--                                                              Metoda 1 (&)

SET VERIFY OFF

SELECT nume,
       id_departament,
       12 * (salariu + NVL(comision,0)) AS venit_anual -- NVL e ca un IFNULL, daca comision e NULL, atunci pune 0 si AS e ca un alias, adica numele coloanei rezultate va fi venit_anual; Ddeci e ca un then, corect? 
       -- AS e ca un then corect? Da, e un alias pentru coloana rezultată. 
FROM angajati
WHERE id_departament = &dep_id
  AND 12 * (salariu + NVL(comision,0)) > &venit_med_annual;

-- Ce rol are AND de la linia 11? AND e un operator logic care combină cele două condiții din WHERE. În acest caz, ambele condiții trebuie să fie adevărate pentru ca un rând să fie inclus în rezultatul final. Prima condiție verifică dacă id_departament este egal cu valoarea introdusă de utilizator (&dep_id), iar a doua condiție verifică dacă venitul anual calculat (12 * (salariu + NVL(comision,0))) este mai mare decât valoarea introdusă de utilizator (&venit_med_annual). Dacă ambele condiții sunt îndeplinite, atunci rândul respectiv va fi returnat în rezultatul interogării.

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
@cerinta1.1.sql ATENTIE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Trebuie sa rulezi inainte si @PENTRUcerinta1.1.sql pentru ca acolo e codul de creare a tabelelor, daca nu ai rulat inca acel script, atunci nu o sa gasesti tabela angajati si o sa iti dea eroarea de mai sus, sau nimic
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



SQL> @cerinta1.1.sql
Enter value for dep_id: 20
Enter value for venit_med_annual: 30000

NUME                           ID_DEPARTAMENT VENIT_ANUAL
------------------------------ -------------- -----------
Popescu                                   
 20         38400
Marin                                     
 20         45600




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
*/