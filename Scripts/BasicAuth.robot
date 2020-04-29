*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}   http://restapi.demoqa.com

*** Test Cases ***

Test Basic authenitication
    [Tags]    ba
    ${auth_val}  create list  ToolsQA  TestPassword
    create session  mysession  ${base_url}  auth=${auth_val}
    ${response}  get request  mysession   /authentication/CheckForAuthentication/
    log to console  ${response.content}
    should be equal as strings  ${response.status_code}  200
    should contain  ${response.content}  Operation completed successfully

