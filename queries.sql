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

-- query and update animals table
-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
select animals.name from animals join owners on animals.owner_id = owners.id; 
where owners.full_name='Melody Pond';
Result:
"Blossom"
"Squirtle"
"Charmander"

--List of all animals that are pokemon (their type is Pokemon)
select animals.name from animals join species on animals.species_id = species.id;
where species.name='Pokemon';
Result:
"Pikachu"
"Charmander"
"Squirtle"
"Blossom"

--List all owners and their animals, remember to include those that don't own any animal
select owners.full_name, animals.name from animals right join owners on animals.owner_id = owners.id;
Result: 
"full_name"	"name"

"Sam Smith"	"Agumon"
"Jennifer Orwell"	"Gabumon"
"Jennifer Orwell"	"Pikachu"
"Bob"	"Devimon"
"Bob"	"Plantmon"
"Melody Pond"	"Blossom"
"Melody Pond"	"Squirtle"
"Melody Pond"	"Charmander"
"Dean Winchester"	"Boarmon"
"Dean Winchester"	"Angemon"
"Jodie Whittaker"		

--How many animals are there per species?
select species.name, count(animals.id) from animals join species on animals.species_id = species.id 
group by species.name;
Result:
"name"	"count"

"Pokemon"	4
"Digimon"	6

--List all Digimon owned by Jennifer Orwell
select animals.name from animals 
join owners on animals.owner_id = owners.id 
join species on animals.species_id = species.id 
where owners.full_name='Jennifer Orwell'
and species.name='Digimon';
Result:
"name"

"Gabumon"

-- List all animals owned by Dean Winchester that haven't tried to escape
select animals.name from animals 
join owners on animals.owner_id = owners.id 
where owners.full_name='Dean Winchester'
and animals.escape_attempts=0;
Result:
Empty

--Who owns the most animals?
select owners.full_name, count(animals.id) from animals 
join owners on animals.owner_id = owners.id 
group by owners.full_name
order by count(animals.id) desc
limit 1;
Result:
"full_name"	"count"

"Melody Pond"	3

-- add "join table" for visits
-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
 select animals.name, visits.date_of_visit from animals join visits on animals.id=visits.animals_id
 join vets on vets.id =visits.vets_id
 where vets.name='William Tatcher'
 order by visits.date_of_visit desc
 limit 1;

 Result:
"name"	"date_of_visit"

"Blossom"	"2021-01-11"
-- How many different animals did Stephanie Mendez see?
select count(distinct (animals.name)) from animals 
join visits on animals.id=visits.animals_id
join vets on vets.id =visits.vets_id
where vets.name='Stephanie Mendez';
 Result:
 4
 -- List all vets and their specialties, including vets with no specialties.
 select vets.name as Vet_Name, specialties.name as Specialty from vets
left join (select specializations.vets_id, specializations.species_id, species.name 
		   from specializations 
		   join species on species.id= specializations.species_id) as specialties
on vets.id = specialties.vets_id

Result: 
"vet_name"	"specialty"

"Stephanie Mendez"	"Pokemon"
"William Tatcher"	"Pokemon"
"Jack Harkness"	"Digimon"
"Stephanie Mendez"	"Digimon"
"Maisy Smith"	
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
select distinct (animals.name), visits.date_of_visit 
from animals 
join visits on animals.id=visits.animals_id
join vets on vets.id =visits.vets_id
where vets.name='Stephanie Mendez'
and visits.date_of_visit between '04-01-2020' and '08-30-2020';
Result: 
"name"	"date_of_visit"

"Blossom"	"2020-05-24"
"Agumon"	"2020-07-22"
-- What animal has the most visits to vets?
select animals.name, count(animals.name)
from animals 
join visits on animals.id=visits.animals_id
join vets on vets.id =visits.vets_id
group by animals.name
order by 2 desc
limit 1

Result:
"name"	"count"

"Boarmon"	4
-- Who was Maisy Smith's first visit?
select distinct (animals.name), visits.date_of_visit 
from animals join visits on animals.id=visits.animals_id
join vets on vets.id =visits.vets_id
where vets.name='Maisy Smith'
order by visits.date_of_visit
limit 1
Result: 
"name"	"date_of_visit"

"Boarmon"	"2019-01-24"
-- Details for most recent visit: animal information, vet information, and date of visit.
select animals.*,vets.*, visits.date_of_visit 
from animals join visits on animals.id=visits.animals_id
join vets on vets.id =visits.vets_id
order by visits.date_of_visit desc 
limit 1
Result:
"id"	"name"	    "date_of_birth"	"escape_attempts"	"neutered"	"weight_kg"	"species_id"	"owner_id"	"id"	"name"	           "age"	"date_of_graduation"	"date_of_visit"

15	    "Devimon"	"2017-05-12"	 5	                 true	     11	         2	             3	         3	    "Stephanie Mendez"	64	    "1981-05-04"	        "2021-05-04"
-- How many visits were with a vet that did not specialize in that animal's species?
select count(1) as visits_not_specialized
from animals join visits on animals.id=visits.animals_id
join vets on vets.id =visits.vets_id
join specializations on specializations.vets_id= vets.id
join species on species.id= specializations.species_id
where animals.species_id != specializations.species_id 

Result:
"visits_not_specialized"
8
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
select distinct(species.name) as specialty, count(species.name)
from animals join visits on animals.id=visits.animals_id
join vets on vets.id =visits.vets_id
join species on species.id= animals.species_id
where vets.name='Maisy Smith'
group by species.name
order by count(species.name) desc
limit 1

Result:
"specialty"	"count"

"Digimon"	6