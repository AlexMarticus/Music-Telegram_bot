DROP TABLE IF EXISTS messages_to_delete;
DROP TABLE IF EXISTS user_playlist;
DROP TABLE IF EXISTS music;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS users;


CREATE TABLE users
(
    id serial,
	tg_id int NOT NULL UNIQUE,

    CONSTRAINT PK_user_id PRIMARY KEY(id)
);

CREATE TABLE messages_to_delete
(
    user_id int NOT NULL,
    message_id int NOT NULL,

    PRIMARY KEY(user_id, message_id),
	FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE genre
(
    id serial,
	name varchar(50) NOT NULL,
	is_showing boolean DEFAULT TRUE,

    CONSTRAINT PK_genre_id PRIMARY KEY(id)
);

CREATE TABLE music
(
    id serial,
    name varchar(100) NOT NULL,
	author varchar(100) NOT NULL,
    genre_id int,
    file_id varchar,
    file_unique_id varchar,
    creator_id int,
    status boolean NOT NULL DEFAULT FALSE,
    duration int,

    CONSTRAINT PK_companies_company_id PRIMARY KEY(id),
    CONSTRAINT FK_creator_music FOREIGN KEY(creator_id) REFERENCES users(id),
    CONSTRAINT FK_genre_music FOREIGN KEY(genre_id) REFERENCES genre(id)
);

CREATE TABLE user_playlist
(
    user_id int NOT NULL,
    music_id int NOT NULL,

    CONSTRAINT PK_user__music PRIMARY KEY(user_id, music_id),
	CONSTRAINT FK_user_music FOREIGN KEY(user_id) REFERENCES users(id),
	CONSTRAINT FK_music_music FOREIGN KEY(music_id) REFERENCES music(id)
);


INSERT INTO genre(name) VALUES ('Dance / Electronic / House');
INSERT INTO genre(name) VALUES ('Euro Top Hits 🎧');
INSERT INTO genre(name) VALUES ('Rap / Hip-Hop / R&B');

INSERT INTO genre(name) VALUES ('Remix ▶️');
INSERT INTO genre(name) VALUES ('Rock music 🎸');
INSERT INTO genre(name) VALUES ('Russian Hits 🎧');

INSERT INTO genre(name) VALUES ('Trend music ⏯');
INSERT INTO genre(name) VALUES ('Chill-out ⏸');
INSERT INTO genre(name) VALUES ('80’s 90’s 00’s Hits');
INSERT INTO genre(name) VALUES ('Шансон | Романс | Авторская песня');
