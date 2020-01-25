*** Settings ***
Force Tags
Library           SeleniumLibrary
Library           ExcelLibrary
Resource          UserDefinedKeywords.txt    # My first resource

*** Variables ***
${var1}           4    # This is my first scalar variable
${var2}           4    # This is my second variable
@{USER}           Natalia    Nata
&{Credentials}    username=natalia    password=natalia

*** Test Cases ***
TC_01
    [Documentation]    This is my 1st test case. It is used to compare two variables.
    ...    *It is bold*
    ...    _It is italic_
    ...    The link is: https://www.google.de/
    Should Be Equal    ${var1}    ${var2}

TC_02
    [Tags]    LOGIN
    [Setup]    SetUpDemo
    Should Not Be Equal As Strings    @{USER}[0]    @{USER}[1]
    [Teardown]    TearDownDemo

TC_03
    Should Be Equal As Strings    &{Credentials}[username]    &{Credentials}[password]

TC_04
    [Tags]    LOGIN
    Should Be True    4    4

TC_05
    [Template]    Should Be Equal As Integers    # Using template
    [Timeout]    2 minutes 20 seconds    # This is my timeout test case
    4    4
    6    6
    8    8
    3    3
    2    2

TC_06
    CompareTwoVariables

*** Keywords ***
SetUpDemo
    Log To Console    This is setup

TearDownDemo
    Log To Console    This is TearDown
