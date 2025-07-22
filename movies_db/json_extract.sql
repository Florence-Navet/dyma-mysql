SELECT meta FROM person_cp
WHERE person_id = 2


SELECT JSON_EXTRACT(meta, "$.poids") FROM person_cp WHERE person_id = 1;

SELECT * 
FROM person_cp
WHERE meta -> "S.favorite_fruits" =  "pomme";


-- requete pour toutes les personnes  aimant les pommes dans le json
SELECT *
FROM person_cp
WHERE JSON_CONTAINS(meta->'$.favorite_fruits', '["pomme"]');

SELECT *
FROM person_cp
WHERE JSON_CONTAINS(meta, '"pomme"', "$.favorite_fruits");
