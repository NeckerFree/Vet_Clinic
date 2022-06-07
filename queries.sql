/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
select * from animals where name like '%mon';

-- List the name of all animals born between 2016 and 2019.
select name from animals where date_of_birth between '01-01-2016' and '12-31-2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
select name from animals where neutered =true and escape_attempts <3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
select date_of_birth from animals where name in ('Agumon','Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
select name, escape_attempts from animals where weight_kg > 10.5;

-- Find all animals that are neutered.
select * from animals where neutered =true;

--Find all animals not named Gabumon.
select * from animals where name !='Gabumon';

--Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
select * from animals where weight_kg between 10.4 and 17.3 ;



--query and update animals table
--update species column
Begin Transaction;
update animals set species='unspecified';
select * from animals;

--rollback previous change
Rollback Transaction; 
select * from animals;

-- Update the animals table by setting the species column to digimon
Begin Transaction;
update animals set species='digimon' where name like '%mon';
update animals set species='pokemon' where species is null;
Commit Transaction;

select * from animals;

-- delete all records in the animals table
Begin Transaction;
delete from animals;
select * from animals;

Rollback Transaction;
select * from animals;


--Delete all animals born after Jan 1st, 2022.
Begin Transaction;
delete from animals where date_of_birth > '01-01-2022';
select * from animals;
--Create a savepoint for the transaction.
SAVEPOINT restauration;
--Update all animals' weight to be their weight multiplied by -1.
update animals set weight_kg= weight_kg * -1;
--Rollback to the savepoint
ROLLBACK TO SAVEPOINT restauration;
--Update all animals' weights that are negative to be their weight multiplied by -1.
update animals set weight_kg= weight_kg * -1 where weight_kg <0;
--Commit transaction
Commit transaction;

select * from animals;


--How many animals are there?
select count(1) from animals;
Result: 10
--How many animals have never tried to escape?
select count(1) from animals where escape_attempts=0;
Result: 2
--What is the average weight of animals?
select AVG(weight_kg) from animals;
Result: 15.55
--Who escapes the most, neutered or not neutered animals?
select name from animals where escape_attempts =(select MAX(escape_attempts) from animals);
Result: 'Boarmon'
--What is the minimum and maximum weight of each type of animal?
select species, MIN(weight_kg), MAX(weight_kg) from animals group by species;
Result: 
"pokemon"	11	17
"digimon"	5.7	45
--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
select species, AVG(escape_attempts) from animals 
where date_of_birth between '01-01-1990' and '12-31-2000' group by species;
Result: 
"pokemon"	3.0