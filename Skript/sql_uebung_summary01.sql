#SQL Übung Summary 01

#Aufgabe 1
#a)
select id as "ID", customer_id as "Customer_ID", order_date as "Order_Date", shipping_fee as "Shipping_Fee" from orders;

#b) 
select shipping_fee from orders where shipping_fee between 10 and 50;

#Aufgabe 2
#a)
select list_price - standard_cost as "Händlergewinn", id, product_name  from products;

#b)
select list_price - standard_cost as "Händlergewinn", 
	id, product_name, reorder_level ,target_level, 
		(reorder_level * list_price) as "Wert Minimalvorrat", (target_level * list_price) as "Wert Sollvorrat",
			(list_price - standard_cost) * reorder_level  as "Gewinn Minimalvorrat",
				(list_price - standard_cost) * reorder_level  as "Gewinn Sollvorrat" from products;
		
#Aufgabe 3
create view orders_view as
	select id, order_date, ship_name, ship_country_region, shipping_fee from orders where shipping_fee != 0  ;
select * from orders_view;

#Aufgabe 4
#a)
select id, product_id, quantity, unit_price from order_details;
select quantity * unit_price as "Gesamtpreis" from order_details order by Gesamtpreis desc;

#b)
select max(quantity) as "Max Quantity", avg(unit_price) as "Average Price", sum(unit_price) as "Gesamtverkaufspreis" from order_details; 

#c)
select order_details_status.status_name stat, avg(unit_price), max(unit_price), min(unit_price) 
	from order_details, order_details_status where order_details.status_id = order_details_status.id group by stat; 
#d) 
select order_details_status.status_name stat, avg(unit_price), max(unit_price), min(unit_price) 
	from order_details, order_details_status where order_details.status_id = order_details_status.id group by stat having stat != "None";




