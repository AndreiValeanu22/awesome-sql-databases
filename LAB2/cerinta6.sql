BEGIN EXECUTE IMMEDIATE 'DROP TABLE composers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE songs CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE artists CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE albums CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE bands CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE categories CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/

CREATE TABLE categories (
  id_category NUMBER NOT NULL,
  category VARCHAR2(50),
  CONSTRAINT pk_categories PRIMARY KEY (id_category)
);

CREATE TABLE bands (
  id_band NUMBER NOT NULL,
  name VARCHAR2(100),
  CONSTRAINT pk_bands PRIMARY KEY (id_band)
);

CREATE TABLE albums (
  id_album NUMBER NOT NULL,
  title VARCHAR2(100),
  year NUMBER,
  id_band NUMBER NOT NULL,
  CONSTRAINT pk_albums PRIMARY KEY (id_album),
  CONSTRAINT fk_albums_bands
    FOREIGN KEY (id_band) REFERENCES bands (id_band)
);

CREATE TABLE artists (
  id_artist NUMBER NOT NULL,
  id_band NUMBER NOT NULL,
  firstname VARCHAR2(50),
  lastname VARCHAR2(50),
  date_of_birth DATE,
  CONSTRAINT pk_artists PRIMARY KEY (id_artist),
  CONSTRAINT fk_artists_bands
    FOREIGN KEY (id_band) REFERENCES bands (id_band)
);

CREATE TABLE songs (
  id_song NUMBER NOT NULL,
  id_category NUMBER NOT NULL,
  id_album NUMBER NOT NULL,
  title VARCHAR2(100),
  length NUMBER,
  content VARCHAR2(255),
  CONSTRAINT pk_songs PRIMARY KEY (id_song),
  CONSTRAINT fk_songs_categories
    FOREIGN KEY (id_category) REFERENCES categories (id_category),
  CONSTRAINT fk_songs_albums
    FOREIGN KEY (id_album) REFERENCES albums (id_album)
);

CREATE TABLE composers (
  id_song NUMBER NOT NULL,
  id_artist NUMBER NOT NULL,
  CONSTRAINT pk_composers PRIMARY KEY (id_song, id_artist),
  CONSTRAINT fk_composers_songs
    FOREIGN KEY (id_song) REFERENCES songs (id_song),
  CONSTRAINT fk_composers_artists
    FOREIGN KEY (id_artist) REFERENCES artists (id_artist)
);