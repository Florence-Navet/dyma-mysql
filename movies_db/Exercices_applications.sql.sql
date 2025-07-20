/*film budget > film Inception triez par budget decroissant()
On peut utiliser agregation mais pas jointures ni group by*/

SELECT *
FROM movie
WHERE budget > (
    SELECT budget 
    FROM movie 
    WHERE title = 'Inception')
ORDER BY budget DESC;

/*Retrouvez tous les films dont le revenu est supérieur au revenu moyens des films sortis après le 1er janvier 2000 et triez les résultats par budget décroissant.*/

SELECT *
FROM movie
WHERE revenue iS NOT NULL
    AND revenue > (
    SELECT AVG(revenue) 
    FROM movie 
    WHERE release_date > '2000-01-01'
)
ORDER BY budget DESC;

/*Retrouvez tous les films dont les USA ne font no
pas parti des pays de production du film.*/
SELECT *
FROM movie
WHERE movie_id NOT IN (
    SELECT movie_id 
    FROM production_country 
    WHERE country_id = (
        SELECT country_id
        FROM country
        WHERE country_name = 'United States of America'
    )
)





/*Obtenez le titre de chaque film accompagné du nombre total de films sortis la même année
pas de join ni de order by* ni de group by f fin exercice*/


SELECT 
    title as titre, 
    release_date AS date_sortie,
    (
    SELECT COUNT(*)
    FROM movie
    WHERE YEAR(release_date) = YEAR(m.release_date)
    ) as nb_films
FROM movie m

/*Trouvez les acteurs qui n'ont jamais joué dans un film d'action ni dans une comédie, ni dans un drame, ni dans un film d'aventure -
Ces exercices peuvent comporter des sous-requêtes, des agrégations et toujours des jointures. Ils ne comportent pas de GROUP BY*/

--DISCTINCT pour ne pas avoir de doublons
SELECT *
FROM person
JOIN movie_cast USING(person_id)
WHERE person_id NOT IN (
    SELECT DISTINCT person_id 
    FROM movie_cast
    JOIN movie_genres USING (movie_id)
    JOIN genre USING(genre_id)
    WHERE genre_name IN ('Action', 'Comedy', 'Drama', 'Adventure')
);

/*créez une requête pour identifier toutes les paires d'acteurs qui ont joué ensemble dans au moins un film. Affichez les noms des acteurs dans chaque paire et le titre du film dans lequel ils ont joué ensemble. Triez par le nom du premier acteur, puis pas le nom du second acteur, puis par titre du film.*/
SELECT DISTINCT
    p1.person_name AS acteur1,
    p2.person_name AS acteur2,
    m.title
FROM movie_cast mc1
JOIN movie_cast mc2
    ON mc1.movie_id = mc2.movie_id AND mc1.person_id != mc2.person_id
JOIN person p1
    ON mc1.person_id = p1.person_id
JOIN person p2
    ON mc2.person_id = p2.person_id
JOIN movie m
    ON mc1.movie_id = m.movie_id
GROUP BY acteur1, acteur2, m.title 
ORDER BY m.title, acteur1, acteur2
LIMIT 150;

/*Trouvez les acteurs ayant joué dans plus de 30 films et triez les par nb de films*/
SELECT 
    person_name acteur,
    COUNT(*) nb_films
FROM person 
JOIN movie_cast mc USING (person_id)
GROUP BY person_id
HAVING nb_films > 30
ORDER BY nb_films DESC;


/*Ecrivez une requête pour trouver le revenu total généré par les film pour chaque production et triez par revenu total décroissant
production_country , retrouver nb pays dans table country avec des JOIN*/

SELECT
c.country_name pays,
SUM(m.revenue) revenue_total
FROM production_country pc 
JOIN country c USING (country_id)
JOIN movie m USING (movie_id)
WHERE m.revenue IS NOT NULL
GROUP BY c.country_name
ORDER BY revenue_total DESC;



/*Trouvez le film le plus populaire par genre et triez alpha par genre*/
SELECT
g.genre_name AS genre,
m.title AS titre,
m.popularity AS popularite
FROM
movie_genres mg 
JOIN genre g ON mg.genre_id = g.genre_id
JOIN movie m ON mg.movie_id = m.movie_id
WHERE m.popularity = (
    SELECT MAX(m2.popularity)
    FROM movie_genres mg2
    JOIN movie m2 ON mg2.movie_id = m2.movie_id
    WHERE mg2.genre_id = mg.genre_id
    LIMIT 1
)
ORDER BY genre_name

--correction de la requête du dessus
SELECT genre_name, (
    SELECT title
    FROM movie
    JOIN movie_genres USING(movie_id)
    WHERE g.genre_id = genre_id
    ORDER BY popularity DESC
    LIMIT 1
)
FROM genre as g 
ORDER BY genre_name;

-- recuperer popularité films 
SELECT genre_name, 
(SELECT title
FROM movie
JOIN movie_genres USING(movie_id)
WHERE g.genre_id = genre_id
ORDER BY popularity DESC
LIMIT 1
) as film_les_plus_pop
FROM genre AS g 
ORDER BY genre_name


/*Trouvez les 15 acteurs ayant joué dans le plus grand nombre de genres différents DISTINCT*/

SELECT
 p.person_name AS Acteur,
 COUNT(DISTINCT mg.genre_id) AS Nombre_de_genres
FROM 
 person p
JOIN movie_cast mc ON p.person_id = mc.person_id
JOIN movie m ON mc.movie_id = m.movie_id
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genre g ON mg.genre_id = g.genre_id
GROUP BY p.person_name
ORDER BY Nombre_de_genres DESC
LIMIT 15;


SELECT
 p.person_name AS Acteur,
 COUNT(DISTINCT mg.genre_id) AS Nombre_de_genres
FROM 
 person p
JOIN movie_cast mc ON p.person_id = mc.person_id
JOIN movie_genres mg USING (movie_id)
JOIN genre g ON mg.genre_id = g.genre_id
GROUP BY p.person_name
ORDER BY Nombre_de_genres DESC
LIMIT 15;



