CREATE OR REPLACE PACKAGE EMPLOYEE_OPERATIONS 
AS  
    /* The procedure add_employee is too create a record in employee table */
    PROCEDURE add_employee(e_id number, e_name varchar2, e_jobtitle varchar2, e_manager_id number, e_salary number, 
    e_departmentid number, e_datehired date);
    
    /* The procedure update_employee_sal is to increment or decrement salary of an employee by the PERCENTAGE
     the update_ind is either an I for increment or D for decrement*/
    PROCEDURE update_employee_sal(e_id employee.employee_id%type, update_ind varchar2, percentage number);

    /*The procedure transfer_employee is to transfer an employee to the department id mentioned in to_department */
    PROCEDURE transfer_employee(e_id employee.employee_id%type, to_department department.department_id%type);
    
    /*The procedure find_employee_sal is to find the salary of given employee */
    PROCEDURE find_employee_sal(e_id employee.employee_id%type);

END;


CREATE OR REPLACE PACKAGE BODY EMPLOYEE_OPERATIONS 
AS

    /* The procedure add_employee is too create a record in employee table */
    PROCEDURE add_employee(e_id number, e_name varchar2, e_jobtitle varchar2, e_manager_id number, e_salary number, 
    e_departmentid number, e_datehired date);
    
    /* The procedure update_employee_sal is to increment or decrement salary of an employee by the PERCENTAGE
     the update_ind is either an I for increment or D for decrement*/
    PROCEDURE update_employee_sal(e_id employee.employee_id%type, update_ind varchar2, percentage number);

    /*The procedure transfer_employee is to transfer an employee to the department id mentioned in to_department */
    PROCEDURE transfer_employee(e_id employee.employee_id%type, to_department department.department_id%type);
    
    /*The procedure find_employee_sal is to find the salary of given employee */
    PROCEDURE find_employee_sal(e_id employee.employee_id%type);


END;