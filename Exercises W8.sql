-- Exercise 9-1
-- Construct a query against the film table that uses a filter 
-- condition with a noncorrelated subquery against the category 
-- table to find all action films (category.name = 'Action').
USE sakila;

SELECT title
FROM film
WHERE film_id IN 
(SELECT fc.film_id
FROM film_category fc
JOIN category c
ON fc.category_id = c.category_id
WHERE c.name = 'Action');

-- Exercise 9-2
-- Rework the query from Exercise 9-1 using a correlated subquery 
-- against the category and film_category tables to achieve the same results.
SELECT f.title
FROM film f
WHERE EXISTS
(SELECT 1
FROM film_category fc
JOIN category c
ON fc.category_id = c.category_id
WHERE c.name = 'Action'
AND fc.film_id = f.film_id);

-- 9.3
SELECT actr.actor_id, grps.level
FROM
(SELECT actor_id, count(*) num_roles
FROM film_actor
GROUP BY actor_id
) actr
 INNER JOIN
(SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles
) grps
ON actr.num_roles BETWEEN grps.min_roles AND grps.max_roles;

-- 9.4
SELECT fa.actor_id, fa.film_id
FROM film_actor fa
WHERE(fa.actor_id, fa.film_id) IN
(SELECT a.actor_id, f.film_id
FROM actor a CROSS JOIN film f
WHERE last_name = 'MONROE'
AND rating = 'PG');

-- 9.5
SELECT fa.actor_id, fa.film_id
FROM  film_actor fa
WHERE EXISTS
(SELECT null
FROM actor a
WHERE
a.last_name = 'MONROE'
AND a.actor_id = fa.actor_id)
AND EXISTS
(SELECT null
FROM film f
WHERE f.rating = 'PG'
AND f.film_id = fa.film_id);




