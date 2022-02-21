/*Queries that provide answers to the questions from all projects.*/


SELECT * FROM animals WHERE name LIKE '%mon';

--  id |  name   | date_of_birth | escape_attempts | neutered | weight 
-- ----+---------+---------------+-----------------+----------+--------
--   1 | Agumon  | 2020-02-03    |               0 | f        |  10.23
--   2 | Gabumon | 2018-11-15    |               2 | t        |      8
--   4 | Devimon | 2017-05-12    |               5 | t        |     11
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
--  Gabumon
-- (1 row)

SELECT date_of_birth FROM animals WHERE name LIKE 'Agumon' OR name LIKE 'Pikachu';

--  date_of_birth 
-- ---------------
--  2020-02-03
--  2021-01-07
-- (2 rows)

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

--   name   
-- ---------
--  Pikachu
--  Devimon
-- (2 rows)

SELECT * FROM animals WHERE neutered IS TRUE;

--  id |  name   | date_of_birth | escape_attempts | neutered | weight 
-- ----+---------+---------------+-----------------+----------+--------
--   2 | Gabumon | 2018-11-15    |               2 | t        |      8
--   4 | Devimon | 2017-05-12    |               5 | t        |     11
-- (2 rows)

SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

--  id |  name   | date_of_birth | escape_attempts | neutered | weight 
-- ----+---------+---------------+-----------------+----------+--------
--   1 | Agumon  | 2020-02-03    |               0 | f        |  10.23
--   3 | Pikachu | 2021-01-07    |               1 | f        |  15.04
--   4 | Devimon | 2017-05-12    |               5 | t        |     11
-- (3 rows)

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--  id |  name   | date_of_birth | escape_attempts | neutered | weight 
-- ----+---------+---------------+-----------------+----------+--------
--   3 | Pikachu | 2021-01-07    |               1 | f        |  15.04
--   4 | Devimon | 2017-05-12    |               5 | t        |     11
-- (2 rows)