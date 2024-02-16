CREATE OR REPLACE FUNCTION set_index (enable boolean) RETURNS VOID AS
$$
BEGIN
    IF(enable= true) THEN
        CREATE INDEX if not exists store_nbr_index on sales USING brin (store_nbr);
        CREATE INDEX if not exists data_index ON sales USING brin (data);
    ELSE
        DROP INDEX IF EXISTS store_nbr_index;
        DROP INDEX IF EXISTS data_index;
    END IF;
END;
$$
LANGUAGE plpgsql;
