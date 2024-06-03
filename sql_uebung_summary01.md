# Zusammenfassende Übung zu bis jetzt gelernten SQL-Konzepten

## Wir benutzen die Datenbank "northwind" (klein geschrieben in MariaDB!)

### Aufgabe 1

#### a)
In der Tabelle "orders", wähle die Spalten "id", "customer_id", "order_date" und
"shipping_fee" zur Anzeige aus. Vergib auch aussagekräftigere Spaltennamen mit
der AS-Klausel

#### b)
Erweitere den Code aus a) und lasse dir nur Datensätze anzeigen, die in einem
"shipping_fee"-Bereich von mindestens 10, höchstens 50 liegen

### Aufgabe 2

#### a)
Die Tabelle "products" enthält eine Spalte "standard_cost" und eine Spalte
"list_price" - also so in etwa Einkaufspreis und Listenpreis. Berechne daraus
den Händlergewinn **pro Produkt und Stück**
Lasse dir dazu aber auch wichtige Infos wie z.B. ID und Produktname anzeigen!

#### b)
In "products" gibt es auch die Spalten "reorder_level" und "target_level" - also
Ziel-Zahlen, ab wann nachbestellt werden soll und wieviel normalerweise auf
Lager sein sollte.
Lasse dir hier den Verkaufswert (Listenpreis!) der jeweiligen Menge in diesen
beiden Spalten anzeigen sowie den Gesamtgewinn!

### Aufgabe 3
Es soll eine View erstellt werden, die die Tabelle "orders" etwas überschaubarer
macht. Wähle daraus die Spalten "id","order_date" "ship_name" und
"ship_country_region" aus und schließe Datensätze aus, bei denen kein
"shipping_fee" fällig wird!

### Aufgabe 4

#### a)
Ziehe aus der Tabelle "order_details" die Spalten "id", "product_id", "quantity"
(also Stückzahl) und "unit_price" (Stückpreis) und berechne außerdem den
Gesamtpreis der Bestellung. Sortiere den Datensatz dann nach diesem Gesamtpreis,
absteigend!

#### b)
Finde nun aus derselben Tabelle die maximale Stückzahl und den
durchschnittlichen Stückpreis heraus! Summiere auch noch den
Gesamt-Verkaufspreis aller Bestellungen auf!

#### c)
Gruppiere nun die Tabelle "order_details" nach "status_id" und lasse dir pro
Gruppe nochmals den Durchschnitt, Max. und Min. für "unit_price" anzeigen!
Bonus-Aufgabe: Setze für den "status_id" gleich den "ausgeschriebenen" Wert ein
(zu finden in der Tabelle "order_details_status) und gruppiere erst dann!

#### d)
wie c), filtere dabei jedoch die Kategorie (status_id) 0/"None" heraus (HAVING!)
Eventuell ist etwas 'rumprobieren notwendig!

### Aufgabe 5
Bei den JOINS-Aufgaben ist es im Fall der northwind-DB relativ egal, ob mit der
"zu Fuß"-Methode, wie ursprünglich gelernt (also: INNER JOIN) oder ob mit
LEFT/RIGHT JOIN gearbeitet wird. Es bleibt also freigestellt!

#### a)
JOINS: Erstelle eine Tabelle, in der die Spalten "employee_id" und "customer_id"
aus der Tabelle "orders" ersetzt werden durch die jeweiligen last - und first
names in den Tabellen "employees" und "customers"! Beschränke dich dabei beim
Rest der "orders"-Tabelle aufs Wesentliche (z.B. nur id, order_date und die oben
verlangten Spalten)

#### b)
Nun soll für jedes bestellte Produkt in "order_details" eine ausführliche
Zusammenfassung erstellt werden, indem die verschiedenen "id"-Spalten durch ihre
eigentlichen Werte ersetzt werden. Durchforste dazu selbständig die nortwhind-DB
nach den zusammen gehörenden Spalten und verknüpfe sie passend! Die Spalten
"discount" und "date_allocated" können weggelassen werden!

### Aufgabe 6
Einfach: Lasse dir nur Datensätze in "orders" anzeigen, die in den
US-Staat ("ship_state_province") "NY" geschickt wurden!
