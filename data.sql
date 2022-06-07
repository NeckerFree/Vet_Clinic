/* Populate database with sample data. */

INSERT INTO animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Agumon','02-03-2020', 0, true, 10.23);
	
INSERT INTO animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Gabumon','11-15-2018', 2, true, 8);

INSERT INTO animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Pikachu','01-07-2021', 1, false, 15.04);

INSERT INTO animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Devimon','05-12-2017', 5, true, 11);



--query and update animals table
--Insert the following data:
INSERT INTO animals(name, date_of_birth,weight_kg, neutered, escape_attempts)
VALUES
('Charmander','02-8-2020',-11,false, 0),
('Plantmon','11-15-2021',-5.7,true, 2),
('Squirtle','04-2-1993',-12.13,false, 3),
('Angemon','06-12-2005',-45,true,1),
('Boarmon','06-7-2005',20.4,true, 7),
('Blossom','10-13-1998',17, true,3),
('Ditto','05-14-2022',22,true,4);