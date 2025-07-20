SELECT *
FROM movie
WHERE release_date IS NULL;


/*Ajouter une MINUTE
SELECT CURRENT TIMESTAMP() + INTERVAL 1 MINUTE*/

DROP EVENT IF EXISTS clear_empty_release_date_movie;


DELIMITER //

CREATE EVENT clear_empty_release_date_movie
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
BEGIN
    -- Supprimer les références dans les autres tables
    DELETE FROM movie_cast WHERE movie_id IN (
        SELECT movie_id FROM movie WHERE release_date IS NULL
    );

    DELETE FROM movie_genres WHERE movie_id IN (
        SELECT movie_id FROM movie WHERE release_date IS NULL
    );

    DELETE FROM movie_popularity_audit WHERE movie_id IN (
        SELECT movie_id FROM movie WHERE release_date IS NULL
    );

   
    DELETE FROM movie WHERE release_date IS NULL;
END//

DELIMITER ;

UPDATE movie
SET release_date = CURDATE()
WHERE movie_id = 380097;

SHOW VARIABLES LIKE 'event_scheduler';

SHOW EVENTS LIKE 'clear_empty_release_date_movie';





DELETE FROM movie
WHERE movie_id IN (459496, 459494);

DELETE FROM movie
WHERE movie_id IN (459495);


--liste les events
SHOW EVENTS;

--montre les events
SHOW EVENTS LIKE 'clear_%';

--modifie les events

DELETE FROM movie WHERE release_date IS NULL;

--CREATION Nouvel even----
CREATE EVENT clear_empty_release_date_movie
ON SCHEDULE AT CURRENT_TIMESTAMP() + INTERVAL 10 MINUTE
DO
    DELETE FROM movie
    WHERE release_date IS NULL;


--modifie les events
ALTER EVENT clear_empty_release_date_movie ON SCHEDULE EVERY 1 HOUR ;

--on peut desactiver l'event
ALTER EVENT clear_empty_release_date_movie DISABLE;

ALTER EVENT clear_empty_release_date_movie ENABLE;

-- DROP EVENT IF EXISTS clear_emply_release_movie;




