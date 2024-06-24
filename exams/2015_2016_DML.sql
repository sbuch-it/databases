/* creazione delle tabelle */

CREATE TABLE Giocatori (
  id SERIAL NOT NULL PRIMARY KEY,
  nomeGiocatore VARCHAR(20),
  dataDiNascita DATE
);

CREATE TABLE Squadre (
  id SERIAL NOT NULL PRIMARY KEY,
  nomeSquadra VARCHAR(20),
  città VARCHAR(20)
);

CREATE TABLE Contratti (
  giocatore INTEGER NOT NULL
    REFERENCES Giocatori(id),
  squadra INTEGER NOT NULL
    REFERENCES Squadre(id),
  costo DECIMAL (5,2),
  anno INTEGER,
  PRIMARY KEY (giocatore, squadra)
);

CREATE TABLE Fratelli (
  giocatore1 INTEGER NOT NULL REFERENCES Giocatori(id),
  giocatore2 INTEGER NOT NULL REFERENCES Giocatori(id),
  PRIMARY KEY (giocatore1, giocatore2)
);

/* inserimento dei dati */

INSERT INTO Giocatori (nomeGiocatore, DataDiNascita) VALUES
  ('Mario Rossi', '2000-01-01'),
  ('Luca Rossi', '2000-03-01'),
  ('Luca Verdi', '2002-03-01'),
  ('Andrea Bianchi', '2004-01-01'),
  ('Marco Verdi', '2004-01-01');

INSERT INTO Squadre (nomeSquadra, città) VALUES
  ('Squadra A', 'Roma'),
  ('Squadra B', 'Milano'),
  ('Squadra C', 'Milano');

INSERT INTO Contratti
  (giocatore, squadra, costo, anno) VALUES
  ('1', '1', '10', '2007'),
  ('2', '1', '20', '2007'),
  ('3', '2', '30', '2008'),
  ('4', '2', '30', '2009'),
  ('5', '2', '140', '2009'),
  ('4', '1', '50', '2010'),
  ('4', '3', '50', '2011');

INSERT INTO Fratelli (giocatore1, giocatore2) VALUES
  ('1', '2'),
  ('3', '5');

/* 1 */

SELECT MAX(costo)
FROM Contratti

/* 2 */

SELECT DISTINCT(squadra)
FROM Contratti
WHERE squadra NOT IN (
  SELECT squadra
  FROM Contratti
  WHERE costo > 100)

/* 3 */

SELECT Squadre.nomeSquadra, Giocatori.nomeGiocatore, Contratti.costo
FROM Squadre LEFT JOIN Contratti ON (Squadre.id = Contratti.squadra)
  LEFT JOIN Giocatori ON (Contratti.giocatore = Giocatori.id)
WHERE Squadre.città = 'Milano'
ORDER BY Squadre.nomeSquadra, Giocatori.nomeGiocatore

/* 4 */

SELECT Giocatori1.nomeGiocatore, Giocatori1.dataDiNascita,
  Giocatori2.nomeGiocatore, Giocatori2.dataDiNascita
FROM Giocatori AS Giocatori1, Giocatori AS Giocatori2, Fratelli
WHERE Fratelli.giocatore1 = Giocatori1.id AND
  Fratelli.giocatore2 = Giocatori2.id

/* 5 */

SELECT Squadre.nomeSquadra, SUM(Contratti.costo) * 1.7 AS costoLordo
FROM Squadre, Contratti
WHERE Squadre.id = Contratti.squadra
GROUP BY Squadre.nomeSquadra

/* 6 */

SELECT Giocatori.nomeGiocatore, COUNT(*)
FROM Giocatori, Contratti
WHERE Giocatori.id = Contratti.giocatore AND
  Contratti.anno > 2000
GROUP BY Giocatori.id
HAVING COUNT(*) > 2

/* 7 */

SELECT Squadre.id, Squadre.nomeSquadra
FROM Squadre, Contratti
WHERE Squadre.id = Contratti.squadra AND Contratti.anno = 2010
INTERSECT
SELECT Squadre.id, Squadre.nomeSquadra
FROM Squadre, Contratti
WHERE Squadre.id = Contratti.squadra AND Contratti.anno = 2011

/* 8 usando NOT IN */

SELECT nomeGiocatore
FROM Giocatori
WHERE id NOT IN (
  SELECT giocatore
  FROM Contratti
  WHERE anno = 2013)

/* 8 usando NOT EXISTS */

SELECT nomeGiocatore
FROM Giocatori
WHERE NOT EXISTS(
  SELECT giocatore
  FROM Contratti
  WHERE anno = 2013 AND Giocatori.id=Contratti.giocatore)

/* 9 */

SELECT Giocatori.nomeGiocatore
FROM Giocatori, Contratti
WHERE Giocatori.id = Contratti.giocatore AND
  Contratti.costo < (SELECT AVG(costo) FROM Contratti)

/* 10 */

CREATE VIEW SpeseSquadre (costoSquadra) AS
  SELECT SUM(Contratti.costo) AS costoSquadra
  FROM Squadre, Contratti
  WHERE Squadre.id = Contratti.squadra
  GROUP BY Squadre.nomeSquadra

SELECT MAX(costoSquadra)
FROM SpeseSquadre