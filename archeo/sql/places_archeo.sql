ATTACH DATABASE '/duckdb/data/overture_archeo.db';

INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;
SET s3_region='us-west-2';

CREATE TABLE places_archeo AS 
SELECT
    id,
    updatetime,
    version,
    CAST(names AS JSON) AS names,
    JSON(CAST(categories AS JSON)) ->'$.main' AS category,
    confidence,
    CAST(sources AS JSON) AS sources,
    ST_GeomFromWKB(geometry)
FROM
    read_parquet('s3://overturemaps-us-west-2/release/2023-07-26-alpha.0/theme=places/type=*/*', hive_partitioning=1)
WHERE bbox.minx > 5.904195 
      AND bbox.maxx < 17.523707 
      AND bbox.miny > 37.332549 
      AND bbox.maxy < 47.610420
      AND category is not NULL
      AND (REPLACE(category, '"', '') LIKE '%historic%' 
           OR REPLACE(category, '"', '') LIKE '%history%'
           OR REPLACE(category, '"', '') LIKE '%cathedral%'); 
