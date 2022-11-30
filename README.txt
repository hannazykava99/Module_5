User creation: for testing purpose test_user should be created (need to create test login first, then test_user for "TRN" database with Password)
Restart MS SQL server after user creation

Setup connection: for connecting to SQL Server pymssql module is used:
For this module install Python 3.7(!)
Run the following command in your command line:
-- pip install -U pip
-- pip install pymssql
To get access to your database check and enter your credentials in "*** Variables ***" section

Installing Robot Framework with pip is simple:
-- pip install robotframework
Installing Database utility library for Robot Framework:
-- pip install robotframework-databaselibrary
Documentation: https://franz-see.github.io/Robotframework-Database-Library/api/0.5/DatabaseLibrary.html

Run the following command in your command line to execute file with test cases:
-- robot -d  output robot_homework.robot

Test Report "report.html" is generated in output/ folder

new line

