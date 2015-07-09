--INSERTION


INSERT INTO employees
(employee_id,last_name,first_name,designation,salary)
VALUES
(1,'Anderson', 'Sarah','SD',50000),
(2,'Andson', 'James','TD',30000),
(3,'Singh', 'Jacob','TD',60000),
(4,'Kumar', 'Raj','GD',10000),
(5,'Paul', 'Surp','SD',70000);

--question 1 (5. SQL Select)

SELECT last_name,first_name,designation from employees;

--question 2 (6. SQL Distinct)

SELECT DISTINCT designation
FROM employees;

--question 3 (7. SQL Where)

SELECT * FROM employees where salary<20000;


--question 4 (8. SQL And & Or)
--1)AND

use SqlTraining;
SELECT * FROM employees where salary>20000 AND age<35;

--2)OR

use SqlTraining;
SELECT * FROM employees where salary>50000 AND (designation='SD' OR designation='TD');

--question 5 (9. SQL Order By)

use SqlTraining;
SELECT TOP 5* FROM employees
ORDER BY salary;


--question 6 (10. SQL Insert)

INSERT INTO employees
(employee_id,last_name,first_name,designation,salary,age)
VALUES
(1,'Anderson', 'Sarah','SD',50000,44),
(2,'Andson', 'James','TD',30000,66),
(3,'Singh', 'Jacob','TD',60000,77),
(4,'Kumar', 'Raj','GD',10000,55),
(5,'Paul', 'Surp','SD',70000,33);

--question 7 (11. SQL Update)


use SqlTraining;
UPDATE employees
SET designation='Manager', salary=50000
WHERE salary>40000 AND age<35;

--question 8 (12. SQL Delete)


use SqlTraining;
DELETE from employees 
where grade=1 AND designation='Trainee';


--question 9 (14. SQL Top)
--Top3
SELECT TOP 5* FROM employees
ORDER BY salary DESC;

--Second

use SqlTraining;
SELECT MAX(salary) FROM employees
WHERE salary NOT IN (SELECT MAX(salary) FROM employees );

--Third



--question 10 (15. SQL Like)

use SqlTraining;
SELECT salary FROM employees
where first_name LIKE '%Akash%';


--question 11 (16. SQL Wildcards)

--
use SqlTraining;
SELECT salary FROM employees
where first_name LIKE '_ara_';
--
use SqlTraining;
SELECT salary FROM employees
where first_name LIKE '[tys]%';
--


--question 12 (17. SQL In)

use SqlTraining;
SELECT salary FROM employees
where age IN (33,44,55);

--question 13 (18. SQL Between)

SELECT salary from employees 
where salary between 10000 AND 50000;

--question 14 (19. SQL Alias)

SELECT salary AS SAL from employees 
where salary between 10000 AND 50000;

--question 15 (20. SQL Inner Join)

use SqlTraining;
CREATE TABLE EMPLOYEE_SLAB
(EMPLOYEE_ID varchar(50), TEAM_NO varchar(50), TEAM_NAME varchar(50));
INSERT INTO EMPLOYEE_SLAB (EMPLOYEE_ID,TEAM_NO,TEAM_NAME)
 VALUES (1,3,'MACMAN'),
(2,4,'MAMAN'),
(3,5,'ACMAN');
use SqlTraining;
SELECT employees.salary,employees.employee_id,employees.last_name,employees.first_name,employees.age,
EMPLOYEE_SLAB.EMPLOYEE_ID 
FROM EMPLOYEE_SLAB INNER JOIN employees  ON employees.employee_id=EMPLOYEE_SLAB.EMPLOYEE_ID;




--question 16 (21. SQL Inner JOIN)

use SqlTraining;
SELECT employees.salary,employees.employee_id,EMPLOYEE_SLAB.EMPLOYEE_ID 
FROM EMPLOYEE_SLAB INNER JOIN employees  ON employees.employee_id=EMPLOYEE_SLAB.EMPLOYEE_ID;


--question 17 (22. sql LEFT JOIN)

--New Table DEPARTMENT is created.

CREATE TABLE DEPARTMENT
(DEPT int, DEPT_NO int, DEPT_NAME varchar(50));

--Insertion of values into newly created department table. 
 
INSERT INTO DEPARTMENT (DEPT,DEPT_NO,DEPT_NAME)
 VALUES (1,3006,'Java'),
(2,4007,'HR'),
(3,5008,'ACM');

--Alter table employee (column is added) 
 

use SqlTraining;
ALTER TABLE employees 
add dept_no int;
SELECT employees.salary,employees.employee_id,	DEPARTMENT.DEPT_NO 
FROM DEPARTMENT LEFT JOIN employees  ON employees.dept_no=DEPARTMENT.DEPT_NO;


--question 18 (23. sql RIGHT JOIN)

use SqlTraining;
SELECT employees.salary,employees.employee_id,	DEPARTMENT.DEPT_NO 
FROM DEPARTMENT RIGHT JOIN employees  ON employees.dept_no=DEPARTMENT.DEPT_NO;


--question 19 (24. SQL Full Join)


use SqlTraining;

SELECT employees.salary,employees.employee_id,	DEPARTMENT.DEPT_NO 
FROM DEPARTMENT FULL JOIN employees  ON employees.dept_no=DEPARTMENT.DEPT_NO;



--question 20 (25.SQL Union)
use SqlTraining;

CREATE TABLE ABCC
(EMPLOYEE_NO int, EMPLOYEE_NAME varchar(50), DEPT_NO int, DEPT_NAME varchar(50));

--Insertion of values into newly created department table. 
 
INSERT INTO ABC (EMPLOYEE_NO,EMPLOYEE_NAME,DEPT_NO,DEPT_NAME)
 VALUES (1,'RAJ',3006,'Java'),
