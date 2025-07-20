
--Round avec 0 pour la partie entiere, 1 un nb après la virgule, etc
SELECT 
    title,
    ROUND((revenue / budget),0) AS ROI 
FROM
    movie
WHERE budget > 1000000 AND revenue > 0
ORDER BY ROI DESC;

SELECT 
    title,
    ROUND((revenue / budget),0) AS ROI,
    ROUND (RAND()*100,0) ale
FROM
    movie
WHERE budget > 1000000 AND revenue > 0
ORDER BY ale;


--tri aléatoire
SELECT 
    title,
    ROUND((revenue / budget),0) AS ROI
FROM
    movie
WHERE budget > 1000000 AND revenue > 0
ORDER BY RAND();

SELECT 
    title,
    CEIL((revenue / budget)) AS ROI
FROM
    movie
WHERE budget > 1000000 AND revenue > 0
;


SELECT 
    title,
    FLOOR((revenue / budget)) AS ROI
FROM
    movie
WHERE budget > 1000000 AND revenue > 0
;