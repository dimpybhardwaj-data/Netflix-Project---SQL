# Netflix-Project - SQL
<div align="center">
  <img src="https://static.vecteezy.com/system/resources/previews/024/273/839/original/netflix-logo-transparent-free-png.png" alt="Netflix Logo" width="200" />
</div>

## Project Overview
This project analyzes Netflix’s catalog using SQL to uncover growth trends, genre popularity, country contributions, and content safety. It demonstrates SQL skills in grouping, ranking, window functions, and business storytelling.

## Dataset 
Netflix titles dataset with attributes such as title, type, country, genre, cast, director, release year, rating, duration, and description.

## Tools Used
MySQL Workbench

## Datasets Used

[SQL Analysis (Code)](Netflix_Project_Insights.sql)

## Business Problem
Netflix’s catalog is vast, but raw data doesn’t directly answer strategic questions like:

- Which is better to watch on Netflix: movies or TV shows? 
- How fast is Netflix growing year by year?
- Which 5 years had the highest number of movies and TV shows released?
- What is the yearly and cumulative number of Netflix titles?
- What are the most common Netflix ratings?
- How are Netflix ratings distributed across movies and TV shows?
- How many titles from India were added to Netflix each year?
- What is the average number of Indian titles released per year on Netflix?
- Which countries and genres dominate the platform?
- What content lengths (movie durations, TV seasons) are most common?
- Who are the most influential directors and actors?
- How safe is the content in terms of violent themes?


## How I solved the problems :
1. Movies vs TV Shows  
→ Used GROUP BY type to count titles. Result: movies dominate Netflix’s catalog compared to TV shows.

2. Growth Trend by Year  
→ Extracted YEAR(date_added) and counted titles per year. This revealed Netflix’s steady growth trajectory.

3. Top 5 Years with Highest Releases  
→ Grouped by year and type, ordered by count. Identified peak years with maximum content additions.

4. Yearly and Cumulative Titles  
→ Applied window functions (SUM(COUNT(*)) OVER) to calculate cumulative growth alongside yearly totals.

5. Ratings Analysis  
→ Grouped by rating to find most common ratings (TV‑MA, TV‑14).
→ Grouped by type + rating to show distribution across movies vs TV shows.

6. India’s Contribution  
→ Filtered country LIKE '%India%', grouped by year to count yearly releases.
→ Used AVG(COUNT(*)) OVER() to calculate average Indian titles per year.

7. Country & Genre Dominance  
→ Grouped by country and listed_in (genre), ranked them. Found USA and India as top producers, with International TV Shows and Dramas leading genres.

8. Emerging Genres  
→ Used RANK() OVER (PARTITION BY YEAR(date_added)) to track genre popularity shifts year by year.

9. Influential Directors  
→ Grouped by director, applied DENSE_RANK() to highlight top contributors (David Dhawan, Ram Gopal Varma, etc.).

10. Content Safety  
→ Searched description for violent keywords (murder, kill, death, violence, blood). Calculated percentage of violent titles.

11. Content Lengths  
→ Found longest movie by ordering duration DESC.
→ Calculated average movie duration (~90–100 minutes).
→ Ranked TV shows by season count, showing most have 1–2 seasons.

The challenge was to turn this dataset into clear insights for business and content strategy.


## Outcome
By systematically answering these questions with SQL:

- I transformed raw Netflix data into structured insights.
- I revealed growth trends, regional dominance, genre preferences, and talent analysis.
- I quantified content safety and audience mix.

This demonstrates how SQL can solve real business problems, not just technical queries.


## SQL Techniques Used
- List the SQL concepts you applied — this shows technical depth.
- Aggregations (COUNT, AVG, SUM)
- Filtering (WHERE, LIKE)
- Grouping (GROUP BY, HAVING)
- Sorting (ORDER BY, LIMIT)
- Window Functions (RANK, DENSE_RANK, SUM OVER)
- String & Date Functions (YEAR, ROUND)


## How to Run
1. Clone the repository  
2. Import `Netflix_Project_Insights.sql` into MySQL Workbench  
3. Run queries on the `netflix_final` table.


## Future Work
Show you think ahead.
- Extend analysis with joins (cast/director breakdown).
- Add visualization in Power BI.
- Compare Netflix with competitors (Prime, Disney+).

## Author
**Dimpy Bhardwaj**  
Operations Executive – Merchant Onboarding & Compliance, Tasic Technology Private Limited
Aspiring Data Analyst | Skilled in SQL, Python, Excel, Power BI  

🔗 LinkedIn: [linkedin.com/in/dimpy-bhardwaj-data](https://www.linkedin.com/in/dimpy-bhardwaj-data/)  
💻 GitHub: [github.com/dimpybhardwaj-data](https://github.com/dimpybhardwaj-data)



