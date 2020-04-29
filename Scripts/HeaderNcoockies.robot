*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}    http://jsonplaceholder.typicode.com

*** Test Cases ***
Test headers
    [Tags]    H
    create session  mysession  ${base_url}
    ${response}  get request  mysession  /photos
    log   ${response.headers}

    ${h_contenttype}  get from dictionary  ${response.headers}  Content-Type
    log to console  ${h_contenttype}
    should contain  ${h_contenttype}  application/json

Test Cookies
    [Tags]  C1
    create session  mysession  ${base_url}
    ${response}  get request  mysession  /photos

    ${c_val}  get from dictionary   ${response.cookies}  __cfduid
    log to console  ${c_val}