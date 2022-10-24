import sqlite3

sq_c = sqlite3.connect('DataBase.db')
cur = sq_c.cursor()
sqlite_insert_query = """SELECT * FROM Music"""
result = cur.execute(sqlite_insert_query)
k = 0
for elem in result:
    for i in range(len(elem)):
        try:
            elem[i] = elem[i].replace("'", '’')
        except AttributeError:
            pass
        except TypeError:
            pass
    if elem[3] == 'Dance / Electronic / House':
        a = 1
    elif elem[3] == 'Euro Top Hits 🎧':
        a = 2
    elif elem[3] == 'Rap / Hip-Hop / R&B':
        a = 3
    elif elem[3] == 'Remix ▶️':
        a = 4
    elif elem[3] == 'Rock music 🎸':
        a = 5
    elif elem[3] == 'Russian Hits 🎧':
        a = 6
    elif elem[3] == 'Trend music ⏯':
        a = 7
    elif elem[3] == 'Chill-out ⏸':
        a = 8
    elif elem[3] == "80’’s 90’’s 00’s Hits":
        a = 9
    elif elem[3] == 'Шансон | Романс | Авторская песня':
        a = 10
    else:
        continue
    i = 'INSERT INTO'
    s = f" music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('{elem[1]}', '{elem[2]}', {a}, '{elem[4]}', 1, TRUE, {k});"
    print(i + s)
    k += 1
sq_c.commit()
cur.close()
# print(li)
