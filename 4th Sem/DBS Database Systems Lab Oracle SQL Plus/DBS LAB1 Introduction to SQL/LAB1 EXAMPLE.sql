SQL> -- LAB1 EXAMPLE
SQL> -- Data definition language commands DDL
SQL> CREATE TABLE STUDENT(
  2  reg_no NUMBER(5),
  3  stu_name VARCHAR(20),
  4  stu_age NUMBER(5),
  5  stu_dob DATE,
  6  subject1_marks NUMBER(4,2),
  7  -- NUMBER(4,2) means that 4 digits, 2 digits after decimal like 98.75
  8  subject2_marks NUMBER(4,2),
  9  subject3_marks NUMBER (4,1));

Table created.

SQL> INSERT INTO STUDENT VALUES(101,'AAA', 16, '03-jul-88', 80,90,98);

1 row created.

SQL> -- add new column
SQL> ALTER TABLE student ADD(gender char(5));

Table altered.

SQL> ALTER TABLE student DROP COLUMN gender;

Table altered.

SQL> --4 modify datatype of stu_age
SQL> ALTER TABLE student MODIFY(stu_age number(3));
ALTER TABLE student MODIFY(stu_age number(3))
                           *
ERROR at line 1:
ORA-01440: column to be modified must be empty to decrease precision or scale 


SQL> -- to modify the existing column, it should be null, but we had set age as 16 so lets set it as null
SQL> UPDATE student SET stu_age=NULL;

1 row updated.

SQL> ALTER TABLE student MODIFY(stu_age number(3));

Table altered.

SQL> RENAME student to students;

Table renamed.

SQL> -- truncate is a command used to remove all data contained in rows of the table or you can say remove all rows of the table
SQL> TRUNCATE TABLE students
  2  ;

Table truncated.

SQL> -- to delete the table use DROP TABLE students
SQL> -- DML Data Manipulation Languagae commands
SQL> -- list all students
SQL> SELECT* FROM students;

no rows selected

SQL> -- list age of all students with column aliased as 'student_age' rather than 'stu-age
SQL> -- instead of displaying the column name as 'stu_age', it will rather be displayed as 'student_age' in the output
SQL> SELECT stu_age AS student_age FROM student;
SELECT stu_age AS student_age FROM student
                                   *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> -- the error came because we have renamed student to students
SQL> SELECT stu_age AS student_age FROM students;

no rows selected

SQL> -- no rows selected comes because we have just made the table structure and not inserted any values into the rows.
SQL> -- find sum of all three subject marks and name it as tot_marks
SQL> SELECT subject1_marks+subject2_marks+subject3_marks AS tot_marks FROM students;

no rows selected

SQL> INSERT INTO students(reg_no, stu_name) VALUES(102,'Krish');

1 row created.

SQL> -- removal of specified rows
SQL> DELETE FROM students WHERE reg_no=102;

1 row deleted.

SQL> --remove all rows
SQL> DELETE FROM students;

0 rows deleted.

SQL> UPDATE students set stu_name='Manav';

0 rows updated.

SQL> UPDATE students set stu_name='Yadav' where reg_no=101;

0 rows updated.

SQL> spool off
