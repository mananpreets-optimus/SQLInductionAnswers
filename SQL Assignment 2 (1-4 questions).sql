--1 Create TABLES


--CREATE TABLE t_product_master

CREATE TABLE t_product_master 
(Product_ID varchar(50) PRIMARY KEY, 
Product_Name varchar(50),
Cost_Per_Item int );

--INSERTION 


INSERT INTO t_product_master
(Product_ID, 
Product_Name,
Cost_Per_Item) VALUES
('P1','Pen',10);
INSERT INTO t_product_master
(Product_ID, 
Product_Name,
Cost_Per_Item) VALUES
('P2','Scale',15);
INSERT INTO t_product_master
(Product_ID, 
Product_Name,
Cost_Per_Item) VALUES
('P3','Note Book',25);
SELECT * FROM t_product_master;



--CREATE TABLE t_user_master


CREATE TABLE t_user_master 
(User_ID varchar(50) PRIMARY KEY, 
User_Name varchar(50));

--INSERTION 


INSERT INTO t_user_master
(User_ID, 
User_Name) VALUES
('U1','Alfred Lawrence');
INSERT INTO t_user_master
(User_ID, 
User_Name) VALUES
('U2','William Paul');
INSERT INTO t_user_master
(User_ID, 
User_Name) VALUES
('U3','Edward Fillip');

SELECT * FROM t_user_master;

CREATE TABLE t_transaction 
(User_ID varchar(50), 
Product_ID varchar(50),
FOREIGN KEY(Product_ID) REFERENCES t_product_master(Product_ID),
Transaction_Date date,
Transaction_Type varchar(50),
Transaction_Amount int);


INSERT INTO t_transaction
(User_ID, 
Product_ID,
Transaction_Date,
Transaction_Type,
Transaction_Amount) VALUES
('U1','P1','2010-11-20','Order','150');
('U1','P1','2010-11-20','Payment','750'),
('U1','P1','2010-11-20','Order','200'),
('U1','P3','2010-11-25','Order','50'),
('U3','P2','2010-11-26','Order','100'),
('U2','P1','2010-10-15','Order','75'),
('U3','P2','2010-01-15','Payment','250');



--2nd QUESTION

use SQLAssignment;

SELECT t_user_master.User_Name,t_product_master.Product_Name,
SUM(
CASE
  WHEN Transaction_Type='Order' THEN (t_transaction.Transaction_Amount)
  ELSE 0 END) AS Ordered_Quantity,
  SUM(
CASE
  WHEN Transaction_Type='Payment' THEN (t_transaction.Transaction_Amount)
  ELSE 0 END) AS Amount_Paid,
  MAX(t_transaction.Transaction_Date) AS Last_Transaction_Date,
  (sum(
	CASE 
		WHEN Transaction_Type='Order'THEN  t_product_master.Cost_Per_Item*t_transaction.Transaction_Amount 
		ELSE 0 END)- 
		sum(
			CASE WHEN Transaction_Type='Payment'
			THEN  t_transaction.Transaction_Amount 
			ELSE 0 
			END)) 
		as Balance 
		from ((t_transaction INNER JOIN t_user_master 
		ON t_transaction.User_ID=t_user_master.User_ID) INNER JOIN t_product_master
		ON t_transaction.Product_ID=t_product_master.Product_ID)
		GROUP BY
		 t_user_master.User_Name,t_product_master.Product_Name ;



--3rd CREATION OF TABLES

CREATE TABLE t_emp
(Emp_id INT IDENTITY(1001,2) PRIMARY KEY NOT NULL,
Emp_Code VARCHAR(20),
Emp_f_name VARCHAR(50) NOT NULL,
Emp_m_name VARCHAR(50),
Emp_l_name VARCHAR(50),
Emp_DOB DATE,
Emp_DOJ DATE NOT NULL);


--INSERTION

