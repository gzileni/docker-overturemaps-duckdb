# docker-overturemaps-duckdb

DuckDb docker image with all [Overture Maps](https://overturemaps.org) persistent data.
To create the [DuckDb](https://duckdb.org) Docker image you need to run the following command:

```bash
make build  
```

to execute stack try to run following command:

```bash
make stack 
```

**Disclaimer: Creating this stack needs a lot of resources and time**

the image can be integrated into its own stack and serves as a database to develop any client to extract geographic data.

There are many clients for DuckDb listed in the [official documentation](https://duckdb.org/docs/archive/0.8.1/api/overview).

For example you can use [.Net library](https://github.com/gzileni/DuckDB.NET) to connect database with following path:

```C#

using (var duckDBConnection = new DuckDBConnection("Data Source=./data/overturemaps.db"))
{
  duckDBConnection.Open();

  var command = duckDBConnection.CreateCommand();

  ....

```

## DuckDb docker image

You can simply launch the docker image with just DuckDb to run queries and tests:

```bash
make build-base
```

and run stack with:

```bash
make stack-base
```

For example, with Duckdb's base image we can run a simple query to filter the location categories from the Places dataset:

```sql

INSTALL spatial;
INSTALL httpfs;

LOAD spatial;
LOAD httpfs;

SET s3_region='us-west-2';

CREATE TABLE categories_places AS 

COPY (Select 
    JSON(categories) ->'$.main' as category,
    from read_parquet('s3://overturemaps-us-west-2/release/2023-07-26-alpha.0/theme=places/type=*/*', filename=true, hive_partitioning=1)
    WHERE category is not NULL
) TO TO 'categories.csv' (DELIMITER '|');
```

## Docker image for specific use

For example, we can search for all places of historical and archaeological interest.
Just run the command to filter all the locations with archaeological interest like this:

```bash
make build-archeo
```

and run with:

```bash
make stack-archeo
```

### List all categories [Here](./categories.csv)

### Examples BBox Query

Go to a site like [BoxFindex](http://bboxfinder.com/) and draw a polygon for your Area of Interest. This will show you the bbox at the bottom of the page. In my case I have selected an area around Pune to add sql script.

- **Italy**: "bbox.minx > 5.904195 AND bbox.maxx < 17.523707 AND bbox.miny > 37.332549 AND bbox.maxy < 47.610420;" (very slow!!)
- **Rome**: "bbox.minx > 12.337646 AND bbox.maxx < 12.626038 AND bbox.miny > 41.781553 AND bbox.maxy < 42.026854;"
- **Paris**: "bbox.minx > 2.423250 AND bbox.maxx < 2.244035 AND bbox.miny > 48.817247 AND bbox.maxy < 48.914812;"
- **London**: "bbox.minx > -0.502471 AND bbox.maxx < 0.299250 AND bbox.miny > 48.914812 AND bbox.maxy < 451.738680;"
