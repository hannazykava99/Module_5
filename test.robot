*** Settings ***

Library  DatabaseLibrary

Suite Setup     Connect To Database   pymssql  ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown  Disconnect From Database


*** Variables ***

${DBName}  TRN
${DBUser}  TestLogin
${DBPass}  1234
${DBHost}  192.168.1.7
${DBPort}  1433





#*** Settings ***
#Suite Setup  Connect To Database Using Custom Params   pyodbc   ${DBHost_ConnectionString}
#Suite Teardown  Disconnect From Database
#Library  DatabaseLibrary
#Library  String
#Library  OperatingSystem
#*** Variables ***
#${DBHost_ConnectionString}    Driver='SQL Server', Server='EPBYMINW0EE0\\SQLEXPRESS03', Database='TRN', Trusted_Connection='yes', UID='testuser', PWD='password12345'

*** Test Cases ***
Test 1. Jobs: Verify a table exists or not
    [Tags]  AUTO-01
    [documentation]
    ...  |*Test Steps:*
    ...  |1. Connect to DB
    ...  |2. Check the existence of table in this DB
    ...  |
    ...  | *Expected result:*
    ...  | Table 'jobs' exists in DB
    Table Must Exist  jobs

Test 2. Jobs: Find out about the existense of following position - Programmer
    [Tags]  AUTO-02
    [documentation]
    ...  |*Test Steps:*
    ...  |1. Connect to DB
    ...  |2. Execute the sql quiery - 'select job_id from hr.jobs where job_title='Programmer';'
    ...  |
    ...  | *Expected result:*
    ...  | The result will be - job_id=9
    ...  | If there are no results, then this will throw an AssertionError.
    Check if exists in Database  select job_id from hr.jobs where job_title='Programmer';

Test 3. Jobs: Find out the position with the highest salary
    [Tags]  AUTO-03
    [documentation]
    ...  |*Test Steps:*
    ...  |1. Connect to DB
    ...  |2. Execute the sql quiery - 'select TOP 1 job_title,max(max_salary) as maximum from hr.jobs group by job_title order by maximum desc;'
    ...  |
    ...  | *Expected result:*
    ...  | The result will be - (President, 40000)
    @{queryResults}=  query  select TOP 1 job_title,max(max_salary) as maximum from hr.jobs group by job_title order by maximum desc;
    Log To Console  @{queryResults}

Test 4. Jobs: Check the count of rows in table 'jobs' with min_salary=4000,it is equal to 3
    [Tags]  AUTO-04
    [documentation]
    ...  |*Test Steps:*
    ...  |1. Connect to DB
    ...  |2. Execute the sql quiery - 'select * from hr.jobs where min_salary=4000;'
    ...  |
    ...  | *Expected result:*
    ...  | The quantity with min_salary=4000 will be - 3
    Row Count Is Equal To X  select * from hr.jobs where min_salary='4000';  3

Test 5. Employees: Count of rows in table
    [Tags]  AUTO-05
    [documentation]
    ...  |*Test Steps:*
    ...  |1. Connect to DB
    ...  |2. Execute the sql quiery - 'select count(*) from hr.employees;'
    ...  |
    ...  | *Expected result:*
    ...  | The count of rows will be 40
    ${rowCount}=    query    select count(*) from hr.employees;
    Log To Console	   ${rowCount}

Test 6. Employees: Content of table
    [Tags]  AUTO-06
    [documentation]
    ...  |*Test Steps:*
    ...  |1. Connect to DB
    ...  |2. Execute the sql quiery - 'select * from hr.employees;'
    ...  |
    ...  | *Expected result:*
    ...  | Table with the values in rows
    @{QueryResult}  Query   select * from hr.employees
    Log Many    @{QueryResult}

Test 7. Employees: Average salary for all employees
    [Tags]  AUTO-07
    [documentation]
    ...  |*Test Steps:*
    ...  |1. Connect to DB
    ...  |2. Execute the sql quiery - 'SELECT sum(salary)/count(*) as average_salary FROM hr.employees;'
    ...  |
    ...  | *Expected result:*
    ...  | Average value of salary for all employees should be 8060
    @{AverageResult}  Query   SELECT sum(salary)/count(*) as average_salary FROM hr.employees;
    Log To Console    @{AverageResult}

Test 7. Employees: The quantity of Employees whose length of name will be equal to 3
    [Tags]  AUTO-08
    [documentation]
    ...  |*Test Steps:*
    ...  |1. Connect to DB
    ...  |2. Execute the sql quiery - 'select count(*) from hr.employees where len(first_name)<4;'
    ...  |
    ...  | *Expected result:*
    ...  | The quantity of Employees, whose length of name will be equal to 3, is 4
    Row Count Is less than X  select count(*) from hr.employees where len(first_name)<4;    4
