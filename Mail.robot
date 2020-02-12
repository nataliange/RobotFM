*** Settings ***
Library           SeleniumLibrary
Library           ExcelLibrary
Library           Collections
Resource          YahooBasicKeaywords.txt

*** Test Cases ***
Mail
    Set Selenium Speed    1
    Open Browser    https://accounts.google.com    chrome
    Maximize Browser Window
    Page Should Contain Element    xpath://span[@jsslot="" and contains(text(), 'Anmeldung')]
    Page Should Contain Element    xpath://span[@jsslot="" and contains(text(), 'Mit Google-Konto anmelden.')]
    Wait Until Keyword Succeeds    2    1    Clear Element Text    xpath://input[@type="email"]
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@type="email"]    @@@@@@@@@@@@@@
    Wait Until Keyword Succeeds    2    1    Click element    xpath://span[@class="RveJvd snByac" and contains(text(), 'Weiter')]
    Wait Until Keyword Succeeds    2    1    Clear Element Text    xpath://input[@type="password"]
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@type="password"]    XXXXXXXXXXX
    Wait Until Keyword Succeeds    2    1    Click element    xpath://span[@class="RveJvd snByac" and contains(text(), 'Weiter')]
    Close Browser
    Open Browser    https://mail.yahoo.com    chrome
    Maximize Browser Window
    Wait Until Keyword Succeeds    2    1    Clear Element Text    xpath://input[@id="login-username"]
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@id="login-username"]    @@@@@@@@@@@@@@
    Wait Until Keyword Succeeds    2    1    Click element    xpath://input[@value="Next"]
    Wait Until Keyword Succeeds    2    1    Clear Element Text    xpath://input[@type="password"]
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://input[@type="password"]    XXXXXXXXX
    Wait Until Keyword Succeeds    2    1    Click element    xpath://button[@type="submit"]
    Comment    Wait Until Keyword Succeeds    2    1    Click element    xpath://*[@id="modal-outer"]/div/div/div[3]/div[5]/button/span
    Page Should Contain Element    xpath://span[@data-test-folder-name="Inbox" and contains(text(), 'Posteingang')]
    Wait Until Keyword Succeeds    2    1    Click element    xpath://a[@aria-label="Verfassen"]
    Wait Until Keyword Succeeds    2    1    Clear Element Text    xpath://*[@id="editor-container"]/div[1]
    Wait Until Keyword Succeeds    2    1    Input Text    xpath://*[@id="editor-container"]/div[1]    Text for mail is typed here

yahoo
    Set Selenium Timeout    360
    Set Selenium Speed    0.5
    loginYahoo
    sendEmail
    checkGesendetFolder
    CheckInboxFolder
    DeleteEmailInInbox
    deleteAllMailsInGesendetFolder
    DeleteAllMailsInTrash
    sleep    2
    Close Browser
