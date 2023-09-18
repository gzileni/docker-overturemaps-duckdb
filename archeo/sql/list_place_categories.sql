INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;
SET s3_region='us-west-2';

CREATE TABLE categories_places AS 

COPY (SELECT DISTINCT
    JSON(CAST(categories AS JSON)) ->'$.main' AS category,
    from read_parquet('s3://overturemaps-us-west-2/release/2023-07-26-alpha.0/theme=places/type=*/*', filename=true, hive_partitioning=1)
    WHERE category is not NULL
) TO 'categories.csv' (DELIMITER '|');