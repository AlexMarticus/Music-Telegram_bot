from aiogram import types
from emoji.core import emojize

from keyboards.inline.type_of_find_music_kb import types_search
from loader import dp


# отлов нажатия на кнопку в основном меню
@dp.message_handler(text=emojize(string=":magnifying_glass_tilted_left: Поиск музыки", language='alias'))
async def genres_find(message: types.Message):
    await message.answer('Выберите поиск', reply_markup=types_search)
