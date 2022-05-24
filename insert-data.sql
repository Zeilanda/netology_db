INSERT INTO genres(name)
    VALUES
           ('pop'),
           ('metal'),
           ('classic'),
           ('rock'),
           ('electronic');

INSERT INTO singers(name)
    VALUES
           ('Sia'),
           ('Scorpions'),
           ('Король и Шут'),
           ('David Guetta'),
           ('Therion'),
           ('Vanessa Mae'),
           ('Scratch Massive'),
           ('ZZ Top');

INSERT INTO genressingers(genre_id, singer_id)
    VALUES
           (1, 1),
           (2, 2),
           (2, 5),
           (3, 6),
           (4, 2),
           (4, 3),
           (4, 8),
           (5, 4),
           (5, 7);

INSERT INTO albums(name, release_date)
    VALUES
           ('Music', '4-02-2021'),
           ('In Trance', '17-09-1975'),
           ('Герои и Злодеи', '13-04-2000'),
           ('One More Love', '24-08-2009'),
           ('Of Darkness', '1-02-1991'),
           ('The Violin Player', '16-05-1995'),
           ('Nuit de Rêve', '31-10-2011'),
           ('Rio Grande Mud', '4-04-1972'),
           ('Like', '12-08-2018');

INSERT INTO singersalbums(singer_id, album_id)
    VALUES
           (1, 1),
           (2, 2),
           (3, 3),
           (4, 4),
           (5, 5),
           (6, 6),
           (7, 7),
           (8, 8),
           (1, 9);

INSERT INTO tracks(name, duration_sec, album_id)
    VALUES
           ('Together', 205, 1),
           ('Hey Boy', 149, 1),
           ('Dark Lady', 205, 2),
           ('In Trance', 283, 2),
           ('Дед на свадьбе', 288, 3),
           ('Невеста палача', 264, 3),
           ('On the Dancefloor', 226, 4),
           ('One love', 241, 4),
           ('The Return', 313, 5),
           ('Morbid reality', 364, 5),
           ('Contradanza', 232, 6),
           ('Warm air', 221, 6),
           ('Closer', 301, 7),
           ('Follow me', 318, 7),
           ('Just Got Paid', 213, 8),
           ('Bar-B-Q', 205, 8),
           ('My heart', 201, 9),
           ('My love', 365, 9),
           ('Мой рок-н-ролл', 289, 9);

INSERT INTO collections(name, release_date)
    VALUES
           ('Ttitanium', '25-06-2012'),
           ('Helium', '18-03-2018'),
           ('Top heats', '12-06-2010'),
           ('Violin', '24-05-2015'),
           ('Rock stars', '31-12-2019'),
           ('Agony', '6-08-2009'),
           ('Besties', '4-09-2016'),
           ('Pop and rock', '5-09-2017'),
           ('Love and hate', '12-06-2020');


INSERT INTO trackscollections(tracks_id, collections_id)
    VALUES (1, 1),
           (2, 1),
           (3, 5),
           (16, 5),
           (2, 2),
           (11, 4),
           (8, 4),
           (10, 6),
           (16, 7),
           (6, 7),
           (1, 8),
           (2, 8),
           (5, 8),
           (6, 8),
           (17, 9);
