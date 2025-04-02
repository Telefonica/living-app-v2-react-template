.ONESHELL:

# Variables
DOCKER_FILE    = ../../docker-compose.qa.yaml
FEATURES       = ./tests/acceptance/features
GHERKIN_LINTRC = ./tests/acceptance/.gherkin-lintrc
REPORT_XML     = ./_output/reports

MAKE_JIRA_COMPONENT  = #TODO
MAKE_JIRA_TOKEN     ?= $(MAKE_JIRA_TOKEN)
TOOLIUM_CONFIG := $(shell test -f "./settings/local-toolium.cfg" && echo "./settings/local-toolium.cfg" || echo "./settings/toolium.cfg")
MAKE_JIRA_VERSION   := $(shell grep '^version:' "$(TOOLIUM_CONFIG)" | cut -d ' ' -f 2)
MAKE_JIRA_BUILD     := $(shell grep '^Build:' "$(TOOLIUM_CONFIG)" | cut -d ' ' -f 2)
MAKE_JIRA_LANGUAGE  := $(shell grep '^Language:' "$(TOOLIUM_CONFIG)" | cut -d ' ' -f 2)
LINE           := $(shell grep '^user_test:' "$(TOOLIUM_CONFIG)" | cut -d ' ' -f 2)

# Help
.PHONY: help
help:
	@echo "Usage: make [target] ..."
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Docker
.PHONY: docker-clean docker-build docker-run-tests selenoid

docker-clean: ## Clean up Docker environment
	@docker compose -f "$(DOCKER_FILE)" down -v

docker-build: ## Build QA services in Docker
	@docker compose -f "$(DOCKER_FILE)" build \
		--build-arg NEXUS_LA_USER="$(NEXUS_LA_USER)" \
		--build-arg NEXUS_LA_PASSWORD="$(NEXUS_LA_PASSWORD)"

docker-run-tests: docker-build ## Run QA tests in Docker
	@docker compose -f "$(DOCKER_FILE)" run --rm \
		-e USER_TEST="$(USER_TEST)" acceptance-tests

# Local
.PHONY: local-env install-requirements

local-env: ## Start Selenoid service and mock server
	@docker compose -f "$(DOCKER_FILE)" up selenoid mock-server

install-requirements: env-vars-export ## Install requirements
	@pip install -r requirements.txt

env-vars-export: ## Export environment variables
	@export $(cat .env.local | xargs)

# Linter
.PHONY: lint ruff gherkin-lint npm-install-required

ruff: ## Run Ruff linter
	@ruff check --fix

gherkin-lint: npm-install-required ## Run Gherkin linter
	@cd ../../ && node ./node_modules/.bin/gherkin-lint -c "$(GHERKIN_LINTRC)" "$(FEATURES)"

npm-install-required:
	@cd ../../ && npm install && npm install gherkin-lint --save-dev

# Jira Queries
.PHONY: jira-query upload-jira-xml

jira-queries: ## Run Jira queries (usage: make jira-query status=[passed|failed|bugs|custom|impeded|not_executed] priority=[regression|smoke|sanity])
	@test -n "$(status)" || { echo "Error: status is required (passed|failed|bugs|custom|impeded|not_executed)"; exit 1; }
	@test -n "$(priority)" || { echo "Error: priority is required (regression|smoke|sanity)"; exit 1; }
	@laqacommons jira-queries -t "$(MAKE_JIRA_TOKEN)" -qt "$(status)" -v "$(MAKE_JIRA_VERSION)" -c "$(MAKE_JIRA_COMPONENT)" -p "$(priority)" -b "$(MAKE_JIRA_BUILD)" -sp "$(MAKE_JIRA_EXTRA_PARAM)"

upload-jira-xml: ## Upload Jira results from XML files
	@find $(REPORT_XML) -name '*.xml' -exec toolium jira-report-xml -x {} \;

# Lines
.PHONY: reserve-line release-line
reserve-line:
	@laqacommons management --reserve --line "${LINE}"

release-line:
	@laqacommons management --release --line "${LINE}"