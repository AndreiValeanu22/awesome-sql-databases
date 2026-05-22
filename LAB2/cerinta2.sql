/*CREATE TABLE recipes
(
    id_recipe NUMBER,
    title VARCHAR2(30),
    instructions VARCHAR2(250),
    CONSTRAINT pk_recipes PRIMARY KEY (id_recipe)
);

SELECT constraint_name, constraint_type FROM all_constraints where table_name =
'RECIPES';

CREATE TABLE INGREDIENTS
(
    id_ingredient NUMBER,
    id_category NUMBER,
    ingredient VARCHAR2(30),
    CONSTRAINT pk_ingredients PRIMARY KEY (id_ingredients)
);

CREATE TABLE CATEGORIES
(
    id_category NUMBER,
    Category VARCHAR(250),
    CONSTRAINT pk_id_category PRIMARY KEY (id_category),
);

ALTER TABLE ingredients ADD CONSTRAINT
fk_ingredient_categories FOREIGN KEY (id_category)
REFERENCES CATEGORIES (id_category)

CREATE TABLE link (
  id_recipe NUMBER,
  id_ingredient NUMBER,
  quantity NUMBER,
  mu VARCHAR2(30),
  CONSTRAINT pk_link PRIMARY KEY (id_recipe, id_ingredient),
  CONSTRAINT fk_link_recipes FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe),
  CONSTRAINT fk_link_ingredients FOREIGN KEY (id_ingredient) REFERENCES ingredients(id_ingredient)
);

SELECT constraint_name, constraint_type FROM all_constraints where table_name =
'RECIPES';



command DESC (DEscription) recipes
*/

BEGIN EXECUTE IMMEDIATE 'DROP TABLE link CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE ingredients CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE categories CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE recipes CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

/*
tas1.sql
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE departamente CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE grila_salariu CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
*/


CREATE TABLE recipes ( -- creeaza tabela recipes
  id_recipe NUMBER, -- coloana ID pentru reteta
  title VARCHAR2(30), -- titlul retetei
  instructions VARCHAR2(250), -- instructiuni de preparare
  CONSTRAINT pk_recipes PRIMARY KEY (id_recipe) -- cheie primara pe id_recipe
);

CREATE TABLE categories ( -- creeaza tabela categories
  id_category NUMBER, -- coloana ID pentru categorie
  category VARCHAR2(250), -- numele categoriei
  CONSTRAINT pk_categories PRIMARY KEY (id_category) -- cheie primara pe id_category
);

CREATE TABLE ingredients ( -- creeaza tabela ingredients
  id_ingredient NUMBER, -- coloana ID pentru ingredient
  id_category NUMBER, -- categoria ingredientului (FK)
  ingredient VARCHAR2(30), -- numele ingredientului
  CONSTRAINT pk_ingredients PRIMARY KEY (id_ingredient), -- cheie primara pe id_ingredient
  CONSTRAINT fk_ingredients_categories -- numele constrangerii FK si o folosim ca sa o putem referi mai usor !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    FOREIGN KEY (id_category) REFERENCES categories (id_category) -- FK la categories.id_category
);

CREATE TABLE link ( -- creeaza tabela de legatura recipe-ingredient
  id_recipe NUMBER, -- reteta (FK)
  id_ingredient NUMBER, -- ingredient (FK)
  quantity NUMBER, -- cantitate
  mu VARCHAR2(30), -- unitate de masura
  CONSTRAINT pk_link PRIMARY KEY (id_recipe, id_ingredient), -- cheie primara compusa
  CONSTRAINT fk_link_recipes -- numele constrangerii FK spre recipes !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    FOREIGN KEY (id_recipe) REFERENCES recipes (id_recipe), -- FK la recipes.id_recipe
  CONSTRAINT fk_link_ingredients -- numele constrangerii FK spre ingredients
    FOREIGN KEY (id_ingredient) REFERENCES ingredients (id_ingredient) -- FK la ingredients.id_ingredient
);

