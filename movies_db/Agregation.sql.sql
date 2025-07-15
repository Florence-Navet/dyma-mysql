--Calcul de la moyenne des budgets des films
SELECT AVG(budget) AS budget_moyen
FROM movie 


SELECT AVG(budget) AS budget_moyen_avant_1950
FROM movie 
WHERE release_date < '1950-01-01'
UNION
SELECT AVG(budget) AS budget_moyen_apres_1950
FROM movie 
WHERE release_date > '1950-01-01';

SELECT MIN(budget)
FROM movie
WHERE budget > 1000;

SELECT MAX(budget)
FROM movie

SELECT MAX(vote_average)
FROM movie
WHERE vote_count > 1000

SELECT count(*)
FROM movie

SELECT count(DISTINCT budget)
FROM movie

SELECT SUM(DISTINCT budget)
FROM movie;

--film avec la plus longue et la plus courte durée
SELECT
    MAX(runtime) AS longest_movie,
    MIN(runtime) AS shortest_movie
FROM
    movie;

--la somme totale des revenus de tous les films :
SELECT SUM(revenue) AS total_revenue FROM movie;

--si tous les films du genre Action on plus rapporté que ceux Comedie
SELECT
    'Action' AS genre,
    SUM(revenue) AS total_revenue
FROM
    movie
        JOIN
    movie_genres USING (movie_id)
        JOIN
    genre USING (genre_id)
WHERE
    genre_name = 'Action'

UNION

SELECT
    'Comedy' AS genre,
    SUM(revenue) AS total_revenue
FROM
    movie
        JOIN
    movie_genres USING (movie_id)
        JOIN
    genre USING (genre_id)
WHERE
    genre_name = 'Comedy';


--ecart type entre les revenus des films
SELECT STDDEV (revenue)
FROM movie

--variance des revenus des films
SELECT VAR_POP(revenue)
FROM movie

SELECT JSON_ARRAYAGG(title)
FROM (SELECT * FROM movie LIMIT 3) AS mymovie;


SELECT JSON_OBJECTAGG(title, vote_average)
FROM (SELECT * FROM movie LIMIT 3) AS mymovie;


SELECT GROUP_CONCAT(title ORDER BY budget DESC SEPARATOR ' - ')
FROM movie


SELECT GROUP_CONCAT(title ORDER BY budget DESC SEPARATOR ' - ')
FROM (SELECT * FROM movie LIMIT 5) AS persomovie;


SELECT person_name, COUNT(*) AS nbr_of_movies
FROM movie_crew mc
JOIN person p USING (person_id)
WHERE job = 'Director'
GROUP BY person_id
ORDER BY nbr_of_movies DESC

SELECT genre_name, COUNT (*) AS nbr_films, (SUM(m.revenue) / SUM(m.budget)) AS ROI
FROM movie_genres mg
JOIN genre g USING (genre_id)
JOIN movie m USING (movie_id)
WHERE m.budget > 0
GROUP BY genre_id
ORDER BY ROI DESC;

SELECT genre_name, COUNT (*) AS nbr_films
FROM movie_genres mg
JOIN genre g USING (genre_id)
GROUP BY genre_name
ORDER BY nbr_films DESC;

--revenu par genre et revenu
SELECT genre_name, SUM(revenue) AS total_revenue
FROM movie m
JOIN movie_genres mg USING (movie_id)
JOIN genre g USING (genre_id)
GROUP BY genre_name
ORDER BY total_revenue DESC;

--duree moyenne filme par genre et par duree
SELECT genre_name, AVG(runtime) AS average_runtime
FROM movie
JOIN movie_genres USING (movie_id)
JOIN genre g USING (genre_id)
GROUP BY genre_name
ORDER BY average_runtime DESC;

--nbre film par année et par genre et trie par nbr de film
SELECT 
YEAR(release_date) AS year, 
genre_name AS Genre, 
COUNT(*) AS nbr_films
FROM movie m
JOIN movie_genres mg USING (movie_id)
JOIN genre g USING (genre_id)
GROUP BY YEAR(release_date), genre_name
ORDER BY nbr_films DESC;

 /*extraire infos de genre d'un film et concatener en une seule chaine de caracatère
 pour chaque film*/
SELECT 
    title AS Titre, 
    GROUP_CONCAT(genre_name 
    SEPARATOR ' - ') AS Genres
