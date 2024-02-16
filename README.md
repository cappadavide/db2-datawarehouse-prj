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

1. Store, weekly day (e.g., Monday), year, product family
2. State, weekly day, year, product family
3. Store, week (e.g., 10th week), year, product family
4. State, week (e.g., 10th week), year, product family
5. Store, month, year, product family
6. State, year, product family
7. State, local holiday, month, year, product family (regular holidays - Sundays - plus local holidays)
8. State, month, year, product family

The comparison queries with the previous month/year are as follows:

1. Products with decreased sales compared to the previous month (month, year, class)
2. Products with decreased sales compared to the previous month (month, year, family)
3. Products with decreased sales compared to the previous year (month, year, class)
4. Products with decreased sales compared to the previous year (month, year, family)

Finally, it has been requested to evaluate the performance and execution times of queries with and without index usage, as well as to assess storage space.
