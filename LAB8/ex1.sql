-- 1) Subcerere cu o singura valoare
SELECT a.nume, d.den_dep, a.salariu
FROM angajati a
JOIN departamente d ON d.id_dep = a.id_dep -- join pentru a aduce denumirea departamentului in rezultat
WHERE a.salariu = (
  SELECT MIN(a2.salariu)
  FROM angajati a2
  WHERE a2.id_dep = a.id_dep -- linia asta e pentru a compara salariul cu salariul minim din acelasi departament
)
ORDER BY a.nume;

-- 2) Subcerere care intoarce o linie cu mai multe coloane
SELECT a.nume, d.den_dep, a.salariu
FROM angajati a
JOIN departamente d ON d.id_dep = a.id_dep
WHERE (a.id_dep, a.salariu) = ( -- cate atribute ai in where atatea atribute trebuie sa returneze subcererea, adica sa ai in select
  SELECT a2.id_dep, MIN(a2.salariu)
  FROM angajati a2
  WHERE a2.id_dep = a.id_dep
  GROUP BY a2.id_dep -- linia asta e pentru a grupa rezultatele pe departament, astfel incat sa avem cate o linie pentru fiecare departament cu 
  -- salariul minim
)
ORDER BY a.nume;

-- 3) Subcerere care intoarce mai multe linii cu mai multe coloane
SELECT a.nume, d.den_dep, a.salariu
FROM angajati a
JOIN departamente d ON d.id_dep = a.id_dep
WHERE (a.id_dep, a.salariu) IN ( -- IN e pentru a compara cu mai multe linii. Practic se va returna un tabel, corect? DA
  SELECT a2.id_dep, MIN(a2.salariu)
  FROM angajati a2
  GROUP BY a2.id_dep
)
ORDER BY a.nume;

-- 4) Subcerere in clauza FROM
SELECT a.nume, d.den_dep, a.salariu
FROM angajati a
JOIN departamente d ON d.id_dep = a.id_dep
JOIN ( -- linia asta e pentru a face join cu subcererea care calculeaza salariul minim pe departament
  SELECT id_dep, MIN(salariu) AS salariu_minim
  FROM angajati
  GROUP BY id_dep
) mins ON mins.id_dep = a.id_dep AND mins.salariu_minim = a.salariu -- linia asta e pentru a face join cu subcererea care 
-- calculeaza salariul minim pe departament; mins e variabila de referinta si o schimbam cu a
ORDER BY a.nume;