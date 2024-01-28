# SQL INFO2 Übungsblatt 8

## Aufgabe 1)
Zum "Spaß": Erstelle das kartesische Produkt (Standard JOIN; Ohne
WHERE-Bedingung!) von möglichst vielen (allen?) Tabellen der 'northwind'-DB.
Wieviele Datensätze kann man sich erzeugen lassen?

ACHTUNG: Abhängig von der Menge der verknüpften Datensätze wird dieses
Unterfangen sehr schnell SEHR Ressourcenhungrig! Die Empfehlung ist deshalb,
sich erst einmal "von unten heranzutasten" mit dem Verknüpfen von 3 bis 4
Tabellen.

Außerdem: Tabellen, die keinen Inhalt haben (also 0 Datensätze) führen nicht zum
Ziel, da X Datensätze mal 0 immer 0 ergibt!

## Aufgabe 2)
Bestellvorgänge: Lasse dir für jeden Datensatz aus der Tabelle 'purchase_orders'
den 'last_name' sowie 'job_title' des 'employees' anzeigen, der in
'purchase_orders' bei 'submitted_by' zu finden ist.

Füge von 'purchase_orders' außerdem noch die 'id', 'creation_date' sowie die
ausgeschriebene 'status_id' hinzu.

Versuche diesmal, eigenständig die notwendigen Spalten zur Tabellen-Verknüpfung
sowie die Tabelle/Spalte mit den Infos zur 'status_id' zu finden!

## Aufgabe 3)
Wie in der vorangegangenen Aufgabe wollen wir nun Supplier-Daten anfügen:
Verbinde wieder die 'id, 'creation_date' aus 'purchase_orders' mit
'company', 'last_name' und 'job_title' aus 'suppliers'.

## Aufgabe 4)
Es soll eine ausführlichere Variante der 'inventory_transactions'-Tabelle
erstellt werden. Beschränke dich dort auf 'id' und 'transaction_created_date'
und füge die ausführlichen Daten (evtl. auch mehrspaltig!) anstelle von
'transaction_type' und 'product_id' hinzu.

Wenn Zeit ist, besinne dich eventuell auch zurück auf das 'AS'-Statement und gib
den jeweiligen Spalten einen schöneren Namen!.

## Aufgabe 5)
Lasse dir jetzt Kunden anzeigen ('company', 'last_name', 'job_title' in
'customers'), die ein durchschnittliches __'shipping_fee'__ von mehr als 50($/€)
verursachen!
