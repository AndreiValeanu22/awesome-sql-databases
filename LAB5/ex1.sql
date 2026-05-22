SELECT
    a.NUME            AS nume_angajat,
    d1.DEN_DEP        AS departament_angajat,
    g1.GRAD           AS grad_angajat,
    s.NUME            AS nume_sef,
    d2.DEN_DEP        AS departament_sef,
    g2.GRAD           AS grad_sef
FROM ANGAJATI a -- tabela principală, de la care începem legăturile
FULL OUTER JOIN DEPARTAMENTE d1
    ON d1.ID_DEP = a.ID_DEP -- legăm angajatul de departamentul său
FULL OUTER JOIN GRILA_SALARIU g1
    ON a.SALARIU BETWEEN g1.NIVEL_INF AND g1.NIVEL_SUP -- legăm angajatul de gradul său pe baza salariului, aflat în intervalul [NIVEL_INF, NIVEL_SUP]
FULL OUTER JOIN ANGAJATI s
    ON s.ID_ANG = a.ID_SEF -- legăm angajatul de șeful său, pe baza ID‑ului șefului (ID_SEF) care se potrivește cu ID‑ul unui angajat (ID_ANG)
FULL OUTER JOIN DEPARTAMENTE d2
    ON d2.ID_DEP = s.ID_DEP -- legăm șeful de departamentul său
FULL OUTER JOIN GRILA_SALARIU g2
    ON s.SALARIU BETWEEN g2.NIVEL_INF AND g2.NIVEL_SUP; -- legăm șeful de gradul său pe baza salariului său, aflat în intervalul [NIVEL_INF, NIVEL_SUP]

-- Observație: folosim `FULL OUTER JOIN` pentru a ne asigura că toate rândurile sunt incluse, chiar dacă nu există potriviri în unele legături.
-- Dacă am fi folosit `INNER JOIN`, am fi pierdut rândurile fără potrivire, ceea ce nu respectă cerința de a afișa toate rezultatele.
-- NIVEL_INF și NIVEL_SUP sunt folosite pentru a determina gradul angajatului și al șefului, pe baza salariului lor si sunt variabile în funcție de datele din tabela 
-- GRILA_SALARIU. Dar sunt citite de la tabela GRILA_SALARIU, nu sunt valori fixe. Ele definesc intervalele de salariu pentru fiecare grad.

/*
Intrebari:
1. Unde este clauza WHERE?
2. Puteam sa folosim si INNER JOIN in loc de FULL OUTER JOIN? Sau RIGHT OUTER JOIN? Sau LEFT OUTER JOIN? Sau Non Equi-join (Θ-Join)?
3. Descrie-mi de pe site-ul ocw, tot lab ul 5, practic toata lectia, altcumva, toate join urile, ca sa le inteleg mai usor, fara sa iti lipsesasca ceva, dar sa fie in romana


RASPUNSURI:
Mai jos răspunsurile, pe scurt și clar:

## 1) Unde este clauza WHERE?
În varianta cu `FULL OUTER JOIN`, condițiile de legare sunt în `ON`, nu în `WHERE`.  
Dacă pui condiții în `WHERE`, riști să „anulezi” partea outer (adică să pierzi rândurile fără potrivire).  
Pe scurt:  
- `ON` = condiția de legare pentru join  
- `WHERE` = filtre finale (după join)

## 2) Puteam folosi INNER/LEFT/RIGHT/Θ-Join?
Depinde de cerință:

- **FULL OUTER JOIN**: singurul care garantează *toate rândurile*, chiar și fără legături.  
- **INNER JOIN**: ar elimina rândurile fără potrivire → NU respectă cerința.  
- **LEFT/RIGHT JOIN**: păstrează toate rândurile doar dintr-o parte → NU garantat „toate”.  
- **Θ-Join (non-equi)**: nu e relevant aici, fiindcă legarea e pe egalitate (ID).

Deci, pentru „să se afișeze toate rezultatele chiar dacă nu există legături”, **FULL OUTER JOIN e corect**.

---

## 3) Lab 5 explicat simplu, complet, în română
Bazat pe [Laborator 05 – Metode de JOIN](https://ocw.cs.pub.ro/courses/bd/laboratoare/05):

### Ce este JOIN
JOIN combină date din două (sau mai multe) tabele pe baza unei condiții.  
În SQL poți avea unul sau mai multe JOIN‑uri într‑un SELECT.

### Tipuri de JOIN

#### 1) CROSS JOIN (Produs cartezian)
- Combină fiecare rând din tabela A cu fiecare rând din tabela B.  
- Rezultatul are **A_rows × B_rows** rânduri.  
- Util doar în situații specifice; altfel apare din greșeală (lipsește condiția).

#### 2) INNER JOIN (cel mai folosit)
- Returnează **doar rândurile care au potrivire** între tabele.  
- Are subtipuri:

**a) Equi-Join**  
- Condiția de legare este „egalitate” (`=`).  
- Exemplu: `A.id = B.id`.

**b) Natural Join**  
- Leagă automat după toate coloanele cu același nume.  
- Nu scrii condiția manual.  
- Atenție: nu poți califica acele coloane cu alias în SELECT.

**c) Non-Equi Join (Θ-Join)**  
- Condiția NU e egalitate (`<`, `>`, `BETWEEN`, etc).  
- Exemplu clasic: legarea salariilor la grile de salarizare.

#### 3) SELF JOIN
- O tabelă se alătură **cu ea însăși**.  
- Folosit când vrei relații între rânduri din aceeași tabelă (ex. angajat‑șef).

#### 4) OUTER JOIN
Returnează și rânduri **fără potrivire**.

**a) LEFT OUTER JOIN**  
- Păstrează toate rândurile din tabela stângă.  
- Dacă nu există potrivire în dreapta → valori `NULL` pentru dreapta.

**b) RIGHT OUTER JOIN**  
- Păstrează toate rândurile din tabela dreaptă.  
- Similar cu LEFT, doar invers.

**c) FULL OUTER JOIN**  
- Păstrează **toate rândurile** din ambele tabele.  
- Dacă nu există potrivire → `NULL` pe partea lipsă.

Observație: `A LEFT JOIN B` este echivalent cu `B RIGHT JOIN A`.

#### 5) JOIN Vertical (UNION / INTERSECT / MINUS)
- „Concatenează” rezultate de SELECT-uri diferite.  
- Coloanele trebuie să fie compatibile ca tip.  
- `UNION` elimină duplicatele, `UNION ALL` le păstrează.  
- `INTERSECT` = doar rândurile comune.  
- `MINUS` = rânduri din primul rezultat care nu apar în al doilea.

---
*/