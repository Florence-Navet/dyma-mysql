--curdate donne la date du jour
--curtime donne l'heure du jour courant
--now donne date et heure
SELECT  
    title,
    release_date,
    CURDATE(),
    CURTIME(),
    NOW()
FROM
    movie
--Date sur now extrait la date
SELECT  
    title,
    release_date,
    CURDATE(),
    CURTIME(),
    DATE(NOW())
FROM
    movie

--Date sur YEAR mais aussi month ou autre
SELECT  
    title,
    release_date
FROM
    movie
WHERE YEAR(release_date) = 1950

--après le 1er mai 1960 mais de 1960
SELECT  
    title,
    release_date
FROM
    movie
WHERE release_date > DATE('1960-05-01') AND YEAR(release_date) = 1960


--combien de jours ce sont écoulés depuis la sortie du film
SELECT
    title,
    release_date,
    DATEDIFF(CURRENT_DATE(), release_date) days_ago
FROM
    movie

--combien de jours ce sont écoulés depuis la sortie du film
-- en plus précis
SELECT
    title,
    release_date,
    TIMESTAMPDIFF(YEAR, release_date, CURRENT_DATE()) years_ago
FROM
    movie

--ajouter une periode à une date
SELECT
    title,
    release_date,
    ADDDATE(release_date, INTERVAL 1 YEAR)
FROM
    movie

--formatage des dates
SELECT
    title,
    DATE_FORMAT(release_date,'%W %d %M %Y') release_date_full
FROM
    movie;


--Trouver les fims sortis cet année
SELECT 
    title
    release_date
FROM 
    movie
WHERE YEAR(release_date) = YEAR(CURDATE());

--Calculer l'age moyen des films par genre
SELECT
    genre_name,
    ROUND(AVG(YEAR(CURRENT_DATE()) - YEAR(release_date)),0) age_moyen
FROM
    movie
    JOIN 
    movie_genres USING (movie_id)
    JOIN
    genre USING (genre_id)
GROUP BY genre_name;
