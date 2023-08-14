/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES
('Agumon', '2020-02-03', 10.23, TRUE, 0),
('Gabumon', '2018-11-15', 8.00, TRUE, 2),
('Pikachu', '2021-01-07', 15.04, FALSE, 1),
('Devimon', '2017-05-12', 11.00, TRUE, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES
('Charmander', '2020-02-08', -11, FALSE, 0),
('Plantmon', '2021-11-15', -5.7, TRUE, 2),
('Squirtle', '1993-04-02', -12.13, FALSE, 3),
('Angemon', '2005-06-12', -45, TRUE, 1),
('Boarmon', '2005-06-07', 20.4, TRUE, 7),
('Blossom', '1998-10-13', 17, TRUE, 3),
('Ditto', '2022-05-14', 22, TRUE, 4);

INSERT INTO owners (full_name, age) VALUES
('Sam Smith',34 ),
('Jennifer Orwell',19 ),
('Bob',45 ),
('Melody Pond',77 ),
('Dean Winchester',14 ),
('Jodie Whittaker',38 );

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

UPDATE animals SET owner_id = ( SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = ( SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = ( SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = ( SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = ( SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id) SELECT v.id, s.id FROM vets v, species s WHERE v.name = 'William Tatcher' AND s.name = 'Pokemon';
INSERT INTO specializations (vet_id, species_id) SELECT v.id, s.id FROM vets v, species s WHERE v.name = 'Stephanie Mendez' AND s.name IN ('Digimon', 'Pokemon');
INSERT INTO specializations (vet_id, species_id) SELECT v.id, s.id FROM vets v, species s WHERE v.name = 'Jack Harkness' AND s.name = 'Digimon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-05-24' FROM vets v, animals a WHERE v.name = 'William Tatcher' AND a.name = 'Agumon';
INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-07-22' FROM vets v, animals a WHERE v.name = 'Stephanie Mendez' AND a.name = 'Agumon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2021-02-02' FROM vets v, animals a WHERE v.name = 'Jack Harkness' AND a.name = 'Gabumon';
INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-01-05' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Pikachu';
INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-03-08' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Pikachu';
INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-05-14' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Pikachu';
INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-05-14' FROM vets v, animals a WHERE v.name = 'Stephanie Mendez' AND a.name = 'Devimon';
INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-05-14' FROM vets v, animals a WHERE v.name = 'Jack Harkness' AND a.name = 'Charmander';
 visited  on May 4th, 2021.
 visited  on Feb 24th, 2021.
Plantmon visited Maisy Smith on Dec 21st, 2019.
Plantmon visited William Tatcher on Aug 10th, 2020.
Plantmon visited Maisy Smith on Apr 7th, 2021.
Squirtle visited Stephanie Mendez on Sep 29th, 2019.
Angemon visited Jack Harkness on Oct 3rd, 2020.
Angemon visited Jack Harkness on Nov 4th, 2020.
Boarmon visited Maisy Smith on Jan 24th, 2019.
Boarmon visited Maisy Smith on May 15th, 2019.
Boarmon visited Maisy Smith on Feb 27th, 2020.
Boarmon visited Maisy Smith on Aug 3rd, 2020.
Blossom visited Stephanie Mendez on May 24th, 2020.
Blossom visited William Tatcher on Jan 11th, 2021.