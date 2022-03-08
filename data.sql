/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
('Charmander','2020-02-08',0,false,'-11'),
('Plantmon','2022-11-15',2,true,'-5.7'),
('Squirtle', '1993-04-02',3,true, '-12.13'),
('Angemon', '2005-06-12', 1, true, '-45'),
('Boarmon', '2005-06-07', 7, true, '20.4'),
('Blossom', '1998-10-13', 3, true, '17');

-- INSERT 0 6

INSERT INTO owners (full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);
-- INSERT 0 6

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');
-- INSERT 0 2

UPDATE animals SET species_id = s.id FROM (SELECT id FROM species WHERE name LIKE 'Digimon') s WHERE name LIKE '%mon';
-- UPDATE 6

UPDATE animals SET species_id = s.id FROM (SELECT id FROM species WHERE name LIKE 'Pokemon') s WHERE name NOT LIKE '%mon';
-- UPDATE 4

UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Sam Smith') o WHERE name = 'Agumon';
UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Bob') o WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') o WHERE name IN ('Pikachu', 'Gabumon');
UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Melody Pond') o WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owners_id = o.id FROM (SELECT id FROM owners WHERE full_name = 'Dean Winchester') o WHERE name IN ('Angemon', 'Boarmon');


SELECT a.name AS animal, o.full_name AS owner FROM animals a LEFT JOIN owners o ON a.owners_id = o.id WHERE o.full_name = 'Melody Pond';
--    animal   |    owner    
-- ------------+-------------
--  Charmander | Melody Pond
--  Squirtle   | Melody Pond
--  Blossom    | Melody Pond
--  Charmander | Melody Pond
--  Squirtle   | Melody Pond
--  Blossom    | Melody Pond
-- (6 rows)

SELECT a.name AS animal, s.name AS belongs_to FROM animals a LEFT JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
--    animal   | belongs_to 
-- ------------+------------
--  Pikachu    | Pokemon
--  Charmander | Pokemon
--  Squirtle   | Pokemon
--  Blossom    | Pokemon
-- (4 rows)

SELECT o.full_name AS owner, a.name AS animal FROM animals a RIGHT JOIN owners o ON a.owners_id = o.id;
--       owner      |   animal   
-- -----------------+------------
--  Sam Smith       | Agumon
--  Bob             | Devimon
--  Bob             | Plantmon
--  Jennifer Orwell | Gabumon
--  Jennifer Orwell | Pikachu
--  Melody Pond     | Charmander
--  Melody Pond     | Squirtle
--  Melody Pond     | Blossom
--  Dean Winchester | Angemon
--  Dean Winchester | Boarmon
--  Jodie Whittaker 

SELECT s.name AS specie, COUNT(a.*) AS total FROM animals a LEFT JOIN species s ON a.species_id = s.id GROUP BY s.name;
--  specie  | total 
-- ---------+-------
--  Pokemon |     4
--  Digimon |     6
-- (2 rows)

SELECT o.full_name AS owner, a.name AS animal, s.name AS specie FROM animals a RIGHT JOIN species s  ON s.id = a.species_id RIGHT JOIN owners o ON a.owners_id = o.id WHERE s.name LIKE 'Digimon';
--       owner      |  animal  | specie  
-- -----------------+----------+---------
--  Sam Smith       | Agumon   | Digimon
--  Bob             | Devimon  | Digimon
--  Bob             | Plantmon | Digimon
--  Jennifer Orwell | Gabumon  | Digimon
--  Dean Winchester | Angemon  | Digimon
--  Dean Winchester | Boarmon  | Digimon
-- (6 rows)

SELECT a.name AS animal, o.full_name AS owned_by FROM animals a JOIN owners o ON a.owners_id = o.id WHERE o.full_name LIKE 'Dean Winchester' AND a.escape_attempts <= 0;
--  animal | owned_by 
-- --------+----------
-- (0 rows)

SELECT o.full_name AS owner, COUNT(a.*) AS total_animals FROM animals a RIGHT JOIN owners o ON a.owners_id = o.id GROUP BY o.full_name ORDER BY total_animals DESC LIMIT 1;
--     owner    | total_animals 
-- -------------+---------------
--  Melody Pond |             3
-- (1 row)

-- INSERT DATA FOR VETS
INSERT INTO vets(name,age,date_of_graduation) VALUES
('William Tatche', 45,'2000-04-23'),
(' Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez',64,'1981-05-04'),
('Jack Harkness', 38,'2008-06-08');
-- INSERT 0 4

-- INSERT DATA FOR SPECIALTIES
INSERT INTO specializations (species_id,vets_id) VALUES (1,1),(2,3),(1,3),(2,4);
-- INSERT 0 4

-- INSERT DATA FOR VISITS
INSERT INTO visits (animal_id,vet_id,date_visited) VALUES 
(1, 1, '2020-05-24'),(1, 3, '2020-07-22'),(2, 4, '2021-02-02'),(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),(3, 2, '2020-05-14'),(4, 2, '2021-05-04'),(5, 4, '2021-02-24'),
(6, 2, '2019-12-21'),(6, 1, '2020-08-10'),(6, 2, '2021-04-07'),(7, 3, '2019-09-29'),
(8, 4, '2020-10-03'),(8, 4, '2020-11-04'),(9, 2, '2019-01-24'),(9, 2, '2019-05-15'),
(9, 2, '2020-02-27'),(9, 2, '2020-08-03'),(10, 3, '2020-05-24'),(10, 1, '2021-01-11');
-- INSERT 0 20


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';