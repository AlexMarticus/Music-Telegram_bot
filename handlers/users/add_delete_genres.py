from aiogram import types
from aiogram.dispatcher import FSMContext
from emoji.core import emojize

from data.config import ADMINS
from handlers.users.main_menu import delete_message
from keyboards.default.start import start_menu, admin_start_menu
from loader import dp
from states.add_del_genre_state import AddGenre, DelGenre
from utils.db_func import add_genre, del_genre


@dp.message_handler(commands=['cancel'], state=AddGenre)
async def cancel(message: types.Message, state: FSMContext):
    await message.answer('Вы отменили добавление жанра.', reply_markup=start_menu)
    await state.reset_state(with_data=False)


@dp.message_handler(commands=['cancel'], state=DelGenre)
async def cancel(message: types.Message, state: FSMContext):
    await message.answer('Вы отменили удаление жанра.', reply_markup=start_menu)
    await state.reset_state(with_data=False)


# отлов нажатия на кнопку в основном меню
@dp.message_handler(text=emojize(string=":file_folder: Категории", language='alias'))
async def genres_(message: types.Message):
    if message.from_user.id in ADMINS:
        cc = types.InlineKeyboardMarkup(
            inline_keyboard=[
                [types.InlineKeyboardButton(text='Добавить', callback_data='add_gen')],
                [types.InlineKeyboardButton(text='Удалить', callback_data='del_gen')]
            ]
        )
        await message.answer('Казнить нельзя помиловать', reply_markup=cc)


@dp.callback_query_handler(text='add_gen')
async def add_gen(call: types.CallbackQuery):
    if call.from_user.id in ADMINS:
        await call.message.edit_text('Введите название жанра, чтобы добавить его, или нажмите /cancel для отмены')
        await AddGenre.name.set()


@dp.callback_query_handler(text='del_gen')
async def del_gen(call: types.CallbackQuery):
    if call.from_user.id in ADMINS:
        await call.message.edit_text('Введите название жанра, чтобы удалить его, или нажмите /cancel для отмены')
        await DelGenre.name.set()


@dp.message_handler(state=AddGenre.name)
async def add_gen_name(message: types.Message, state: FSMContext):
    if message.from_user.id in ADMINS:
        cc = types.InlineKeyboardMarkup(
            inline_keyboard=[
                [types.InlineKeyboardButton(text='Всё верно', callback_data='agn_r_yes')],
                [types.InlineKeyboardButton(text='Ввести заново', callback_data='agn_r_change')]
            ]
        )
        name = message.text
        await state.update_data(name=name)
        await message.answer(f'Вы уверены, что хотите добавить жанр {name}?', reply_markup=cc)
        await AddGenre.confirm.set()


@dp.message_handler(state=DelGenre.name)
async def del_gen_name(message: types.Message, state: FSMContext):
    if message.from_user.id in ADMINS:
        cc = types.InlineKeyboardMarkup(
            inline_keyboard=[
                [types.InlineKeyboardButton(text='Всё верно', callback_data='dgn_r_yes')],
                [types.InlineKeyboardButton(text='Ввести заново', callback_data='dgn_r_change')]
            ]
        )
        name = message.text
        await state.update_data(name=name)
        await message.answer(f'Вы уверены, что хотите удалить жанр {name}?', reply_markup=cc)
        await DelGenre.confirm.set()


@dp.callback_query_handler(text='agn_r_change', state=AddGenre.confirm)
async def agn_change(call: types.CallbackQuery):
    await call.message.edit_reply_markup()
    await call.message.edit_text('Введите заново название жанра, чтобы добавить его, или нажмите /cancel для отмены.')
    await AddGenre.name.set()


@dp.callback_query_handler(text='agn_r_yes', state=AddGenre.confirm)
async def agn_yes(call: types.CallbackQuery, state: FSMContext):
    await call.message.edit_reply_markup()
    data = await state.get_data()
    await add_genre(name=data.get('name'))
    await delete_message(call.message)
    await call.message.answer('Добавлен.', reply_markup=start_menu)
    await state.reset_state(with_data=False)


@dp.callback_query_handler(text='dgn_r_change', state=DelGenre.confirm)
async def agn_change(call: types.CallbackQuery):
    await call.message.edit_reply_markup()
    await call.message.edit_text('Введите заново название жанра, чтобы добавить его, или нажмите /cancel для отмены.')
    await AddGenre.name.set()


@dp.callback_query_handler(text='dgn_r_yes', state=DelGenre.confirm)
async def agn_yes(call: types.CallbackQuery, state: FSMContext):
    await call.message.edit_reply_markup()
    data = await state.get_data()
    await del_genre(name=data.get('name'))
    await delete_message(call.message)
    await call.message.answer('Удалён.', reply_markup=start_menu)
    await state.reset_state(with_data=False)
