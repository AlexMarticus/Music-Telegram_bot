from typing import Union

import aiogram.utils.exceptions
from aiogram.types import CallbackQuery, Message
from emoji.core import emojize

from handlers.users.add_music import am_genre
from handlers.users.main_menu import delete_message
from keyboards.default.start import start_menu
from utils.db_func import get_all_tracks_of_genre, name_of_genre, get_music_info, add_music_to_playlist, \
    get_user_id_from_tg_id, delete_music_from_playlist, check_is_track_added

from aiogram import types
from keyboards.inline.music_genres_menu import menu_cd, genres_keyboard, all_tracks_or_one, add_track, all_tracks_mode, \
    one_track_mode, one_track_in_one_mode, delete_track_from_playlist
from loader import dp


# отлов нажатия на кнопку в основном меню
@dp.message_handler(text=emojize(string=":magnifying_glass_tilted_left: Поиск музыки по жанрам", language='alias'))
async def genres_(message: types.Message):
    await list_genres(message)


# возвращает список жанров
async def list_genres(message: Union[CallbackQuery, Message], **kwargs):
    markup = await genres_keyboard()
    if isinstance(message, Message):
        await message.answer(text='Выберите нужный Вам жанр:', reply_markup=markup)
    elif isinstance(message, CallbackQuery):
        call = message
        await call.message.edit_text(text='Выберите нужный Вам жанр:', reply_markup=markup)


# кнопки выбора: все треки за раз вывести или по одному
async def all_or_one_track(call: types.CallbackQuery, genre_id, **kwargs):
    markup = await all_tracks_or_one(genre_id)
    await call.message.edit_text('"Слушать треки" позволит Вам увидеть весь плейлист из данного жанра и прослушать его.'
                                 '\n"Добавить треки" позволит удобно переключатся от одного терка к другому '
                                 'и добавлять их к себе в плейлист', reply_markup=markup)


# если выбрали все треки за раз
async def all_tracks_of_genre(call: types.CallbackQuery, genre_id, reference_point_tracks=0, lvl=None, **kwargs):
    await delete_message(call.message)
    all_tracks = await get_all_tracks_of_genre(genre_id)
    all_tracks = all_tracks[::-1]
    if reference_point_tracks + 10 >= len(all_tracks):
        before = len(all_tracks)
    else:
        before = reference_point_tracks + 10
    for track in range(reference_point_tracks, before):
        message_text = f"***Название:*** `{all_tracks[track][1]}`\n" \
                       f"***Исполнитель:*** `{all_tracks[track][2]}`\n" \
                       f"***Жанр:*** `{await name_of_genre(all_tracks[track][3])}`\n" \
                       f"***Музыка без интернета:*** https://t.me/pmusicamusik"
        if await check_is_track_added(music_id=all_tracks[track][0],
                                      user_id=await get_user_id_from_tg_id(call.from_user.id)):
            await call.message.answer_audio(audio=all_tracks[track][4],
                                            reply_markup=
                                            (await delete_track_from_playlist(music_id=all_tracks[track][0], lvl=lvl)),
                                            caption=message_text,
                                            parse_mode=types.ParseMode.MARKDOWN)
        else:
            await call.message.answer_audio(audio=all_tracks[track][4],
                                            reply_markup=(await add_track(all_tracks[track][0])), caption=message_text,
                                            parse_mode=types.ParseMode.MARKDOWN)
    if reference_point_tracks + 10 < len(all_tracks):
        await call.message.answer(text='Для просмотра других треков нажмите "Ещё треки"',
                                  reply_markup=(await all_tracks_mode(genre_id=genre_id,
                                                                      reference_point_tracks=reference_point_tracks)))
    else:
        await call.message.answer(text=emojize(string=":white_exclamation_mark: Песен больше нет!",
                                               language='alias'),
                                  reply_markup=start_menu)


