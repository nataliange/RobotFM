*** Settings ***
Library           SeleniumLibrary
Library           ExcelLibrary
Library           Collections
Resource          YahooBasicKeaywords.txt

*** Test Cases ***
yahoo
    [Documentation]    - Login to yahoo
    ...    - send email to yourself
    ...    - check "Sent" folder
    ...    - check "Inbox" folder
    ...    - delete email in "Sent" folder
    ...    - delete email in "Inbox" folder
    ...    - delete all from "Trash"
    Set Selenium Timeout    360
    Set Selenium Speed    2
    loginYahoo
    sendEmail
    checkGesendetFolder
    CheckInboxFolder
    DeleteEmailInInbox
    deleteAllMailsInGesendetFolder
    DeleteAllMailsInTrash
    sleep    2
    Close Browser
