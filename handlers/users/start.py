from aiogram import types
from aiogram.dispatcher.filters.builtin import CommandStart

from keyboards.default.start import start_menu, admin_start_menu
from loader import dp
from data.config import ADMINS
from emoji.core import emojize

from utils.db_func import check_is_new_user, create_user


@dp.message_handler(CommandStart())
async def bot_start(message: types.Message):
    is_new = await check_is_new_user(message.from_user.id)
    if is_new == 'new':
        await create_user(message.from_user.id)
    if message.from_user.id in ADMINS:
        await message.answer(emojize(""":waving_hand: Добро пожаловать в бот!
Нажмите /admin для входа в меню админа"""), reply_markup=start_menu)
    else:
        await message.answer(emojize(""":waving_hand: Добро пожаловать в бот!"""), reply_markup=start_menu)
