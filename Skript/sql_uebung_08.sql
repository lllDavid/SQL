
-- 1)
-- z.B.:
SELECT * FROM customers, employee_privileges, employees,
    inventory_transaction_types, inventory_transactions, invoices,
    order_details, order_details_status;
-- generiert einen Datensatz mit 1,297 Mrd. Zeilen (ca. 5 min. Rechenzeit)
-- evtl. veraltet!

-- 2)
SELECT last_name AS 'Employee Name',
    job_title AS 'Employee Title', purchase_orders.id AS 'Bestellorder Nr.',
    purchase_orders.submitted_date AS 'Datum Bestellung',
    purchase_order_status.status AS 'Bestellstatus'
    FROM purchase_orders, employees, purchase_order_status
    WHERE purchase_orders.submitted_by = employees.id
    AND purchase_orders.status_id = purchase_order_status.id;

-- 3)
SELECT purchase_orders.id AS 'ID (Purchase Orders)',
    purchase_orders.creation_date AS 'Cr.Date (Purchase Orders)',
    suppliers.company AS 'Company (Suppliers)',
    suppliers.last_name AS 'Name (Suppliers)',
    suppliers.job_title AS 'Title (Suppliers)'
    FROM purchase_orders, suppliers
    WHERE purchase_orders.supplier_id = suppliers.id;
    
-- Aufgabe 4)
SELECT inventory_transactions.id AS 'ID (Inv. Trans.)',
    inventory_transactions.transaction_created_date AS 'Date (Inv. Trans.)',
    inventory_transaction_types.type_name AS 'Transaction Type',
    products.product_name AS 'Produktname',
    products.description AS 'Beschreibung', products.category AS 'Kategorie'
    FROM inventory_transactions, inventory_transaction_types, products
    WHERE
    inventory_transactions.transaction_type = inventory_transaction_types.id
    AND inventory_transactions.product_id = products.id;

-- Aufgabe 5)
SELECT customers.id AS 'Kunde ID', customers.company AS 'Kundenfirma',
    customers.last_name AS 'Kunden-Repr.', customers.job_title AS 'Titel',
    AVG(orders.shipping_fee) AS 'Durchschnittl. VersendegebÃ¼hren'
    FROM customers, orders WHERE customers.id = orders.customer_id
    GROUP BY orders.customer_id HAVING AVG(orders.shipping_fee) > 50;