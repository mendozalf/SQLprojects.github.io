USE Sakila;
SELECT LENGTH('Salmon');
SELECT LOCATE('mo', 'Salmon');
SELECT STRCMP('Salmon', 'SALMON');
SELECT STRCMP('Salmon', 'Tuna');
SELECT STRCMP('Tuna', 'Salmon');

SELECT first_name, LENGTH(first_name) AS "String Length",
	LOCATE('an', first_name) AS "'an' found",
    STRCMP('Ed', first_name)
FROM actor
ORDER BY first_name;

SELECT CONCAT(last_name, ", ", first_name) AS 'Full Name'
FROM actor;

SELECT INSERT("I love salmon", 7, 0, " smoked");

SELECT REPLACE("I love salmon", "salmon", "tuna");

SELECT first_name, REPLACE(first_name, "ED", "Eddie")
FROM actor;

SELECT title, SUBSTRING(title, 3, 5)
FROM film;

SELECT title, LOCATE("OO", title)
FROM film;

SELECT title
FROM sakila.film
WHERE SUBSTRING(title, LOCATE("OO", title), 2)='OO';

SELECT * FROM sakila.payment;

SELECT DATE_FORMAT(NOW(), "%M %D %Y"),
		SYSDATE(),
        CURRENT_DATE(),
        CURRENT_TIME(),
        UTC_DATE(),
        UTC_TIME();

SELECT payment_date, 
CONCAT(DATE_FORMAT(payment_date, "%m/%d/%Y"), TIME_FORMAT(payment_date, " %h:%I %p"))
FROM payment;

SELECT payment_date, last_update,
	DATEDIFF(payment_date, last_update)
FROM payment;

SELECT payment_date, DATE_ADD(payment_date, INTERVAL 5 DAY)
FROM payment;

SELECT amount,
	ROUND(amount,1),
    CEIL(amount),
    FLOOR(amount),
    TRUNCATE(amount,1)
FROM payment;

INSERT INTO actor
VALUES(DEFAULT, "Sam", "I AM", DEFAULT);

SELECT * FROM actor
ORDER BY actor_id DESC;

INSERT INTO actor(first_name, last_name)
VALUES("Richard", "Salmon");

SELECT * FROM sakila.actor
ORDER BY actor_id DESC;


UPDATE actor
SET first_name = "Bob", last_name = "Trout"
WHERE actor_id = 203;

DELETE
FROM actor
WHERE actor_id IN(202,203);

-- Exercise 7-1
-- Write a query that returns the 17th through 25th characters
-- of the string 'Please find the substring in this string'.
SELECT SUBSTRING("Please find the substring", 17, 9) AS parsed;

-- Exercise 7-2
-- Write a query that returns the absolute value and sign (−1, 0, or 1) of 
-- the number −25.76823. Also return the number rounded to the nearest hundredth.

SELECT ABS(-25.76823) abs, SIGN(-25.76823) sign, ROUND(-25.76823, 2) round;

-- Exercise 7-3
-- Write a query to return just the month portion of the current date.
SELECT EXTRACT(MONTH FROM CURRENT_DATE()) month;

SET @string := 'Sorcer''s Stone';
SELECT REPLACE(@string, 'er', 'erer') title;

SET @string := '2024-02-29';
SELECT @string date;
SELECT DATE_FORMAT(DATE(@string), '%d-%b-%y') date;