(2,'SMITH',4007,'HR'),
(3,'KUMAR',5008,'ACM');

CREATE TABLE LMN
(EMPLOYEE_NO int, EMPLOYEE_NAME varchar(50), DEPT_NO int, DEPT_NAME varchar(50));

--Insertion of values into newly created department table. 
 
INSERT INTO LMN (EMPLOYEE_NO,EMPLOYEE_NAME,DEPT_NO,DEPT_NAME)
 VALUES (1,'RÚAJ',3006,'Java'),
(2,'SMOITH',4007,'HR'),
(3,'KUMLLAR',5008,'ACM');

CREATE TABLE XYZ
(EMPLOYEE_NO int, EMPLOYEE_NAME varchar(50), DEPT_NO int, DEPT_NAME varchar(50));

--Insertion of values into newly created department table. 
 

INSERT INTO XYZ (EMPLOYEE_NO,EMPLOYEE_NAME,DEPT_NO,DEPT_NAME)
 VALUES (1,'RAUJ',3006,'Java'),
(2,'SMIBTH',4007,'HR'),
(3,'KUMFAR',5008,'ACM');;


use SqlTraining;
SELECT EMPLOYEE_NAME FROM ABC
UNION
SELECT EMPLOYEE_NAME FROM XYZ
UNION
SELECT EMPLOYEE_NAME FROM LMN
ORDER BY EMPLOYEE_NAME;

--question 21 (26. SQL Select Into)


--question 22 (27. SQL Create DB)


--question 23 (28. SQL Create Table)


--question 24 (29. SQL Constraints)
CREATE TABLE EMPLOYEE1
(EMPLOYEE_ID varchar(50) PRIMARY KEY, 
EMPLOYEE_NAME varchar(50) UNIQUE,
 TEAM_NAME varchar(50) NOT NULL,
 CHECK (EMPLOYEE_ID>0));

--question 25 (30. SQL Not Null)
CREATE TABLE EMPLOYEE2
(EMPLOYEE_ID varchar(50) PRIMARY KEY, 
EMPLOYEE_NAME varchar(50) UNIQUE,
 TEAM_NAME varchar(50) NOT NULL,
 CHECK (EMPLOYEE_ID>0));

--question 26 (31.SQL Unique )
CREATE TABLE EMPLOYEE3
(EMPLOYEE_ID varchar(50) PRIMARY KEY, 
EMPLOYEE_NAME varchar(50) UNIQUE,
 TEAM_NAME varchar(50) NOT NULL,
 CHECK (EMPLOYEE_ID>0));

--question 27 (32.SQL Primary Key )
CREATE TABLE EMPLOYEE4
(EMPLOYEE_ID varchar(50) PRIMARY KEY, 
EMPLOYEE_NAME varchar(50) UNIQUE,
 TEAM_NAME varchar(50) NOT NULL,
 CHECK (EMPLOYEE_ID>0));

--question 28 (33.SQL Foreign Key )?????????????????
CREATE TABLE EMPLOYEE5
(EMPLOYEE_ID varchar(50) PRIMARY KEY, 
EMPLOYEE_NAME varchar(50) UNIQUE,
 TEAM_NAME varchar(50) NOT NULL,
 CHECK (EMPLOYEE_ID>0));

--question 29 (34.SQL Check )
CREATE TABLE EMPLOYEE6
(EMPLOYEE_ID varchar(50) PRIMARY KEY, 
EMPLOYEE_NAME varchar(50) UNIQUE,
 TEAM_NAME varchar(50) NOT NULL,
 CHECK (EMPLOYEE_ID>0));

--question 30 (35. SQL Default)

use SqlTraining;

CREATE TABLE EMPLOYEE15
(EMPLOYEE_ID varchar(50) PRIMARY KEY, 
EMPLOYEE_NAME varchar(50) UNIQUE,
 TEAM_NAME varchar(50) NOT NULL DEFAULT 'MY TEAM',
 CHECK (EMPLOYEE_ID>0));

--question 31 (36. SQL Drop)

DROP TABLE EMPLOYEE15;

--question 32 (37. SQL Create Index)
CREATE UNIQUE INDEX MY_INDEX
ON DEPARTMENT (DEPT,DEPT_NAME);

--question 33 (38. SQL ALTER)

 use SqlTraining;
ALTER TABLE EMPLOYEE
ALTER COLUMN TEAM_NAME int;

--question 34 (39. SQL Increment)

update employees set salary=salary+5000;

--question 35 (40. SQL Views)

--question 36 (41. SQL Dates)

--question 37 (42. SQL Nulls)

--question 38 (43. SQL isnull())
use SqlTraining;
SELECT * FROM employees
WHERE last_name IS NULL
 
--question 39 (44. SQL SQL avg())
SELECT * FROM employees
WHERE (salary > (select avg(salary) from employees));

--question 40 (45. SQL count())

--question 41 (46. SQL max())

SELECT * FROM employees
WHERE (salary < (select max(salary) from employees));

--question 42 (47. SQL min())

SELECT * FROM employees
WHERE (salary > (select min(salary) from employees));

--question 43 (48. SQL sum())

SELECT SUM(salary) FROM employees;

--question 44 (49. SQL Group By)


--question 45 (50. SQL Having)


--question 46 (51. SQL Nulls)


--question 47 (52. SQL Nulls)


--question 48 (53. SQL Nulls)


--question 49 (54. SQL Nulls)


--question 50 (55. SQL len())

SELECT len(first_name) AS Length_of_first_Name from employees;

--question 51 (56. SQL Nulls)


--question 52 (55. SQL Nulls)



--question 53 (57. SQL Nulls)



--question 54 (58. SQL Nulls)



--question 55 (59. SQL cast())



--question 56 (60. SQL Nulls)




