from aiogram.types import InlineKeyboardButton, InlineKeyboardMarkup
from emoji.core import emojize

types_search = InlineKeyboardMarkup(inline_keyboard=[
    [
        InlineKeyboardButton(text=emojize(string=":magnifying_glass_tilted_left: Поиск музыки по жанру",
                                          language='alias'), callback_data="find_for_genre"),
    ],
    [
        InlineKeyboardButton(text=emojize(string=":magnifying_glass_tilted_left: Поиск музыки по названию",
                                          language='alias'), callback_data="find_for_name"),
    ],
    [
        InlineKeyboardButton(text=emojize(string=":magnifying_glass_tilted_left: Поиск музыки по исполнителю",
                                          language='alias'), callback_data="find_for_author"),
    ],
[
        InlineKeyboardButton(text=emojize(string="⬅ Назад",
                                          language='alias'), callback_data="main_menu"),
    ],
])
