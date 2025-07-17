--titre les plus longs
SELECT 
    title
FROM
    movie
ORDER BY CHAR_LENGTH(title) DESC;


SELECT 
    title,
    CHAR_LENGTH(title) title_length
FROM
    movie
ORDER BY CHAR_LENGTH(title) DESC;


--lower en minuscule
SELECT 
    LOWER(title),
    CHAR_LENGTH(title) title_length
FROM
    movie
ORDER BY CHAR_LENGTH(title) DESC;

--upper en minuscule
SELECT 
    UPPER(title),
    CHAR_LENGTH(title) title_length
FROM
    movie
ORDER BY CHAR_LENGTH(title) DESC;

--enlever les espaces inutiles
SELECT TRIM(person_name)
FROM person
WHERE person_name LIKE ' %'

SELECT CONCAT(title, ' by ', person_name) as pub
FROM movie
JOIN movie_crew USING(movie_id)
JOIN person USING (person_id)
WHERE job = 'Director'
ORDER BY budget DESC;

--Trouver des films dont le titre contient un mot spécifique,
--en ignorant la casse
SELECT 
    title
FROM
    movie
WHERE LOWER(title) LIKE '%moon%'

--convertir tous les noms de genre en majuscules pour uniformiser l'affichage
SELECT 
    UPPER(genre_name) as genre_uppercase
FROM
    genre

