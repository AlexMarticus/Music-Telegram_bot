import psycopg
from data.config import PG_USER, DB_NAME, PG_PASS, PG_HOST


async def add_message_id_for_deletting(user_id, message_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('INSERT INTO messages_to_delete (user_id, message_id) VALUES (%s, %s)',
                               (user_id, message_id))
            await aconn.commit()


async def delete_mes_id_from_del_mes(user_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''DELETE FROM messages_to_delete WHERE (user_id=%s)''', (user_id,))
            await aconn.commit()


async def return_all_ids_mes_for_delete(user_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("SELECT message_id FROM messages_to_delete WHERE user_id=%s", (user_id,))
            return await acur.fetchall()


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
            await acur.execute("SELECT id FROM music WHERE (status=FALSE AND file_id IS NOT NULL)")
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


async def add_gener_duration_file_id_to_music(music_id, file_id, file_unique_id, genre_id, duration, status=False):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''UPDATE music SET file_id = %s WHERE id=%s''', (file_id, music_id))
            await aconn.commit()
            await acur.execute('''UPDATE music SET file_unique_id = %s WHERE id=%s''', (file_unique_id, music_id))
            await aconn.commit()
            await acur.execute('''UPDATE music SET genre_id = %s WHERE id=%s''', (genre_id, music_id))
            await aconn.commit()
            await acur.execute('''UPDATE music SET duration = %s WHERE id=%s''', (duration, music_id))
            await aconn.commit()
            await acur.execute('''UPDATE music SET status = %s WHERE id=%s''', (status, music_id))
            await aconn.commit()


async def get_music_id(name, author, creator_id):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute("""SELECT id FROM music WHERE (name=%s AND author=%s AND creator_id=%s)""",
                               (name, author, creator_id))
            return (await acur.fetchone())[0]


async def add_music(name, author, creator_id, status=False):
    async with await psycopg.AsyncConnection.connect(f"dbname={DB_NAME} user={PG_USER} "
                                                     f"password={PG_PASS} host={PG_HOST}") as aconn:
        async with aconn.cursor() as acur:
            await acur.execute('''INSERT INTO music (name, author, creator_id, status)
            VALUES (%s, %s, %s, %s)''',
                               (name, author, creator_id, status))
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
