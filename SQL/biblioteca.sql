CREATE TABLE Sedi (
  id SERIAL NOT NULL PRIMARY KEY,
  indirizzo VARCHAR(20)
);

CREATE TABLE Autori (
  nome VARCHAR(20) NOT NULL,
  cognome VARCHAR(20) NOT NULL,
  dataDiNascita DATE NOT NULL,
  luogoDiNascita VARCHAR(20),
  PRIMARY KEY(nome, cognome, dataDiNascita)
);

CREATE TABLE Libri (
  titolo VARCHAR(20),
  nomeAutore VARCHAR(20),
  cognomeAutore VARCHAR(20),
  dataDiNascitaAutore DATE,
  dataPubblicazionePrimaVersione DATE,
  dataPubblicazioneQuestaVersione DATE CHECK
    (dataPubblicazionePrimaVersione <=
      dataPubblicazioneQuestaVersione),
  sede INTEGER REFERENCES Sedi(id),
  ISBN CHAR(13) NOT NULL PRIMARY KEY,
  prezzo DECIMAL(5,2) DEFAULT 0 CHECK (prezzo >= 0),
  numeroPagine INTEGER DEFAULT 0 CHECK (prezzo >= 0),
  
  FOREIGN KEY(nomeAutore, cognomeAutore, dataDiNascitaAutore)
  REFERENCES Autori(nome, cognome, dataDiNascita)
);