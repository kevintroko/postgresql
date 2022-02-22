-- Challenge 1
SELECT movie_name, release_date FROM movies;

SELECT first_name, last_name 
WHERE nationality = 'American';

SELECT * FROM actors 
WHERE gender = 'M' AND date_of_birth > '1970-01-01';

SELECT movie_name FROM movies 
WHERE movie_length > 90 AND movie_lang = 'English';

-- Challenge 2
SELECT movie_name, movie_lang FROM movies
WHERE movie_lang IN ('English', 'Spanish', 'Korean');

SELECT first_name, last_name FROM actors
WHERE first_name LIKE 'M%'
AND date_of_birth BETWEEN '1940-01-01' AND '1969-12-31';

SELECT first_name, last_name FROM directors
WHERE nationality IN ('British', 'French', 'German')
AND date_of_birth BETWEEN '1950-01-01' AND '1980-12-31';

-- Challenge 3
SELECT * FROM directors 
WHERE nationality = 'American'
ORDER BY date_of_birth;

SELECT DISTINCT nationality FROM directors;

SELECT first_name, last_name, date_of_birth FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC
LIMIT 10;

-- Challenge 4
SELECT international_takings FROM movie_revenues
WHERE international_takings IS NOT NULL
ORDER BY international_takings DESC
LIMIT 3;

SELECT CONCAT(first_name, ' ', last_name) AS fullname FROM directors;

SELECT * FROM actors
WHERE first_name IS NULL
   OR date_of_birth IS NULL;
   
-- Challenge 5
SELECT COUNT(*) FROM actors 
WHERE date_of_birth > '1970-01-01';

SELECT MAX(domestic_takings), MIN(domestic_takings) FROM movie_revenues;

SELECT SUM (movie_length) FROM movies
WHERE age_certificate = '15';

SELECT COUNT(*) FROM directors
WHERE nationality = 'Japanese';

SELECT AVG(movie_length) FROM movies
WHERE movie_lang = 'Chinese';

-- Challenge 6
SELECT nationality, COUNT(nationality) FROM directors
GROUP BY nationality;

SELECT age_certificate, movie_lang, SUM(movie_length) 
FROM movies
GROUP BY age_certificate, movie_lang;

SELECT movie_lang, SUM(movie_length) FROM movies
GROUP BY movie_lang
HAVING SUM(movie_length) > 500;

-- Challenge: Joins 1
SELECT d.first_name, d.last_name, m.movie_name, m.release_date 
FROM directors d
JOIN movies m
USING (director_id)
WHERE movie_lang IN ('Chinese', 'Korean', 'Japanese');

SELECT m.movie_name, m.release_date, mr.international_takings
FROM movies m
JOIN movie_revenues mr
USING (movie_id)
WHERE movie_lang = 'English';

SELECT m.movie_name, mr.domestic_takings, mr.international_takings
FROM movies m
JOIN movie_revenues mr
USING (movie_id)
ORDER BY m.movie_name;

-- Challenge: Joins 2
SELECT d.first_name, d.last_name, m.age_certificate
FROM directors d
        LEFT JOIN movies m
        USING (director_id)
WHERE d.nationality = 'British'
GROUP BY d.first_name, d.last_name, d.first_name, m.age_certificate;

SELECT d.first_name, d.last_name, COUNT(m.movie_name) as movie_count
FROM directors d
LEFT JOIN movies m
USING (director_id)
GROUP BY d.first_name, d.last_name
ORDER BY movie_count DESC;

-- Challenge: Joins 3
SELECT ac.first_name, ac.last_name FROM actors ac
JOIN movies_actors ma ON ac.actor_id = ma.actor_id
JOIN movies mo ON mo.movie_id = ma.movie_id
JOIN directors d ON d.director_id = mo.director_id
WHERE d.first_name = 'Wes'
  AND d.last_name = 'Anderson'
GROUP BY ac.first_name, ac.last_name
ORDER BY ac.first_name;

SELECT d.first_name, d.last_name, SUM(mr.domestic_takings + mr.international_takings) as total_revenue
FROM directors d
         JOIN movies m USING (director_id)
         JOIN movie_revenues mr USING (movie_id)
GROUP BY d.first_name, d.last_name;

SELECT d.first_name, d.last_name, SUM(mr.domestic_takings) as suma
FROM directors d
         JOIN movies m USING (director_id)
         JOIN movie_revenues mr USING (movie_id)
WHERE mr.domestic_takings IS NOT NULL
GROUP BY d.first_name, d.last_name
ORDER BY suma DESC;

-- Challenge: Joins 4
SELECT d.first_name, d.last_name, d.date_of_birth
FROM directors d 
UNION 
SELECT ac.first_name, ac.last_name, ac.date_of_birth
FROM actors ac
ORDER BY date_of_birth;

-- Challenge: Joins 5
SELECT first_name, last_name, date_of_birth FROM directors
INTERSECT
SELECT first_name, last_name, date_of_birth FROM actors;

-- Challenge: Correlation 1
SELECT first_name, last_name FROM actors
WHERE date_of_birth < (
        SELECT date_of_birth FROM actors
        WHERE first_name = 'Marlon'
        AND last_name = 'Brando'
);

SELECT MIN(movie_length), MAX(movie_length) FROM movies 
WHERE movie_id IN (
    SELECT movie_id FROM movie_revenues
    WHERE domestic_takings > (
        SELECT AVG(domestic_takings) FROM movie_revenues
    )
);

-- Challenge: Correlation 2
SELECT ac1.first_name, ac1.last_name, ac1.date_of_birth, ac1.gender
FROM actors ac1
WHERE ac1.date_of_birth = (
    SELECT MAX(date_of_birth) FROM actors ac2
    WHERE ac2.gender = ac1.gender
);

SELECT m1.movie_name, m1.movie_length, m1.age_certificate
FROM movies m1
WHERE m1.movie_length > (
    SELECT AVG(m2.movie_length) FROM movies m2
    WHERE m1.age_certificate = m2.age_certificate
) ORDER BY  m1.age_certificate;

-- Challenge: Final
SELECT SUBSTRING(movie_name, 1, 6), 
       SUBSTRING(release_date::TEXT, 1, 4)
FROM movies;

SELECT CONCAT(LEFT(first_name, 1), '.'), last_name 
FROM actors
WHERE SUBSTRING(date_of_birth::TEXT, 6, 2) = '05';

SELECT movie_name, age_certificate, (
    REPLACE(movie_lang, 'English', 'Eng')
)
FROM movies
WHERE age_certificate = '18';