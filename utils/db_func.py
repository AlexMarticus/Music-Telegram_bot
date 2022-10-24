import psycopg
from data.config import PG_USER, DB_NAME, PG_PASS, PG_HOST


async def get_music_info(music_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT * FROM music WHERE id=%s", (music_id,))
            return await acur.fetchone()


async def add_genre(name):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''INSERT INTO genre (name) VALUES (%s)''',
                               (name,))
            await aconn.commit()


async def find_uniq_file_id(un_file_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT count(id) FROM music WHERE (file_unique_id=%s)", (un_file_id,))
            return await  acur.fetchone()


async def del_track(file_unique_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT id FROM music WHERE (file_unique_id=%s)", (file_unique_id,))
            id = (await acur.fetchone())[0]
            await acur.execute('''DELETE FROM user_playlist WHERE (music_id=%s)''', (id,))
            await aconn.commit()
            await acur.execute('''DELETE FROM music WHERE (id=%s)''', (id,))
            await aconn.commit()


async def del_track_id(id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''DELETE FROM music WHERE (id=%s)''', (id,))
            await aconn.commit()


async def tracks_on_moderation():
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT id FROM music WHERE (status=FALSE)")
            return await acur.fetchall()


async def made_status_true_music(id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("UPDATE music SET status = TRUE WHERE id = %s", (id,))
            await aconn.commit()


async def del_genre(name):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''UPDATE genre SET is_showing=FALSE WHERE name=%s''', (name,))
            await aconn.commit()


async def add_music_to_playlist(music_id, user_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''INSERT INTO user_playlist (user_id, music_id) VALUES (%s, %s)''',
                               (user_id, music_id,))
            await aconn.commit()


async def check_is_track_added(music_id, user_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''SELECT * FROM user_playlist WHERE (user_id=%s AND music_id=%s)''',
                               (user_id, music_id))
            try:
                if (await acur.fetchone())[0] == 1:
                    return True
            except TypeError:
                return False


async def get_all_tracks():
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT * FROM music WHERE status=True")
            return await acur.fetchall()


async def delete_music_from_playlist(music_id, user_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''DELETE FROM user_playlist WHERE (user_id=%s AND music_id=%s)''',
                               (user_id, music_id,))
            await aconn.commit()


async def all_genres():
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT * FROM genre WHERE is_showing=TRUE")
            return await acur.fetchall()


