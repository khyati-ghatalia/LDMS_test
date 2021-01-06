LDMS

I have added the table scripts in the file table_scripts.sql. It contains the table creation script and the insert statements. This needs to be executed first. This is the solution for 

       1. Create the necessary data structures to contain the data specified in the
       Appendix ensuring that data integrity is enforced
       2. Populate the Departments and Employees data structures using the data
       specified in the Appendix



The package_spec.sql and package_body.sql contains the solution for 3,4,5,6. This is a package employee_operations and has 3 procedures and 1 function.
The package spec(file package_spec.sql) needs to be executed first and then the package body (file package_body.sql)
   3. Create an appropriate executable database object to allow an Employee to be created 
    I have created the procedure employee_operations.add_employee(e_id number, e_name varchar2, e_jobtitle varchar2, e_manager_id number, e_salary    number,e_departmentid number, e_datehired date)

This procedure takes the following parameters as input and be called like this
BEGIN
EMPLOYEE_OPERATIONS.add_employee(90011,'Khyati Ghatalia','Engineer',null, 60000, 3,to_date('01/01/15','dd/mm/yy'));
END;


 4. Create an appropriate executable database object to allow the Salary for an Employee to be increased or decreased by a percentage. the second parameter is I or D (I for increment and D for decrement).
 I used the following code to unit test

     BEGIN
     EMPLOYEE_OPERATIONS.update_employee_sal(90011,'I',20);
     END;


 5. Create an appropriate executable database object to allow the transfer of an Employee to a different Department. I used the following code to unit test

     BEGIN
     EMPLOYEE_OPERATIONS.transfer_employee(90011,4);
     END;

 6. Create an appropriate executable database object to return the Salary for an Employee.
 
   I did the unit test with the following code 
      declare
      sal number;
      BEGIN
      select EMPLOYEE_OPERATIONS.find_employee_sal(90011) into sal from dual;
      dbms_output.put_line(sal);
      END;


 For 7 and 8 I have created an apex screen in apex 20.2 and added an export here. I have created 2 pages one for each report which can be navigated through homepage. The filename is LDMS_REPORT.sql. This can be imported to be viewed.More info : https://docs.oracle.com/en/database/oracle/application-express/20.2//htmdb/changes-in-this-release.html#GUID-747B08A2-A680-42EA-87A5-54BDF469E5EE


I have added 3 screenshots of the apex report.


 I have added the UTPLSQL code as well in the file test_employee_operations_spec.sql and test_employee_operations_body.sql
/* utPLSQL is a Unit Testing framework for Oracle PL/SQL and SQL.

For installing this please refer to 
 http://utplsql.org/utPLSQL/v3.0.1/userguide/install.html

 Additional info

 To Run Tests

 To execute using development IDE (TOAD/SQLDeveloper/PLSQLDeveloper/other) use one of following commands.

begin
  ut.run();
end;
/
exec  ut.run();
select * from table(ut.run());
The above commands will run all the suites in the current schema and provide report to dbms_output or as a select statement.


 */
 
 * I havent been able to test my test cases due to a problem in my MAC . Apologies if there are any problems.
