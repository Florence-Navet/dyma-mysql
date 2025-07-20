SELECT 
    title, 
    release_date,
    CASE
        WHEN YEAR(release_date) <= 2000 THEN 'Classique'
        WHEN YEAR(release_date) > 2000 AND YEAR
        (release_date) <= 2010 THEN 'Moderne'
        ELSE 'Récent'
        END category
FROM movie
ORDER BY release_date DESC

SELECT 
    title, 
    release_date,
    CASE
        WHEN YEAR(release_date) <= 2000 THEN 'Classique'
        WHEN YEAR(release_date) BETWEEN 2000 AND 2010 THEN 'Moderne'
        ELSE 'Récent'
        END category
FROM movie
ORDER BY release_date DESC



SELECT 
    title, 
    release_date,
    CASE
        WHEN vote_average <= 2 THEN 'Mauvais'
        WHEN vote_average <= 7 THEN 'Moyen'
        ELSE 'Excellent'
        END Avis
FROM movie
ORDER BY vote_average;

SELECT 
    title, 
    release_date,
    IF(revenue > budget, '+', '-') rentable
FROM movie
ORDER BY revenue < budget;



SELECT 
    title, 
    release_date,
    IFNULL(budget, 'unknown') date_de_sortie
FROM movie
WHERE release_date IS NULL


--classer les films par popularité
SELECT
    Title titre,
    popularity,
    CASE
        WHEN popularity < 5 THEN 'Inconnue'
        WHEN popularity BETWEEN 5 AND 15 THEN 'Peu Populaire'
        WHEN popularity BETWEEN 15 AND 21 THEN 'Moyenne'
        WHEN popularity BETWEEN 21 AND 62 THEN 'Populaire'
        WHEN popularity > 62 THEN 'Très populaire'
        END Classement_pop
FROM movie
ORDER BY title;

--differencier les films qui on generer des benef ou pas en prenant en compte budget et revenus
SELECT
    title,
    budget,
    revenue,
    IF(revenue > budget,
    'Beneficiaire',
    'Déficitaire') statut_financier
FROM
    movie
ORDER BY statut_financier DESC;







SELECT 
    title, 
    release_date,
    IF(revenue > budget, '+', '-') rentable
FROM movie
ORDER BY revenue < budget;