SELECT * FROM mysql.user;

-- modifier le mot de passe
ALTER USER mywebapp@'%' IDENTIFIED BY '1234';

-- supprimer un user
DROP USER mywebapp@'%';

SELECT CURRENT_USER();
SELECT * FROM mysql.user;

-- voir les permissions pour l'utilisateurs
SHOW GRANTS FOR mywebapp;

SHOW DATABASES;

-- autoriser mon nouveau user à voir ttes les databases
GRANT SHOW DATABASES ON *.* TO mywebapp;

-- Ajouter pour le select et les autres sur la table movie à mon user
GRANT SELECT, INSERT, UPDATE, DELETE ON movies.* TO mywebapp;

-- permet d'accord tous les privilèges à un user
-- a éviter cependant
GRANT ALL ON *.* TO mywebapp;

-- revoquer une permission
REVOKE DELETE ON movies.* FROM mywebapp;

-- CAS DES PRIVILEGES A DONNER EN GENERAL
GRANT SELECT, UPDATE, DELETE, INSERT on  movies.* TO mywebapp;

-- pour un admin car tous les privilèges
GRANT SELECT ALL ON *.* FROM mywebapp;

-- bloquer un user
ALTER USER mywebapp ACCOUNT LOCK;

-- debloquer un user
ALTER USER mywebapp ACCOUNT UNLOCK;

-- donner à votre user de creer des users avec ses meme privileges
GRANT SELECT ALL ON *.* FROM mywebapp WITH GRANT OPTION;



-- roles d'un utilisateur
CREATE ROLE access_movie;

-- attribution permission à ce role
GRANT SELECT ON movies.* TO access_movie;

-- creation d'un utilisateur test sans by il se connecte sans mdp
CREATE USER test;

-- attribuer le role access_movie à mon user test
GRANT access_movie TO test;

-- voir ce que font les roles
SHOW GRANTS FOR access_movie;

/*mysql> USE movies;
ERROR 1044 (42000): Access denied for user 'test'@'%' to database 'movies'
il doit alors renseigner son role actif :
SET ROLE access_movie;
puis il peut faire
USE movies;
*/

/*2eme possibilité : avoir le role actif à la connection :
*/

DROP USER test;
CREATE USER test;
GRANT access_movie TO test;

-- l'admin lui active directement son role 'ALL' represente les role par defaut ou
-- on peut directement ciblé le nom du role
SET DEFAULT ROLE access_movie TO test;

-- revoker un droit sur un role
REVOKE SELECT ON movies.* FROM access_movies;

-- supprimer un role
DROP role access_movie;