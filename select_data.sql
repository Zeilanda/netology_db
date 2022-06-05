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
SELECT a.name as album_name, AVG(duration_sec) as avg_track_duration
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
SELECT DISTINCT c.name
FROM singers as s
INNER JOIN singersalbums as sa on s.id = sa.singer_id
INNER JOIN tracks as t on sa.album_id = t.album_id
INNER JOIN trackscollections as tc on t.id = tc.tracks_id
INNER JOIN collections as c on tc.collections_id = c.id
WHERE s.name = 'ZZ Top';


-- название альбомов, в которых присутствуют исполнители более 1 жанра
SELECT name
FROM genressingers
LEFT JOIN  singersalbums as sa on genressingers.singer_id = sa.singer_id
LEFT JOIN albums as a on a.id = sa.album_id
GROUP BY name
HAVING COUNT(genre_id) > 1;



-- наименование треков, которые не входят в сборники
SELECT name
FROM tracks
LEFT JOIN trackscollections t on tracks.id = t.tracks_id
WHERE collections_id IS NULL;

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












