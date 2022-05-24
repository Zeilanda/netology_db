SELECT name, date_part('year', release_date) as year
FROM albums
WHERE date_part('year', release_date) = 2018;


SELECT name, duration_sec
FROM tracks
WHERE duration_sec = (
    SELECT MAX(duration_sec)
    FROM tracks
    );

SELECT name
FROM tracks
WHERE duration_sec >= 210;

SELECT name
FROM collections
WHERE date_part('year', release_date) BETWEEN 2018 AND 2020;

SELECT name
FROM singers
WHERE name NOT LIKE '% %';

SELECT name
FROM tracks
WHERE name ILIKE '%my%' OR name ILIKE'%мой%';

