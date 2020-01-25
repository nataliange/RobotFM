*** Settings ***
Library           DateTime

*** Variables ***
${var1}           5
${var2}           5

*** Test Cases ***
TC_01
    Should Be Equal As Integers    ${var1}    ${var2}

TC_02
    Get Current Date

TC_03
    Log To Console    Hello world
