-- INSERT INTO movie (title, budget,release_date, vote_average, vote_count)
-- VALUES('Un vie de Chouquette', 20000, '2025-06-01', 6.5, 600);

SELECT * FROM movie
ORDER BY movie_id DESC LIMIT 3;

-- INSERT INTO movie (title, budget,release_date, vote_average, vote_count, movie_id)
-- VALUES('Un vie de Chouquette 2', 20000, '2025-07-01', 6.5, 600,459491)
-- ;

INSERT INTO production_company
VALUES (95064, 'Chouquette Productions')

SELECT * FROM production_company
ORDER BY company_id DESC LIMIT 1;

INSERT INTO production_company (company_id, company_name)
VALUES (95065, 'Monster Inc !'), 
       (95066, 'New Company'),
       (95067, 'Twins Produc');

CREATE TABLE korean_movie (
    movie_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    release_date DATETIME NULL,
    title VARCHAR(255) NULL
  );

  INSERT INTO korean_movie (movie_id, release_date, title)
  SELECT NULL, release_date, title
  FROM movie
  WHERE release_date < '1950-01-01'

SELECT * FROM movie WHERE title = 'Une vie de Chouquette';

-- UPDATE movie
-- SET vote_average = 9.5, vote_count = 5500
-- WHERE title = 'Un vie de Chouquette';

UPDATE movie
SET title = 'Une vie de Chouquette'
WHERE title = 'Un vie de Chouquette';

SELECT * FROM movie
WHERE title = 'Une vie de Chouquette' limit 2;


--copie table movie
CREATE TABLE `copy_movie` (
    `movie_id` int NOT NULL AUTO_INCREMENT,
    `title` varchar(1000) DEFAULT NULL,
    `budget` int DEFAULT NULL,
    `homepage` varchar(1000) DEFAULT NULL,
    `overview` varchar(1000) DEFAULT NULL,
    `popularity` decimal(12, 6) DEFAULT NULL,
    `release_date` date DEFAULT NULL,
    `revenue` bigint DEFAULT NULL,
    `runtime` int DEFAULT NULL,
    `movie_status` varchar(50) DEFAULT NULL,
    `tagline` varchar(1000) DEFAULT NULL,
    `vote_average` decimal(4, 2) DEFAULT NULL,
    `vote_count` int DEFAULT NULL,
    PRIMARY KEY (`movie_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 459492 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci


-- INSERT INTO copy_movie
-- SELECT * FROM movie;

SELECT * FROM person
WHERE person_name LIKE '%weinstein%';

UPDATE copy_movie
SET popularity = popularity - 10
WHERE movie_id IN (
    SELECT movie_id FROM movie_crew WHERE person_id = (
        SELECT person_id FROM person WHERE person_name = 'Harvey Weinstein'))
