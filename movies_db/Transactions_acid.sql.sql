--recupérer une variable en particulier
SHOW VARIABLES LIKE 'autocommit';


--Demarrer une transaction
START TRANSACTION;
    INSERT INTO movie (title, budget, release_date)
    VALUES ('Lilo et Stitch', 100000000, '2025-05-21');

    INSERT INTO movie_languages
    VALUES(LAST_INSERT_ID(), 24574, 1);

    COMMIT;


--COMMIT; transmets tous

--ROLLBACK 'annuler les instructions'

SELECT *
FROM movie
WHERE title = 'Lilo et Stitch';

-- START TRANSACTION;

-- DELETE FROM movie_languages WHERE movie_id = 459498;
-- DELETE FROM movie_cast WHERE movie_id = 459498;
-- DELETE FROM movie_genres WHERE movie_id = 459498;

-- -- maintenant que toutes les dépendances sont supprimées :
-- DELETE FROM movie WHERE movie_id = 459498;

-- COMMIT;

--Demarrer une transaction
START TRANSACTION;
    INSERT INTO movie (title, budget, release_date)
    VALUES ('Lilo et Stitch 2', 150000000, '2025-07-01');

    INSERT INTO movie_languages
    VALUES(LAST_INSERT_ID(), 24574, 1);

    COMMIT;


SELECT *
FROM movie
WHERE title = 'Lilo et Stitch 2';

/*chaque instruction validée par individuellement par sa propre transaction
SET autocommit = 0; -- pour désactiver l'autocommit
SET autocommit = 1; -- pour activer l'autocommit
*/

/*Commande effectuée dans workbench
*SHOW VARIABLES LIKE 'transaction_isolation';
*SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
* nous on a laissé : 
* SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
*
*START TRANSACTION;
*USE movies;
*UPDATE movie
*SET budget = 10
*WHERE movie_id = 5;
*ROLLBACK;
*Le rollback permet de revenir en arrière
*SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
*SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
*START TRANSACTION;
*SELECT * FROM movie WHERE movie_id = 5;
*SELECT * FROM movie WHERE movie_id = 5;
*COMMIT;
*
*
*
*
*
*
*
*
************************************/