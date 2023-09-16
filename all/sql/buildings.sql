ATTACH DATABASE '/duckdb/data/overture.db';
INSTALL spatial;
INSTALL httpfs;
LOAD spatial;
LOAD httpfs;
SET s3_region='us-west-2';


CREATE TABLE buildins AS SELECT
        type,
        version,
        CAST(updatetime as varchar) as updateTime,
        height,
        numfloors as numFloors,
        level,
        class,
        JSON(names) as names,
        JSON(sources) as sources,
        ST_GeomFromWKB(geometry) as geometry
    FROM
        read_parquet('s3://overturemaps-us-west-2/release/2023-07-26-alpha.0/theme=buildings/type=*/*', hive_partitioning=1)
    WHERE
        bbox.minx > 4.34
        AND bbox.maxx < 21.94
        AND bbox.miny > 35.96
        AND bbox.maxy < 48.02;
