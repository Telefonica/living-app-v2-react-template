# CIs
## Configure Workflows
### Required Secrets 
   (Only repo admin could access to this section) https://github.com/Telefonica/{repository-name}/settings/secrets/actions
- `GIT_CRYPT_KEY`: Ask la qa team for credentials
- `HARBOR_QACDCO_PASSWORD`: Ask la qa team for credentials
- `HARBOR_LA_PASSWORD`: Ask la qa team for credentials
- `NEXUS_LA_PASSWORD`: Ask la qa team for credentials

### Required repository variables
   (Only repo admin could access to this section) https://github.com/Telefonica/{repository-name}/settings/variables/actions
- `HARBOR_LA_USER`: robot$la-qa+default
- `HARBOR_QACDCO_USER`: robot$qacdo-hub+la
- `HARBOR_URL`: harbor.tid.es
- `NEXUS_LA_USER`: bot-la-reader
- `PROJECT`: Poject label. Example: LA-GENERIC
- `QA_RUNNER`: Runner. Example: cdorunner-la-qa-platform
