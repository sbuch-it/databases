CREATE TABLE Aziende (
  id SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(20) NOT NULL,
  PIVA CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE Dipendenti (
  idAz INTEGER NOT NULL REFERENCES Aziende(id),
  matricola SERIAL NOT NULL,
  nome VARCHAR(20) NOT NULL,
  cognome VARCHAR(20) NOT NULL,
  CF CHAR(16) NOT NULL UNIQUE,
  dataNascita DATE NOT NULL,
  dataAssunzione DATE NOT NULL,
  stipendio DECIMAL(8,2),
  PRIMARY KEY(idAz, matricola),
  CHECK (dataAssunzione > dataNascita)
);

CREATE TABLE Telefoni (
  idAz INTEGER NOT NULL,
  matricolaDip INTEGER NOT NULL,
  numero VARCHAR(20) NOT NULL PRIMARY KEY,
  cellulare BIT DEFAULT 0,
  FOREIGN KEY (idAz, matricolaDip) REFERENCES Dipendenti(idAz, matricola)
);