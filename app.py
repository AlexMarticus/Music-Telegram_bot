from aiogram import executor
from loader import dp, bot, storage
import middlewares, handlers
from utils.notify_admins import on_startup_notify
from utils.set_bot_commands import set_default_commands
# , parse_mode=types.ParseMode.MARKDOWN

async def on_startup(dispatcher):
    # Устанавливаем дефолтные команды
    await set_default_commands(dispatcher)
    # Уведомляет про запуск
    await on_startup_notify(dispatcher)


async def on_shutdown(dispatcher):
    await storage.close()
    await bot.close()


if __name__ == '__main__':
    executor.start_polling(dp, on_startup=on_startup, on_shutdown=on_shutdown)
