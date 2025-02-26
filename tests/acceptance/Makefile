.ONESHELL:

docker-file = ../../docker-compose.yaml -f ../../docker-compose.qa.yaml
nexus-user = ${NEXUS_LA_USER}
nexus-password = ${NEXUS_LA_PASSWORD}
component = Generic

.EXPORT_ALL_VARIABLES:

.PHONY: help
help: ## Show this help
	@echo "usage: make [target] ..."
	@echo ""
	@echo "targets:"
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# CI commands
.PHONY: docker-clean
docker-clean:
	docker compose -f ${docker-file} down -v

.PHONY: docker-build ## Docker build
docker-build:
	docker compose -f ${docker-file} build --build-arg NEXUS_LA_USER=${nexus-user} --build-arg NEXUS_LA_PASSWORD=${nexus-password}

.PHONY: docker-run-tests ## Docker run tests
docker-run-tests:
	docker compose -f ${docker-file} run --rm docker-tests

.PHONY: selenoid
selenoid:
	docker compose -f ${docker-file} up selenoid

.PHONY: ruff-lint
ruff:
	ruff check --fix

.PHONY: get-regression-failed
regression-failed:
	@JIRA_VERSION=$$(grep -oP '(?<=^version: ).*' ./settings/local-toolium.cfg) && \
	laqacommons jira-queries -qt failed -v $${JIRA_VERSION} -c ${component} -p regression -b Release

.PHONY: get-regression-not-executed
regression-not-executed:
	@JIRA_VERSION=$$(grep -oP '(?<=^version: ).*' ./settings/local-toolium.cfg) && \
	laqacommons jira-queries -qt not_executed -v $${JIRA_VERSION} -c ${component} -p regression -b Release

.PHONY: get-smoke-failed
smoke-failed:
	@JIRA_VERSION=$$(grep -oP '(?<=^version: ).*' ./settings/local-toolium.cfg) && \
	laqacommons jira-queries -qt failed -v $${JIRA_VERSION} -c ${component} -p smoke -b Release

.PHONY: get-smoke-not-executed
smoke-not-executed:
	@JIRA_VERSION=$$(grep -oP '(?<=^version: ).*' ./settings/local-toolium.cfg) && \
	laqacommons jira-queries -qt not_executed -v $${JIRA_VERSION} -c ${component} -p smoke -b Release
