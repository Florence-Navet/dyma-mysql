-- pour drop index
DROP INDEX idx_title on movie;
DROP INDEX idx_release_date on movie;

-- pour voir tous les index
SHOW INDEXES FROM movie;

-- pour visualiser les index d'une table
SHOW INDEX FROM nom_de_la_table;

/*creer un index
CREATE [UNIQUE | FULLTEXT | SPATIAL] INDEX index_name
    ON tbl_name (key_part,...)
    [index_option]
    [algorithm_option | lock_option] ...*/

-- cree un index - car les titres sont trop longs on doit mettre un nombre
CREATE INDEX idx_title ON movie (title(768));

CREATE INDEX idx_release_date ON movie (release_date);

-- difference de performance sous le from en mettant USE INDEX() on force le DBMS a ne 
-- pas utiliser l'index
EXPLAIN 
SELECT  *
FROM movie
WHERE release_date > '2011-01-01';

CREATE INDEX idx_release_date ON movie (release_date);

-- creation d'un index pour la popularite
EXPLAIN 
SELECT  *
FROM movie
WHERE popularity > 50;
CREATE INDEX idx_popularity ON movie (popularity);


-- tri des personnes par nom
EXPLAIN 
SELECT  *
FROM person
-- USE INDEX()
ORDER BY person_name;



CREATE INDEX idx_person_name ON person (person_name);

-- liste des 10 derniers films sortis
EXPLAIN SELECT * FROM movie ORDER BY release_date DESC LIMIT 10;
-- compte des films avec une certaine date
EXPLAIN SELECT COUNT(*) FROM movie WHERE release_date < '2010-01-01';
-- recherche de film entre deux dates
EXPLAIN
SELECT *
FROM movie
WHERE release_date
BETWEEN '1994-01-01' AND '1995-01-01';

-- moyenne des revenus des films pour une année donnée
EXPLAIN
SELECT AVG(revenue)
FROM movie
WHERE YEAR(release_date) = 1998;


-- creation index multiples
CREATE INDEX idx_budget_popularity ON movie(budget, popularity);

-- utilisation idx budget_popularity
EXPLAIN
SELECT movie_id 
FROM movie
WHERE budget > 1000000 AND popularity > 10;

-- utilisation idx_popularity
EXPLAIN
SELECT movie_id 
FROM movie
WHERE budget > 1000000 AND popularity > 50;

-- index qui filtre popularity et release_date
CREATE INDEX idx_movie_popularity_release ON movie(popularity, release_date);
EXPLAIN SELECT * FROM movie ORDER BY popularity DESC, release_date DESC;

-- trouver des films avec un popularité par ordre de dates
EXPLAIN SELECT * FROM movie
WHERE popularity > 500
  AND release_date BETWEEN '2010-01-01' AND '2016-01-01'
ORDER BY release_date DESC;

-- selectionner les films les plus recents avec une popularité superieur à un seuil
EXPLAIN
SELECT *
FROM movie
WHERE popularity >= 200
ORDER BY release_date DESC, popularity DESC
LIMIT 10;

CREATE INDEX idx_title ON movie (title(2));



DROP INDEX idx_title ON movie;

EXPLAIN SELECT * FROM movie WHERE title LIKE 'love%';

-- recherche de films par un titre débutant par 'incept'
EXPLAIN SELECT * FROM movie WHERE title LIKE 'Incep%';
EXPLAIN SELECT * FROM movie WHERE title LIKE 'In%';

-- index textuels
CREATE FULLTEXT INDEX idx_overview ON movie (overview);
-- mode de recherche language naturel
SELECT *, MATCH(overview)AGAINST('war love') score
FROM movie
WHERE MATCH(overview) AGAINST('war love');

-- mode de recherche booleen le mot war aura plus d'imp que love
SELECT *,MATCH (overview)
AGAINST('+war love' IN BOOLEAN MODE) score
FROM movie
WHERE MATCH (overview)
AGAINST('+war love' IN BOOLEAN MODE);

SELECT movie_id, title, overview, MATCH(overview) AGAINST('space adventure') AS score
FROM movie
WHERE MATCH(overview) AGAINST('space adventure');

SELECT movie_id, title, overview
FROM movie
WHERE MATCH(overview) AGAINST('+space adventure' IN BOOLEAN MODE);

-- index ascendants et descendants
CREATE INDEX idx_popularity_desc ON movie(popularity DESC);
EXPLAIN
SELECT *
FROM movie
ORDER BY popularity DESC
LIMIT 10;


-- sur plusieurs champs
CREATE INDEX idx_vote_count_popularity ON movie(vote_count DESC, popularity ASC);

-- forcer utiliser index
EXPLAIN
SELECT title, vote_count, popularity
FROM movie
WHERE vote_count > 1000
ORDER BY vote_count DESC, popularity ASC;


