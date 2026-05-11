-- !Creating Database
CREATE DATABASE Lab05;

USE Lab05;

-- !Verify
SHOW DATABASES;
SELECT DATABASE();

-- !Create Tables
CREATE TABLE Student (
    snum INT PRIMARY KEY,
    sname VARCHAR(30),
    major VARCHAR(25),
    level VARCHAR(10),
    age INT
);

CREATE TABLE Faculty (
    fid INT PRIMARY KEY,
    fname VARCHAR(30),
    deptid INT
);

CREATE TABLE Class (
    name VARCHAR(40) PRIMARY KEY,
    meets_at TIME,
    room VARCHAR(10),
    fid INT,
    FOREIGN KEY (fid) REFERENCES Faculty(fid)
);

CREATE TABLE Enrolled (
    snum INT,
    cname VARCHAR(40),
    PRIMARY KEY (snum, cname),
    FOREIGN KEY (snum) REFERENCES Student(snum),
    FOREIGN KEY (cname) REFERENCES Class(name)
);

-- !Verify Tables
SHOW TABLES;
DESC Student;
DESC Faculty;
DESC Class;
DESC Enrolled;


-- !Insert Data
-- !Student
INSERT INTO Student VALUES
(51135593, 'Maria White', 'English', 'SR', 21),
(60839453, 'Charles Harris', 'Architecture', 'SR', 22),
(99354543, 'Susan Martin', 'Law', 'JR', 20),
(112348546, 'Joseph Thompson', 'Computer Science', 'SO', 19),
(115987938, 'Christopher Garcia', 'Computer Science', 'JR', 20),
(132977562, 'Angela Martinez', 'History', 'SR', 20),
(269734834, 'Thomas Robinson', 'Psychology', 'SO', 18),
(280158572, 'Margaret Clark', 'Animal Science', 'FR', 18),
(301221823, 'Juan Rodriguez', 'Psychology', 'JR', 20),
(318548912, 'Dorthy Lewis', 'Finance', 'FR', 18),
(320874981, 'Daniel Lee', 'Electrical Engineering', 'FR', 17),
(322654189, 'Lisa Walker', 'Computer Science', 'SO', 17),
(348121549, 'Paul Hall', 'Computer Science', 'JR', 18),
(351565322, 'Nancy Allen', 'Accounting', 'JR', 19),
(451519864, 'Mark Young', 'Finance', 'FR', 18),
(455798411, 'Luis Hernandez', 'Electrical Engineering', 'FR', 17),
(462156489, 'Donald King', 'Mechanical Engineering', 'SO', 19),
(550156548, 'George Wright', 'Education', 'SR', 21),
(552455318, 'Ana Lopez', 'Computer Engineering', 'SR', 19),
(556784565, 'Kenneth Hill', 'Civil Engineering', 'SR', 21),
(567354612, 'Karen Scott', 'Computer Engineering', 'FR', 18),
(573284895, 'Steven Green', 'Kinesiology', 'SO', 19),
(574489456, 'Betty Adams', 'Economics', 'JR', 20),
(578875478, 'Edward Baker', 'Veterinary Medicine', 'SR', 21);

-- !Faculty
INSERT INTO Faculty VALUES
(142519864, 'Ivana Teach', 20),
(242518965, 'James Smith', 68),
(141582651, 'Mary Johnson', 20),
(11564812,  'John Williams', 68),
(254099823, 'Patricia Jones', 68),
(356187925, 'Robert Brown', 12),
(489456522, 'Linda Davis', 20),
(287321212, 'Michael Miller', 12),
(248965255, 'Barbara Wilson', 12),
(159542516, 'William Moore', 33),
(90873519,  'Elizabeth Taylor', 11),
(486512566, 'David Anderson', 20),
(619023588, 'Jennifer Thomas', 11),
(489221823, 'Richard Jackson', 33),
(548977562, 'Ulysses Teach', 20);

-- !Class
ALTER TABLE Class 
MODIFY meets_at VARCHAR(30);

