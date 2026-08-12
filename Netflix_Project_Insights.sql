SELECT * FROM netflix_final;
SHOW COLUMNS FROM netflix_final;

-- Movies vs TV Shows count 
SELECT type, count(*) AS COUNT 
FROM netflix_final
GROUP BY type;
-- As we can clearly see movie's number are greater than TV show.

-- Growth trend by year
SELECT 
  YEAR(date_added) as year,
  COUNT(*) as titles_added
FROM netflix_final
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year ASC;

-- if we want top 5 years which gave highest movie/Tv show:
SELECT 
  YEAR(date_added) as year,
  type,
  COUNT(*) as titles_added
FROM netflix_final
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added),type
ORDER BY titles_added DESC;

-- CUMULATIVE GROWTH USING WINDOW FUNCTION :
SELECT YEAR(date_added) AS YEAR,
COUNT(*) AS yearly_titles,
SUM(COUNT(*)) OVER (ORDER BY YEAR(date_added)) AS Cumulative_titles
FROM netflix_final
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year;


-- Ratings Analysis :- 
-- most common ratings
SELECT rating, COUNT(*) AS total_titles
FROM netflix_final
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC;

-- rating distribution by type : 
SELECT type,rating, COUNT(*) AS total_titles
FROM netflix_final
WHERE rating IS NOT NULL
GROUP BY rating, type
ORDER BY type, total_titles DESC;

-- Content safety — % of titles with violent keywords in descriptions
SELECT 
    ROUND(
        (SUM(CASE 
                WHEN description LIKE '%murder%' 
                  OR description LIKE '%kill%' 
                  OR description LIKE '%death%' 
                  OR description LIKE '%violence%' 
                  OR description LIKE '%blood%' 
                THEN 1 ELSE 0 END
            ) * 100.0 / COUNT(*)), 2
    ) AS violent_percentage
FROM netflix_final
WHERE description IS NOT NULL;


-- GENRE INSIGHTS : - 
-- Top genres globally 
SELECT listed_in AS Genre, COUNT(*) as total_titles
FROM netflix_final
WHERE listed_in IS NOT NULL
GROUP BY listed_in
ORDER BY total_titles DESC;

-- Genre popularity by Country 
SELECT country, listed_in AS Genre, COUNT(*) AS total_titles
FROM netflix_final
WHERE country IS NOT NULL AND listed_in IS NOT NULL
GROUP BY country, listed_in
ORDER BY total_titles DESC;

-- Emerging genres in a recent years : 
SELECT YEAR(date_added) AS year, listed_in AS genre, COUNT(*) AS total_titles,
       RANK() OVER (PARTITION BY YEAR(date_added) ORDER BY COUNT(*) DESC) AS genre_rank
FROM netflix_final
WHERE listed_in IS NOT NULL AND date_added IS NOT NULL
GROUP BY YEAR(date_added), listed_in
ORDER BY year, genre_rank;

-- COUNTRY TRENDS :
-- Top producing countries :
SELECT country, COUNT(*) as total_titles,
RANK () OVER (ORDER BY COUNT(*) DESC) AS country_rank
FROM netflix_final
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC;

-- India releases every year
SELECT YEAR(date_added) AS year, COUNT(*) AS india_titles
FROM netflix_final
WHERE country LIKE '%India%' AND date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year ;

-- Average India Releases Per Year :
-- SELECT YEAR(date_added) AS year, COUNT(*) AS india_titles,
-- AVG(COUNT(*)) OVER () AS avg_titles_per_year
-- FROM netflix_final
-- WHERE country LIKE '%India%' AND date_added IS NOT NULL
-- GROUP BY YEAR(date_added)

-- Director analysis :
SELECT director,
       COUNT(*) AS total_titles,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS director_rank
FROM netflix_final
WHERE country LIKE '%India%' AND director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC;


-- Longest Movie
SELECT type, title, duration
FROM netflix_final
WHERE type = 'Movie'
AND duration IS NOT NULL
ORDER BY duration DESC;

-- Average Movie duration : 
SELECT 
    ROUND(AVG(duration),2) AS avg_movie_duration
FROM netflix_final
WHERE type = 'Movie';

-- TV shows season distribution :
SELECT 
    duration AS seasons,
    COUNT(*) AS total_shows,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS season_rank
FROM netflix_final
WHERE type = 'TV Show' AND duration IS NOT NULL
GROUP BY duration
ORDER BY total_shows DESC;






