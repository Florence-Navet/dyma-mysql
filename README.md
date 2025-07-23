# dyma-mysql
Dyma formation MySQL 

## Installation  
1. Vscode  
2. - MySQL -> MySQLCommunity(GPL) Download  
   - MySQLInstaller for Windows  
   - dernière version -> msi installer -> download et faire 'no thanks'
   - double click  
   - Custom benck  
     * MySQL Server8.0 :  
       version 8.0  
     * Application : 
       MySQLWorkBench dernière version  
   - next
   - execute
   - next
   - next
   - laisser port par defaut 336  
   - next : strong password  
   - Entrer MDP : deux fois '123456'  
   - next  
   - Nom service : MySQL80  
   - next  
   - Execute  
   - Finish  
   - next  
   - Finish  

---  

## Connection à MySql

```bash
mysql -u nom_user -pmotdepasse
SHOW DATABASES;
USE nom_datase;
```   
Aller dans dans son fichier mysql et lancer sa queries  

---  

## Création UML DATABASES  
  
1. creation sur Draw.io  
```
https://app.diagrams.net/
```  
  
2. modélisation sur workbench de son ULM  
puis  
- Database -> Forward Engineer  
- Utiliser connection -> 'Localhost'  ou sur un 'server distant'  
- puis sur 3 fois et close.  


## Synchroniser UML et BDD  
  
1. Modifier sa table  
2. Database puis 'Synchronize Model' puis next 
   il propose ma BDD, il me montre tous les éléments qui
   font être potentiel être modifiés, il va dropper toutes
   les FK et remettre en place les différentes contraintes.  
   On close.