FROM 
    movie_genres
JOIN 
    genre USING (genre_id)
JOIN 
    movie USING (movie_id)
GROUP BY movie_id
ORDER BY title;

-- tous les films et le nb d'acteurs pour chaque film y compris film ss acteurs// trie par nb acteurs
SELECT
    title AS titre,
    COUNT(DISTINCT person_id) AS nbr_acteurs
FROM
    movie
INNER JOIN
    movie_cast USING (movie_id)
GROUP BY 
    title, movie_id
ORDER BY nbr_acteurs DESC;

SELECT genre_name, COUNT (*) AS nbr_films, (SUM(m.revenue) / SUM(m.budget)) AS ROI
FROM movie_genres mg
JOIN genre g USING (genre_id)
JOIN movie m USING (movie_id)
WHERE m.budget > 0
GROUP BY genre_id
HAVING roi > 3
ORDER BY ROI DESC;


--DISCTINCT pour ne pas avoir de doublons
SELECT DISTINCT person_id
FROM movie_crew
WHERE movie_crew.job = 'Director'

SELECT 
    person_name, 
    (SUM(m.revenue) / SUM(m.budget)) AS roi, 
    COUNT(*) AS nbr_of_films
FROM movie_crew mc
JOIN person p USING (person_id)
JOIN movie m USING (movie_id)
WHERE mc.job = 'Director'
GROUP BY person_name
HAVING nbr_of_films > 15
ORDER BY roi DESC;

SELECT 
    YEAR(release_date) AS annee, 
    AVG(vote_average) AS note_moyenne,
    COUNT (*) AS nombre_de_films
FROM movie
WHERE vote_average IS NOT NULL  
GROUP BY YEAR(release_date)
HAVING note_moyenne > 7.5
ORDER BY note_moyenne DESC;

--genre avec moins de 200 films et tirez par nombre de films

SELECT
    genre_name,
    COUNT(*) AS nombre_de_films
FROM
    genre g 
JOIN
    movie_genres mg USING (genre_id)
GROUP BY
    genre_name
HAVING
    nombre_de_films < 200
ORDER BY
    nombre_de_films DESC;
 

-- genre dont revenu moyen > 100000000 et triez par revenu
SELECT 
    genre_name,
    AVG(revenue) AS revenu_moyen
FROM
     movie 
JOIN 
    movie_genres mg USING (movie_id)
Join genre USING (genre_id)
GROUP BY 
    genre_name
HAVING revenu_moyen > 100000000
ORDER BY revenu_moyen DESC;

-- Trouver les années ou la note moyenne est sup à 7.5 et triez par note

SELECT
    YEAR(release_date) AS annee,
    AVG(vote_average) AS note_moyenne
FROM
    movie
GROUP BY
    YEAR(release_date)
HAVING note_moyenne > 7.5
ORDER BY note_moyenne DESC;


SELECT
    YEAR(release_date) AS annee,
    AVG(vote_average) AS note_moyenne,
    COUNT(*) AS nombre_de_films,
    MIN(release_date) AS first_movie_of_year,
    MAX(release_date) AS last_movie_of_year,
    (SUM(revenue) - SUM(budget)) As revenu_of_year
FROM
    movie
WHERE release_date IS NOT NULL
GROUP BY
    YEAR(release_date) WITH ROLLUP
-- HAVING note_moyenne > 7.5
-- ORDER BY note_moyenne DESC;


/*revenu par année en filtrant pour année ss revenu et en triant par revenu.
obtenez total avec ROLLUP*/
SELECT 
    YEAR(release_date) AS annee,
    SUM(revenue) AS revenue_annuel
FROM
    movie
GROUP BY
    YEAR(release_date) WITH ROLLUP
HAVING revenue_annuel > 0
ORDER BY revenue_annuel DESC;

/*Duree moyenne film par année de sortie et par genre. AVec totaux pour chaque année
et total global*/

SELECT
    YEAR(release_date) AS annee,
    genre_name,
    AVG(runtime) AS duree_moyenne
FROM
    movie
JOIN
    movie_genres USING (movie_id)
JOIN
    genre USING (genre_id)
GROUP BY
    YEAR(release_date), genre_name WITH ROLLUP
ORDER BY
    YEAR(release_date);