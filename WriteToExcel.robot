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
WriteToExcel
    Create Excel Document    My_workbook
    Save Excel Document    C:/Users/nage/Robot clones/RobotFM/My_workbook.xlsx
    Open Excel Document    C:/Users/nage/Robot clones/RobotFM/My_workbook.xlsx    doc_id=My_workbook.xlsx
    Write Excel Cell    1    1    write some text to excel file
    Save Excel Document    C:/Users/nage/Robot clones/RobotFM/My_workbook.xlsx
