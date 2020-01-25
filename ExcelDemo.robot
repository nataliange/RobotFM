*** Settings ***
Library           SeleniumLibrary

*** Variables ***
@{ExcelRows}
@{ExcelColumns}
${ExcelRow}       ${EMPTY}
${ExcelColumn}    ${EMPTY}
${ColCount}       ${EMPTY}

*** Test Cases ***
ReadFromExcel
    Open Excel Document    D:/Robot_framework/Contacts_list.xlsx    doc_id=Contacts_list.xlsx
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
    Comment    Create Excel Workbook    My_workbook
    Comment    Save Excel    My_createc_excel.xls
    Comment    Open Excel    C:/Robot_projects/Demo/My_createc_excel.xls
    Comment    Put String To Cell    My_workbook    0    1    Natalia
    Comment    Save Excel    My_createc_excel_2.xls
    Comment    Put Number To Cell    My_workbook    0    1    123
    Comment    Save Excel    My_createc_excel_2.xls
    Create Excel Document    My_workbook
    Save Excel Document    D:/Robot_framework/My_workbook.xlsx
    Open Excel Document    D:/Robot_framework/My_workbook.xlsx    doc_id=My_workbook.xlsx
    Write Excel Cell    1    1    Natalia
    Save Excel Document    D:/Robot_framework/My_workbook.xlsx
