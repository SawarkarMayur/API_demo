*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}   http://restapi.demoqa.com/customer

*** Test Cases ***

Put_cust_reg
    create session  mysession  ${base_url}
    ${body}=  create dictionary  FirstName=Random1  LastName=User1  UserName=randomuser1  Password=Test1231  Email=randomuser2@gmail.com
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=  post request  mysession   /register  data=${body}  headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}

    #Validations
    ${res_body}=  convert to string  ${response.content}
    should contain  ${res_body}    OPERATION_SUCCESS
    should contain  ${res_body}    Operation completed successfully