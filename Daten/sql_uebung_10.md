# SQL INFO2 Übungsblatt 10

Die Datenbank bleibt 'northwind'

## Aufgabe 1)
Erweitere eine Suchabfrage der Tabelle 'orders' (dort ausgewählte Spalten:
'customer_id', 'employee_id', 'order_date) um Informationen zum Produkt (Tabelle
'products'; Spalten 'product_name', 'list_price', 'quantity_per_unit' und
'category').

Wichtige Spalten zum Verbinden der Tabellen sind in der Tabelle 'order_details'
zu finden!

## Aufgabe 2)

### a)
Finde Infos über die Kundschaft: Alle Kunden, die mehr als 5 Bestellungen
aufgegeben haben (Tabelle 'orders') sollen in einer Suchabfrage über die besten
Kunden genauer angezeigt werden.

Suche die Tabelle(n), wo Infos über Kunden zu finden sind und lasse dir Daten
wie Firmenname, Kontaktname, Stadt, (US-)Bundesstaat und Telefonnummer anzeigen.

### b)
Sortiere diese Abfrage anschließend noch absteigend, mit den
"besten"(häufigsten) Bestellern zuerst gelistet!

## Aufgabe 3)
Es gibt in der DB auch Daten zum Nachbestellen von Waren ind der Tabelle
'purchase_orders'. Lasse dir dort ein paar Spalten anzeigen (z.B. 'id',
'submitted_date') und ergänze um Lieferantendaten ('suppliers') sowie Daten zu
den bearbeitenden Mitarbeitern ('employees'), also z.B. Jobtitel, Last Name etc.

Finde selbst einen Weg, z.B. mittels "Objekt-Betrachter" in DBeaver, die
entsprechenden Tabellen zu verknüpfen und die daten anzuzeigen.

## Aufgabe 4)
Noch einmal 'orders': Lasse dir den Durchschnitt, Maximal- und Minimalwert von
'shipping_fee' anzeigen, gruppiert nach 'ship_city' - wobei Städte, in die
maximal einmal geliefert wurde, nicht angezeigt werden sollen.

Dazu wäre eine Spalte, die eben diese Anzahl der Lieferungen pro Stadt zeigt,
sinnvoll!

