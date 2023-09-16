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
WHERE bbox.minx > 5.904195 AND bbox.maxx < 17.523707 AND bbox.miny > 37.332549 AND bbox.maxy < 47.610420;
