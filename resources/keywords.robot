*** Settings ***
Library     RPA.PDF
Library     Invitations
Library     OperatingSystem
Variables   variables.py

*** Keywords ***
Process invitations
    Validate prerequisites
    ${invitations}=         Collect invitations

    FOR     ${invitation}    IN  @{invitations}
        Run Keyword And Continue On Failure     Process invitation   ${invitation}
    END

    [Teardown]

Validate prerequisites
    File Should Exist       ${EXCEL_FILE_PATH}
    File Should Exist       ${PDF_TEMPLATE_PATH}

Collect invitations
    ${invitations}=  Get invitations    ${EXCEL_FILE_PATH}
    [Return]    ${invitations}

Process invitation
    [Arguments]                     ${invitation}
    Log   ${PDF_OUTPUT_DIRECTORY}
    Template HTML to PDF   ${PDF_TEMPLATE_PATH}  ${PDF_OUTPUT_DIRECTORY}/${invitation["first_name"]}${invitation["last_name"]}.pdf  ${invitation}
