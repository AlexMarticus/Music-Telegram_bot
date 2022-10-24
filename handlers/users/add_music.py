from aiogram import types
from aiogram.dispatcher import FSMContext
from emoji.core import emojize

from data.config import ADMINS
from handlers.users.main_menu import delete_message
from keyboards.default.start import start_menu
from keyboards.inline.music_genres_menu import genres_keyboard
from loader import dp
from states.add_music import AddMusic
from utils.db_func import name_of_genre, add_music, get_user_id_from_tg_id


@dp.message_handler(commands=['cancel'], state=AddMusic)
async def cancel(message: types.Message, state: FSMContext):
    await message.answer('Вы отменили добавление песни.', reply_markup=start_menu)
    await state.reset_state(with_data=False)


# отлов нажатия на кнопку в основном меню
@dp.message_handler(text=emojize(string=":heavy_plus_sign: Добавить музыку", language='alias'))
async def add_(message: types.Message):
    msg = ":pencil: ***Введите название песни и автора через двойной пробел или нажмите /cancel для отмены***"
    msg = emojize(string=msg, language='alias')
    await message.answer(msg, parse_mode=types.ParseMode.MARKDOWN)
    await AddMusic.name.set()


# забираем название трека + state на автора
@dp.message_handler(state=AddMusic.name)
async def am_name(message: types.Message, state: FSMContext):
    try:
        name, author = message.text.split('  ')
        msg = ":pencil: ***Выберите жанр песни или нажмите /cancel для отмены***"
        msg = emojize(string=msg, language='alias')
        markup = await genres_keyboard(search_music=True, author=author, name=name)
        await state.reset_state(with_data=False)
        await message.answer(msg, parse_mode=types.ParseMode.MARKDOWN, reply_markup=markup)
    except ValueError:
        await message.answer('Неверный формат ввода. Попробуйте ещё раз или нажмите /cancel для отмены')
        await AddMusic.name.set()


# забираем жанр трека
async def am_genre(call: types.CallbackQuery, state: FSMContext, genre_id, author_tr, name_track, **kwargs):
    await state.update_data(genre_id=genre_id, author=author_tr, name=name_track)
    msg = ":pencil: ***Отправьте файл песни или нажмите /cancel для отмены***"
    msg = emojize(string=msg, language='alias')
    await call.message.edit_text(msg, parse_mode=types.ParseMode.MARKDOWN)
    await AddMusic.file.set()


# забираем файл трека
@dp.message_handler(content_types=['audio'], state=AddMusic.file)
async def am_file(message: types.Message, state: FSMContext):
    cc = types.InlineKeyboardMarkup(
        inline_keyboard=[
            [types.InlineKeyboardButton(text='Всё верно', callback_data='am_r_yes')],
            [types.InlineKeyboardButton(text='Ввести заново', callback_data='am_r_change')]
        ]
    )
    data = await state.get_data()
    await message.answer(text=f"""Проверьте данные:
Название: {data.get('name')}
Автор: {data.get('author')}
Жанр: {await name_of_genre(data.get('genre_id'))}

Всё верно? Нажмите /cancel для отмены.""", reply_markup=cc)
    await state.update_data(file_id=message.audio.file_id, file_unique_id=message.audio.file_unique_id)
    await AddMusic.confirm.set()


@dp.callback_query_handler(text='am_r_change', state=AddMusic.confirm)
async def am_change(call: types.CallbackQuery):
    await call.message.edit_reply_markup()
    await call.message.edit_text('Введите заново навазние песни или нажмите /cancel для отмены.')
    await AddMusic.name.set()


@dp.callback_query_handler(text='am_r_yes', state=AddMusic.confirm)
async def am_yes(call: types.CallbackQuery, state: FSMContext):
    await call.message.edit_reply_markup()
    data = await state.get_data()
    if call.from_user.id in ADMINS:
        await add_music(name=data.get('name'), author=data.get('author'), genre_id=data.get('genre_id'),
                        creator_id=await get_user_id_from_tg_id(call.from_user.id), file_id=data.get('file_id'),
                        file_unique_id=data.get('file_unique_id'), status=True)
        await call.message.answer('Музыка добавлена', reply_markup=start_menu)
    else:
        await add_music(name=data.get('name'), author=data.get('author'), genre_id=data.get('genre_id'),
                        creator_id=await get_user_id_from_tg_id(call.from_user.id), file_id=data.get('file_id'),
                        file_unique_id=data.get('file_unique_id'))
        await call.message.answer('Музыка отправлена на модерацию', reply_markup=start_menu)
    await delete_message(call.message)
    await state.reset_state()
