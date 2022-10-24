from aiogram import types
from emoji.core import emojize

from data.config import ADMINS
from handlers.users.main_menu import delete_message
from keyboards.default.start import admin_start_menu
from keyboards.inline.moderation_kb import menu_mod, mod_tr
from loader import dp
from utils.db_func import tracks_on_moderation, get_music_info, name_of_genre, made_status_true_music, del_track_id


# отлов нажатия на кнопку в основном меню
@dp.message_handler(text=emojize(string=":bust_in_silhouette: Модерация", language='alias'))
async def add_(message: types.Message):
    if message.from_user.id in ADMINS:
        all_tr = await tracks_on_moderation()
        for tr in all_tr:
            tr = tr[0]
            all_info = await get_music_info(tr)
            message_text = f"***Название:*** `{all_info[1]}`\n" \
                           f"***Исполнитель:*** `{all_info[2]}`\n" \
                           f"***Жанр:*** `{await name_of_genre(all_info[3])}`\n" \
                           f"***Музыка без интернета:*** https://t.me/pmusicamusik"
            await message.answer_audio(audio=all_info[4],
                                       reply_markup=(await mod_tr(music_id=all_info[0])),
                                       caption=message_text,
                                       parse_mode=types.ParseMode.MARKDOWN)
        if len(all_tr) == 0:
            await message.answer('Ничего пока нет', reply_markup=admin_start_menu)


async def ne_odobreno(call: types.CallbackQuery, music_id, **kwargs):
    await delete_message(call.message)
    await del_track_id(music_id)


async def odobreno(call: types.CallbackQuery, music_id, **kwargs):
    await delete_message(call.message)
    await made_status_true_music(music_id)


@dp.callback_query_handler(menu_mod.filter())
async def navigate(call: types.CallbackQuery, callback_data: dict, state=None):
    current_level = callback_data.get("level")
    music_id = int(callback_data.get("music_id"))
    levels = {
        "1": odobreno,
        "2": ne_odobreno
    }
    current_level_function = levels[current_level]
    await current_level_function(
        call,
        lvl=current_level,
        state=state,
        music_id=music_id,
    )
