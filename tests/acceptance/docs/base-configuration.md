# Base configuration:

Required Python version 3.11
   
## Vscode Configuration
   1. Import vscode Profile.
      Settings -> Profile -> Profiles -> New Profile (More Actions) -> Import Profile
      Get Profile from proyect -> [Profile.json](./utils/Projects.code-profile)

   2. Configure launch file .vscode/launch.json.
      Download the [launch.json](./utils/launch.json) file and place it in the `.vscode` directory.

## Decrypt project:
   https://confluence.tid.es/pages/viewpage.action?spaceKey=CTO&title=%5BLA-QA%5D+Tools

   Unlock repository:
      ```bash
         cd tests/acceptance/
         git-crypt unlock ~/carpeta/key.key
      ```

## Virtual env
   1. Create (Root project)
      ```bash
         python3.11 -m venv .venv
         source .venv/bin/activate
      ```
   2. Configure env in vscode: <br>
      Ctrl+P -> Python: Select Interpreter
      ![python iterpreter](documentation/Interpreter.png)

   3. Install requirements inside the venv
      ```bash
         cd tests/acceptance/
         pip install -r requirements.txt
      ```
## Create local-toolium.cfg
   Include local-toolium.cfg in tests/acceptance
   Download the [local-toolium.json](./utils/template-local-toolium.cfg) file and place it in the `tests/acceptance/settings` directory.
