SELECT title, budget
FROM movie
WHERE movie_id IN (
    SELECT movie_id
    FROM movie_company
    JOIN production_company USING (company_id)
    WHERE company_name = 'Lucasfilm'
);


SELECT title, budget
FROM movie
WHERE movie_id = ANY (
    SELECT movie_id
    FROM movie_company
    JOIN production_company USING (company_id)
    WHERE company_name = 'Lucasfilm'
);


SELECT title, budget
FROM movie
WHERE budget < ANY (
    SELECT budget
    FROM movie_company
    JOIN production_company USING (company_id)
    JOIN movie USING(movie_id)
    WHERE company_name = 'Lucasfilm' 
    AND budget > 0
) AND budget;

SELECT title,
        budget
FROM movie_company
JOIN production_company USING(company_id)
JOIN movie USING(movie_id)
WHERE company_name = 'Lucasfilm' AND budget > 0
ORDER BY budget DESC;

SELECT title,
        budget
FROM movie_company
JOIN production_company USING(company_id)
JOIN movie USING(movie_id)
WHERE company_name = 'Lucasfilm' AND budget > 0
ORDER BY budget;

--avec all budget superieur a toute la selection
SELECT title, budget
FROM movie
WHERE budget < ALL (
    SELECT budget
    FROM movie_company
    JOIN production_company USING (company_id)
    JOIN movie USING(movie_id)
    WHERE company_name = 'Lucasfilm' 
    AND budget > 0
) AND budget;

--entree pas terrible ou on a pas le casting
SELECT title
FROM movie
WHERE NOT EXISTS (
    SELECT *
    FROM movie_cast
    WHERE movie_id = movie.movie_id
)

/*film ayant un budget sup à celui realise par un film de Christopher Nolan*/
SELECT 
    title, 
    budget
FROM movie
WHERE budget > ANY (
    SELECT movie.budget
    FROM movie
    JOIN movie_crew ON movie.movie_id = movie_crew.movie_id
    JOIN person ON movie_crew.person_id = person.person_id
    WHERE person_name = 'Christopher Nolan' AND job = 'Director'
);

