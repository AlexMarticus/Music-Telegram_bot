from aiogram import types
from aiogram.dispatcher.filters.builtin import CommandHelp
from loader import dp


@dp.message_handler(CommandHelp())
async def bot_help(message: types.Message):
    await message.answer('Что умеет этот бот:\n'
                         'Бот поможет создать свой плейлист,\n'
                         'Доступен Кеш (оффлайн прослушавание)\n'
                         'Искать музыку по названию, исполнителю или жанру,\n'
                         'Добавлять свои любимые треки\n\n'
                         'Разработчик бота: @seerb')
