-- Ex.3 (ALL)
SELECT e.ename,
       d.dname,
       e.job,
       (e.sal + NVL(e.comm,0)) AS venit_lunar
FROM emp e
JOIN dept d ON d.deptno = e.deptno
WHERE (e.sal + NVL(e.comm,0)) >= ALL -- ALL se foloseste INTOTDEAUNA cu operatori de comparatie, adica <, >, <=, >=, =, !=;
      (SELECT (e2.sal + NVL(e2.comm,0))
       FROM emp e2
       WHERE e2.deptno = e.deptno)
ORDER BY d.dname;

-- ANalog ALL, corect? Da, ALL se foloseste intotdeauna cu operatori de comparatie, adica <, >, <=, >=, =, !=. 
--In cazul de fata se foloseste >= pentru a compara salariul lunar al fiecarui angajat cu salariul lunar al tuturor angajatilor din acelasi 
--departament. Nu e o regula ca ALL sa se foloseasca intotdeauna cu >=, ci se poate folosi si cu <, >, <=, =, !=, in functie de ce vrem sa comparam. 

--De exemplu, daca vrem sa comparam salariul lunar al fiecarui angajat cu salariul lunar al tuturor angajatilor din acelasi departament pentru a 
--afla care sunt angajatii care au un salariu lunar mai mic decat salariul lunar al tuturor angajatilor din acelasi departament, atunci am putea 
--folosi < in loc de >=.