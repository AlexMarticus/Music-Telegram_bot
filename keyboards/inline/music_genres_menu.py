from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton
from aiogram.utils.callback_data import CallbackData
from emoji.core import emojize
from utils.db_func import all_genres, get_all_tracks_of_genre

menu_cd = CallbackData('show_menu', 'level', 'genre_id', 'music_id', 'reference_point_tracks', 'flag')


def make_callback_data(level, genre_id="0", music_id='0', reference_point_tracks='0', flag=False):
    return menu_cd.new(level=level, genre_id=genre_id, music_id=music_id, reference_point_tracks=reference_point_tracks,
                       flag=flag)


# клавиатура с жанрами
async def genres_keyboard(search_music=False, music_id=None):
    if not search_music:
        CURRENT_LEVEL = 0
        markup = InlineKeyboardMarkup(row_width=1)
        genres = await all_genres()
        for genre in genres:
            button_text = f"{genre[1]}"
            callback_data = make_callback_data(level=CURRENT_LEVEL + 1, genre_id=genre[0], flag=False)
            markup.insert(
                InlineKeyboardButton(text=button_text, callback_data=callback_data)
            )
        markup.row(
            InlineKeyboardButton(
                text="⬅ Назад",
                callback_data=make_callback_data(level=-1))
        )
    else:
        markup = InlineKeyboardMarkup(row_width=1)
        genres = await all_genres()
        for genre in genres:
            button_text = f"{genre[1]}"
            callback_data = make_callback_data(level=50, genre_id=genre[0], music_id=music_id)
            markup.insert(
                InlineKeyboardButton(text=button_text, callback_data=callback_data)
            )
    return markup


# клавиатура с выбором: показать все треки или по одному
async def all_tracks_or_one(genre_id):
    CURRENT_LEVEL = 1
    markup = InlineKeyboardMarkup(row_width=2)
    callback_data = make_callback_data(level='11', genre_id=genre_id)
    markup.insert(
        InlineKeyboardButton(text='Слушать треки', callback_data=callback_data),
    )
    callback_data = make_callback_data(level='21', genre_id=genre_id)
    markup.insert(
        InlineKeyboardButton(text='Добавить треки', callback_data=callback_data),
    )
    markup.row(
        InlineKeyboardButton(
            text="Назад",
            callback_data=make_callback_data(level=CURRENT_LEVEL - 1,))
    )
    return markup


# клавиатура с добавлением трека в плейлист (мод: все треки)
async def add_track(music_id):
    markup = InlineKeyboardMarkup(row_width=1)
    callback_data = make_callback_data(level=12, music_id=music_id)
    markup.insert(
        InlineKeyboardButton(text=emojize(string=":heavy_plus_sign: Добавить в плейлист", language='alias'),
                             callback_data=callback_data),
    )
    return markup


# клавиатура со всеми треками(мод: все треки)
async def all_tracks_mode(genre_id, reference_point_tracks):
    # CURRENT_LEVEL = 11
    markup = InlineKeyboardMarkup(row_width=1)
    callback_data = make_callback_data(level='11', genre_id=genre_id,
                                       reference_point_tracks=reference_point_tracks + 10, flag=True)
    markup.insert(
        InlineKeyboardButton(text='Ещё треки', callback_data=callback_data),
    )
    markup.row(
        InlineKeyboardButton(
            text="К жанрам",
            callback_data=make_callback_data(level=0))
    )
    return markup


