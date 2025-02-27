# Getting Started with QA Living Apps 2.0

## Index
1. [Base configuration](./docs/base-configuration.md#base-configuration)
2. [CIs configuration](./docs/cis-configuration.md#cis)
3. [Reports](./docs/base-configuration.md#reports)
4. [Project First Day](./docs/project-first-day.md#project-first-day)

## Run CIs tests

## Check Results in Jira
    https://jira.tid.es/browse/QALAGLOB-727741?jql=project%20%3D%20QALAGLOB%20ORDER%20BY%20created%20DESC

    Check Failed results. (Include in make file as make regression-failed)
    ´´´bash
    cd tests/acceptance
    laqacommons jira-queries -qt failed -v $${JIRA_VERSION} -c ${component} -p regression -b Release
    ´´´

    Check Not executed tests. (Include in make file as make regression-not-executed)
    ´´´bash
    cd tests/acceptance
    laqacommons jira-queries -qt not_executed -v $${JIRA_VERSION} -c ${component} -p regression -b Release
    ´´´

## Generate Release Report

http://qacdco.hi.inet/qacdco-reporter # VPN Required


## Run Local Tests