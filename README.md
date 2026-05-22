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

## Laboratoare si exercitii individuale (rezumat)

Fiecare laborator are cerintele complete si imaginile in pagina OCW.
Mai jos sunt rezumate (parafrazate) pentru exercitiile individuale.

### Laborator 02 - Introducere in SQL si SQL*Plus

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/02

Exercitii individuale (rezumat):
- Baza de date pentru blog (tabele si relatii din diagrama).
- Baza de date pentru retete culinare.
- Baza de date pentru flota de masini.
- Baza de date pentru florarie.
- Baza de date pentru biblioteca.
- Baza de date pentru cantece.

Fisiere incluse:
- `LAB2/cerinta1.sql` - `LAB2/cerinta6.sql`

### Laborator 03 - Variabile substituite in SQL*Plus

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/03

Exercitii individuale (rezumat):
- Lista angajati dintr-un departament dat, cu venit anual peste un prag
  dat; afisati nume, id_dep, venit anual. Cerinta rezolvata in mai multe
  metode.

Fisiere incluse:
- `LAB3/cerinta1.1.sql` - `LAB3/cerinta1.4.sql`

### Laborator 04 - Cereri SQL

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/04

Exercitii individuale (rezumat):
- Angajati angajati inainte de 1982 fara comision.
- Angajati cu salariu > 3000 si fara sef, ordonati pe departament.
- Nume, functie, venit anual pentru angajati non-MANAGER intr-un
  departament introdus de la tastatura.
- Departament, nume, data angajarii si salariu pentru angajati din 1981,
  doar din doua departamente introduse de la tastatura.

Fisiere incluse:
- `LAB4/ex1.sql` - `LAB4/ex4.sql`

### Laborator 05 - Metode de JOIN

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/05

Exercitii individuale (rezumat):
- Lista cu nume angajat, departament angajat, grad angajat, nume sef,
  departament sef, grad sef. Afisati toate rezultatele, chiar si fara
  legaturi complete de JOIN intre tabele.

Fisiere incluse:
- `LAB5/ex1.sql`

### Laborator 06 - Functii SQL (I)

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/06

Exercitiu individual (rezumat):
- Pentru angajatii cu nume de lungime 4: numele cu litere mari, ziua
  angajarii, departamentul cu litere mici, initiala sefului.

Fisiere incluse:
- `LAB6/ex1.sql`

### Laborator 07 - Functii SQL (II)

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/07

Exercitii individuale (rezumat):
- Lista cu sef, nume sef, nr. subalterni, departament sef, salariu
  minim/mediu/maxim pentru subalterni.
- Raport complex cu formatare nume/departament, data angajarii,
  prima calculata cu reguli pe grade si vechime, grad salarial si date
  despre sefi; ordonare dupa nume angajat.

Fisiere incluse:
- `LAB7/ex1.sql`, `LAB7/ex2.sql`

### Laborator 08 - Subcereri SQL (I)

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/08

Exercitiu individual (rezumat):
- Angajati cu salariu egal cu salariul minim din departamentul lor;
  afisati nume, departament si salariu. Rezolvare in mai multe metode
  (subcereri diverse).

Fisiere incluse:
- `LAB8/ex1.sql`

### Laborator 09 - Subcereri SQL (II)

Link OCW: https://ocw.cs.pub.ro/courses/bd/laboratoare/09

Exercitii individuale (rezumat):
- Functie si venit lunar mediu per functie, cu subcerere in SELECT.
- Functie, grad salarial, salariu mediu per functie+grad, filtrat fata de
  salariul mediu pe grad.
- Angajatii cu cel mai mare venit lunar in departamentul lor, afisati
  nume, departament, functie, venit lunar; rezolvari cu SOME/ANY, ALL,
  EXISTS (fara functii agregate).

Fisiere incluse:
- `LAB9/ex1.sql`, `LAB9/ex2.sql`, `LAB9/ex3-1.sql`, `LAB9/ex3-2.sql`,
  `LAB9/ex3-3.sql`
