from aiogram import types
from emoji.core import emojize

from data.config import ADMINS
from keyboards.default.start import admin_start_menu, start_menu
from loader import dp


@dp.message_handler(commands=['admin'])
async def cancel(message: types.Message):
    if message.from_user.id in ADMINS:
        await message.answer('Доброго времени суток. Поработаем?', reply_markup=admin_start_menu)


# отлов нажатия на кнопку в основном меню
@dp.message_handler(text=emojize(string=":point_left: Вернуться в основное меню", language='alias'))
async def add_(message: types.Message):
    await message.answer(emojize(""":waving_hand: Добро пожаловать в бот!
Нажмите /admin для входа в меню админа"""), reply_markup=start_menu)
