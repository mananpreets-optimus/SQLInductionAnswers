use newTest;
CREATE TABLE Vendor (VendorID int PRIMARY KEY, Name varchar(50));
INSERT INTO Vendor
VALUES
(101,'Sai Travels'),
(102,'Meru Cabs'),
(103,'Miracle Cabs');
select * from Vendor;


CREATE TABLE Cab (CabID int PRIMARY KEY, VendorID int FOREIGN KEY REFERENCES Vendor(VendorID), Number int, BrandName varchar(50));
INSERT INTO Cab
VALUES
(201,101,8529,'Mercedes'),
(202,103,5764,'Jaguar'),
(203,101,1967,'Lamborghini'),
(204,102,7359,'Mercedes'),
(205,103,1992,'Audi'),
(206,103,0786,'BMW'),
(207,101,0007,'Audi'),
(208,102,8541,'Fiat');
select * from Cab;


CREATE TABLE User_Table (UserID int PRIMARY KEY, Name varchar(50), Gender varchar(1));
INSERT INTO User_Table
VALUES
(301,'Ravi','M'),
(302,'Kavi','F'),
(303,'Abhi','M'),
(304,'Savita','F'),
(305,'Gopal','M'),
(306,'Bhopal','M'),
(307,'Dolly','F'),
(308,'Tanu','F'),
(309,'Prince','M'),
(310,'Raj Kishore','M');

SELECT * FROM User_Table;

CREATE TABLE Bookings 
(BookingID int PRIMARY KEY,CabID int FOREIGN KEY REFERENCES Cab(CabID),UserID int FOREIGN KEY REFERENCES User_Table(UserID),
Fare int, Distance float, PickupTime DATETIME, DropTime DATETIME, Rating int);

INSERT INTO Bookings
VALUES
(401,204,309,101,13,'04-07-2015 19:00:00','04-07-2015 19:30:00',5),
(402,205,301,105,15.2,'05-11-2015 9:15:00','05-11-2015 10:00:00',3),
(403,204,309,2000,190,'03-19-2015 20:45:00','03-20-2015 01:00:00',2),
(404,201,302,1995,150,'07-07-2015 11:00:00','07-07-2015 15:00:00',5),
(405,204,303,553,50,'09-12-2014 19:00:00','09-12-2014 22:15:00',2),
(406,202,302,465,45,'01-07-2015 9:00:00','01-07-2015 9:40:00',1),
(407,205,304,258,20,'07-02-2015 3:00:00','07-02-2015 3:15:00',4),
(408,202,309,125,15,'06-23-2015 9:00:00','06-23-2015 10:00:00',5),
(409,204,310,1462,30,'02-05-2015 6:00:00','02-05-2015 8:00:00',4),
(410,207,306,1876,60,'01-29-2015 15:00:00','01-29-2015 18:00:00',1),
(411,203,308,1145,100,'06-04-2015 20:00:00','06-05-2015 6:00:00',0),
(412,206,309,1358,90,'01-19-2015 02:00:00','01-19-2015 08:00:00',1),
(413,208,301,102,5,'03-21-2015 11:00:00','03-21-2015 11:15:00',5),
(414,206,309,503,50,'02-28-2015 08:00:00','02-28-2015 10:00:00',4),
(415,204,304,786,62,'03-09-2015 16:00:00','03-09-2015 19:00:00',3),
(416,208,306,143,3,'04-09-2015 11:30:00','04-09-2015 11:45:00',2),
(417,203,309,658,12,'05-04-2015 01:00:00','05-04-2015 01:45:00',0),
(418,206,308,852,17,'02-18-2015 15:00:00','02-18-2015 16:00:00',1),
(419,208,301,450,22,'03-11-2015 18:00:00','03-12-2015 10:00:00',4),
(420,204,309,420,29,'02-17-2015 11:00:00','02-17-2015 21:00:00',1);

select * from bookings;


--1 TIME
SELECT User_Table.Name,a.BrandName, a.Number, DATEDIFF(MI,a.PickupTime,a.DropTime) TravelTime
FROM User_Table 
RIGHT JOIN
(
SELECT Bookings.UserID,Cab.BrandName,Cab.Number,Bookings.PickupTime,Bookings.DropTime
FROM Bookings
INNER JOIN Cab
ON Cab.CabID = Bookings.CabID
WHERE Bookings.Fare>500 AND Bookings.Fare<1000
) a
ON User_Table.UserID = a.UserID;

