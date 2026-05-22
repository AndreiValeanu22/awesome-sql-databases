BEGIN EXECUTE IMMEDIATE 'DROP TABLE books_authors CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE books CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE authors CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE book_types CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE publishers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

CREATE TABLE book_types (
  id_type NUMBER NOT NULL,
  type VARCHAR2(50),
  CONSTRAINT pk_book_types PRIMARY KEY (id_type)
);

/*
La aceste probleme pe care ti le-am dat, doar id_x contine NOT NULL? Daca da, de ce?          !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
În soluțiile mele, da: am pus NOT NULL doar pe cheile (PK și FK).
De ce?
PK trebuie să fie NOT NULL (altfel nu poate identifica unic).
FK e de obicei NOT NULL ca să forțezi relația (fiecare rând trebuie să aibă „părinte”).
Restul coloanelor (ex. title, name, content) am lăsat fără NOT NULL pentru flexibilitate.
Dacă vrei reguli mai stricte (ex. titlu obligatoriu), adaugi NOT NULL și acolo.
*/

CREATE TABLE publishers (
  id_publisher NUMBER NOT NULL,
  name VARCHAR2(100),
  CONSTRAINT pk_publishers PRIMARY KEY (id_publisher)
);

CREATE TABLE books (
  id_book NUMBER NOT NULL,
  id_type NUMBER NOT NULL,
  id_publisher NUMBER NOT NULL,
  title VARCHAR2(150),
  no_pages NUMBER,
  publishing_year NUMBER,
  CONSTRAINT pk_books PRIMARY KEY (id_book),
  CONSTRAINT fk_books_types
    FOREIGN KEY (id_type) REFERENCES book_types (id_type),
  CONSTRAINT fk_books_publishers
    FOREIGN KEY (id_publisher) REFERENCES publishers (id_publisher)
);

CREATE TABLE authors (
  id_author NUMBER NOT NULL,
  firstname VARCHAR2(50),
  lastname VARCHAR2(50),
  CONSTRAINT pk_authors PRIMARY KEY (id_author)
);

CREATE TABLE books_authors (
  id_book NUMBER NOT NULL,
  id_author NUMBER NOT NULL,
  CONSTRAINT pk_books_authors PRIMARY KEY (id_book, id_author),
  CONSTRAINT fk_books_authors_books
    FOREIGN KEY (id_book) REFERENCES books (id_book),
  CONSTRAINT fk_books_authors_authors
    FOREIGN KEY (id_author) REFERENCES authors (id_author)
);