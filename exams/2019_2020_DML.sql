/* 1 */

SELECT nomeDipendente
FROM Dipendenti
WHERE dataNascita > '1960-01-01' AND
dataNascita > (SELECT dataNascita
  FROM Dipendenti WHERE dataNascita > '1960-01-01')

/* 2 */

SELECT nomeDipendente
FROM Dipendenti, Incarichi
WHERE Dipendenti.id = Incarichi.dipendente AND
dataIncarico > '2020-01-01'

/* 3 */

SELECT nomeDipendente, stipendio
FROM Dipendenti, Incarichi
WHERE Dipendenti.id = Incarichi.dipendente AND
dataNascita < '1980-01-01' AND stipendio > 30000
ORDER BY nomeDipendente

/* 4 */

SELECT Progetti.nomeProgetto, Dipendenti.nomeDipendente
FROM Progetti LEFT JOIN Incarichi ON Progetti.id = Incarichi.progetto
LEFT JOIN Dipendenti ON Incarichi.dipendente = Dipendenti.id
AND Dipendenti.stipendio < 50000

/* 5 */

SELECT D2.nomeDipendente AS "Nome del figlio"
FROM Dipendenti AS D1, Dipendenti AS D2, Genitori
WHERE D1.nomeDipendente = 'Paperino' AND
D1.id = Genitori.genitore AND D2.id = Genitori.figlio

/* 6 */

SELECT sede, SUM(budget)
FROM Progetti
GROUP BY sede

/* 7 */

SELECT sede, SUM(budget)
FROM Progetti
WHERE budget < 10000
GROUP BY sede
HAVING COUNT(*) > 3

/* 8 */

SELECT id, nomeDipendente
FROM Dipendenti
WHERE stipendio > 100000
EXCEPT
SELECT id, nomeDipendente
FROM Dipendenti, Incarichi
WHERE stipendio > 100000 AND
Incarichi.dipendente = Dipendenti.id

/* 9 */
