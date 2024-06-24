CREATE TABLE Città (
  id SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(20),
  nazione VARCHAR(20),
  numeroAbitanti INTEGER,
  mappa BLOB(10MB),
  UNIQUE (nome, nazione)
);

CREATE TABLE Autostrade (
  sigla VARCHAR(10) NOT NULL,
  nazione VARCHAR(20) NOT NULL,
  nomeEU CHAR(4),
  aPagamento BIT DEFAULT 1,
  lunghezza FLOAT,
  PRIMARY KEY (sigla, nazione)
);

CREATE TABLE Uscite (
  città INTEGER REFERENCES Città(id),
  siglaAutostrada VARCHAR(10) NOT NULL,
  nazioneAutostrada VARCHAR(20) NOT NULL,
  nomeUscita VARCHAR(20) NOT NULL,
  longitudine DECIMAL(10,7) CHECK (longitudine IS NULL OR (
    longitudine >= -180 AND longitudine <= 180)),
  latitudine DECIMAL(9,7) CHECK (latitudine IS NULL OR (
    latitudine >= -90 AND latitudine <= 90)),
  dataOraChiusura TIMESTAMP,
  dataOraRiapertura TIMESTAMP,
  FOREIGN KEY (siglaAutostrada, nazioneAutostrada) REFERENCES
    Autostrade(sigla, nazione),
  PRIMARY KEY (siglaAutostrada, nazioneAutostrada, nomeUscita)
);