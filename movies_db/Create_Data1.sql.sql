SELECT title, popularity FROM copy_movie
WHERE movie_id IN (
    SELECT movie_id FROM movie_crew WHERE person_id = (
        SELECT person_id FROM person WHERE person_name = 'Harvey Weinstein'))

UPDATE movie_c
SET budget = budget / 2
WHERE movie_id IN (
	SELECT movie_id FROM movie_crew WHERE person_id IN
			(SELECT person_id FROM person WHERE person_name = 'Harvey Weinstein')
	);

SELECT title, budget FROM movie
WHERE movie_id IN (
    SELECT movie_id FROM movie_crew WHERE person_id IN
            (SELECT person_id FROM person WHERE person_name = 'Harvey Weinstein')
    );

UPDATE copy_movie
SET budget = budget / 2
WHERE movie_id IN (
    SELECT movie_id FROM movie_crew
    WHERE person_id IN (
        SELECT person_id FROM person WHERE person_name = 'Harvey Weinstein'
    )
)
OR movie_id IN (
    SELECT movie_id FROM movie_cast
    WHERE person_id IN (
        SELECT person_id FROM person WHERE person_name = 'Harvey Weinstein'
    )
);

SELECT title, budget FROM copy_movie
WHERE movie_id IN (
    SELECT movie_id FROM movie_crew
    WHERE person_id IN (
        SELECT person_id FROM person WHERE person_name = 'Harvey Weinstein'
    )
)

DELETE FROM copy_movie
WHERE movie_id = 459490;

SELECT * FROM copy_movie
WHERE title = 'Une vie de Chouquette' LIMIT 2;



DELETE FROM copy_movie
WHERE movie_id IN (
    SELECT movie_id FROM (
        SELECT movie_id FROM copy_movie WHERE title = 'K-PAX'
    ) AS supp
);

SELECT * FROM copy_movie
WHERE title = 'K-PAX';  


--DELETE ma table
-- DELETE FROM copy_movie;