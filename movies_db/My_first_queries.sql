SHOW DATABASES;
USE movies;
SELECT * FROM movie;
SELECT title, vote_average FROM movie LIMIT 5, 5;

SELECT movie_id, title, vote_average, release_date FROM movie LIMIT 10;

SELECT movie_id, title, vote_average, release_date FROM movie WHERE movie_id = 5;

SELECT movie_id, title, vote_average, release_date FROM movie WHERE movie_id != 5;

SELECT movie_id, title, vote_average, release_date 
FROM 
    movie 
WHERE 
    vote_average >=8 
LIMIT 
10;

SELECT movie_id, title, vote_average, release_date 
FROM 
    movie 
WHERE 
    release_date >= '2000-01-01'
LIMIT 
10;

SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    release_date >= '2000-01-01' AND
    vote_average >= 7.5 AND
    vote_count > 10
LIMIT 
10;

SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    vote_average >= 9 OR
    vote_count > 1000
LIMIT 
10;


SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    vote_average >= 9 OR
    vote_count > 1000
LIMIT 
10;

SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    vote_average BETWEEN 6 AND 7
LIMIT 
10;

SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    release_date BETWEEN '2015-01-01' AND '2016-01-01'
LIMIT 
10;


SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    vote_average IN (6.00, 7.00, 8.00)
LIMIT 
10;


SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    vote_average IS NOT NULL
LIMIT 
10;

SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    release_date IS NULL
LIMIT 
10;

SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    NOT vote_average = 7.00
LIMIT 
10;

SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    title LIKE 'c_r%'
LIMIT 
10;

-- inverse la  queries du dessus
SELECT movie_id, title, vote_average, release_date, vote_count 
FROM 
    movie 
WHERE 
    title NOT LIKE 'c_r%'
LIMIT 
10;

SELECT movie_id, title, vote_average
FROM
    movie
WHERE
    vote_average >= 8.0
LIMIT
10;

SELECT movie_id, title, popularity, vote_count
FROM
    movie
WHERE
    popularity >= 140 AND
    vote_count >= 3000
LIMIT
10;

SELECT movie_id, title, runtime 
FROM 
    movie
WHERE
    runtime BETWEEN 90 AND 120
LIMIT
10;

SELECT movie_id, title, movie_status
FROM 
    movie
WHERE
    movie_status = 'Rumored' OR
    movie_status = 'Post Production'
LIMIT
10;

SELECT movie_id, title, overview
FROM
    movie
WHERE
    overview LIKE '%god%'
LIMIT
10;


SELECT movie_id, title, homepage
FROM
    movie
WHERE
    homepage IS NULL
LIMIT
10;

SELECT movie_id, title, movie_status
FROM
    movie
WHERE
    movie_status NOT IN ('Released')
LIMIT
10;

SELECT movie_id, title, release_date
FROM
    movie
WHERE
    release_date >= '2016-03-15'
LIMIT
10;

SELECT movie_id, title, budget, revenue
FROM
    movie
WHERE
    budget >=100000000 AND
    revenue >=300000000
LIMIT
10;
--NOT > AND > OR donc penser aux parenthèses
Select movie_id, title, vote_average, release_date, vote_count
FROM
    movie
WHERE
    vote_count > 500 AND
    (vote_average > 8 OR
    vote_average < 2)
LIMIT
100;

Select movie_id, title, vote_average, release_date, vote_count
FROM
    movie
WHERE
    NOT (title = 'fight club' OR title = 'Star wars')
LIMIT
100;

SELECT movie_id, title, vote_average, budget
FROM
    movie
WHERE
    budget > 50000000 AND
    vote_average > 7
LIMIT
10;

SELECT movie_id, title, budget, release_date, popularity
FROM
    movie
WHERE
    (budget > 100000000 AND
    release_date >= '2010-12-31') OR
    popularity > 100
LIMIT
10;

SELECT movie_id, title,movie_status, budget
FROM
    movie
WHERE
    movie_status != 'Post Production' AND
    budget > 250000000
