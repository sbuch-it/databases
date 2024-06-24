CREATE TABLE Autori (
  id SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(20),
  cognome VARCHAR(20),
  dataDiNascita DATE
);

CREATE TABLE Libri (
  id SERIAL NOT NULL,
  nazione VARCHAR(20) NOT NULL,
  titolo VARCHAR(20),
  anno INTEGER CHECK (anno IS NULL OR anno > 1950),
  editore VARCHAR(50),
  copertina BLOB(5M),
  ISBN CHAR(13) UNIQUE NOT NULL,
  disponibile BIT,
  prezzo DECIMAL(4,2) CHECK (prezzo > 0),
  UNIQUE (nazione, editore),
  PRIMARY KEY(id, nazione)
);

CREATE TABLE Stesure (
  autore INTEGER NOT NULL REFERENCES Autori(id),
  idLibro INTEGER NOT NULL,
  nazioneLibro VARCHAR(20) NOT NULL,
  ordine INTEGER DEFAULT 1 CHECK (ordine IS NULL OR ordine > 0),
  PRIMARY KEY (autore, idLibro, nazioneLibro),
  FOREIGN KEY (idLibro, nazioneLibro) REFERENCES Libri(id, nazione)
);