INSERT INTO t_emp(Emp_Code,Emp_f_name,Emp_m_name,Emp_l_name,Emp_DOB,Emp_DOJ)
VALUES
('OPT20110105','Manmohan','','Singh','1983-02-10','2010-05-25'),
('OPT20100915','Alfred','Joseph','Lawrence','1988-02-28','2010-06-22'),
('OPT20110189','Manmohan','Paul','Singh','1983-07-1','2010-05-25'),
('OPT20110190','Manmohan','Raj','Singh','1987-05-16','2010-05-25'),
('OPT20110188','Manmohan','Raj','Singh','1983-09-19','2010-05-25');

SELECT * FROM t_emp;

CREATE TABLE t_activity
(Activity_id INT PRIMARY KEY,
Activity_description VARCHAR(50)
);
INSERT INTO t_activity(Activity_id,Activity_description)
VALUES
(1,'Code Analysis'),
(2,'Lunch'),
(3,'Coding'),
(4,'Knowledge Transition'),
(5,'Database');
SELECT * FROM t_activity;

CREATE TABLE t_salary
(Salary_id INT,
Emp_Id INT,
Changed_date DATE,
New_Salary INT);
INSERT INTO t_salary
(Salary_id,Emp_Id,Changed_date,New_Salary)--2010-11-20
VALUES
(1001,1003,'2011-2-16',20000),
(1002,1003,'2011-1-05',25000),
(1003,1001,'2011-2-16',26000);

--4 a)

SELECT Emp_f_name,Emp_m_name, Emp_l_name, Emp_DOB FROM t_emp WHERE 
(
(MONTH(Emp_DOB)  IN (1,3,5,7,8,10,12)) AND (DAY(Emp_DOB) IN (31))
OR
(MONTH(Emp_DOB)  IN (4,6,9,11)) AND (DAY(Emp_DOB) IN (30))
OR
(MONTH(Emp_DOB)  IN (2)) AND (DAY(Emp_DOB) IN (28))
);


--4 B)


SELECT *
FROM
(
SELECT DISTINCT 
 
 CASE 
							WHEN Emp_m_name IS NULL 
							THEN Emp_f_name+''+Emp_l_name
							ELSE
							Emp_f_name+Emp_m_name+Emp_l_name
							END  AS name

							,
 
 
 year(t_atten_det.Atten_start_datetime) as [year],
  datename(month,t_atten_det.Atten_start_datetime) as [month], datename(day,t_atten_det.Atten_start_datetime) as [day] , 
  t_atten_det.Atten_end_hrs AS hrs FROM t_emp INNER JOIN t_atten_det ON t_emp.Emp_id=t_atten_det.Emp_id)l
PIVOT
(
SUM(l.hrs) FOR [day] IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],
[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31])
)pvt;

-- 4 C)Display employee full name, got increment in salary?, previous salary, current salary, total worked hours , last worked activity and hours worked in that.
SELECT  t_emp.Emp_f_name,
  
  (CASE 
   WHEN (MAX(t_salary.New_Salary)-MIN(t_salary.New_Salary))>0 
   THEN 'YES' ELSE 'NO' END) 
   AS got_increment_in_salary,
  min(t_salary.New_Salary) AS previous_salary,
  max(t_salary.New_Salary) AS current_salary ,
  s.ss AS total_worked_hours,
  p.pp AS last_worked_activity
FROM t_salary 
LEFT JOIN t_emp ON t_salary.Emp_Id=t_emp.EMP_id 
LEFT JOIN t_atten_det ON t_salary.Emp_Id=t_atten_det.Emp_id 
LEFT JOIN t_activity ON t_activity.Activity_id=t_atten_det.Activity_id  
LEFT JOIN (SELECT Emp_id, sum(atten_end_hrs) ss FROM t_atten_det group by Emp_id) s 
ON s.Emp_id=t_emp.EMP_id 
LEFT JOIN (select Emp_id,MAX(Activity_id) pp FROM t_atten_det GROUP BY Emp_id) p 
ON p.Emp_id=t_emp.EMP_id
group by t_emp.Emp_f_name,t_atten_det.Emp_Id,s.ss,p.pp;


