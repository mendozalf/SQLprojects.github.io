-- Exercise 8-1
-- Construct a query that counts the number of rows in the payment table.
USE sakila;
SELECT COUNT(*) FROM payment;

-- Exercise 8-2
-- Modify your query from Exercise 8-1 to count the number 
-- of payments made by each customer. Show the customer ID 
-- and the total amount paid for each customer.
SELECT customer_id, SUM(amount), COUNT(payment_id) 
FROM payment
GROUP BY customer_id;

-- Exercise 8-3
-- Modify your query from Exercise 8-2 to include only 
-- those customers who have made at least 40 payments.
SELECT customer_id, SUM(amount) Total, COUNT(payment_id)
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) >= 40;

-- Construct a query that displays the following results from a query against 
-- the film, film_actor, and actor tables where the film's rating is either 'G', 
-- 'PG', or 'PG-13' with a row count between 9 and 12 rows and order the results by ascending order of title.
SELECT f.title, f.rating, COUNT(*) 
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
JOIN actor a
ON fa.actor_id = a.actor_id
WHERE f.rating IN ('G', 'PG', 'PG-13')
GROUP BY f.title, f.rating
HAVING COUNT(*) BETWEEN 9 AND 12
ORDER BY f.title;

-- Construct a query that displays the following results from a query against the film, inventory, 
-- rental, and customer tables where the film's title starts with 'C' and the film has been rented 
-- at least twice; and order the results by ascending order of title.
SELECT f.title, f.rating, COUNT(*)
FROM film f 
JOIN inventory i 
ON f.film_id = i.film_id
JOIN rental r 
ON i.inventory_id = r.inventory_id
JOIN customer c 
ON r.customer_id = c.customer_id
WHERE f.title LIKE 'C%'
GROUP BY f.title, f.rating
HAVING COUNT(*) >= 2
ORDER BY f.title;