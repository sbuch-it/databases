CREATE TABLE Nazioni (
  id SERIAL NOT NULL PRIMARY KEY,
  sigla CHAR(3) UNIQUE,
  nome VARCHAR(10) UNIQUE,
  estensione FLOAT,
  europea BIT DEFAULT 1,
  numeroAbitanti INTEGER
);

CREATE TABLE Pazienti (
  nazione INTEGER NOT NULL REFERENCES Nazioni(id),
  ssn VARCHAR(30) NOT NULL,
  nome VARCHAR(20),
  cognome VARCHAR(20),
  sesso CHAR CHECK
    (sesso IS NULL OR sesso = 'u' OR sesso = 'd'),
  dataDiNascita DATE,
  altezza DECIMAL(5,2),
  peso DECIMAL(5,2),
  PRIMARY KEY (nazione, ssn)
);

CREATE TABLE EsamiMedici (
  dataEOra TIMESTAMP NOT NULL,
  nazione INTEGER NOT NULL,
  ssn VARCHAR(30) NOT NULL,
  file BLOB(50M),
  descrizione VARCHAR(20),
  PRIMARY KEY (dataEOra, nazione, ssn),
  FOREIGN KEY (nazione, ssn) REFERENCES Pazienti(nazione, ssn)
);