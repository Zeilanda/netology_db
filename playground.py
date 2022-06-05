
singer_name = "'; SELECT * FROM secure; --"
sql = f"SELECT name FROM singers WHERE name ILIKE '%{singer_name}%';"
print(sql)


SELECT singers.id, singers.name, array_agg(a.name) FILTER ( WHERE a.name is not null ), count(*) FILTER ( WHERE a.name is not null )
FROM singers
LEFT JOIN singersalbums s on singers.id = s.singer_id
LEFT JOIN albums a on s.album_id = a.id AND date_part('year', release_date) = 2020
-- WHERE array_agg(a.name)
GROUP BY singers.id

SELECT *
FROM singers
LEFT JOIN singersalbums s on singers.id = s.singer_id
LEFT JOIN albums a on s.album_id = a.id  AND date_part('year', release_date) = 2020
ORDER BY singers.id, a.id


SELECT singers.name
FROM singers
LEFT JOIN singersalbums s on singers.id = s.singer_id
LEFT JOIN albums a on s.album_id = a.id  AND date_part('year', release_date) = 2020
GROUP BY singers.id
HAVING count(a.id) FILTER ( WHERE a.id is not null ) = 0

SELECT name
FROM (
         SELECT singers.id, singers.name, array_agg(a.id) FILTER ( WHERE a.id is not null ) as ids,
           array_agg(a.name) as names,
           array_agg(a.release_date) FILTER ( WHERE a.id is not null ) as dates,
           count(*)
    FROM singers
    LEFT JOIN singersalbums s on singers.id = s.singer_id
    LEFT JOIN albums a on s.album_id = a.id  AND date_part('year', release_date) = 2020
    GROUP BY singers.id
         ) as final_table
WHERE final_table.dates IS NULL