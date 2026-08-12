-- CREATE DATABASE netflix; 
USE netflix;

-- CREATE TABLE :-
CREATE TABLE netflix_titles (
    show_id VARCHAR(10),
    type VARCHAR(10),
    title VARCHAR(255),
    director VARCHAR(255),
    cast TEXT,
    country VARCHAR(500),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(20),
    listed_in VARCHAR(255),
    description TEXT
);
ALTER TABLE netflix_titles MODIFY country TEXT;

-- LOAD THE CSV FILE INTO THIS SQL DATABASE :
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_titles.csv'
INTO TABLE netflix_titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- SELECT * FROM netflix_titles 


-- DATA CLEANING PROCESS :
-- CHECK MISSING VALUES :  
SELECT show_id
FROM netflix_titles
WHERE director IS NULL OR director = ''
	OR country IS NULL OR country = ''
	OR cast IS NULL OR cast = ''
    OR rating IS NULL OR rating = '';
    
-- COUNT HOW MANY SHOW ID HAS ANY MISSING VALUE
SELECT COUNT(DISTINCT show_id) AS missing_count
FROM netflix_titles
WHERE director IS NULL OR director = ''
   OR country IS NULL OR country = ''
   OR cast IS NULL OR cast = ''
   OR rating IS NULL OR rating = '';

-- REPLACE ALL THE MISSING VALUES WITH PLACEHOLDERS:
UPDATE netflix_titles
SET director = 'Unknown'
WHERE director IS NULL OR director = '';

UPDATE netflix_titles
SET country = 'Unknown'
WHERE country IS NULL OR country = '';

UPDATE netflix_titles
SET cast = 'Not Available'
WHERE cast IS NULL OR cast = '';

UPDATE netflix_titles
SET rating = 'NA'
WHERE rating IS NULL OR rating = '';


-- CHECK DUPLICATE VALUES : 
SELECT title, COUNT(*)
FROM netflix_titles
GROUP BY title
HAVING COUNT(*) > 1;

-- ALTERNATIVE METHOD TO FIND DUPLICATE ROWS : 
SELECT *
FROM netflix_titles
WHERE title IN (
    SELECT title
    FROM netflix_titles
    GROUP BY title
    HAVING COUNT(*) > 1
);


-- REMOVE DUPLICATE VALUES :-
            
SELECT *
FROM netflix_titles
WHERE show_id NOT IN (
  SELECT keep_id FROM (
    SELECT MAX(show_id) AS keep_id
    FROM netflix_titles
    GROUP BY title
  ) AS t
);
DELETE FROM netflix_titles
WHERE show_id NOT IN (
  SELECT keep_id FROM (
    SELECT MAX(show_id) AS keep_id
    FROM netflix_titles
    GROUP BY title
  ) AS t
);

SELECT * FROM netflix_titles;

-- WE CAN ALSO SOLVE THIS FROM INNER JOIN METHOD : 
-- DELETE t1
-- FROM netflix_titles AS t1
-- INNER JOIN netflix_titles AS t2
--   ON t1.title = t2.title
--   AND t1.show_id < t2.show_id;
  
-- SOME MODIFICATION : 
-- SET RELEASE_YEAR AS INTEGER FOR BETTER ANALYSIS: 
ALTER TABLE netflix_titles
MODIFY release_year INT;

-- IF WE WANT A DATE FORMAT IN DATE/MONTH/YEAR FORMAT.
SELECT DATE_FORMAT(date_added, '%d-%m-%Y') AS date_added_formatted FROM netflix_titles;

-- REMOVE INVALID YEARS 
DELETE FROM netflix_titles
WHERE release_year < 1900 OR release_year > 2026;

-- TRIM EXTRA SPACES FROM TITLE :
UPDATE netflix_titles
SET title = TRIM(title);

-- CREATE A FINAL CLEAN TABLE : 
CREATE TABLE netflix_final AS
SELECT DISTINCT *
FROM netflix_titles;

SELECT * FROM netflix_final;



