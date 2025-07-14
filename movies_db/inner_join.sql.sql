SELECT movie_cast.person_id, character_name, person_name
FROM movie_cast
INNER JOIN person ON movie_cast.person_id = person.person_id;

SELECT mc.person_id, character_name, person_name
FROM movie_cast AS mc
INNER JOIN person AS p ON mc.person_id = p.person_id;


SELECT mc.person_id, character_name, person_name
FROM movie_cast mc
INNER JOIN person p ON mc.person_id = p.person_id;


SELECT m.title, country_name
FROM
movie AS m 
INNER JOIN production_country pc ON m.movie_id = pc.movie_id
INNER JOIN country c ON pc.country_id = c.country_id;

SELECT title, country_name
FROM
movie 
INNER JOIN production_country USING(movie_id)
INNER JOIN country USING(country_id);

SELECT m.title, country_name
FROM
movie AS m 
INNER JOIN production_country pc ON m.movie_id = pc.movie_id
INNER JOIN country c ON pc.country_id = c.country_id
WHERE country_name = 'france';

SELECT m.title, country_name
FROM
movie AS m 
INNER JOIN production_country pc USING(movie_id)
INNER JOIN country c USING(country_id)
WHERE country_name = 'france';

SELECT DISTINCT title, language_name
FROM movie m
INNER JOIN movie_languages ml ON m.movie_id = ml.movie_id
INNER JOIN language l ON ml.language_id = l.language_id
WHERE language_name = 'Français';

SELECT DISTINCT title, language_name
FROM movie
INNER JOIN movie_languages USING(movie_id)
INNER JOIN language USING(language_id)
WHERE language_name = 'Français';

SELECT m.title, genre_name, language_name
from movie m 
INNER JOIN movie_genres mg ON m.movie_id = mg.movie_id
INNER JOIN genre g ON mg.genre_id = g.genre_id
INNER JOIN movie_languages ml ON m.movie_id = ml.movie_id
INNER JOIN language l ON ml.language_id = l.language_id

SELECT p.person_name, mc.character_name
FROM movie_cast mc
INNER JOIN person p ON mc.person_id = p.person_id
WHERE mc.movie_id = 
(SELECT movie_id 
FROM movie 
WHERE title = "Inception");

SELECT genre_name, title
FROM movie m
INNER JOIN movie_genres mg ON m.movie_id = mg.movie_id
INNER JOIN genre g ON mg.genre_id = g.genre_id
WHERE genre_name = 'Fantasy';

SELECT mc.person_id, character_name, person_name
FROM movie_cast mc 
RIGHT JOIN person p ON mc person_id = p.person_id
WHERE mc.movie_id = 285;

SELECT m.title
FROM movie m 
LEFT JOIN movie_keywords mk ON m.movie_id = mk.movie_id
WHERE mk.keyword_id IS NULL;

SELECT title
FROM movie m
LEFT JOIN production_country pc ON m.movie_id = pc.movie_id
LEFT JOIN country c ON pc.country_id = c.country_id
WHERE country_name IS NULL;

SELECT m.title 
FROM movie m
LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
WHERE genre_id is NULL;

SELECT * 
FROM genre
CROSS JOIN language;

SELECT p1.person_name, mc1.job, p2.person_name, mc2.job, mc1.movie_id
FROM movie_crew mc1
JOIN person p1
ON mc1.person_id = p1.person_id
JOIN movie_crew mc2 
ON mc1.movie_id = mc2.movie_id
JOIN person p2
ON mc2.person_id = p2.person_id
WHERE mc1.job = 'Director' AND mc2.job = 'Producer';

SELECT 
p1.person_name as 'Acteur 1', 
p2.person_name as 'Acteur 2', 
m.title as 'titre du film'
FROM movie_cast AS mc1
JOIN movie_cast AS mc2
ON mc1.movie_id = mc1.movie_id AND mc1.person_id < mc2.person_id
JOIN person AS p1
ON mc1.person_id = p1.person_id
JOIN person AS p2
ON mc2.person_id = p2.person_id

Join movie m ON mc1.movie_id = m.movie_id
Limit 100;

SELECT person_name FROM person 
JOIN movie_cast ON person.person_id = movie_cast.person_id
UNION
SELECT person_name FROM person 
JOIN movie_crew ON movie_crew.person_id = person.person_id
LIMIT 50;






