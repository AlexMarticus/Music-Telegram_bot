from aiogram import types
from aiogram.dispatcher import FSMContext
from emoji.core import emojize

from keyboards.default.start import start_menu
from keyboards.inline.music_genres_menu import delete_track_from_playlist, add_track
from states.find_music import FindMusic

from loader import dp
from utils.db_func import get_all_tracks, check_is_track_added, name_of_genre, get_user_id_from_tg_id


@dp.message_handler(commands=['cancel'], state=FindMusic)
async def cancel(message: types.Message, state: FSMContext):
    await message.answer('Вы отменили поиск песни.', reply_markup=start_menu)
    await state.reset_state(with_data=False)


# отлов нажатия на кнопку в основном меню
@dp.callback_query_handler(text="find_for_author")
async def find_(call: types.CallbackQuery):
    msg = ":pencil: ***Введите исполнителя песни или нажмите /cancel для отмены***"
    msg = emojize(string=msg, language='alias')
    await call.message.edit_text(msg, parse_mode=types.ParseMode.MARKDOWN)
    await FindMusic.author.set()


@dp.message_handler(state=FindMusic.author)
async def fm_author(message: types.Message, state: FSMContext):
    name = message.text.lower()
    lvl = 13
    await state.reset_state()
    all_tracks = await get_all_tracks()
    flag = False
    for track in all_tracks:
        if name in list(map(lambda x: x.lower(), track[2].split())) or ''.join(name.split()) in \
                list(map(lambda x: x.lower(), track[2].split())):
            message_text = f"***Название:*** `{track[1]}`\n" \
                           f"***Исполнитель:*** `{track[2]}`\n" \
                           f"***Жанр:*** `{await name_of_genre(track[3])}`\n" \
                           f"***Музыка без интернета:*** https://t.me/pmusicamusik"
            if await check_is_track_added(music_id=track[0],
                                          user_id=await get_user_id_from_tg_id(message.from_user.id)):
                await message.answer_audio(audio=track[4],
                                           reply_markup=(await delete_track_from_playlist(music_id=track[0],
                                                                                          lvl=lvl)),
                                           caption=message_text,
                                           parse_mode=types.ParseMode.MARKDOWN)
            else:
                await message.answer_audio(audio=track[4],
                                           reply_markup=(await add_track(track[0])),
                                           caption=message_text,
                                           parse_mode=types.ParseMode.MARKDOWN)
            flag = True
    if not flag:
        await message.answer('Ничего не найдено. Попробуйте ещё раз или нажмите /cancel для отмены',
                             reply_markup=start_menu)
        await FindMusic.author.set()
    else:
        await message.answer('Это всё, что мы нашли по Вашему запросу', reply_markup=start_menu)
