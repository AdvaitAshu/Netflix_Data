select * from netflix;

--Counting the number of Movies vs TV shows
select  type,count(*) as number_of_content from netflix group by Type;

--Finding the most common rating in for movies and TV shows
select Rating,count(*)as c from netflix group by Rating order by c desc limit 1;

--Listing all the movies realeased in year 2020
select title, release_year,type from netflix where type = 'Movie' AND release_year=2020;

--top countries with most content on Netflix
select country, count(show_id) as count_of_show  from netflix group by country order by count_of_show  desc limit 5;

--identifying the longest movie 
select title, duration from netflix where duration=(select max(duration) from netflix) and type='Movie';

--find the content added in last five year.
select title,release_year from netflix where release_year IN (2021,2020,2019,2018,2017);
select count(title),release_year from netflix where release_year IN (2021,2020,2019,2018,2017) group by release_year;

-- All the movie and shows by "Rajiv chilaka"
select title, type from netflix where director ='Rajiv Chilaka'

--List all the TV show with more than 5 seasons
select title,type, duration from netflix where duration like '5_Seasons'

--Count the number of content items in each genere 
select count(show_id) as cnt,listed_in  from netflix group by listed_in order by cnt desc\

--Average number of content released in India on netflix each year
select count(show_id),release_year from netflix where country='India' group by release_year order by release_year desc

--Listing all the movie that are documnetry
select title, type, listed_in from netflix where listed_in like '%Documentaries%'

--All the content without director
select title, type from netflix where director IS null

-- Finding all the movies in which Salman Khan has appeared in last year
select title, type, release_year from netflix where casts like '%Salman_Khan%' and 
release_year in (select distinct(release_year) from netflix order by release_year desc limit 10)

--top ten Actor in Movies produced in India
WITH Actors AS (
    SELECT UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor FROM netflix
				)
SELECT actor,COUNT(*) AS appearance_count FROM Actors GROUP BY actor ORDER BY appearance_count DESC, actor ASC LIMIT 10;

---Categorizing the content Good or bad.
SELECT description,
    CASE 
        WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
        ELSE 'Good'END AS category
FROM netflix;


