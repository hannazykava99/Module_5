*** Settings ***

Library  DatabaseLibrary

Suite Setup     Connect To Database   pymssql  ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown  Disconnect From Database

*** Variables ***

${DBName}  TRN
${DBUser}  TestLogin
${DBPass}  1234
${DBHost}  192.168.1.6
${DBPort}  1433

*** Test Cases ***

Prerequisite №1. Check that 3 tables (jobs, locations, employees) exist
# Expected result: tables exist
    Table Must Exist  jobs
    Table Must Exist  locations
    Table Must Exist  employees

Prerequisite №2. Check that 3 tables (jobs, locations, employees) are not empty
# Expected result: tables are not empty
    Row Count Is Greater Than X	select * from hr.jobs	0
    Row Count Is Greater Than X	select * from hr.locations	0
    Row Count Is Greater Than X	select * from hr.employees	0

TC №1. Check that table "Jobs" has 4 columns
# Expected result: 4 (four columns)
    Row Count Is Equal to X	select distinct column_name from INFORMATION_SCHEMA.COLUMNS where table_name = 'Jobs'	4

TC №2. Check that table "Jobs" has record where job_title is 'Programmer'
# Expected result: 1 (one distinct row with job_title = 'Programmer')
    Check If Exists In Database	select job_title from hr.jobs where job_title = 'Programmer'

TC №3. Check that table "Locations" has column 'postal_code'
# Expected result: 1 (one column 'postal_code')
    Check If Exists In Database	select column_name from INFORMATION_SCHEMA.COLUMNS where table_name = 'Locations' and Column_name = 'postal_code'

TC №4. Check that table "Locations" doesn't contain duplicates by field "street_address"
# Expected result: 0 (no duplicates)
    Row Count Is Equal to X	select street_address, count(*) from hr.locations group by street_address having count(*) > 1	0

TC №5. Calculate max, min and avg of salary from "Employees" table
# Expected result: calculated min, max and avarage salary
    ${queryResults}	Query	select round(max(salary),2), round(min(salary),2), round(avg(salary),2) from hr.employees
    Log	Max salary is ${queryResults[0][0]}, mix salary is ${queryResults[0][1]} and avarage salary is ${queryResults[0][2]} among employees

TC №6. Check that column "Email" doesn't contain NULLs in "Employees" table
# Expected result: 0 (no NULLS)
    Row Count Is Equal to X	select * from hr.employees where email is null	0
    
TC №7. Check that column "last_name" doesn't contain NULLs in "Employees" table
# Expected result: 0 (no NULLS)
    Row Count Is Equal to X	select * from hr.employees where last_name is null	0
    
TC №8. Check that column "first_name" doesn't contain NULLs in "Employees" table
# Expected result: 0 (no NULLS)
    Row Count Is Equal to X	select * from hr.employees where first_name is null	0

TC №10. Check that column "first_name" doesn't contain NULLs in "Employees" table
# Expected result: 0 (no NULLS)
    Row Count Is Equal to X	select * from hr.employees where first_name is null	0

    



