{\rtf1\ansi\ansicpg1252\cocoartf2511
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 LucidaGrande;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 SELECT\
  g.Name AS G
\f1 E
\f0 NERO,\
  SUM(il.Quantity * il.UnitPrice) AS VALOR_TOTAL\
FROM Genre g\
JOIN Track t\
  ON g.GenreId = t.GenreId\
JOIN InvoiceLine il\
  ON t.TrackId = il.TrackId\
GROUP BY 1\
ORDER BY 2 DESC\
\
\
SELECT\
  sub.PAIS,\
  sub.GENERO,\
  MAX(sub.TOTAL_DE_VENDAS)\
FROM (SELECT\
  c.Country PAIS,\
  SUM(il.Quantity * il.UnitPrice) TOTAL_DE_VENDAS,\
  COUNT(il.Quantity) NUMERO_DE_VENDAS,\
  g.Name GENERO\
FROM Invoice i\
JOIN Customer c\
  ON i.CustomerId = c.CustomerId\
JOIN InvoiceLine il\
  ON i.InvoiceId = il.InvoiceId\
JOIN Track t\
  ON il.TrackId = t.TrackId\
JOIN Genre g\
  ON t.GenreId = g.GenreId\
GROUP BY 1,\
         4\
ORDER BY 2 DESC) sub\
GROUP BY 1\
ORDER BY 3 DESC\
\
\
SELECT\
  SUM(il.Quantity) AS quantidade_por_semestre\
FROM Invoice i\
JOIN InvoiceLine il\
  ON il.InvoiceId = i.InvoiceId\
WHERE strftime('%d', i.invoiceDate) > '15'\
\
UNION\
\
SELECT\
  SUM(il.Quantity) AS quantidade_por_semestre\
FROM Invoice i\
JOIN InvoiceLine il\
  ON il.InvoiceId = i.InvoiceId\
WHERE strftime('%d', i.invoiceDate) < '16'\
\
\
SELECT\
  SUM(il.UnitPrice * il.Quantity) Total_Vendas,\
  i.BillingCountry AS Pa
\f1 \uc0\u65533 
\f0 s,\
  art.Name Artista\
FROM Artist art\
JOIN Album alb\
  ON art.ArtistId = alb.ArtistId\
JOIN Track t\
  ON alb.AlbumId = t.AlbumId\
JOIN InvoiceLine il\
  ON t.TrackId = il.TrackId\
JOIN Invoice i\
  ON il.InvoiceId = i.InvoiceId\
WHERE BillingCountry = 'Brazil'\
GROUP BY 2,\
         3\
ORDER BY 1 DESC\
LIMIT 10}