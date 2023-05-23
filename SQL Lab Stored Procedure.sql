USE sakila;

-- starting query 

  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
  -- stored procedure 
  
  CREATE PROCEDURE GetActionCustomers()
BEGIN
  SELECT first_name, last_name, email
  FROM customer
  JOIN rental ON customer.customer_id = rental.customer_id
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON film.film_id = inventory.film_id
  JOIN film_category ON film_category.film_id = film.film_id
  JOIN category ON category.category_id = film_category.category_id
  WHERE category.name = "Action"
  GROUP BY first_name, last_name, email
END

-- dynamic stored procedure 

EXEC GetCustomersByCategory('Action');
EXEC GetCustomersByCategory('Animation');
EXEC GetCustomersByCategory('Children');
EXEC GetCustomersByCategory('Classic');

--  check the number of movies released in each movie category

SELECT category.name, COUNT(film_id) AS movie_count
FROM category
JOIN film.category ON category.category_id = film.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

CREATE PROCEDURE GetCategories(MovieCount INT)
BEGIN
  SELECT category.name, COUNT(film.film_id) AS movie_count
  FROM category
  JOIN film_category ON category.category_id = film_category.category_id
  JOIN film ON film_category.film_id = film.film_id
  GROUP BY category.name
  HAVING movie_count > minMovieCount;
END 







-- 


  