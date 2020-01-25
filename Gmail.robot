*** Settings ***
Library           SeleniumLibrary
Library           ExcelLibrary
Resource          BasicKeywords.txt

*** Test Cases ***
TC_01_Login
    navigateToUrl
    Location Should Be    https://www.leo.org/german-english
    PageObjects
    Maximize Browser Window
    loginToLeo
    [Teardown]    close Browser
