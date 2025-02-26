# Base configuration:

   1. Required Python version 3.11
   
   2. Import vscode Profile.
      Settings -> Profile -> Profiles -> New Profile (More Actions) -> Import Profile
      Get Profile from proyect -> [Profile.json](./utils/Projects.code-profile)

   3. Configure launch file .vscode/launch.json.
      Download the [launch.json](./utils/launch.json) file and place it in the `.vscode` directory.

   4. Decrypt project:
      https://confluence.tid.es/pages/viewpage.action?spaceKey=CTO&title=%5BLA-QA%5D+Tools

      Unlock repository:
         ```bash
            git-crypt unlock ~/carpeta/key.key
         ```

      Configure git-crypt in project: [Configure Git-Crypt](./configure-git-crypt.md#git-crypt)

   5. Virtual env (Root project)
      ```bash
         python3.11 -m venv .venv
         source .venv/bin/activate
      ```
      Configure env in vscode:
         Ctrl+P -> Python: Select Interpreter
         ![alt text](documentation/Interpreter.png)

   6. Install requirements inside the venv
      ```bash
         cd tests/acceptance/
         pip install -r requirements.txt
      ```
   7. Include local-toolium.cfg in tests/acceptance
      Download the [local-toolium.json](./utils/template-local-toolium.cfg) file and place it in the `tests/acceptance/settings/` directory.
      

# Reports

## Allure
   ### Install
   [Allure](https://docs.qameta.io/allure/#_installing_a_commandline)
   
   ### Configure in project
   ![Allure Toolium](./images/allure-toolium.png)