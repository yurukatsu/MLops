.PHONY: help up down restart logs ps build clean
.PHONY: mlflow-up mlflow-down mlflow-restart mlflow-logs mlflow-ps mlflow-build mlflow-clean mlflow-shell
.PHONY: prefect-up prefect-down prefect-restart prefect-logs prefect-ps prefect-build prefect-clean prefect-shell

# Default target
help:
	@echo "Available commands:"
	@echo "  make up              - Start all services"
	@echo "  make down            - Stop all services"
	@echo "  make restart         - Restart all services"
	@echo "  make logs            - Show logs for all services"
	@echo "  make ps              - Show status of all services"
	@echo "  make build           - Build all Docker images"
	@echo "  make clean           - Remove all containers and volumes"
	@echo ""
	@echo "Service-specific commands:"
	@echo "  make mlflow-up       - Start MLflow service"
	@echo "  make mlflow-down     - Stop MLflow service"
	@echo "  make mlflow-logs     - Show MLflow logs"
	@echo "  make mlflow-shell    - Access MLflow container"
	@echo "  make prefect-up      - Start Prefect service"
	@echo "  make prefect-down    - Stop Prefect service"
	@echo "  make prefect-logs    - Show Prefect logs"
	@echo "  make prefect-shell   - Access Prefect container"

# All services commands
up: mlflow-up prefect-up
	@echo "All services started"

down: mlflow-down prefect-down
	@echo "All services stopped"

restart: down up

logs:
	@make mlflow-logs
	@make prefect-logs

ps: mlflow-ps prefect-ps

build: mlflow-build prefect-build

clean: mlflow-clean prefect-clean

# MLflow specific commands
mlflow-up:
	@echo "Starting MLflow service..."
	@cd mlflow && docker compose up -d

mlflow-down:
	@echo "Stopping MLflow service..."
	@cd mlflow && docker compose down

mlflow-restart: mlflow-down mlflow-up

mlflow-logs:
	@cd mlflow && docker compose logs -f

mlflow-ps:
	@cd mlflow && docker compose ps

mlflow-build:
	@echo "Building MLflow Docker image..."
	@cd mlflow && docker compose build

mlflow-clean:
	@echo "Removing MLflow containers and volumes..."
	@cd mlflow && docker compose down -v

mlflow-shell:
	@cd mlflow && docker compose exec mlflow bash

# Prefect specific commands
prefect-up:
	@echo "Starting Prefect service..."
	@cd prefect && docker compose up -d

prefect-down:
	@echo "Stopping Prefect service..."
	@cd prefect && docker compose down

prefect-restart: prefect-down prefect-up

prefect-logs:
	@cd prefect && docker compose logs -f

prefect-ps:
	@cd prefect && docker compose ps

prefect-build:
	@echo "Building Prefect Docker image..."
	@cd prefect && docker compose build

prefect-clean:
	@echo "Removing Prefect containers and volumes..."
	@cd prefect && docker compose down -v

prefect-shell:
	@cd prefect && docker compose exec prefect bash
