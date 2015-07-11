CREATE TABLE Train_Details
(Train_ID INT PRIMARY KEY,
Train_Name varchar(50));
INSERT INTO Train_Details
(Train_ID, Train_Name)
VALUES (11404,'Shatabdi'),
(22505,'Rajdhani'),
(33606,'Passenger');

select * from Train_Details;

CREATE TABLE Station_Details
(Station_ID INT PRIMARY KEY,
Station_Name VARCHAR(50));
INSERT INTO Station_Details
(Station_ID,Station_Name)
VALUES
(101,'Delhi'),
(102,'Aligarh'),
(103,'Lucknow'),
(104,'Kanpur');

select * from Station_Details;

CREATE TABLE Journey_Details
(Train_ID INT FOREIGN KEY REFERENCES Train_Details(Train_ID),
Station_ID INT FOREIGN KEY REFERENCES Station_Details(Station_ID),
Distance INT, Arrival_GMT DATETIME, Departure_GMT DATETIME);


INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Departure_GMT)
VALUES
(11404,101,0,'1-25-2012 03:00:00');
INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Arrival_GMT)
VALUES
(11404,103,750,'1-25-2012 09:30:00');
INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Departure_GMT)
VALUES
(22505,101,0,'1-25-2012 15:04:00');
INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Arrival_GMT,Departure_GMT)
VALUES
(22505,102,225,'1-25-2012 05:30:00','1-25-2012 06:00:00');
INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Arrival_GMT,Departure_GMT)
VALUES
(22505,104,150,'1-25-2012 07:10:00','1-25-2012 07:50:00');
INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Arrival_GMT)
VALUES
(22505,103,100,'1-25-2012 08:30:00');
INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Departure_GMT)
VALUES
(33606,102,0,'1-25-2012 10:45:00');
INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Arrival_GMT,Departure_GMT)
VALUES
(33606,104,150,'1-25-2012 13:20:00','1-25-2012 13:45:00');
INSERT INTO Journey_Details
(Train_ID,Station_ID,Distance,Arrival_GMT)
VALUES
(33606,103,100,'1-25-2012 17:20:00');
select * from Journey_Details;

--1


SELECT DISTINCT Train_Name, Station_Name,Distance, OD.OC/g.e AS Average_Speed 
FROM Train_Details
INNER JOIN
Journey_Details
ON Train_Details.Train_ID=Journey_Details.Train_ID
INNER JOIN
Station_Details
ON Journey_Details.Station_ID=Station_Details.Station_ID
INNER JOIN 
(SELECT 
		CAST(SUM(Distance) AS FLOAT) AS OC,OH.Train_ID 
FROM Journey_Details OH
GROUP BY OH.Train_ID) AS OD
ON Journey_Details.Train_ID=OD.Train_ID
INNER JOIN
(SELECT 
		(CAST(DATEDIFF(SS,f.OB,f.a) AS FLOAT)/3600.0) AS e, i.Train_ID
FROM Journey_Details i
INNER JOIN
(SELECT MAX(Arrival_GMT) AS a,MIN(Departure_GMT) AS OB, j.Train_ID
FROM Journey_Details j
GROUP BY j.Train_ID) AS f
ON i.Train_ID=f.Train_ID) AS g
ON Journey_Details.Train_ID=g.Train_ID;

--Question 1 Ends


--2 A)
SELECT TOP 1 T_D.Train_Name FROM Train_Details T_D INNER JOIN Journey_Details J_D
ON T_D.Train_ID=J_D.Train_ID 
INNER JOIN
(SELECT Train_ID,SUM(Distance) s FROM Journey_Details GROUP BY Train_ID ) T
ON T.Train_ID=T_D.Train_ID
GROUP BY T_D.Train_Name ORDER BY T_D.Train_Name DESC;
--2 B)
SELECT TOP 1 T.Train_Name FROM Train_Details T
INNER JOIN
(SELECT Train_ID,SUM(Distance) AS TOT_DIST,
DATEDIFF(SS,MIN(Departure_GMT),
MAX(Arrival_GMT)) AS DIFF_DATE 
FROM Journey_Details 
GROUP BY Train_ID)AS FUL ON T.Train_ID=FUL.Train_ID 
ORDER BY FUL.TOT_DIST/FUL.DIFF_DATE;

--2 c)

