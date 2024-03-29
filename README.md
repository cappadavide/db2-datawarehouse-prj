# db2-datawarehouse-prj

## Description

The aim of this study project is to optimize the dataset published by Corporación Favorita, a grocery chain based in Ecuador. The aforementioned dataset has been released in the form of a CSV file for the purpose of a [competition](https://www.kaggle.com/c/favorita-grocery-sales-forecasting/), the goal of which is to predict the sales of hundreds of products across various points of sale within the corporation. It is structured as follows:
```md
.
├── dataset
    ├── train.csv
    ├── holidays_events.csv
    ├── items.csv
    ├── stores.csv
```
- The file `train.csv` contains information regarding the sales made.
- The file `holidays_events.csv` contains information about the holidays that have occurred.
- The file `items.csv` reports data related to each item.
- The file `stores.csv` contains information about the stores belonging to the corporation.

Not all files published by the company have been considered, as some were specifically useful for the aforementioned competition.
The objective pursued in this work is therefore to appropriately collect the operational and informational data present in the files provided by the Ecuadorian company into a ROLAP (Relational On-Line Analytical Processing) Data Warehouse. This is done in order to make them available for analytical purposes and to enable the execution of well-defined queries as quickly as possible despite the large amount of data.
## Tasks

The data loading has been requested to occur in blocks of six months. 

From the specifications, the following 8 slicings are outlined:

1. negozio (store), giorno settimanale (weekly day)(e.g., Monday), anno (year), famigliaprodotto (product family)
2. stato (State), giornosettimanale, anno, famigliaprodotto
3. negozio, settimana (ad es. decima settimana), anno, famigliaprodotto
4. stato, settimana (ad es 10 settimana),anno, famigliaprodotto
5. negozio, mese (month), anno, famigliaprodotto
6. stato, anno, famigliaprodotto
7. stato, festivolocale (local holiday), mese, anno, famigliaprodotto (regular holidays - Sundays - plus local holidays)
8. stato, mese, anno, famigliaprodotto

The comparison queries with the previous month/year are as follows:

1. Products with decreased sales compared to the previous month (month, year, class)
2. Products with decreased sales compared to the previous month (month, year, family)
3. Products with decreased sales compared to the previous year (month, year, class)
4. Products with decreased sales compared to the previous year (month, year, family)

In addition, the utilization of materialized views has been investigated to enhance the accessibility of information required by four specific queries. These queries focus on retrieving data related to units sold and any potential decline in comparison to previous months/years. Materialized views have been employed to streamline the retrieval process and facilitate the analysis of relevant information.
Finally, it has been requested to evaluate the performance and execution times of queries with and without index usage, as well as to assess storage space.

## Dimensional Fact Model

Based on the provided data, there exists a distinct model centred around sales, with key metrics being the units sold (`UnitàVendute`) and a value indicating whether the sold item is on promotion or not (`InPromozione`).
<p align="center">
  <img src="https://github.com/cappadavide/db2-datawarehouse-prj/assets/70511599/c3261c99-d424-4c78-a663-8a4eed88870e" alt="DFM"/>
</p>

### Hierarchies Overview

1. **Temporal Hierarchy:**
   - Detailed characteristics related to time, differentiated by granularity. This hierarchy includes day, week, and month, extracted from the date. The attribute `tipo` has a descriptive attribute called `descrizione`, indicating its description. Another enriching attribute, as seen in the following hierarchies, is `transferred`. A holiday is labelled as `transferred` if it officially falls on a specific calendar day but has been moved to another date by the government. A `transferred` day is more akin to a regular day than a holiday. `Local_name` and `local` indicate the holiday's name and type (`National`, `Local`, `Regional`), respectively.

2. **Product Hierarchy:**
   - Encompasses product-related details, including the perishable attribute indicating whether the product is perishable, the family, and the class (`class`) to which the product belongs.

3. **Store Hierarchy:**
   - Specifies details related to a store, including the city and state, the store's cluster, and the descriptive attribute type.

These three hierarchies provide a comprehensive view of the exclusive sales model, incorporating temporal, product-related, and store-specific dimensions.

## Data Loading Process Overview
As outlined in the requirements, data loading is mandated to occur on a semi-annual basis, totalling four semesters (two years). To achieve this, a separation process was implemented using the Python script `extractHalfYear.py`. This script takes input parameters such as the date to be segmented, the table, and the semester, generating the corresponding CSV file.
Subsequently, the data from the CSV files about each semester needs to be loaded into the system. The `COPY` command was employed within the `caricaSemestre.sql` procedure for this purpose. The following code snippet illustrates this:
```sql
EXECUTE 'COPY sales FROM ''C:\Users\Public\'' + salescsv + ' WITH (format csv, delimiter '','', FORCE_NULL (onpromotion))';
```
Similarly, the COPY command was utilized for the holiday_events table to populate it.
Furthermore, within the procedure, data is also inserted into the data table. This table, as elaborated in the third section of the document, gathers temporal information with varying granularity present in both the sales and holiday_events tables. The insertion process is depicted as follows:
```sql
INSERT INTO data (SELECT DISTINCT s.data AS Data, to_char(s.data, 'Day') AS Day, EXTRACT(WEEK FROM s.data) AS Week, EXTRACT(MONTH FROM s.data) AS Month, EXTRACT(YEAR FROM s.data) AS Year FROM sales AS s);
```
```sql
UNION (SELECT DISTINCT h.data AS Data, to_char(h.data, 'Day') AS Day, EXTRACT(WEEK FROM h.data) AS Week, EXTRACT(MONTH FROM h.data) AS Month, EXTRACT(YEAR FROM h.data) AS Year FROM holiday_events AS h) ORDER BY 1;
```
Since multiple holidays can correspond to a single date and a holiday can be celebrated on multiple dates, common dates from the holiday_events table are also inserted into data_holiday. The following code snippet outlines this procedure:
```sql
INSERT INTO data_holiday SELECT d.data, h.id FROM data d JOIN holiday_events h ON d.data = h.data;
```

## Index Evaluation

One of the indices utilized within the entire system is BRIN, an acronym for "Block Range INdex". This index has been applied to the `data` and `store_nbr` attributes of the `Sales` table. These attributes were selected because they simulate BITMAP indices. Considering that the attribute on which they are applied recurs in almost all queries and belongs to the `Sales` table, which, due to its high number of rows, contains many duplicates, the BRIN indices significantly improve the query performance involving this table.
Analysis of JOIN Operations

In all queries, it was chosen to designate the 'Sales' table as the inner table on which to apply the index. This decision was based on the fact that the `Sales` table is the most populated relation (with millions of records) and remains unaltered within the query.

Evaluating the parameter 
$$E_{reg}=N_{reg}(Sales)/N_{key}(Attribute)$$
it was observed that the value exceeds the threshold (approximately 200). This indicates that the ideal index type is that of bitmaps, simulated by the BRIN indices. An additional advantage was gained by enabling HASH join which is enabled by default in PostgreSQL.

### Authors
[Giuseppina Russo](https://github.com/giusyrux)

[cappadavide](https://github.com/cappadavide)

