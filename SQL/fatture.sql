CREATE TABLE Clienti (
  codice SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(20),
  indirizzo VARCHAR(40),
  partitaIVA CHAR(11) UNIQUE
);

CREATE TABLE Prodotti (
  codice SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(20),
  descrizione VARCHAR(256),
  prezzo DECIMAL(8,2)
);

CREATE TABLE Fatture (
  codice SERIAL NOT NULL PRIMARY KEY,
  cliente INTEGER NOT NULL REFERENCES Clienti(codice),
  data DATE
);

CREATE TABLE RigheFattura (
  codice SERIAL NOT NULL PRIMARY KEY,
  fattura INTEGER NOT NULL REFERENCES Fatture(codice),
  prodotto INTEGER NOT NULL REFERENCES Prodotti(codice),
  quantità INTEGER
  prezzo DECIMAL(8,2)
);