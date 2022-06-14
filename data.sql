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

-- add "join table" for visits
-- Insert the following data for vets:
INSERT INTO vets(name, age, date_of_graduation) VALUES 
('William Tatcher', 45, '04-23-2000'),
('Maisy Smith', 26, '01-17-2019'),
('Stephanie Mendez', 64, '05-04-1981'),
('Jack Harkness', 38, '06-08-2008');

-- Insert the following data for specialties:
INSERT INTO specializations(species_id, vets_id) 
--Vet William Tatcher is specialized in Pokemon.
SELECT t1.id, t2.id 
FROM (select id from species where name='Pokemon') AS t1
FULL JOIN (select id from vets where name='William Tatcher') AS t2
ON true
union
--Vet Stephanie Mendez is specialized in Digimon and Pokemon.
SELECT t1.id, t2.id 
FROM (select id from species where name='Digimon') AS t1
FULL JOIN (select id from vets where name='Stephanie Mendez') AS t2
ON true
union
SELECT t1.id, t2.id 
FROM (select id from species where name='Pokemon') AS t1
FULL JOIN (select id from vets where name='Stephanie Mendez') AS t2
ON true
union
--Vet Jack Harkness is specialized in Digimon.
SELECT t1.id, t2.id 
FROM (select id from species where name='Digimon') AS t1
FULL JOIN (select id from vets where name='Jack Harkness') AS t2
ON true;

--Insert the following data for visits:

INSERT INTO public.visits(animals_id, vets_id, date_of_visit)
--Agumon visited William Tatcher on May 24th, 2020.
SELECT t1.id, t2.id, '05-24-2020' 
FROM (select id from animals where name='Agumon') AS t1
FULL JOIN (select id from vets where name='William Tatcher') AS t2
ON true
union 
--Agumon visited Stephanie Mendez on Jul 22th, 2020.
SELECT t1.id, t2.id, TO_DATE('07-22-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Agumon') AS t1
FULL JOIN (select id from vets where name='Stephanie Mendez') AS t2
ON true
union 
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
SELECT t1.id, t2.id, TO_DATE('02-02-2021','MM-DD-YYYY') 
FROM (select id from animals where name='Gabumon') AS t1
FULL JOIN (select id from vets where name='Jack Harkness') AS t2
ON true
union 
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
SELECT t1.id, t2.id, TO_DATE('01-05-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Pikachu') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
SELECT t1.id, t2.id, TO_DATE('03-08-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Pikachu') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Pikachu visited Maisy Smith on May 14th, 2020.
SELECT t1.id, t2.id, TO_DATE('05-14-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Pikachu') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Devimon visited Stephanie Mendez on May 4th, 2021.
SELECT t1.id, t2.id, TO_DATE('05-04-2021','MM-DD-YYYY') 
FROM (select id from animals where name='Devimon') AS t1
FULL JOIN (select id from vets where name='Stephanie Mendez') AS t2
ON true
union 
-- Charmander visited Jack Harkness on Feb 24th, 2021.
SELECT t1.id, t2.id, TO_DATE('02-24-2021','MM-DD-YYYY') 
FROM (select id from animals where name='Charmander') AS t1
FULL JOIN (select id from vets where name='Jack Harkness') AS t2
ON true
union 
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
SELECT t1.id, t2.id, TO_DATE('12-21-2019','MM-DD-YYYY') 
FROM (select id from animals where name='Plantmon') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Plantmon visited William Tatcher on Aug 10th, 2020.
SELECT t1.id, t2.id, TO_DATE('08-10-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Plantmon') AS t1
FULL JOIN (select id from vets where name='William Tatcher') AS t2
ON true
union
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
SELECT t1.id, t2.id, TO_DATE('04-07-2021','MM-DD-YYYY') 
FROM (select id from animals where name='Plantmon') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
SELECT t1.id, t2.id, TO_DATE('09-29-2019','MM-DD-YYYY') 
FROM (select id from animals where name='Squirtle') AS t1
FULL JOIN (select id from vets where name='Stephanie Mendez') AS t2
ON true
union 
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
SELECT t1.id, t2.id, TO_DATE('10-03-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Angemon') AS t1
FULL JOIN (select id from vets where name='William Tatcher') AS t2
ON true
union 
-- Angemon visited Jack Harkness on Nov 4th, 2020.
SELECT t1.id, t2.id, TO_DATE('11-04-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Agumon') AS t1
FULL JOIN (select id from vets where name='Jack Harkness') AS t2
ON true
union 
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
SELECT t1.id, t2.id, TO_DATE('01-24-2019','MM-DD-YYYY') 
FROM (select id from animals where name='Boarmon') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Boarmon visited Maisy Smith on May 15th, 2019.
SELECT t1.id, t2.id, TO_DATE('05-15-2019','MM-DD-YYYY') 
FROM (select id from animals where name='Boarmon') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
SELECT t1.id, t2.id, TO_DATE('02-27-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Boarmon') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
SELECT t1.id, t2.id, TO_DATE('08-03-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Boarmon') AS t1
FULL JOIN (select id from vets where name='Maisy Smith') AS t2
ON true
union 
-- Blossom visited Stephanie Mendez on May 24th, 2020.
SELECT t1.id, t2.id, TO_DATE('05-24-2020','MM-DD-YYYY') 
FROM (select id from animals where name='Blossom') AS t1
FULL JOIN (select id from vets where name='Stephanie Mendez') AS t2
ON true
union 
-- Blossom visited William Tatcher on Jan 11th, 2021.
SELECT t1.id, t2.id, TO_DATE('01-11-2021','MM-DD-YYYY') 
FROM (select id from animals where name='Blossom') AS t1
FULL JOIN (select id from vets where name='William Tatcher') AS t2
ON true;


-- database performance audit

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animals_id, (SELECT id FROM vets) vets_id, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;


-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';




















