-- Calcolo unità vendute rispetto al mese precedente (varia class)

SELECT C.item, C.class, C.meseCurr, C.unitaMeseCurr, C.mesePrec, C.unita_mesePrecedente, C.year
FROM (SELECT H.item_nbr AS item, H.class AS class, H.family AS family, H.mese_corrente AS meseCurr, H.mese_precedente AS mesePrec, H.year AS year, H.unita_meseCorrente AS unitaMeseCurr, LAG(H.unita_meseCorrente) OVER (PARTITION BY H.item_nbr ORDER BY H.mese_corrente,H.year) unita_mesePrecedente
FROM (SELECT I.item_nbr, I.class, I.family, D.month AS mese_corrente, (D.month-1) AS mese_precedente, D.year, SUM(S.unit_sales) AS unita_meseCorrente
            FROM items I JOIN sales S on I.item_nbr=S.item_nbr JOIN Data D ON S.data=D.data
            GROUP BY I.item_nbr, D.month, D.year) AS H
        ) AS C
WHERE C.class=1072 AND C.unitaMeseCurr<C.unita_mesePrecedente;


SELECT C.item_nbr, C.class, C.currentMonth, C.unitSalesCurrentMonth, C.previousMonth, C.unitSalesPreviousMonth, C.year
FROM calcoloUnitaPerMese AS C
WHERE C.class=1072 AND C.unitSalesCurrentMonth<C.unitSalesPreviousMonth;


-- Calcolo unità vendute rispetto al mese precedente (varia family)

SELECT C.item, C.class, C.meseCurr, C.unitaMeseCurr, C.mesePrec, C.unita_mesePrecedente, C.year
FROM (SELECT H.item_nbr AS item, H.class AS class, H.family AS family, H.mese_corrente AS meseCurr, H.mese_precedente AS mesePrec, H.year AS year, H.unita_meseCorrente AS unitaMeseCurr, LAG(H.unita_meseCorrente) OVER (PARTITION BY H.item_nbr ORDER BY H.mese_corrente,H.year) unita_mesePrecedente
FROM (SELECT I.item_nbr, I.class, I.family, D.month AS mese_corrente, (D.month-1) AS mese_precedente, D.year, SUM(S.unit_sales) AS unita_meseCorrente
            FROM items I JOIN sales S on I.item_nbr=S.item_nbr JOIN Data D ON S.data=D.data
            GROUP BY I.item_nbr, D.month, D.year) AS H
        ) AS C
WHERE C.family LIKE‘%DELI%’ AND C.unitaMeseCurr<C.unita_mesePrecedente;


SELECT C.item_nbr, C.class, C.currentMonth, C.unitSalesCurrentMonth, C.previousMonth, C.unitSalesPreviousMonth, C.year
FROM calcoloUnitaPerMese AS C
WHERE C.family LIKE ‘%DELI%’ AND C.unitSalesCurrentMonth<C.unitSalesPreviousMonth;


-- Calcolo unità vendute rispetto all’anno precedente (varia class)

SELECT C.item, C.class, C.annoCurr, C.unitaAnnoCurr, C.annoPrec, C.unitSalesPreviousYear
FROM (SELECT H.item_nbr AS item, H.class AS class, H.family AS family, H.currentYear AS annoCurr, H.previousYear AS annoPrec, H.unitSalesCurrentYear AS unitaAnnoCurr, LAG(H.unitSalesCurrentYear) OVER (PARTITION BY H.item_nbr ORDER BY H.currentYear) unitSalesPreviousYear
        FROM (SELECT I.item_nbr, I.class, I.family, D.year AS currentYear, (D.year-1) AS previousYear, SUM(S.unit_sales) AS unitSalesCurrentYear
            FROM items I JOIN sales S on I.item_nbr=S.item_nbr JOIN Data D ON S.data=D.data
            GROUP BY I.item_nbr, D.year) AS H ) AS C
WHERE C.class=1072 AS C.unitaAnnoCurr<C.unitSalesPreviousYear;


SELECT C.item_nbr, C.class, C.currentYear, C.unitSalesCurrentYear, C.previousYear, C.unitSalesPreviousYear
FROM calcoloUnitaPerAnno AS C
WHERE C.class=1072 AS C.unitSalesCurrentYear<C.unitSalesPreviousYear;	


-- Calcolo unità vendute rispetto all’anno precedente (varia family)

SELECT C.item, C.class, C.annoCurr, C.unitaAnnoCurr, C.annoPrec, C.unitSalesPreviousYear
FROM (SELECT H.item_nbr AS item, H.class AS class, H.family AS family, H.currentYear AS annoCurr, H.previousYear AS annoPrec, H.unitSalesCurrentYear AS unitaAnnoCurr, LAG(H.unitSalesCurrentYear) OVER (PARTITION BY H.item_nbr ORDER BY H.currentYear) unitSalesPreviousYear
        FROM (SELECT I.item_nbr, I.class, I.family, D.year AS currentYear, (D.year-1) AS previousYear, SUM(S.unit_sales) AS unitSalesCurrentYear
            FROM items I JOIN sales S on I.item_nbr=S.item_nbr JOIN Data D ON S.data=D.data
            GROUP BY I.item_nbr, D.year) AS H ) AS C
WHERE C.family LIKE‘%DELI%’AS C.unitaAnnoCurr<C.unitSalesPreviousYear;


SELECT C.item_nbr, C.class, C.currentYear, C.unitSalesCurrentYear, C.previousYear, C.unitSalesPreviousYear
FROM calcoloUnitaPerAnno AS C
WHERE C.family LIKE‘%DELI%’AS C.unitSalesCurrentYear<C.unitSalesPreviousYear;
