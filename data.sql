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



-- query and update animals table
--Insert the following data into the owners table:
INSERT INTO owners(full_name, age)	VALUES 
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

--Insert the following data into the species table:
INSERT INTO species(name)	VALUES 
	('Pokemon'),
	('Digimon'),	

--Modify your inserted animals so it includes the species_id value:
Begin Transaction;
update animals set species_id=(select id from species where name ='Digimon')
where name like '%mon';

update animals set species_id=(select id from species where name ='Pokemon')
where species_id isnull;
Commit Transaction;


--Modify your inserted animals to include owner information (owner_id):
Begin Transaction;
update animals set owner_id =(select id from owners where full_name='Sam Smith')
where name='Agumon';

update animals set owner_id =(select id from owners where full_name='Jennifer Orwell')
where name in ('Gabumon','Pikachu');

update animals set owner_id =(select id from owners where full_name='Bob')
where name in ('Devimon','Plantmon');

update animals set owner_id =(select id from owners where full_name='Melody Pond')
where name in ('Charmander','Squirtle','Blossom');

update animals set owner_id =(select id from owners where full_name='Dean Winchester')
where name in ('Angemon','Boarmon');
Commit Transaction;