*** Settings ***
Library     RPA.PDF
Library     RPA.Robocloud.Items
Library     OperatingSystem
Library     ArchiveLibrary
Variables   variables.py

*** Keywords ***
Process invitations
    Set up and validate
    ${invitations}=    Collect invitations from work item

    FOR     ${invitation}  IN  @{invitations}
        Run Keyword And Continue On Failure    Process invitation  ${invitation}
    END

    Create ZIP Package from PDF files

    [Teardown]   Cleanup PDF directory

Set up and validate
    Create directory        ${PDF_TEMP_OUTPUT_DIRECTORY}
    File Should Exist       ${PDF_TEMPLATE_PATH}
    
Collect invitations from work item
    Load Work Item From Environment
    ${invitations}=    Get Work Item Variable  invitations
    Log Many    ${invitations}
    [Return]    ${invitations}

Process invitation
    [Arguments]                     ${invitation}
    Log   ${PDF_TEMP_OUTPUT_DIRECTORY}
    Template HTML to PDF   ${PDF_TEMPLATE_PATH}  ${PDF_TEMP_OUTPUT_DIRECTORY}/${invitation["first_name"]}_${invitation["last_name"]}.pdf  ${invitation}

Create ZIP Package from PDF files
    ${zipfilename}=    set variable     ${OUTPUT_DIRECTORY}/PDFs.zip
    Create zip from Files in directory    ${PDF_TEMP_OUTPUT_DIRECTORY}    ${zipfilename}

Cleanup PDF directory
    Remove Directory    ${PDF_TEMP_OUTPUT_DIRECTORY}  True