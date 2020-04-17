*** Settings ***
Library     OperatingSystem
Library     RPA.Robocloud.Items
Library     RPA.Tables
Library     RPA.Excel.Files
Library     Collections
Variables   variables.py

*** Keywords ***
Store invitations in work item
    Set up and validate
    ${invitations}=    Collect invitations from the Excel file
    Load Work Item From Environment
    Set work item variables    invitations=${invitations}
    Save work item

    [Teardown]

Set up and validate
    File Should Exist       ${EXCEL_FILE_PATH}
    
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