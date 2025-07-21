BEGIN;

UPDATE movie_languages SET Language_id = NULL WHERE movie_id = 5;
UPDATE movie SET budget = 3 WHERE movie_id = 5;


COMMIT;