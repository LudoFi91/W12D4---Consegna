-- Verificare che i campi definiti come PK siano univoci 

USE toysgroup
SELECT 'Prodotto' AS tabella, COUNT(*) AS duplicati
FROM Prodotto
GROUP BY id_prodotto
HAVING COUNT(*) > 1

UNION ALL

SELECT 'Categoria' AS tabella, COUNT(*) AS duplicati
FROM Categoria
GROUP BY id_categoria
HAVING COUNT(*) > 1

UNION ALL

SELECT 'Regione' AS tabella, COUNT(*) AS duplicati
FROM Regione
GROUP BY id_regione
HAVING COUNT(*) > 1

UNION ALL

SELECT 'Stato' AS tabella, COUNT(*) AS duplicati
FROM Stato
GROUP BY id_stato
HAVING COUNT(*) > 1

UNION ALL

SELECT 'Vendite' AS tabella, COUNT(*) AS duplicati
FROM Vendite
GROUP BY id_vendita
HAVING COUNT(*) > 1;

-- Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.

USE toysgroup;

SELECT p.nome_prodotto, 
       YEAR(v.data_vendita) AS anno, 
       SUM(v.importo_vendita) AS fatturato_totale 
FROM Prodotto p 
INNER JOIN Vendite v ON p.id_prodotto = v.id_prodotto 
GROUP BY p.nome_prodotto, YEAR(v.data_vendita);

-- Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente


USE toysgroup

SELECT s.nome_stato,
    YEAR(v.data_vendita) AS anno,
    SUM(v.importo_vendita) AS fatturato_totale
FROM 
    Stato s
INNER JOIN 
    Vendite v ON s.id_regione = v.id_regione
GROUP BY 
    s.nome_stato, YEAR(v.data_vendita)
ORDER BY 
    YEAR(v.data_vendita) ASC, SUM(v.importo_vendita) DESC;
    
    
       -- Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato? 
    SELECT 
    c.nome_categoria,
    COUNT(*) AS numero_vendite
FROM 
    Categoria c
INNER JOIN 
    Prodotto p ON c.id_categoria = p.id_categoria
INNER JOIN 
    Vendite v ON p.id_prodotto = v.id_prodotto
GROUP BY 
    c.nome_categoria
ORDER BY 
    COUNT(*) DESC
LIMIT 1;

-- Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti. 
SELECT  nome_prodotto
FROM prodotto
WHERE 
id_prodotto  NOT IN (SELECT DISTINCT id_prodotto FROM vendite);

-- Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).

SELECT  nome_prodotto,
    MAX(data_vendita) AS ultima_data_vendita
FROM 
 prodotto
LEFT JOIN 
vendite ON id_prodotto = id_prodotto
GROUP BY  nome_prodotto ;


