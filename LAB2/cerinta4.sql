BEGIN EXECUTE IMMEDIATE 'DROP TABLE flowers_bouquete CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE bouquets CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE bouquets_types CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE flowers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE flower_types CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

CREATE TABLE flower_types (
  id_type NUMBER NOT NULL,
  type VARCHAR2(50),
  CONSTRAINT pk_flower_types PRIMARY KEY (id_type)
);

CREATE TABLE flowers (
  id_flower NUMBER NOT NULL,
  name VARCHAR2(100),
  price NUMBER,
  color VARCHAR2(30),
  quantity NUMBER,
  id_type NUMBER NOT NULL,
  CONSTRAINT pk_flowers PRIMARY KEY (id_flower),
  CONSTRAINT fk_flowers_types
    FOREIGN KEY (id_type) REFERENCES flower_types (id_type)
);

CREATE TABLE bouquets_types (
  id_type NUMBER NOT NULL,
  type VARCHAR2(50),
  CONSTRAINT pk_bouquets_types PRIMARY KEY (id_type)
);

CREATE TABLE bouquets (
  id_bouquet NUMBER NOT NULL,
  name VARCHAR2(100),
  id_type NUMBER NOT NULL,
  CONSTRAINT pk_bouquets PRIMARY KEY (id_bouquet),
  CONSTRAINT fk_bouquets_types
    FOREIGN KEY (id_type) REFERENCES bouquets_types (id_type)
);

CREATE TABLE flowers_bouquete (
  id_bouquet NUMBER NOT NULL,
  id_flower NUMBER NOT NULL,
  number_flower NUMBER,
  CONSTRAINT pk_flowers_bouquete PRIMARY KEY (id_bouquet, id_flower),
  CONSTRAINT fk_flowers_bouquete_bouquets
    FOREIGN KEY (id_bouquet) REFERENCES bouquets (id_bouquet),
  CONSTRAINT fk_flowers_bouquete_flowers
    FOREIGN KEY (id_flower) REFERENCES flowers (id_flower)
);