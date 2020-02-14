*** Settings ***
Library           SeleniumLibrary
Resource          CommonlyUsedKeywords.txt
Library           ExcelLibrary

*** Variables ***
${scalarVar1}     2
${scalarVar2}     2
@{listVar1}       month    January
@{listVar2}       month    February
&{dictVar1}       author=Liu Cixin    title=The Three-Body Problem
&{dictVar2}       author=Lemm    title=The Star Diaries
&{dictVar3}       author=Lemm    title=The Star Diaries123

*** Test Cases ***
VariablesTypes
    [Documentation]    *Variables*
    ...    _scalar variables example_
    ...
    ...    _list variable example_:
    ...    lists are converted to Strings before comparing
    ...
    ...    Link: https://www.leo.org/german-english
    [Tags]    TEST
    [Setup]
    Should Be Equal As Numbers    2    2
    Should Be Equal As Numbers    ${scalarVar1}    ${scalarVar2}
    Should Be Equal As Strings    @{listVar1}[0]    @{listVar2}[0]
    Should Not Be Equal As Strings    &{dictVar1}[author]    &{dictVar2}[author]
    [Teardown]

TemplatesAndTimeouts
    [Template]    Should Be Equal As Integers
    [Timeout]    1 minute 10 seconds    # testing timeout
    1    1
    5    5
    7    7

*** Keywords ***
