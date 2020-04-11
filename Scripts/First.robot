*** Settings ***
Documentation    Suite description

Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}   http://restapi.demoqa.com
${city}       Mumbai

*** Test Cases ***
Get_wheather_info
    [Tags]    MS
    create session  myscn  ${base_url}
    ${response}=  get request  myscn  /utilities/weather/city/${city}

    log to console  ${response.status_code}
    log to console  ${response.content}
    log to console  ${response.headers}

    #validations
    ${status_code}=  convert to string  ${response.status_code}
    should be equal      ${status_code}  200
    ${body}=  convert to string  ${response.content}
    should contain  ${body}  Mumbai
    ${conType}  get from dictionary  ${response.headers}  Content-Type
    should be equal  ${conType}  application/json

*** Keywords ***
