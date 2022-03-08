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



--Who was the last animal seen by William Tatcher?
SELECT vets.name, animals.name, date_visited FROM vets JOIN visits ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id WHERE vets.name ='William Tatcher' ORDER BY visits.date_visited DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(*) as total_animals from vets JOIN visits ON vets.id = visits.vet_id WHERE name='Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT 
	vets.name,
	species.name as specialization
from vets
LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN  species ON specializations.species_id = species.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name ,date_visited from animals 
JOIN visits ON animals.id= visits.animal_id JOIN vets ON vets.id=visits.vet_id
 WHERE vets.name= 'Stephanie Mendez' AND visits.date_visited BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name, COUNT(*) as total_visit from animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY total_visit DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, date_visited FROM vets JOIN visits ON vets.id=visits.vet_id
JOIN animals ON animals.id= visits.animal_id WHERE vets.name ='Maisy Smith' ORDER BY visits.date_visited ASC LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT
	date_visited,
	animals.date_of_birth as animal_dob,
	animals.escape_attempts,
	animals.neutered,
	animals.weight_kg as animal_weight,
	vets.name as vet_name,
	vets.age as vet_age,
	vets.date_of_graduation
from visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY date_visited DESC
LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
JOIN specializations ON specializations.vets_id = visits.vet_id
WHERE animals.species_id != specializations.species_id;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name as specialization , COUNT(visits.animal_id) from visits
JOIN vets ON vets.id = visits.vet_id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY species.name DESC 
LIMIT 1;

explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
--                                                                   QUERY PLAN                                                                  
-- ----------------------------------------------------------------------------------------------------------------------------------------------
--  Finalize Aggregate  (cost=415203.86..415203.87 rows=1 width=8) (actual time=69973.689..70445.780 rows=1 loops=1)
--    ->  Gather  (cost=415203.64..415203.85 rows=2 width=8) (actual time=69973.460..70445.762 rows=3 loops=1)
--          Workers Planned: 2
--          Workers Launched: 2
--          ->  Partial Aggregate  (cost=414203.64..414203.65 rows=1 width=8) (actual time=69943.226..69943.229 rows=1 loops=3)
--                ->  Parallel Seq Scan on visits  (cost=0.00..412007.98 rows=878265 width=0) (actual time=5.284..69862.241 rows=718857 loops=3)
--                      Filter: (animal_id = 4)
--                      Rows Removed by Filter: 12220571
--  Planning Time: 0.097 ms
--  JIT:
--    Functions: 14
--    Options: Inlining false, Optimization false, Expressions true, Deforming true
--    Timing: Generation 1.809 ms, Inlining 0.000 ms, Optimization 0.797 ms, Emission 14.587 ms, Total 17.192 ms
--  Execution Time: 70446.725 ms
-- (14 rows)

explain analyze SELECT * FROM visits where vet_id = 2;
--                                                        QUERY PLAN                                                       
-- ------------------------------------------------------------------------------------------------------------------------
--  Seq Scan on visits  (cost=0.00..695058.55 rows=4407178 width=12) (actual time=236.611..42283.244 rows=4313166 loops=1)
--    Filter: (vet_id = 2)
--    Rows Removed by Filter: 34505118
--  Planning Time: 0.102 ms
--  JIT:
--    Functions: 2
--    Options: Inlining true, Optimization true, Expressions true, Deforming true
--    Timing: Generation 41.602 ms, Inlining 207.539 ms, Optimization 22.460 ms, Emission 6.357 ms, Total 277.958 ms
--  Execution Time: 42516.058 ms
-- (9 rows)
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';
--                                                          QUERY PLAN                                                          
-- -----------------------------------------------------------------------------------------------------------------------------
--  Gather  (cost=1000.00..107119.18 rows=3 width=43) (actual time=1539.992..32825.427 rows=3 loops=1)
--    Workers Planned: 2
--    Workers Launched: 2
--    ->  Parallel Seq Scan on owners  (cost=0.00..106118.88 rows=1 width=43) (actual time=16451.403..27529.857 rows=1 loops=3)
--          Filter: ((email)::text = 'owner_18327@mail.com'::text)
--          Rows Removed by Filter: 2500005
--  Planning Time: 39.035 ms
--  JIT:
--    Functions: 6
--    Options: Inlining false, Optimization false, Expressions true, Deforming true
--    Timing: Generation 5.119 ms, Inlining 0.000 ms, Optimization 76.192 ms, Emission 781.019 ms, Total 862.331 ms
--  Execution Time: 32827.078 ms
-- (12 rows)
