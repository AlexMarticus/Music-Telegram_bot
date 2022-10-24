from aiogram.dispatcher.filters.state import StatesGroup, State


class DelTrack(StatesGroup):
    name = State()
    confirm = State()
