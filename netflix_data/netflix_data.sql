CREATE DATABASE netflix_analysis;

CREATE TABLE netflix(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

SELECT * FROM netflix;

--1. Count the number of Movies vs TV Shows
SELECT COUNT(DISTINCT show_id) FROM netflix WHERE netflix.type = 'Movie';
SELECT COUNT(DISTINCT show_id) FROM netflix WHERE netflix.type = 'TV Show';

--2. Find the most common rating for movies and TV shows
WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;

-- 3. List all movies released in a specific year
SELECT * FROM netflix WHERE release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix
SELECT *
FROM
(
SELECT 
	UNNEST(STRING_TO_ARRAY(country,',')) AS country, 
	COUNT(*) AS total_content
FROM netflix
GROUP BY 1
) AS t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;

--Longest movie
SELECT * FROM netflix WHERE type = 'Movie' AND duration IS NOT NULL ORDER BY SPLIT_PART(duration, ' ',1)::INT DESC;

--SPLIT_PART(duration, ' ',1)::INT DESC - Split the duration string using space and picks the first part as a 
--and ::INT cast that part into actual interger and then order by descending.


