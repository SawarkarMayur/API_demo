*** Settings ***
Documentation    Suite description
Library  XML
Library  os
Library  Collections
Library  RequestsLibrary
*** Variables ***
${build_url}  http://thomas-bayer.com

*** Test Cases ***
TC1-Read xml file
    [Tags]    x1
    ${xml_obj}  parse xml  ./sample.xml

    #type1
    ${name}  get element text  ${xml_obj}  .//employee[1]/firstname
    should be equal  ${name}  Jane
    #type2
    ${val}  get element  ${xml_obj}  .//employee[1]/firstname
    should be equal  ${val.text}  Jane
    #type3
    element text should be  ${xml_obj}  Jane  .//employee[1]/firstname

    #Check number of nodes/set/element
    ${count}  get element count  ${xml_obj}  .//employee
    log to console  ${count}
    should be equal as integers  ${count}  6

    #check  attribute present
    element attribute should be  ${xml_obj}  id  be135  .//employee[6]

    #check values of child nodes
    ${childs}  get child elements  ${xml_obj}  .//employee[2]
    should not be empty  ${childs}
    ${title}  get element text  ${childs[2]}
    ${fname}  get element text  ${childs[0]}
    should be equal  ${fname}  William
    should be equal  ${title}  Accountant


TC2-Read response from xml
    [Tags]  x2
    create session  mysession  ${build_url}
    ${response}  get request  mysession  /sqlrest/CUSTOMER/15
    ${xml_str}  convert to string  ${response.content}
    ${xml_obj}  parse xml  ${xml_str}

    #check single element
    element text should be  ${xml_obj}  15  .//ID
    ${ct}  get element text  ${xml_obj}  .//CITY
    should be equal  ${ct}  Seattle
    #check multiple values
    ${chld}  get child elements  ${xml_obj}
    should not be empty  ${chld}
    element text should be  ${chld[1]}  Bill
    ${lname}  get element text  ${chld[2]}
    should be equal  ${lname}  Clancy
