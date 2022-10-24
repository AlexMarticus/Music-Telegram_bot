from aiogram.dispatcher.filters.state import StatesGroup, State


class AddGenre(StatesGroup):
    name = State()
    confirm = State()


class DelGenre(StatesGroup):
    name = State()
    confirm = State()
