# LDMS

# I have added the table scripts in the file 

# table_scripts.sql

# It contains the table creation script and the insert statements. This needs to be executed first.

# The package.sql contains the solution for 3,4,5,6. 

# 3. Create an appropriate executable database object to allow an Employee to be created 
#  I have created the procedure employee_operations.add_employee(e_id number, e_name varchar2, e_jobtitle varchar2, e_manager_id number, e_salary number, 
 #        e_departmentid number, e_datehired date)

# This procedure takes the following parameters as input and be called like this
BEGIN
EMPLOYEE_OPERATIONS.add_employee(90011,'Khyati Ghatalia','Engineer',null, 60000, 3,to_date('01/01/15','dd/mm/yy'));
END;


#  4. Create an appropriate executable database object to allow the Salary for an
#  Employee to be increased or decreased by a percentage. the second parameter is I or D (I for increment and D for decrement) I used the following code to unit test

BEGIN
EMPLOYEE_OPERATIONS.update_employee_sal(90011,'I',20);
END;


#  5. Create an appropriate executable database object to allow the transfer of an
#  Employee to a different Department. I used the following code to unit test

BEGIN
EMPLOYEE_OPERATIONS.transfer_employee(90011,4);
END;

#  6. Create an appropriate executable database object to return the Salary for an
#  Employee.
# I did the unit test with the following code 
declare
sal number;
BEGIN
select EMPLOYEE_OPERATIONS.find_employee_sal(90011) into sal from dual;
dbms_output.put_line(sal);
END;


# For 7 and 8 I have created an apex screen in apex 20.0 and added an export here. I have created 2 pages one for each report which can be navigated through homepage. The filename is LDMS_REPORT.sql. This can be imported to be viewed.


# I have added the UTPLSQL code as well in the file test_employee_operations.sql

