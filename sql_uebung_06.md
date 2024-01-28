# SQL INFO2 Übungsblatt 6

Wir bleiben innerhalb der 'northwind'-DB; dort geht es generell wieder um die
Tabelle 'orders'.

## Aufgabe 1)
Erstelle eine View, mit der die Tabelle **'orders'** erst einmal übersichtlicher
angezeigt wird - also nur mit den Spalten 'id', 'customer_id', 'shipped_date',
'ship_name', 'ship_city' und 'ship_state_province'.

## Aufgabe 2)
Sortiere diese View nun nach einer Spalte, die "Sinn macht" (aufsteigend?
absteigend? Entscheide selbst!). Beachte: Hier soll keine neue View erstellt
werden, sondern ein neuer SELECT-Befehl auf die bestehende View angewendet
werden!

## Aufgabe 3)
Gib an, welche Sendungen jeweils nach

### a)
Denver

### b)
Portland

### c)
Seattle

geschickt wurden und sortiere jeweils absteigend nach 'shipped_date'.

## Aufgabe 4)
Nun wollen wir erfahren:

### a)
Die durchschnittlichen Versandgebühren 'shipping_fee' von allen Sendungen, die
nach Chicago geschickt wurden

### b)
Die Anzahl der Aufträge, die der Mitarbeiter mit der 'employee_id' Nr. 4
verschickt hat - und wiederum die durchschnittlichen 'shipping_fee's davon

### c)
Was waren die günstigsten 'shipping_fee's, was waren die teuersten?

## Aufgabe 5)
Gruppiere die Tabelle 'orders' nach 'ship_city'. Wie viele Aufträge gingen in
die jeweiligen Städte; wieviele Gebühren wurden für die einzelnen Städte fällig?

## Aufgabe 6)
Aus dieser Gruppierung ziehen wir nun diejenigen Städte,

### a)
in die mehr als zwei (2) Bestellungen gingen

### b)
für die mehr als 50($/€) Versandgebühren fällig wurden
