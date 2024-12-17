USE sakila;
# Exercise 4-1 
# Which of the payment IDs would be returned by the following filter conditions?
select payment_id, customer_id, amount, payment_date
from payment
where payment_id between 101 and 120 and
 customer_id <> 5 and (amount > 8 or date(payment_date) = '2005-08-23');

# Exercise 4-1
# Which of the payment IDs would be returned by the following filter conditions?
select payment_id, customer_id, amount, payment_date
from payment
where payment_id between 101 and 120 and
 customer_id = 5 and not (amount > 6 or date(payment_date) = '2005-06-19');
 
# Exercise 4-3
# Construct a query that retrieves all rows from the payment table where the amount is either 1.98, 7.98, or 9.98.
select payment_id, amount
from payment
where amount in (1.98, 7.98, 9.98);

# Exercise 4-4
# Construct a query that finds all customers whose last name contains an A in the second position and a W anywhere after the A.
select *
from customer
where last_name like ('_A%W%');

# Construct a query that finds all customers whose last name contains an E in the second position
select first_name, last_name
from customer
where last_name like ('_E%');