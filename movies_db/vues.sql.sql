-- CREATE VIEW cast_details AS
-- SELECT title, character_name, person_name
-- FROM movie_cast
-- JOIN movie USING (movie_id)
-- JOIN person USINg (person_id)

--casting Tous les acteurs d'un film spécifique genre 'inception'
SELECt person_name, character_name
FROM cast_details
WHERE title = 'inception'

--tous les films ou leonardo DiCaprio a joué
SELECT title
FROM cast_details
WHERE person_name = 'Leonardo DiCaprio'

--Film tous les films dans lequel un pers apparait genre 'james bond'
SELECT title
FROM cast_details
WHERE character_name = 'James Bond'

--nombre de films réalisé par chacun des acteurs
SELECT 
    person_name,
    COUNT(*) nbr_films
FROM cast_details
GROUP BY person_name
ORDER BY nbr_films DESC;

--james bond par année
SELECT title, person_name, release_date
FROM cast_details
JOIN movie USING (title)
WHERE character_name = 'James Bond'
ORDER BY release_date

--trouvez tous les films joué par un acteur spécifique
SELECT 
    title,
    character_name
FROM
    cast_details
WHERE
    person_name = 'Johnny Depp'

--Comptez le nbr d'apparition de film dans lequels un acteur a joué, ex "Tom Cruise'
SELECT
    COUNT(*) nb_films
FROM
    cast_details
WHERE
    person_name = 'Tom Cruise'

--trouver des erreurs ou des doublons dans votre base de données
SELECT 
    title, 
    character_name, 
    person_name,
    COUNT(*)
FROM
    cast_details
GROUP BY title, character_name, person_name
HAVING COUNT(*) > 1;

--ajouter une colonne donc je modifie ma view
ALTER VIEW cast_details AS
SELECT title, movie_id, character_name, person_name
FROM movie_cast
JOIN person USING (person_id)
JOIN movie USING (movie_id);

--peux faire la meme chose ou en changeant le nom crer une autre view
CREATE OR REPLACE VIEW cast_movie_details AS
SELECT title, movie_id, character_name, person_name
FROM movie_cast
JOIN person USING (person_id)
JOIN movie USING (movie_id);

--supprimer une view
DROP VIEW cast_movie_details;

SELECT * 
FROM cast_details
WHERE person_name = 'Johnny Depp'

UPDATE cast_details
SET person_name = 'Johnny Depp'
WHERE title = 'Pirates of the Caribbean: At World\'s End';

--creation nouvelle view
CREATE VIEW blockbuster AS
SELECT *
FROM movie
WHERE budget > 15000000;

--insertion nouveau film en-dessous budget
INSERT INTO blockbuster (title, budget)
VALUE('Yo cousin!', 10000);

--creer une option si l'insertion ne correspond pas à la table
CREATE OR REPLACE VIEW blockbuster AS
SELECT *
FROM movie
WHERE budget > 15000000
WITH CHECK OPTION;


