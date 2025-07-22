--voir les valeurs des variables
SHOW VARIABLES;

--Selectionner une variable en particulier systeme
SELECT @@global.version;

SELECt @@global.wait_timeout


--pour definir les variables utilisateur
-- SET @mavariable = 123;

--pour recuperer ma variable
SELECT @mavariable;

--creation de deux variables
-- SELECT title, release_date INTO @title, @release_date
-- FROM movie
-- ORDER BY RAND()
-- LIMIT 1;

--Affichage de ces variables
SELECT @title, @release_date;
SET @release_year = YEAR((SELECT @release_date));
SELECT * 
FROM movie
WHERE YEAR(release_date) = @release_year

SELECt @release_year

--recuperer le film avec le plus gros budget
SELECT 
    MAX(budget) AS plus_gros_budget
INTO 
    @max_budget
FROM
    movie
;

--utiliser la variable pour recuperer le titre du film - stockage de valeurs agrégées
SELECT
    title, budget
FROM
    movie
WHERE
    budget = @max_budget
;
/*recuperer dans une variable le nombre de films*/
SELECT 
    COUNT(*) INTO @nombre_total_films FROM movie;

SELECt @nombre_total_films;


/*utilisations d'une année de recherche*/
SET @année_de_recherche = 2001;
SELECT * FROM movie WHERE YEAR(release_date) = @annee_de_recherche;

/*Stockage de valeurs en requetes*/

SET @id_film = (
    SELECT movie_id
    FROM copy_movie
    WHERE title = 'Une vie de Chouquette'
);

-- Si revenue est NULL, on l'initialise à 1 000 000
UPDATE copy_movie
SET revenue = 1000000
WHERE movie_id = @id_film AND revenue IS NULL;

UPDATE copy_movie SET revenue = revenue * 1.1 WHERE movie_id = @id_film;

SELECT title, revenue
FROM copy_movie
WHERE title = 'Une vie de Chouquette';

SELECT movie_id, title, revenue
FROM copy_movie
ORDER BY revenue DESC;

SELECT title
FROM copy_movie
WHERE title LIKE '%chouquette%';

-- Déclare la variable
SET @id_film = (
    SELECT movie_id
    FROM copy_movie
    WHERE title = 'Une vie de Chouquette'
);

--procédure
DELIMITER //

CREATE PROCEDURE ten_best_recent_movies ()
BEGIN
    SELECT 
        title,
        overview,
        vote_average
    FROM movie
    WHERE YEAR(release_date) > 2015 AND vote_count > 100
    ORDER BY vote_average DESC
    LIMIT 10;
END

DELIMITER ;

--lister des films et leurs statut de production en faisant une procédure

DELIMITER //

CREATE PROCEDURE ListerStatutFilms()
BEGIN
    SELECT
        title,
        movie_status
    FROM
        movie;
END

DELIMITER ;

--Lister des personnes et leur role le plus recent dans un film
DELIMITER //

CREATE PROCEDURE DernierRoleParPersonne()
BEGIN
    SELECT
        p.person_name AS nom_personne,
        m.title AS titre_dernier_film
    FROM 
        person p
    JOIN (
        SELECT 
            person_id,
            MAX(movie_id) AS dernier_film_id
        FROM
            movie_cast 
        GROUP BY person_id
    ) AS dernier_film_joué_personne
        ON p.person_id = dernier_film_joué_personne.person_id
    JOIN movie m 
        ON m.movie_id = dernier_film_joué_personne.dernier_film_id;
END;

DELIMITER ;




--pour appeller ma procedure 
CALL ma_procedure();
CALL ten_best_recent_movies();

CALL ListerStatutFilms();


CALL DernierRoleParPersonne();


--creation procedure best movie par genre
DELIMITER //

CREATE PROCEDURE ten_best_recent_movies_per_genre(
    IN genreName VARCHAR(255)
)
BEGIN
    SELECT title, overview, vote_average
    FROM movie
    JOIN movie_genres USING(movie_id)
    JOIN genre USING(genre_id)
    WHERE 
        YEAR(release_date) > 2015 
        AND vote_count > 100 
        AND genre_name = genreName
    ORDER BY vote_average DESC
    LIMIT 10;
END //

DELIMITER ;

CALL ten_best_recent_movies_per_genre('Horror');

DROP PROCEDURE ten_best_recent_movies_per_genre;

