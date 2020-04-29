*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}  https://maps.googleapis.com
${req_uri}   /maps/api/place/nearbysearch/json?

*** Test Cases ***

GoogleMapPlacesAPI_TC
    [Tags]    g
    create session  mysession  ${base_url}
    ${params}  create dictionary  location=-33.8670522,151.1957362  radius=500  types=food  name=harbour  key=AIzaSyDfF7_uf-cLJxM9SqZcoipt0RjoWRK5uQ4
    ${response}  get request  mysession  ${req_uri}  params=${params}

    log  ${response.status_code}
    log  ${response.content}