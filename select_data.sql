/* название и год выхода альбомов, вышедших в 2018 году; */
SELECT name, date_part('year', release_date) as year
FROM albums
WHERE date_part('year', release_date) = 2018;

/* название и продолжительность самого длительного трека */
SELECT name, duration_sec
FROM tracks
WHERE duration_sec = (
    SELECT MAX(duration_sec)
    FROM tracks
    );

/* название треков, продолжительность которых не менее 3,5 минуты */
SELECT name
FROM tracks
WHERE duration_sec >= 210;

/* названия сборников, вышедших в период с 2018 по 2020 год включительно */
SELECT name
FROM collections
WHERE date_part('year', release_date) BETWEEN 2018 AND 2020;

/* исполнители, чье имя состоит из 1 слова */
SELECT name
FROM singers
WHERE name NOT LIKE '% %';

/* название треков, которые содержат слово "мой"/"my" */
SELECT name
FROM tracks
WHERE name ILIKE '%my%' OR name ILIKE'%мой%';

/* количество исполнителей в каждом жанре */
SELECT name, COUNT(singer_id)
FROM genres INNER JOIN genressingers
ON genres.id = genressingers.genre_id
GROUP BY name;

/* количество треков, вошедших в альбомы 2019-2020 годов */
SELECT COUNT(t.name)
FROM albums INNER JOIN tracks t on albums.id = t.album_id
WHERE date_part('year', release_date) BETWEEN 2019 AND 2020;

/* средняя продолжительность треков по каждому альбому */
SELECT a.name as Название_альбома, AVG(duration_sec) as Средняя_продолжительность_треков
FROM tracks INNER JOIN albums a on a.id = tracks.album_id
GROUP BY a.name;

/* все исполнители, которые не выпустили альбомы в 2020 году */
SELECT DISTINCT s.name
FROM singers as s
LEFT JOIN
    (SELECT sa.singer_id, a.release_date, a.id
        FROM singersalbums as sa
        LEFT JOIN albums as a ON (a.id = sa.album_id)) as template
ON (s.id = template.singer_id) AND (date_PART('year', template.release_date) = 2020)
WHERE template.id is NULL
ORDER BY s.name;


-- названия сборников, в которых присутствует конкретный исполнитель (выберите сами)
SELECT chosen_collections.name
FROM singers as s
INNER JOIN (
    SELECT singer_id, name
    FROM singersalbums as sa
    INNER JOIN
        (SELECT album_id, collection_table.name
        FROM tracks as tr
        INNER JOIN (
            SELECT c.name, t.tracks_id
            FROM collections AS c INNER JOIN trackscollections t on c.id = t.collections_id) as collection_table
            ON tr.id = collection_table.tracks_id
        ) as tracks_coll_table
    ON sa.id = tracks_coll_table.album_id
    ) as chosen_collections
ON s.id = chosen_collections.singer_id
WHERE s.name = 'ZZ Top';

-- название альбомов, в которых присутствуют исполнители более 1 жанра
SELECT name
FROM (SELECT genre_id, gs.singer_id, name
    FROM genressingers as gs
    LEFT JOIN (
        SELECT singer_id, name
        FROM singersalbums as sa
        LEFT JOIN (
            SELECT al.id, al.name
            FROM albums as al
            ) as album_info
            ON sa.album_id = album_info.id
        ) as temple_table
    ON gs.singer_id = temple_table.singer_id) as final_table
GROUP BY name
HAVING COUNT(genre_id) > 1

-- наименование треков, которые не входят в сборники
SELECT name
FROM tracks
LEFT JOIN trackscollections t on tracks.id = t.tracks_id
WHERE collections_id IS NULL

-- исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)

SELECT s.name
FROM tracks as t
LEFT JOIN albums AS a on t.album_id = a.id
LEFT JOIN singersalbums sa on a.id = sa.album_id
LEFT JOIN singers s on sa.singer_id = s.id
WHERE t.duration_sec = (SELECT MIN(duration_sec) FROM tracks)
ORDER BY s.name;

-- название альбомов, содержащих наименьшее количество треков

SELECT albums.name
FROM albums
LEFT JOIN tracks AS t ON albums.id = t.album_id
group by albums.name
HAVING COUNT(t.id) = (
    SELECT MIN(amount)
    FROM (
         SELECT count(t.id) as amount
            FROM albums AS al
            LEFT JOIN tracks AS t on al.id = t.album_id
            GROUP BY al.name
     ) as temp
);












