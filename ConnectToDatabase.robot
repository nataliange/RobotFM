*** Settings ***
Library           DatabaseLibrary
Library           SeleniumLibrary
Library           Collections

*** Variables ***
@{username}
@{password}

*** Test Cases ***
DBTestAutomation
    [Documentation]    Convert To List: converts tuple to a String
    Connect To Database    pyodbc    TESTDB    TESTSQLUSERNAME    test    localhost    1433
    Table Must Exist    Email
    @{queryResults}    Description    select * from Employees
    Log Many    @{queryResults}
    @{queryResults}    Query    select * from Employees
    ${rowCount}    Row Count    select * from Employees
    Log    ${rowCount}
    Row Count Is Equal To X    select * from Employees    2
    Table Must Exist    Employees
    Check If Exists In Database    select first_name from Employees where last_name='Braun'
    @{queryResults}    Query    select username from Email where id=2
    @{username}    Convert To List    @{queryResults}
    @{queryResults}    Query    select password from Email where id=2
    @{password}    Convert To List    @{queryResults}
    Open Browser    https://www.leo.org    chrome
    Maximize Browser Window
    Click Element    xpath://i[@title='Login']
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@name='login' and @autocomplete='username']    @{username}
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@name='password' and @autocomplete='current-password']    @{password}
    [Teardown]    close Browser
