ATTACH DATABASE '/duckdb/data/overture.db';

INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;
SET s3_region='us-west-2';

CREATE TABLE places AS SELECT
    id,
    updatetime,
    version,
    CAST(names AS JSON) AS names,
    CAST(categories AS JSON) AS categories,
    confidence,
    CAST(websites AS JSON) AS websites,
    CAST(socials AS JSON) AS socials,
    CAST(emails AS JSON) AS emails,
    CAST(phones AS JSON) AS phones,
    CAST(brand AS JSON) AS brand,
    CAST(addresses AS JSON) AS addresses,
    CAST(sources AS JSON) AS sources,
    ST_GeomFromWKB(geometry)
FROM
    read_parquet('s3://overturemaps-us-west-2/release/2023-07-26-alpha.0/theme=places/type=*/*', hive_partitioning=1)
WHERE
        bbox.minx > 4.34
        AND bbox.maxx < 21.94
        AND bbox.miny > 35.96
        AND bbox.maxy < 48.02;
