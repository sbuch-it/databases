/* 1 */

SELECT Telefoni.numero, Dipendenti.nome, Dipendenti.cognome, Aziende.nome
FROM Aziende, Dipendenti, Telefoni
WHERE Dipendenti.idAz = Aziende.id AND
Telefoni.idAz = Dipendenti.idAz AND
Telefoni.matricolaDip = Dipendenti.matricola AND
Dipendenti.dataAssunzione > '1990-01-01'
ORDER BY Aziende.nome, Dipendenti.cognome, Dipendenti.nome

/* 2 */

SELECT Dipendenti.cognome, Dipendenti.nome,
Dipendenti.stipendio AS "Stipendio lordo",
Dipendenti.stipendio * 0.6 AS "Stipendio netto"
FROM Dipendenti, Aziende
WHERE Dipendenti.idAz = Aziende.id AND Aziende.nome = 'de Paperoni spa'
ORDER BY Dipendenti.cognome DESC, Dipendenti.nome ASC

/* 3 */

SELECT Dipendenti.nome, Dipendenti.cognome, Aziende.nome
FROM Dipendenti, Aziende
WHERE Dipendenti.idAz = Aziende.id AND Aziende.nome LIKE 'P%'

/* 4 */

SELECT Dipendenti.nome, Dipendenti.cognome, Aziende.nome
FROM Aziende LEFT JOIN Dipendenti ON Dipendenti.idAz = Aziende.id
WHERE Aziende.nome LIKE 'P%'

/* 5 con coppia di aziende due volte */

SELECT Az1.nome, Az2.nome, Az2.dataNascita
FROM Aziende AS Az1, Aziende AS Az2
WHERE Az1.dataNascita = Az2.dataNascita

/* 5 con coppia di aziende una volta */

SELECT Az1.nome, Az2.nome, Az2.dataNascita
FROM Aziende AS Az1, Aziende AS Az2
WHERE Az1.dataNascita = Az2.dataNascita AND Az1.id > Az2.id

/* 6 */

SELECT COUNT(*)
FROM Aziende

/* 7 */

SELECT COUNT(DISTINCT(nome))
FROM Aziende

/* 8 */

SELECT nazione, COUNT(*)
FROM Aziende
GROUP BY nazione

/* 9 */

SELECT nazione, COUNT(*)
FROM Aziende
WHERE numeroDipendenti > 15
GROUP BY nazione
HAVING COUNT(*) > 20

/* 10 */

SELECT Aziende.nome, AVG(Dipendenti.stipendio)
FROM Aziende, Dipendenti
WHERE Aziende.id = Dipendenti.idAz
GROUP BY Aziende.id, Aziende.nome

/* 11 */

CREATE VIEW StipendioMedio (nome, media) AS
  SELECT Aziende.nome, AVG(Dipendenti.stipendio)
  FROM Aziende, Dipendenti
  WHERE Aziende.id = Dipendenti.idAz
  GROUP BY Aziende.id, Aziende.nome

/* 12 */

SELECT nome, media AS "Media stipendio lordo",
media * 0.6 AS "Media stipendio netto"
FROM StipendioMedio

/* 13 usando le sottointerrogazioni */

SELECT nome, id
FROM Aziende
WHERE id NOT IN (SELECT idAz FROM Dipendenti)

/* 13 usano l'operatore differenza EXCEPT */

SELECT nome, id
FROM Aziende
EXCEPT
SELECT nome, id
FROM Aziende, Dipendenti
WHERE Aziende.id = Dipendenti.idAz

/* 14 */

SELECT nome
FROM Aziende
WHERE NOT EXISTS (
  SELECT *
  FROM Dipendenti
  WHERE dataNascita <> dataAssunzione AND
  Aziende.id = Dipendenti.idAz)

/* 15 usando le viste e il join */

CREATE VIEW MaxNumeroDipendenti (massimo) AS
  SELECT MAX(numeroDipendenti)
  FROM Aziende

SELECT nome
FROM Aziende, MaxNumeroDipendenti
WHERE Aziende.numeroDipendenti = MaxNumeroDipendenti.massimo

/* 15 usano le viste e le sottointerrogazioni */

CREATE VIEW MaxNumeroDipendenti (massimo) AS
  SELECT MAX(numeroDipendenti)
  FROM Aziende

SELECT nome
FROM Aziende, MaxNumeroDipendenti
WHERE Aziende.numeroDipendenti IN (
  SELECT massimo FROM MaxNumeroDipendenti)

/* 16 */

CREATE VIEW MediaDipendenti (nazione, media) AS
  SELECT nazione, AVG(numeroDipendenti)
  FROM Aziende
  GROUP BY nazione

SELECT nazione
FROM MediaDipendenti
WHERE media IN (SELECT MAX(media) FROM MediaDipendenti)