LIMIT
10;

SELECT movie_id, title, vote_count, runtime 
FROM 
    movie 
WHERE
 title LIKE 'a%' AND
 (vote_count > 500 OR
 runtime < 120)
LIMIT
10;

SELECT movie_id, title, movie_status, vote_average
FROM 
    movie 
WHERE
    (movie_status != 'Cancelled' AND
    movie_status != 'Post Production') AND
 (vote_average < 5 OR
 vote_average > 8)
 LIMIT
10;

--requete du dessus corrigée

SELECT movie_id, title, movie_status, vote_average
FROM 
    movie 
WHERE
    movie_status NOT IN ('Cancelled', 'Post Production') AND
 (vote_average < 5 OR
 vote_average > 8)
 LIMIT
10;

--exemple avec un alias
SELECT movie_id, title AS titre, movie_status, vote_average AS Moyenne
FROM 
    movie 

 LIMIT
5;


SELECT title, budget, revenue, (revenue / budget) AS profit
FROM 
    movie 
WHERE
(revenue - budget) > 0
LIMIT
5;

SELECT movie_id, title, budget, revenue, (revenue - budget) AS profit 
FROM 
    movie 
WHERE (revenue - budget) > 1000000000
LIMIT
5;

SELECT movie_id, title, budget, revenue, (revenue / budget) AS ROI 
FROM movie
WHERE (revenue > 2 * budget) AND
    budget > 50000000
LIMIT 5;    


SELECT movie_id, title
FROM movie
WHERE 
 title REGEXP '^war'
LIMIT 5;



SELECT movie_id, title
FROM movie
WHERE 
 title REGEXP '\\blove\\b'
LIMIT 5;

SELECT movie_id, title
FROM 
 movie 
WHERE title REGEXP '^A';

SELECT movie_id, title
FROM 
movie 
WHERE title REGEXP '[A-Z]$';

SELECT movie_id, title 
FROM 
movie 
WHERE title REGEXP '^(Al|Be)'
LIMIT 10;

select movie_id, title
FROM
movie
WHERE
    title REGEXP '^the'
;

Select movie_id, title
FROM
movie
WHERE
    title REGEXP 'man$'
LIMIT 10;

SELECT movie_id, title
FROM
movie
WHERE
    title REGEXP '[a-eA-E]'
LIMIT 10;

SELECT movie_id, title
FROM movie
WHERE title REGEXP '^(Coll|Call)';
LIMIT 20;

SELECT movie_id, title
FROM movie
WHERE title REGEXP '^[o]{2}';
LIMIT 20;


SELECT movie_id, title
FROM movie
WHERE title REGEXP '^[^aeiou]';
LIMIT 20;

SELECT movie_id, title
FROM movie
WHERE title REGEXP '^(the|A)';
LIMIT 20;


SELECT title, vote_average
FROM movie
WHERE 
title REGEXP '^[a-z]' AND
vote_count > 500
ORDER BY 
 vote_average DESC, 
 title ASC
LIMIT 20;

SELECT title, popularity 
FROM movie 
ORDER BY popularity 
DESC, title ASC;

SELECT title, release_date, vote_average
FROM movie
ORDER BY
 release_date DESC, 
 vote_average DESC;



 SELECT title, (revenue - budget) AS profit
FROM movie
WHERE (revenue - budget) > 0
ORDER BY
 profit DESC, 
 title ASC;

 
 SELECT title
FROM movie
WHERE
 movie_id IN (
 SELECT movie_id 
 FROM movie_cast 
 WHERE character_name = 'Will Turner')
 ;

  SELECT title
FROM movie
WHERE
 movie_id IN (
 SELECT movie_id 
 FROM movie_cast 
 WHERE 
 character_name LIKE '%bilbo%')
 ;

  SELECT title
FROM movie
WHERE
 movie_id IN (
 SELECT movie_id 
 FROM movie_cast 
 WHERE 
 character_name LIKE '%the%')
 ;

