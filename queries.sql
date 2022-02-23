/*Queries that provide answers to the questions from all projects.
 COMMENTS ARE RESULTS RUN on data inserted form schema only.
*/


SELECT * FROM animals WHERE name LIKE '%mon';

--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8
--   4 | Devimon | 2017-05-12    |               5 | t        |        11
-- (3 rows)

SELECT name FROM animals WHERE CAST(to_char(date_of_birth, 'YYYY') AS INTEGER) BETWEEN 2016 AND 2019;

--   name   
-- ---------
--  Gabumon
--  Devimon
-- (2 rows)

SELECT name FROM animals WHERE  neutered IS TRUE AND escape_attempts < 3;

--   name   
-- ---------
--  Agumon
--  Gabumon
-- (2 rows)

SELECT date_of_birth FROM animals WHERE name LIKE 'Agumon' OR name LIKE 'Pikachu';

--  date_of_birth 
-- ---------------
--  2020-02-03
--  2021-01-07
-- (2 rows)

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

--   name   | escape_attempts 
-- ---------+-----------------
--  Pikachu |               1
--  Devimon |               5
-- (2 rows)

SELECT * FROM animals WHERE neutered IS TRUE;

--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8
--   4 | Devimon | 2017-05-12    |               5 | t        |        11
-- (3 rows)

SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04
--   4 | Devimon | 2017-05-12    |               5 | t        |        11
-- (3 rows)

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg 
-- ----+---------+---------------+-----------------+----------+-----------
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04
--   4 | Devimon | 2017-05-12    |               5 | t        |        11
-- (2 rows)

-- Transactions
BEGIN;

UPDATE animals SET species =' unspecified';
-- UPDATE 4


SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg |   species    
-- ----+---------+---------------+-----------------+----------+-----------+--------------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 |  unspecified
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 |  unspecified
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04 |  unspecified
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 |  unspecified
-- (4 rows)

ROLLBACK;

SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | 
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | 
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04 | 
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | 
-- (4 rows)

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04 | 
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
-- (4 rows)

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04 | 
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
-- (4 rows)

COMMIT;

SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04 | 
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
-- (4 rows)

BEGIN;

DELETE FROM animals;
-- DELETE 4

SELECT * FROM animals;
--  id | name | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+------+---------------+-----------------+----------+-----------+---------
-- (0 rows)

ROLLBACK;

SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04 | pokemon
-- (4 rows)

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04 | pokemon
-- (4 rows)

SAVEPOINT sp1;

UPDATE animals SET weight_kg = (weight_kg * -1);

SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon  | 2020-02-03    |               0 | t        |    -10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |        -8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |       -11 | digimon
--   3 | Pikachu | 2021-01-07    |               1 | f        |    -15.04 | pokemon
-- (4 rows)

ROLLBACK TO sp1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

SELECT * FROM animals;
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
--   3 | Pikachu | 2021-01-07    |               1 | f        |     15.04 | pokemon
-- (4 rows)

-- How many animals are there
SELECT COUNT(*) total_animals FROM animals;
--  total_animals 
-- ---------------
--              4
-- (1 row)

-- How many animals have never tried to escape?
SELECT COUNT(*) as never_escpaed FROM animals WHERE escape_attempts = 0;
--  never_escpaed 
-- ---------------
--              1
-- (1 row)

-- What is the average weight of animals?
SELECT AVG(weight_kg) as average_weight FROM animals;
--    average_weight    
-- ---------------------
--  11.0675000000000000
-- (1 row)

-- Who escapes the most, neutered or not neutered animals?
SELECT name, MAX(escape_attempts) as max FROM animals GROUP BY neutered, name ORDER BY max DESC LIMIT 1;
--  Devimon |   5
-- (1 row)

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg) as max_weigth, MIN(weight_kg) AS min_weight FROM animals GROUP by species;
--  species | max_weigth | min_weight 
-- ---------+------------+------------
--  pokemon |      15.04 |      15.04
--  digimon |         11 |          8
-- (2 rows)

SELECT species, AVG(escape_attempts) AS avg_escapes  FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;

--  avg_escapes 
-- -------------
            
-- (1 row) 
-- NB commented output sampples changes when data.sql is run
