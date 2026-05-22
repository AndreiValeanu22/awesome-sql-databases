--                                                                      Metoda 4 (&1, &2)

SET VERIFY OFF

SELECT nume,
       id_departament,
       12 * (salariu + NVL(comision,0)) AS venit_anual
FROM angajati
WHERE id_departament = &1
  AND 12 * (salariu + NVL(comision,0)) > &2;

/*
Diferenta dintre cele 4 metode este doar in modul in care se introduc valorile pentru `dep_id` si `venit_med_annual`: La a 4-a metoda, folosim `&1` si `&2` pentru a indica faptul ca sunt parametri care vor fi inlocuiti cu valorile introduse de utilizator la momentul executiei. Acest lucru face ca scriptul sa fie mai flexibil, deoarece nu depinde de numele variabilelor (`dep_id` si `venit_med_annual`) si poate fi rulat cu orice valori fara a fi nevoie sa modificam codul.
*/

  /*
Exemplu de valori pe care le poți introduce:
dep_id = 20
venit_med_annual = 30000
Poți încerca și:
dep_id = 10, venit_med_annual = 25000
dep_id = 30, venit_med_annual = 20000
*/

/*

1. Ai spus ca am de rulat comenzi de SQL pentru acest exercitiu. Comenziile astea unde le scriu: In lbaorator BD pe Vscode cu un worksheet nou, sau aici:  SQL>? Daca le scriu doar in SQL>, nu pot sa le rulez cumva si din VScode, adica din worksheet din Laborator BD?

2.Ai spus ca cele 4 metode, pe care le cere exercitiul sunt defapt codul, corect?

3. SET VERIFY OFF unde o pun in vscode sau in terminalulul cu SQL>?

4. Fiind in directorul bun, SQL>run cerinta1.1.sql asa se ruleaza codul, daca am scris codul in Vscode?

5. SQL> run cerinta1.1.sql
  1  SELECT nume,
  2         id_departament,
  3         12 * (salariu + NVL(comision,0)) AS venit_anual
  4  FROM angajati
  5  WHERE id_departament = &dep_id       
  6*   AND 12 * (salariu + NVL(comision,0)) > &venit_med_annual
Enter value for dep_id: 20
Enter value for venit_med_annual: 30000
FROM angajati
     *
ERROR at line 4:
ORA-00942: table or view does not exist   
Help: https://docs.oracle.com/error-help/db/ora-00942/

Ce ii fac?






Mai jos, pe scurt, punctual:

---

**1) Unde scriu comenzile?**  
Poți în **ambele**:
- **SQL*Plus** (`SQL>`): scrii direct sau rulezi fișier cu `@`/`START`.
- **VSCode Worksheet** (Oracle SQL Developer Extension): scrii și dai **Run Script**.

Dacă scrii doar în SQL*Plus, nu se “sincronizează” automat cu VSCode. Sunt două interfețe diferite către aceeași DB.

---

**2) “Cele 4 metode” = cod?**  
Da. Sunt **4 interogări SQL diferite** care rezolvă aceeași cerință.

---

**3) `SET VERIFY OFF` unde?**  
Îl pui **în aceeași interfață** în care rulezi:
- dacă rulezi în SQL*Plus → scrii acolo.
- dacă rulezi în VSCode Worksheet → îl pui sus în script.

---

**4) `run cerinta1.1.sql` e corect?**  
În SQL*Plus, comanda corectă e:
```
@cerinta1.1.sql
```
sau
```
START cerinta1.1.sql
```
Ai grijă să fii în directorul unde e fișierul sau să dai **cale completă**.

În VSCode, nu folosești `run` — doar selectezi scriptul și dai **Run Script**.

---

**5) ORA-00942: table or view does not exist**  
În schema SCOTT **nu există `ANGAJATI`**. Ai două variante:

**A) Folosești tabelele SCOTT (EMP):**
```sql
SELECT ename,
       deptno,
       12 * (sal + NVL(comm,0)) AS venit_anual
FROM emp
WHERE deptno = &dep_id
  AND 12 * (sal + NVL(comm,0)) > &venit_med_annual;
```

**B) Creezi/importi tabela `ANGAJATI`** (dacă laboratorul tău o cere).

Verifică ce tabele ai:
```sql
SELECT table_name FROM user_tables;
```

Spune-mi ce iese aici și îți dau exact varianta corectă pentru schema ta.










În SQL*Plus poți:

- **Curăța ecranul**:  
  ```
  CLEAR SCREEN
  ```
  (pe Windows merge și `HOST CLS`)

- **Rula din nou ultima comandă**:  
  ```
  /
  ```
  sau  
  ```
  RUN
  ```

Spune-mi ce vrei exact prin “refresh” (curățare ecran sau rerun).


Probabil schema SCOTT nu are tabelul EMP instalat (sau nu ești în schema corectă).
Verifică rapid:
SELECT user FROM dual;  -- îți arată în ce schemă ești
SELECT table_name FROM user_tables; -- îți arată ce tabele ai în schema curentă                    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Dacă nu vezi EMP, atunci:
fie trebuie să folosești tabelele tale (ANGAJATI) și să le creezi/importi,
fie trebuie să instalezi schema sample SCOTT (cu EMP/DEPT).

SQL> SELECT COUNT(*) FROM angajati;

  COUNT(*)
----------
         0












!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!





OBSERVATIE: Daca am dau o data @PENTRUcerinta1.1.sql la rulat, care e si pentru celelalte cerinte, in terminalul cu cerinta1.1.sqlALTER
NU MAI E NEVOIE SA MAI DAU @PENTRUcerinta1.1.sql pentru urmatoarele minicerinte, pentru ca deja am rulat codul, si daca dau din nou, o sa imi dea eroare ca tabela exista deja

asd@DESKTOP-KEN2053:/mnt/c/Users/Andrei/Desktop/SEM_2/BD/LAB3$ sqlplus scott/tiger@localhost:1521/XEPDB1

SQL*Plus: Release 23.26.1.0.0 - Production on Mon Mar 9 21:06:23 2026
Version 23.26.1.0.0

Copyright (c) 1982, 2025, Oracle.  All rights reserved.

Last Successful login time: Mon Mar 09 2026 21:04:22 +02:00

Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> @cerinta1.2.sql
Enter value for dep_id: 20
Enter value for venit_med_annual: 30000

NUME                           ID_DEPARTAMENT VENIT_ANUAL
------------------------------ -------------- -----------
Popescu                                   
 20         38400
Marin                                     
 20         45600
*/