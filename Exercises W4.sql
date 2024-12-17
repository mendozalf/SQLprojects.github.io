# Exercise 5-1
# Fill in the blanks (denoted by <#>) for the following query to obtain the results that follow:
USE sakila;
SELECT c.first_name, c.last_name, a.address, ct.city
FROM customer c
	JOIN address a
	ON c.address_id = a.address_id
		JOIN city ct
		ON a.city_id = ct.city_id
			WHERE a.district = 'California';
    
# Exercise 5-2
# Write a query that returns the title of every film in which an actor with the first name JOHN appeared.
SELECT fl.title, ac.first_name
FROM film fl
	JOIN film_actor fa
	ON fl.film_id = fa.film_id
		JOIN actor ac
		ON fa.actor_id = ac.actor_id
			WHERE ac.first_name = 'JOHN';

# Exercise 5-3
# Construct a query that returns all addresses that are in the same city.
# You will need to join the address table to itself, and each row should include two different addresses.
SELECT a1.address address1, a2.address address2, ct.city
FROM address a1
	JOIN address a2
    ON a1.city_id = a2.city_id
    JOIN city ct
    ON a1.city_id = ct.city_id
    JOIN city ci
    ON a2.city_id = ci.city_id
    WHERE NOT a1.address = a2.address;
    
# Write a query that shows all the films starring Joe Swank that have a length between 90 and 120 minutes.
# You will use the actor, film_actor and film tables to answer this question. It should display the following data set:
SELECT ac.first_name, ac.last_name, f.length, f.title
FROM actor ac
JOIN film_actor fa
	ON ac.actor_id = fa.actor_id
    JOIN film f
    ON fa.film_id = f.film_id
	WHERE length BETWEEN 90 AND 120
    AND ac.first_name = 'Joe'
    AND ac.last_name = 'Swank';
    
# Write a query that shows the staff members who rented items. You will use the staff and rental tables to answer this question.
SELECT st.first_name, st.last_name, COUNT(rt.rental_id)
FROM staff st
JOIN rental rt
ON st.staff_id = rt.staff_id
GROUP BY st.first_name, st.last_name;




    



