-- SQL Country Database Challenge
-- What languages are spoken in the 20 poorest (GNP/ capita) countries in the world? Hint: Use DISTINCT to remove duplicates
SELECT DISTINCT
  name,
  code,
  language,
  gnp,
  population,
  gnp/population AS gnp_per_capita
FROM
  public.countrylanguages,
  public.countries
WHERE
	population > 0
	AND
	countries.code = countrylanguages.countrycode
ORDER BY
	gnp_per_capita ASC
	LIMIT 20;
-- Are there any countries without an official language?
SELECT
  name,
  language,
  isofficial
FROM
  public.countrylanguages,
  public.countries
WHERE
  countries.code = countrylanguages.countrycode
  AND
  countrylanguages.isofficial = 'f';
-- What are the cities in the countries with no official language?
SELECT
  cities.name,
  code,
  countrylanguages.isofficial,
  language
FROM
  public.cities,
  public.countrylanguages,
  public.countries
WHERE
  cities.countrycode = countries.code AND
  countries.code = countrylanguages.countrycode
  AND
  isofficial = 'f';

-- Which languages are spoken in the ten largest (area) countries?
WITH top10countries AS
(
SELECT
	*
FROM
	countries
WHERE
	population>0
ORDER BY
	surfacearea DESC
)

SELECT
	countrylanguages.language,
	top10countries.name
FROM
	top10countries,
	countrylanguages
WHERE
	top10countries.code = countrylanguages.countrycode
ORDER BY
	surfacearea DESC
	LIMIT
	10;

-- What is the total population of cities where English is the offical language? Spanish? (Hint: The official language of a city is based on country)
WITH english_cities AS
(
SELECT
  cities.name,
  countries.code,
  cities.population,
  countrylanguages.language,
  countrylanguages.isofficial
FROM
  public.cities,
  public.countries,
  public.countrylanguages
WHERE
  countries.code = cities.countrycode AND
  countries.code = countrylanguages.countrycode
  AND
  countrylanguages.language = 'English'
  AND
  countrylanguages.isofficial = 't'
  )
SELECT
	language,
	sum(english_cities.population)
FROM
	english_cities
GROUP BY
	language;
-- How many countries have no cities?
SELECT
  countries.name,
  countries.code
FROM
  public.cities,
  public.countries
EXCEPT
SELECT
  countries.name,
  countries.code
FROM
  public.cities,
  public.countries
WHERE
  countries.code = cities.countrycode;
        -- 7 --
-- Which countries have the 100 biggest cities in the world?
SELECT
  code,
  cities.name,
  cities.population,
FROM
  public.cities,
  public.countries
WHERE
  countries.code = cities.countrycode
 ORDER BY
   population DESC
LIMIT
  100;
-- What languages are spoken in the countries with the 100 biggest cities in the world?
WITH top100 AS
(
SELECT
  code,
  cities.name,
  cities.population
FROM
  public.cities,
  public.countries
WHERE
  countries.code = cities.countrycode
 ORDER BY
   population DESC
LIMIT
  100
)

	SELECT
	  top100.code,
	  top100.name,
	  top100.population,
	  countrylanguages.language
	FROM
	  top100,
	  public.countrylanguages
	WHERE
	  top100.code = countrylanguages.countrycode
	ORDER BY
	  population DESC;
    --------- 757 rows --------
-- Which country or countries have the most official languages?

-- Which country or countries speak the most languages?
-- Which countries have the highest proportion of official language speakers? The lowest?
