from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.utils.callback_data import CallbackData
from emoji.core import emojize

menu_mod = CallbackData('show_mod', 'level', 'music_id')


def make_callback_data(level, music_id='0'):
    return menu_mod.new(level=level, music_id=music_id)


async def mod_tr(music_id):
    markup = InlineKeyboardMarkup(row_width=2)
    callback_data = make_callback_data(level=1, music_id=music_id)
    markup.insert(
        InlineKeyboardButton(text=emojize(string=":heavy_plus_sign: Одобрить", language='alias'),
                             callback_data=callback_data),
    )
    callback_data = make_callback_data(level=2, music_id=music_id)
    markup.insert(
        InlineKeyboardButton(text=emojize(string=":heavy_minus_sign: Не одобрить", language='alias'),
                             callback_data=callback_data),
    )
    return markup
