-- faire des recherches sans passer par la table movie table principale
-- index couvrant
EXPLAIN
SELECT movie_id
FROM movie
WHERE popularity > 80;


EXPLAIN
SELECT movie_id, budget, popularity
FROM movie
WHERE budget > 1000000;

-- exemple d'index couvrant :
CREATE INDEX idx_movie_release_revenue ON movie(release_date, revenue);
-- requete pour cet index
EXPLAIN SELECT release_date, revenue FROM movie WHERE release_date BETWEEN '2016-01-01' AND '2016-12-31';
EXPLAIN SELECT SUM(revenue) FROM movie WHERE release_date >= '2012-05-01' AND release_date <= '2015-05-31';
EXPLAIN SELECT COUNT(*), AVG(revenue) FROM movie WHERE release_date >= '2010-01-01' AND release_date <= '2010-06-30';

