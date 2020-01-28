*** Settings ***
Library           SeleniumLibrary
Library           ExcelLibrary

*** Variables ***
@{ExcelRows}
@{ExcelColumns}
${ExcelRow}       ${EMPTY}
${ExcelColumn}    ${EMPTY}
${ColCount}       ${EMPTY}

*** Test Cases ***
ReadFromExcel
    Open Excel Document    C:/Users/nage/Robot clones/RobotFM/Leo.xlsx    doc_id=Leo.xlsx
    @{ExcelRows}    Read Excel Row    2
    @{ExcelColumns}    Read Excel Column    1
    Comment    FOR    ${ExcelRow}    IN    @{ExcelRows}
    Comment    LOG    ${ExcelRow}    ${ExcelRow}
    Comment    Open Excel    D:/Robot_framework/Contacts_list_old_format.xls
    Comment    Check Cell Type    Sheet1    2    1
    Comment    ${ColCount}    Get Column Count    Sheet1
    Comment    LOG    ${ColCount}
    Comment    @{ExcelColumns}    Get Column Values    Sheet1    2
    Comment    FOR    ${ExcelColumn}    IN    @{ExcelColumns}
    Comment    LOG    ${ExcelColumn}
    Comment    ${ExcelRow}    Read Cell Data By Coordinates    Sheet1    2    1
    Comment    LOG    ${ExcelRow}

WriteToExcel
    Create Excel Document    My_workbook
    Save Excel Document    C:/Users/nage/Robot clones/RobotFM/My_workbook.xlsx
    Open Excel Document    C:/Users/nage/Robot clones/RobotFM/My_workbook.xlsx    doc_id=My_workbook.xlsx
    Write Excel Cell    1    1    Tiger
    Save Excel Document    C:/Users/nage/Robot clones/RobotFM/My_workbook.xlsx
