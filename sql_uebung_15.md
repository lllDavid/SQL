# SQL Info2 Übungsblatt 15

Wir verwenden die CD-Database, wie beschrieben in den entsprechenden SQL-Files

## Aufgabe 1

Erstelle eine Stored Procedure, die ausgibt, welche Alben in der Datenbank in
den 90er Jahren herausgekommen sind (bzw. wo man Anfangs- und End - Jahreszahl
angeben kann) und diese dann aufgelistet werden inkl. Interpret und
Erscheinungsjahr

## Aufgabe 2

Erstelle eine Stored Procedure, die die durchschnittliche Anzahl der Songs pro
Album angibt (einfach Songs / Alben!)

## Aufgabe 3

Erstelle eine SP, die angibt, welche Interpreten mehr als ein Album in der
Datenbank stehen haben

## Aufgabe 4

Erstelle einen Trigger für die CD-DB, die im Falle des Löschens von Alben in
CD_Albums die ganzen Daten in einer "Backup-Tabelle" inkl. Del.ID und
Zeitstempel speichert (damit man sie wiederherstellen könnte). Dazu muss man
natürlich erst diese  Backup-Tabelle erstellen!