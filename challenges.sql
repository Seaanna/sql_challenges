-- WHERE

-- What is the population of the US?
SELECT
	code,
	name,
	population
FROM
	countries
WHERE
	code='USA';
-- What is the area of the US?
SELECT
	code,
	name,
	surfacearea
FROM
	countries
WHERE
	code='USA';
-- List the countries in Africa that have a population smaller than 30,000,000 and a life expectancy of more than 45?
SELECT
	*
FROM
	countries
WHERE
	continent  = 'Africa'
	AND
	lifeexpectancy >45
	AND
	population < 30000000;

-- Which countries gained independence after 1910 that are also a republic?
SELECT
	*
FROM
	countries

WHERE
	indepyear > 1910
	AND
	governmentform='Republic';

-- ORDER BY

-- Which fifteen countries have the lowest life expectancy?
SELECT
	*
FROM
	countries

ORDER BY
	lifeexpectancy ASC
	limit 15;
-- Which five countries have the lowest population density?
SELECT
	*
FROM
	countries

ORDER BY
	population ASC
	limit 5;
-- Which is the smallest country, by area and population? the 10 smallest countries, by area and population?
SELECT
	code,
	population,
	surfacearea,
	surfacearea / population AS surfacearea_per_capita

FROM
	countries

WHERE
	population >0
	AND
	surfacearea >0

ORDER BY
	surfacearea_per_capita	ASC
	LIMIT 10;
-- Which is the biggest country, by area and population? the 10 biggest countries, by area and population?
SELECT
	code,
	population,
	surfacearea,
	surfacearea / population AS population_per_capita

FROM
	countries

WHERE
	population >0
	AND
	surfacearea >0

ORDER BY
	population_per_capita DESC
	LIMIT 10;

-- WITH

-- Of the smallest 10 countries, which has the biggest gnp? (hint: use with and max)
WITH database as
(
SELECT
	code,
	population,
	surfacearea,
	gnp

FROM
	countries

WHERE
	population >0
	AND
	surfacearea >0

ORDER BY
	surfacearea ASC
	LIMIT 10)

	SELECT
		code,
		MAX(gnp)
	FROM
		database
	GROUP BY
		code,
		gnp
	ORDER BY
		gnp;
-- Of the smallest 10 countries, which has the biggest per capita gnp?
WITH database as
(
SELECT
	code,
	population,
	surfacearea,
	gnp,
	gnp/population AS gnp_per_capita

FROM
	countries

WHERE
	population >0
	AND
	surfacearea >0

ORDER BY
	surfacearea ASC
	LIMIT 10)

	SELECT
		code,
		gnp_per_capita,
		gnp
	FROM
		database
	GROUP BY
		code,
		gnp,
		gnp_per_capita
	ORDER BY
		gnp_per_capita DESC;
-- Of the biggest 10 countries, which has the biggest gnp?
WITH database as
(
SELECT
	code,
	population,
	surfacearea,
	gnp

FROM
	countries

WHERE
	population >0
	AND
	surfacearea >0

ORDER BY
	surfacearea DESC
	LIMIT 10)

	SELECT
		code,
		MAX(gnp)
	FROM
		database
	GROUP BY
		code,
		gnp
	ORDER BY
		gnp DESC;
-- Of the biggest 10 countries, which has the biggest per capita gnp?
WITH database as
(
SELECT
	code,
	population,
	surfacearea,
	gnp,
	gnp/population AS gnp_per_capita

FROM
	countries

WHERE
	population >0
	AND
	surfacearea >0

ORDER BY
	surfacearea DESC
	LIMIT 10)

	SELECT
		code,
		gnp_per_capita,
		gnp
	FROM
		database
	GROUP BY
		code,
		gnp,
		gnp_per_capita
	ORDER BY
		gnp_per_capita DESC;
-- What is the sum of surface area of the 10 biggest countries in the world? The 10 smallest?



-- GROUP BY

-- How big are the continents in term of area and population?

-- Which region has the highest average gnp?

-- Who is the most influential head of state measured by population?

-- Who is the most influential head of state measured by surface area?

-- What are the most common forms of government? (hint: use count(*))

-- What are the forms of government for the top ten countries by surface area?



-- Interesting...

-- Which countries are in the top 5% in terms of area?
