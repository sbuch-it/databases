INSERT INTO Candidato(cognome, nome, 
viaResidenza, capResidenza, cittaResidenza, dataNascita, luogoNascita)
VALUES ('Rossi', 'Mario', 'Via dei Rossi', '53100', 'Siena', '1995-01-01', 'Siena'),
('Rossi', 'Luigi', 'Via dei Rossi', '53100', 'Siena', '2000-01-01', 'Siena'),
('Bianchi', 'Andrea', 'Via Roma', '53100', 'Siena', '2001-01-01', 'Siena'),
('Neri', 'Luca', 'Via dei Rozzi', '53100', 'Siena', '2002-01-01', 'Siena');

INSERT INTO Telefono(numero, candidato)
VALUES ('123456789', 1), ('987654321', 2);

INSERT INTO TitoloStudio(descrizione)
VALUES ('diploma'), ('laurea triennale'), ('laurea magistrale');