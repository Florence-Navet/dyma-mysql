-- Suppression de la base de données si elle existe
DROP DATABASE IF EXISTS mystore;


-- Création de la base de données avec jeux de caracteres et collation
CREATE DATABASE IF NOT EXISTS mystore DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_0900_as_cs;

-- Utilisation de la base
USE mystore;


-- Création de la table payment
CREATE TABLE IF NOT EXISTS payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    token VARCHAR(255) UNIQUE NOT NULL
);

-- Création de la table client
-- contrainte check verifier si elles soient valides avant de rentrer en bdd
CREATE TABLE IF NOT EXISTS client (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(45) NOT NULL,
    lastname VARCHAR(45) NOT NULL,
    email VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    age TINYINT UNSIGNED DEFAULT 0, -- pas besoin de UNIQUE ici
    payment_id INT,
    last_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT client_payment FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT verify_age CHECK (age > 18)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
;

-- rajouter un champ dans un table
ALTER TABLE client ADD creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- supprimer une colonne d'une table
ALTER TABLE client DROP creation_date;

-- modifier une colonne d'une table
ALTER TABLE client MODIFY COLUMN firstname VARCHAR(50) NOT NULL UNIQUE;

-- renommer une colonne d'une table
ALTER TABLE client RENAME COLUMN email TO email_pro;

-- changer l'ordre des colonnes
ALTER TABLE client MODIFY COLUMN firstname VARCHAR(50) NOT NULL UNIQUE AFTER lastname;
ALTER TABLE client MODIFY COLUMN firstname VARCHAR(50) NOT NULL UNIQUE AFTER client_id;

-- supprimer les contraintes
ALTER TABLE client DROP FOREIGn KEY client_payment;
-- rajouter une contraite
ALTER TABLE client ADD CONSTRAINT client_payment FOREIGN KEY
(payment_id) REFERENCES payment(payment_id) ON DELETE CASCADE ON UPDATE 
NO ACTION;

-- supprimer une table;
DROP TABLE client;

-- on verifie qu'il y a bien @ dans l'email
ALTER TABLE client 
ADD CONSTRAINT valid_email 
CHECK (email_pro LIKE '%@%');


ALTER TABLE client ADD CONSTRAINT category_check CHECK (category IN ('1', '2', '3'));

-- supprimer une contrainte
ALTER TABLE client DROP CHECK valid_email;

ALTER TABLE client CONVERT TO CHARACTER SET utf8mb4 
COLLATE utf8mb4_0900_ai_ci;




