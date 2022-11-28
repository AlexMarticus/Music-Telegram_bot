import aiogram.utils.exceptions
from emoji.core import emojize

from handlers.users.main_menu import delete_message
from keyboards.default.start import start_menu
from keyboards.inline.playlist import all_tracks_profile, menu_
from utils.db_func import name_of_genre, get_music_info, get_user_id_from_tg_id, get_all_user_tracks, \
    add_message_id_for_deletting, delete_mes_id_from_del_mes, return_all_ids_mes_for_delete

from aiogram import types
from keyboards.inline.music_genres_menu import delete_track_from_playlist
from loader import dp, bot


# отлов нажатия на кнопку в основном меню
@dp.message_handler(text=emojize(string=":musical_note: Мой плейлист", language='alias'))
async def genres_(message: types.Message):
    # удаление старых отправленных треков
    mes_del = await message.answer('📤 Загружаю')
    user_id = await get_user_id_from_tg_id(message.from_user.id)
    mess_id = await return_all_ids_mes_for_delete(user_id=user_id)
    for i in mess_id:
        try:
            await bot.delete_message(message_id=i[0], chat_id=message.chat.id)
        except aiogram.utils.exceptions.MessageToDeleteNotFound:
            pass
        except aiogram.utils.exceptions.MessageCantBeDeleted:
            pass
    await delete_mes_id_from_del_mes(user_id=user_id)
    await delete_message(mes_del)
    all_tracks = await get_all_user_tracks(await get_user_id_from_tg_id(message.from_user.id))
    all_tracks = all_tracks[::-1]
    reference_point_tracks = 0
    if reference_point_tracks + 10 >= len(all_tracks):
        before = len(all_tracks)
    else:
        before = reference_point_tracks + 10
    for track_ind in range(reference_point_tracks, before):
        track_id = all_tracks[track_ind][0]
        all_info = await get_music_info(track_id)
        message_text = f"""***Название:*** `{all_info[1].replace('`', "'")}`
***Исполнитель:*** `{all_info[2].replace('`', "'")}`
***Жанр:*** `{(await name_of_genre(all_info[3])).replace('`', "'")}`
***Музыка без интернета:*** https://t.me/pmusicamusik"""
        
        mes_id = await message.answer_audio(audio=all_info[4],
                                            reply_markup=(
                                                await delete_track_from_playlist(music_id=all_info[0], lvl=12)),
                                            caption=message_text,
                                            parse_mode=types.ParseMode.MARKDOWN)
        # добавление message id в БД для удаления сообщений в будущем
        await add_message_id_for_deletting(message_id=mes_id.message_id,
                                           user_id=await get_user_id_from_tg_id(message.from_user.id))
    if reference_point_tracks + 10 < len(all_tracks):
        await message.answer(text='Для просмотра других треков нажмите "Ещё треки"',
                             reply_markup=(await all_tracks_profile(reference_point_tracks=reference_point_tracks)))
    else:
        await message.answer(text=emojize(string=":white_exclamation_mark: Песен больше нет!",
                                          language='alias'),
                             reply_markup=start_menu)


# если выбрали все треки за раз
async def all_tracks_of_profile(call: types.CallbackQuery, reference_point_tracks=10, flag=False, **kwargs):
    await delete_message(call.message)
    all_tracks = await get_all_user_tracks(await get_user_id_from_tg_id(call.from_user.id))
    all_tracks = all_tracks[::-1]
    if reference_point_tracks + 10 >= len(all_tracks):
        before = len(all_tracks)
    else:
        before = reference_point_tracks + 10
    for track_ind in range(reference_point_tracks, before):
        track_id = all_tracks[track_ind][0]
        all_info = await get_music_info(track_id)
        message_text = f"""***Название:*** `{all_info[1].replace('`', "'")}`
***Исполнитель:*** `{all_info[2].replace('`', "'")}`
***Жанр:*** `{(await name_of_genre(all_info[3])).replace('`', "'")}`
***Музыка без интернета:*** https://t.me/pmusicamusik"""
        mes_id = await call.message.answer_audio(audio=all_info[4],
                                                 reply_markup=(
                                                     await delete_track_from_playlist(music_id=all_info[0], lvl=12)),
                                                 caption=message_text,
                                                 parse_mode=types.ParseMode.MARKDOWN)
        # добавление message id в БД для удаления сообщений в будущем
        await add_message_id_for_deletting(message_id=mes_id.message_id,
                                           user_id=await get_user_id_from_tg_id(call.from_user.id))
    if reference_point_tracks + 10 < len(all_tracks):
        await call.message.answer(text='Для просмотра других треков нажмите "Ещё треки"',
                                  reply_markup=(
                                      await all_tracks_profile(reference_point_tracks=reference_point_tracks + 10)))
    else:
        await call.message.answer(text=emojize(string=":white_exclamation_mark: Песен больше нет!",
                                               language='alias'),
                                  reply_markup=start_menu)


@dp.callback_query_handler(menu_.filter())
async def navigate(call: types.CallbackQuery, callback_data: dict, state=None):
    current_level = callback_data.get("level")
    reference_point_tracks = int(callback_data.get("reference_point_tracks"))
    levels = {
        "0": all_tracks_of_profile,
    }
    current_level_function = levels[current_level]
    await current_level_function(
        call,
        lvl=current_level,
        state=state,
        reference_point_tracks=reference_point_tracks,
    )
