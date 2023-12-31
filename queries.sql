/*Queries that provide answers to the questions from all projects.*/

-- 1. Find all animals whose name ends in "mon":
SELECT * FROM animals WHERE name LIKE '%mon';

-- 2. List the name of all animals born between 2016 and 2019:
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- 3. List the name of all animals that are neutered and have less than 3 escape attempts:
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- 4. List the date of birth of all animals named either "Agumon" or "Pikachu":
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- 5. List name and escape attempts of animals that weigh more than 10.5kg:
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- 6. Find all animals that are neutered:
SELECT name, neutered FROM animals WHERE neutered = TRUE;


-- 7. Find all animals not named Gabumon:
SELECT name FROM animals WHERE name <> 'Gabumon';


-- 8. Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg):
SELECT name, weight_kg FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- turn into unspecified and roll back

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

-- insert digimon and pokemon to respective data

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT name, species FROM animals;
COMMIT;
SELECT name, species FROM animals;

-- delete and rollback

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- practice savepoint

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_all_born_after_1stJan22;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO delete_all_born_after_1stJan22;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts FROM animals GROUP BY neutered ORDER BY total_escape_attempts DESC LIMIT 1;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


-- What animals belong to Melody Pond?
SELECT name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name AS animal_name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name AS owner_name, animals.name AS animal_name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id ORDER BY owners.full_name;
-- How many animals are there per species?
SELECT species.name AS species_name, COUNT(animals.id) AS total_animals FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name AS animal_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
-- Who owns the most animals?
SELECT owners.full_name AS owner_name, COUNT(animals.id) AS total_animals FROM owners LEFT JOIN animals ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY total_animals DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'William Tatcher' ORDER BY v.visit_date DESC LIMIT 1; 
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT a.id) FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez';
-- List all vets and their specialties, including vets with no specialties.
SELECT vt.name AS vet_name, s.name AS specialist FROM vets vt LEFT JOIN specializations sp ON vt.id = sp.vet_id LEFT JOIN species s ON sp.species_id = s.id ORDER BY vt.name;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT a.name, COUNT(a.id) FROM animals a JOIN visits v ON a.id = v.animal_id GROUP BY a.name ORDER BY COUNT(a.id) DESC LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT a.name AS maisy_first_visit FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Maisy Smith' ORDER BY v.visit_date ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id ORDER BY v.visit_date DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id WHERE sp.vet_id IS NULL;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS speciality_for_maisy FROM species s JOIN animals a ON s.id = a.species_id JOIN visits v ON a.id = v.animal_id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Maisy Smith' GROUP BY s.name ORDER BY COUNT(v.visit_date) DESC LIMIT 1;