INSERT INTO Class VALUES
('Data Structures', 'MWF 10', 'R128', 489456522),
('Database Systems', 'MWF 12:30-1:45', '1320 DCL', 142519864),
('Operating System Design', 'TuTh 12-1:20', '20 AVW', 489456522),
('Archaeology of the Incas', 'MWF 3-4:15', 'R128', 248965255),
('Aviation Accident Investigation', 'TuTh 1-2:50', 'Q3', 11564812),
('Air Quality Engineering', 'TuTh 10:30-11:45', 'R15', 11564812),
('Introductory Latin', 'MWF 3-4:15', 'R12', 248965255),
('American Political Parties', 'TuTh 2-3:15', '20 AVW', 619023588),
('Social Cognition', 'Tu 6:30-8:40', 'R15', 159542516),
('Perception', 'MTuWTh 3', 'Q3', 489221823),
('Multivariate Analysis', 'TuTh 2-3:15', 'R15', 90873519),
('Patent Law', 'F 1-2:50', 'R128', 90873519),
('Urban Economics', 'MWF 11', '20 AVW', 489221823),
('Organic Chemistry', 'TuTh 12:30-1:45', 'R12', 489221823),
('Marketing Research', 'MW 10-11:15', '1320 DCL', 489221823),
('Seminar in American Art', 'M 4', 'R15', 489221823),
('Orbital Mechanics', 'MWF 8', '1320 DCL', 11564812),
('Dairy Herd Management', 'TuTh 12:30-1:45', 'R128', 356187925),
('Communication Networks', 'MW 9:30-10:45', '20 AVW', 141582651),
('Optical Electronics', 'TuTh 12:30-1:45', 'R15', 254099823),
('Intoduction to Math', 'TuTh 8-9:30', 'R128', 489221823);

-- !Enrolled
INSERT INTO Enrolled VALUES
(112348546, 'Database Systems'),
(115987938, 'Database Systems'),
(348121549, 'Database Systems'),
(322654189, 'Database Systems'),
(552455318, 'Database Systems'),

(455798411, 'Operating System Design'),
(552455318, 'Operating System Design'),
(567354612, 'Operating System Design'),
(112348546, 'Operating System Design'),
(115987938, 'Operating System Design'),
(322654189, 'Operating System Design'),

(567354612, 'Data Structures'),
(552455318, 'Communication Networks'),
(455798411, 'Optical Electronics'),

(301221823, 'Perception'),
(301221823, 'Social Cognition'),
(301221823, 'American Political Parties'),

(556784565, 'Air Quality Engineering'),
(99354543,  'Patent Law'),
(574489456, 'Urban Economics');


-- !All rows of tables
SELECT * FROM student;
SELECT * FROM faculty;
SELECT * FROM class;
SELECT * FROM enrolled;


-- !Queries
-- !Q1: Classes that meet in room 20 AVW OR have ≥ 5 students
SELECT c.name as COURSES
FROM class c
WHERE c.room = '20 AVW' 
    OR EXISTS (
        SELECT 1
        FROM enrolled e
        WHERE e.cname = c.name
        GROUP BY e.cname
        HAVING count(*) >= 5
);


-- !Q2: Number of courses conducted per room
SELECT room, count(*) as num_courses
FROM class
GROUP BY room;


-- !Q3: Faculty with number of classes taught (include 0)
SELECT f.fid, f.fname, count(c.name) as num_classes, 'Faculty' as Role
FROM faculty f
LEFT OUTER JOIN class c
on f.fid = c.fid
GROUP BY f.fid;


-- !Q4: Courses with room and number of students (include 0)
SELECT c.name AS course_name, c.room, COUNT(e.snum) AS num_students
FROM class c
LEFT OUTER JOIN enrolled e
    ON c.name = e.cname
GROUP BY c.name, c.room;


-- !Q5: Faculty in dept 20 whose courses are in room R128
SELECT *
FROM faculty f
WHERE f.deptid = 20 
    AND EXISTS (
    SELECT 1
    FROM class c
    WHERE f.fid = c.fid
    AND c.room = 'R128'
);


-- !Q6: Maximum age of students of each major
SELECT major, max(age)
FROM student s
GROUP BY major;


-- !Q7: Students and faculty whose names contain "son"
-- !CARTESIAN PRODUCT
SELECT DISTINCT(s.sname) as STUDENTS, f.fname as FACULTY
FROM student s, faculty f
WHERE s.sname like '%son%' AND f.fname like '%son%';


-- !Using UNION removes duplicates automatically.
SELECT s.sname AS Name, 'Student' AS Role
FROM Student s
WHERE s.sname LIKE '%son%'
UNION
SELECT f.fname AS name, 'Faculty' AS role
FROM Faculty f
WHERE f.fname LIKE '%son%';


-- !Q8: Dept 20 faculty teaching in R128 (Nested Query only)
SELECT fid, fname
FROM Faculty
WHERE deptid = 20
    AND fid IN (
        SELECT fid
        FROM Class
        WHERE room = 'R128'
);


-- !Q9: Same query using VIEW (no nested query)
CREATE VIEW R128_Faculty AS
SELECT DISTINCT fid
FROM Class
WHERE room = 'R128';

SELECT F.fid, F.fname
FROM Faculty F
JOIN R128_Faculty R ON F.fid = R.fid
WHERE F.deptid = 20;

