.ONESHELL:

# Variables
MAKE_FEATURES       = ./tests/acceptance/features
MAKE_GHERKIN_LINTRC = ./tests/acceptance/.gherkin-lintrc
MAKE_REPORT_XML     = _output/reports
MAKE_RUN_TESTS_PATH = ./scripts/run_tests.sh

# JIRA
MAKE_JIRA_COMPONENT  = <your-jira-component-of-the-project>  # Replace with your actual Jira component of the project
MAKE_TOOLIUM_CONFIG := $(shell test -f "./settings/local-toolium.cfg" && echo "./settings/local-toolium.cfg" || echo "./settings/toolium.cfg")
MAKE_JIRA_VERSION   := $(shell grep '^version:' "$(MAKE_TOOLIUM_CONFIG)" | cut -d ' ' -f 2)
MAKE_JIRA_BUILD     := $(shell grep '^Build:' "$(MAKE_TOOLIUM_CONFIG)" | cut -d ' ' -f 2)
MAKE_JIRA_LANGUAGE  := $(shell grep '^Language:' "$(MAKE_TOOLIUM_CONFIG)" | cut -d ' ' -f 2)

# DOCKER
COMPOSE_BAKE               = false
MAKE_DOCKER_FILE           = ../../docker-compose.qa.yaml
MAKE_DOCKER_ALL_SERVICE    = app selenoid mock-server mock-server-new la-qa-py-env
MAKE_DOCKER_PYTHON_SERVICE = la-qa-py-env
MAKE_DOCKER_SERVICES      ?= $(MAKE_DOCKER_ALL_SERVICE)

# LAQACOMMONS
MAKE_LAQACOMMONS     = laqacommons
MAKE_COMMAND_JLOB    = $(MAKE_LAQACOMMONS) list-jira-bugs
MAKE_JLOB_STATUS     = "\'Closed\',\'Resolved\'"
MAKE_ERROR_FILE_JLOB = errors_list_jira_bugs.txt

MAKE_COMMAND_JRDI    = $(MAKE_LAQACOMMONS) review-duplicated-ids
MAKE_ERROR_FILE_JRDI = errors_review_duplicated_ids.txt

# Help
.PHONY: help
help:
	@echo "Usage: make [target] ..."
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Docker
.PHONY: docker-clean docker-build docker-up docker-run-tests

docker-clean: ## Clean up Docker environment
	@docker compose -f "$(MAKE_DOCKER_FILE)" down -v --remove-orphans

docker-build: ## Build QA services in Docker
	@docker compose -f "$(MAKE_DOCKER_FILE)" build \
		--build-arg NEXUS_LA_USER="$(NEXUS_LA_USER)" \
		--build-arg NEXUS_LA_PASSWORD="$(NEXUS_LA_PASSWORD)"

docker-up: ## Up Docker services (use MAKE_DOCKER_SERVICES="..." to customize)
	@docker compose -f "$(MAKE_DOCKER_FILE)" up -d --build $(MAKE_DOCKER_SERVICES)

docker-run-tests:  ## Run QA tests in Docker
	@docker compose -f "$(MAKE_DOCKER_FILE)" exec -e USER_TEST="$(USER_TEST)" $(MAKE_DOCKER_PYTHON_SERVICE) bash -c '$(MAKE_RUN_TESTS_PATH)'

# Linter
.PHONY: lint ruff gherkin-lint npm-install-required

ruff: ## Run Ruff linter
	@ruff check --fix

gherkin-lint: npm-install-required ## Run Gherkin linter
	@cd ../../ && node ./node_modules/.bin/gherkin-lint -c "$(MAKE_GHERKIN_LINTRC)" "$(MAKE_FEATURES)"

npm-install-required:
	@cd ../../ && npm install && npm install gherkin-lint --save-dev

# Jira 
.PHONY: jira-queries jira-executions jira-list-of-bugs review-duplicated-ids upload-jira-xml

jira-queries: ## Run Jira queries (usage: make jira-queries status=[passed|failed|bugs|custom|impeded|not_executed] priority=[regression|smoke|sanity])
	@test -n "$(status)" || { echo "Error: status is required (passed|failed|bugs|custom|impeded|not_executed)"; exit 1; }
	@test -n "$(priority)" || { echo "Error: priority is required (regression|smoke|sanity)"; exit 1; }
	@laqacommons jira-queries -t "$(JIRA_TOKEN)" -qt "$(status)" -v "$(MAKE_JIRA_VERSION)" -c "$(MAKE_JIRA_COMPONENT)" -p "$(priority)" -b "$(MAKE_JIRA_BUILD)" -sp "$(JIRA_EXTRA_PARAM)"

