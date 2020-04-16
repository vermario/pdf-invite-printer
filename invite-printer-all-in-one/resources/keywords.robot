*** Settings ***
Library     RPA.PDF
Library     OperatingSystem
Library     RPA.Tables
Library     RPA.Excel.Files
Library     Collections
Library     ArchiveLibrary
Variables   variables.py

*** Keywords ***
Process invitations
    Set up and validate
    ${invitations}=    Collect invitations from the Excel file

    FOR     ${invitation}  IN  @{invitations}
        Run Keyword And Continue On Failure    Process invitation  ${invitation}
    END

    Create ZIP Package from PDF files

    [Teardown]   Cleanup PDF directory

Set up and validate
    Create directory        ${PDF_TEMP_OUTPUT_DIRECTORY}
    File Should Exist       ${EXCEL_FILE_PATH}
    File Should Exist       ${PDF_TEMPLATE_PATH}
    
Collect invitations from the Excel file
    Open workbook  ${EXCEL_FILE_PATH}
    ${worksheet}=  Read worksheet  header=${TRUE}
    ${invitations_table}=   Create table   ${worksheet}
    ${invitations}=  Create list
    FOR    ${row}    IN    @{invitations_table}
        ${invitation}=  Create Dictionary
        Set To Dictionary   ${invitation}  first_name   ${row.first_name}
        Set To Dictionary   ${invitation}  last_name    ${row.last_name}
        Set To Dictionary   ${invitation}  address      ${row.address}
        Set To Dictionary   ${invitation}  city         ${row.city}
        Set To Dictionary   ${invitation}  date         ${row.date}
        Set To Dictionary   ${invitation}  time         ${row.time}
        
        Append to List      ${invitations}  ${invitation}
    END

    Close workbook
    [Return]         ${invitations}   

Process invitation
    [Arguments]   ${invitation}
    Template HTML to PDF   ${PDF_TEMPLATE_PATH}  ${PDF_TEMP_OUTPUT_DIRECTORY}/${invitation["first_name"]}_${invitation["last_name"]}.pdf  ${invitation}

Create ZIP Package from PDF files
    ${zipfilename}=    set variable     ${OUTPUT_DIRECTORY}/PDFs.zip
    Create zip from Files in directory    ${PDF_TEMP_OUTPUT_DIRECTORY}    ${zipfilename}

Cleanup PDF directory
    Remove Directory    ${PDF_TEMP_OUTPUT_DIRECTORY}  True