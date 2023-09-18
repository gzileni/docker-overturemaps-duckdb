build-base:
	@echo Building and tagging DUCKDB BASE
	docker build -t duckdb:latest -f base/Dockerfile .

build-archeo:
	@echo Building and tagging DUCKDB ARCHEOLOGIC
	docker build -t overturemaps-archeo:latest -f archeo/Dockerfile .

build:
	@echo Building and tagging DUCKDB ALL DATA
	docker build -t overturemaps:latest -f all/Dockerfile .

stack-base: 
	docker-compose -f ./docker-compose.yml --profile base up -d --remove-orphans

stack-base: 
	docker-compose -f ./docker-compose.yml --profile archeo up -d --remove-orphans

stack: 
	docker-compose -f ./docker-compose.yml --profile all up -d --remove-orphans
