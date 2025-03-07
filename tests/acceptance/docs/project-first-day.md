# Project First Day:

This is only required when is first project day, if is YOUR first day in project only check Base configuration.

## Configure Git-Crypt

   1. [Crypt Project](./configure-git-crypt.md#git-crypt)
   2. Upload created key to [QA Keys](https://confluence.tid.es/pages/viewpage.action?spaceKey=CTO&title=%5BLA-QA%5D+Tools)<br>
   3. Base64 project key, Must be included in GH Actions secrets (Admin credentials required)

## Set Enviroments credentials: (Ask QA Team)
   ![private settings](images/private-settings.png)

## Create .env.local and set expected credentials (Ask QA Team)
   Export creadentials:
   ```bash
      export $(cat .env.local | xargs)
   ```

## Update `laqacommons` 
[QA Commons](https://github.com/Telefonica/living-apps-qa-common)

## Update in settings/toolium.cfg the following values:
   ```
   [Jira]
   token: {QAUser token}

   [TestExecution]
   matricula: ID0XXXX

   [Capabilities]
   browserVersion: 128.0
   ```
   ![selenoid__options](images/selenoid__options.png)

## Configure Project lines:
   Create project lines: [Create lines](./create-lines.md#create-lines)

   Included to users.json ->
   https://github.com/Telefonica/baikal-global-mocks/blob/master/api/provision/tenants/globalint/users.json

   Include Project lines in: [SDF Mock File](../settings/common-sdf-mock.json)

## Include base settings in .qa folder
   1. Reserve lines:<br>
      ![reserve lines](images/reserve-lines.png)
   2. Upload Feature:<br>
      Search in Jira "project = QALAGLOB and issuetype = 'Test Plan' and labels not in (uat)"
      ![tests plans](images/test-plan.png)
      ![upload features](images/upload-features.png)
      1: Test Plan Number.
      2: Project Component.

## Update Living App data in settings: 
   [Settings](../settings/common-living-apps.json)
   [Environment](../common/environment.py)
   Replace todo-app with la name in both files
