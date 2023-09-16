FROM amd64/ubuntu:23.10

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    ca-certificates \
    bash \
    curl \
    wget \
    procps \
    apt-utils \
    apt-transport-https \
    bzip2 \
    cron \
    jq \
    gnupg \
    unzip \
    libnss-wrapper && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# DUCKDB
WORKDIR /duckdb
RUN mkdir sql
RUN mkdir data
RUN wget https://github.com/duckdb/duckdb/releases/download/v0.8.1/duckdb_cli-linux-amd64.zip
RUN unzip duckdb_cli-linux-amd64.zip
COPY all/sql/*.sql ./sql

# import data from sql
RUN /duckdb/duckdb < ./sql/admins.sql
RUN /duckdb/duckdb < ./sql/buildings.sql
RUN /duckdb/duckdb < ./sql/places.sql

