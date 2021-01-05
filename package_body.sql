
CREATE OR REPLACE PACKAGE BODY EMPLOYEE_OPERATIONS 
AS

    /* The procedure add_employee is too create a record in employee table */
    PROCEDURE add_employee(e_id number, e_name varchar2, e_jobtitle varchar2, e_manager_id number, e_salary number, 
    e_departmentid number, e_datehired date) IS
    emp_exists number;
    BEGIN
    select count(employee_id) into emp_exists from employee where employee_id=e_id;
    if emp_exists =0 then
    insert into employee (employee_id,employee_name,job_title,manager_id,date_hired,salary,department_id) values 
    (e_id,e_name,e_jobtitle,e_manager_id,to_date(e_datehired,'dd/mm/yy'), e_salary,e_departmentid);
    commit;
    ELSE
    raise emp_already_exists;
    end if;
    EXCEPTION -- exception-handling part starts here
    when emp_already_exists THEN
     DBMS_OUTPUT.PUT_LINE('The employee already exists.');
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('The employee does not exist.');
    end add_employee;

    /* The procedure update_employee_sal is to increment or decrement salary of an employee by the PERCENTAGE percent
     the update_ind is either an I for increment or D for decrement*/
    PROCEDURE update_employee_sal(e_id employee.employee_id%type, update_ind varchar2, percent number) IS
        sal number := 0;
        begin
            SELECT  salary INTO  sal FROM employee
             WHERE employee_id = e_id;

             if upper(update_ind)= 'I' THEN
             sal := sal + (sal * (percent/100));
             ELSE if upper(update_ind) = 'D' THEN
             sal := sal - (sal * (percent/100));
             end if;
             end if;

        IF sal > 0 THEN
         UPDATE employee SET salary = sal WHERE employee_id = e_id;
         commit;
        ELSE
         RAISE invalid_salary;
        END IF;
   EXCEPTION  -- exception-handling part starts here
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('The employee does not exist.');
     WHEN invalid_salary THEN
       DBMS_OUTPUT.PUT_LINE('The salary cannot be updated.');
     WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('The employee salary could not be updated.');
    END update_employee_sal;

    /*The procedure transfer_employee is to transfer an employee to the department id mentioned in to_department */
    PROCEDURE transfer_employee(e_id employee.employee_id%type, to_department department.department_id%type) IS
    emp_exists number;
    department_exists number;
    begin
    /* the below logic is to check whether employee exists */
    select count(employee_id) into emp_exists from employee where employee_id=e_id;
    if emp_exists = 1 THEN
        /* the below logic is to test if the department exists */
        select count(department_id) into department_exists from department where department_id=to_department;
        If department_exists = 1 then
        /* Transfer the employee if employee exists and target department exists */
            update employee set department_id=to_department where employee_id=e_id;
            commit;
        ELSE
         raise dept_does_not_exist;
        end if;
        ELSE
        raise emp_does_not_exist;
    end if;


    EXCEPTION  -- exception-handling part starts here
    WHEN dept_does_not_exist THEN
     DBMS_OUTPUT.PUT_LINE('The department does not exist.');
     WHEN emp_does_not_exist THEN
     DBMS_OUTPUT.PUT_LINE('The employee does not exist.');
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('The employee does not exist.');
     WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('The employee could not be transferred.');
    end transfer_employee;
    
    /*The procedure find_employee_sal is to find the salary of given employee */
    FUNCTION find_employee_sal(e_id employee.employee_id%type) RETURN NUMBER IS
    sal number;
    BEGIN
    select salary into sal from employee where employee_id=e_id;
    RETURN sal;
    EXCEPTION  -- exception-handling part starts here
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('The employee does not exist.');
    END find_employee_sal;

END;

