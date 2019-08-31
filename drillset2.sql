--Write a query that returns a list of unique values for the country field
SELECT DISTINCT country
FROM ksprojects;

--How many unique values are there for the main_category field
SELECT COUNT(DISTINCT main_category)
FROM ksprojects;
--15
--How about the category field?
SELECT COUNT(DISTINCT category)
FROM ksprojects;
--158

--Get a list of all the unique combinations of main_category and category fields, sorted A to Z by main_category
SELECT DISTINCT main_category, category
FROM ksprojects
ORDER BY main_category;

--How many unique categories are in each main_category?
SELECT COUNT(DISTINCT category), main_category
FROM ksprojects
GROUP BY main_category;

--Write a query that returns the average number of backers per main_category, rounded to the nearest whole number and sorted high to low
SELECT ROUND(AVG(backers), 0) AS avg_backers, main_category
FROM ksprojects
GROUP BY main_category
ORDER BY avg_backers DESC;

--Write a query that shows for each category how many campaigns were successful and the average difference per project between dollars pledged and the goal
SELECT COUNT(state) AS num_successful, category, AVG(pledged - goal) AS avg_difference
FROM ksprojects
WHERE state = 'successful'
GROUP BY category;

--Write a query that shows, for every main_category, how many projects had 0 backers for that category and the largest goal amount for that category
SELECT COUNT(*), main_category, MAX(goal)
FROM ksprojects
WHERE backers = 0
GROUP BY main_category;

--For each category find the average USD per backer, and return only those results for which the average is > $50, sorted high to low
SELECT category, AVG(usd_pledged/NULLIF(backers, 0)) AS avg_per_backer
FROM ksprojects
GROUP BY category
HAVING AVG(usd_pledged/NULLIF(backers, 0)) >= 50
ORDER BY avg_per_backer DESC;

--Write a query that shows, for each main_category, how many successful projects had between 5 and 10 backers
SELECT main_category, COUNT(*)
FROM ksprojects
WHERE state = 'successful'
	AND backers BETWEEN 5 AND 10
GROUP BY main_category;

--Get a total of the amount pledged for each type of currency, grouped by its respective currency. Sort by pledged from high to low
SELECT SUM(pledged) AS total_pledged, currency
FROM ksprojects
GROUP BY currency
ORDER BY total_pledged DESC;

--Excluding Games and Technology in the main_category field, return the total of all backers for successful projects by main_category where the total was more than 100,000. Sort by main_category from A to Z
SELECT main_category, SUM(backers) AS total_backers
FROM ksprojects
WHERE state = 'successful'
	AND main_category NOT IN('Games', 'Technology')
GROUP BY main_category
HAVING SUM(backers) > 100000
ORDER BY main_category;
