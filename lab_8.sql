USE sakila;
-- 1.Write a query to display for each store its store ID, city, and country.
-- SELECT * FROM address;
SELECT S.store_id, C.city, CO.country 
FROM store S
JOIN address A
ON S.address_id = A.address_id
JOIN city C
ON A.city_id = C.city_id 
JOIN country CO
ON C.country_id = CO.country_id
ORDER BY S.store_id;

-- 2.Write a query to display how much business, in dollars, each store brought in.

SELECT FORMAT(sum(P.amount),'c', 'en-US') AS '$ per Store' , S.store_id 
FROM store C
JOIN staff S
ON C.store_id = S.store_id
JOIN rental R
ON R.staff_id = S.staff_id
JOIN payment P
ON R.customer_id = P.customer_id
GROUP BY C.store_id
ORDER BY sum(P.amount);


-- 3.Which film categories are longest , I did it as average lenght of the category 
SELECT DISTINCT(C.name) as Category , AVG(FI.length) as "Average Length"
FROM category C
JOIN film_category F
ON C.category_id = F.category_id
JOIN film FI
ON FI.film_id = F.film_id
GROUP BY C.name
ORDER BY FI.length desc;

-- 4.Display the most frequently rented movies in descending order. I show the 10 most rented
SELECT F.title,COUNT(I.film_id) as number_of_rentals
FROM rental R
JOIN inventory I 
ON R.inventory_id = I.inventory_id
JOIN film F
ON I.film_id = F.film_id
GROUP BY F.title
ORDER BY number_of_rentals DESC
LIMIT 10;


-- 5.List the top five genres in gross revenue in descending order.

SELECT C.name AS Category,SFC.total_sales
FROM film F
JOIN film_category FC
ON F.film_id = FC.film_id
JOIN category C
ON FC.category_id = C.category_id
JOIN sales_by_film_category SFC
ON C.name = SFC.category
GROUP BY SFC.category 
ORDER BY SFC.total_sales desc
LIMIT 5;

-- 6.Is "Academy Dinosaur" available for rent from Store 1?
SELECT COUNT(I.inventory_id) AS "Amount available", F.title, I.store_id
FROM inventory I 
JOIN film F 
ON I.film_id = F.film_id
WHERE F.title = "Academy Dinosaur" AND I.store_id = 1
GROUP BY F.title;

SELECT * FROM film;

-- 7.Get all pairs of actors that worked together.

SELECT A1.actor_id as "1stActor", A2.actor_id as '2ndActor', F.title as Movie
FROM film_actor A1
JOIN film_actor A2
ON (A1.actor_id <> A2.actor_id) AND (A1.film_id = A2.film_id) 
JOIN film F 
ON F.film_id = A2.film_id
ORDER BY A1.actor_id;


-- 8.Get all pairs of customers that have rented the same film more than 3 times.
SELECT R1.customer_id AS C1,R2.customer_id AS C2
FROM sakila.rental AS R1
INNER JOIN sakila.rental AS R2 ON R1.rental_id != R2.rental_id
INNER JOIN inventory AS I3 ON R1.inventory_id = I3.inventory_id 
WHERE I3.film_id = I3.film_id
AND R1.inventory_id = R2.inventory_id
GROUP BY C1, C2
HAVING COUNT(Distinct R1.rental_id) > 3
;	



-- 9.For each film, list actor that has acted in more films.

SELECT A1.first_name, A1.last_name, F3.title
FROM sakila.actor AS A1
JOIN sakila.film_actor AS FA2 ON A1.actor_id = FA2.actor_id
JOIN sakila.film AS F3 ON FA2.film_id = F3.film_id
GROUP BY A1.actor_id, A1.first_name, A1.last_name, F3.title