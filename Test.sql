CREATE DATABASE Test;

CREATE TABLE User_Table (UserID int PRIMARY KEY,
 Name varchar(50), Country varchar(50), Gender varchar(1));
INSERT INTO User_Table(UserID, Name, Country, Gender)
VALUES 
(101, 'Harsh', 'India', 'M'),
(102, 'Richa', 'Sri Lanka', 'F'),
(103, 'Richard', 'US', 'M'),
(104, 'Gopal', 'India', 'M'),
(105, 'Jennifer', 'US', 'F'),
(106, 'Karishma', 'India', 'F'),
(107, 'Clinton', 'US', 'M'),
(108, 'Sadhna', 'India', 'F');
SELECT * FROM User_Table;

CREATE TABLE Post(PostID int PRIMARY KEY,
 UserID int FOREIGN KEY REFERENCES User_Table(UserID),
 Post varchar(50)); 

INSERT INTO Post(PostID, UserID,Post)
VALUES 
(201,104,'My name is Gopal'),
(202,101,'Hello Friends'),
(203,105,'Bon Voyage'),
(204,104,'Cherishing Life'),
(205,108,'Switching Lanes'),
(206,105,'Feeling Nostalgic'),
(207,102,'Sangakkara Rocks'),
(208,104,'Bleeding Blue');

SELECT * FROM Post;

CREATE TABLE FriendRequest(RequestID int,
SenderID int,
ReceiverID int,
Status varchar(50));

INSERT INTO FriendRequest(RequestID,SenderID,ReceiverID,Status)
VALUES 
(301,101,102,'Approved'),
(302,107,105,'Rejected'),
(303,101,106,'Approved'),
(304,108,101,'Approved'),
(305,106,103,'Approved'),
(306,104,108,'Pending'),
(307,104,101,'Approved'),
(308,105,102,'Pending'),
(309,107,103,'Approved'),
(310,106,102,'Rejected');

SELECT * FROM FriendRequest;

CREATE TABLE PostLikes(LikeID int PRIMARY KEY,
PostID int FOREIGN KEY REFERENCES Post(PostID),
UserID int FOREIGN KEY REFERENCES User_Table(UserID));

INSERT INTO PostLikes(LikeID,PostID,UserID)
VALUES
(401,203,102),
(402,208,108),
(403,204,106),
(404,203,108),
(405,207,102),
(406,202,102),
(407,203,106),
(408,205,102),
(409,204,107),
(410,203,101);

SELECT * FROM PostLikes;

--1 ?? DONE
SELECT TOP 1 Users.Country FROM User_Table Users 
INNER JOIN
Post Posts 
ON Posts.UserID = Users.UserID
INNER JOIN 
(SELECT DISTINCT COUNT(*) cnt,UserID  FROM Post GROUP BY UserID) A
ON A.UserID=Posts.UserID
GROUP BY Users.Country,Users.UserID
ORDER BY Users.Country; 

--2 
SELECT Name,Country FROM User_Table Users
INNER JOIN
Post Posts
ON Posts.UserID = Users.UserID
INNER JOIN
(SELECT DISTINCT COUNT(*) cnt, UserID FROM Post GROUP BY UserID) B
ON B.UserID=Posts.UserID
GROUP BY Country




--3 DONE
use Test;
SELECT  TOP 2 MAX(q.cnt),Post.Post from PostLikes p
INNER JOIN 
Post
ON
P.PostID=Post.PostID

INNER JOIN 

(SELECT COUNT(*) cnt, PostID FROM PostLikes GROUP BY PostID) q
ON p.PostID = q.PostID
WHERE Post.Post NOT IN
(
SELECT  TOP 2 Post.Post from PostLikes p
INNER JOIN 
Post
ON
P.PostID=Post.PostID

INNER JOIN 

(SELECT COUNT(*) cnt, PostID FROM PostLikes GROUP BY PostID) q
ON p.PostID = q.PostID
group by Post.Post
ORDER BY MAX(q.cnt) desc
)
group by Post.Post
ORDER BY MAX(q.cnt) desc
-----------------------------------------------------------------
--4  DONE 
SELECT TOP 1 MAX(f.e) coun, User_Table.Name FROM Post
Inner JOIN 
User_Table
ON
User_Table.UserID = Post.UserID
INNER JOIN
(SELECT COUNT(*) e,UserID U FROM PostLikes GROUP BY UserID) f
ON Post.UserID = f.U
GROUP BY User_Table.Name
ORDER BY coun DESC

--5 DONE
SElECT distinct User_Table.Name FROM FriendRequest
INNER JOIN
User_Table
ON FriendRequest.ReceiverID = User_Table.UserID
where FriendRequest.ReceiverID NOT IN 
(
SELECT distinct FriendRequest.ReceiverID FROM FriendRequest
WHERE (Status = 'Approved')
)
AND
FriendRequest.ReceiverID
IN 
( 
SELECT distinct FriendRequest.ReceiverID FROM FriendRequest
WHERE (Status = 'Pending' or Status = 'Rejected') 
GROUP BY ReceiverID
)
--6 done
SELECT User_Table.Name,Post.Post,Post.PostID,Post.UserID FROM Post
INNER JOIN
User_Table
ON Post.UserID=User_Table.UserID
INNER JOIN
(SELECT COUNT(*) A,PostID E FROM PostLikes group by PostLikes.PostID) P
ON P.E = Post.PostID
GROUP BY PostID,Post.Post,Post.UserID,User_Table.Name;
--7 done


SELECT User_Table.Country, count(Post.PostID) noOfUsers
from User_Table INNER JOIN Post
ON User_Table.UserID=Post.UserID
GROUP BY User_Table.Country

--8??
SELECT User_Table.Country, count(*) noOfUsers
from User_Table INNER JOIN Post
ON User_Table.UserID=Post.UserID
GROUP BY User_Table.Country


SELECT User_Table.Gender, count(Post.PostID) noOfUsers
from User_Table INNER JOIN Post
ON User_Table.UserID=Post.UserID
GROUP BY User_Table.Gender

--9 
