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

-- add "join table" for visits
-- Create a table named vets
create table vets(
id SERIAL PRIMARY KEY,
name varchar(100) NOT NULL,
age INT NOT NULL,
date_of_graduation date
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, 
-- and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
create table specializations(
    species_id INT CONSTRAINT FK_species REFERENCES species(id),
    vets_id INT CONSTRAINT FK_vets REFERENCES vets(id),
    PRIMARY KEY (species_id, vets_id)
);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. 
-- Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.

create table visits(
    animals_id INT CONSTRAINT FK_animals REFERENCES animals(id),
    vets_id INT CONSTRAINT FK_vets REFERENCES vets(id),
    date_of_visit date
);

-- database performance audit

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

--Run the following statements to add data to your database (executing them might take a few minutes):

CREATE INDEX animals_id_idx ON visits (animals_id);

CREATE INDEX vets_id_idx ON visits (vets_id ASC);

CREATE INDEX email_idx ON owners (email);