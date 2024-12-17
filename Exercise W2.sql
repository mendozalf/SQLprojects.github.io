use sakila;
# Exercise 3-1
# Retrieve the actor ID, first name, and last name for all actors. 
# Sort by last name and then by first name.
select actor_id, first_name, last_name
from actor
order by last_name, first_name;

# Exercise 3-2
# Retrieve the actor ID, first name, and last name for all actors whose last name equals 'WILLIAMS' or 'DAVIS'.
select actor_id, first_name, last_name
from actor
where  last_name = 'WILLIAMS' OR last_name = 'DAVIS';

# Exercise 3-3
# Write a query against the rental table that returns the IDs of the customers who rented a film on July 5, 2005
# (use the rental.rental_date column, and you can use the date() function to ignore the time component).
# Include a single row for each distinct customer ID.

select distinct customer_id
from rental
where date(rental_date) = '2005-07-05';

# Exercise 3-4
# Fill in the blanks (denoted by <#>) for this multitable query to achieve the following results
SELECT c.email, r.return_date
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY 2 desc;

# Write the SQL statement that retrieves the unique actor last name values for all actors. Sort results by last name
select last_name from actor
order by last_name;
SELECT   CONCAT(c.first_name,' ',c.last_name) AS full_name
,        COUNT(*) AS number_of_customer
FROM     customer c INNER JOIN rental r
ON       c.customer_id = r.customer_id
WHERE    SUBSTRING(c.last_name,1,1) IN ('J','K','L','M')
GROUP BY c.first_name
,        c.last_name
HAVING   COUNT(*) > 30
ORDER BY 2, 1;

SELECT   CONCAT(c.first_name,' ',c.last_name) AS full_name
     ,        COUNT(*) AS number_of_customer
     FROM     customer c INNER JOIN rental r
     ON       c.customer_id = r.customer_id
     GROUP BY c.first_name
     ,        c.last_name;
     
	SELECT   CONCAT(c.first_name,' ',c.last_name) AS full_name
     ,        COUNT(*) AS number_of_customer
     FROM     customer c INNER JOIN rental r
     ON       c.customer_id = r.customer_id
     GROUP BY CONCAT(c.first_name,' ',c.last_name)
     HAVING   COUNT(*) > 30
     ORDER BY 1 DESC;




