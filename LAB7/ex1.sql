SELECT
    m.empno AS id_sef,
    INITCAP(m.ename) AS nume_sef,
    COUNT(e.empno) AS numar_subalterni,
    LOWER(d.dname) AS departament, -- LOWER pentru a afisa numele departamentului cu litere mici
    MIN(e.sal) AS salariu_min,
    ROUND(AVG(e.sal), 2) AS salariu_mediu, -- am adaugat 2 zecimale pentru a se vedea mai bine media
    MAX(e.sal) AS salariu_max
FROM emp e
JOIN emp m ON e.mgr = m.empno -- am schimbat LEFT JOIN in JOIN pentru a nu include sefii fara subalterni
JOIN dept d ON m.deptno = d.deptno -- am schimbat d.deptno in m.deptno pentru a afisa departamentul sefului, nu al angajatului
GROUP BY m.empno, m.ename, d.dname -- am adaugat m.ename si d.dname in GROUP BY pentru a putea afisa numele sefului si departamentul
ORDER BY m.empno; -- am schimbat ORDER BY INITCAP(e.ename) in ORDER BY m.empno pentru a ordona dupa id-ul sefului, nu dupa numele angajatului

/*
SQL> @ex2.sql
Enter value for c: 0.15
old  12:                 THEN e.sal * SQRT(&&c * LOG(2, MONTHS_BETWEEN(SYSDATE, e.hiredate)))
new  12:                 THEN e.sal * SQRT(0.15 * LOG(2, MONTHS_BETWEEN(SYSDATE, e.hiredate)))
old  14:                 THEN e.sal * SQRT(&&c * LOG(3, MONTHS_BETWEEN(SYSDATE, e.hiredate)))
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