/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
id SERIAL PRIMARY KEY,
name varchar(100) NOT NULL,
date_of_birth date,
escape_attempts INT NOT NULL,
neutered boolean,
weight_kg decimal
)

-- query and update animals table
-- Add a column species of type string
ALTER TABLE animals 
ADD COLUMN species VARCHAR NULL;


-- query multiple tables
create table owners (
    id SERIAL PRIMARY KEY,
    full_name varchar(100) NOT NULL,
    age INT NOT NULL
);

create table species (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

--Modify animals table
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT CONSTRAINT FK_animals_species REFERENCES species (id);
ALTER TABLE animals ADD COLUMN owner_id INT CONSTRAINT FK_animals_owners REFERENCES owners (id);