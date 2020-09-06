/*******************************************************************************
********************************************************************************
********************************************************************************
Pennkey: henrylui

                              CIS 550
                              Homework 1

Note: This assignment will be autograded, therefore, you must follow these
  instructions in order for your submission to be processed successfully.
  Violating any of these instructions will cause the autograded to deduct
  your grade, and you might receive a ZERO.

  1) Do not modify the comments that are included in the skeleton file.
  2) Write your queries underneath the appropriate comment
          for example, write your query for Question 7 underneath the comment
          that starts with "-- Question ..."
  3) Do not write any comments that look similar to "-- Question ..."

********************************************************************************
********************************************************************************
********************************************************************************/

-- Question 1 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT DISTINCT release_year FROM movie ORDER BY release_year DESC;

-- Question 2 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT movie_cast.name, cast_in.charac
FROM movie JOIN cast_in ON (movie.movie_id=cast_in.movie_id) JOIN movie_cast ON (movie_cast.id=cast_in.cast_id)
WHERE movie.title='The Other Side of the Wind' AND movie.release_year=2018;

-- Question 3 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT movie.title, crew.name
FROM movie JOIN crew_in ON (movie.movie_id=crew_in.movie_id) 
JOIN crew ON (crew.id=crew_in.crew_id) 
JOIN movie_genre ON (movie.movie_id=movie_genre.movie_id)
WHERE crew_in.job='Director' AND movie.release_year=2015 AND movie_genre.genre_name='Comedy' AND crew.name LIKE 'L%';

-- Question 4 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT COUNT(movie_cast.id) AS Num
FROM crew JOIN movie_cast ON (crew.id=movie_cast.id);

-- Question 5 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT genre.name, COUNT(movie_genre.genre_name) AS num
FROM movie_genre RIGHT OUTER JOIN genre ON movie_genre.genre_name=genre.name
GROUP BY name;

-- Question 6 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT title, MIN(release_year) AS earliest, MAX(release_year) AS recent, COUNT(title) as num_releases
FROM movie
GROUP BY title
HAVING COUNT(title)=(SELECT MAX(COUNT(title)) FROM movie GROUP BY title);

-- Question 7 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT (FLOOR(movie.release_year / 10) * 10) as DECADE, movie_genre.genre_name, 
         AVG(movie.rating) AS avg_rating, COUNT(movie.movie_id) as num
FROM movie_genre JOIN movie ON movie_genre.movie_id=movie.movie_id
GROUP BY (FLOOR(movie.release_year / 10) * 10), movie_genre.genre_name;

-- Question 8 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT crew.name 
FROM crew JOIN crew_in ON crew.id=crew_in.crew_id JOIN movie ON crew_in.movie_id=movie.movie_id
WHERE crew_in.job='Director' AND movie.release_year > 2016 AND movie.rating >=
( SELECT MAX(movie.rating)
    FROM movie 
    WHERE movie.release_year > 2016
) - 1;

-- Question 9 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---


-- Question 10 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
CREATE TABLE Airports(id int(11), name varchar(20), city varchar(20), country varchar(20), iata char(3), icao char(4), lat decimal(8,6), lon decimal(9,6), alt int(11), timezone decimal(3,1), dst char(1), tz varchar(20), PRIMARY KEY(id));
CREATE TABLE Airlines(id int(11), name varchar(20), alias varchar(20), iata char(2), icao char(3), callsign varchar(20), country varchar(20), active char(1), PRIMARY KEY(id));
CREATE TABLE Routes(airline_iata char(3), airline_id int(11), src_iata_icao char(4), source_id int(11), target_iata_icao char(4), target_id int(11), code_share char(1) CHECK(code_share='Y' OR code_share=''), equipment char(20), FOREIGN KEY(airline_id) REFERENCES Airlines(id), FOREIGN KEY(source_id) REFERENCES Airports(id), FOREIGN KEY(target_id) REFERENCES Airports(id));


-- Question 11 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
/*The order is Airports Airlines Routes. Here is the reason: Routes references Airlines and Airports with foreign keys, so they must be generated first. */

-- Question 12 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT Airports.city, COUNT(Airports.id) AS NumAirports 
FROM Airports 
WHERE Airports.country='United States' 
GROUP BY Airports.city 
HAVING COUNT(NumAirports)>=3;

-- Question 13 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT AP.name 
FROM Airports AP JOIN Routes R ON AP.id=R.source_id 
WHERE AP.id NOT IN 
 (SELECT AP.id FROM Airports AP JOIN Routes R ON AP.id=R.target_id);


-- Question 14 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
SELECT AP.name 
FROM Airports AP JOIN Routes R ON AP.id=R.source_id
WHERE AP.country='United States' 
AND R.target_id IN 
 (SELECT DISTINCT Routes.target_id
    FROM Airports JOIN Routes ON Airports.id=Routes.target_id 
    WHERE Airports.city='San Francisco' OR Airports.city='Los Angeles' 
    AND Airports.country='United States');

-- Question 15 -- DO NOT REMOVE OR MODIFY THIS COMMENT OR CREATE SIMILAR ONES ---
