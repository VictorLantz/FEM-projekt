%Detta script k�r hela programmet. F�rst laddas konstanter och mesh-v�rden.
clear; close all;  load('finemesh_2'); load('konstanter');

%Skriv 1 h�r om man vill g�ra tidsstegsloop f�r temp, 0 om man vill hoppa
%�ver:
runtempstep = 1;

%Skriv 1 h�r f�r att ha mesh utritat i figurer, 0 f�r inga linjer.
meshlines = 0;

%Tillkallar koden f�r att l�sa temperaturf�rdelningen:
temperatur;

%Tillkallar koden f�r att l�sa sp�nningsf�rdelningen:
spanningar;