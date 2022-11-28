from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.utils.callback_data import CallbackData
from emoji.core import emojize
from utils.db_func import all_genres, get_all_tracks_of_genre

menu_ = CallbackData('show_tr_profile', 'level', 'reference_point_tracks', 'flag')


def make_callback_data(level, reference_point_tracks='0', flag=False):
    return menu_.new(level, reference_point_tracks=reference_point_tracks, flag=flag)


# клавиатура со всеми треками(мод: все треки)
async def all_tracks_profile(reference_point_tracks):
    markup = InlineKeyboardMarkup(row_width=1)
    callback_data = make_callback_data(reference_point_tracks=reference_point_tracks + 10, level=0, flag=True)
    markup.insert(
        InlineKeyboardButton(text='Ещё треки', callback_data=callback_data),
    )
    markup.row(
        InlineKeyboardButton(
            text="В главное меню",
            callback_data='main_menu')
    )
    return markup
