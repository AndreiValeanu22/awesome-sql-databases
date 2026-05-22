-- Ex.3 (SOME/ANY)
SELECT e.ename,
       d.dname,
       e.job,
       (e.sal + NVL(e.comm,0)) AS venit_lunar
FROM emp e
JOIN dept d ON d.deptno = e.deptno
WHERE NOT ( (e.sal + NVL(e.comm,0)) < ANY -- ANY se foloseste INTOTDEAUNA cu operatori de comparatie, adica <, >, <=, >=, =, !=; 
--linia de mai sus e pentru a compara salariul lunar al fiecarui angajat cu salariul lunar al tuturor angajatilor din acelasi departament
            (SELECT (e2.sal + NVL(e2.comm,0))
             FROM emp e2
             WHERE e2.deptno = e.deptno) ) -- de ce se mai face linia asta? Pentru a aduce in calcul doar angajatii din acelasi departament, astfel 
             --incat sa comparam salariul lunar al fiecarui angajat cu salariul lunar al tuturor angajatilor din acelasi departament    
ORDER BY d.dname;

-- Dar ANY se folosete intotdeauna cu < corect? Da, ANY se foloseste intotdeauna cu operatori de comparatie, adica <, >, <=, >=, =, !=.
-- In cazul de fata se foloseste < pentru a compara salariul lunar al fiecarui angajat cu salariul lunar al tuturor angajatilor din acelasi 
--departament. Nu e o regula ca ANY sa se foloseasca intotdeauna cu <, ci se poate folosi si cu >, <=, >=, =, !=, in functie de ce vrem sa comparam. De exemplu, daca vrem sa comparam salariul lunar al fiecarui angajat cu salariul lunar al tuturor angajatilor din acelasi departament pentru a afla care sunt angajatii care au un salariu lunar mai mare decat salariul lunar al tuturor angajatilor din acelasi departament, atunci am putea folosi > in loc de <.
