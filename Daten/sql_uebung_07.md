# SQL INFO2 Übungsblatt 7

Es geht wiederum um die DB 'northwind'!

## Aufgabe 1)
Erste Tests zu den JOIN-Methoden: Die Tabellen 'orders' und 'customers' sollen
auf verschiedene Arten miteinander verknüpft werden (über 'customer_id' aus
'orders', die der __Fremd-Schlüssel__ zur Spalte 'id' in 'customers' ist):

### a)
Verbindung mittels eines einfachen JOINS ohne WHERE-Bedingung (Kartesisches
Produkt!)

### b)
Equi-JOIN

### c)
Natural-JOIN

Beachte dabei die unterschiedlichen Ergebnisse!

## Aufgabe 2)
Natural JOIN: Gesucht sind alle Kombinationen von Datensätzen der Tabellen
'orders' und 'customers', die, wie bei **1c)** über 'customer_id' und 'id'
miteinander verbunden werden. Dabei sollen nun allerdings nur die Spalten 'id',
'last_name', 'city' aus 'customers' sowie die Spalten 'order_date', 'ship_name'
und 'ship_state_province' aus 'orders' angezeigt werden.

## Aufgabe 3)

### a)
Finde für die Bestellung mit 'id' 36 in 'orders' den Namen ('last_name' und
'first_name'), den Firmennamen ('company') sowie die 'state_province' des
Käufers ('customers').

### b)
Nun sollen nur die Aufträge ('id', 'order_date', 'shipping_fee' aus 'orders' und
'last_name' sowie 'first_name' aus 'customers'), die von __'Alexander Eggerer'__
und __'Sven Mortensen'__ erteilt wurden, angezeigt werden.

## Aufgabe 4)
Verknüpfung von 3 Tabellen: Finde für jeden Angestellten ('employees') den
Nachnamen ('last_name'), die Auftragsnummer ('id' aus 'orders') aller von diesem
Angestellten bearbeiteten Aufträge und den Namen des Kunden ('last_name' und
'first_name' aus 'customers'), der den jeweiligen Auftrag erteilt hat.

Es reicht, wenn die Angestellten, nach Namen sortiert, untereinander stehen; es
muss nicht danach gruppiert werden.

## Aufgabe 5)
Aus der Tabelle 'products' sollen die Spalten 'id', 'product_name'
'product_code' und 'list_price' angezeigt werden, ergänzt um die Informationen
'company' und 'last_name' aus 'suppliers'.

Bemerkung: In der Spalte 'supplier_ids' sind gelegentlich mehr als eine ID pro
Datensatz angegeben. Dies ist eigentlich eine schlechte Praxis im
Datenbank-Design; wir wollen diese Datensätze erst einmal ignorieren - z.B.
indem man Datensätze mit einem ";" ausschließt (z.B. LIKE %;%).

## Aufgabe 6)
Weitere Verarbeitung: Aus der Tabelle 'purchase_orders' soll die 'id' sowie
'submitted_date' angezeigt werden, ergänzt durch 'quantity', 'unit_cost',
'(quantity * unit_cost)' aus 'purchase_order_details', sowie die zu den
einzelnen Datensätzen passende Spalte 'status' aus 'purchase_order_status'.
