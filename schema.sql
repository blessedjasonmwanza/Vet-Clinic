/* Database schema to keep the structure of entire database. */
-- \c vet_clinic
DROP TABLE IF EXISTS animals  CASCADE;

CREATE TABLE animals (
    id INT  PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,   
    weight_kg DECIMAL
);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
('Agumon','2020-02-03',0,true,'10.23'),
('Gabumon','2018-11-15',2,true,'8'),
('Pikachu', '2021-01-07',1,false, '15.04'),
('Devimon', '2017-05-12', 5, true, '11');

-- INSERT 0 4

ALTER TABLE animals ADD species varchar(255) NULL;

DROP TABLE IF EXISTS owners  CASCADE;

CREATE TABLE owners(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(255),
    age INT

);

DROP TABLE IF EXISTS species  CASCADE;
CREATE TABLE species(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255)
);

ALTER TABLE animals DROP species  CASCADE;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD CONSTRAINT species_id FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD  owners_id INT;
ALTER TABLE animals ADD CONSTRAINT owners_id FOREIGN KEY (owners_id) REFERENCES owners(id);

DROP TABLE IF EXISTS vets  CASCADE;
CREATE TABLE vets(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in 
-- multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
DROP TABLE IF EXISTS specializations  CASCADE;
CREATE TABLE specializations (
    species_id INT,
    vets_id INT
);
ALTER TABLE specializations ADD CONSTRAINT species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE specializations ADD CONSTRAINT vets FOREIGN KEY(vets_id) REFERENCES vets(id);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit 
-- multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_visited DATE
);
ALTER TABLE visits ADD CONSTRAINT animals FOREIGN KEY (animal_id) REFERENCES animals(id);
ALTER TABLE visits ADD CONSTRAINT vet FOREIGN KEY (vet_id) REFERENCES vets(id);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);