--2
SELECT TOP 1 Cab.Number, Cab.BrandName
FROM Cab
INNER JOIN 
Bookings
on Bookings.CabID = Cab.CabID
Group by Cab.Number, Cab.BrandName
ORDER BY count(Bookings.CabID) DESC;

--3 TOP 3 users with ties implementation and without ties implementation both

--with ties
SELECT TOP 3 WITH TIES User_Table.Name,count(Bookings.UserID)
FROM User_Table
INNER JOIN 
Bookings
ON User_Table.UserID = Bookings.UserID
GROUP BY User_Table.Name
ORDER BY count(Bookings.UserID) DESC;

--without ties
SELECT TOP 3 User_Table.Name,count(Bookings.UserID)
FROM User_Table
INNER JOIN 
Bookings
ON User_Table.UserID = Bookings.UserID
GROUP BY User_Table.Name
ORDER BY count(Bookings.UserID) DESC;


--4 


SELECT User_Table.Name as UserName,Vendor.Name as VendorName,sum(a.cnt) as NoOfTimesCabBooked FROM Cab
left JOIN
(SELECT Bookings.UserID, Bookings.CabID, count(Bookings.CabID) cnt
FROM Bookings GROUP BY Bookings.UserID, Bookings.CabID) A
ON A.CabID=Cab.CabID
left join
User_Table
on User_Table.UserID=A.UserID
left join
Vendor
on Vendor.VendorID= Cab.VendorID
group by Cab.VendorID,a.UserID,User_Table.Name,Vendor.VendorID,Vendor.Name;

--5
SELECT Cab.BrandName, Cab.Number, User_Table.Gender,COUNT(User_Table.Gender) as NoOFUsers
FROM Bookings
LEFT JOIN
Cab
on Cab.CabID=Bookings.CabID
LEFT JOIN
User_Table
ON User_Table.UserID=Bookings.UserID
group by Cab.BrandName, Cab.Number, User_Table.Gender;


--6?? rating 
SELECT Vendor.VendorID,Vendor.Name, Avg(cast(Bookings.Rating as decimal)) AS Avg_Rating
FROM 
Bookings
LEFT JOIN
Cab
ON Cab.CabID=Bookings.CabID
LEFT JOIN
Vendor
ON Vendor.VendorID=Cab.VendorID
GROUP BY  Vendor.VendorID,Vendor.Name;

--7 
Select f.BrandName,f.vname AS VendorName,F.TotalDistance,AVG(F.TotalDistance/f.TotTime) as AverageSpeed
from
Vendor
right join
(
Select Vendor.VendorID,d.BrandName,Vendor.Name as vname,sum(d.Distance) as TotalDistance,sum(cast(d.Total_Time as decimal))/60 AS TotTime
from 
Vendor
inner join
(SELECT Cab.VendorID,Cab.BrandName, Bookings.CabID,Bookings.Distance,DATEDIFF(MI,Bookings.PickupTime,Bookings.DropTime) as Total_Time
FROM
Bookings
INNER JOIN
Cab
on cab.CabID=Bookings.CabID) as d
on d.VendorID=Vendor.VendorID
group by Vendor.Name,d.BrandName,Vendor.VendorID
)f
ON Vendor.VendorID=f.VendorID
GROUP BY F.vname,F.BrandName,F.TotalDistance;







--8
SELECT Vendor.Name,count(Bookings.CabID)
from 
Bookings
inner join
Cab
ON Bookings.CabID=Cab.CabID
INNER JOIN
Vendor
ON Vendor.VendorID=Cab.VendorID
WHERE DATEPART(DAY,Bookings.PickupTime)=07
GROUP BY Vendor.Name;




--9 
SELECT Cab.BrandName,Cab.CabID FROM Cab
WHERE Cab.CabID IN 
(
SELECT TOP 1 Bookings.CabID
FROM 
Bookings
GROUP BY Bookings.CabID
ORDER BY AVG(Bookings.Fare/Bookings.Distance)
);