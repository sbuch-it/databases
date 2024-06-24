/* 1 */

SELECT Difetti.descrizione, Segnalazioni.data, Prodotti.nome
FROM Difetti, Segnalazioni, Prodotti, Clienti
WHERE Prodotti.id = Difetti.prodotto AND
Difetti.id = Segnalazioni.difetto AND
Segnalazioni.clienteID = Clienti.id AND
Segnalazioni.clienteNaz = Clienti.nazione AND
Clienti.nome = 'Pippo' AND Segnalazioni.data > '2000-01-01'

/* 2 */

SELECT Sedi.nome, Prodotti.nome, Difetti.descrizione
FROM Sedi LEFT JOIN Prodotti ON Sedi.id = Prodotti.sede
LEFT JOIN Difetti ON Prodotti.id = Difetti.prodotto
WHERE Sedi.città = 'Siena'

/* 3 */

SELECT Sedi.nome, Prodotti.nome, Difetti.descrizione
FROM Sedi LEFT JOIN Prodotti ON Sedi.id = Prodotti.sede
LEFT JOIN Difetti ON Prodotti.id = Difetti.prodotto
WHERE Sedi.città = 'Siena' AND (
  Difetti.stato IS NULL OR Difetti.stato = 'fixed')

/* 4 */

SELECT P1.nome, P2
FROM Prodotti AS P1, Prodotti AS P2
WHERE P1.prezzo = P2.prezzo

/* 5 */

SELECT MAX(prezzo)
FROM Prodotti

/* 6 */

SELECT nome
FROM Prodotti
WHERE prezzo = (SELECT MAX(prezzo) FROM Prodotti)

/* 7 */

CREATE VIEW PrezzoMassimo(prezzo) AS
  SELECT MAX(prezzo)FROM Prodotti

SELECT nome
FROM Prodotti, PrezzoMassimo
WHERE Prodotti.prezzo = PrezzoMassimo.prezzo

/* 8 */

SELECT Sedi.nome, AVG(prezzo)
FROM Sedi, Prodotti
WHERE Sedi.id = Prodotti.sede
GROUP BY Sedi.id, Sedi.nome

/* 9 */

SELECT Prodotti.nome, COUNT(*) AS "Numero di difetti"
FROM Prodotti, Difetti
WHERE Prodotti.id = Difetti.prodotto AND Difetti.stato <> 'fixed'
GROUP BY Prodotti.id, Prodotti.nome
HAVING COUNT(*) > 3

/* 10 usando le sottointerrogazioni */

SELECT Sedi.id, Sedi.nome
FROM Sedi
WHERE Sedi.id NOT IN (
  SELECT Prodotti.sede
  FROM Prodotti WHERE Prodotti.prezzo > 100)

/* 10 usando gli operatori insiemistici */

SELECT Sedi.id, Sedi.nome
FROM Sedi
EXCEPT
SELECT Sedi.id, Sedi.nome
FROM Sedi, Prodotti
WHERE Sedi.id = Prodotti.sede AND Prodotti.prezzo > 100

/* 11 */

CREATE VIEW DifettiSede (sedeId, sedeNome, numeroDifetti) AS
  SELECT Prodotti.sede, Sede.nome, COUNT(*)
  FROM Sedi, Prodotti, Difetti
  WHERE Sedi.id = Prodotti.sede AND Prodotti.id = Difetti.prodotto
  GROUP BY Prodotti.sede, Prodotti.id, Prodotti.nome

SELECT sedeNome, AVG(numeroDifetti) AS "Media dei difetti"
FROM DifettiSede
GROUP BY sedeId, sedeNome