*** Settings ***
Library     RPA.Robocloud.Items
Library     OperatingSystem
Library     Invitations
Variables   variables.py

*** Keywords ***
Store invitations in work item
    Set up and validate
    ${invitations}=    Collect invitations
    Log Many   ${invitations}
    Load Work Item From Environment
    Set work item variables    invitations=${invitations}
    Save work item

    [Teardown]

Set up and validate
    File Should Exist       ${EXCEL_FILE_PATH}
    
Collect invitations
    ${invitations}=    Get invitations    ${EXCEL_FILE_PATH}
    [Return]    ${invitations}