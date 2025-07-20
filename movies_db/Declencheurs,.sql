/*copie de la table person en une table person cop*/
CREATE TABLE `person_cp` (
    `person_id` int NOT NULL,
    `person_name` VARCHAR(500) DEFAULT NULL,
    PRIMARY KEY (`person_id`)
) ENGINe=innoDB DEFAULT CHARSET=utf8mb4 COLLATe=utf8mb4_0900_ai_ci;

/*recuperation de la table person pour la mettre dans la table person cp*/
INSERT INTO person_cp
SELECT * FROM person;

/*modification de la table*avec ajout colonne*/
ALTER TABLE 
    person_cp 
ADD COLUMN 
    nbr_of_movie SMALLINT DEFAULT 0
;

UPDATE person_cp
SET nbr_of_movie = (
    SELECT COUNT(*)
    FROM movie_cast
    WHERE person_id = person_cp.person_id
)
;

--person ayant fait le plus grand nb de films
SELECT *
FROM person_cp
ORDER BY nbr_of_movie DESC;


--insertion d'un nouveau film dans movie
INSERT INTO movie (title, budget)
VALUES ('En eaux troubles', 130000000)
;

INSERT INTO movie (title, popularity)
VALUES ('En eaux troubles', 12.5);

UPDATE movie
SET popularity = 12.5
WHERE title = 'En eaux troubles';

-- recuperer le dernier film ajoute
SELECT MAX(movie_id)
FROM movie
;

SELECT *
FROM movie
WHERE movie_id = 459493;

SELECT person_name
FROM person
WHERE person_name = 'Jason Statham'

SELECT person_id
FROM person
WHERE person_name = 'Jason Statham'

DROP TRIGGER IF EXISTS after_movie_cast_insert;
/*creation du trigger*/

DELIMITER //

CREATE TRIGGER after_movie_cast_insert
AFTER INSERT ON movie_cast
FOR EACH ROW
BEGIN
    UPDATE person_cp
    SET nbr_of_movie = nbr_of_movie + 1
    WHERE NEW.person_id = person_id;
END ;
DELIMITER ;

--declenchement du trigger
INSERT INTO movie_cast (movie_id, person_id, character_name)
VALUES (459493, 976, 'Jonas Taylor')

--supprimer la nouvelle entrée dans movie_cast

DELIMITER //
DROP TRIGGER IF EXISTS after_movie_cast_delete;
CREATE TRIGGER after_movie_cast_delete
AFTER DELETE ON movie_cast
FOR EACH ROW
BEGIN
    UPDATE person_cp
    SET nbr_of_movie = nbr_of_movie - 1
    WHERE OLD.person_id = person_id;
END;
DELIMITER ;

---pour declencher ce nouveau trigger
DELETE FROM movie_cast
WHERE movie_id = 459493

---------------------CREATION NOUVELLE TABLE POP------------------------------------
/*copie de la table person en une table person cop*/

DROP TABLE IF EXISTS movie_popularity_audit;

CREATE TABLE `movie_popularity_audit` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `movie_id` int NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `old_popularity` decimal(12, 6) DEFAULT NULL,
    `new_popularity` decimal(12, 6) DEFAULT NULL,
    `change_date` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

DROP TRIGGER IF EXISTS before_pop_movie_update;

DELIMITER //

CREATE TRIGGER before_pop_movie_update
BEFORE UPDATE ON movie
FOR EACH ROW
BEGIN
    IF OLD.popularity != NEW.popularity THEN
        INSERT INTO movie_popularity_audit (
            movie_id, title, old_popularity, new_popularity, change_date
        ) VALUES (
            OLD.movie_id, OLD.title, OLD.popularity, NEW.popularity, NOW()
        );
    END IF;
END //

DELIMITER ;

UPDATE movie SET popularity = popularity + 1 WHERE movie_id = 5;
UPDATE movie SET popularity = popularity + 2 WHERE movie_id = 459493;
UPDATE movie SET popularity = popularity -1 WHERE movie_id = 11;


SELECT * FROM movie_popularity_audit ORDER BY change_date DESC;

SHOW TRIGGERS WHERE `Trigger` = 'before_pop_movie_update';




SELECT movie_id, title, popularity FROM movie WHERE movie_id = 5;


--TEST POUR TRIGGER----


SELECT * FROM movie_popularity_audit ORDER BY change_date DESC;


SELECT * FROM movie_popularity_audit ORDER BY change_date DESC;


-- Voir un film avec son id
SELECT movie_id, title, popularity FROM movie;

-- Mettre à jour la popularité (modifie l'ID selon ton cas)
UPDATE movie
SET popularity = 42.123456 
WHERE movie_id = 5;

SELECT * FROM movie_popularity_audit WHERE movie_id = 5 ORDER BY change_date DESC;


-- Voir les logs
SELECT * FROM movie_popularity_audit ORDER BY change_date DESC;

-- --MAJ de la table en rajoutant une colone
-- ALTER TABLE movie_popularity_audit
-- ADD COLUMN title VARCHAR(255) NOT NULL AFTER movie_id



--test--
INSERT INTO movie (movie_id, title, popularity)
VALUES (9999, 'Film Test Trigger', 42.123456);

SELECT * FROM movie_popularity_audit ORDER BY change_date DESC;


--voir tous les triggers--
SHOW TRIGGERS;


SHOW PROCEDURES;

--requete pour supprimer les doublonS
DELETE FROM movie_popularity_audit
WHERE id NOT IN (
    SELECT * FROM (
        SELECT MAX(id)
        FROM movie_popularity_audit
        GROUP BY title
    ) AS latest
);


SELECT * FROM movie_popularity_audit ORDER BY change_date DESC;


SHOW TRIGGERS LIKE 'movi%';
SHOW TRIGGERS WHERE 'table' = 'movie_cast';

SHOW CREATE TRIGGER after_movie_cast_insert


DROP TRIGGER IF EXISTS after_movie_cast_insert;