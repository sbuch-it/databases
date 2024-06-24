CREATE TABLE Nazioni (
  id SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(20) NOT NULL,
  sigla CHAR(3) NOT NULL UNIQUE
);

CREATE TABLE Città (
  nome VARCHAR(20),
  nazione INTEGER NOT NULL REFERENCES Nazioni(id),
  numeroAbitanti INTEGER NOT NULL CHECK (numeroAbitanti > 0),
  mappa BLOB(100M),
  superficie DECIMAL(7,2) CHECK (superficie IS NULL OR superficie > 0),
  capitale BIT NOT NULL,
  PRIMARY KEY(nome, nazione)
);

CREATE TABLE Cittadini (
  id SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(20) NOT NULL,
  cognome VARCHAR(20) NOT NULL,
  dataNascita DATE
);

CREATE TABLE Residenze (
  città VARCHAR(20) NOT NULL,
  nazione INTEGER NOT NULL,
  cittadino INTEGER NOT NULL REFERENCES Cittadini(id),
  inizioResidenza DATE NOT NULL DEFAULT CURRENT_DATE,
  fineResidenza DATE,
  CHECK (fineResidenza IS NULL OR fineResidenza > inizioResidenza),
  FOREIGN KEY (città, nazione) REFERENCES Città(nome, nazione),
  PRIMARY KEY(città, nazione, cittadino, inizioResidenza)
);

CREATE TABLE Distanze (
  città1 VARCHAR(20) NOT NULL,
  nazione1 INTEGER NOT NULL,
  città2 VARCHAR(20) NOT NULL,
  nazione2 INTEGER NOT NULL,
  distanza DECIMAL(6,2) NOT NULL CHECK (distanza > 0),
  PRIMARY KEY(città1, nazione1, città2, nazione2),
  FOREIGN KEY (città1, nazione1) REFERENCES Città(nome, nazione),
  FOREIGN KEY (città2, nazione2) REFERENCES Città(nome, nazione)
);