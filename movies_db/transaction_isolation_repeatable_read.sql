SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT * FROM movie WHERE movie_id = 5;
SELECT * FROM movie WHERE movie_id = 5;
COMMIT;