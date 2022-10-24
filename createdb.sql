CREATE DATABASE tg_w_music;
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
    genre_id int NOT NULL,
    file_id varchar NOT NULL,
    file_unique_id varchar NOT NULL,
    creator_id int,
    status boolean NOT NULL DEFAULT FALSE,

    CONSTRAINT PK_companies_company_id PRIMARY KEY(id),
    CONSTRAINT FK_creator_music FOREIGN KEY(creator_id) REFERENCES users(id),
    CONSTRAINT FK_genre_music FOREIGN KEY(genre_id) REFERENCES genre(id)
);

CREATE TABLE user_playlist
(
    user_id int NOT NULL,
    music_id int NOT NULL,

    CONSTRAINT PK_admin__company PRIMARY KEY(user_id, music_id),
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

INSERT INTO users(tg_id) VALUES (481317616);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Chanse', 'Raggi Luminosi', 1, 'CQACAgIAAxkBAAIDMGMPXYtqG1vAg14KMCDzicCO38ZCAAJkGgACVWowS0X0TQlE5SvRKQQ', 1, TRUE, 0);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Hypnotized', 'Oliver Koletzki', 1, 'CQACAgIAAxkBAAINN2MhtWdBOd9EJR4GsX12tTnCMcpeAAJvHwAC2GWZSQNYV9Nr4pfLKQQ', 1, TRUE, 1);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('SexyBack', 'ilkan Gunuc,Clara Stegall', 1, 'CQACAgIAAxkBAAIOIWMjfelaYFznktuLi-23miW51V-FAAIZGgACVa1BSSrEAAGP2mFWWykE', 1, TRUE, 2);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Tago', 'Fanis Stam', 1, 'CQACAgIAAxkBAAIOK2MjfmwtvL5qrprZZpibZR4ywutYAAJdIQACNMAgSZgob38t1VUKKQQ', 1, TRUE, 3);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Night Prayer', 'Rashid Alamo feat. Jaw', 1, 'CQACAgIAAxkBAAIOn2MjhTErU39SfHepKcMS06q9YS7dAAIsHAACSpkRSkre0AkhuH4jKQQ', 1, TRUE, 4);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Topeka', 'Netam, Damla Temel', 1, 'CQACAgIAAxkBAAIO0WMjh0aXLAk5RcX-uPN_YwuANxpnAALYGgACcCmhSg-Hv8NzT24cKQQ', 1, TRUE, 5);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Fragile', 'Kora (CA)', 1, 'CQACAgIAAxkBAAIO22Mjh5u0_aRoUNA21plcRFQykbs9AAL2GAACexx4SYH1R0ZYmhELKQQ', 1, TRUE, 6);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Swayed', 'Kiss mod', 1, 'CQACAgIAAxkBAAIPF2Mjiipw8Y_FCVDM6o-wcIopinMZAALtFAACEkopSkb25esaktBQKQQ', 1, TRUE, 7);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Ночь', 'Assenssia, Blvck', 1, 'CQACAgIAAxkBAAIPbmMjjzCnsXVx7sUdfhBFtySr4JBjAAI9GAACDmBxSX4jYGWcTSXFKQQ', 1, TRUE, 8);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('King of Bass', 'G. Key, Alex Mini', 1, 'CQACAgIAAxkBAAIPgmMjkAd5IPojPM2NnEm1vc3Zgn0cAAJZGAACCIA4SQtvw-NvPmMNKQQ', 1, TRUE, 9);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('It’s Insanity', 'ALPHADOG', 1, 'CQACAgIAAxkBAAISo2MscM3S77znkH4u2KmxZc3H8xfDAALZGwACOZQQSFxDBrp-PFZMKQQ', 1, TRUE, 10);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('its Time to Wake Up 2023', 'La Femme', 1, 'CQACAgIAAxkBAAISrWMsceYLwnuTlp0rHJUcKF7t4JFeAALRGwACAXiwSpXokabOaMQuKQQ', 1, TRUE, 11);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Москва не Лондон', 'Danny Abro', 7, 'CQACAgIAAxkBAAISt2Msc6bqHXH2aSnkqlzYo_4NP-csAAKIIAACMCvZS40F3NoXqoHXKQQ', 1, TRUE, 12);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('chiao bitch', 'Dvaiodin', 7, 'CQACAgIAAxkBAAISwWMsdMyBIDLiE3RXcWckocwcM74xAALlGAACL4oISgl5dCMTEes0KQQ', 1, TRUE, 13);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Фантом', 'BADIEV', 7, 'CQACAgIAAxkBAAIS0GMsdTIlk9SkuRy27jlko-0luXqGAAJYIAACNWepS1smfXxWqxOnKQQ', 1, TRUE, 14);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Kollera', 'Dusty Kid', 1, 'CQACAgIAAxkBAAIS2mMsdkaewTEGgNbqxMgPQdwm_XJ4AAJcHQACjdyAS7Qm6AM2D9hDKQQ', 1, TRUE, 15);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Трали-вали', 'Руви', 7, 'CQACAgIAAxkBAAIS5GMse3d6N8vmC2BbK1U4PXKFQr2VAAJfGgACqerRSWLZudzgI4C1KQQ', 1, TRUE, 16);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Море', 'Кравц', 3, 'CQACAgIAAxkBAAIS7mMse9_UPJrdmVkLFfuxyIDoEXIKAAKRGQACZs1ISUEFMhpS0j9rKQQ', 1, TRUE, 17);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Уже час', 'Каспийский Груз feat. Триагрутрика', 3, 'CQACAgIAAxkBAAITKWMsfnDUt7MH2bFKTTj3Ypf6svicAAJdFwACOXNASYljnxjJkX_QKQQ', 1, TRUE, 18);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Дыхание', 'Sirotkin', 10, 'CQACAgIAAxkBAAITM2MsfuT3KtqoKuU0b-kxrmXJBAn5AAK1EgAC-4pwScWzzQXvoq4OKQQ', 1, TRUE, 19);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Nevada', 'Kerala Dust', 8, 'CQACAgIAAxkBAAITVWMsgD01rFYqetY4flst6Q0HvTMEAAJ8FQACyAKASZtUl8YV6DcqKQQ', 1, TRUE, 20);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Leave Me', 'Otnicka', 8, 'CQACAgIAAxkBAAITv2Msga0n0BgAAWseb_5CMG0YOTQzkAACHxgAAvLNWUl4g9T9QUoeXSkE', 1, TRUE, 21);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Cupa Cupa', 'Parra for Cuva', 8, 'CQACAgIAAxkBAAITz2MsgjF9xzjWoFJRBdPVXHqbURiUAAKEHAAC80RxSaEkZK7ZjM7IKQQ', 1, TRUE, 22);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Let’s Do', 'Deep koliis', 8, 'CQACAgIAAxkBAAIT2WMsgtpBvwb-lrUCbAw2lZ8G8FPsAAKGFgACJDzhSslhD4SiOvuIKQQ', 1, TRUE, 23);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Ветер в спину', 'ВесЪ Loc-Dog', 3, 'CQACAgIAAxkBAAIT9mMsg30QaUjUR4YUn01QQNbMqRLLAAKFFQACHwtQSfxRe3lY1pj_KQQ', 1, TRUE, 24);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Save Me', 'LLEU', 1, 'CQACAgIAAxkBAAIUFmMshGHbk76eWbzfRG8AAXgKrHa4lQAC_hQAAjAeWElWya0VicJIGSkE', 1, TRUE, 25);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Polyhedron', 'NBSPLV', 8, 'CQACAgIAAxkBAAIUIGMshNb1HvHP9Bf_nw3Mzr7blrT2AAJxFgAC1Oc4Sb6nPQLDqC_SKQQ', 1, TRUE, 26);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Kiss the Night', 'Twoxi, Poletay', 1, 'CQACAgIAAxkBAAIUKmMshUvykRUzEPH1lBJjuimr0Ti5AAJVFwACWwP5S6sB5BVbi2uQKQQ', 1, TRUE, 27);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Подпишись', 'Naf, Zambezi, Типси Тип', 3, 'CQACAgIAAxkBAAIUdGMu3mHdyATQzNemArNW8kIyU094AAIhEwAC0N3hScnXBMDVb9b_KQQ', 1, TRUE, 28);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('СМУЗИ', 'The Limba', 7, 'CQACAgIAAxkBAAIUfmMu3yeyOj7aGkdNou0c80_t-fNhAALyGgACT2lgSvQLzfucO-DRKQQ', 1, TRUE, 29);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Вот и всё', 'Звонкий', 6, 'CQACAgIAAxkBAAIUkmMu38pBuV-XO1FgJPzS0fXFV49zAAITHAACe-lAScSt-LVBwC5lKQQ', 1, TRUE, 30);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Superman', 'Eminem feat. Dina Rae', 3, 'CQACAgIAAxkBAAIUnGMu4AeDbDj1LcelIfDomgEojXj2AAKcGwACOGrJSMMuwJ-5GB7-KQQ', 1, TRUE, 31);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Варвара', 'Би-2', 5, 'CQACAgIAAxkBAAIUpmMu4Esh4F8CN_nMBQABAcF8vGiVtwAC0xoAAiCScUq9mZYYgnzzTykE', 1, TRUE, 32);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Granatum', 'Sako Isoyan', 8, 'CQACAgIAAxkBAAIUsGMu4OPSjKMnd2LdFwfHXnUpGtypAAKqFQACbPhhSQhXaxGyOvBsKQQ', 1, TRUE, 33);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Моя по-любому', 'SHAMI', 7, 'CQACAgIAAxkBAAIUumMu4Tl-NZ-l_qPeid6K4xsh47q9AAK3HgACRc9ISRpPYEt71dE2KQQ', 1, TRUE, 34);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Выходи', 'NLO, Анет Сай', 7, 'CQACAgIAAxkBAAIUxGMu4YffJ9WQWujdQ5_Pk_bUCPlMAAImFwACnzEZS_RgIBVzo9BVKQQ', 1, TRUE, 35);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Smoke', 'VINIVILLA feat. FILV', 7, 'CQACAgIAAxkBAAIUzmMu4cETTaPFAoyn5s78SfXk0DABAAJjHAAC3c3ZSv0bHnO38HeKKQQ', 1, TRUE, 36);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Всё пиздато', 'Зануда feat. П.Ё.С.', 3, 'CQACAgIAAxkBAAIU5GMu4yNJ7e0RsNJmwZ-s9ijBafCyAAL3FAAC4_R4SSCS1Ynuqd4uKQQ', 1, TRUE, 37);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Hey Mama', 'ERS, Valerie Baltaeva', 1, 'CQACAgIAAxkBAAIU7mMu44MRq1q_PVthYNvCNDUbj0m2AAJnEgACpHpBSXrWGZdtoXDBKQQ', 1, TRUE, 38);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Ангел', 'Кажэ Обойма feat. Баста', 3, 'CQACAgIAAxkBAAIU-GMu4792csdvXTu6sht9yWgvnUICAALzFgACs_axSQm0tf-_Hy5zKQQ', 1, TRUE, 39);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Я хочу дом', 'Black Mesa feat. Nigorah', 7, 'CQACAgIAAxkBAAIVAmMu5D6YBTV6v5VeT1W1_ENNbY6pAAJLGQACLYpRSdH1aaA_aavGKQQ', 1, TRUE, 40);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Sweetdreams (Podval Capella Remix)', 'Еmily browning', 8, 'CQACAgIAAxkBAAIVDGMu5MZ_9MfBUe6MVwNub2OxIZvxAAIoFwACePh4SfI7ECpgmqHGKQQ', 1, TRUE, 41);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('PERRON', 'Dina RAF', 7, 'CQACAgIAAxkBAAIVFmMu5Ri98CzG5UxQxyAKOfdrAtfkAAJjGwAC29wISIFqOMeYfxsGKQQ', 1, TRUE, 42);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Дышат о любви', 'Dan Balan, INDI', 8, 'CQACAgIAAxkBAAIVIGMu5Yt8FSZxrl5eC6IY-QGQWZ12AAJsHQACerjQSycClWgJM2kYKQQ', 1, TRUE, 43);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('La alegria', 'Scott Rill, Yasmin Levy', 1, 'CQACAgIAAxkBAAIVKmMu5dVNsWE6FanLbXK1msau0lq7AAK1GwACD4EwSYbrQeDbCOpsKQQ', 1, TRUE, 44);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Сине-красные огни', 'Detsl aka Le Truk', 7, 'CQACAgIAAxkBAAIVNGMu5hhYRtfKVvxJQAiQdJ1iuxdRAAKpFQACmow4SRd1idEa3_03KQQ', 1, TRUE, 45);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Стало холодать', 'Johnny Bongzila feat. Murovei, Коля Маню', 7, 'CQACAgIAAxkBAAIVSGMu5s-3k9dQJc2g7AwfxgdzRPGJAAK2FQACsPO4SdGlFLSAEEW7KQQ', 1, TRUE, 46);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Простыни (karmv Remix)', 'KALVADOS', 7, 'CQACAgIAAxkBAAIVXGMu513HlNics2epM905o9kmKAGRAAI7HAAC2OoBSGawSuh2m8O1KQQ', 1, TRUE, 47);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('X.O', 'The Limba, Andro', 7, 'CQACAgIAAxkBAAIVZmMu54f7p3OANR7t81yv8aGUVg9jAALYKAACx7MpSAWkBlq3ddyIKQQ', 1, TRUE, 48);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('SNEAKY', 'WYR GEMI', 1, 'CQACAgIAAxkBAAIVcGMu58K4NE6CO8Rqbc595kht28NpAAJtHgACfA55SCmM7yxUceSvKQQ', 1, TRUE, 49);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('LUV', 'Luxor', 7, 'CQACAgIAAxkBAAIVemMu5_YplBVIiFkUBitS3GUjhgABfwACQRcAAtVWOUn3otHAxmO3kSkE', 1, TRUE, 50);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('All Designer', 'HEDEGAARD, CANCUN', 1, 'CQACAgIAAxkBAAIVhGMu6DdkIs7QWWteQ90sNr6EUASvAAJdGAACvoNISReTp1C3-UfsKQQ', 1, TRUE, 51);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Street Child (Pill.One Remix)', 'Jambazi', 4, 'CQACAgIAAxkBAAIVjmMu6If9Gw2RGHjjw0iOEBTfqbOvAAIgHwACSPHBSB_jnrY3OLNFKQQ', 1, TRUE, 52);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Мы не дружим с головой', 'Лилая', 7, 'CQACAgIAAxkBAAIVnmMu6PFOOWoNgwtI0RHoJNjt-pSpAAKxEwACyq9ISSX_YlNBwFnIKQQ', 1, TRUE, 53);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Делай любовь', 'Звонкий, Ёлка, Рем Дигга', 6, 'CQACAgIAAxkBAAIVqGMu6aIhW4zDdYYl5oPCWGs2h6mjAAIrFQACu-5BSShdn6oUN9suKQQ', 1, TRUE, 54);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Oh My Darling', 'Unklfnkl', 8, 'CQACAgIAAxkBAAIVsmMu6e-jrLHZ5jy6FG2u714iayGXAAIyFwACyURISSIUbJuRpVByKQQ', 1, TRUE, 55);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Firewater', 'Fat Joe feat. Big Pun, Armageddon, Raekwon', 3, 'CQACAgIAAxkBAAIVvGMu6h-9YJf5w15zaOwx60CXh-aOAALTFAACH2lgSxT86usb8HbDKQQ', 1, TRUE, 56);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Понедельник', 'Taukan', 7, 'CQACAgIAAxkBAAIV0GMu6wYwJwABI29DIN5usMNkXieWYAACRhsAAhlJ4Up06ynJ1jC1GikE', 1, TRUE, 57);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Front Line', 'Mobb Deep', 8, 'CQACAgIAAxkBAAIV2mMu6yr94AZPtT2bxtLcFanUIZNoAAJKHAAC1mx4SUjUTOtxUrdIKQQ', 1, TRUE, 58);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Shorty Wanna Be A Thug', '2Paс', 3, 'CQACAgIAAxkBAAIV6GMu63OvuE-7DZnnyEJxEtxDhxMWAAKxFgACE_BBScAiHY2RP5MEKQQ', 1, TRUE, 59);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Bitch Please II', 'Eminem feat. Dr. Dre, Snoop Dogg, Xzibit, Nate Dogg', 3, 'CQACAgIAAxkBAAIV8mMu66KNPkm6b4TYAAHiIl3LWG1bnwAC6h0AAmBO6EjSXe-De3416CkE', 1, TRUE, 60);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('American Psycho II', 'D12 feat. B-Real', 3, 'CQACAgIAAxkBAAIV_GMu69NiK8U1mVu0_PCUXjAm_7vnAAJlFQACj58IStUfGZhIH7XiKQQ', 1, TRUE, 61);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Forgot About Dre', 'Dr. Dre feat. Eminem', 3, 'CQACAgIAAxkBAAIWBmMu7D9C20bPNHt7j3ho2ojJXKxDAAIeFQAC7ENBSWayyVKCTjT4KQQ', 1, TRUE, 62);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Illusions Harpsichord Mix', 'Cypress Hill', 3, 'CQACAgIAAxkBAAIWEGMu7GrpfrryXXTVOx_kOrsj_fLrAALDEwACBzdpSbd9WuiVP4TxKQQ', 1, TRUE, 63);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Paparazzi', 'Xzibit', 3, 'CQACAgIAAxkBAAIWGmMu7Jhyq0SHtj2nAQsFNzDdYkS0AALLFwACgt5JSckX5Ldr041LKQQ', 1, TRUE, 64);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Survival of the Fittest', 'Mobb Deep', 3, 'CQACAgIAAxkBAAIWJGMu7MaI5m-Lbyyksc1p7RwFE0VQAAI-HQAC_iFgSOXfLEZgRVj9KQQ', 1, TRUE, 65);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Raze It Up', 'Onyx', 3, 'CQACAgIAAxkBAAIWLmMu7PSyZRm9hy0WXD1ir8blCcdPAALVFgACNdQ5SWlj_Phk7TgTKQQ', 1, TRUE, 66);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('California Love', '2Pac feat. Roger Troutman, Dr. Dre', 3, 'CQACAgIAAxkBAAIWOGMu7UY_sGsMSPBl0Yvps7bxPOUVAAK3FwAC66JBSYm3lUynERn-KQQ', 1, TRUE, 67);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Changes', '2Pac feat. Talent', 3, 'CQACAgIAAxkBAAIWQmMu7XJ60e1LtgFlolh8l4LLOYuyAAK3FwAC66JBSYm3lUynERn-KQQ', 1, TRUE, 68);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Changes', '2Pac feat. Talent', 3, 'CQACAgIAAxkBAAIWVmMu7h5IR8mRBL_ekq0tT9mBevptAAJWIgACHwdgSZOLxBYxGHvEKQQ', 1, TRUE, 69);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Hit ’Em Up (Original Mix)', '2Pac', 3, 'CQACAgIAAxkBAAIWYGMu7ktf8FiBKi4SLIlTKmOjNGLCAAKvEwACN9g4SVkesSN_c8JAKQQ', 1, TRUE, 70);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('The Read All About It (Emeli Sande Cover)', 'Stefan Biniak', 8, 'CQACAgIAAxkBAAIWamMu7pr8OhcpwlVRZeu5qm8ehH7bAAJRHAAC1mx4SQg-Lty2rL8YKQQ', 1, TRUE, 71);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Отряд самоубийц', 'Ost suicide squad', 4, 'CQACAgIAAxkBAAIWdGMu7yL8xC2OthxLrQhZSlh7XTGuAAINHAAChPjgSdn1A7Yalks1KQQ', 1, TRUE, 72);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Hypnotized ( Remix by G-Ko)', 'Oliver Koletzki feat. Fran', 4, 'CQACAgIAAxkBAAIWiGMu7-RRQNXJqbfWf_Til-Iy-b7KAAJYHAAC1mx4SXT6-rhxVUQ2KQQ', 1, TRUE, 73);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Ласковый Зверь (DJ Mexx Remix)', '9 Грамм feat. Alina Orlova', 4, 'CQACAgIAAxkBAAIWkmMu8EJcmdhTHq73fjTxZztWUtZaAALOFwAC8M6hSdpc8qFmOxmoKQQ', 1, TRUE, 74);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Haunted (DJ Kapral Remix)', 'Isabel La Rosa', 4, 'CQACAgIAAxkBAAIWnGMu8KQkZ-2QT0a7ENIX9I3CsjqbAAI4IgACPpVBS331qMhJj5zeKQQ', 1, TRUE, 75);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Underworld (Volen Sentir Remix)', 'Nacho Varela & Cruz Vittor', 4, 'CQACAgIAAxkBAAIWpmMu8O4Mqo_haHlpVNbkCEdq80UtAAJMGAACQN4QSOGJhHTmMl-FKQQ', 1, TRUE, 76);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Release The Energy', 'German Brigante', 1, 'CQACAgIAAxkBAAIWsGMu8UyO99mQ7SHevbT7nFjoZBzNAAJRGAACQN4QSK1KrykhynnLKQQ', 1, TRUE, 77);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Moth To A Flame (Adriatique Remix)', 'Swedish House Mafia, The Weeknd', 4, 'CQACAgIAAxkBAAIWumMu8Zdyzy47pk1tmJu2VIuuf3oSAALFGwACw3_AS3YYl-dabTRgKQQ', 1, TRUE, 78);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Стрелы', 'Markul, Тося Чайкина', 7, 'CQACAgIAAxkBAAIWyGMu8d7Vi0cOosWsBeNVvDAaEPMPAAKMHQACfRv5SI5q6HnWJN_QKQQ', 1, TRUE, 79);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Himalayas', 'Alexander Alar, RoelBeat', 1, 'CQACAgIAAxkBAAIW0mMu8hkZk2NJj0pWIyIOWc6kMDkvAALJFgACfQ5ISf-qvswrReYQKQQ', 1, TRUE, 80);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Грустный дэнс', 'Artik & Asti, Артем Качер', 6, 'CQACAgIAAxkBAAIW3GMu8m5pJQvVPv_X6gABk0q4GOoCYQAChhoAAkcK-UkYy_6xjnBphikE', 1, TRUE, 81);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Mladost', 'Tebra', 8, 'CQACAgIAAxkBAAIW5mMu8uDeUHzBl9S_DE94WBKAUwmSAAIiFgACyG8JSr71R_WjYDNqKQQ', 1, TRUE, 82);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Минута вечера', 'Тима Белорусских, просто Лера', 6, 'CQACAgIAAxkBAAIW8GMu8zNIASmi6DOPPEul0X8bQm_DAALjFAACKvM5SaiF6uRVU2nTKQQ', 1, TRUE, 83);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Seduction Original Mix', 'Fanis Stam', 1, 'CQACAgIAAxkBAAIW-mMu84Karad3YWTvrq3G9ALuuarpAAJvFgACwbjQScOwcdy66W9yKQQ', 1, TRUE, 84);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Свет гаснет', 'Игла, SLIMUS', 3, 'CQACAgIAAxkBAAIXDmMu89L_WsdjrRaGb97Tc_LitDcGAAInGAACEVVJSZ9CPNTsQiJxKQQ', 1, TRUE, 85);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('МАЛИНОВАЯ ЛАДА', 'GAYAZOV$ BROTHER$', 7, 'CQACAgIAAxkBAAIXGGMu9AlVfTrlUjxwvaY5jXoj67D0AAL0GgAC4aR4Sg8CO8G6Zy6kKQQ', 1, TRUE, 86);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Вечеринка', 'Nebezao', 7, 'CQACAgIAAxkBAAIXImMu9FYce9AjlpD8kp4o_rdvdZpjAAKfGgAC-RFxSlvgI_eMUjfGKQQ', 1, TRUE, 87);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Сестра', 'Каста', 3, 'CQACAgIAAxkBAAIXLGMu9IIeKE-np4vktWT-_Wnb9cs-AAIdGAACgpEQSiyDlgsdkmeHKQQ', 1, TRUE, 88);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Восемь West Junior Remix', 'Лилу45', 4, 'CQACAgIAAxkBAAIXNmMu9MpUSR0iwAunCi4ORTy-TXLZAAJiFgACFZQ4SWMukeAGSr9nKQQ', 1, TRUE, 89);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Шишки', 'L iZReaL feat. Pastor Napas', 7, 'CQACAgIAAxkBAAIXQGMu9PpNLkOwVjYN1WWf8zPui6DUAAKFFwACJcs5SRc8Xr5EVgowKQQ', 1, TRUE, 90);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Gyasi', 'Solidmind', 8, 'CQACAgIAAxkBAAIXSmMu9VIzLnSYF2MqUIdVqBILgz15AAJFJgACf6OxSRwwfFk3gVD9KQQ', 1, TRUE, 91);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('As Time Goes By', 'Zuma Dionys', 1, 'CQACAgIAAxkBAAIXVGMu9YIaoMbuzjzgCDVcIqDMiuYZAAIIFwACgQp4SQABsn_Celi3ZykE', 1, TRUE, 92);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('In The End Mellen Gi Remix', 'Tommee Profitt, Fleurie, Mellen Gi', 4, 'CQACAgIAAxkBAAIXXmMu9a74w1peXPC18OsgRcZsdpfnAALFGgACYgswSYd6-ZFcadYTKQQ', 1, TRUE, 93);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Би-2', 'Би-2', 10, 'CQACAgIAAxkBAAIXaGMu9ef2pOjQsCT1MzTnatdjrkhUAAL1HAACUkF4SgHENpvZaP4TKQQ', 1, TRUE, 94);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Курара Чибана', 'Курара feat. Александр Гагарин, Антон Нифантьев, Екатерина Павлова', 7, 'CQACAgIAAxkBAAIXcmMu9k6Ro5DHVu2RCUnOu9YepmTEAAIfEwACbr3YSUJHORo4Np1HKQQ', 1, TRUE, 95);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('2 Phút Hơn KAIZ Remix', 'Pháo', 1, 'CQACAgIAAxkBAAIXfGMu9rYOEK_BkBhgXlRgN59zNQMdAAI8GAACVNw4SZvQf8-QNs_VKQQ', 1, TRUE, 96);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Desire', 'Libercio', 1, 'CQACAgIAAxkBAAIXhmMu9t1zanYVGKbZHFves5KV-P3AAAJbHQACzos5SYWcyDzWlKtDKQQ', 1, TRUE, 97);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Addicted', 'ONEIL, SMOLA', 4, 'CQACAgIAAxkBAAIXkGMu9xAcL0hfnwuPza-bSyuBNFGiAALBEwACK_45STym84omEfGAKQQ', 1, TRUE, 98);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Over the Ground', 'Chipinkos', 1, 'CQACAgIAAxkBAAIXmmMu90pvrhETaZ2lOb74-xYc6qSAAAKuFAACCSfYS6CwY5ZvjpyUKQQ', 1, TRUE, 99);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Disfruto (Audioiko Remix)', 'Carla Morrison', 4, 'CQACAgIAAxkBAAIXpGMu93MLW1zhYoWNoCVldCna9Yj6AAIKGQACs03RSCDGV_aID4h7KQQ', 1, TRUE, 100);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('SexyBack', 'ilkan Gunuc, Clara Stegall', 1, 'CQACAgIAAxkBAAIXrmMu-BgBrsfTs4fIJu97ige5D5eYAAIZGgACVa1BSSrEAAGP2mFWWykE', 1, TRUE, 101);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Tago Original Mix', 'Fanis Stam', 1, 'CQACAgIAAxkBAAIXuGMu-FRSbpKxHG1TzSHiVLAegRKbAALIGAAC2jXASxp050S3nDNPKQQ', 1, TRUE, 102);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Do It To It', 'ACRAZE feat. Cherish', 4, 'CQACAgIAAxkBAAIXwmMu-M-ILurTBgRLKPgLpVZBNKXXAAKUGgAC10XRSYHQarK_8osGKQQ', 1, TRUE, 103);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Тлеет', 'Bula, SVNV', 7, 'CQACAgIAAxkBAAIX62Mu-Veb_hRcNHCmqQfsmcwZbIYWAAKRHAACqrGgS4-Mm55QeKGcKQQ', 1, TRUE, 104);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Не пускайте танцевать', 'TIMRAN, Zell, Batrai feat. Aslai', 6, 'CQACAgIAAxkBAAIX9WMu-YpPoH7g6dij0SxtoQzkcSb6AALqHAACFGKISs5dpu1qtUR6KQQ', 1, TRUE, 105);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Индиго', 'Дана Соколова feat. Скруджи', 6, 'CQACAgIAAxkBAAIX_2Mu-csIhptk479UwHPAo9KmcZlgAALbHAACSqr5SAUTGkmN4m-nKQQ', 1, TRUE, 106);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Всем счастья', 'ГЛАВНАЯ РОЛЬ', 6, 'CQACAgIAAxkBAAIYG2Mu-u4aw6SBPvan11neAAHcyuJqnAAC1hYAAnYYQUk2W5ok7pD_EikE', 1, TRUE, 107);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Не наговаривай Alik Leto Chill Remix', 'RSAC, Ёлка', 4, 'CQACAgIAAxkBAAIYJWMu-4LetDtJe72OIxB7HvJS4OlZAAKMIQACNMAgSTadjMF4uhZvKQQ', 1, TRUE, 108);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Black Panther (feat. Rafal)', 'Nebezao feat. Rafal', 7, 'CQACAgIAAxkBAAIYL2Mu_Af63qgkx1XZ6k8wMpKp1-mOAAK6GwACL9ABST-6F4k8VFp4KQQ', 1, TRUE, 109);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Rolls Royce', 'Джиган, Тимати, Егор Крид', 7, 'CQACAgIAAxkBAAIYOWMu_EETxqXfZiO2I6c2ZK_vEHDEAAL5HwACqYxQS91iH85hjUnkKQQ', 1, TRUE, 110);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Воу-воу палехчэ', 'Jah Khalib', 6, 'CQACAgIAAxkBAAIYQ2Mu_KP_J-goXZWV6OEURMbKkq0fAALyFAACMxNpSeDrteP6AQaWKQQ', 1, TRUE, 111);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Night Prayer', 'Rashid Ajami feat. Jaw', 1, 'CQACAgIAAxkBAAIYTWMu_OOosRl-onX94ZSrws8cCuTQAAIsHAACSpkRSkre0AkhuH4jKQQ', 1, TRUE, 112);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Слово к слову', 'Легенды Про, Centr', 3, 'CQACAgIAAxkBAAIYV2Mu_Qr483w2heHePw6X59BHnd-uAAKbHAACTulJSaEK-GsstixXKQQ', 1, TRUE, 113);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Трали-вали', 'РУВИ', 7, 'CQACAgIAAxkBAAIYYWMu_U3pAAGXoSIwQ9PEk70FILa-ugACXxoAAqnq0Uli2bnc4COAtSkE', 1, TRUE, 114);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Море', 'Кравц', 3, 'CQACAgIAAxkBAAIYa2Mu_bOrzEgZjOJ2G_CfoEaDepcFAAKRGQACZs1ISUEFMhpS0j9rKQQ', 1, TRUE, 115);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Groovejet Andrey Exx & Fomichev', 'Lissat & Voltaxx, Marc Fisher', 4, 'CQACAgIAAxkBAAIYdWMu_hxM4Izyt7RkHkgnN3Kvzjp4AAIZHwACuf5hS-ZoQU9iKkpYKQQ', 1, TRUE, 116);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Toprak', 'Netam, Damla Temel', 8, 'CQACAgIAAxkBAAIYf2Mu_lKh4zo9kDVv8RLT9nr97Wh6AALYGgACcCmhSg-Hv8NzT24cKQQ', 1, TRUE, 117);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Fragile', 'Kora (CA)', 8, 'CQACAgIAAxkBAAIYiWMu_sqlhRXYy_I2OzyA3ZTEcZ9fAAL2GAACexx4SYH1R0ZYmhELKQQ', 1, TRUE, 118);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Без тебя я тону в этом море (Barabanov Remix)', '5УТРА', 4, 'CQACAgIAAxkBAAIYk2Mu_wABC6RnLE9IqIfIgxteKXvO0QAC-RIAAqUuOUlf6XrV7PYrcykE', 1, TRUE, 119);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Not So Bad', 'Yves V, Ilkay Sencan feat. Emie', 4, 'CQACAgIAAxkBAAIYnWMu_1bi95MMFXt47cT21LT41Jo4AAJ3FwAC54hoSaCw7_oiHbotKQQ', 1, TRUE, 120);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Bleu Chanel (NA-NO Remix)', 'ARIA', 4, 'CQACAgIAAxkBAAIYp2Mu_4g6eLcKFdYCU1uKxS6vqRWAAAKMGAACQG1ISXJaYK1eCiUQKQQ', 1, TRUE, 121);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Киса на опыте', 'RSAC feat. SLIMUS', 3, 'CQACAgIAAxkBAAIYsWMu_9Byf0tUuWuCqGZvfFJ5msYNAAIfFQACmphISQE66wAB5nUMiCkE', 1, TRUE, 122);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Swayed', 'Kiasmos', 8, 'CQACAgIAAxkBAAIYu2MvAAFLHka-n1Kq6JoeO04QCjDTIQAC7RQAAhJKKUpG9uXrGpLQUCkE', 1, TRUE, 123);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Тишина', 'WE feat. Vasya', 6, 'CQACAgIAAxkBAAIYxWMvAAF3s867gricojCeNHsDUNVzzgACdhoAAm1GiUnB9z7LfCfdbikE', 1, TRUE, 124);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Крылья', 'SLIMUS feat. Ай-Q', 3, 'CQACAgIAAxkBAAIYz2MvAAHOMGHKbj0mhiYJ4hnzdT44KAACARkAAoYzEEpSanzq-szRGSkE', 1, TRUE, 125);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Если буду', 'Стриж, SLIMUS, Ай-Q', 6, 'CQACAgIAAxkBAAIY2WMvAAH-0fsDQaZ53eSqT78-Ajt_sgAClBgAAkOIcUoI0VBq11ONvikE', 1, TRUE, 126);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Мёд (feat. искра)', 'Рем Дигга feat. Искра', 6, 'CQACAgIAAxkBAAIY42MvAUP29IfdJ6D_7mxdNTizGIVtAAILGwACoydpSbBJrCqiLFqJKQQ', 1, TRUE, 127);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Если честно', 'D.L.S. feat. SLIMUS', 3, 'CQACAgIAAxkBAAIY7WMvAY-czrVmxMg-t6x-UyOf0UW6AAMTAAI24plJg2YMEJl5244pBA', 1, TRUE, 128);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Любимая песня', 'HammAli, Loc-Dog', 6, 'CQACAgIAAxkBAAIY92MvAcefAAHGU8Pr4RH5VNjixnCZfQACDBIAAtejcUkUbpCI1Dag-ikE', 1, TRUE, 129);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('SLIMUS', 'SLIMUS', 7, 'CQACAgIAAxkBAAIZAWMvAg_oOp-_7ZHiDPARmolTMP0qAAKiFQACq7uJSYGP1PWVkz8fKQQ', 1, TRUE, 130);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Пой со мной', 'Krec feat. Елена Темникова', 6, 'CQACAgIAAxkBAAIZC2MvAkEJpmMMZV3Coy_5LH03v8txAALpEgACYbJASe0QJwZsKSttKQQ', 1, TRUE, 131);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Делай любовь', 'Звонкий, Ёлка, Рем Дигга', 6, 'CQACAgIAAxkBAAIZFWMvAnaKtbhK4OYlV0CDD1a6rFPTAAIrFQACu-5BSShdn6oUN9suKQQ', 1, TRUE, 132);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Стёкла', 'Lil Kate & Смоки Мо', 6, 'CQACAgIAAxkBAAIZH2MvArCghDIeleVkrnGdPnpMUyCAAALJEgACGi45SQx3KON2QsvTKQQ', 1, TRUE, 133);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Техно', '2 Ляма feat. Zivert', 6, 'CQACAgIAAxkBAAIZKWMvAt8EK4RhvKVwy9yNWu5iUtx8AALmFwACVDBZSZqDOWYQkaW3KQQ', 1, TRUE, 134);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Dior', 'ASAEV feat. Izzamuzzic', 7, 'CQACAgIAAxkBAAIZM2MvA3Moi5ZYWoIwAAF0AXiXjRuABQACNBYAAofKOEmE2fYO53nsbSkE', 1, TRUE, 135);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Aldebaran Original', 'Hraach, Armen Miran', 8, 'CQACAgIAAxkBAAIZPWMvA7Q1NAaAuXePwn9UoivzMUCwAAKaEwACh16wSd3j4HnIXGEsKQQ', 1, TRUE, 136);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Позови меня с собой (Cover)', 'TSOY', 4, 'CQACAgIAAxkBAAIZR2MvBAuKW5b8TrArp8htwEn8PqTHAAKIGwAC5i94S0KqKWYJW2jHKQQ', 1, TRUE, 137);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('МНЕ УЖЕ ПОРА', 'Loc-Dog, Scady', 6, 'CQACAgIAAxkBAAIZUWMvBD-E21hzlL5EhwiVBZ_HZfzZAAJKFQACBZxJSf9Tt9KLzffDKQQ', 1, TRUE, 138);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Никому я тебя не отдам Remastered', 'Линда', 4, 'CQACAgIAAxkBAAIZZWMvBMRDgGTOZzlDafBjyWOfsr9DAAJ_EgAC1UZZSZtaNiN-TQwBKQQ', 1, TRUE, 139);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Dernière Danse', 'Ugg’A', 4, 'CQACAgIAAxkBAAIZb2MvBQNM3cUswL40byEi7GOYH0zyAAJJFgACQNdJSUs2DUXlSascKQQ', 1, TRUE, 140);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Love Tonight Vintage Culture & Kiko Franco Remix', 'Shouse', 4, 'CQACAgIAAxkBAAIZeWMvBTvl7yTzpups340xBj-iSTu3AAK9FQACnhxRSQRyUcQSPTxWKQQ', 1, TRUE, 141);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Дурман', 'Ганвест', 7, 'CQACAgIAAxkBAAIZg2MvBW3fBZpNsBfkq_AgpeOKTxxiAAI4HgAC9mThSqZk6U2pvWKeKQQ', 1, TRUE, 142);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Нас не догонят', 'liam howard ТАТУ', 4, 'CQACAgIAAxkBAAIZjWMvBbGIYM642JF4CtH67lnAsNrdAAKWGQACeBFwSvJvopVhyJsEKQQ', 1, TRUE, 143);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Show Me Original Mix', 'Andrey Kravtsov', 1, 'CQACAgIAAxkBAAIZl2MvBeUa4AL2p6ucoWTUerWiGVZOAAIhHQACadqZSApL-g_V7LhzKQQ', 1, TRUE, 144);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Friend Radio Edit', 'KastomariN', 1, 'CQACAgIAAxkBAAIZoWMvBij4G5lOd_WCnHiKHp9eZO5OAAIpHAACJcGpSQwOhSffFBevKQQ', 1, TRUE, 145);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Gave My Heart', 'Ali Bakgor', 1, 'CQACAgIAAxkBAAIZq2MvBoVtW8xPdQvBjo2O8pK7Kk1SAAKRFAACaPdZSZEyA4dgpAeDKQQ', 1, TRUE, 146);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Мерцают огни', 'Agunda, Тайпан', 6, 'CQACAgIAAxkBAAIZtWMvBqqXZRRG0DqPXa7UB4ohfElqAAIdHAACNezIS3GN6iQPCtz4KQQ', 1, TRUE, 147);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Не строю планы', 'Ямыч Восточный Округ', 3, 'CQACAgIAAxkBAAIZv2MvBtBToj3B2ufeYm83XhEQKSB3AAKhFgAC9dZwSr9k2jclsLHyKQQ', 1, TRUE, 148);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Спокойная ночь', 'Кино', 10, 'CQACAgIAAxkBAAIZyWMvBv7TkXqrvhA4WBnwtZmp3enPAALbGAACaJ3ISdOrrqKUaOY4KQQ', 1, TRUE, 149);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Я хочу', 'Grivina', 6, 'CQACAgIAAxkBAAIZ02MvBzhKtWixw_Pg6Hbi6Q_VXu7GAALiGAACJnXQSOUSneiSQGbnKQQ', 1, TRUE, 150);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Бутылочка', 'Луна (izzamuzzic remix)', 4, 'CQACAgIAAxkBAAIZ3WMvB6Ae10G0vUyz7yl7zC9UizErAAIjHQAC1mx4SSiGGhER_rd1KQQ', 1, TRUE, 151);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Выпей меня', 'Kambulat', 7, 'CQACAgIAAxkBAAIZ52MvB83Wbovtqs8GI7Ru2jQwd8XtAALkGQADPKlLO-Vk3O503u8pBA', 1, TRUE, 152);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Давай не думать ни о чем( Remix)', 'Zivert', 4, 'CQACAgIAAxkBAAIZ8WMvCAjtRpRSaFdw-c2joujt5ihfAAInHQAC1mx4SZHKAAHyZBUwCykE', 1, TRUE, 153);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('забирай всё что хочешь но только не это', 'Неизвестен', 7, 'CQACAgIAAxkBAAIZ-2MvCEB4Ergp3_d7T5UqRMpa_gLlAAKXHAAC0GWQSHdE-U0iXF6pKQQ', 1, TRUE, 154);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Tab Leh Hobta Remix', 'Hrag Mikkel, Hobta', 1, 'CQACAgIAAxkBAAIaBWMvPqU1jC7vTYCDITWR2bYphZ1eAALeEwACA395SfGci-6QZgABQikE', 1, TRUE, 155);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Mantra Original', 'Zuma Dionys', 1, 'CQACAgIAAxkBAAIaD2MvPtOvgbKI_jF8olIqjwd5nmjTAAJ_EgACYnf4SegFiHQ-lgiFKQQ', 1, TRUE, 156);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Kak Nikogda Instrumental Mix', 'Airsand, Wayward Brothers', 1, 'CQACAgIAAxkBAAIaGWMvPw1Hi4LPSKbaevnRx_iXkfR3AALyFAAC6FHISWEwuyCGptGEKQQ', 1, TRUE, 157);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Up Or Down (Original Mix)', 'Roudeep', 1, 'CQACAgIAAxkBAAIaI2MvP2f6gj-w8hYOt-PW1fLHLUy3AAJzHAAC1myASYSagcF7EIg0KQQ', 1, TRUE, 158);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Hamayak Jan (Original Mix)', 'Hrag Mikkel & Pambouk', 1, 'CQACAgIAAxkBAAIaLWMvP5CWAAF5aVfuuAZMZkqIm4pjmQACNxgAAgjkIEp7LY9sO8aryikE', 1, TRUE, 159);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Закат', 'The OM', 7, 'CQACAgIAAxkBAAIaN2MvP9cVTIn4sr9tX4LHyArheFnFAAJhFQAC1Rg5SWN_YkNE4F09KQQ', 1, TRUE, 160);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Rechenka', 'Sako Isoyan', 1, 'CQACAgIAAxkBAAIaQWMvQBKYcF1HyFY8HTVx9-iKTuG1AALyFwAC6YBYSYa0UYt_UKuTKQQ', 1, TRUE, 161);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Dle Yaman', 'DJ Pantelis', 8, 'CQACAgIAAxkBAAIaS2MvQEgZlKn1TxKYhdvGQD6-tXB9AAJgGQACoE9AScoRb11k3H8pKQQ', 1, TRUE, 162);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Никогда Remastered', 'Линда', 6, 'CQACAgIAAxkBAAIaVWMvQJ_s_wFWcY5_JkglA_2rNqXeAAJpFgACbbhISRWxd_INAqwoKQQ', 1, TRUE, 163);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('The Mantra', 'Morttagua', 1, 'CQACAgIAAxkBAAIaX2MvQNShO6RYKfzDRdrXkWqHE1DmAAK4FgACtqxhSaoNjU4bCpvIKQQ', 1, TRUE, 164);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Мальчик, ты снег', 'Луна', 6, 'CQACAgIAAxkBAAIaaWMvQQbwesyOujQAAa0a7EfSgSqDnAACZxcAAqomKEvb0Y8lMhd20SkE', 1, TRUE, 165);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Закружило так', 'HammAli, Мари Краймбрери', 6, 'CQACAgIAAxkBAAIac2MvQU95Adc9g3xtwFgl3a98MolyAAK6FAACRbc5SbnRYCagJVM6KQQ', 1, TRUE, 166);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Как на войне', 'Сабина Ахмедова', 4, 'CQACAgIAAxkBAAIafWMvQZFjq5p7VxFSVEUgUtFAG5vXAALlFwACm2pBSjiTNzFqtAIOKQQ', 1, TRUE, 167);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Позови Меня... ( Rmx)', 'PALINA', 4, 'CQACAgIAAxkBAAIah2MvQdqYi3zyhrwYA5HESfCFpmfoAAJ7HgACGtN4SLS7DdDx4ntEKQQ', 1, TRUE, 168);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('БЕРЕГОМ', 'Ёлка', 6, 'CQACAgIAAxkBAAIakWMvQim8mly7J5r5zivn11ihQ2jWAAJoHQACIOpgSchA6ffVPrubKQQ', 1, TRUE, 169);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Broken Mind (Tip D`Oris Emotional Mix)', 'Devangel', 1, 'CQACAgIAAxkBAAIapWMvQqi7TDoLuGBH7QQDug6jwR_LAALyHwACDB4hSXNlTMIQFIIUKQQ', 1, TRUE, 170);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('mygut Solomun Remix', 'Super Flu', 4, 'CQACAgIAAxkBAAIar2MvQuJ7W1_JAsY2B2SBGPjv1UfRAAL0HwACDB4hSRQZeqB9v29iKQQ', 1, TRUE, 171);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('mygut Solomun Remix', 'Super Flu', 4, 'CQACAgIAAxkBAAIa4mMvQ_TVCvyhQ2edhuOvJzE7cGuvAAJSGgACIbLISIffklM1ewo8KQQ', 1, TRUE, 172);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Feel Me', 'Legroni, Peredel feat. Ilana Lorraine', 1, 'CQACAgIAAxkBAAIa7GMvREMuYqlgYSRdJyNSxV9SOC1iAAJsFgAC1Oc4SUCNr8wogMoUKQQ', 1, TRUE, 173);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Lamp', 'Raggi Luminosi', 8, 'CQACAgIAAxkBAAIa9mMvRIYGIXN56HDs8Awtc-ZwazzhAAKxGwAC2j3ZSis448kBV1mcKQQ', 1, TRUE, 174);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Mantra', 'Umid', 8, 'CQACAgIAAxkBAAIbAAFjL0Tk0U-gREp-MeoYRRBbmIKwcQAC-CUAAn-jsUn77JxdTfWaYSkE', 1, TRUE, 175);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Uhodi', 'Lilova', 1, 'CQACAgIAAxkBAAIbCmMvRRdGRg9RHmPnWhySkgyoB0r-AALGHAACWAg4SQwTDMenR0EIKQQ', 1, TRUE, 176);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Breath Me Original Mix', 'Bruno Be', 1, 'CQACAgIAAxkBAAIbFGMvRUK7Cwa5-sL1kM7BvQq3RlG5AAIPGgACztxRSA2Q39Z4oCMZKQQ', 1, TRUE, 177);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Tears', 'Serkan Saruhan', 8, 'CQACAgIAAxkBAAIbHmMvRYQDOhi4EDhPuucjOrV91HCpAAIdFgACyG8JSrMOEKBO--dSKQQ', 1, TRUE, 178);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Climbatize', 'The Prodigy', 1, 'CQACAgIAAxkBAAIbKGMvRbROuI0OgqpuOTccYEAumL9MAAKTGwAC80RxSStCuQ-WAWT6KQQ', 1, TRUE, 179);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Мутная', 'GUF feat. Slim и Птаха (Центр)', 3, 'CQACAgIAAxkBAAIbPGMvRiUmmVCUM0V2ba6MHjFQ1u9gAAJFEwACRQ9ZS4soThN6Rkb-KQQ', 1, TRUE, 180);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Заходит Луна', 'ГУФ feat. Принцип', 3, 'CQACAgIAAxkBAAIbR2MvRoykbOS_-H1xHUdnxf9ns6iFAAL7GwACmzpxSwIggnpsLmYBKQQ', 1, TRUE, 181);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Приходи', 'Сплин', 5, 'CQACAgIAAxkBAAIbUWMvRrhhqHEb4r8dqtnOtas41iN4AAJQFAACP_xRSR_wLcklxdU9KQQ', 1, TRUE, 182);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Малый повзрослел', 'Макс Корж', 6, 'CQACAgIAAxkBAAIbW2MvRuXHiGeifFshtA_HyxJoy6gEAAKzGwACAVxQSQLIOKnDCCA3KQQ', 1, TRUE, 183);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Окей', 'Тима Белорусских', 6, 'CQACAgIAAxkBAAIbZWMvSm6rNuLGMwOrgAsNYOh9URExAALzGgAC5ZMYSvL7OBhYgQ0KKQQ', 1, TRUE, 184);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Послала', 'VAVAN, Real Girl', 7, 'CQACAgIAAxkBAAIbb2MvSqu7rzI4moWvGYk9WC6T_mOVAAIQFwACFq95SfkUtHFi-RxlKQQ', 1, TRUE, 185);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Останься', 'NЮ, Асия', 6, 'CQACAgIAAxkBAAIbeWMvSsy8TZ5gQTSK30twtWlmXK97AAJeFgACBArZSHtrlI4PT70hKQQ', 1, TRUE, 186);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Last Night', 'Kastomarin', 1, 'CQACAgIAAxkBAAIbg2MvSwF6An2qnPMYw9GFnDpII6uWAAJNGQAC4XRpSUqjKn4Fedk2KQQ', 1, TRUE, 187);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Депрессия', 'Дерево Жизни', 7, 'CQACAgIAAxkBAAIbjWMvSy3Rtuah2jq3LU_mK_F4JwAB5wACVxUAAu2hGUqSDCrZkomxVSkE', 1, TRUE, 188);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Kiss the Night', 'Twoxi, Poletay', 1, 'CQACAgIAAxkBAAIboWMvS3E8Bf0AAVUE2P77MmvOb6h8cQACVRcAAlsD-UurAeQVW4trkCkE', 1, TRUE, 189);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Зеркала', 'Григорий Лепс, Ани Лорак', 10, 'CQACAgIAAxkBAAIbq2MvTAABZNdTAXSQwcltINlOrnJr0wACWx8AAhO-cEptGJ1e6vM1DSkE', 1, TRUE, 190);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Вокруг шум', 'Каста', 6, 'CQACAgIAAxkBAAIbv2MvTKBWfPd5xght5_ZBRpYhtDqsAAJlFQAC_BBhSc_nclNTDaw0KQQ', 1, TRUE, 191);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Многоточия (Radio Edit)', 'Zivert', 6, 'CQACAgIAAxkBAAIb02MvTP4cAAEBPqFQpTV7mpivRF1D2wACARgAAvCpYEktPpu5uaGmtSkE', 1, TRUE, 192);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Голоса', 'Звонкий', 6, 'CQACAgIAAxkBAAIb3WMvTS171wZQ_NZlRSxEg_A1Vil2AAIKGgAC9E_ZSZs0WfSGzmrbKQQ', 1, TRUE, 193);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Никотин', 'Ганвест', 7, 'CQACAgIAAxkBAAIb52MvTXoORTyUCLJHX_5xVAEbRDqQAAJPIAACh0apSOMqFVXiNrfaKQQ', 1, TRUE, 194);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Таблетка', 'Джаро & Ханза, kavabanga Depo kolibri', 7, 'CQACAgIAAxkBAAIb8WMvTbCux1vn7CnCl18OaedG5_xjAAJ8IQAChIMJSce0sgxU6ydLKQQ', 1, TRUE, 195);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Дым', 'Леша Свик', 7, 'CQACAgIAAxkBAAIb-2MvTex_eflAC14EVG1aib9Hzw5-AAKMHgACDg9JSJy3Wo0YSS5OKQQ', 1, TRUE, 196);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Minor', 'Miyagi & Andy Panda', 6, 'CQACAgIAAxkBAAIcBWMvThJd22JlQ8K4ptTdI4WXP0gvAAJbHwACClBwSaBqLSTYpFHrKQQ', 1, TRUE, 197);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Птичка', 'HammAli & Navai', 6, 'CQACAgIAAxkBAAIcD2MvTjyLbo8JK6bpVww0W3E1Sz7cAAIKIwAC60TYSK1E6E0ytV3bKQQ', 1, TRUE, 198);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('UFC', 'Jahmal TGK', 3, 'CQACAgIAAxkBAAIgqmM1vSF5tBH8z7n709Cc3lSzkvvPAALyEQACi8JBSVeRtvAqNdK7KgQ', 1, TRUE, 199);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Хлопушка', 'Zambezi feat. Типси Тип', 3, 'CQACAgIAAxkBAAIgxGM1vamywRtLUy3TScdSRkYhjfAgAAKFHgACRY3RSELWHYttZ_I3KgQ', 1, TRUE, 200);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Исповедь', 'CENTR feat. Стриж, Принцип', 3, 'CQACAgIAAxkBAAIgzmM1vf0kQkJFCcQjgfcH9uy__JqrAAKIFAACU2RoSZxym7Pd_xI7KgQ', 1, TRUE, 201);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Всем берегам', 'CENTR feat. Баста', 3, 'CQACAgIAAxkBAAIg2GM1vkzBXSfEGtNog0oxOfDZWtY3AALxFQACtsqYSXQLd6cFdCbTKgQ', 1, TRUE, 202);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Гудини', 'Каспийский Груз, CENTR', 3, 'CQACAgIAAxkBAAIg4mM1voRs2KiCvPi6vExrbOAumRruAALEFgACF5BASc40-c4DCtIYKgQ', 1, TRUE, 203);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Аватар', 'CENTR feat. Каспийский Груз', 3, 'CQACAgIAAxkBAAIg7GM1vrjiMoetskfaLaiEMyLBqXbAAAIzGgAC8xbZSQ-M667T7WOkKgQ', 1, TRUE, 204);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Вариант', 'Masha Hima', 7, 'CQACAgIAAxkBAAIhAAFjNb-W7oMprjxgBO1yWdHjMv8pSwACqiUAAv77OUlVZrlcPPWstCoE', 1, TRUE, 206);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Ночь', 'Asenssia, Blvck Cvrnvge', 1, 'CQACAgIAAxkBAAIhCmM1wDh92nPrBzD8qu9eBUC6Hp3pAAI9GAACDmBxSX4jYGWcTSXFKgQ', 1, TRUE, 207);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Who You Are', 'Gaullin', 2, 'CQACAgIAAxkBAAIhPWM1wS9drZZOnNrijjIFt7UX4TsuAAK9FQACaKtISXhAx3Srx3EiKgQ', 1, TRUE, 208);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Ирландец Freestyle', 'Брутто', 3, 'CQACAgIAAxkBAAIhfWM1wpXbYijTYT_YDu81-PNBUyobAALiGgACtyUxSY9VIDTYhAEVKgQ', 1, TRUE, 209);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('Платина', 'Jakone, A.V.G', 7, 'CQACAgIAAxkBAAIhqmM1w5749AnkLY06zA-KPw6MfZ1FAAJxJQACb8zwSN2Tt1sUxUKeKgQ', 1, TRUE, 210);
INSERT INTO music(name, author, genre_id, file_id, creator_id, status, file_unique_id) VALUES ('King of Bass', 'G.Key, AlexMini', 1, 'CQACAgIAAxkBAAIhx2M1xAZiIFFFiPCYNJii5q1g1wcnAAJZGAACCIA4SQtvw-NvPmMNKgQ', 1, TRUE, 211);