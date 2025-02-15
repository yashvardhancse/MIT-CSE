SQL> -- create a table employee with emp_no, emp_name, emp_address
SQL> CREATE TABLE employee(
  2  emp_no NUMBER(5),
  3  emp_name VARCHAR(100) NOT NULL,
  4  emp_address VARCHAR(150));

Table created.

SQL> --2 five employees information

SQL> INSERT INTO employee(emp_no, emp_name, emp_address) VALUES(1,'Shreem', 'Noida');

1 row created.

SQL> INSERT INTO employee(emp_no,emp_name, emp_address) VALUES(2, 'Yash', 'Manipal');

1 row created.

SQL> INSERT INTO employee(emp_no, emp_name, emp_address) VALUES (3,'Sheen', 'Indirapuram Ghaziabad');

1 row created.

SQL> INSERT INTO employee(emp_no, emp_name, emp_address) VALUES(4, 'Ishan', 'Noida');

1 row created.

SQL> INSERT INTO employee(emp_no, emp_name, emp_address) VALUES(5, 'Shubhendu', 'Patna');

1 row created.

SQL> -- display names of all employees
SQL> SELECT emp_name FROM employee;

EMP_NAME                                                                        
--------------------------------------------------------------------------------
Shreem                                                                          
Yash                                                                            
Sheen                                                                           
Ishan                                                                           
Shubhendu                                                                       

SQL> --4 display all employees from manipal
SQL> SELECT emp_name FROM employee WHERE emp_address='Manipal';

EMP_NAME                                                                        
--------------------------------------------------------------------------------
Yash                                                                            

SQL> -- add a column named salary to employee table
SQL> ALTER TABLE employee ADD salary NUMBER(10);

Table altered.

SQL> UPDATE employee SET salary=150 WHERE emp_no=1;

1 row updated.

SQL> UPDATE employee SET salary=100000000 WHERE emp_no=2;

1 row updated.

SQL> UPDATE employee SET salary=600 WHERE emp_no=3;

1 row updated.

SQL> UPDATE employee SET salary=400 WHERE emp_no=4;

1 row updated.

SQL> UPDATE employee SET salary=50 WHERE emp_no=5;

1 row updated.

SQL> --7 desc
SQL> DESC employee
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 EMP_NO                                             NUMBER(5)
 EMP_NAME                                  NOT NULL VARCHAR2(100)
 EMP_ADDRESS                                        VARCHAR2(150)
 SALARY                                             NUMBER(10)

SQL> --8 delete all employees from mangalore
SQL> DELETE FROM employee WHERE emp_address='Mangalore';

0 rows deleted.

SQL> RENAME employee to employee1;

Table renamed.

SQL> DROP TABLE employee1;

Table dropped.

SQL> spool off
