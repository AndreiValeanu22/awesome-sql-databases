-- Ex.2
SELECT e.job, -- functie
       e.salgrade, -- gradul salarial
       AVG(e.sal + NVL(e.comm,0)) AS avg_venit_job_grad -- asta e salariu mediu angajati? nu, e salariu mediu pentru fiecare combinatie de job si 
       -- grad salarial. La ce e nevoie de avg_venit_job_grad? E nevoie de aceasta coloana pentru a putea compara salariul mediu pentru fiecare combinatie de job si 
       -- grad salarial cu salariul mediu pentru fiecare grad salarial, indiferent de job, astfel incat sa putem afla care sunt combinatiile de job si grad salarial care au un salariu mediu mai mare sau
       -- egal decat salariul mediu pentru fiecare grad salarial, indiferent de job.

       -- Si de ce nu o folosim mai departe? Pentru ca nu e nevoie sa o folosim mai departe, ci doar sa o afisam in rezultat pentru a putea vedea care sunt combinatiile de job si grad salarial care au un 
       -- salariu mediu mai mare sau egal decat salariul mediu pentru fiecare grad salarial, indiferent de job.
FROM emp e
GROUP BY e.job, e.salgrade
HAVING AVG(e.sal + NVL(e.comm,0)) >=
       (SELECT AVG(e2.sal + NVL(e2.comm,0)) -- linia asta e pentru a compara salariul mediu pentru fiecare combinatie de job si grad 
       -- salarial cu salariul mediu (e2, corect? DA) pentru fiecare grad salarial, indiferent de job
        FROM emp e2
        WHERE e2.salgrade = e.salgrade);

-- HAVING e un fel de WHERE pentru GRUPURI
--Atenție: Nu confunda tabela temporală cu tabela temporară (#tempTable).
-- Tabela temporară este doar un spațiu de stocare pe termen scurt care dispare când închizi sesiunea, 

--în timp ce 

-- tabela temporală este o structură permanentă de arhivare a istoricului datelor, care poate fi interogată și analizată în timp, oferind o perspectivă asupra evoluției datelor în timp.
-- Tabela temoprala se creeaza la o subcerere? Nu, tabela temporala se creeaza la crearea bazei de date, iar datele se adauga in tabela temporala prin intermediul unor trigger-e sau proceduri 
-- stocate care se executa la anumite evenimente, cum ar fi inserarea, actualizarea sau stergerea datelor din tabelele principale. Tabela temporala nu se creeaza la o subcerere, 
--ci este o structura permanenta care exista in baza de date si care poate fi interogata pentru a obtine informatii despre evolutia datelor in timp.

-- Tabela temporala se realizeaza la o subcerere in clauza from? E un tabel care returneaza o linie si mai multe coloane, nu arata nicicum, dar e un tabel care exista doar in timpul executiei subcererii,
-- adica in timpul executiei interogarii care contine subcererea. Tabela temporala se realizeaza la o subcerere in clauza from - rezultat

-- SELECT count(*) numara toate liniile. Nu se pot numara toate coloanele. Exista metode, dar nu pentru cursul de baze de date de la facultate.ALTER
-- SELECT count(id_angajat) numara toate liniile care au un id_angajat, adica toate liniile care au un angajat, adica toate liniile care nu sunt nule (Adica toate liniile de la coloana id_angajat)