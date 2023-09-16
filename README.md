# docker-duckdb

DuckDb docker image with all Overture Maps persistent data.
To create the Docker image you need to run the following command:

```

docker build -t overturemaps-duckdb .  

```

to execute stack try to run following command:

```

docker-compose up 

```

the image can be integrated into its own stack and serves as a database to develop any client to extract geographic data.

There are many clients for DuckDb listed in the [official documentation](https://duckdb.org/docs/archive/0.8.1/api/overview).

For example you can use [.Net library](https://github.com/gzileni/DuckDB.NET) to connect database with following path:

```

using (var duckDBConnection = new DuckDBConnection("Data Source=./data/overturemaps.db"))
{
  duckDBConnection.Open();

  var command = duckDBConnection.CreateCommand();

  ....

```