--creation procedure best movie par genre avec paramètre pour stocker info
DELIMITER //

CREATE PROCEDURE ten_best_recent_movies_per_genre(
    IN genreName VARCHAR(255),
    OUT best_movie_title VARCHAR(255)
)
BEGIN
    SELECT title INTO best_movie_title
    FROM movie
    JOIN movie_genres USING (movie_id)
    JOIN genre USING (genre_id)
    WHERE 
        YEAR(release_date) > 2015 
        AND vote_count > 100 
        AND genre_name = genreName
    ORDER BY vote_average DESC
    LIMIT 1;

    SELECT title, overview, vote_average
    FROM movie
    JOIN movie_genres USING(movie_id)
    JOIN genre USING(genre_id)
    WHERE 
        YEAR(release_date) > 2015 
        AND vote_count > 100 
        AND genre_name = genreName
    ORDER BY vote_average DESC
    LIMIT 10;
END //

DELIMITER ;

CALL ten_best_recent_movies_per_genre ('Fantasy', @best_movie);

SELECT @best_movie;

--utilisation  variable locale
DELIMITER //
CREATE PROCEDURE max_budget_movie_title(IN year_movie VARCHAR(10))
BEGIN

    DECLARE max_budget int;

    SELECT MAX(budget) INTO max_budget
    FROM movie
    WHERE YEAR(release_date) = year_movie;

    SELECT title
    FROM movie
    WHERE budget = max_budget AND YEAR(release_date) = year_movie;

END //


DELIMITER;

CALL max_budget_movie_title(2000);

--
DELIMITER //

CREATE PROCEDURE FindLatestMovieByDirector(IN directorName VARCHAR(255))
BEGIN
  -- Déclaration de variables locales pour stocker l'ID et le titre du dernier film
  DECLARE latestMovieID INT;
  DECLARE latestMovieTitle VARCHAR(255);
  DECLARE latestMovieReleaseDate DATE;

  -- Recherche de l'ID du film le plus récent du réalisateur donné
  SELECT movie_id, title, MAX(release_date) INTO latestMovieID, latestMovieTitle, latestMovieReleaseDate
  FROM movie
  JOIN movie_crew USING(movie_id)
  JOIN person USING(person_id)
  WHERE person_name = directorName AND job = 'Director'
  GROUP BY movie_id
  ORDER BY release_date DESC
  LIMIT 1;

  -- Affichage des détails du dernier film
  SELECT latestMovieID AS 'ID', latestMovieTitle AS 'Title', latestMovieReleaseDate AS 'Release Date';
END //

DELIMITER ;
CALL FindLatestMovieByDirector('Christopher Nolan');


-- declenchement des erreurs S
DELIMITER //

CREATE PROCEDURE get_random_horror_movie (IN age SMALLINT)
BEGIN
    IF age IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vous devez renseigner votre âge';
    END IF;

    IF age < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vous devez avoir au moins 18 ans';
    END IF;

    SELECT *
    FROM movie
    JOIN movie_genres USING (movie_id)
    JOIN genre USING (genre_id)
    WHERE genre_name = 'Horror'
    ORDER BY RAND()
    LIMIT 1;
END //

DELIMITER ;


CALL get_random_horror_movie(NULL);

CALL get_random_horror_movie(17)

CALL get_random_horror_movie(25);

--Fonctions stockées
DELIMITER //
CREATE FUNCTION movieQuality(vote_average DECIMAL (4,2))
RETURNS VARCHAR (50)
DETERMINISTIC
BEGIN
    DECLARE quality VARCHAR(50);

    IF vote_average < 2 THEN
        SET quality = 'Horrible';
    ELSEIF vote_average < 7 THEN
        SET quality = 'Moyen';
    ELSE
        SET quality = 'Excellent';
    END IF;

    RETURN quality;
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION movieYearAgo(release_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, release_date, CURDATE());
END //
DELIMITER ;

--Trouver l'age d'un film

DELIMITER //

CREATE FUNCTION GetMovieAge(titre VARCHAR(1000))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE release_year INT;
    SELECT YEAR(release_date) INTO release_year FROM movie WHERE title = titre;
    RETURN YEAR(CURRENT_DATE) - release_year;
END //

DELIMITER ;






SELECT title, movieQuality(vote_average), movieYearAgo(release_date)
FROM movie

SELECT title, GetMovieAge(title) FROM movie;