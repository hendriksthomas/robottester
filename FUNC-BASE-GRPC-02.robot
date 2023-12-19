*** Settings ***
Documentation       BT-GNF.Feature Basebuild GRPC

#Resource            ${EXECDIR}/resources/settings.robot
#Variables           ${EXECDIR}/bt-gnf-test-data/topologies/%{TESTBED}/vars_testbed.yaml
#Resource            ${EXECDIR}/resources/keywords/FEATURE/basebuild_grpc.resource

Library             libraries/grpcInterface.py

#Suite Setup        Setup
#Test Setup         Setup quick
#Test Teardown      Cleanup   include_syslogs=${FALSE}   include_rollback=${FALSE}
#Suite Teardown     Cleanup

*** Test Cases ***
Scenario: FUNC-BASE-GRPC-02 Verify gNMI get is successful to device
    [Tags]    feature    fast    basebuild    grpc    func-base-grpc-02    batch12
    [Template]    gnmiGet

    # Description                             # Device Under Test
    #this doesnt work properly? 3 params passed only, one blanked
    #clab-pce_demo-r1
    172.143.177.11

    #Verify gNMI get is successful to PE2      localhost
    #Verify gNMI get is successful to P1       localhost
    #Verify gNMI get is successful to RRi1     localhost
    #Verify gNMI get is successful to RRs1     localhost
    #Verify gNMI get is successful to LS1      localhost



*** Keywords ***
Scenario Outline: Verify gNMI get is successful to device
    [Arguments]    ${Testcase}    ${device}
    #[Teardown]     Cleanup   include_syslogs=${FALSE}   include_rollback=${FALSE}

    Given GRPC is configured on ${device} as defined in basebuild template/datamodel files
    And GRPC operational state is correct on ${device} as defined in basebuild template/datamodel files
    When GNMI Get Request is attempted to ${device}
    Then the attempted GNMI Get Request is successful to ${device}
