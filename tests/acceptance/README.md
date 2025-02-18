# Base configuration:

   1. Required Python version 3.11
   
   2. Import vscode Profile.
      Settings -> Profile -> Profiles -> New Profile (More Actions) -> Import Profile
      Get Profile from proyect -> Projects.code-profile

   3. Configure launch file .vscode/launch.json.
      ```json
      {
         "version": "0.2.0",
         "configurations": [
            {
               "name": "Feature only tag",
               "type": "debugpy",
               "request": "launch",
               "cwd": "${workspaceFolder}/tests/acceptance",
               "module": "behave",
               "env": {
                  "PYTHONPATH": "${workspaceFolder}/tests/acceptance"
               },
               "args": [
                  "${file}",
                  "-t",
                  "${selectedText},@jira.${selectedText},@${selectedText}",
                  "-t",
                  "~@skip",
                  "-t",
                  "~@future",
                  "-s"
               ],
               "stopOnEntry": false,
               "justMyCode": false
            },
            {
            "name": "Features folder",
            "type": "debugpy",
            "request": "launch",
            "cwd": "${workspaceFolder}/tests/acceptance",
            "module": "behave",
            "env": {
                "PYTHONPATH": "${workspaceFolder}/tests/acceptance"
            },
            "args": [
                "${workspaceFolder}/tests/acceptance/",
                "-t",
                "~@future",
                "-t",
                "~@manual",
                "-t",
                "~@skip",
                "-s"
            ],
            "stopOnEntry": false,
            "justMyCode": false
            }
         ]
      }
      ```
   4. Get git crypt key:
      https://confluence.tid.es/pages/viewpage.action?spaceKey=CTO&title=%5BLA-QA%5D+Tools

   5. Gitcrypt:

      Unlock repository:
      ```bash
      git-crypt unlock ~/carpeta/key
      ```
      First time:
      1. lock the repository:
      ```bash
         sudo apt install git-crypt
         git-crypt init
      ```
      2. Add ".gitattributes" to the project root
      3. Export the key:
      ```bash
         git-crypt export-key ~/carpeta/key
      ```
      4. Get base64 project key, and add it to github.
      ```bash
      git-crypt export-key ./tmp-key && cat ./tmp-key | base64 | xclip && rm ./tmp-key
      cat ./project-key.key | base64
      ```
   6. Create Virtual env
      ```bash
      python3.11 -m venv .venv
      ```
   7. Install requirements inside the venv
      ```bash
      cd tests/acceptance/
      pip install -r requirements.txt
      ```
   8. Include local-toolium.cfg in tests/acceptance
      ```
         [Jira]
         enabled: true
         # reportAfter: scenario
         token: 

         [Driver]
         type: chrome
         chrome_driver_path: /usr/local/share/chromedriver
         headless: true

         [ChromeArguments]
         # mute-audio: false

         [TestExecution]
         environment: es-dev
         language: es-es
         auto_retry: true
         mock_mode: local
         env_file_path: .env.local
         user_test: user_ci_0
         la_version: 3.25.0-yanguas
         # pr_number: 468
         # demo_url: https://globalmakermedia.blob.core.windows.net/web-pocs/PRs/la-generic-470/build/index.html

         [Server]
         enabled: true
         host: localhost
         port: 4444

         [VisualTests]
         save: false

         [JiraExecution]
         version: v3.25_Yanguas
         Build: Release
         labels: LA-GENERIC,ft,regression,final

         [BrowserMobProxy]
         enabled: false
      ```

# CIs
## Required Secrets 

- `GIT_CRYPT_KEY`: Ask la qa team for credentials
- `HARBOR_QACDCO_PASSWORD`: Ask la qa team for credentials
- `HARBOR_LA_PASSWORD`: Ask la qa team for credentials
- `NEXUS_LA_PASSWORD`: Ask la qa team for credentials

## Required repository variables

- `HARBOR_LA_USER`: robot$la-qa+default
- `HARBOR_QACDCO_USER`: robot$qacdo-hub+la
- `HARBOR_URL`: harbor.tid.es
- `NEXUS_LA_USER`: bot-la-reader
- `PROJECT`: Poject label. Example: LA-GENERIC
- `QA_RUNNER`: Runner. Example: cdorunner-la-qa-platform

# Reports

   # [Allure](https://docs.qameta.io/allure/#_installing_a_commandline)