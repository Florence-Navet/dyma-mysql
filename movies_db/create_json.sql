ALTER TABLE person_cp ADD COLUMN meta JSON;
-- definir un objet dans une entree SQL
UPDATE person_cp
SET meta = '{
	"taille": 182,
    "poids": 122,
    "riche": true,
    "adresse": {
		"city": "new  york"
	},
	"favorite_fruits": ["pomme", "fraise", "banane"]
}'
WHERE person_id = 1;


UPDATE person_cp
SET meta = JSON_OBJECT (
"taille",
182,
"poids",
122,
"riche", 
true,
"adresse", 
JSON_OBJECT(
	"city",
	"new  york"
),
"favorite_fruits", 
JSON_ARRAY("pomme", "fraise", "banane")
)WHERE person_id = 2;