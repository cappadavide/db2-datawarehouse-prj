CREATE OR REPLACE FUNCTION caricaSemestre (varchar(200) sales_csv, varchar(200) holiday_csv) RETURNS VOID AS
$$
BEGIN

PERFORM set_index(false);

RAISE NOTICE 'Inizio copy SALES';

EXECUTE 'COPY sales FROM ''C:\Users\Public\'' || salescsv || 'with (format csv , delimiter '','' , FORCE_NULL (onpromotion))';

RAISE NOTICE 'Fine COPY';

RAISE NOTICE 'Inizio copy HOLIDAY';

EXECUTE 'COPY holiday_events(data,type,locale,locale_name,description,transferred) FROM ''C:\Users\Public\'' || holiday_csv || 'with (format csv , delimiter '','')';
RAISE NOTICE 'Fine COPY';

RAISE NOTICE 'Inizio INSERT data';
	
INSERT INTO data
	(SELECT DISTINCT s.data AS Data,to_char(s.data, 'Day') AS Day,EXTRACT(WEEK FROM s.data) AS Week,EXTRACT(MONTH FROM s.data) AS Month,EXTRACT(YEAR FROM s.data) AS Year
FROM sales AS s)
UNION
	(SELECT DISTINCT h.data AS Data,to_char(h.data, 'Day') AS Day ,EXTRACT(WEEK FROM h.data) AS Week,EXTRACT(MONTH FROM h.data) AS Month,EXTRACT(YEAR FROM h.data) AS Year
FROM holiday_events AS h)
ORDER BY 1;
RAISE NOTICE 'Fine INSERT data';

RAISE NOTICE 'Inizio INSERT data_holiday';

INSERT INTO data_holiday
SELECT d.data,h.id
FROM data d JOIN holiday_events h on d.data=h.data;

RAISE NOTICE 'Fine INSERT data_holiday';

END;
$$
LANGUAGE plpgsql;
