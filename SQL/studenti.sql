CREATE TABLE Studenti (
  matricola VARCHAR(20) NOT NULL,
  università VARCHAR(20) NOT NULL,
  nome VARCHAR(20) NOT NULL,
  cognome VARCHAR(20) NOT NULL,
  dataDiNascita DATE
  codiceFiscale CHAR(16) NOT NULL UNIQUE,
  
  PRIMARY KEY(matricola, università)
);

CREATE TABLE Corsi (
  id SERIAL NOT NULL PRIMARY KEY,
  nome VARCHAR(20) NOT NULL,
  docente VARCHAR(20) NOT NULL,
  numeroStudentiPrevisto INTEGER DEFAULT 20
);

CREATE TABLE Esami (
  studente VARCHAR(20) NOT NULL
  università VARCHAR(20) NOT NULL,
  corso INT REFERENCES Corsi(id) NOT NULL,
  data DATE NOT NULL,
  voto INTEGER NOT NULL,
  lode BIT NOT NULL CHECK(lode = 0 OR Voto = 30),
  
  PRIMARY KEY(studente, università, corso),
  
  FOREIGN KEY(studente, università)
    REFERENCES Studenti(matricola, università)
);