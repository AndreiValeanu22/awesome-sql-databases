SELECT
    INITCAP(e.ename) AS nume_angajat, -- am adaugat INITCAP pentru a afisa numele angajatului cu prima litera mare
    LOWER(d.dname) AS departament_angajat, -- am adaugat LOWER pentru a afisa numele departamentului cu litere mici
    TO_CHAR(e.hiredate, 'MM-YYYY') AS data_angajare, -- am adaugat TO_CHAR pentru a afisa data angajarii in formatul dorit
    CASE
        WHEN s.grade IN (2, 4)
             AND m.hiredate IS NOT NULL -- verificam daca seful are data angajarii pentru a putea compara cu data angajarii angajatului
             AND EXTRACT(YEAR FROM e.hiredate) = EXTRACT(YEAR FROM m.hiredate) -- verificam daca angajatul si seful au fost angajati in acelasi an
        THEN
            CASE
                WHEN s.grade = 2 -- daca gradul sefului este 2, atunci prima este calculata cu logaritm in baza 2
                THEN e.sal * SQRT(&c * LOG(2, MONTHS_BETWEEN(SYSDATE, e.hiredate))) -- am inlocuit &&c cu &c pentru a putea introduce valoarea doar o data
                WHEN s.grade = 4 -- daca gradul sefului este 4, atunci prima este calculata cu logaritm in baza 3
                THEN e.sal * SQRT(&c * LOG(3, MONTHS_BETWEEN(SYSDATE, e.hiredate))) -- am inlocuit &&c cu &c pentru a putea introduce valoarea doar o data
            END
        ELSE 0
    END AS prima,
    s.grade AS grad_salarial,
    INITCAP(m.ename) AS nume_sef,
    LOWER(d2.dname) AS departament_sef
FROM emp e
LEFT JOIN emp m ON e.mgr = m.empno
JOIN dept d ON e.deptno = d.deptno
LEFT JOIN dept d2 ON m.deptno = d2.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
ORDER BY INITCAP(e.ename);

/*
SQL> @ex2.sql
Enter value for c: 0.15
old  12:                 THEN e.sal * SQRT(&&c * LOG(2, MONTHS_BETWEEN(SYSDATE, e.hiredate)))
new  12:                 THEN e.sal * SQRT(0.15 * LOG(2, MONTHS_BETWEEN(SYSDATE, e.hiredate)))
old  14:                 THEN e.sal * SQRT(&&c * LOG(3, MONTHS_BETWEEN(SYSDATE, e.hiredate))) asta afiseaza daca e &&c. Daca e &c se afiseaza doar o data old ... new ...
new  14:                 THEN e.sal * SQRT(0.15 * LOG(3, MONTHS_BETWEEN(SYSDATE, e.hiredate)))

NUME_ANGAJ DEPARTAMENT_AN DATA_AN      PRIMA GRAD_SALARIAL NUME_SEF
---------- -------------- ------- ---------- ------------- ----------
DEPARTAMENT_SE
--------------
Adams      research       01-1983          0             1 Scott
research

Allen      sales          02-1981          0             3 Blake
sales

Blake      sales          05-1981 2641.17299             4 King
accounting


NUME_ANGAJ DEPARTAMENT_AN DATA_AN      PRIMA GRAD_SALARIAL NUME_SEF
---------- -------------- ------- ---------- ------------- ----------
DEPARTAMENT_SE
--------------
Clark      accounting     06-1981 2270.06041             4 King
accounting

Ford       research       12-1981 2777.26598             4 Jones
research

James      sales          12-1981          0             1 Blake
sales


NUME_ANGAJ DEPARTAMENT_AN DATA_AN      PRIMA GRAD_SALARIAL NUME_SEF
---------- -------------- ------- ---------- ------------- ----------
DEPARTAMENT_SE
--------------
Jones      research       04-1981 2757.40686             4 King
accounting

King       accounting     11-1981          0             5


Martin     sales          09-1981 1457.33029             2 Blake
sales


NUME_ANGAJ DEPARTAMENT_AN DATA_AN      PRIMA GRAD_SALARIAL NUME_SEF
---------- -------------- ------- ---------- ------------- ----------
DEPARTAMENT_SE
--------------
Miller     accounting     01-1982          0             2 Clark
accounting

Scott      research       12-1982          0             4 Jones
research

Smith      research       12-1980          0             1 Ford
research


NUME_ANGAJ DEPARTAMENT_AN DATA_AN      PRIMA GRAD_SALARIAL NUME_SEF
---------- -------------- ------- ---------- ------------- ----------
DEPARTAMENT_SE
--------------
Turner     sales          09-1981          0             3 Blake
sales

Ward       sales          02-1981 1458.88086             2 Blake
sales


14 rows selected.

SQL> @ex1.sql

    ID_SEF NUME_SEF   NUMAR_SUBALTERNI DEPARTAMENT    SALARIU_MIN SALARIU_MEDIU
---------- ---------- ---------------- -------------- ----------- -------------
SALARIU_MAX
-----------
      7566 Jones                     2 research              3000          3000
       3000

      7698 Blake                     5 sales                  950          1310
       1600

      7782 Clark                     1 accounting            1300          1300
       1300


    ID_SEF NUME_SEF   NUMAR_SUBALTERNI DEPARTAMENT    SALARIU_MIN SALARIU_MEDIU
---------- ---------- ---------------- -------------- ----------- -------------
SALARIU_MAX
-----------
      7788 Scott                     1 research              1100          1100
       1100

      7839 King                      3 accounting            2450       2758.33
       2975

      7902 Ford                      1 research               800           800
        800


6 rows selected.
*/