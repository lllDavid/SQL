-- SQL INFO2 Übungsblatt 9

-- Aufgabe 1
-- a)
SELECT * FROM orders WHERE orders.order_date BETWEEN '2006-01-01'
    AND '2006-02-01';
-- oder
SELECT * FROM orders WHERE orders.order_date BETWEEN '2006-01-01'
    AND ADDDATE('2006-01-01', INTERVAL 1 MONTH);

-- b)
SELECT * FROM orders WHERE orders.order_date BETWEEN '2006-02-01'
    AND ADDDATE('2006-02-01', INTERVAL 1 QUARTER);
    
-- c)
SELECT * FROM orders WHERE orders.order_date BETWEEN '2006-04-01'
    AND ADDDATE('2006-04-01', INTERVAL 1 WEEK);
    
-- d)
-- z.B. Anzeige in Tagen:
SELECT id, (shipped_date - order_date) FROM orders;

-- Anzeige mittels DATEDIFF():
SELECT id, DATEDIFF(shipped_date, order_date) FROM orders;

-- e)
SELECT id, DATEDIFF(CURRENT_DATE(), order_date) FROM orders;

-- 2)
-- a)
SELECT ABS(MAX(unit_price * quantity) - MIN(unit_price * quantity))
    FROM order_details WHERE id = 40 OR id = 42;
    
-- b)
SELECT SUM(quantity) FROM order_details;

-- c)
SELECT CEILING(standard_cost * reorder_level) AS 'Aufgerundet' FROM products
    WHERE products.id BETWEEN 40 AND 80;
    
SELECT FLOOR(standard_cost * reorder_level) AS 'Abgerundet' FROM products
    WHERE products.id BETWEEN 40 AND 80;
    
SELECT ROUND(standard_cost * reorder_level) AS 'Gerundet' FROM products
    WHERE products.id BETWEEN 40 AND 80;
    
-- d) - z.B. mit Modulo:
SELECT (reorder_level % 2) AS 'Ungerade' FROM products;

-- e)
SELECT (target_level * standard_cost) - (reorder_level * standard_cost)
    AS 'Einsparpotential' FROM products;