*** Settings ***
Library           ExcelLibrary
Resource          BasicKeywords.txt
Library           DatabaseLibrary
Library           Collections
Resource          CommonlyUsedKeywords.txt
Library           SeleniumLibrary
Library           REST
Library           BuiltIn
Library           DateTime
Library           Dialogs
Library           Process
Library           Screenshot
Library           String
Library           Telnet
Library           XML
Library           SSHLibrary
Library           CryptoLibrary
Library           KeePassLibrary
Library           RequestsLibrary

*** Variables ***
@{pages}
${Response}       10 20 50 100 250
${page}           ${EMPTY}
${BaseURL}        https://api.github.com

*** Test Cases ***
ReadFromXLSX
    [Documentation]    - Login to Dict.leo.org with credentials taken from xlsx file
    ...    - search for a word translation
    Set Selenium Speed    1
    navigateToUrl
    Location Should Be    https://www.leo.org/german-english
    PageObjects
    Maximize Browser Window
    Login to user application
    Sleep    3
    wordSearch
    Wait Until Keyword Succeeds    2    1    Click element    xpath://a[@class='ib' and contains(text(), 'Forum')]
    Wait Until Keyword Succeeds    2    1    Click element    xpath://a[@class='ib' and contains(text(), 'Trainer')]
    Wait Until Keyword Succeeds    2    1    Click element    xpath://button[@type="button" and contains(text(), 'Weiter')]
    Sleep    2
    Wait Until Keyword Succeeds    2    1    Click element    xpath://a[@class='ib' and contains(text(), 'Kurse')]
    Close Browser
    [Teardown]

ReadFromDB
    [Documentation]    - Login to Dict.leo.org with credentials taken from DB
    ...    - search for a word translation
    ...    - open one after another all tabs
    Set Selenium Speed    2
    Connect To Database    pyodbc    NATADB    NATASQL    test    localhost    1433
    Table Must Exist    Email
    Row Count Is Equal To X    select * from Email    2
    @{queryResultsName}    Query    select username from Email where id=2
    Log Many    @{queryResultsName}
    @{queryResultsPWD}    Query    select password from Email where id=2
    Open Browser    https://www.leo.org    chrome
    Maximize Browser Window
    Click Element    xpath://i[@title='Login']
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@name='login' and @autocomplete='username']    @{queryResultsName}
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@name='password' and @autocomplete='current-password']    @{queryResultsPWD}
    Close Browser
    [Teardown]    close Browser

LoginWrongCrenentials
    Set Selenium Speed    1
    navigateToUrl
    Maximize Browser Window
    Click Element    xpath://i[@title='Login']
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@name='login' and @autocomplete='username']    invalid data
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@name='password' and @autocomplete='current-password']    invalid data
    Click Element    xpath://button[@type='submit' and contains(text(), 'Login')]
    ${loginFailed}    Get Text    xpath://span[@class="f2" and contains(text(), 'Die Anmeldung ist fehlgeschlagen.')]
    Log    ${loginFailed}
    Should Be Equal As Strings    ${loginFailed}    Die Anmeldung ist fehlgeschlagen.
    Close All Excel Documents
    Close Browser

CompareExcelFiles
    [Documentation]    Select "Show 10 items on the page"
    ...
    ...    select the letter "P" for districts to be displayed
    ...
    ...    Read postcodes from the page
    ...
    ...    Write postcodes to the new creates file Postcode_ACTUAL.xlsx
    ...
    ...    Compare lists in Postcode_ACTUAL.xlsx and Postcode_EXPECTED.xlsx
    Set Selenium Speed    0.5
    Open Browser    https://www.suche-postleitzahl.org/berlin.13f    chrome
    Maximize Browser Window
    Sleep    2
    Click Element    xpath://option[@value='10']
    Sleep    2
    List Selection Should Be    xpath://select[@name='data-table_length']    10
    Sleep    2
    Select From List By Index    xpath://select[@name='data-table_length']    2
    List Selection Should Be    xpath://select[@name='data-table_length']    50
    Sleep    2
    BuiltIn.Wait Until Keyword Succeeds    2    1    Click Element    xpath://option[@value='P']
    ${postcode1}    Get Text    xpath://span[@data-plzexpand="Prenzlauer Berg" and contains(text(), '10119-10439')]
    Log    ${postcode1}
    Should Be Equal As Strings    ${postcode1}    10119-10439
    ${postcode2}    Get Text    xpath://span[@data-plzexpand="Pankow" and contains(text(), '10439-13189')]
    Log    ${postcode2}
    Should Be Equal As Strings    ${postcode2}    10439-13189
    ${postcode3}    Get Text    xpath://span[@data-plzexpand="Plänterwald" and contains(text(), '')]
    Log    ${postcode3}
    Should Be Equal As Strings    ${postcode3}    12435-12437
    Create Excel Document    doc_id=C:/Users/nage/Robot clones/RobotFM/Postcode_ACTUAL.xlsx
    ${col_data}    Create List    ${postcode1}    ${postcode2}    ${postcode3}
    Write Excel Column    col_num=1    col_data=${col_data}    sheet_name=Sheet
    Save Excel Document    filename=Postcode_ACTUAL.xlsx
    Open Excel Document    C:/Users/nage/Robot clones/RobotFM/Postcode_EXPECTED.xlsx    doc_id=Postcode_EXPECTED.xlsx
    ${cd}    Read Excel Column    col_num=1    max_num=3    sheet_name=Sheet
    Log    ${cd}
    Lists Should Be Equal    ${col_data}    ${cd}
    Close All Excel Documents
    Close Browser

REST!
    Get    https://jsonplaceholder.typicode.com/users
    Integer    response body id    4

RESTWithProxies!
    ${proxies}=    BuiltIn.Create Dictionary    http=10.56.130.175:3128    http=193.138.91.175:8080
    Create Session    employees    https://jsonplaceholder.typicode.com    proxies=${proxies}
    ${resp}=    Get Request    employees    /users/1
    BuiltIn.Log To Console    ${resp}
    Should Be Equal As Strings    ${resp.status_code}    200

TC_01_Login_with_XLSX_mob_view!
    [Documentation]    WORKD ONLY FOR TABLET VIEW
    Set Selenium Speed    1
    navigateToUrl
    Location Should Be    https://www.leo.org/german-english
    PageObjects
    Maximize Browser Window
    Login to user application
    Sleep    3
    wordSearchMobView
    Wait Until Keyword Succeeds    2    1    Click element    xpath://a[@class='ib' and contains(text(), 'Forum')]
    Wait Until Keyword Succeeds    2    1    Click element    xpath://a[@class='ib' and contains(text(), 'Trainer')]
    Wait Until Keyword Succeeds    2    1    Click element    xpath://button[@type="button" and contains(text(), 'Weiter')]
    Sleep    2
    Wait Until Keyword Succeeds    2    1    Click element    xpath://a[@class='ib' and contains(text(), 'Kurse')]
    Close Browser
    [Teardown]
