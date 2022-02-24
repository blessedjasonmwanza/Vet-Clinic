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