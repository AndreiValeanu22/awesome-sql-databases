BEGIN EXECUTE IMMEDIATE 'DROP TABLE tags_articles CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE comments CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE articles CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE tags CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

CREATE TABLE users (
  id NUMBER NOT NULL,
  username VARCHAR2(50),
  password VARCHAR2(50),
  CONSTRAINT pk_users PRIMARY KEY (id)
);

CREATE TABLE articles (
  id NUMBER NOT NULL,
  iduser NUMBER NOT NULL,
  title VARCHAR2(100),
  content VARCHAR2(255),
  CONSTRAINT pk_articles PRIMARY KEY (id),
  CONSTRAINT fk_articles_users
    FOREIGN KEY (iduser) REFERENCES users (id)
);

CREATE TABLE comments (
  id NUMBER NOT NULL,
  article_comment VARCHAR2(255),
  idarticle NUMBER NOT NULL,
  iduser NUMBER NOT NULL,
  CONSTRAINT pk_comments PRIMARY KEY (id),
  CONSTRAINT fk_comments_articles
    FOREIGN KEY (idarticle) REFERENCES articles (id),
  CONSTRAINT fk_comments_users
    FOREIGN KEY (iduser) REFERENCES users (id)
);

CREATE TABLE tags (
  id NUMBER NOT NULL,
  tagname VARCHAR2(50),
  CONSTRAINT pk_tags PRIMARY KEY (id)
);

CREATE TABLE tags_articles (
  idarticle NUMBER NOT NULL,
  idtag NUMBER NOT NULL,
  CONSTRAINT pk_tags_articles PRIMARY KEY (idarticle, idtag), -- !!!!!!!! sunt doua chei primare, pentru ca o combinatie dintre idarticle si idtag trebuie sa fie unica, adica un articol sa nu aiba acelasi tag de doua ori
  CONSTRAINT fk_tags_articles_articles
    FOREIGN KEY (idarticle) REFERENCES articles (id),
  CONSTRAINT fk_tags_articles_tags
    FOREIGN KEY (idtag) REFERENCES tags (id)
);

/*
1. De ce mai pui asta la exercitiul 1: CONSTRAINT fk_articles_users? Chiar trebuie? Cum iti dai seama de FK si PK? FK sunt de unde porneste/de unde ajunge dintr-o/intr-o tabela in alta sageata si nu are cheie aurita, si PK e cheie aurita, oricum ar fi drumul? (1)
Da, dacă vrei să respecți diagrama. În diagramă, articles.iduser referă users.id ⇒ asta este o cheie străină (FK).
PK = cheia aurită (identificator unic).
FK = coloana care arată către PK din alt tabel (capătul cu săgeata care intră în tabelul „părinte”).
Regulă simplă: dacă într-un tabel ai idX care se leagă de X.id, atunci pui FK.

(1)
Da, exact:
PK = coloana cu cheie aurită în tabelul „părinte”.
FK = coloana din tabelul „copil” care nu are cheie aurită și păstrează ID‑ul din tabelul părinte.
Practic, FK e locul de unde pleacă săgeata.
Deci:
săgeata intră în PK (cheia aurită)
săgeata pleacă din FK (coloana fără cheie aurită)


2. Tot la exercitiul 1, care e logica, se porneste cu tabelul care are sageti din ce in ce mai multe, plecandu-se de la mai putin, sau cum?
Trebuie să creezi întâi tabelele părinte (cele cu PK‑urile referențiate), apoi pe cele care au FK.
În Ex. 1:
users, tags → apoi articles → apoi comments și tags_articles.
Cu cât are mai multe FK‑uri, cu atât trebuie creat mai târziu. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


3. La fel ca la intrebarea 1, de ce ai mai pus: CONSTRAINT fk_comments_articles si CONSTRAINT fk_comments_users?
Pentru că comments are două FK:
idarticle → articles.id
iduser → users.id
Diagrama arată două relații, deci două FK.


4. Cand ai sageata care vine spre tabelul pe care tu il creezi atunci nu se pune ceva in gen CONSTRAINT fk_comments_articles, dar cand pleaca atunci pui ceva in gen CONSTRAINT fk_comments_articles, corect?
Pui FK în tabelul din care pleacă săgeata (tabelul copil), nu în cel în care intră.
Săgeata intră în users ⇒ FK este în tabelul care pleacă (ex: articles.iduser).
Deci formula corectă:
Dacă săgeata pleacă din tabela ta către alta, pui FK în tabela ta.
Dacă săgeata doar vine spre tabela ta, nu pui FK acolo (PK e deja în ea).

*/