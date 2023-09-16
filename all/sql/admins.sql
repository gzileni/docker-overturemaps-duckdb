ATTACH DATABASE '/duckdb/data/overture.db';

INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;
SET s3_region='us-west-2';

CREATE TABLE admins AS SELECT
    type,
    version,
    CAST(updatetime as varchar) as updateTime,
    JSON(names) as names,
    JSON(sources) as sources,
    ST_GeomFromWKB(geometry) as geometry
FROM
    read_parquet('s3://overturemaps-us-west-2/release/2023-07-26-alpha.0/theme=admins/type=*/*', hive_partitioning=1)
WHERE
    adminLevel = 2 AND ST_GeometryType(ST_GeomFromWKB(geometry)) IN ('POLYGON','MULTIPOLYGON')
    AND bbox.minx > 5.904195 AND bbox.maxx < 17.523707 AND bbox.miny > 37.332549 AND bbox.maxy < 47.610420;