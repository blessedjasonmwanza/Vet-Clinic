/* Database schema to keep the structure of entire database. */
-- \c vet_clinic
DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
    id INT PRIMARY KEY NOT NULL,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

INSERT INTO animals (id, name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES
(1, 'Agumon','2020-02-03',0,true,'10.23'),
(2, 'Gabumon','2018-11-15',2,true,'8'),
(3, 'Pikachu', '2021-01-07',1,false, '15.04'),
(4, 'Devimon', '2017-05-12', 5, true, '11');

-- INSERT 0 4