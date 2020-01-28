*** Settings ***
Library           SeleniumLibrary
Library           ExcelLibrary
Resource          BasicKeywords.txt
Library           DatabaseLibrary
Library           Collections
Resource          CommonlyUsedKeywords.txt

*** Test Cases ***
TC_01_Login_with_XLSX
    navigateToUrl
    Location Should Be    https://www.leo.org/german-english
    PageObjects
    Maximize Browser Window
    Comment    loginToLeo
    Login to user application
    [Teardown]

Login_with_DB
    [Documentation]    Convert To List: converts tuple to a String
    Connect To Database    pyodbc    NATADB    NATASQL    test    localhost    1433
    Table Must Exist    Email
    @{queryResults}    Description    select * from Email
    Log Many    @{queryResults}
    @{queryResults}    Query    select * from Email
    ${rowCount}    Row Count    select * from Email
    ${LOG_FILE}    ${rowCount}
    Row Count Is Equal To X    select * from Email    2
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
    close br
    [Teardown]    close Browser
