*** Settings ***
Documentation   Invite printer robot. Creates PDF invitations to events based on data collected
...             in a Microsoft Excel file.
Resource        keywords.robot

*** Tasks ***
Create pdf invitations
    Process invitations
