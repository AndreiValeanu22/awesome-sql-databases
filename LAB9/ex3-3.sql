-- Ex.3 (EXISTS)
SELECT e.ename,
       d.dname,
       e.job,
       (e.sal + NVL(e.comm,0)) AS venit_lunar
FROM emp e
JOIN dept d ON d.deptno = e.deptno
WHERE NOT EXISTS (
    SELECT 1 -- se poate pune orice in select, de obicei se pune 1 sau *, pentru ca nu ne intereseaza ce se selecteaza, ci doar daca exista sau nu
    -- linii care sa indeplineasca conditia din where
    FROM emp e2
    WHERE e2.deptno = e.deptno
      AND (e2.sal + NVL(e2.comm,0)) > (e.sal + NVL(e.comm,0))
)
ORDER BY d.dname;