BEGIN EXECUTE IMMEDIATE 'DROP TABLE licenses_drivers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE car_drivers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE cars CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE licenses CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE drivers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE car_types CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE producers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

CREATE TABLE producers (
  id_producer NUMBER NOT NULL,
  name VARCHAR2(100),
  CONSTRAINT pk_producers PRIMARY KEY (id_producer)
);

CREATE TABLE car_types (
  id_type NUMBER NOT NULL,
  type VARCHAR2(50),
  CONSTRAINT pk_car_types PRIMARY KEY (id_type)
);

CREATE TABLE cars (
  id_car NUMBER NOT NULL,
  id_producer NUMBER NOT NULL,
  id_type NUMBER NOT NULL,
  registration_no VARCHAR2(30),
  year NUMBER,
  CONSTRAINT pk_cars PRIMARY KEY (id_car),
  CONSTRAINT fk_cars_producers
    FOREIGN KEY (id_producer) REFERENCES producers (id_producer),
  CONSTRAINT fk_cars_types
    FOREIGN KEY (id_type) REFERENCES car_types (id_type)
);

CREATE TABLE drivers (
  id_driver NUMBER NOT NULL,
  name VARCHAR2(100),
  age NUMBER,
  CONSTRAINT pk_drivers PRIMARY KEY (id_driver)
);

CREATE TABLE car_drivers (
  id_driver NUMBER NOT NULL,
  id_car NUMBER NOT NULL,
  date DATE,
  CONSTRAINT pk_car_drivers PRIMARY KEY (id_driver, id_car),
  CONSTRAINT fk_car_drivers_drivers
    FOREIGN KEY (id_driver) REFERENCES drivers (id_driver),
  CONSTRAINT fk_car_drivers_cars
    FOREIGN KEY (id_car) REFERENCES cars (id_car)
);

CREATE TABLE licenses (
  id_license NUMBER NOT NULL,
  type VARCHAR2(30),
  CONSTRAINT pk_licenses PRIMARY KEY (id_license)
);

CREATE TABLE licenses_drivers (
  id_driver NUMBER NOT NULL,
  id_license NUMBER NOT NULL,
  year NUMBER,
  CONSTRAINT pk_licenses_drivers PRIMARY KEY (id_driver, id_license),
  CONSTRAINT fk_licenses_drivers_drivers
    FOREIGN KEY (id_driver) REFERENCES drivers (id_driver),
  CONSTRAINT fk_licenses_drivers_licenses
    FOREIGN KEY (id_license) REFERENCES licenses (id_license)
);