jira-executions: ## Get Jira executions (usage: make jira-executions jira_query="your_jql_query", docker=[true|false])
	@test -n "$(jira_query)" || { echo "Error: jira_query is required"; exit 1; }
	@test -n "$(docker)" || { echo "Error: docker is required (true|false)"; exit 1; }
	$(MAKE) comments_log title_comment="Get Jira executions" command="laqacommons jira-executions -qt custom -f html -q '$(jira_query)'"
	@if [ "$(docker)" = "true" ]; then \
		docker compose -f "$(MAKE_DOCKER_FILE)" exec \
			-e JIRA_QUERY="$(jira_query)" \
			-e JIRA_TOKEN="$(JIRA_TOKEN)" \
			$(MAKE_DOCKER_PYTHON_SERVICE) bash -c \
			'laqacommons jira-executions -qt custom -f html -t "$$JIRA_TOKEN" -q "$$JIRA_QUERY"'; \
    else \
        laqacommons jira-executions -qt custom -f html -t "$(JIRA_TOKEN)" -q "$(jira_query)"; \
    fi

jira-list-of-bugs: ## List Jira bugs in features (usage: make jira-list-of-bugs features_folder="path/to/features" docker=[true|false])
	@test -n "$(features_folder)" || { echo "Error: features_folder is required"; exit 1; }
	@test -n "$(docker)" || { echo "Error: docker is required (true|false)"; exit 1; }
	@$(MAKE) comments_log title_comment="Get list of bugs with the expected status" command="$(MAKE_COMMAND_JLOB) -f $(features_folder) -s $(MAKE_JLOB_STATUS)"
	@if [ "$(docker)" = "true" ]; then \
		docker compose -f "$(MAKE_DOCKER_FILE)" exec \
			-e FEATURES_FOLDER="$(features_folder)" \
			-e JIRA_STATUS="$(MAKE_JLOB_STATUS)" \
			-e JIRA_TOKEN="$(JIRA_TOKEN)" \
			$(MAKE_DOCKER_PYTHON_SERVICE) bash -c '\
				$(MAKE_COMMAND_JLOB) -f "$$FEATURES_FOLDER" -s "$$JIRA_STATUS" 2> /app/$(MAKE_ERROR_FILE_JLOB); \
				if [ -s /app/$(MAKE_ERROR_FILE_JLOB) ]; then \
					cat /app/$(MAKE_ERROR_FILE_JLOB); \
					exit 1; \
				fi'; \
	else \
		$(MAKE_COMMAND_JLOB) -f "$(features_folder)" -s "$(MAKE_JLOB_STATUS)" 2> ./$(MAKE_ERROR_FILE_JLOB); \
		if [ -s ./$(MAKE_ERROR_FILE_JLOB) ]; then \
			cat ./$(MAKE_ERROR_FILE_JLOB); \
			exit 1; \
		fi; \
	fi

review-duplicated-ids: ## Review duplicated IDs in features (usage: make $@ features_folder="path/to/features" docker=[true|false])
	@test -n "$(features_folder)" || { echo "Error: features_folder is required"; exit 1; }
	@test -n "$(docker)" || { echo "Error: docker is required (true|false)"; exit 1; }
	@$(MAKE) comments_log title_comment="Review duplicated IDs in features" command="$(MAKE_COMMAND_JRDI) -f $(features_folder)"
	@if [ "$(docker)" = "true" ]; then \
		docker compose -f "$(MAKE_DOCKER_FILE)" exec \
			-e FEATURES_FOLDER="$(features_folder)" \
			$(MAKE_DOCKER_PYTHON_SERVICE) bash -c '\
				$(MAKE_COMMAND_JRDI) -f "$$FEATURES_FOLDER" 2> /app/$(MAKE_ERROR_FILE_JRDI); \
				if [ -s /app/$(MAKE_ERROR_FILE_JRDI) ]; then \
					cat /app/$(MAKE_ERROR_FILE_JRDI); \
					exit 1; \
				fi'; \
	else \
		$(MAKE_COMMAND_JRDI) -f "$(features_folder)" 2> ./$(MAKE_ERROR_FILE_JRDI); \
		if [ -s ./$(MAKE_ERROR_FILE_JRDI) ]; then \
			cat ./$(MAKE_ERROR_FILE_JRDI); \
			exit 1; \
		fi; \
	fi

upload-jira-xml: ## Upload Jira results from XML files
	@find "$(MAKE_REPORT_XML)" -name '*.xml' -exec toolium jira-report-xml -x {} \;

# Logs
PHONY: comments_log

comments_log: ## Add comments in the execution log
	@test -n "$(title_comment)" || { echo "Error: title_comment is required"; exit 1; }
	@test -n "$(command)" || { echo "Error: command is required"; exit 1; }
	@echo "****************************************************************************"
	@echo "                      $(title_comment)                                      "
	@echo "  $(command)                                                                "
	@echo "****************************************************************************"
