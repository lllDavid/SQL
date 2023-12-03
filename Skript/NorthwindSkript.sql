-- Aufgabe 1

SELECT * FROM orders  ORDER BY customer_id asc;
SELECT * FROM orders ORDER BY customer_id desc;

-- Aufgabe 2

SELECT SUM(shipping_fee) FROM orders;

SELECT SUM(shipping_fee) FROM orders; WHERE ship_city = "Las Vegas" OR ship_city="Chicago" OR ship_city="Milwaukee";


SELECT ship_city SUM(shipping_fee);FROM orders; WHERE ship_city = "Las Vegas" OR "Chicago" OR "Milwaukee";
	GROUP BY ship_city;

SELECT ship_city, SUM(shipping_fee) AS "Summe pro Stadt" FROM orders 
	GROUP BY ship_city;

-- Aufgabe 3

SELECT ship_city , AVG(shipping_fee) FROM orders
	GROUP BY ship_city;
	
SELECT AVG(shipping_fee) FROM orders 
	WHERE employee_id = 9;
	
-- Aufgabe 4

SELECT MIN(shipping_fee) , MAX(shipping_fee) FROM orders;

SELECT MIN(shipping_fee) , MAX (shipping_fee) FROM orders WHERE ship_state_province = "NY";


-- Aufgabe 5

SELECT Count(*) FROM orders;

SELECT Count(customer_id) FROM orders;

------------------------------------- Tests -------------------------------------------------

Update customers set job_title ="NotOwner" where job_title ='Owner' ;
Select * from customers;


create view aufgabe2 as select id,customer_id,shipped_date,ship_city  from orders;
select * from aufgabe2;


select * from aufgabe2 order by id desc;


select ship_city from orders where ship_city="Los Angeles" or "New York";





