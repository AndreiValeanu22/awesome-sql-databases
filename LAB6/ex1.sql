SELECT
    UPPER(e.ename)                  AS nume_angajat,
    EXTRACT(DAY FROM e.hiredate)    AS zi_angajare,
    LOWER(d.dname)                  AS departament,
    SUBSTR(m.ename, 1, 1)           AS initiala_sef
FROM emp e
JOIN dept d ON d.deptno = e.deptno
LEFT JOIN emp m ON m.empno = e.mgr
WHERE LENGTH(e.ename) = 4;

/*
Am pus **JOIN** pentru că trebuie să leg `emp` cu `dept` ca să afișez denumirea departamentului. Dacă nu faci join, nu ai `dname`.

Am pus **LEFT JOIN** pe șef (`emp m`) ca să nu pierzi angajații care nu au șef (`mgr` este NULL). Dacă folosești `INNER JOIN`, acei angajați dispar din rezultat.  

Dacă știi sigur că toți au șef, poți schimba cu `JOIN` simplu.
*/

/**

RPAD(str1, n[,str2]) 	adaugă la dreapta lui str1 caracterele din str2 până la lungimea n iar dacă str2 lipseșe adaugă spațiu
LPAD(str1, n[,str2]) 	adaugă la stânga lui str1 caracterele din str2 până la lungimea n iar dacă str2 lipseșe adaugă spațiu

da-mi exemplu in sql






Iată câteva exemple practice pentru utilizarea funcțiilor LPAD și RPAD în SQL (sunt folosite frecvent în Oracle, MySQL sau PostgreSQL):
## 1. Exemplu LPAD (Left Pad)
Se folosește des pentru a formata numere (de exemplu, pentru a adăuga zerouri în față).

SELECT LPAD('123', 5, '0') AS rezultat;-- Rezultat: '00123'-- Explicație: Adaugă '0' la stânga până când șirul are 5 caractere.

## 2. Exemplu RPAD (Right Pad)
Se folosește pentru a alinia textul sau pentru a crea rapoarte vizuale simple.

SELECT RPAD('Salariu', 10, '*') AS rezultat;-- Rezultat: 'Salariu***'-- Explicație: Adaugă '*' la dreapta până când șirul are 10 caractere.

## 3. Exemplu fără al treilea parametru (spațiu implicit)
Dacă nu specifici ce caracter să adauge, ambele funcții vor folosi spațiul.

SELECT LPAD('Test', 7) AS rezultat;-- Rezultat: '   Test' (3 spații la început)

## 4. Utilizare într-un tabel real
Imaginează-ți că vrei să afișezi numele angajaților și să completezi cu puncte până la o anumită lungime pentru un tabel:

SELECT RPAD(nume, 15, '.') || salariu AS lista_plataFROM angajati;-- Rezultat tip: 'Ionescu........5000'

Vrei să vezi cum se pot folosi aceste funcții împreună cu SUBSTR sau INSTR pentru a extrage și formata date mai complexe?






Da-mi exemplu de :

ROUND(date, format) 	returnează data prin rotunjirea lui date la formatul format
TRUNC(date, format) 	returnează data prin trunchierea lui date la formatul format
SYSDATE 	returnează data curentă(data de sistem) în diferite formate
EXTRACT(part FROM date) 	extrage partea part din dată date, returnează o valoare numerică

 Folosind operatorii aritmetici + și – se pot face diferite operații cu date calendaristice:

    data + numar – adună un număr de zile la dată, returnând tot o dată calendaristică ;
    data – numar – scade un număr de zile la dată, returnând tot o dată calendaristică ;
    data1 – date2 – scade date2 din date1 , returnând numărul de zile ;
    data – numar /24 – adună la dată un număr de ore, returnează tot o dată calendaristică.







Iată exemple practice în SQL (standard Oracle, unde aceste funcții sunt cel mai des utilizate) pentru manipularea datelor calendaristice:
## 1. Funcțiile ROUND și TRUNC
Acestea funcționează similar cu rotunjirea numerelor, dar aplicate pe unități de timp (an, lună, zi).

-- TRUNC: Taie tot ce urmează după unitatea specificată (merge la începutul perioadei)SELECT TRUNC(TO_DATE('15-OCT-2023'), 'YEAR') AS inceput_an,   -- Rezultat: 01-JAN-2023
       TRUNC(TO_DATE('15-OCT-2023'), 'MONTH') AS inceput_luna  -- Rezultat: 01-OCT-2023FROM dual;
-- ROUND: Rotunjește la cea mai apropiată unitate (peste jumătate trece la următoarea)SELECT ROUND(TO_DATE('20-OCT-2023'), 'MONTH') AS luna_proxima, -- Rezultat: 01-NOV-2023 (20 e > 15)
       ROUND(TO_DATE('10-OCT-2023'), 'MONTH') AS luna_curenta  -- Rezultat: 01-OCT-2023 (10 e < 15)FROM dual;

## 2. SYSDATE și EXTRACT
SYSDATE oferă data și ora curentă a serverului, iar EXTRACT scoate o componentă numerică specifică.

SELECT SYSDATE AS data_azi,
       EXTRACT(YEAR FROM SYSDATE) AS anul,
       EXTRACT(MONTH FROM SYSDATE) AS luna,
       EXTRACT(DAY FROM SYSDATE) AS ziuaFROM dual;

## 3. Operatori aritmetici (+ și -)
În SQL, când aduni sau scazi un număr dintr-o dată, unitatea de măsură implicită este ziua.

-- Adunare și scădere de zileSELECT SYSDATE + 7 AS peste_o_saptamana,
       SYSDATE - 1 AS ieriFROM dual;
-- Diferența dintre două date (returnează numărul de zile)SELECT TO_DATE('31-DEC-2023') - TO_DATE('01-DEC-2023') AS zile_in_decembrieFROM dual; -- Rezultat: 30
-- Adunare de ore (numar/24)SELECT SYSDATE + (5/24) AS peste_5_ore,
       SYSDATE + (10/1440) AS peste_10_minute -- 1440 minute are o ziFROM dual;

## Exemplu combinat (Scenariu real)
Calcularea vechimii și a zilelor rămase până la finalul lunii pentru un angajat:

SELECT 
    nume, 
    SYSDATE - data_angajare AS zile_vechime,
    TRUNC(LAST_DAY(SYSDATE)) - SYSDATE AS zile_pana_la_salariuFROM angajati;

Vrei să încerci câteva exerciții de calcul pentru intervale de timp mai complexe (luni sau ani) folosind funcția MONTHS_BETWEEN?






Deci SYSDATE se modeleaza in functie de cu e data, fie zi, fie an, fie luna, fie secol etc, corect?




Exact. SYSDATE este o funcție dinamică: ea returnează un „pachet” complet care conține anul, luna, ziua, ora, minutul și secunda din momentul executării interogării.
Modul în care se „modelează” depinde de ce vrei să faci cu ea:

   1. Vizual (Formatare): Deși ea conține tot, baza de date ți-o afișează implicit într-un format setat la nivel de sistem (ex: DD-MON-RR). Dacă vrei să vezi doar anul sau doar ora, folosești TO_CHAR(SYSDATE, 'YYYY').
   2. Prin Trunchiere/Rotunjire (TRUNC/ROUND): Aici „tai” precizia. Dacă dai TRUNC(SYSDATE, 'MM'), păstrezi anul și luna, dar ziua devine prima zi a lunii respective, iar ora devine 00:00:00.
   3. Prin Extracție (EXTRACT): Când vrei doar valoarea numerică a unei componente (ex: EXTRACT(YEAR FROM SYSDATE) îți dă pur și simplu numărul 2024).
   4. Aritmetic: Dacă aduni 1, SQL știe că te referi la o unitate de măsură de tip zi, deci va mări data cu 24 de ore.

Exemplu scurt de "modelare" a aceleiași valori SYSDATE:

* TRUNC(SYSDATE, 'YY') -> Te duce la 01-JAN al anului curent.
* TRUNC(SYSDATE, 'MM') -> Te duce la ziua de 1 a lunii curente.
* SYSDATE + 7 -> Te duce în aceeași zi și oră, dar peste o săptămână.

Vrei să vezi cum poți extrage și secundele sau numele zilei de săptămână (ex: "Luni") din SYSDATE?






Exact! Pentru a extrage elemente precum secundele sau numele zilei, cea mai folosită și flexibilă metodă în SQL (Oracle) este funcția TO_CHAR.
Iată cum poți "modela" SYSDATE pentru aceste detalii specifice:
## 1. Extragerea numelui zilei (Luni, Marți, etc.)
Poți obține numele complet sau prescurtat.

SELECT 
    TO_CHAR(SYSDATE, 'DAY') AS nume_complet, -- Returnează ex: 'MONDAY   ' (cu spații până la 9 caractere)
    TO_CHAR(SYSDATE, 'fmDAY') AS nume_fara_spatii, -- 'fm' elimină spațiile de completare
    TO_CHAR(SYSDATE, 'DY') AS nume_scurt,    -- Returnează ex: 'MON'
    TO_CHAR(SYSDATE, 'D') AS numar_zi_sapt   -- Returnează cifra zilei (ex: 1 pentru Duminică sau Luni, depinde de setări)FROM dual;

## 2. Extragerea secundelor și timpului detaliat
Pentru secunde, folosim masca de formatare SS.

SELECT 
    TO_CHAR(SYSDATE, 'SS') AS secunde_doar,        -- Doar secundele (00-59)
    TO_CHAR(SYSDATE, 'HH24:MI:SS') AS timp_complet -- Ora:Minut:Secundă (format 24h)FROM dual;

## 3. Diferența dintre EXTRACT și TO_CHAR pentru secunde
Este important de reținut:

* TO_CHAR returnează un șir de caractere (text). Este ideal pentru afișare.
* EXTRACT returnează un număr. Totuși, în Oracle standard, EXTRACT(SECOND FROM SYSDATE) poate da uneori eroare deoarece SYSDATE este tratat ca tip DATE (care oficial în standardul ANSI nu include secunde, deși Oracle le stochează).
* Soluția pentru numere: Dacă vrei secundele ca număr pentru calcule, poți folosi SYSTIMESTAMP:

SELECT EXTRACT(SECOND FROM SYSTIMESTAMP) AS secunde_numeric FROM dual;


## Rezumat de "modelare" rapidă:

| Ce vrei să obții | Cod Format (TO_CHAR) | Rezultat Exemplu |
|---|---|---|
| Nume zi complet | 'fmDAY' | LUNI |
| Nume zi scurt | 'DY' | MON / LUN |
| Secunde | 'SS' | 45 |
| Ziua din an | 'DDD' | 085 (a 85-a zi din an) |
| Săptămâna din an | 'WW' | 12 |

Te-ar ajuta să vezi cum poți schimba limba în care sunt afișate numele zilelor (de exemplu, din English în Romanian) direct din interogare?







De ce in primul exemplu ai scrie fmaDAY (ce inseamna fm?), sau DY (ce inseamna DY?), sau D?




Acestea se numesc modele de formatare (format models). Ele sunt coduri speciale care îi spun bazei de date exact ce și cum să extragă dintr-o dată calendaristică.
Iată explicația pentru fiecare:
## 1. Ce înseamnă fm (Fill Mode)?
Implicit, Oracle adaugă spații goale la finalul numelui unei zile (sau luni) pentru ca toate să aibă aceeași lungime (lungimea celei mai lungi zile, de exemplu "WEDNESDAY" are 9 caractere).

* Fără fm: TO_CHAR(date, 'DAY') returnează 'MONDAY ' (cu 3 spații la final).
* Cu fm: TO_CHAR(date, 'fmDAY') elimină acele spații inutile și returnează exact 'MONDAY'.
* Notă: fm funcționează ca un comutator (toggle): prima dată când apare elimină spațiile/zerourile de umplere, a doua oară le activează la loc.

## 2. Ce înseamnă DY?
Este codul pentru numele prescurtat al zilei.

* DAY (complet): MONDAY, TUESDAY, etc.
* DY (abreviat): MON, TUE, WED, etc. (de obicei primele 3 litere).

## 3. Ce înseamnă D?
Este codul pentru ziua numerică a săptămânii.

* Returnează un număr de la 1 la 7.
* Atenție: Rezultatul depinde de setările regionale ale bazei de date (NLS_TERRITORY). În unele țări (ca SUA), săptămâna începe cu Duminică (1), în altele cu Luni.

------------------------------
## Tabel rapid de referință pentru coduri de zi:

| Cod | Explicație | Rezultat (Exemplu) |
|---|---|---|
| DAY | Numele complet (cu spații de umplere) | 'MONDAY ' |
| fmDAY | Numele complet (fără spații) | 'MONDAY' |
| DY | Numele scurt (abreviat) | 'MON' |
| D | Numărul zilei în săptămână | 2 (dacă Luni e a 2-a zi) |
| DD | Ziua din lună | 25 |
| DDD | Ziua din an (1-366) | 084 |

Vrei să vezi cum poți forța afișarea în limba română (ex: "LUNI" în loc de "MONDAY") folosind un al treilea parametru în TO_CHAR?



**/