#!/bin/bash

OMDownloader omaps --theme places --ptype place --bbox /duckdb/italy/bbox.geojson --output /duckdb/italy/parquet/places.parquet
ogr2ogr /duckdb/italy/gdb/places.gdb /duckdb/italy/parquet/places.parquet
ogr2ogr /duckdb/italy/gpkg/places.gpkg /duckdb/italy/gdb/places.gdb
jupyter notebook --notebook-dir=/duckdb/italy --NotebookApp.token='' --allow-root 