SELECT nume,
       functie,
       (salariu + NVL(comision, 0)) * 12 AS venit_anual
FROM angajati
WHERE functie <> 'MANAGER' -- <> <=> !=
  AND id_dep = &id_dep;

/*
Mai jos ai lecția de la Laboratorul 04, rescrisă clar și pe scurt, dar fără să omit vreo componentă importantă din material. Sursa: [Laborator 04 - Cereri SQL](https://ocw.cs.pub.ro/courses/bd/laboratoare/04).

## Laborator 04 — Cereri SQL, explicat simplu

### Obiectivele laboratorului
- Înțelegi comanda `SELECT` (cum se scrie și ce poate face).
- Învățați cereri simple.
- Folosiți corect clauza `WHERE`.

### Idee principală
Interogările SQL se fac cu **`SELECT`**. Comanda poate citi atât datele create de tine, cât și tabelele interne ale sistemului de gestiune.

### Structura completă a unei cereri `SELECT`
Formatul general (cu toate opțiunile posibile) include:

- `SELECT` cu `DISTINCT` sau `ALL`
- `FROM` cu tabelă (eventual cu alias și dblink)
- `WHERE` pentru filtrare
- `START WITH` / `CONNECT BY` pentru ierarhii
- `UNION` / `INTERSECT` / `MINUS` pentru combinarea mai multor selecturi
- `GROUP BY` / `HAVING` pentru grupare
- `ORDER BY` pentru sortare
- `FOR UPDATE` + `NOWAIT` pentru blocare la modificare

Pe scurt:
- **`DISTINCT`**: elimină duplicatele.
- **`ALL`**: păstrează tot (implicit).
- **`schema.table`**: numele complet al tabelei/view-ului.
- **`expression`**: coloană sau expresie.
- **`alias`**: nume afişat în rezultat.
- **`dblink`**: acces la altă bază de date.
- **`table_alias`**: alias de tabel (utile la interogări corelate).
- **`WHERE`**: condiții de selecție.
- **`START WITH` / `CONNECT BY`**: ierarhii.
- **`GROUP BY` / `HAVING`**: grupare + filtrare a grupurilor.
- **`UNION/INTERSECT/MINUS`**: combinarea rezultatelor.
- **`ORDER BY`**: sortare.
- **`FOR UPDATE` / `NOWAIT`**: blocare pentru modificare.

### Cereri simple (exerciții)
Laboratorul cere să exersezi interogări de bază:

1. **Creezi o copie a tabelei `DEPT`** cu nume `departamente` și coloane redenumite.
2. **Creezi o copie a tabelei `EMP`** numită `angajati`.
3. **Selectezi toate coloanele și toate rândurile** din `angajati`.
4. **Selectezi doar id și nume departament** din `departamente`.
5. **Selectezi id, nume, funcție, data angajării**, ordonate descrescător după id și concatenezi id cu numele.
6. **Selectezi id, nume, funcție, salariu lunar**, adaugi o coloană goală numită `semnatura`, concatenezi id cu numele, ordonezi după departament.
7. **Selectezi nume + funcție** din `angajati`.
8. **Listezi numele departamentului și codul**, ordonate după nume.

**Concatenarea șirurilor**:
- Oracle: `||`
- SQL Server: `+`
- În multe SGBD-uri există `concat()`.

### Clauza `WHERE`
Este folosită pentru filtrare, pe:
- nume de coloane
- operatori de comparație
- operatori de negație
- liste de valori

**Operatori logici**:
- `AND` → toate condițiile adevărate
- `OR` → cel puțin una adevărată

**Precedență**:
1. Comparațiile (`=, <, >, BETWEEN, IN, LIKE, IS NULL`)
2. `NOT`
3. `AND`
4. `OR`

**Operatori de comparație**:
- `=, >, >=, <, <=`

**Operatori SQL**:
- `BETWEEN`, `IN`, `LIKE`, `IS NULL`

**Operatori de negație**:
- `!=`, `^=`, `<>`
- `NOT BETWEEN`, `NOT IN`, `NOT LIKE`, `IS NOT NULL`

### Exemple cu `WHERE`
9. Angajații din departamentul 10  
10. Angajații cu funcția MANAGER, ordonați după departament  
11. Angajații angajați într-o perioadă dată  
12. Angajații cu id-uri specifice  

### `LIKE` și wildcard-uri
- `_` → un singur caracter
- `%` → orice secvență de caractere

Exemple:
13. Angajați angajați în 1980  
14. Nume cu `F` și funcție de 7 caractere  

### `NULL` — foarte important
- `NULL` se compară **doar** cu `IS NULL` sau `IS NOT NULL`.
- `comision = NULL` este **mereu fals**.

### Sensibilitate la litere
SQL nu e case-sensitive, dar șirurile de caractere sunt. Pentru normalizare:
- `lower()` → micșorează
- `upper()` → majuscule

### Alte exemple din laborator
15. Angajații din dept 20 fără comision  
16. Angajații cu comision și funcția SALESMAN  
17. MANAGER cu salariu > 1500 + toți ANALYST  

### Exerciții individuale
- Angajați înainte de 1982 fără comision  
- Salariu > 3000 și fără șef, ordonat pe departament  
- Nume + funcție + venit anual pentru angajați fără funcția MANAGER, pentru un departament dat de la tastatură  
- Departament, nume, data angajării, salariu pentru angajații din 1981, din două departamente date de la tastatură

---

Dacă vrei, pot să îți fac și exemple concrete de interogări pentru fiecare exercițiu.
*/