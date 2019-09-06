--Draw a schema of the relationship between the people, salaries, and hof_inducted tables. There are several online database schema drawers that you can use for free, including draw.io, which we recommend. We discuss the basics of how to use draw.io at the end of this checkpoint.
--Label the primary and foreign keys. (Note that a field can be a primary key to one table and a foreign key to another.)
--What are the parent and child tables? Are these one-to-one, one-to-many, or many-to-many relationships?

--Write a query that returns the namefirst and namelast fields of the people table, along with the inducted field from the hof_inducted table. 
--All rows from the people table should be returned, and NULL values for the fields from hof_inducted should be returned when there is no match found.
SELECT *
FROM people INNER JOIN hof_inducted
ON people.playerid = hof_inducted.playerid;

--In 2006, a special Baseball Hall of Fame induction was conducted for players from the negro baseball leagues of the 20th century. In that induction, 17 players were posthumously inducted into the Baseball Hall of Fame. 
--Write a query that returns the first and last names, birth and death dates, and birth countries for these players. Note that the year of induction was 2006, and the value for votedby will be “Negro League.”
SELECT namefirst, namelast, birthyear, birthcountry, deathyear
FROM people INNER JOIN hof_inducted 
ON people.playerid = hof_inducted.playerid
WHERE yearid = 2006
	AND votedby = 'Negro League';

--Write a query that returns the yearid, playerid, teamid, and salary fields from the salaries table, along with the category field from the hof_inducted table. 
--Keep only the records that are in both salaries and hof_inducted. Hint: While a field named yearid is found in both tables, don’t JOIN by it. You must, however, explicitly name which field to include.
SELECT salaries.yearid, salaries.playerid, teamid, salary, category
FROM salaries INNER JOIN hof_inducted
ON salaries.playerid = hof_inducted.playerid;

--Write a query that returns the playerid, yearid, teamid, lgid, and salary fields from the salaries table and the inducted field from the hof_inducted table. 
--Keep all records from both tables.
SELECT salaries.playerid, salaries.yearid, teamid, lgid, salary, hof_inducted.inducted
FROM salaries FULL OUTER JOIN hof_inducted
ON salaries.playerid = hof_inducted.playerid;

--There are 2 tables, hof_inducted and hof_not_inducted, indicating successful and unsuccessful inductions into the Baseball Hall of Fame, respectively.
-- 1. Combine these 2 tables by all fields. Keep all records.
SELECT * FROM hof_inducted 
UNION ALL
SELECT * FROM hof_not_inducted;

-- 2. Get a distinct list of all player IDs for players who have been put up for HOF induction.
SELECT playerid FROM hof_inducted
UNION
SELECT playerid FROM hof_not_inducted;

--Write a query that returns the last name, first name (see people table), and total recorded salaries for all players found in the salaries table.
SELECT namefirst, namelast, SUM(salary)
FROM salaries LEFT OUTER JOIN people
ON people.playerid = salaries.playerid
GROUP BY namelast, namefirst
ORDER BY namelast, namefirst;

--Write a query that returns all records from the hof_inducted and hof_not_inducted tables that include playerid, yearid, namefirst, and namelast. 
--Hint: Each FROM statement will include a LEFT OUTER JOIN!
SELECT hof_inducted.playerid, namefirst, namelast, yearid
FROM people LEFT OUTER JOIN hof_inducted
ON hof_inducted.playerid = people.playerid

UNION ALL

SELECT hof_not_inducted.playerid, namefirst, namelast, yearid
FROM people LEFT OUTER JOIN hof_not_inducted
ON people.playerid = hof_not_inducted.playerid;

--Return a table including all records from both hof_inducted and hof_not_inducted, and include a new field, namefull, which is formatted as namelast , namefirst (in other words, the last name, followed by a comma, then a space, then the first name). 
--The query should also return the yearid and inducted fields. Include only records since 1980 from both tables. Sort the resulting table by yearid, then inducted so that Y comes before N. Finally, sort by the namefull field, A to Z.
SELECT concat(namelast,', ', namefirst) AS namefull, yearid, inducted
FROM hof_inducted LEFT OUTER JOIN people
ON hof_inducted.playerid = people.playerid
WHERE yearid >= 1980

UNION ALL 

SELECT concat(namelast,', ', namefirst) AS namefull, yearid, inducted
FROM hof_not_inducted LEFT OUTER JOIN people
ON hof_not_inducted.playerid = people.playerid
WHERE yearid >= 1980

ORDER BY yearid,  inducted DESC, namefull;

--Write a query that returns the highest annual salary for each teamid, ranked from high to low, along with the corresponding playerid. 
--Bonus! Return namelast and namefirst in the resulting table. (You can find these in the people table.)
SELECT yearid, teamid, salaries.playerid, namelast, namefirst, salary
FROM salaries LEFT OUTER JOIN people
	 ON salaries.playerid = people.playerid
WHERE salary IN
	(SELECT MAX(salary)
	FROM salaries
	GROUP BY yearid, teamid)
ORDER BY salary DESC;

--Select birthyear, deathyear, namefirst, and namelast of all the players born since the birth year of Babe Ruth (playerid = ruthba01). 
--Sort the results by birth year from low to high.
SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear > ANY
	(SELECT birthyear
	 FROM people
	 WHERE playerid = 'ruthba01')
ORDER BY birthyear;

--Using the people table, write a query that returns namefirst, namelast, and a field called usaborn where. 
--The usaborn field should show the following: if the player's birthcountry is the USA, then the record is 'USA.' Otherwise, it's 'non-USA.' 
--Order the results by 'non-USA' records first.
SELECT namefirst, namelast, birthcountry,

CASE 
	WHEN birthcountry = 'USA' THEN 'USA'
	ELSE 'non-USA'
END as usaborn

FROM people
ORDER BY usaborn; 

--Calculate the average height for players throwing with their right hand versus their left hand. 
--Name these fields right_height and left_height, respectively.
SELECT 
AVG(CASE WHEN throws = 'R' THEN height END) AS right_height,
AVG(CASE WHEN throws = 'L' THEN height END) AS left_height
FROM people;

CASE WHEN 

--Get the average of each team's maximum player salary since 2010.
--Hint: WHERE will go inside your CTE.
WITH max_team_sal AS
(
	SELECT teamid, MAX(salary) as max_sal
	FROM salaries
	WHERE yearid > 2010
	GROUP BY teamid
)
SELECT AVG(max_sal) AS avg_max_sal
	FROM max_team_sal;