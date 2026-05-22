-- Ex.1
SELECT e.job, -- se afiseaza jobul, sau mai bine zis, denumirea postului
       (SELECT AVG(e2.sal + NVL(e2.comm,0)) -- se calculeaza media salariului pentru fiecare job in parte, adica pentru fiecare linie din tabelul
        FROM emp e2                         -- rezultat; e2.comm e pentru a aduce in calcul si comisionul, daca exista
        WHERE e2.job = e.job) AS avg_venit_lunar -- se adauga o coloana noua in rezultat care sa contina media salariului pentru fiecare job in 
        --parte
FROM emp e
GROUP BY e.job; -- se grupeaza dupa job pentru a avea cate o linie pentru fiecare job, astfel incat sa putem calcula media salariului pentru fiecare
-- job in parte