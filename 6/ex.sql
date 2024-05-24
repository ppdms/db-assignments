/* 1 */
SELECT year(release_date) as year, COUNT(id) as movies_per_year
FROM movie
WHERE budget > 1000000
GROUP BY year(release_date);

/* 2 */
SELECT genre_id as genre, COUNT(id) as movies_per_genre
FROM movie JOIN hasGenre ON id = movie_id
WHERE budget > 1000000 OR runtime > 120
GROUP BY genre_id;

/* 3 */
SELECT genre_id as genre, year(release_date) as year, COUNT(id) as movies_per_gy
FROM movie JOIN hasGenre ON id = movie_id
GROUP BY genre_id, year(release_date);

/* 4 */
SELECT year(release_date) as year, SUM(revenue) as revenues_per_year
FROM movie JOIN movie_cast ON id = movie_id
WHERE name = 'Madonna'
GROUP BY year(release_date);

/* 5 */
SELECT year(release_date) as year, MAX(budget) as max_budget
FROM movie
WHERE budget > 0
GROUP BY year(release_date);

/* 6 */
SELECT name as trilogy_name
FROM collection JOIN belongsTocollection ON id = collection_id
GROUP BY name
HAVING COUNT(movie_id) = 3; 

/* 7 */
SELECT AVG(rating) as avg_rating, COUNT(rating) as rating_count
FROM ratings
GROUP BY user_id;

/* 8 */
SELECT TOP(10) title as movie_title, budget
FROM movie
ORDER BY budget DESC;

/* 9 */
SELECT year(release_date) as year, title as movies_with_max_budget, budget
FROM movie JOIN (
    SELECT year(release_date) as year, MAX(budget) as max_budget
    FROM movie
    WHERE budget > 0
    GROUP BY year(release_date)
) as p1 ON year(movie.release_date) = p1.year AND movie.budget = p1.max_budget
ORDER BY year(release_date), title;

/* 10 */
SELECT m_cr.name
FROM movie_crew m_cr
WHERE m_cr.job = 'Director'
  AND EXISTS (
      SELECT 1
      FROM movie m
      JOIN hasGenre h_g ON m.id = h_g.movie_id
      JOIN genre g ON h_g.genre_id = g.id
      WHERE m_cr.movie_id = m.id AND g.name = 'Horror'
    )
  AND EXISTS (
      SELECT 1
      FROM movie m
      JOIN hasGenre h_g ON m.id = h_g.movie_id
      JOIN genre g ON h_g.genre_id = g.id
      WHERE m_cr.movie_id = m.id AND g.name = 'Comedy'
    )
  AND NOT EXISTS (
    SELECT 1
    FROM movie m
    JOIN hasGenre h_g ON m.id = h_g.movie_id
    JOIN genre g ON h_g.genre_id = g.id
    WHERE m_cr.movie_id = m.id AND g.name NOT IN ('Horror', 'Comedy')
  );

James Orr
Takashi Miike
Michael Gottlieb
Michael Ritchie
John Whitesell
Sean McNamara
Darrell James Roodt
Albert Pyun
Daniel Goldberg
Burt Kennedy
Robert Butler
John Landis

/* 11 */
SELECT m_cr.name
FROM movie_crew m_cr
JOIN movie m ON m_cr.movie_id = m.id
JOIN hasGenre h_g ON m.id = h_g.movie_id
JOIN genre g ON h_g.genre_id = g.id
WHERE m_cr.job = 'Director'
  AND g.name = 'Horror' 

INTERSECT

SELECT m_cr.name
FROM movie_crew m_cr
JOIN movie m ON m_cr.movie_id = m.id
JOIN hasGenre h_g ON m.id = h_g.movie_id
JOIN genre g ON h_g.genre_id = g.id
WHERE m_cr.job = 'Director'
  AND g.name = 'Comedy'

EXCEPT

SELECT m_cr.name
FROM movie_crew m_cr
JOIN movie m ON m_cr.movie_id = m.id
JOIN hasGenre h_g ON m.id = h_g.movie_id
JOIN genre g ON h_g.genre_id = g.id
WHERE m_cr.job = 'Director'
  AND g.name NOT IN ('Horror', 'Comedy');

Burt Kennedy
Arlene Sanford
Daniel Goldberg


/* 12 note: r1.movie_id < r2.movie_id so we only get each pair once */
CREATE VIEW Popular_Movie_Pairs AS
SELECT r1.movie_id AS id1, r2.movie_id AS id2
FROM ratings r1
JOIN ratings r2 ON r1.user_id = r2.user_id AND r1.movie_id < r2.movie_id
WHERE r1.rating > 4 AND r2.rating > 4
GROUP BY r1.movie_id, r2.movie_id
HAVING COUNT(*) > 10;
