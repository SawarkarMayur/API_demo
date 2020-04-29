*** Settings ***
Documentation    Suite description
Library  JSONLibrary
Library  os
Library  Collections
Library  RequestsLibrary
*** Variables ***
${baseurl}      https://restcountries.eu

*** Test Cases ***

TC1-Read data from simple local json file
    [Tags]    jj
    ${json_obj}  load json from file  ./samplejson.json
    ${value}   get value from json   ${json_obj}  $.phoneNumbers[0].number
    log to console  ${value[0]}
    #should be equal  @{value}  Steve

Get country info
    [Tags]  jc
    create session  mysession  ${baseurl}
    ${response}  get request  mysession   /rest/v2/alpha/IN
    ${json_obj}  to json  ${response.content}
    #Single data validation
    ${c_name}  get value from json  ${json_obj}  $.name
    log  ${c_name}
    should be equal  ${c_name[0]}  India

    ${alt}  get value from json  ${json_obj}  $.altSpellings[2]
    log to console  ${alt}
    list should contain value   ${alt}   Republic of India



    ${border}  get value from json  ${json_obj}  $.borders
    log to console  ${border}
    should contain   ${border[0]}  NPL  AFG
    should not contain any  ${border[0]}   xyz  abc


