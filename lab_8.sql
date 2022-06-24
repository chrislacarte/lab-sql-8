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


-- 3.Which film categories are longest?
SELECT C.name, F.film_id, FI.length 
FROM category C
JOIN film_category F
ON C.category_id = F.category_id
JOIN film FI
ON FI.film_id = F.film_id
GROUP BY C.name, F.film_id
ORDER BY FI.length desc;

-- 4.Display the most frequently rented movies in descending order.







-- 5.List the top five genres in gross revenue in descending order.

SELECT C.name,SFC.total_sales
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
SELECT I.inventory_id, F.title, I.store_id
FROM inventory I 
JOIN film F 
ON I.film_id = F.film_id
WHERE F.title = "Academy Dinosaur" AND I.store_id = 1;


-- 7.Get all pairs of actors that worked together.

SELECT A1.last_name, A2.last_name
FROM actor A1
JOIN actor A2
ON (A1.last_name <> A2.last_name AND (A1.film_id = A2.film_id)
ORDER BY A1.film_id;



-- 8.Get all pairs of customers that have rented the same film more than 3 times.


-- 9.For each film, list actor that has acted in more films.