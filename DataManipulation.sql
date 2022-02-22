-- Create the director  table
CREATE TABLE directors (
    director_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30) NOT NULL,
    date_of_birth DATE,
    nationality VARCHAR(20)
);

-- Create actors table
CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30) NOT NULL,
    gender CHAR(1),
    date_of_birth DATE
);

-- Create movies table using FK
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    movie_name VARCHAR(50) NOT NULL,
    movie_length INT,
    movie_lang VARCHAR(20),
    release_date DATE,
    age_certificate VARCHAR(5),
    director_id INT REFERENCES directors(director_id)
);

-- Challenge
CREATE TABLE movie_revenues (
    revenue_id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies(movie_id),
    domestic_takings NUMERIC(6,2),
    international_takings NUMERIC(6,2)
);

-- Junction Table
CREATE TABLE movies_actors (
    movie_id INT REFERENCES movies (movie_id),
    actor_id INT REFERENCES actors (actor_id),
    PRIMARY KEY (movie_id, actor_id)
);

-- Delete Table
DROP TABLE actors;

-- IN
SELECT first_name, last_name FROM actors
WHERE first_name IN ('Bruce', 'John'); -- Bruce, John, John

SELECT first_name, last_name FROM actors
WHERE first_name NOT IN ('Bruce', 'John'); -- Peter, Pablo, Per

-- Like
SELECT * FROM actors
WHERE first_name LIKE 'P%'; -- Peter, Pablo, Per

SELECT * FROM actors
WHERE first_name LIKE 'Pe_'; -- Per

SELECT * FROM actors
WHERE first_name LIKE '%r%'; -- Lorraine, Peter, Marlon

-- Between
SELECT movie_name, release_date FROM movies
WHERE release_date BETWEEN '1995-01-01' AND '1999-12-31';

SELECT movie_name, release_date FROM movies
WHERE movie_length BETWEEN 90 AND 120;

SELECT movie_name, release_date FROM movies
WHERE movie_lang BETWEEN 'E' AND 'P';

-- Order By
SELECT * FROM actors
ORDER BY first_name ASC; -- A to Z

SELECT * FROM actors
ORDER BY first_name DESC; -- Z to A

-- Limit
SELECT * FROM movie_revenues
ORDER BY domestic_takings
LIMIT 3; -- Only 3 results

SELECT * FROM movie_revenues
ORDER BY domestic_takings
LIMIT 3 OFFSET 5; -- Only 3 results starting from 6th value

-- Fetch
SELECT actor_id, first_name FROM actors
FETCH FIRST ROW ONLY;

SELECT actor_id, first_name FROM actors
FETCH FIRST 10 ROW ONLY;

SELECT actor_id, first_name FROM actors
OFFSET 8 ROWS
FETCH FIRST 10 ROW ONLY;

-- DISTINCT
SELECT DISTINCT movie_lang FROM movies
ORDER BY movie_lang; 

SELECT DISTINCT movie_lang, age_certificate FROM movies
ORDER BY movie_lang; 

-- Null values
SELECT * FROM actors
WHERE date_of_birth IS NOT NULL;

SELECT * FROM actors
WHERE date_of_birth IS NULL;

-- Setting an alias
SELECT last_name AS surname FROM directors;

SELECT last_name AS surname FROM directors
WHERE last_name LIKE 'A%'
ORDER BY surname;

-- CONCAT
SELECT CONCAT(first_name, ' ', last_name) AS fullname FROM actors;

-- COUNT
SELECT COUNT(*) FROM movie_revenues;

SELECT COUNT(*) FROM movies
WHERE movie_length = 'English';

-- SUM
SELECT SUM(domestic_takings) FROM movie_revenues;

SELECT SUM(domestic_takings) FROM movie_revenues
WHERE domestic_takings > 100.0; 


-- MIN and MAX
SELECT MAX(movie_length) FROM movies;
SELECT MIN(movie_length) FROM movies WHERE movie_lang = 'English';
SELECT MAX(release_date) FROM movies; -- 2021-11-10
SELECT MIN(release_date) FROM movies; -- 1937-08-25
SELECT MAX(movie_name) FROM movies; -- Way of the dragon
SELECT MIN(movie_name) FROM movies; -- A Clockwork Orange

-- AVG
SELECT AVG (movie_length) FROM movies;
SELECT AVG (movie_length) FROM movies WHERE age_certificate = 18;

-- GROUP BY
SELECT movie_lang, COUNT(movie_lang) FROM movies
GROUP BY movie_lang;

SELECT movie_lang, age_certificate, AVG(movie_length) FROM movies
WHERE movie_length > 120
GROUP BY movie_lang, age_certificate;

-- HAVING
SELECT movie_lang, COUNT(movie_lang) FROM movies
GROUP BY movie_lang
HAVING COUNT(movie_lang) > 1;


-- Mathematical Operators
SELECT 5 - 6 AS result;
SELECT 5 + 6 AS result;
SELECT 5 / 6 AS result; -- does not return decimals since it is integer
SELECT 5 * 6 AS result;
SELECT 5 % 6 AS result;

-- UPPER and LOWER
SELECT UPPER('string'); -- STRING
SELECT LOWER(movie_lang) FROM movies; 

-- INITCAP
SELECT INITCAP('example string'); -- Example String
SELECT INITCAP(movie_lang) FROM movies;

-- LEFT and RIGHT
SELECT LEFT('string', 3); --  str
SELECT LEFT('string', -1); --  strin
SELECT LEFT(movie_name, 5) FROM movies;
SELECT RIGHT('string', 3); -- ing
SELECT RIGHT(movie_name, 5) FROM movies;

-- REVERSE
SELECT REVERSE('hello'); -- olleh
SELECT REVERSE(movie_name) FROM movies;

-- SUBSTRING
SELECT SUBSTRING('string', 1, 2); -- st
SELECT SUBSTRING(movie_name, 1, 5) FROM movies;

-- REPLACE
SELECT REPLACE('source_string', 'old_string', 'new_string');
SELECT first_name, last_name, REPLACE(gender, 'M', 'Male') FROM movies;

UPDATE directors 
SET nationality = REPLACE(nationality, 'American', 'USA')
WHERE nationality = 'American';

-- SPLIT
SELECT SPLIT_PART('first_name.last_name@gmail.com', '@', 1); -- first_name.last_name
SELECT movie_name, SPLIT_PART(movie_name, ' ', 1) AS first_word FROM movies;

-- CAST
SELECT date_of_birth::TEXT FROM directors; -- change Date to Text type