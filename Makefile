.PHONY: setup test lint scan build

setup:
	@echo "Setting up development environment..."
	@pip install pre-commit
	@pre-commit install
	@cd app && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

test:
	@echo "Running tests..."
	@pytest app/

lint:
	@echo "Running linters..."
	@flake8 app --count --select=E9,F63,F7,F82 --show-source --statistics --exclude=.venv,__pycache__

scan:
	@echo "Running security scans..."
	@bash scripts/scan.sh

build:
	@echo "Building Docker image..."
	@docker build -t demo-app:local app/
