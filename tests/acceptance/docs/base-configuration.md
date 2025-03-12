# Base configuration:

Required Python version 3.11.11
   
## Vscode Configuration
### Import vscode Profile.
Settings -> Profile -> Profiles -> New Profile (More Actions) -> Import Profile
Get Profile from proyect -> [Profile.json](./utils/Projects.code-profile)

### Configure launch file .vscode/launch.json.
   Download the [launch.json](./utils/launch.json) file and place it in the `.vscode` directory.

## Decrypt project:
Download project key: [QA Keys](https://confluence.tid.es/pages/viewpage.action?spaceKey=CTO&title=%5BLA-QA%5D+Tools)

Unlock repository:
```bash
cd tests/acceptance/
git-crypt unlock ~/carpeta/key.key
```

## Configure Virtual env
### Create with Vscode:
Ctrl+P -> Python: Select Interpreter -> <br>
Create virtual environment -> Select Venv -> <br>
Expected Python version -> <br>
Select tests/acceptance/requirements.txt -> OK

### Create with Command (Root project):
```bash
python3.11 -m venv .venv
source .venv/bin/activate
cd tests/acceptance/
pip install -r requirements.txt
```
Ctrl+P -> Python: Select Interpreter


## Create local-toolium.cfg
Include local-toolium.cfg in tests/acceptance
Download the [local-toolium.json](./utils/template-local-toolium.cfg) file and place it in the `tests/acceptance/settings` directory.

## Download chromedriver
Check Chrome browser version and download the expected chromedriver <br>
[Chromedriver](https://googlechromelabs.github.io/chrome-for-testing/) <br>

Set chromediver path in local-toolium.cfg
```
[Driver]
type: chrome
chrome_driver_path: /usr/local/share/chromedriver
```

## [Project First Day](./project-first-day.md#project-first-day)

↩️ **[Go Back to QA Readme](../README.md)**