*** Settings ***
Library             libraries/grpcInterface.py


*** Test Cases ***
Scenario: gRPC-GET-verify Check interface name has expected value via GNMI get
    [Template]    Check interface name has expected value via GNMI get
    Check interface name has expected value via GNMI get for 172.143.177.11    172.143.177.11    openconfig-interfaces:interfaces/interface[name=1/1/c4/1]/state/name    1/1/c4/1    57400    admin    admin


*** Keywords ***
Check interface name has expected value via GNMI get
    [Arguments]    ${Testcase}    ${device}    ${paths}    ${expected_value}    ${port}    ${user}    ${password}
    &{gRPCGetResult} =   gnmiGet    ${device}    ${paths}    ${port}    ${user}    ${password}
    Should Be Equal    ${gRPCGetResult}[notification][0][update][0][val]    ${expected_value}
    ${ReportResultSQL} =    Evaluate    "${gRPCGetResult}[notification][0][update][0][val]" + "==" + "${expected_value}"