async def get_all_user_tracks(user_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT music_id FROM user_playlist WHERE user_id=%s", (user_id,))
            return await acur.fetchall()


async def get_user_id_from_tg_id(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT id FROM users WHERE tg_id=%s", (tg_id,))
            return (await acur.fetchone())[0]


async def get_all_tracks_of_genre(genre_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT * FROM music WHERE (genre_id=%s AND status=True)", (genre_id,))
            return await acur.fetchall()


async def name_of_genre(genre_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT name FROM genre WHERE id=%s", (genre_id,))
            return (await acur.fetchone())[0]


async def add_music(name, author, genre_id, file_id, creator_id, file_unique_id, status=False):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''INSERT INTO music (name, author, genre_id, file_id, creator_id, file_unique_id, status) 
            VALUES (%s, %s, %s, %s, %s, %s, %s)''',
                               (name, author, genre_id, file_id, creator_id, file_unique_id, status))
            await aconn.commit()


async def check_is_new_user(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT count(id) FROM users WHERE tg_id = %s", (tg_id,))
            count = await acur.fetchone()
            if count[0] != 1:
                return 'new'
            return False


async def create_user(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''INSERT INTO users (tg_id) VALUES (%s)''',
                               (tg_id,))
            await aconn.commit()


"""
async def who_is_creator(user_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT (name, surname) FROM users WHERE user_id = %s", (user_id,))
            full_name = (await acur.fetchone())[0]
            return full_name


async def add_new_user(tg_id, login, phone, name, surname):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''INSERT INTO users (tg_id, login, phone name, surname) VALUES (%s, %s, %s, %s, %s)''',
                               (tg_id, login, phone, name, surname,))
            await aconn.commit()


async def task_info(task_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''SELECT * FROM tasks WHERE task_id = %s''', (task_id,))
            info = await acur.fetchone()
    return info


async def take_tasks_id_for_user(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT user_id FROM users WHERE tg_id = %s", (tg_id,))
            user_id = (await acur.fetchone())[0]
            await acur.execute("SELECT task_id FROM executor__task WHERE user_id = %s", (user_id,))
            tasks_id = list(map(lambda x: x[0],
                                await acur.fetchall()))
            not_new_and_not_completed_tasks_id = []
            for task_id in tasks_id:
                if not await check_is_new_task(task_id) and not await check_is_completed_task(task_id):
                    not_new_and_not_completed_tasks_id.append(task_id)
    if not_new_and_not_completed_tasks_id:
        return not_new_and_not_completed_tasks_id
    return False


async def take_answer_tasks_id_for_user(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT user_id FROM users WHERE tg_id = %s", (tg_id,))
            user_id = (await acur.fetchone())[0]
            await acur.execute("SELECT task_id FROM executor__task WHERE user_id = %s", (user_id,))
            tasks_id = list(map(lambda x: x[0],
                                await acur.fetchall()))
            not_new_and_not_completed_tasks_id = []
            for task_id in tasks_id:
                if not await check_is_new_task(task_id) and not await check_is_completed_task(task_id)\
                        and not await check_is_ver_task(task_id):
                    not_new_and_not_completed_tasks_id.append(task_id)
    if not_new_and_not_completed_tasks_id:
        return not_new_and_not_completed_tasks_id
    return False


async def take_completed_tasks_id_for_user(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT user_id FROM users WHERE tg_id = %s", (tg_id,))
            user_id = (await acur.fetchone())[0]
            await acur.execute("SELECT task_id FROM executor__task WHERE user_id = %s", (user_id,))
            tasks_id = list(map(lambda x: x[0],
                                await acur.fetchall()))
            completed_tasks_id = []
            for task_id in tasks_id:
                if await check_is_completed_task(task_id):
                    completed_tasks_id.append(task_id)
    if completed_tasks_id:
        return completed_tasks_id
    return False


async def take_user_id_from_tg_id(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT user_id FROM users WHERE tg_id = %s", (tg_id,))
            user_id = (await acur.fetchone())[0]
            return user_id


async def take_tg_id_from_user_id(user_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT tg_id FROM users WHERE user_id = %s", (user_id,))
            tg_id = (await acur.fetchone())[0]
            return tg_id


async def is_title_uniq(title):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT count(task_id) FROM tasks WHERE title = %s", (title,))
            task_id = (await acur.fetchone())[0]
            return task_id


async def take_task_id_from_title(title):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT task_id FROM tasks WHERE title = %s", (title,))
            try:
                task_id = (await acur.fetchone())[0]
                return task_id
            except TypeError:
                return False


async def add_task(creator_id, date_now, title, description, deadline):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("INSERT INTO tasks (creator, creating_date, deadline_date, title, description) "
                               "VALUES (%s, %s, %s, %s, %s)",
                               (creator_id, date_now, deadline, title, description,))
            await aconn.commit()


async def add_executor__task(user_id, task_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("INSERT INTO executor__task (user_id, task_id) VALUES (%s, %s)", (user_id, task_id,))
            await aconn.commit()


async def take_user_id_from_name_surname(name, surname):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            try:
                await acur.execute("SELECT user_id FROM users WHERE name = %s AND surname = %s", (name, surname,))
                user_id = (await acur.fetchone())[0]
                return user_id
            except TypeError:
                return False


async def take_new_tasks_id_for_user_and_change_status(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT user_id FROM users WHERE tg_id = %s", (tg_id,))
            user_id = (await acur.fetchone())[0]
            await acur.execute("SELECT task_id FROM executor__task WHERE user_id = %s", (user_id,))
            tasks_id = list(map(lambda x: x[0],
                                await acur.fetchall()))
            new_task_id = []
            for task_id in tasks_id:
                if await check_is_new_task(task_id):
                    new_task_id.append(task_id)
                    await acur.execute("UPDATE tasks SET status = 'execution' WHERE task_id = %s", (task_id,))
            await aconn.commit()
    if new_task_id:
        return new_task_id
    return False


async def check_is_new_task(task_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''SELECT status FROM tasks WHERE task_id = %s''', (task_id,))
            status = (await acur.fetchone())[0]
    if status == 'given':
        return True
    return False


async def check_is_ver_task(task_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''SELECT status FROM tasks WHERE task_id = %s''', (task_id,))
            status = (await acur.fetchone())[0]
    if status == 'verification':
        return True
    return False


async def check_is_completed_task(task_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''SELECT status FROM tasks WHERE task_id = %s''', (task_id,))
            status = (await acur.fetchone())[0]
    if status == 'completed':
        return True
    return False


async def who_is_executor(task_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT user_id FROM executor__task WHERE task_id = %s", (task_id,))
            user_id = (await acur.fetchone())[0]
            await acur.execute("SELECT (name, surname) FROM users WHERE user_id = %s", (user_id,))
            full_name = (await acur.fetchone())[0]
            return full_name


async def set_completed_task(title):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("UPDATE tasks SET status = 'completed' WHERE title = %s", (title,))
            await aconn.commit()


async def set_rework_task(title):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("UPDATE tasks SET status = 'rework' WHERE title = %s", (title,))
            await aconn.commit()


async def take_tasks_id_to_check(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT user_id FROM users WHERE tg_id = %s", (tg_id,))
            user_id = (await acur.fetchone())[0]
            await acur.execute("SELECT task_id FROM tasks WHERE creator = %s AND status = 'verification'", (user_id,))
            tasks_id = list(map(lambda x: x[0],
                                await acur.fetchall()))
            if tasks_id:
                return tasks_id
            else:
                return False


async def take_user_s_tasks(tg_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT user_id FROM users WHERE tg_id = %s", (tg_id,))
            user_id = (await acur.fetchone())[0]
            await acur.execute("SELECT task_id FROM tasks WHERE creator = %s", (user_id,))
            tasks_id = list(map(lambda x: x[0],
                                await acur.fetchall()))
            if tasks_id:
                return tasks_id
            else:
                return False
"""