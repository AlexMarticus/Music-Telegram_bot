from aiogram.dispatcher.filters.state import StatesGroup, State


class FindMusic(StatesGroup):
    name = State()
