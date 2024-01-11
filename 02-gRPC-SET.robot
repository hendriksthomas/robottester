*** Settings ***
Library             libraries/grpcInterface.py


*** Variables ***
&{DICT_1}    name=1/1/c7/1    enabled=${TRUE}    description=1/1/c7/1 description    type=ethernetCsmacd
&{DICT_2}    config=${DICT_1}    name=1/1/c7/1
&{DICT}      interface=${DICT_2}


*** Test Cases ***
Scenario: gRPC-SET Set interface configuration via GNMI set
    [Template]    Set interface configuration via GNMI set
    Set interface configuration via GNMI set for 172.143.177.11    172.143.177.11    openconfig-interfaces:interfaces    ${DICT}    57400    admin    admin


*** Keywords ***
Set interface configuration via GNMI set
    [Arguments]    ${Testcase}    ${device}    ${path}    ${payload}    ${port}    ${user}    ${password}
    ${ReportResultSQL} =    gnmiSet    ${device}    ${path}    ${payload}    ${port}    ${user}    ${password}