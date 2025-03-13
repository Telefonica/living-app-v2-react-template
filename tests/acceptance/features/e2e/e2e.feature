@e2e @baseline+
Feature: [E2E] PAGE NAME: Feature description

    Actions Before the feature:
    Given the user "[TOOLIUM:TestExecution_user_test]" is set
      And the ip is released
      And the phone number "[CONTEXT:living_app_user.phone_number]" is reserved

    Actions Before each Scenario:
    Given the TAC are restored to the user id "[CONTEXT:living_app_user.user_id]"
      And I remove the LA session
      And the living app is opened using the url 
          | param_name     | param_value                                 |
          | laName         | [CONTEXT:living_app_name]                   |
          | contentsLabUrl | [CONF:api.url]                              |
          | labUrl         | [CONF:api.url]                              |
          | contentsLabEnv | [CONTEXT:living_app_props.contents_lab_env] |
          | aura_wait      | [TRUE]                                      |

  Actions After each Scenario:
     Then the close event is sent to the living app

  @jira.link.tests.LIVINGAPPS-XXXXX
  @jira.acs.LIVINGAPPS-XXXXX#ACX
  Scenario: PAGE NAME, element name, scenario description
