/* I am going to create a test package by using the utplsql utility
For installing this please refer to 
 http://utplsql.org/utPLSQL/v3.0.1/userguide/install.html

 Additional info

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

CREATE OR REPLACE PACKAGE BODY TEST_EMPLOYEE_OPERATIONS 
    AS  
        e_id number := 900012;
        e_name varchar2(50) := 'ABC';
        e_jobtitle varchar2(50) := 'Engineer';
        e_manager_id number := 90003;
        e_datehired date := SYSDATETIME;
       e_salary number := 50000;
       e_departmentid number := 3;

        PROCEDURE add_employee_normal_case AS
        insert into employee (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) values 
    (e_id,e_name,e_jobtitle,e_manager_id,to_date(e_datehired,'dd/mm/yy'), e_salary,e_departmentid);

        PROCEDURE add_employee_negative_case AS
        ut.expect( employee_operation.add_employee(90001,'John Smith','CEO',null, 100000, 1, to_date('01/01/95','dd/mm/yy')).to_equal('The employee already exists.'); 
        
        /* PROCEDURE update_emp_sal_normal AS
        ut.expect( employee_operation.update_employee_sal(90001,'D',100) ).to_equal(''); */

        PROCEDURE update_emp_sal_invalid
        ut.expect( employee_operation.update_employee_sal(90001,'D',100) ).to_equal('The salary cannot be updated.'); 

        PROCEDURE update_emp_sal_emp_not_exists AS
        ut.expect( employee_operation.update_employee_sal(90002341,'D',5) ).to_equal('The employee does not exist.');

        /* PROCEDURE transfer_employee_normal AS
        ut.expect( employee_operation.transfer_employee(90003,4)).to_equal(''); */

        PROCEDURE transfer_employee_dep_notexists AS
        ut.expect( employee_operation.transfer_employee(90008,32) ).to_equal('The department does not exist.');
        
        PROCEDURE transfer_employee_emp_notexists AS
        ut.expect( employee_operation.transfer_employee(9000761,3) ).to_equal('The employee does not exist.');
      
        PROCEDURE find_employee_sal_normal AS
        ut.expect( employee_operation.find_employee_sal(90001)).to_equal(100000);

        PROCEDURE find_employee_sal_emp_notexists AS
        ut.expect( employee_operation.find_employee_sal(9000761) ).to_equal('The employee does not exist.');

    END;



begin
  ut.run();
end;
/