--Enumerations
CREATE TYPE enum_type_negozio AS ENUM('A','B','C','D','E');
CREATE TYPE enum_type AS ENUM ('Holiday', 'Bridge', 'Additional', 'Transfer', 'Event', 'Work Day');
CREATE TYPE enum_loc AS ENUM ('Local', 'Regional', 'National');


--Tables

CREATE TABLE sales(id integer PRIMARY KEY, data date not null, store_nbr integer not null, item_nbr integer not null, unit_sales float not null, onpromotion boolean null);
CREATE TABLE holiday_events(id smallserial primary key, data date not null, type enum_type not null, locale enum_loc not null, locale_name varchar(100) not null, description varchar(200) not null, transferred boolean not null);
CREATE TABLE data(data date primary key, day varchar(10) not null, week integer not null, month integer not null, year integer not null);
CREATE TABLE items(item_nbr integer PRIMARY KEY, family varchar(200) not null, class integer not null, perishable boolean not null);
CREATE TABLE stores(store_nbr integer PRIMARY KEY, city varchar(20) not null, state varchar(200) not null, type enum_type_negozio not null, cluster integer not null);
CREATE TABLE data_holiday(data_fk date, holiday_fk integer);


--Foreign Key Constraints

ALTER TABLE SALES ADD CONSTRAINT FK1 FOREIGN KEY (STORE_NBR) REFERENCES STORES(STORE_NBR);
ALTER TABLE SALES ADD CONSTRAINT FK2 FOREIGN KEY (ITEM_NBR) REFERENCES ITEMS(ITEM_NBR);
ALTER TABLE SALES ADD CONSTRAINT FK5 FOREIGN KEY (DATA) REFERENCES DATA(DATA);
ALTER TABLE DATA_HOLIDAY ADD CONSTRAINT FK3 FOREIGN KEY (HOLIDAY_FK) REFERENCES HOLIDAY_EVENTS(ID);
ALTER TABLE DATA_HOLIDAY ADD CONSTRAINT FK4 FOREIGN KEY (DATA_FK) REFERENCES DATA(DATA);
