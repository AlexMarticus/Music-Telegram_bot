from aiogram.dispatcher.filters.state import StatesGroup, State


class AddMusic(StatesGroup):
    name = State()
    author = State()
    genre = State()
    file = State()
    confirm = State()