# если выбрали "по одному"
async def one_track_of_genre(call: types.CallbackQuery, genre_id, reference_point_tracks=0, **kwargs):
    markup = await one_track_mode(genre_id=genre_id, reference_point_tracks=reference_point_tracks)
    all_tracks = await get_all_tracks_of_genre(genre_id)
    try:
        await call.message.edit_text(text=f"Треков - {len(all_tracks)}", reply_markup=markup)
    except aiogram.utils.exceptions.BadRequest:
        await delete_message(call.message)
        await call.message.answer(text=f"Треков - {len(all_tracks)}", reply_markup=markup)


# информация об одном треке
async def info_one_track(call: types.CallbackQuery, music_id, genre_id, reference_point_tracks=0, lvl=None, **kwargs):
    track_info = await get_music_info(music_id)
    text = f"***Название:*** `{track_info[1]}`\n" \
           f"***Исполнитель:*** `{track_info[2]}`\n" \
           f"***Жанр:*** `{await name_of_genre(track_info[3])}`\n" \
           f"***Музыка без интернета:*** https://t.me/pmusicamusik"
    await delete_message(call.message)
    if await check_is_track_added(music_id=music_id, user_id=(await get_user_id_from_tg_id(call.from_user.id))):
        markup = await delete_track_from_playlist(genre_id=genre_id, reference_point_tracks=reference_point_tracks,
                                                  music_id=music_id, lvl=lvl)
    else:
        markup = await one_track_in_one_mode(genre_id=genre_id, reference_point_tracks=reference_point_tracks,
                                             music_id=music_id)
    await call.message.answer_audio(caption=text, audio=track_info[4], reply_markup=markup,
                                    parse_mode=types.ParseMode.MARKDOWN)


# добавление трека в плейлист к пользователю
async def add_to_playlist(call: types.CallbackQuery, lvl, music_id, genre_id=None, reference_point_tracks=None,
                          **kwargs):
    await add_music_to_playlist(user_id=await get_user_id_from_tg_id(call.from_user.id), music_id=music_id)
    markup = await delete_track_from_playlist(music_id=music_id, genre_id=genre_id,
                                              reference_point_tracks=reference_point_tracks, lvl=lvl)
    await call.message.edit_reply_markup(markup)


# удаление трека из плейлиста у пользователя
async def del_from_playlist(call: types.CallbackQuery, lvl, music_id, genre_id=None, reference_point_tracks=None,
                            **kwargs):
    await delete_music_from_playlist(user_id=await get_user_id_from_tg_id(call.from_user.id), music_id=music_id)
    if int(lvl) == 23 or int(lvl) == 24:
        markup = await one_track_in_one_mode(music_id=music_id, genre_id=genre_id,
                                             reference_point_tracks=reference_point_tracks)
        await call.message.edit_reply_markup(markup)
    elif int(lvl) == 12 or int(lvl) == 13:
        markup = await add_track(music_id)
        await call.message.edit_reply_markup(markup)


@dp.callback_query_handler(menu_cd.filter())
async def navigate(call: CallbackQuery, callback_data: dict, state=None):
    current_level = callback_data.get("level")
    genre_id = int(callback_data.get("genre_id"))
    music_id = int(callback_data.get("music_id"))
    reference_point_tracks = int(callback_data.get("reference_point_tracks"))
    author_tr = callback_data.get("author_tr")
    name_track = callback_data.get("name_track")
    levels = {
        "0": list_genres,
        "1": all_or_one_track,
        "11": all_tracks_of_genre,
        '21': one_track_of_genre,
        '22': info_one_track,
        '12': add_to_playlist,
        '23': add_to_playlist,
        '13': del_from_playlist,
        '24': del_from_playlist,
        '50': am_genre
    }
    current_level_function = levels[current_level]
    await current_level_function(
        call,
        lvl=current_level,
        genre_id=genre_id,
        music_id=music_id,
        state=state,
        reference_point_tracks=reference_point_tracks,
        author_tr=author_tr,
        name_track=name_track
    )
