USE [SqlTraining]
GO

/****** Object:  Table [dbo].[employees]    Script Date: 08-07-2015 11:33:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[employees](
	[employee_id] [int] NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[first_name] [varchar](50) NULL,
	[designation] [varchar](50) NULL,
	[salary] [money] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


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
ORDER BY salary DESC;


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
SELECT TOP 3* FROM employees
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
SELECT emp.salary,emp.employee_id,emp.last_name,emp.first_name,emp.age,
es.EMPLOYEE_ID 
FROM EMPLOYEE_SLAB es INNER JOIN employees emp ON emp.employee_id=es.EMPLOYEE_ID;




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
CREATE DATABASE BACKUP_DB;

use [SqlTraining]
SELECT * 
INTO [BACKUP_DB]..[Employee_Backup123]
FROM [Employee_Backup123]



--question 22 (27. SQL Create DB)

CREATE DATABASE NEW_DB;

--question 23 (28. SQL Create Table)

CREATE TABLE EMPLOYEE_NEW
(EMPLOYEE_ID int, F_NAME varchar(50), L_NAME varchar(50), SEX varchar(1), STATUS bit);

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

--question 28 (33.SQL Foreign Key )
CREATE TABLE NEWTABLE
(EMPLOYEE_ID int primary key, F_NAME varchar(50), L_NAME varchar(50), SEX varchar(2), STATUS bit);
CREATE TABLE NEWTABLE_Fkey
(ID int primary key, NUM int FOREIGN KEY REFERENCES NEWTABLE(EMPLOYEE_ID) );
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
CREATE TABLE Designation
(EMPLOYEE_ID varchar(50) PRIMARY KEY, 
EMPLOYEE_NAME varchar(50) UNIQUE,
 TEAM_NAME varchar(50) NOT NULL DEFAULT 'MY TEAM',
 CHECK (EMPLOYEE_ID>0));
DROP TABLE Designation;

--question 32 (37. SQL Create Index)
CREATE UNIQUE INDEX MY_INDEX
ON employees (first_name,last_name);

--question 33 (38. SQL ALTER)

 use SqlTraining;
ALTER TABLE EMPLOYEE
ALTER COLUMN TEAM_NAME int;

--question 34 (39. SQL Increment)

update employees set salary=salary+5000;

--question 35 (40. SQL Views)

ALTER TABLE employees add date_joining date;
CREATE VIEW AS 
SELECT date_joining from employees 
where salary>40000;

--question 36 (41. SQL Dates)
select GETDATE() as currentDate from employees;
select GETDATE()+2 as currentDate from employees;
--question 37 (42. SQL Nulls)
SELECT COUNT(salary) from employee;
--question 38 (43. SQL isnull())
use SqlTraining;
SELECT * FROM employees
WHERE last_name IS NULL
 
--question 39 (46. SQL SQL avg())
SELECT * FROM employees
WHERE (salary > (select avg(salary) from employees));
--question 40 (47. SQL count())

--question 41 (48. SQL max())

SELECT * FROM employees
WHERE (salary < (select max(salary) from employees));

--question 42 (49. SQL min())

SELECT * FROM employees
WHERE (salary > (select min(salary) from employees));

--question 43 (50. SQL sum())

SELECT SUM(salary) FROM employees;

--question 44 (51. SQL Group By)

SELECT designation,COUNT(last_name) FROM employees group by designation;

--question 45 (52. SQL Having)

SELECT LMN.EMPLOYEE_NO, COUNT(employees.salary) AS NUMBER FROM employees 
INNER JOIN LMN
ON LMN.EMPLOYEE_NO=employees.employee_id
where EMPLOYEE_ID=1
 group by EMPLOYEE_NO having LMN.EMPLOYEE_NO>10000;

--question 46 (53. SQL upper())
SELECT Upper(last_name) from employees;

--question 47 (54. SQL lower())
SELECT Lower(last_name) from employees;


--question 50 (55. SQL len())

SELECT len(first_name) AS Length_of_first_Name from employees;



--question 56(SQL ROUND())
SELECT firstname, lastname,ROUND(salary,0) as roundedsalary from employee;

--question 57(SQL GETDATE())
SELECT *,GETDATE() as currentDate from employee;

--question 58(SQL CONVERT())
SELECT firstname,salary,CONVERT(VARCHAR(19),GETDATE(),3) as today from employee;

--question 59(CAST())
SELECT CAST(e_id AS varchar(10)) from employee;



--question 56 (60.Case Statements)

SELECT employee_id,
CASE
  WHEN employee_id = 1 THEN 'Tea'
  WHEN employee_id = 2 THEN 'Check'
  ELSE 'Big'
END
FROM employees;


