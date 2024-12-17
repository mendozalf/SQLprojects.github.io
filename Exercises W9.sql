USE sakila;
SELECT c.first_name, sum(p.amount) 
FROM customer c LEFT OUTER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.first_name;

-- Conditionally drop the payment table.
DROP TABLE IF EXISTS payment_backup;

-- Create the payment_backup table.
CREATE TABLE payment_backup AS
  SELECT payment_id
  ,      customer_id
  ,      staff_id
  ,      rental_id
  ,      amount
  ,      payment_date
  ,      last_update
  FROM   payment
  WHERE  customer_id = 
          (SELECT customer_id
           FROM   customer
           WHERE  first_name = 'ELLA'
           AND    last_name = 'OLIVER');
           
DELETE FROM payment
WHERE customer_id = (SELECT customer_id
                     FROM   customer 
                     WHERE  first_name = 'ELLA' 
                     AND    last_name = 'OLIVER');
                     
SELECT CONCAT(c.first_name, ' ' , c.last_name) AS name,
	SUM(p.amount)
    FROM customer c LEFT OUTER JOIN payment p
    ON c.customer_id = p.customer_id
    WHERE c.customer_id IN (1,4,210)
    GROUP BY name
    ORDER BY name;
    
INSERT INTO payment
( payment_id
, customer_id
, staff_id
, rental_id
, amount
, payment_date
, last_update )
( SELECT *
  FROM   payment_backup
  WHERE  customer_id = (SELECT customer_id
                        FROM   customer 
                        WHERE  first_name = 'ELLA' 
                        AND    last_name = 'OLIVER'));

SELECT c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS name,
SUM(p.amount)
FROM customer c LEFT JOIN payment p
ON c.customer_id = p.customer_id
WHERE c.customer_id IN (1,4,210)
GROUP BY c.customer_id, name
ORDER BY name;

SELECT ones.x + tens.x + 1 AS counter
FROM
(SELECT 0 AS x UNION ALL
SELECT 1 AS x UNION ALL
SELECT 2 AS x UNION ALL
SELECT 3 AS x UNION ALL
SELECT 4 AS x UNION ALL
SELECT 5 AS x UNION ALL
SELECT 6 AS x UNION ALL
SELECT 7 AS x UNION ALL
SELECT 8 AS x UNION ALL
SELECT 9 AS x) ones CROSS JOIN
(SELECT 0 AS x UNION ALL
SELECT 10 AS x UNION ALL
SELECT 20 AS x UNION ALL
SELECT 30 AS x UNION ALL
SELECT 40 AS x UNION ALL
SELECT 50 AS x UNION ALL
SELECT 60 AS x UNION ALL
SELECT 70 AS x UNION ALL
SELECT 80 AS x UNION ALL
SELECT 90 AS x) tens
ORDER BY counter;

SELECT f.film_id, f.title, i.inventory_id
FROM inventory i RIGHT JOIN film f 
ON f.film_id = i.film_id
WHERE f.title REGEXP '^RA(I|N).*$'
ORDER BY f.film_id, f.title, i.inventory_id;

SELECT f.film_id, f.title, i.inventory_id
FROM film f LEFT JOIN inventory i
ON f.film_id = i.film_id
WHERE f.title REGEXP '^RA(I|N).*$'
AND i.film_id IS NULL
ORDER BY f.film_id, f.title, i.inventory_id;

 SELECT DISTINCT
         f.film_id left_id
,        i.film_id right_id
,        f.title
FROM     film f NATURAL JOIN inventory i
ORDER BY 1;

SELECT f.film_id left_id
,      i.film_id right_id
,      f.title
FROM   film f RIGHT OUTER JOIN inventory i
ON     f.film_id = i.film_id
WHERE  i.film_id IS NULL
ORDER BY 1;

SELECT  *
FROM   (SELECT 'Yes'   AS reply
    UNION ALL
    SELECT 'No'    AS reply) decided CROSS JOIN
    (SELECT 'Maybe' AS reply) undecided;