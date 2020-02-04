*** Settings ***
Library           SeleniumLibrary
Resource          CommonlyUsedKeywords.txt
Library           ExcelLibrary

*** Variables ***
@{Cities}
${City}           ${EMPTY}
${TextField}      ${EMPTY}
${username}       ${EMPTY}
${password}       ${EMPTY}
${actualWrongCredentials}    ${EMPTY}
${expectedWrongCredentials}    ${EMPTY}
${ResponseTwo}    Toronto Chicago New York London

*** Test Cases ***
OpenBrowserChrome
    Open Browser    https://www.facebook.com/    chrome
    Maximize Browser Window
    Sleep    2
    Input Text    name:email    Natalia@gmail.com
    Input Text    id=pass    qwerty
    Sleep    2
    Close Browser

OpenBrowserFF
    Open Browser    https://www.google.de/    ff
    Close Browser

OpenBrowserChrome2
    [Documentation]    The test will NOT work withour id=iframe-015!!!
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-015
    Sleep    2
    Element Text Should Be    xpath://option[text()='London']    London
    Sleep    2
    Select From List By Value    id=FromCity    jfk
    Sleep    2
    Click Element    xpath:/html/body/fieldset[3]/input[2]
    Sleep    2
    Click Element    //input[@value='por']
    Sleep    2
    Click Element    xpath://input[contains(@value, 'bmw')]
    Sleep    2
    Click Element    xpath://input[starts-with(@value, 'me')]
    Sleep    2
    Click Element    xpath://input[@type='checkbox'][2]
    Sleep    2
    Click Element    //input[@type='checkbox' and @value='por']
    Sleep    2
    Click Element    xpath:/html/body/descendant::input[@value='bmw']
    sleep    2
    Click Element    //input[@value='merc']/preceding-sibling::*[2]
    Sleep    2
    Click Element    //input[@value='merc']/following-sibling::*[2]
    Sleep    2
    Click Element    //input[@value='merc']/preceding-sibling::input[@value = 'bmw']
    Sleep    2
    [Teardown]    Close Browser

OpenBrowserChromeXpath
    [Documentation]    The test will NOT work withour id=iframe-015!!!
    SeleniumLibrary.Open Browser    https://www.facebook.com/    chrome
    SeleniumLibrary.Maximize Browser Window
    Sleep    2
    Input Text    xpath://*[@id="email"]    Nata
    Sleep    3
    Input Text    xpath://*[@id="pass"]    qwerty
    Sleep    3
    Close Browser

OpenBrowserChromeCSS
    [Documentation]    The test will NOT work withour id=iframe-015!!!
    SeleniumLibrary.Open Browser    https://www.facebook.com/    chrome
    SeleniumLibrary.Maximize Browser Window
    Sleep    2
    Input Text    css:#email    Nata
    Sleep    3
    Input Text    css:#pass    test@gmail.com
    Sleep    3
    Close Browser

AdvancedCSS
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-015
    Click Element    css:select[id='FromCity']
    Sleep    2
    Comment    Click Element    css:div[class='popup']
    sleep    3
    Comment    Click Element    css:input[value^='b']
    Sleep    2
    Comment    Click Element    input[value$='r']
    Sleep    2
    Click Element    css:input[value*='er']
    Sleep    2
    [Teardown]    Close browser

TextBoxDemo
    [Documentation]    LOG-level "DEBUG" will create a screenshot in an error case
    ...
    ...    LOG-level "WARN" will create a stack trace in an error case
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-015
    Sleep    2
    Page Should Contain Textfield    xpath://input[@name='FirstName']    Show me this message in case if you fail.    WARN
    Sleep    2
    Input Text    xpath://input[@name='FirstName']    Natalia
    Sleep    2
    Textfield Value Should Be    xpath://input[@name='FirstName']    Natalia
    Sleep    2
    Clear Element Text    xpath://input[@name='FirstName']
    Sleep    2
    [Teardown]    Close browser

Button
    SeleniumLibrary.Open Browser    https://www.facebook.com/    chrome
    SeleniumLibrary.Maximize Browser Window
    Sleep    2
    Input Text    css:#email    demo
    Sleep    2
    Input Text    css:#pass    demo1
    Sleep    2
    Click Button    xpath://input[@value='Log In']
    [Teardown]    Close browser

