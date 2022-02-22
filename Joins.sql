INSERT INTO directors (first_name, last_name, date_of_birth, nationality)
VALUES ('Christopher', 'Nolan', '1970-07-30', 'British');

-- INNER JOIN: Return only matching data
SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name
FROM directors
INNER JOIN movies
ON directors.director_id = movies.director_id;

SELECT directors.director_id, directors.first_name, directors.last_name, movies.movie_name
FROM directors
INNER JOIN movies
ON directors.director_id = movies.director_id
WHERE movies.movie_lang = 'Japanese';

SELECT d.director_id, d.first_name, d.last_name, m.movie_name
FROM directors d
INNER JOIN movies m
ON d.director_id = m.director_id
WHERE m.movie_lang = 'Japanese';

-- Joining columns with same name
SELECT mo.movie_name, mr.domestic_takings FROM movies mo
JOIN movie_revenues mr USING (movie_id);

-- Joining more than 1 query
SELECT ac.first_name, ac.last_name, mo.movie_name FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
WHERE mo.movie_lang = 'English';

-- Union
SELECT first_name, last_name FROM directors
UNION
SELECT first_name, last_name FROM actors;

SELECT first_name, last_name FROM directors
WHERE nationality = 'American'
UNION
SELECT first_name, last_name FROM actors
WHERE gender = 'F';

-- Union All
SELECT first_name, last_name FROM directors
UNION ALL
SELECT first_name, last_name FROM actors;

-- Intersect
SELECT first_name FROM directors
WHERE nationality = 'American'
INTERSECT 
SELECT first_name FROM actors
ORDER BY first_name;

-- Except
SELECT first_name FROM directors
EXCEPT 
SELECT first_name FROM actors;