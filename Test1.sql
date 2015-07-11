USE Test1;

--CREATE TABLE 
CREATE TABLE Department(DeptID int PRIMARY KEY,DeptName VARCHAR(50),DeptHeadID int);
--
CREATE TABLE Employee(Id INT PRIMARY KEY, Name VARCHAR(50),Gender VARCHAR(50), 
Basic INT,HR INT,DA INT,TAX INT,DeptID INT
FOREIGN KEY REFERENCES Department(DeptID));
--
CREATE TABLE EmployeeAttendance
(
EmpID INT,
Atten_Date DATE,
WorkingDays INT,
PresentDays INT,
FOREIGN KEY(EmpID) REFERENCES Employee(Id)
);
--INSERTION INTO TABLE
INSERT INTO Employee(Id,Name,Gender,Basic,HR,DA,TAX,DeptID)
VALUES
(1,'Anil','Male',10000,5000,1000,400,1),
(2,'Sanjana','Female',12000,6000,1000,500,2),
(3,'Johnny','Male',5000,2500,500,200,3),
(4,'Suresh','Male',6000,3000,500,250,1),
(5,'Anglia','Female',11000,5500,1000,500,4),
(6,'Saurabh','Male',12000,6000,1000,600,1),
(7,'Manish','Male',10000,5000,1000,400,2),
(8,'Neeraj','Male',5000,2500,500,200,3),
(9,'Suman','Female',5000,2500,500,200,4),
(10,'Tina','Female',6000,3000,500,220,1);
--

INSERT INTO Department VALUES(1,'HR',1);
INSERT INTO Department VALUES(2,'Admin',2);
INSERT INTO Department VALUES(3,'Sales',9);
INSERT INTO Department VALUES(4,'Engineering',5);
--
INSERT INTO EmployeeAttendance
VALUES(1,'2010-01-01',22,21),
(1,'2010-02-01',20,20),
(1,'2010-03-01',22,20),
(2,'2010-01-01',22,22),
(2,'2010-02-01',20,20),
(2,'2010-03-01',22,22),
(3,'2010-01-01',22,21),
(3,'2010-02-01',20,20),
(3,'2010-03-01',22,21),
(4,'2010-01-01',22,21),
(4,'2010-02-01',20,19),
(4,'2010-03-01',22,22),
(5,'2010-01-01',22,22),
(5,'2010-02-01',20,20),
(5,'2010-03-01',22,22),
(6,'2010-01-01',22,21),
(6,'2010-02-01',20,20),
(6,'2010-03-01',22,20),
(7,'2010-01-01',22,21),
(7,'2010-02-01',20,20),
(7,'2010-03-01',22,21),
(8,'2010-01-01',22,21),
(8,'2010-02-01',20,20),
(8,'2010-03-01',22,21),
(9,'2010-01-01',22,22),
(9,'2010-02-01',20,20),
(9,'2010-03-01',22,21),
(10,'2010-01-01',22,22),
(10,'2010-02-01',20,20),
(10,'2010-03-01',22,22);

--1

SELECT D.DeptName,E.Gender,COUNT(*) AS No_Of_Employees 
FROM Employee E INNER JOIN Department D ON E.DeptID=D.DeptID GROUP BY D.DeptName,E.Gender;

--2
SELECT D.DeptID,COUNT(*) AS No_Of_Employees, MAX(E.Basic+E.DA+E.HR-E.TAX) AS Highest_Gross_Salary, 
SUM(E.Basic+E.DA+E.HR-E.TAX)
FROM Employee E INNER JOIN Department D ON E.DeptID=D.DeptID GROUP BY D.DeptID;

--3

SELECT DeptName,Name,K.P AS Highest_Gross_Salary
FROM Employee 
INNER JOIN
Department
ON Employee.DeptId=Department.DeptID
INNER JOIN(SELECT DeptID,Max(Basic+HR+DA) AS P
FROM Employee
GROUP BY DeptID) AS K
ON Employee.DeptID=b.DeptID
WHERE (Basic+HR+DA)=K.P;

--4
SELECT Id,Name FROM Employee WHERE (Basic+DA+HR-TAX)>15000;

--5 

SELECT ID, Name FROM EMPLOYEE 
WHERE BASIC IN (SELECT MIN(BASIC) FROM Employee 
WHERE BASIC IN(SELECT DISTINCT TOP 2 BASIC FROM Employee ORDER BY Basic DESC))


--6
SELECT D.DeptName, T.tt as No_Of_Employees FROM Employee E INNER JOIN Department D ON E.DeptID=D.DeptID
INNER JOIN (
SELECT DeptID,COUNT(DeptID) tt FROM Employee group by DeptID 
) T
ON E.DeptID=T.DeptId
where T.tt>3
GROUP BY D.DeptName,E.DeptID,T.tt;


--7
SELECT D.DeptName,E.Name FROM Employee E LEFT OUTER JOIN Department D ON D.DeptID=E.DeptID
WHERE D.DeptHeadID=E.Id;

--8 

SELECT E.Id,E.Name FROM Employee E INNER JOIN 
(SELECT EmpID,sum(workingDays)-sum(PresentDays) 
AS D FROM EmployeeAttendance GROUP BY EmpID) AS FUL ON E.Id=FUL.EmpID WHERE D=0;


-----

--9
-----------------------------------------------------
SELECT  DISTINCT Name
FROM Employee
INNER JOIN
EmployeeAttendance
ON Employee.Id=EmployeeAttendance.EmpID
INNER JOIN
(SELECT SUM(PresentDays) AS ol,EmpID
FROM EmployeeAttendance
GROUP BY EmpID) AS po
ON Employee.Id=po.EmpID
Where  po.ol=(SELECT MIN(e.f)
From Employee inner join(SELECT SUM(PresentDays) AS f,EmpID
FROM EmployeeAttendance
GROUP BY EmpID) AS e
ON Employee.Id=e.EmpID);
-----------------------------------------------------




--10
SELECT E.Id,E.Name FROM Employee E INNER JOIN 
(SELECT EmpID,sum(workingDays)-sum(PresentDays) 
AS D FROM EmployeeAttendance GROUP BY EmpID) AS FUL ON E.Id=FUL.EmpID WHERE D>3;