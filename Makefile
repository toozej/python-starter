# Set sane defaults for Make
SHELL = bash
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Set default goal such that `make` runs `make help`
.DEFAULT_GOAL := help

IMAGE_AUTHOR = toozej
IMAGE_NAME = python-starter
IMAGE_TAG = latest

.PHONY: all build test run local-run get-cosign-pub-key verify update-python-version pre-commit pre-commit-install pre-commit-run clean help

all: build run verify ## Run default workflow

build: ## Build Dockerized project
	docker build -f $(CURDIR)/Dockerfile -t $(IMAGE_AUTHOR)/$(IMAGE_NAME):$(IMAGE_TAG) .

test: ## Test Dockerized project
	docker build --target test -f $(CURDIR)/Dockerfile -t $(IMAGE_AUTHOR)/$(IMAGE_NAME):$(IMAGE_TAG) .

run: ## Run Dockerized project
	-docker kill $(IMAGE_NAME)
	docker run --rm --name $(IMAGE_NAME) $(IMAGE_AUTHOR)/$(IMAGE_NAME):$(IMAGE_TAG)

local-run: ## Run Python project locally
	python3 -m venv venv && source $(CURDIR)/venv/bin/activate && pip install -r $(CURDIR)/requirements.txt
	python3 $(CURDIR)/python_starter/__main__.py command --help

get-cosign-pub-key: ## Get golang-starter Cosign public key from GitHub
	test -f $(CURDIR)/python-starter.pub || curl --silent https://raw.githubusercontent.com/toozej/python-starter/main/python-starter.pub -O

verify: get-cosign-pub-key ## Verify Docker image with Cosign
	cosign verify --key $(CURDIR)/python-starter.pub $(IMAGE_AUTHOR)/$(IMAGE_NAME):$(IMAGE_TAG)

update-python-version: ## Update Python version
	@VERSION=`curl -s "https://endoflife.date/api/python.json" | jq -r '.[0].latest' | sed 's/\.[0-9]*$$//'`; \
	echo "Updating Python to $$VERSION"; \
	./scripts/update_python_version.sh $$VERSION

pre-commit: pre-commit-install pre-commit-run ## Install and run pre-commit hooks

pre-commit-install: ## Install pre-commit hooks and necessary binaries
	# install and update pre-commits
	pre-commit install
	pre-commit autoupdate

pre-commit-run: ## Run pre-commit hooks against all files
	pre-commit run --all-files

clean: ## Clean up built Docker images
	docker image rm $(IMAGE_AUTHOR)/$(IMAGE_NAME):$(IMAGE_TAG)

help: ## Display help text
	@grep -E '^[a-zA-Z_-]+ ?:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