DROP TABLE angajati CASCADE CONSTRAINTS;
DROP TABLE departamente CASCADE CONSTRAINTS;
DROP TABLE grila_salariu CASCADE CONSTRAINTS;

SELECT c.table_name, -- Alege numele tabelului care are cheia străină.
       c.constraint_name, -- Alege numele constrângerii (FK).
       cc.column_name AS fk_column, -- Coloana din tabelul curent care e FK. 
       r.table_name AS ref_table, -- Tabela referențiată (tabela „părinte”).
       rcc.column_name AS ref_column -- Coloana din tabela părinte (de obicei PK).
FROM user_constraints c -- Pornește din lista constrângerilor definite în schema mea.
JOIN user_cons_columns cc -- Leagă constrângerile de coloanele lor (ca să afli pe ce coloană e FK)
  ON c.constraint_name = cc.constraint_name -- Potrivește constrângerea cu coloana ei.
JOIN user_constraints r -- Leagă FK‑ul de constrângerea referențiată (PK/UNIQUE).
  ON c.r_constraint_name = r.constraint_name -- Spune: „FK‑ul c referă constrângerea r”.
JOIN user_cons_columns rcc -- Ia coloana din tabelul referențiat.
  ON r.constraint_name = rcc.constraint_name -- Potrivește constrângerea referențiată cu coloana ei.
 AND cc.position = rcc.position -- Dacă PK/FK e compus, pozițiile trebuie să se potrivească (prima cu prima, etc.).
WHERE c.constraint_type = 'R' -- Filtrează doar constrângeri de tip R = Foreign Key.
/*
constraint_type:
P = primary key
R = foreign key

În baze de date ai cheie primară (PK) și cheie străină (FK).
Le vezi așa:
SELECT constraint_name, constraint_typeFROM user_constraintsWHERE table_name IN ('RECIPES','CATEGORIES','INGREDIENTS','LINK');
P = primary key
R = foreign key
*/
  AND c.table_name IN ('RECIPES','CATEGORIES','INGREDIENTS','LINK') -- Limitează rezultatul la tabelele tale.
ORDER BY c.table_name, c.constraint_name, cc.position; -- Sortează frumos pe tabel, constrângere și poziție.


