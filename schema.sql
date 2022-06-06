/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
id INT PRIMARY KEY NOT NULL,
name varchar(100) NOT NULL,
date_of_birth date,
escape_attempts INT NOT NULL,
neutered boolean,
weight_kg decimal
)