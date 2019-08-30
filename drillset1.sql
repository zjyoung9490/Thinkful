--How many records are in the vehicles table?
SELECT COUNT(*)
FROM vehicles;
-- 33,442

--Write a query that returns all records
SELECT *
FROM vehicles;

--Write a query that returns the id, make and model for all the records for all 2010 vehicles
SELECT id, make, model
FROM vehicles
WHERE year = 2010;

--Write a query that provides the count of vehicles from 2010
SELECT COUNT(*)
FROM vehicles
WHERE year = 2010;
-- 1,109

--Write a query that provides the count of vehicles from 2010 to 2015, inclusive
SELECT COUNT (*)
FROM vehicles
WHERE year BETWEEN 2010 and 2015;
-- 5,995

--Write a query that provides the count of vehicles from the years 1990, 2000 and 2010
SELECT COUNT (*)
FROM vehicles
WHERE year IN(1990, 2000, 2010);
-- 3,026

--Write a query that returns the count of all records between 1987 and 2005, exclusive of the years 1990 and 2000
SELECT COUNT (*)
FROM vehicles
WHERE year BETWEEN 1987 AND 2005
AND year NOT IN(1990, 2000);
-- 17,235

--Write a field that returns the year, make and model and a field called average_mpg that calculates the average highway/city fuel consumption
SELECT year, make, model, (hwy + cty)/2 AS average_mpg
FROM vehicles;

--Write a query that returns the year, make and model and a text field displaying "X highway; Y city"
SELECT year, make, model, CONCAT(hwy, ' highway; ', cty, ' city') AS hwy_cty
FROM vehicles;

--Write a query that returns the id, make, model and year for all records that have NULL for either cyl or displ fields
SELECT id, make, model, year
FROM vehicles
WHERE cyl IS NULL OR displ IS NULL;

--Write a query that returns all fields for records with rear-wheel drive and diesel vehicles since 2000, inclusive
--Sort by year and highway mileage, both descending
SELECT *
FROM vehicles
WHERE year >= 2000 
	AND drive = 'Rear-Wheel Drive'
	AND fuel = 'Diesel'
ORDER BY year DESC, hwy DESC; 

--Write a query that counts the number of Fords or Chevrolets and either compact cars or 2-seaters
SELECT COUNT(*)
FROM vehicles
WHERE make IN('Ford', 'Chevrolet')
AND class IN('Compact Cars', 'Two Seaters');
-- 612

--Write a query that returns the records for 10 vehicles with the highest highway fuel mileage
SELECT * 
FROM vehicles
ORDER BY hwy DESC
LIMIT 10;

--Write a query that returns all the records for vehicles since 2000 whose model names starts with a capital X
SELECT *
FROM vehicles
WHERE year >= 2000 AND model LIKE 'X%'
ORDER BY make;
--using a lower case x only returns the Scions

--Write a query that returns the count of records where 'cyl' is NULL
SELECT COUNT (*)
FROM vehicles
WHERE cyl IS NULL;
-- 58

--Write a query that returns the count of all records before the year 2000 that got more than 20 mpg hwy and had greater than 3 liters displacement
SELECT COUNT(*)
FROM vehicles
WHERE year < 2000 AND hwy > 20 AND displ > 3; 
-- 1,964

--Write a query that returns all records whose model name has a capital X in the third position
SELECT *
FROM vehicles
WHERE model LIKE '__X%';