*** Settings ***
Documentation    Suite description

Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}  http://localhost:8080

*** Test Cases ***
TC1:Returns all the video games(GET)
    [Tags]    now
    create session  mysession  ${base_url}
    ${response}  get request  mysession  /app/videogames
    log to console  ${response.status_code}
    #log to console  ${response.content}
    ${status_code}=  convert to string  ${response.status_code}
    should be equal      ${status_code}  200

TC2:Add new video game(POST)
    [Tags]  now
    create session  mysession  ${base_url}
    ${body}  create dictionary  id=100  name=SpiderMan  releaseDate=2020-04-28T11:58:50.210Z  reviewScore=1  category=action  rating=5
    ${header}  create dictionary  Content-Type=application/json
    ${response}=  post request  mysession   /app/videogames  data=${body}  headers=${header}

    log to console  ${response.status_code}
    log  ${response.status_code}
    ${res_body}=  convert to string  ${response.content}
    should contain  ${res_body}    Record Added Successfully

TC3:Returns Single game based on id(GET)
    [Tags]    now
    create session  mysession  ${base_url}
    ${response}  get request  mysession  /app/videogames/100
    log  ${response.status_code}
    ${status_code}=  convert to string  ${response.status_code}
    should be equal      ${status_code}  200
    ${res_content}  convert to string  ${response.content}
    should contain     ${res_content}    SpiderMan

TC4:Update existing record(PUT)
    [Tags]  now
    create session  mysession  ${base_url}
    ${body}  create dictionary  id=100  name=SpiderMan  releaseDate=2020-04-28T11:58:50.210Z  reviewScore=5  category=action  rating=Legend
    ${header}  create dictionary  Content-Type=application/json
    ${response}=  put request  mysession   /app/videogames/100  data=${body}  headers=${header}
    log to console  ${response.status_code}
    log  ${response.status_code}
    ${res_body}=  convert to string  ${response.content}
    should contain  ${res_body}    Legend


TC5:Delets video game based on id(DELETE)
    [Tags]  now
     create session  mysession  ${base_url}
    ${response}  delete request  mysession  /app/videogames/100
    log   ${response.status_code}
    ${res_body}=  convert to string  ${response.content}
    should contain  ${res_body}    Record Deleted Successfully


