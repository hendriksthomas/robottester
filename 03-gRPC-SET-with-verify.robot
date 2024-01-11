*** Settings ***
Library             libraries/grpcInterface.py


*** Variables ***
&{DICT_1}    name=1/1/c6/1    enabled=${TRUE}    description=1/1/c6/1 description    type=ethernetCsmacd
&{DICT_2}    config=${DICT_1}    name=1/1/c6/1
&{DICT}      interface=${DICT_2}


*** Test Cases ***
Scenario: gRPC-SET Set interface configuration via GNMI set
    [Template]    Set interface configuration via GNMI set
    Set interface configuration via GNMI set for 172.143.177.11    172.143.177.11    openconfig-interfaces:interfaces    ${DICT}    57400    admin    admin
Scenario: gRPC-GET-verify Check interface name has expected value via GNMI get
    [Template]    Check interface name has expected value via GNMI get
    Check interface name has expected value via GNMI get for 172.143.177.11    172.143.177.11    openconfig-interfaces:interfaces/interface[name=1/1/c6/1]/state/name    1/1/c6/1    57400    admin    admin


*** Keywords ***
Set interface configuration via GNMI set
    [Arguments]    ${Testcase}    ${device}    ${path}    ${payload}    ${port}    ${user}    ${password}
    gnmiSet    ${device}    ${path}    ${payload}    ${port}    ${user}    ${password}
Check interface name has expected value via GNMI get
    [Arguments]    ${Testcase}    ${device}    ${paths}    ${expected_value}    ${port}    ${user}    ${password}
    &{gRPCGetResult} =   gnmiGet    ${device}    ${paths}    ${port}    ${user}    ${password}
    Should Be Equal    ${gRPCGetResult}[notification][0][update][0][val]    ${expected_value}
    ${ReportResultSQL} =    Evaluate    "${gRPCGetResult}[notification][0][update][0][val]" + "==" + "${expected_value}"