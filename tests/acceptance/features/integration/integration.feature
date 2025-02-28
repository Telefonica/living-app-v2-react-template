@integration
Feature: [INTEGRATION] PAGE NAME: Feature description

  @jira.link.tests.LIVINGAPPS-XXXXX
  @jira.acs.LIVINGAPPS-XXXXX#ACX
  Scenario: PAGE NAME, element name, scenario description
    Given the living app is opened using the url 
          | param_name     | param_value                                 |
          | laName         | [CONTEXT:living_app_name]                   |
          | labUrl         | [CONF:api.url]                              |
          | contentsLabEnv | [CONTEXT:living_app_props.contents_lab_env] |
          | mock           | [TRUE]                                      |
          | layoutId       | [CONTEXT:layout_content.id]                 |