# клавиатура со всеми треками(мод: один трек)
async def one_track_mode(genre_id, reference_point_tracks):
    # CURRENT_LEVEL = 21
    markup = InlineKeyboardMarkup(row_width=2)
    all_tracks = await get_all_tracks_of_genre(genre_id)
    all_tracks = all_tracks[::-1]
    if reference_point_tracks + 10 >= len(all_tracks):
        before = len(all_tracks)
    else:
        before = reference_point_tracks + 10
    for track in range(reference_point_tracks, before):
        if all_tracks[track][8] is not None:
            button_text = f"{all_tracks[track][1]} — {all_tracks[track][2]} ({int(all_tracks[track][8]) // 60}:" \
                          f"{int(all_tracks[track][8] % 60)})"
        else:
            button_text = f"{all_tracks[track][1]} — {all_tracks[track][2]}"
        callback_data = make_callback_data(level=22, music_id=all_tracks[track][0], genre_id=genre_id,
                                           reference_point_tracks=reference_point_tracks)
        markup.row(
            InlineKeyboardButton(text=button_text, callback_data=callback_data)
        )
    if reference_point_tracks + 10 < len(all_tracks) and reference_point_tracks < 10:
        markup.row(
            InlineKeyboardButton(
                text="Ещё треки",
                callback_data=make_callback_data(level=21, genre_id=genre_id,
                                                 reference_point_tracks=reference_point_tracks + 10))
        )
        markup.insert(
            InlineKeyboardButton(
                text="К жанрам",
                callback_data=make_callback_data(level=0))
        )
    elif reference_point_tracks >= 10 and reference_point_tracks + 10 < len(all_tracks):
        markup.row(
            InlineKeyboardButton(
                text="Ещё треки",
                callback_data=make_callback_data(level=21, genre_id=genre_id,
                                                 reference_point_tracks=reference_point_tracks + 10))
        )
        markup.row(
            InlineKeyboardButton(
                text="Назад",
                callback_data=make_callback_data(level=21, genre_id=genre_id,
                                                 reference_point_tracks=reference_point_tracks - 10))
        )
        markup.insert(
            InlineKeyboardButton(
                text="К жанрам",
                callback_data=make_callback_data(level=0))
        )
    elif reference_point_tracks >= 10:
        markup.row(
            InlineKeyboardButton(
                text="Назад",
                callback_data=make_callback_data(level=21, genre_id=genre_id,
                                                 reference_point_tracks=reference_point_tracks - 10))
        )
        markup.insert(
            InlineKeyboardButton(
                text="К жанрам",
                callback_data=make_callback_data(level=0))
        )
    else:
        markup.row(
            InlineKeyboardButton(
                text="К жанрам",
                callback_data=make_callback_data(level=0))
        )
    return markup


# клавиатура с инф-ой об 1ом треке(мод: один трек)
async def one_track_in_one_mode(genre_id, reference_point_tracks, music_id):
    # CURRENT_LEVEL = 22
    markup = InlineKeyboardMarkup(inline_keyboard=[
        [
            InlineKeyboardButton(
                text=emojize(string=":heavy_plus_sign: Добавить в плейлист", language='alias'),
                callback_data=make_callback_data(level=23, music_id=music_id, genre_id=genre_id))
        ],
        [
            InlineKeyboardButton(
                text="Назад",
                callback_data=make_callback_data(level=21, genre_id=genre_id,
                                                 reference_point_tracks=reference_point_tracks))
        ]
    ])
    return markup


# удалить трек из плейлиста
async def delete_track_from_playlist(music_id, lvl, genre_id=None, reference_point_tracks=None):
    if int(lvl) == 23 or int(lvl) == 22:
        markup = InlineKeyboardMarkup(inline_keyboard=[
            [
                InlineKeyboardButton(
                    text=emojize(string=":heavy_minus_sign: Удалить из плейлиста", language='alias'),
                    callback_data=make_callback_data(level=24, music_id=music_id, genre_id=genre_id))
            ],
            [
                InlineKeyboardButton(
                    text="Назад",
                    callback_data=make_callback_data(level=21, genre_id=genre_id,
                                                     reference_point_tracks=reference_point_tracks))
            ]
        ])
        return markup
    elif int(lvl) == 12 or int(lvl) == 11:
        markup = InlineKeyboardMarkup(row_width=1)
        callback_data = make_callback_data(level=13, music_id=music_id)
        markup.insert(
            InlineKeyboardButton(text=emojize(string=":heavy_minus_sign: Удалить из плейлиста", language='alias'),
                                 callback_data=callback_data),
        )
        return markup
