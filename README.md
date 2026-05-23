# Awesome SQL Databases

Colectie de rezolvari pentru exercitii individuale din laboratoarele BD
de pe OCW (UPB). In acest repo sunt incluse doar fisierele cerute, fara
alte materiale din folderele originale.

## Structura

- `LAB2/` - cerinta1-6.sql
- `LAB3/` - cerinta1.1-1.4.sql
- `LAB4/` - ex1.sql - ex4.sql
- `LAB5/` - ex1.sql
- `LAB6/` - ex1.sql
- `LAB7/` - ex1.sql, ex2.sql
- `LAB8/` - ex1.sql
- `LAB9/` - ex1.sql, ex2.sql, ex3-1.sql, ex3-2.sql, ex3-3.sql

## Laboratoare si exercitii individuale (enunturi)

Enunturile de mai jos sunt preluate din `BD_Laboratoare_01-11_complet.pdf`.

### Laborator 02 - Introducere in SQL si SQL*Plus

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/02

Exercitii individuale:
- Ex. 1. Să se implementeze o bază de date pentru un Blog folosind următoarea diagramă.
- Ex. 2. Să se implementeze o bază de date pentru un rețete culinare folosind următoarea diagramă.
- Ex. 3. Să se implementeze o bază de date pentru o flota de masini folosind următoarea diagramă.
- Ex. 4. Să se implementeze o bază de date pentru o florărie folosind următoarea diagramă.
- Ex. 5. Să se implementeze o bază de date pentru o bibliotecă folosind următoarea diagramă.
- Ex. 6. Să se implementeze o bază de date pentru cântece folosind următoarea diagramă.

Fisiere incluse:
- `LAB2/cerinta1.sql` - `LAB2/cerinta6.sql`

### Laborator 03 - Variabile substituite in SQL*Plus

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/03

Exercitii individuale:
- 1. Să se scrie o comandă SQL care listează toți angajații dintr-un departament (introdus ca parametru de la tastatură), care au venitul anual peste un venit mediu anual (introdus tot de la tastatură). Să se afișeze numele angajatului, id-ul de departamentul, venitul anual. Dați cel puțin 4 metode de rezolvare.

Fisiere incluse:
- `LAB3/cerinta1.1.sql` - `LAB3/cerinta1.4.sql`

### Laborator 04 - Cereri SQL

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/04

Exercitii individuale:
- 1. Selectați toți angajații care s-au angajat înainte de anul 1982 și nu au primit comision.
- 2. Selectați toți angajații care au salariul peste 3000 și nu au șefi, ordonați după departament.
- 3. Selectați numele, funcția și venitul anual al angajaților care nu au funcția MANAGER pentru un departament introdus de la tastatură.
- 4. Selectați departamentul, numele, data angajării și salariul tuturor persoanelor angajate în anul 1981 din două departamente care se introduc de la tastatură.

Fisiere incluse:
- `LAB4/ex1.sql` - `LAB4/ex4.sql`

### Laborator 05 - Metode de JOIN

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/05

Exercitii individuale:
- 1. Să se facă o listă cu: Nume Angajat, Departament Angajat, Grad Angajat, Nume Sef, Departament Sef, Grad Sef. Sa se afiseze toate rezutlatele, chiar daca nu se gasesc legaturi de JOIN intre intregistrarile din diferitele tabele.

Fisiere incluse:
- `LAB5/ex1.sql`

### Laborator 06 - Functii SQL (I)

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/06

Exercitiu individual:
- Pentru angajatii ce au numele de lungime 4, faceti o lista cu: numele angajatului scris cu litere mari, ziua in care s-au angajat, denumirea departamentului in care lucreaza scrisa cu litere mici, initiala numelui sefului.

Fisiere incluse:
- `LAB6/ex1.sql`

### Laborator 07 - Functii SQL (II)

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/07

Exercitii individuale:
- Ex 1. Să se facă o listă cu: id-ul sefului, numele sefului, numarul de subalterni, numele departamentului din care face parte seful, salariu minim/mediu/maxim pt subalterni.
- Ex 2. Să se facă o listă cu: numele angajatului (formatați prima litera mare și restul mici), departamentul în care lucreaza angajatul (formatați cu litere mici), data angajării pentru angajat (afișati doar luna și anul), prima (calculată conform regulilor de mai jos), gradul salarial în funcție de salariu, numele șefului (formatați prima litera mare și restul mici), departamentul în care lucreaza șeful (formatați cu litere mici). Prima se acorda doar pentru angajații care au gradul salarial 2 sau 4 și au venit în firmă în același an cu șeful lor: dacă angajatul are gradul salarial 2: salariu * sqrt(c * log2(n)); dacă angajatul are gradul salarial 4: salariu * sqrt(c * log3(n)); altfel: 0. Unde n este vechimea în firmă calculată în luni și c este o valoare introdusă de la tastatură (folosiți 0.15 pentru testare). Ordonați rezultatele crescător dupa numele angajatului.

Fisiere incluse:
- `LAB7/ex1.sql`, `LAB7/ex2.sql`

### Laborator 08 - Subcereri SQL (I)

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/08

Exercitiu individual:
- Să se selecteze numele angajatului, numele departamentului si salariul pentru angajatii care au salariul egal cu salariul minim din departamentul in care lucreaza. Ordonati dupa nume. Rezolvati prin 4 metode: o metoda care sa foloseasca o subcerere care intoarce o valoare; o metoda care sa foloseasca o subcerere care intoarce o linie cu mai multe coloane; o metoda care sa foloseasca o subcerere care intoarce mai multe linii cu mai multe coloane; o metoda care sa foloseasca o subcerere in clauza from.

Fisiere incluse:
- `LAB8/ex1.sql`

### Laborator 09 - Subcereri SQL (II)

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/09

Exercitii individuale:
- 1. Să se calculeze și afișeze funcția și venitul mediu lunar pentru fiecare funcție. Să se folosească o subcerere în clauza select.
- 2. Să se facă o listă cu funcție, gradul salarial, salariul mediu angajați calculat după funcție și grad unde salariul mediu angajați este mai mare sau egal cu salariu mediu pentru grad.
- 3. Să se selecteze angajatul/angajații cu cel mai mare venit lunar din departamentul în care lucrează. Afișați numele angajatului, numele departamentului în care lucrează angajatul, funcția angajatului, venitul lunar. Ordonați după numele departamentului. Să se rezolve fără a folosi funcții agregate (de grup). Rezolvati in 3 metode, folosind: operatorul some/any, operatorul all, operatorul exists.

Fisiere incluse:
- `LAB9/ex1.sql`, `LAB9/ex2.sql`, `LAB9/ex3-1.sql`, `LAB9/ex3-2.sql`,
  `LAB9/ex3-3.sql`
