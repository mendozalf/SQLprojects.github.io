USE sakila;

-- Rewrite the following query, which uses a simple CASE expression, so that the same 
-- results are achieved using a searched CASE expression. Try to use as few WHEN clauses as possible.
SELECT name
,      CASE name
          WHEN 'English'  THEN 'latin1'
          WHEN 'Italian'  THEN 'latin1'
          WHEN 'French'   THEN 'latin1'
          WHEN 'German'   THEN 'latin1'
          WHEN 'Japanese' THEN 'utf8'
          WHEN 'Mandarin' THEN 'utf8'
          ELSE 'UNKNOWN'
        END AS character_set
 FROM   language;

SELECT name,
CASE
	WHEN name IN ('English', 'Italian', 'French', 'German')
    THEN 'latinl'
    WHEN name IN ('Japanese', 'Mandarin')
    THEN 'utf8'
    ELSE 'UNKNOWN'
END character_set
FROM language;

-- Rewrite the following query so that the result set contains 
-- a single row with five columns (one for each rating). Name the
--  five columns (G, PG, PG_13, R, and NC_17).
SELECT   rating
,        COUNT(*)
FROM     film
GROUP BY rating;

SELECT SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) G
,		SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) PG
,		SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) "PG-13"
,		SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) R
,		SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) "NC-17"
FROM film;

-- Write a query that returns the alphabetized first letter of the customer's 
-- last name and the count of active and inactive customers. Limit the results 
-- to only those first letters that occur in the last_name colum of the customer table.

-- Label the columns as follows:

-- starts_with is the first column and the first letter of the customer's last_name.
-- active_count is the second column and the count of active customers (as defined in 
-- the textbook examples of Chapter 11).
-- inactive_count is the third column and the count of inactive customers (as 
-- defined in the textbook examples of Chapter 11).
-- The output should look like the following:

SELECT SUBSTR(last_name,1,1) AS starts_with
,		SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count
,		SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM customer
GROUP BY SUBSTR(last_name,1,1)
ORDER BY 1;

# 11-4

WITH letters AS
( SELECT 'A' AS letter
UNION ALL
SELECT 'B' AS letter
UNION ALL
SELECT 'C' AS letter
UNION ALL
SELECT 'D' AS letter
UNION ALL
SELECT 'E' AS letter
UNION ALL
SELECT 'F' AS letter
UNION ALL
SELECT 'G' AS letter
UNION ALL
SELECT 'H' AS letter
UNION ALL
SELECT 'I' AS letter
UNION ALL
SELECT 'J' AS letter
UNION ALL
SELECT 'K' AS letter
UNION ALL
SELECT 'L' AS letter
UNION ALL
SELECT 'M' As 1etter
UNION ALL
SELECT 'N' AS letter
UNION ALL
SELECT 'O' AS letter
UNION ALL
SELECT 'P' AS letter
UNION ALL
SELECT 'Q' AS letter
UNION ALL
SELECT 'R' AS letter
UNION ALL
SELECT 'S' AS letter
UNION ALL
SELECT 'T' AS letter
UNION ALL
SELECT 'U' AS letter
UNION ALL
SELECT 'V' AS letter
UNION ALL
SELECT 'W' AS letter
UNION ALL
SELECT 'X' AS letter
UNION ALL
SELECT 'Y' AS letter
UNION ALL
SELECT 'Z' AS letter)
SELECT l.letter AS starts_with
,		SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count
,		SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM customer c RIGHT JOIN letters l
ON SUBSTR(c.last_name, 1, 1) = l.letter
GROUP BY l.letter
ORDER BY 1;

# 11-5

SELECT SUBSTR(last_name, 1, 1) AS starts_with
,		SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count
,		SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM customer
GROUP BY SUBSTR(last_name, 1, 1)
HAVING SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) > 30
ORDER BY 1;


	