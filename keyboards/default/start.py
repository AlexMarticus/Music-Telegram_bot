from aiogram.types import ReplyKeyboardMarkup, KeyboardButton
from emoji.core import emojize

start_menu = ReplyKeyboardMarkup(
    keyboard=[
        [
            KeyboardButton(text=emojize(string=":magnifying_glass_tilted_left: Поиск музыки",
                                        language='alias')),
        ],
        [
            KeyboardButton(text=emojize(string=":heavy_plus_sign: Добавить музыку", language='alias'))
        ],
        [
            KeyboardButton(text=emojize(string=":musical_note: Мой плейлист", language='alias'))
        ],
    ],
    resize_keyboard=True,
    # one_time_keyboard=True
)

admin_start_menu = ReplyKeyboardMarkup(
    keyboard=[

        [
            KeyboardButton(text=emojize(string=":heavy_minus_sign: Удалить музыку", language='alias'))
        ],
        [
            KeyboardButton(text=emojize(string=":file_folder: Категории", language='alias')),
        ],
        [
            KeyboardButton(text=emojize(string=":bust_in_silhouette: Модерация", language='alias')),
        ],
        [
            KeyboardButton(text=emojize(string=":point_left: Вернуться в основное меню", language='alias')),
        ]
    ],
    resize_keyboard=True,
    # one_time_keyboard=True
)
