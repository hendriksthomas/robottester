*** Settings ***
Library             libraries/grpcInterface.py


*** Test Cases ***
Scenario: Verify gNMI get is successful to device
    [Template]    Verify gNMI get is successful to device
    Verify gNMI get is successful to 172.143.177.11    172.143.177.11    openconfig-interfaces:interfaces    57400    admin    admin


*** Keywords ***
Verify gNMI get is successful to device
    [Arguments]    ${Testcase}    ${device}    ${paths}    ${port}    ${user}    ${password}
    ${ReportResultSQL} =    gnmiGet    ${device}    ${paths}    ${port}    ${user}    ${password}
