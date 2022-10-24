from aiogram import types
from aiogram.dispatcher import FSMContext
from emoji.core import emojize

from data.config import ADMINS
from handlers.users.main_menu import delete_message
from keyboards.default.start import start_menu, admin_start_menu
from loader import dp
from states.del_track import DelTrack
from utils.db_func import del_track, find_uniq_file_id


@dp.message_handler(commands=['cancel'], state=DelTrack)
async def cancel(message: types.Message, state: FSMContext):
    await message.answer('Вы отменили удаление песни.', reply_markup=start_menu)
    await state.reset_state(with_data=False)


# отлов нажатия на кнопку в основном меню
@dp.message_handler(text=emojize(string=":heavy_minus_sign: Удалить музыку", language='alias'))
async def genres_(message: types.Message):
    if message.from_user.id in ADMINS:
        await message.answer('Перешлите сообщение с песней, которую хотите удалить, или нажмите /cancel для отмены')
        await DelTrack.name.set()


@dp.message_handler(state=DelTrack.name, content_types=['audio'])
async def task_answer_text(message: types.Message, state: FSMContext):
    if message.from_user.id in ADMINS:
        cc = types.InlineKeyboardMarkup(
            inline_keyboard=[
                [types.InlineKeyboardButton(text='Всё верно', callback_data='tat_r_yes')],
                [types.InlineKeyboardButton(text='Ввести заново', callback_data='tat_r_change')]
            ]
        )
        await message.answer(text='Уверены, что хотите удалить эту песню?', reply_markup=cc)
        await state.update_data(file_unique_id=message.audio.file_unique_id)
        await DelTrack.confirm.set()


@dp.callback_query_handler(text='tat_r_change', state=DelTrack.confirm)
async def am_change(call: types.CallbackQuery):
    if call.from_user.id in ADMINS:
        await call.message.edit_reply_markup()
        await call.message.edit_text('Снова перешлите сообщение с песней, которую хотите удалить, '
                                     'или нажмите /cancel для отмены.')
        await DelTrack.name.set()


@dp.callback_query_handler(text='tat_r_yes', state=DelTrack.confirm)
async def am_yes(call: types.CallbackQuery, state: FSMContext):
    if call.from_user.id in ADMINS:
        await call.message.edit_reply_markup()
        data = await state.get_data()
        if await find_uniq_file_id(data.get('file_unique_id')) != 0:
            await del_track(file_unique_id=data.get('file_unique_id'))
            await delete_message(call.message)
            await call.message.answer('Трек удалён', reply_markup=start_menu)
            await state.reset_state(with_data=False)
        else:
            await delete_message(call.message)
            await call.message.answer('Этот трек нельзя удалить. Он был добавлен ещё когда такой функции не было)',
                                      reply_markup=start_menu)
            await state.reset_state(with_data=False)
