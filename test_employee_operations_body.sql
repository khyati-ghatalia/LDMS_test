
CREATE OR REPLACE PACKAGE BODY TEST_EMPLOYEE_OPERATIONS 
    AS  
        e_id number := 900012;
        e_name varchar2(50) := 'ABC';
        e_jobtitle varchar2(50) := 'Engineer';
        e_manager_id number := 90003;
        e_datehired date := SYSDATE;
        e_salary number := 50000;
        e_departmentid number := 3;

        /* Test to add an employee */ 
        PROCEDURE add_employee_normal_case IS
        BEGIN
        insert into employee (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) values 
        (e_id,e_name,e_jobtitle,e_manager_id,to_date(e_datehired,'dd/mm/yy'), e_salary,e_departmentid);
        commit;
        end;

        /* Test to add an employee which already exists */

        PROCEDURE add_employee_negative_case IS
        BEGIN
            employee_operations.add_employee(90001,'John Smith','CEO',null, 100000, 1, to_date('01/01/95','dd/mm/yy'));
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        EXCEPTION
            WHEN others THEN
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        END;

   
        /* Test to update salary of an employee */

        PROCEDURE update_emp_sal_normal IS
        results      sys_refcursor;
        expected     sys_refcursor;
        not_affected sys_refcursor;
        test_employee number := 90001;
        percent number := 10;
    
        BEGIN
    
            open expected for
            select (salary + (salary * percent/100)) as new_salary
            from employee where employee_id = test_employee;

            open not_affected for
            select * from employees where employee_id <> test_employee;

    
            employee_operations.update_employee_sal(test_employee, 'I',percent);

    
            open results  for
            select salary as new_salary
            from employee where employee_id = test_employee;

            ut.expect( results ).to_( equal( expected ) );

            open results for
            select * from employee where employee_id != test_employee;

            ut.expect( results ).to_( equal( not_affected ) );
        END;


        /* Test to update salary of an employee which is invalid i.e 0 */

        PROCEDURE update_emp_sal_invalid is
        BEGIN
            employee_operations.update_employee_sal(90001,'D',100);
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        EXCEPTION
            when others then
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        end;


        /* Test to update salary of an employee which does not exist */
        PROCEDURE update_emp_sal_emp_not_exists IS
        BEGIN
            employee_operations.update_employee_sal(90002341,'D',5);
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        EXCEPTION
            when others then
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        end;


        /* Test to transfer employee to a department */
        PROCEDURE transfer_employee_normal AS
        
        test_employee number := 90006;
        result_to_department number;
        expected_to_department number := 3;
    
        BEGIN
    
            employee_operations.transfer_employee(test_employee,expected_to_department);

            select department_id into result_to_department
            from employee where employee_id = test_employee;

            ut.expect( result_to_department ).to_equal( expected_to_department ) ;

            
        END;

        /* Test to transfer employee to a department which does not exist */
        PROCEDURE transfer_employee_dep_notexists is 
        BEGIN
            employee_operations.transfer_employee(90008,32);
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        EXCEPTION
            when others then
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        end;
        
        /* Test to transfer employee which does not exist */
        PROCEDURE transfer_employee_emp_notexists is 
        BEGIN
            employee_operations.transfer_employee(9000761,3);
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        EXCEPTION
            when others then
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        end;
      
      /* Test to find salary of an employee which exists */
        PROCEDURE find_employee_sal_normal AS
        result_sal number :=0;
        BEGIN
        select employee_operations.find_employee_sal(90001) into result_sal from dual;
            ut.expect(result_sal).to_equal(100000);
        end;


    /* Test to find salary of an employee which does not exist */
        PROCEDURE find_employee_sal_emp_notexists is 
        BEGIN
            employee_operations.find_employee_sal(9000761);
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        EXCEPTION
            when others then
            ut.expect( sqlcode ).not_to( equal( 0 ) );
        end;
    END;


