CREATE TABLE Candidato (
  codice SERIAL NOT NULL PRIMARY KEY,
  cognome VARCHAR(50) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  viaResidenza VARCHAR(100),
  capResidenza CHAR(5),
  cittaResidenza VARCHAR(30),
  dataNascita DATE NOT NULL,
  luogoNascita VARCHAR(30)
);

CREATE TABLE Telefono (
  numero VARCHAR(15) NOT NULL PRIMARY KEY,
  candidato INTEGER REFERENCES Candidato(codice)
);

CREATE TABLE TitoloStudio (
  codice SERIAL NOT NULL PRIMARY KEY,
  descrizione VARCHAR(50) NOT NULL
);

CREATE TABLE Istruzione (
  candidato INTEGER REFERENCES Candidato(codice),
  titoloStudio INTEGER,
  data DATE,
  voto INTEGER,
  istituto VARCHAR(100),
  FOREIGN KEY (titoloStudio) REFERENCES TitoloStudio(codice),
  PRIMARY KEY(candidato, titoloStudio)
);

CREATE TABLE Attivita (
  codice SERIAL NOT NULL PRIMARY KEY,
  mansione VARCHAR(100) NOT NULL
);

CREATE TABLE Esperienza (
  candidato INTEGER REFERENCES Candidato(codice),
  attivita INTEGER REFERENCES Attivita(codice),
  dataInizio DATE NOT NULL,
  dataFine DATE,
  azienda VARCHAR(100),
  PRIMARY KEY(candidato, attivita)
);