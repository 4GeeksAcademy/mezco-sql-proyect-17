-- queries.sql
-- Complete each mission by writing your SQL query below the instructions.
-- Don't forget to end each query with a semicolon ;
;

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;

-- MISSION 1 We want to understand the biodiversity of each region. Which regions have the most recorded species?;

SELECT
r.name AS region_name,
COUNT(DISTINCT o.species_id) AS num_species
FROM observations o
JOIN regions r ON o.region_id = r.id
GROUP BY r.name
ORDER BY num_species DESC
LIMIT 10;

-- MISSION 2 Which months have the highest observation activity? Group by month based on actual observation dates. This is useful for detecting seasonality;

SELECT 
strftime('%m', observation_date) AS month,
COUNT(*) AS total_observations
FROM observations
GROUP BY month
ORDER BY total_observations DESC;

-- MISSION 3 Detect species with few recorded individuals (possible rare cases);
SELECT 
s.common_name AS specie_name,
SUM(o.count) AS total_views
FROM observations o
JOIN species s ON o.species_id = s.id
GROUP BY s.common_name
HAVING total_views BETWEEN 1 AND 5
ORDER BY total_views ASC;

-- MISSION 4 Which region has the highest number of distinct species observed?;
SELECT
r.name AS region_name,
COUNT(DISTINCT o.species_id) AS num_species
FROM observations o
JOIN regions r ON o.region_id = r.id
GROUP BY r.name
ORDER BY num_species DESC
LIMIT 1;


-- MISSION 5 Which species have been observed most frequently?;
SELECT 
s.common_name AS specie_name,
SUM(o.count) AS total_views
FROM observations o
JOIN species s ON o.species_id = s.id
GROUP BY s.common_name
ORDER BY total_views DESC
LIMIT 10;



-- MISSION 6 We want to identify the most active observers. Who are the people with the most observation records?;

SELECT o.observer, 
COUNT(*) AS total_records
FROM observations o
GROUP BY o.observer
ORDER BY total_records DESC
LIMIT 10;


-- MISSION 7 What species have never been observed? Check if there are species in the table species that do not appear in observations;

SELECT 
  s.common_name, 
  s.scientific_name
FROM species s
LEFT JOIN observations o ON s.id = o.species_id
WHERE o.id IS NULL;

-- MISSION 8 On which dates were the most distinct species observed? This information is useful to explore peak biodiversity on specific days;

SELECT 
  observation_date,
  COUNT(DISTINCT species_id) AS distinct_species_count
FROM observations
GROUP BY observation_date
ORDER BY distinct_species_count DESC
LIMIT 10;