SELECT T_D.Train_Name FROM Train_Details T_D INNER JOIN Journey_Details J_D
ON T_D.Train_ID=J_D.Train_ID 
INNER JOIN
(SELECT Train_ID,COUNT(Station_ID) s FROM Journey_Details GROUP BY Train_ID ) T
ON T.Train_ID=T_D.Train_ID
WHERE T.s>3
GROUP BY T_D.Train_Name;

--2 D)


SELECT TOP 1 T.Train_Name FROM Train_Details T INNER JOIN
 (SELECT Train_ID,SUM(Distance) 
 AS totaldistance,DATEDIFF(SS,MIN(Departure_GMT),MAX(Arrival_GMT))
 AS DiffDate FROM Journey_Details GROUP BY Train_ID)AS f ON T.Train_ID=f.Train_ID ORDER BY f.totaldistance/f.DiffDate;


--4) 
 
SELECT DISTINCT b.Train_ID,Train_Name,B.A AS Boarding,OD.OC AS Destination
FROM Train_Details
INNER JOIN
Journey_Details
ON Train_Details.Train_ID=Journey_Details.Train_ID
INNER JOIN
(SELECT  DISTINCT Train_ID,Station_Name AS A
FROM Journey_Details INNER JOIN Station_Details
ON Journey_Details.Station_ID=Station_Details.Station_ID
WHERE DISTANCE=0 AND Arrival_GMT IS NULL) AS B
ON Journey_Details.Train_ID=b.Train_ID
INNER JOIN(SELECT  DISTINCT Train_ID,Station_Name AS OC
FROM Journey_Details INNER JOIN Station_Details
ON Journey_Details.Station_ID=Station_Details.Station_ID
WHERE DISTANCE>0 AND Departure_GMT IS NULL) AS OD
ON Journey_Details.Train_ID=OD.Train_ID;





-- SECTION B

--1)
use Test2_BB;
CREATE TABLE Department 
(Dept_Id INT Primary key,
Dept_Name VARCHAR(50)
);
use Test2_BB;
 CREATE TABLE Project
(P_Id INT PRIMARY KEY,
P_Name VARCHAR(50),
Dept_Id INT FOREIGN KEY REFERENCES Department(Dept_Id)
);
use Test2_BB;
CREATE TABLE Engineer
(E_Id INT PRIMARY KEY,
Dept_Id INT FOREIGN KEY REFERENCES Department(Dept_Id),
Emp_Name VARCHAR(50)
);
use Test2_BB;
CREATE TABLE Attendance
(
Att_Id INT PRIMARY KEY,
E_Id INT FOREIGN KEY REFERENCES Engineer(E_Id),
P_Id INT FOREIGN KEY REFERENCES Project(P_Id),
Atten_Date DATE,
Hrs INT
);
INSERT INTO Department
(Dept_Id ,
Dept_Name)
VALUES
(1,'HR'),
(2,'Development'),
(3,'Testing');
INSERT INTO Project
(P_Id,P_Name,Dept_Id)
VALUES
(1,'ABC','2'),
(2,'XYZ','2'),
(3,'XMATTERS','3'),
(4,'YUVI','3'),
(5,'ABIC','2'),
(6,'BRAVO','2'),
(7,'YOMAN','3');
INSERT INTO Engineer
(E_Id ,
Dept_Id ,
Emp_Name)
VALUES
(1,2,'JOHN'),
(2,3,'TANVI'),
(3,3,'RAVI'),
(4,3,'KN'),
(5,2,'PN'),
(6,2,'JO'),
(7,3,'JN');
INSERT INTO Attendance
(Att_Id,
E_Id,
P_Id,
Atten_Date,
Hrs 
)
VALUES
(1,1,1,'2010-1-1',3),
(2,2,2,'2010-1-1',6),
(3,2,2,'2010-1-1',10),
(4,3,3,'2010-1-1',9),
(5,3,3,'2010-1-1',8);


--2)


SELECT e.Emp_Name,sum(a.Hrs) as TOTAL_HOURS
from
Engineer e INNER JOIN Attendance a
ON e.E_Id=a.E_Id
GROUP BY e.Emp_Name;

SELECT p.P_Name,sum(a.Hrs) as TOTAL_HRS_PROJECT
from
Project p INNER JOIN Attendance a
ON p.P_Id=a.P_Id
GROUP BY p.P_Name;
