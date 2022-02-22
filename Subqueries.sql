-- Uncorrelated
SELECT AVG(movie_length) FROM movies;

SELECT movie_name, movie_length
FROM movies
WHERE movie_length > (SELECT AVG(movie_length) FROM movies);

-- Uncorrelated 2
SELECT movie_id movie_revenues
WHERE international_takings > domestic_takings; 

SELECT mo.movie_name, d.first_name FROM movies mo
JOIN directors d USING (director_id)
WHERE movie_id IN (
    SELECT movie_id
    FROM movie_revenues
    WHERE international_takings > domestic_takings
);

-- Correlated
SELECT m1.movie_name, m1.movie_lang, m1.movie_length 
FROM movies m1
WHERE m1.movie_length = (
    SELECT MAX(movie_length) FROM movies m2
    WHERE m2.movie_lang = m.movie_lang
);

SELECT ac1.first_name, ac1.last_name, ac1.date_of_birth
FROM actors ac1
WHERE ac1.gender = (
    SELECT MAX(date_of_birth) FROM actors ac2
    WHERE act2.gender = act1.gender
)
