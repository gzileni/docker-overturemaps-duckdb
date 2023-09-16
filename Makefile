build-base:
	@echo Building and tagging DUCKDB BASE
	docker build -t duckdb:latest -f base/Dockerfile .

build:
	@echo Building and tagging DUCKDB BASE + ALL DATA
	docker build -t overturemaps:latest -f all/Dockerfile .

stack-base: 
	docker-compose -f ./docker-compose.yml --profile base up -d --remove-orphans

stack: 
	docker-compose -f ./docker-compose.yml --profile all up -d --remove-orphans
