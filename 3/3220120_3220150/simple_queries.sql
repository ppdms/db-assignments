select movie.original_title
from  movie, movie_cast
where movie.popularity > 5 AND movie.id = movie_cast.movie_id and movie_cast.name = 'Madonna'

-- 1. Expected 8 results
-- Explanation: find the original titles of movies with popularity > 5 starring Madonna

SELECT movie.original_title
FROM  movie
WHERE movie.id IN (
SELECT movie_cast.movie_id
FROM movie_cast INNER JOIN movie_crew ON (movie_cast.name = 'Quentin Tarantino' and movie_crew.name = 'Quentin Tarantino' and movie_cast.movie_id = movie_crew.movie_id))

-- 2. Expected 5 results
-- Explanation: find the original titles of movies where Tarantino was both a cast and crew member

SELECT TOP(10) original_title
FROM movie
ORDER BY revenue DESC

-- 3. 10 expected
-- Explanation: find the original titles of the top 10 movies by revenue

SELECT movie.title, avg(r.rating) as rating
FROM ((movie INNER JOIN movie_crew c ON c.name = 'Quentin Tarantino' AND c.job = 'Director' AND movie.id = c.movie_id)
    LEFT OUTER JOIN ratings r ON movie.id = r.movie_id)
GROUP BY movie.id, movie.title
ORDER BY rating DESC

-- 4. 6 expected
-- Explanation: find titles and average rating of movies where Tarantino was the director, and sort them by average user rating

SELECT DISTINCT m.title
FROM (movie m INNER JOIN (genre g LEFT OUTER JOIN hasGenre h ON g.id = h.genre_id and (g.name = 'Adventure' or g.name = 'Fantasy')) on m.id = movie_id)

-- 5. 1487 expected
-- Explanation: find titles of movies whose genre is either adventure or fantasy and list movies having both only once

SELECT m.original_title
FROM (movie m INNER JOIN (
    SELECT movie.id, avg(r.rating) as rating
    FROM ((movie INNER JOIN movie_crew c ON c.name = 'Quentin Tarantino' AND c.job = 'Director' AND movie.id = c.movie_id) LEFT OUTER JOIN ratings r ON movie.id = r.movie_id)
    GROUP BY movie.id, movie.title) as t ON m.id = t.id) 
WHERE t.rating = (
    SELECT min(rating) 
    FROM (movie m INNER JOIN (
        SELECT movie.id, avg(r.rating) as rating
        FROM ((movie INNER JOIN movie_crew c ON c.name = 'Quentin Tarantino' AND c.job = 'Director' AND movie.id = c.movie_id)
        LEFT OUTER JOIN ratings r ON movie.id = r.movie_id)
        GROUP BY movie.id, movie.title) as t ON m.id = t.id))

-- 6. 1 expected
-- Explanation: Get the original title of the movie with Tarantino as director with the worst rating.

SELECT m.original_title
FROM (movie m INNER JOIN (
    SELECT movie.id, avg(r.rating) as rating
    FROM ((movie INNER JOIN movie_crew c ON c.name = 'Quentin Tarantino' AND c.job = 'Director' AND movie.id = c.movie_id) LEFT OUTER JOIN ratings r ON movie.id = r.movie_id)
    GROUP BY movie.id, movie.title) as t ON m.id = t.id) 
WHERE t.rating = (
    SELECT max(rating) 
    FROM (movie m INNER JOIN (
        SELECT movie.id, avg(r.rating) as rating
        FROM ((movie INNER JOIN movie_crew c ON c.name = 'Quentin Tarantino' AND c.job = 'Director' AND movie.id = c.movie_id)
        LEFT OUTER JOIN ratings r ON movie.id = r.movie_id)
        GROUP BY movie.id, movie.title) as t ON m.id = t.id))

-- 7. 1 expected
-- Explanation: Get the original title of the movie with Tarantino as director with the best rating

SELECT movie.title, avg(r.rating) as rating
FROM ((movie INNER JOIN movie_crew c ON c.name = 'Quentin Tarantino' AND c.job = 'Director' AND movie.id = c.movie_id)
    LEFT OUTER JOIN ratings r ON movie.id = r.movie_id)
GROUP BY movie.id, movie.title
HAVING avg(r.rating) BETWEEN 3 AND 3.5

-- 8. 3 expected
-- Explanation: find titles of movies that got ratings between 3 and 3.5 and in which Tarantino was a director

SELECT movie.title, avg(r.rating) as rating
FROM ((movie INNER JOIN movie_crew c ON movie.id = c.movie_id)
    LEFT OUTER JOIN ratings r ON movie.id = r.movie_id)
WHERE title LIKE 'The%'
GROUP BY movie.id, movie.title
HAVING avg(r.rating) > 4

-- 9. 46 expected
-- Explanation: find titles and ratings of movies with ratings > 4 whose titles starts with "The"

SELECT m.title
FROM (movie m INNER JOIN (
        Keyword k LEFT OUTER JOIN haskeyword h ON k.id = h.keyword_id and (k.name = 'schizophrenia'))
            on m.id = movie_id)

-- 10. 20 expected
-- Explanation: Find titles of movies that feature the keyword "schizophrenia"

SELECT movie.original_title
FROM  movie
WHERE movie.id IN (
SELECT movie_cast.movie_id
FROM movie_cast INNER JOIN movie_crew ON (movie_cast.name = 'Salma Hayek' and movie_crew.name = 'Quentin Tarantino' and movie_cast.movie_id = movie_crew.movie_id))

-- 11. 2 expected
-- Explanation: find the original titles of the movies where Salma Hayek acted and Tarantino was a crew member

SELECT TOP(1) title
FROM movie INNER JOIN movie_crew c ON c.name = 'Quentin Tarantino' AND c.job = 'Director' AND movie.id = c.movie_id
ORDER BY revenue DESC

-- 12. 1 expected
-- find the title of the top grossing film by Tarantino


