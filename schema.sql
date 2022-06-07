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