Checkbox
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-015
    Sleep    2
    Page Should Contain Checkbox    xpath://input[@value='bmw']    Checkbox not found    INFO
    Sleep    2
    Select Checkbox    xpath://input[@value='bmw']
    Sleep    2
    Checkbox Should Be Selected    xpath://input[@value='bmw']
    Sleep    2
    Unselect Checkbox    xpath://input[@value='bmw']
    Sleep    2
    Checkbox Should Not Be Selected    xpath://input[@value='bmw']
    Sleep    2
    [Teardown]    Close browser

ListElementDemo
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-014
    Sleep    2
    Page Should Contain List    css:#FromCity
    Sleep    2
    @{Cities}    Get List Items    css:#FromCity
    FOR    ${City}    IN    @{Cities}
        LOG    ${City}
    Sleep    4
    List Selection Should Be    css:#FromCity    Toronto
    Sleep    2
    Select From List By Index    css:#FromCity    1
    Sleep    2
    Select From List By Value    css:#FromCity    ord
    Sleep    2
    [Teardown]    Close browser

RadioButton
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-015
    Sleep    2
    Page Should Contain Radio Button    xpath://input[@value='flighthotel']
    Sleep    2
    Select Radio Button    flight    flighthotel
    sleep    2
    Radio Button Should Be Set To    flight    flighthotel
    Sleep    2
    [Teardown]    Close browser

Image
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Click Image    xpath://*[@id="n-52555261-navBarId"]/div[1]/div/a/img
    Sleep    2
    [Teardown]    Close browser

Table
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-015
    Sleep    2
    Page Should Contain Element    xpath:/html/body/fieldset[7]/table    Table not foud    INFO
    Sleep    2
    Table Should Contain    xpath:/html/body/fieldset[7]/table    Country    INFO
    Sleep    2
    Table Cell Should Contain    xpath:/html/body/fieldset[7]/table    2    3    Canada
    Sleep    2
    Table Column Should Contain    xpath:/html/body/fieldset[7]/table    1    Justin Trudeau
    sleep    2
    Table Row Should Contain    xpath:/html/body/fieldset[7]/table    5    Chancellor
    ${TextField}    Get Text    xpath://table/tbody/tr[4]/td[1]
    Should Be Equal As Strings    ${TextField}    Theresa May
    Sleep    2
    [Teardown]    Close browser

Flight Application
    Set Selenium Speed    0.5
    Set Selenium Implicit Wait    5
    SeleniumLibrary.Open Browser    https://ngendigital.com/demo-application    chrome
    Location Should Be    https://ngendigital.com/demo-application    It is not the same URL.
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-015
    Sleep    2
    Wait Until Keyword Succeeds    1min    1sec    Login to user application
    sleep    5
    Page Should Contain Element    xpath://*[@id="InvalidLogin"]/p/label/font
    ${actualWrongCredentials}    Get Text    xpath://*[@id="InvalidLogin"]/p/label/font
    Open Excel Document    C:/Robot_projects/Demo/Flight.xlsx    doc_id=Flight1.xlsx
    ${expectedWrongCredentials}    Read Excel Cell    4    2
    Should Be Equal As Strings    ${actualWrongCredentials}    ${expectedWrongCredentials}
    Capture Page Screenshot
    Close Browser
    Open Browser    https://www.gmail.com/    chrome
    Log Location
    Log Source
    Log Title
    Close Browser
    [Teardown]    Close Browser

DZ_2_LoginInvalCredent
    SeleniumLibrary.Open Browser    https://ngendigital.com/demo-application    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-015
    Sleep    2
    Login to user application    support@ngendidgital.com    abc12345
    Page Should Contain Element    xpath://*[contains(text(), "Invalid username/password")]    Text not found    INFO
    Sleep    2
    [Teardown]    Close browser

List2
    SeleniumLibrary.Open Browser    https://ngendigital.com/practice    chrome
    SeleniumLibrary.Maximize Browser Window
    Select Frame    id=iframe-014
    Sleep    2
    @{Cities}    Get List Items    xpath://select[@id='FromCity']
    FOR    ${City}    IN    @{Cities}
        Should Contain    ${ResponseTwo}    ${City}
