USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT st.store_id, ci.city, co.country
FROM store AS st
LEFT JOIN address AS a
ON st.address_id = a.address_id
JOIN city AS ci
ON a.city_id = ci.city_id
JOIN country AS co
ON ci.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT st.store_id, sum(p.amount)
FROM store AS st
JOIN customer AS c
ON st.store_id = c.store_id
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY st.store_id;

-- 3. Which film categories are longest?

SELECT c.name, MAX(f.length) AS duration
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id =f.film_id
GROUP BY c.name
ORDER BY MAX(f.length) DESC;

-- 4. Display the most frequently rented movies in descending order.

SELECT f.title, count(r.rental_id) AS rentals
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY count(r.rental_id) DESC;

-- 5. List the top five genres in gross revenue in descending order.

SELECT ca.name, SUM(p.amount) AS "Gross revenue"
FROM category AS ca
JOIN film_category AS fc
ON ca.category_id = fc.category_id
JOIN inventory AS i
ON fc.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
JOIN payment AS p
ON r.customer_id = p.customer_id
GROUP BY ca.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?

SELECT f.title, i.store_id
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
WHERE f.title = "ACADEMY DINOSAUR" AND i.store_id = "1"
GROUP BY f.title;

-- 7. Get all pairs of actors that worked together.

SELECT DISTINCT a1.first_name AS Act1_first_name, a1.last_name AS Act1_last_name, a2.first_name AS Act2_first_name, a2.last_name AS Act2_last_name
FROM film_actor fa1
INNER JOIN actor a1 
ON fa1.actor_id = a1.actor_id
INNER JOIN film_actor fa2 
ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
INNER JOIN actor a2 
ON fa2.actor_id = a2.actor_id;