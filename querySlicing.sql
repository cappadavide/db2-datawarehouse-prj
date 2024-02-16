-- First Slicing
-- without view
SELECT SUM(S2.unit_sales)
FROM ((STORES S1 JOIN SALES S2 ON S1.store_nbr=S2.store_nbr) JOIN items I ON S2.item_nbr = I.item_nbr) JOIN data D on S2.data = D.data 
WHERE S2.store_nbr = 2 AND D.year = 2013 AND I.family LIKE '%DELI%' AND D.day LIKE '%Monday%'
GROUP BY S2.store_nbr, D.year, I.family, D.day;
-- with view
SELECT SUM(V.unitSales)
FROM vistaSlicing AS V 
WHERE V.store = 2 AND V.year = 2013 AND V.family LIKE '%DELI%' AND V.day LIKE '%Monday%'
GROUP BY V.store, V.year, V.family, V.day;


--Second Slicing

SELECT SUM(S2.unit_sales)
FROM ((STORES S1 JOIN SALES S2 ON S1.store_nbr=S2.store_nbr) JOIN items I ON S2.item_nbr = I.item_nbr) JOIN data D on S2.data = D.data 
WHERE S1.state LIKE '%Bolivar%' AND I.family LIKE '%DELI%' AND D.day LIKE '%Monday%' AND D.year = 2013
GROUP BY S1.state, I.family, D.day, D.year;

SELECT SUM(V.unitSales)
FROM vistaSlicing AS V
WHERE V.state LIKE '%Bolivar%' AND V.family LIKE '%DELI%' AND V.day LIKE '%Monday%' AND V.year = 2013
GROUP BY V.state, V.family, V.day, V.year;


--Third Slicing

SELECT SUM(S2.unit_sales)
FROM ((STORES S1 JOIN SALES S2 ON S1.store_nbr=S2.store_nbr) JOIN items I ON S2.item_nbr = I.item_nbr) JOIN data D on S2.data = D.data 
WHERE S2.store_nbr=2 AND D.week=12 AND D.year = 2013 AND I.family LIKE '%CLEANING%'
GROUP BY S2.store_nbr, D.week, D.year, I.family;

SELECT SUM(V.unitSales)
FROM vistaSlicing AS V
WHERE V.store=2 AND V.week=12 AND V.year = 2013 AND V.family LIKE '%CLEANING%'
GROUP BY V.store, V.week, V.year, V.family;


--Fourth Slicing

SELECT SUM(S2.unit_sales)
FROM ((STORES S1 JOIN SALES S2 ON S1.store_nbr=S2.store_nbr) JOIN items I ON S2.item_nbr = I.item_nbr) JOIN data D on S2.data = D.data 
WHERE D.week=2 AND D.year = 2013 AND S1.state LIKE '%Bolivar%' AND I.family LIKE '%DELI%'
GROUP BY D.week, D.year, S1.state, I.family;

SELECT SUM(V.unitSales)
FROM vistaSlicing AS V
WHERE V.week=2 AND V.year = 2013 AND V.state LIKE '%Bolivar%' AND V.family LIKE '%DELI%'
GROUP BY V.week, V.year, V.state, V.family;


--Fifth Slicing

SELECT SUM(S2.unit_sales)
FROM ((STORES S1 JOIN SALES S2 ON S1.store_nbr=S2.store_nbr) JOIN items I ON S2.item_nbr = I.item_nbr) JOIN data D on S2.data = D.data 
WHERE S2.store_nbr=1 AND D.month=6 AND D.year = 2013 AND I.family LIKE '%CLEANING%'
GROUP BY S2.store_nbr, D.month, D.year, I.family;

SELECT SUM(V.unitSales)
FROM vistaSlicing AS V
WHERE V.store=1 AND V.month=6 AND V.year = 2013 AND V.family LIKE '%CLEANING%'
GROUP BY V.store, V.month, V.year, V.family;


--Sixth Slicing

SELECT SUM(S2.unit_sales)
FROM ((STORES S1 JOIN SALES S2 ON S1.store_nbr=S2.store_nbr) JOIN items I ON S2.item_nbr = I.item_nbr) JOIN data D on S2.data = D.data 
WHERE D.year = 2013 AND S1.state LIKE '%Pichincha%' AND I.family LIKE '%DELI%'
GROUP BY S1.state, D.year, I.family;

SELECT SUM(V.unitSales)
FROM vistaSlicing AS V
WHERE V.year = 2013 AND V.state LIKE '%Pichincha%' AND V.family LIKE '%DELI%'
GROUP BY V.state, V.year, V.family;


--Seventh Slicing

SELECT SUM(S2.unit_sales)
FROM (((STORES S1 JOIN SALES S2 ON S1.store_nbr=S2.store_nbr) JOIN items I ON S2.item_nbr = I.item_nbr) JOIN data D on S2.data = D.data ) LEFT JOIN holiday_events h on d.data=h.data
WHERE D.year = 2013 AND D.month=4 AND S1.state LIKE '%Pichincha%' AND I.family LIKE '%GROCERY II%' AND (D.day LIKE '%Sunday%' OR h.locale='Local')
GROUP BY D.year, D.month, S1.state, I.family;

SELECT SUM(V.unitSales)
FROM vistaSlicing AS V
WHERE V.year = 2013 AND V.month=4 AND V.state LIKE '%Pichincha%' AND V.family LIKE '%GROCERY II%' AND (V.day LIKE '%Sunday%' OR V.data in (SELECT h.data FROM holiday_events h WHERE h.locale='Local'))
GROUP BY V.year, V.month, V.state, V.family;


--Eighth Slicing

SELECT SUM(S2.unit_sales)
FROM ((STORES S1 JOIN SALES S2 ON S1.store_nbr=S2.store_nbr) JOIN items I ON S2.item_nbr = I.item_nbr) JOIN data D on S2.data = D.data 
WHERE D.month=2 AND D.year = 2013 AND S1.state LIKE '%Cotopaxi%' AND I.family LIKE '%DELI%'
GROUP BY D.month, D.year, S1.state, I.family;

SELECT SUM(V.unitSales)
FROM vistaSlicing AS V
WHERE V.month=2 AND V.year = 2013 AND V.state LIKE '%Cotopaxi%' AND V.family LIKE '%DELI%'
GROUP BY V.month, V.year, V.state, V.family;
