SELECT
  g.Name AS GENERO,
  SUM(il.Quantity * il.UnitPrice) AS VALOR_TOTAL
FROM Genre g
JOIN Track t
  ON g.GenreId = t.GenreId
JOIN InvoiceLine il
  ON t.TrackId = il.TrackId
GROUP BY 1
ORDER BY 2 DESC


SELECT
  sub.PAIS,
  sub.GENERO,
  MAX(sub.TOTAL_DE_VENDAS)
FROM (SELECT
  c.Country PAIS,
  SUM(il.Quantity * il.UnitPrice) TOTAL_DE_VENDAS,
  COUNT(il.Quantity) NUMERO_DE_VENDAS,
  g.Name GENERO
FROM Invoice i
JOIN Customer c
  ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il
  ON i.InvoiceId = il.InvoiceId
JOIN Track t
  ON il.TrackId = t.TrackId
JOIN Genre g
  ON t.GenreId = g.GenreId
GROUP BY 1,
         4
ORDER BY 2 DESC) sub
GROUP BY 1
ORDER BY 3 DESC


SELECT
  SUM(il.Quantity) AS quantidade_por_semestre
FROM Invoice i
JOIN InvoiceLine il
  ON il.InvoiceId = i.InvoiceId
WHERE strftime('%d', i.invoiceDate) > '15'

UNION

SELECT
  SUM(il.Quantity) AS quantidade_por_semestre
FROM Invoice i
JOIN InvoiceLine il
  ON il.InvoiceId = i.InvoiceId
WHERE strftime('%d', i.invoiceDate) < '16'


SELECT
  SUM(il.UnitPrice * il.Quantity) Total_Vendas,
  i.BillingCountry AS Pas,
  art.Name Artista
FROM Artist art
JOIN Album alb
  ON art.ArtistId = alb.ArtistId
JOIN Track t
  ON alb.AlbumId = t.AlbumId
JOIN InvoiceLine il
  ON t.TrackId = il.TrackId
JOIN Invoice i
  ON il.InvoiceId = i.InvoiceId
WHERE BillingCountry = 'Brazil'
GROUP BY 2,
         3
ORDER BY 1 DESC
LIMIT 10