/*
1. Pentru acest exercitiu, codul final este: 

CREATE TABLE recipes (
  id_recipe NUMBER,
  title VARCHAR2(30),
  instructions VARCHAR2(250),
  CONSTRAINT pk_recipes PRIMARY KEY (id_recipe)
);

CREATE TABLE categories (
  id_category NUMBER,
  category VARCHAR2(250),
  CONSTRAINT pk_categories PRIMARY KEY (id_category)
);

CREATE TABLE ingredients (
  id_ingredient NUMBER,
  id_category NUMBER,
  ingredient VARCHAR2(30),
  CONSTRAINT pk_ingredients PRIMARY KEY (id_ingredient),
  CONSTRAINT fk_ingredients_categories
    FOREIGN KEY (id_category) REFERENCES categories (id_category)
);

CREATE TABLE link (
  id_recipe NUMBER,
  id_ingredient NUMBER,
  quantity NUMBER,
  mu VARCHAR2(30),
  CONSTRAINT pk_link PRIMARY KEY (id_recipe, id_ingredient),
  CONSTRAINT fk_link_recipes
    FOREIGN KEY (id_recipe) REFERENCES recipes (id_recipe),
  CONSTRAINT fk_link_ingredients
    FOREIGN KEY (id_ingredient) REFERENCES ingredients (id_ingredient)
);

DROP TABLE angajati CASCADE CONSTRAINTS;
DROP TABLE departamente CASCADE CONSTRAINTS;
DROP TABLE grila_salariu CASCADE CONSTRAINTS;

SELECT c.table_name,
       c.constraint_name,
       cc.column_name AS fk_column,
       r.table_name AS ref_table,
       rcc.column_name AS ref_column
FROM user_constraints c
JOIN user_cons_columns cc
  ON c.constraint_name = cc.constraint_name
JOIN user_constraints r
  ON c.r_constraint_name = r.constraint_name
JOIN user_cons_columns rcc
  ON r.constraint_name = rcc.constraint_name
 AND cc.position = rcc.position
WHERE c.constraint_type = 'R'
  AND c.table_name IN ('RECIPES','CATEGORIES','INGREDIENTS','LINK')
ORDER BY c.table_name, c.constraint_name, cc.position;

 si functioneaz ca site-ul https://freesql.com/?

Nu. Ca pe freesql.com, acolo rulezi tot într‑un editor care știe să execute SQL și să arate rezultat/DDL.
Pentru cerința exercițiului, codul final ar trebui să fie doar cele 4 CREATE TABLE.
Restul (DROP TABLE... și SELECT ...) sunt comenzi auxiliare pentru curățare/verificare, nu fac parte din schema “finală”.
Deci, pentru “cod final”:
Păstrezi: cele 4 CREATE TABLE
Scoți: DROP ... și interogarea de SELECT ...

1.2 Ca sa dau de tabel, si sa imi afiseze, ca in link ul de mai sus, si sa functioneze ca link ul de mai sus trebuie sa fac acesti pasi cumva:

->
SELECT c.table_name,
       c.constraint_name,
       cc.column_name AS fk_column,
       r.table_name AS ref_table,
       rcc.column_name AS ref_column
FROM user_constraints c
JOIN user_cons_columns cc
  ON c.constraint_name = cc.constraint_name
JOIN user_constraints r
  ON c.r_constraint_name = r.constraint_name
JOIN user_cons_columns rcc
  ON r.constraint_name = rcc.constraint_name
 AND cc.position = rcc.position
WHERE c.constraint_type = 'R'
  AND c.table_name IN ('RECIPES','CATEGORIES','INGREDIENTS','LINK')
ORDER BY c.table_name, c.constraint_name, cc.position;
Daca da, care ara fii sablonul, dupa care m-as indica: Imi poti genera tu unul?

e cel de sus si Înlocuiești lista din IN (...) cu tabelele tale.


-> Pe bara din stanga cu instrumente din vscode, pe SQL Developer -> Reports -> Table -> User Tables si imi afiseaza tabelul, ca in link ul de la intrebarea 1, corect? da

2. Codul :

DROP TABLE angajati CASCADE CONSTRAINTS;
DROP TABLE departamente CASCADE CONSTRAINTS;
DROP TABLE grila_salariu CASCADE CONSTRAINTS;

Scapa de tabelele vechi: angajati, departamente, grila_salariu, pentru a putea crea cele noi?

Da. Comenzile DROP TABLE ... CASCADE CONSTRAINTS șterg tabelele vechi (angajati, departamente, grila_salariu) ca să nu te mai încurce.
Nu sunt necesare pentru a crea noile tabele (recipes, categories, ingredients, link), decât dacă vrei baza “curată”.

3. Explica-mi rand cu rand ce face codul acesta:

SELECT c.table_name, -- Alege numele tabelului care are cheia străină.
       c.constraint_name, -- Alege numele constrângerii (FK).
       cc.column_name AS fk_column, -- Coloana din tabelul curent care e FK. 
       r.table_name AS ref_table, -- Tabela referențiată (tabela „părinte”).
       rcc.column_name AS ref_column -- Coloana din tabela părinte (de obicei PK).
FROM user_constraints c -- Pornește din lista constrângerilor definite în schema mea.
JOIN user_cons_columns cc -- Leagă constrângerile de coloanele lor (ca să afli pe ce coloană e FK)
  ON c.constraint_name = cc.constraint_name -- Potrivește constrângerea cu coloana ei.
JOIN user_constraints r -- Leagă FK‑ul de constrângerea referențiată (PK/UNIQUE).
  ON c.r_constraint_name = r.constraint_name -- Spune: „FK‑ul c referă constrângerea r”.
JOIN user_cons_columns rcc -- Ia coloana din tabelul referențiat.
  ON r.constraint_name = rcc.constraint_name -- Potrivește constrângerea referențiată cu coloana ei.
 AND cc.position = rcc.position -- Dacă PK/FK e compus, pozițiile trebuie să se potrivească (prima cu prima, etc.).
WHERE c.constraint_type = 'R' -- Filtrează doar constrângeri de tip R = Foreign Key.
  AND c.table_name IN ('RECIPES','CATEGORIES','INGREDIENTS','LINK') -- Limitează rezultatul la tabelele tale.
ORDER BY c.table_name, c.constraint_name, cc.position; -- Sortează frumos pe tabel, constrângere și poziție.
?

4. Explica-mi rand cu rand ce face codul acesta:

CREATE TABLE recipes ( -- creeaza tabela recipes
  id_recipe NUMBER, -- coloana ID pentru reteta
  title VARCHAR2(30), -- titlul retetei
  instructions VARCHAR2(250), -- instructiuni de preparare
  CONSTRAINT pk_recipes PRIMARY KEY (id_recipe) -- cheie primara pe id_recipe
);

CREATE TABLE categories ( -- creeaza tabela categories
  id_category NUMBER, -- coloana ID pentru categorie
  category VARCHAR2(250), -- numele categoriei
  CONSTRAINT pk_categories PRIMARY KEY (id_category) -- cheie primara pe id_category
);

CREATE TABLE ingredients ( -- creeaza tabela ingredients
  id_ingredient NUMBER, -- coloana ID pentru ingredient
  id_category NUMBER, -- categoria ingredientului (FK)
  ingredient VARCHAR2(30), -- numele ingredientului
  CONSTRAINT pk_ingredients PRIMARY KEY (id_ingredient), -- cheie primara pe id_ingredient
  CONSTRAINT fk_ingredients_categories -- numele constrangerii FK
    FOREIGN KEY (id_category) REFERENCES categories (id_category) -- FK la categories.id_category
);

CREATE TABLE link ( -- creeaza tabela de legatura recipe-ingredient
  id_recipe NUMBER, -- reteta (FK)
  id_ingredient NUMBER, -- ingredient (FK)
  quantity NUMBER, -- cantitate
  mu VARCHAR2(30), -- unitate de masura
  CONSTRAINT pk_link PRIMARY KEY (id_recipe, id_ingredient), -- cheie primara compusa
  CONSTRAINT fk_link_recipes -- numele constrangerii FK spre recipes
    FOREIGN KEY (id_recipe) REFERENCES recipes (id_recipe), -- FK la recipes.id_recipe
  CONSTRAINT fk_link_ingredients -- numele constrangerii FK spre ingredients
    FOREIGN KEY (id_ingredient) REFERENCES ingredients (id_ingredient) -- FK la ingredients.id_ingredient
);

Stiu doar asta de la tine:

3) Cum ai construit codul (explicație pe scurt)
Ai urmat diagrama:
fiecare tabel din diagramă → un CREATE TABLE.
fiecare id_... → cheie primară (PRIMARY KEY).
legăturile dintre tabele → FOREIGN KEY.
tabelul link → tabel de legătură many‑to‑many între recipes și ingredients, deci cheie primară compusă (id_recipe, id_ingredient).

5. Sa inteleg ca blocul:

BEGIN EXECUTE IMMEDIATE 'DROP TABLE ____ CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

unde in loc de ____ pui numele tabelei, este un bloc PL/SQL care încearca sa stearga tabela sspecifica din memoria VSCODE-ului dupa ce am dat run script la tot codul,
si daca pun blocul de mai sus, pentru fiecare tabel, put da run script de cate ori vreau eu, si in acelasi timp sa se faca refresh, adica sa se stearga ce am facut eu
anterior? Da, e un bloc PL/SQL, dar nu șterge din “memoria VSCode”. Șterge tabela din baza de date.


6. Din codul asta:

/*CREATE TABLE recipes
(
    id_recipe NUMBER,
    title VARCHAR2(30),
    instructions VARCHAR2(250),
    CONSTRAINT pk_recipes PRIMARY KEY (id_recipe)
);

SELECT constraint_name, constraint_type FROM all_constraints where table_name =
'RECIPES';                                                                                                  ce face asta?

CREATE TABLE INGREDIENTS
(
    id_ingredient NUMBER,
    id_category NUMBER,
    ingredient VARCHAR2(30),
    CONSTRAINT pk_ingredients PRIMARY KEY (id_ingredients)
);

CREATE TABLE CATEGORIES
(
    id_category NUMBER,
    Category VARCHAR(250),
    CONSTRAINT pk_id_category PRIMARY KEY (id_category),
);

ALTER TABLE ingredients ADD CONSTRAINT
fk_ingredient_categories FOREIGN KEY (id_category)
REFERENCES CATEGORIES (id_category)                                                                          ce face asta?

CREATE TABLE link (
  id_recipe NUMBER,
  id_ingredient NUMBER,
  quantity NUMBER,
  mu VARCHAR2(30),
  CONSTRAINT pk_link PRIMARY KEY (id_recipe, id_ingredient),
  CONSTRAINT fk_link_recipes FOREIGN KEY (id_recipe) REFERENCES recipes(id_recipe),
  CONSTRAINT fk_link_ingredients FOREIGN KEY (id_ingredient) REFERENCES ingredients(id_ingredient)
);

SELECT constraint_name, constraint_type FROM all_constraints where table_name =
'RECIPES';                                                                                                   ce face asta?



command DESC (DEscription) recipes                                                                           ce face asta?

si cand se foloseste fiecare si de ce in acel loc?

Tu mi-ai spus:

2) Ce să tai / ce era în plus + rol
De tăiat (nu sunt necesare pentru cerință):
SELECT constraint_name, constraint_type ...
→ doar verifică ce constrângeri ai în tabel. Nu creează nimic.
DESC recipes
→ doar îți arată structura tabelului.
ALTER TABLE ingredients ADD CONSTRAINT ...
→ nu e greșit, dar dacă pui FK direct în CREATE TABLE ingredients, nu mai ai nevoie de acest ALTER.
Greșeli reale în codul tău:
CONSTRAINT pk_ingredients PRIMARY KEY (id_ingredients)
→ coloana se numește id_ingredient, nu id_ingredients.
Category VARCHAR(250)
→ folosește VARCHAR2 în Oracle (nu VARCHAR).
CONSTRAINT pk_id_category PRIMARY KEY (id_category),
→ ai virgulă în plus înainte de ).
lipsă ; la ALTER TABLE ingredients ADD CONSTRAINT ...
Rolul liniilor “în plus”:
SELECT ... all_constraints = interogare de verificare, ca să vezi PK/FK/UNIQUE create.
DESC recipes = comandă SQLPlus pentru descriere tabel (utilă la debugging, nu la creare).

Vreau mai detaliat daca se poate.






Mai detaliat, pe bucăți:
1) SELECT constraint_name, constraint_type ...
SELECT constraint_name, constraint_typeFROM all_constraintsWHERE table_name = 'RECIPES';
Ce face:
Interoghează dicționarul de date Oracle și îți arată constrângerile definite pe tabelul RECIPES.
Ce înseamnă constraint_type:
P = Primary Key
R = Foreign Key
U = Unique
C = Check
Când se folosește:
După ce ai creat tabelul, ca să verifici că PK/FK au fost create corect.
Nu modifică tabela, doar îți arată info.
2) ALTER TABLE ingredients ADD CONSTRAINT ...
ALTER TABLE ingredients ADD CONSTRAINTfk_ingredient_categories FOREIGN KEY (id_category)REFERENCES categories (id_category);
Ce face:
Adaugă după crearea tabelului o constrângere de tip FK.
Spune că ingredients.id_category trebuie să existe în categories.id_category.
De ce apare:
Dacă ai creat tabelul fără FK, îl adaugi ulterior.
E util când:
tabelele sunt create la momente diferite
vrei să controlezi ordinea sau să editezi constrângeri
Când se folosește:
Când FK nu e în CREATE TABLE sau când vrei să adaugi/editezi relații după.
3) DESC recipes
DESC recipes
Ce face:
Comandă din SQLPlus/SQL Developer care descrie tabelul:
coloane, tipuri de date, dacă au NOT NULL.
Când se folosește:
Când vrei să vezi rapid structura tabelului (debugging / verificare).
Nu schimbă nimic în DB.
4) SELECT constraint_name... (din nou)
Este același lucru ca la punctul 1.
Apare din nou pentru verificare după alte modificări.
Când se folosesc în mod normal (context):
La creare:
CREATE TABLE ...
creează efectiv tabela.
După creare (verificare):
DESC tabelaSELECT ... FROM all_constraints ...
doar verifică.
După creare (modificări):
ALTER TABLE ... ADD CONSTRAINT ...
adaugă sau modifică constrângeri.
Concluzie simplă
CREATE TABLE → creează tabelul
ALTER TABLE → modifică tabelul cum? Adaugă constrângeri sau coloane !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT FROM all_constraints → verifică constrângerile
DESC → verifică structura tabelului







7. Sql este un limbaj in care, e putin mai formal de zis: in vscode, " si codul, si toate comenziile pe care in mod obisnuit le dadeam in terminal le punem in cod", iar sql,
citeste rand cu rand?

8. Daca am lucra in simulatorul de la 1, codul ar fi doar acesta, corect:

CREATE TABLE recipes (
  id_recipe NUMBER,
  title VARCHAR2(30),
  instructions VARCHAR2(250),
  CONSTRAINT pk_recipes PRIMARY KEY (id_recipe)
);

CREATE TABLE categories (
  id_category NUMBER,
  category VARCHAR2(250),
  CONSTRAINT pk_categories PRIMARY KEY (id_category)
);

CREATE TABLE ingredients (
  id_ingredient NUMBER,
  id_category NUMBER,
  ingredient VARCHAR2(30),
  CONSTRAINT pk_ingredients PRIMARY KEY (id_ingredient),
  CONSTRAINT fk_ingredients_categories
    FOREIGN KEY (id_category) REFERENCES categories (id_category)
);

CREATE TABLE link (
  id_recipe NUMBER,
  id_ingredient NUMBER,
  quantity NUMBER,
  mu VARCHAR2(30),
  CONSTRAINT pk_link PRIMARY KEY (id_recipe, id_ingredient),
  CONSTRAINT fk_link_recipes
    FOREIGN KEY (id_recipe) REFERENCES recipes (id_recipe),
  CONSTRAINT fk_link_ingredients
    FOREIGN KEY (id_ingredient) REFERENCES ingredients (id_ingredient)
); ?

7. Nu chiar. SQL e un limbaj declarativ: spui ce vrei, nu cum să se execute pas cu pas.
În VSCode nu pui “toate comenzile de terminal” în cod. Pui doar instrucțiuni SQL/PLSQL.
Executarea depinde de cum rulezi:
Run Statement → rulează doar instrucțiunea curentă (nu tot fișierul).
Run Script → rulează tot scriptul, în ordine, de sus în jos.
Deci, SQL nu „citește mereu rând cu rând” ca un program. Rulează instrucțiuni, nu fiecare rând de text.



8. Da. În simulatorul de la punctul 1, doar acest cod e suficient (cele 4 CREATE TABLE).
Restul (DROP, SELECT, DESC) sunt pentru curățare/verificare, nu sunt obligatorii pentru cerință.


*/