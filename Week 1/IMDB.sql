alter session set current_schema = master; 
SELECT title, rating FROM movie WHERE ROWNUM <= 5;

SELECT DISTINCT release_year FROM movie ORDER BY release_year DESC;

SELECT O.name, C.charac 
FROM movie_cast O JOIN movie M ON O.id=M.movie_id JOIN cast_in C ON C.movie_id=M.movie_id AND C.cast_id=O.id
WHERE M.title='The Other Side of the Wind' AND M.release_year=2018;

SELECT movie_cast.name, cast_in.charac
FROM movie JOIN cast_in ON (movie.movie_id=cast_in.movie_id) JOIN movie_cast ON (movie_cast.id=cast_in.cast_id)
WHERE movie.title='The Other Side of the Wind' AND movie.release_year=2018;

SELECT movie.title, crew.name
FROM movie JOIN crew_in ON (movie.movie_id=crew_in.movie_id) 
JOIN crew ON (crew.id=crew_in.crew_id) 
JOIN movie_genre ON (movie.movie_id=movie_genre.movie_id)
WHERE crew_in.job='Director' AND movie.release_year=2015 AND movie_genre.genre_name='Comedy' AND crew.name LIKE 'L%';

-- Iffy Q 4
SELECT COUNT(movie_cast.id) AS Num
FROM crew JOIN movie_cast ON (crew.id=movie_cast.id);

-- Need to have genres not in movie_genre

SELECT genre_name, COUNT(*) FROM
(SELECT genre_name FROM movie_genre
UNION
SELECT name FROM genre)
GROUP BY genre_name;


SELECT genre_name, COUNT(genre_name) AS num
FROM movie_genre
GROUP BY genre_name;

(SELECT name FROM genre)
MINUS
(SELECT genre_name FROM movie_genre);

SELECT 
(SELECT name FROM genre)
UNION
(SELECT genre_name FROM movie_genre);

CREATE VIEW All_Genres(name) AS 
(SELECT name FROM genre)
UNION
(SELECT genre_name FROM movie_genre);

SELECT genre.name, COUNT(movie_genre.genre_name) AS num
FROM movie_genre RIGHT OUTER JOIN genre ON movie_genre.genre_name=genre.name
GROUP BY name;

-- Q 6
SELECT title, MIN(release_year) AS earliest, MAX(release_year) AS recent, COUNT(title) as num_releases
FROM movie
GROUP BY title
HAVING COUNT(title)=(SELECT MAX(COUNT(title)) FROM movie GROUP BY title);

SELECT MAX(top)
FROM (SELECT title, COUNT(title) top FROM movie
GROUP BY title);


SELECT title, COUNT(title) top FROM movie
GROUP BY title;

(SELECT title, MIN(release_year) AS earliest, MAX(release_year) AS recent
FROM movie
GROUP BY title)
UNION
(SELECT MAX(top)
FROM (SELECT title, COUNT(title) top FROM movie
GROUP BY title));

SELECT MAX(COUNT(title))
FROM movie
GROUP BY title;

-- Q 7 -- need decades
SELECT movie_genre.genre_name, AVG(movie.rating) AS avg_rating, COUNT(movie.movie_id) as num
FROM movie_genre JOIN movie ON movie_genre.movie_id=movie.movie_id
GROUP BY movie_genre.genre_name;

SELECT (FLOOR(movie.release_year / 10) * 10) as DECADE, COUNT(movie.movie_id) AS NUM
FROM movie
GROUP BY FLOOR(movie.release_year / 10)
ORDER BY FLOOR(movie.release_year / 10);

SELECT ((movie.release_year / 10)*10) as DECADE, COUNT(movie.movie_id) AS NUM
FROM movie
GROUP BY ((movie.release_year / 10)*10);

SELECT (FLOOR(movie.release_year / 10) * 10) as DECADE, movie_genre.genre_name, 
         ROUND(AVG(movie.rating), 2) AS avg_rating, COUNT(movie.movie_id) as num
FROM movie_genre JOIN movie ON movie_genre.movie_id=movie.movie_id
GROUP BY (FLOOR(movie.release_year / 10) * 10), movie_genre.genre_name
ORDER BY (FLOOR(movie.release_year / 10) * 10);

SELECT (FLOOR(movie.release_year / 10) * 10) as DECADE, movie_genre.genre_name, 
         AVG(movie.rating) AS avg_rating, COUNT(movie.movie_id) as num
FROM movie_genre JOIN movie ON movie_genre.movie_id=movie.movie_id
GROUP BY (FLOOR(movie.release_year / 10) * 10), movie_genre.genre_name;

SELECT (FLOOR(movie.release_year / 10) * 10) as DECADE, movie_genre.genre_name, 
         AVG(movie.rating), 2) AS avg_rating, COUNT(movie.movie_id) as num
FROM movie_genre JOIN movie ON movie_genre.movie_id=movie.movie_id
GROUP BY (FLOOR(movie.release_year / 10) * 10), movie_genre.genre_name;

-- Q 8

SELECT crew.name 
FROM crew JOIN crew_in ON crew.id=crew_in.crew_id JOIN movie ON crew_in.movie_id=movie.movie_id
WHERE crew_in.job='Director' AND movie.release_year > 2016 AND movie.rating >=
( SELECT MAX(movie.rating)
    FROM movie 
    WHERE movie.release_year > 2016
) - 1;

SELECT MAX(movie.rating)
    FROM movie 
    WHERE movie.release_year > 2016;

-- Q 9

SELECT crew.name 
FROM crew JOIN crew_in ON crew.id=crew_in.crew_id JOIN movie ON crew_in.movie_id=movie.movie_id
WHERE crew_in.job='Director';

SELECT MAX(movie.rating), movie_genre.genre_name
    FROM movie JOIN movie_genre ON movie_genre.movie_id=movie.movie_id
    GROUP BY movie_genre.genre_name;




