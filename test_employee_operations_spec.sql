/* I am going to create a test package by using the utplsql utility

utPLSQL is a Unit Testing framework for Oracle PL/SQL and SQL.

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

     CREATE OR REPLACE PACKAGE TEST_EMPLOYEE_OPERATIONS 
    AS  

       
        PROCEDURE add_employee_normal_case;

        PROCEDURE add_employee_negative_case;
        
        PROCEDURE update_emp_sal_normal;

        PROCEDURE update_emp_sal_invalid;

        PROCEDURE update_emp_sal_emp_not_exists;

        PROCEDURE transfer_employee_normal;

        PROCEDURE transfer_employee_dep_notexists;
        
        PROCEDURE transfer_employee_emp_notexists;
      
        PROCEDURE find_employee_sal_normal;

        PROCEDURE find_employee_sal_emp_notexists;

    END;
