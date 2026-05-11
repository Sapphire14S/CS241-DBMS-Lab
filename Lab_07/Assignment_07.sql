-- !Creating Database
CREATE DATABASE Lab07;

USE Lab07;

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

-- !Add column
ALTER TABLE Student
ADD total_credits INT;

-- !Update values
UPDATE Student s
SET total_credits = (
    SELECT IFNULL(SUM(c.credits), 0)
    FROM Enrolled e
    JOIN Class c ON e.cname = c.name
    WHERE e.snum = s.snum
);

CREATE TABLE Faculty (
    fid INT PRIMARY KEY,
    fname VARCHAR(30),
    deptid INT
);

CREATE TABLE Class (
    name VARCHAR(40) PRIMARY KEY,
    meets_at VARCHAR(30),
    room VARCHAR(15),
    fid INT,
    credits INT,
    FOREIGN KEY (fid) REFERENCES Faculty(fid)
);

CREATE TABLE Enrolled (
    snum INT,
    cname VARCHAR(40),
    grade CHAR(2),
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
INSERT INTO Student (snum, sname, major, level, age) VALUES
(051135593,'Maria White','English','SR',21),
(060839453,'Charles Harris','Architecture','SR',22),
(099354543,'Susan Martin','Law','JR',20),
(112348546,'Joseph Thompson','Computer Science','SO',19),
(115987938,'Christopher Garcia','Computer Science','JR',20),
(132977562,'Angela Martinez','History','SR',20),
(269734834,'Thomas Robinson','Psychology','SO',18),
(280158572,'Margaret Clark','Animal Science','FR',18),
(301221823,'Juan Rodriguez','Psychology','JR',20),
(318548912,'Dorthy Lewis','Finance','FR',18),
(320874981,'Daniel Lee','Electrical Engineering','FR',17),
(322654189,'Lisa Walker','Computer Science','SO',17),
(348121549,'Paul Hall','Computer Science','JR',18),
(351565322,'Nancy Allen','Accounting','JR',19),
(451519864,'Mark Young','Finance','FR',18),
(455798411,'Luis Hernandez','Electrical Engineering','FR',17),
(462156489,'Donald King','Mechanical Engineering','SO',19),
(550156548,'George Wright','Education','SR',21),
(552455318,'Ana Lopez','Computer Engineering','SR',19),
(556784565,'Kenneth Hill','Civil Engineering','SR',21),
(567354612,'Karen Scott','Computer Engineering','FR',18),
(573284895,'Steven Green','Kinesiology','SO',19),
(574489456,'Betty Adams','Economics','JR',20),
(578875478,'Edward Baker','Veterinary Medicine','SR',21);


-- !Faculty 
INSERT INTO Faculty (fid, fname, deptid) VALUES
(142519864,'Ivana Teach',20),
(242518965,'James Smith',68),
(141582651,'Mary Johnson',20),
(011564812,'John Williams',68),
(254099823,'Patricia Jones',68),
(356187925,'Robert Brown',12),
(489456522,'Linda Davis',20),
(287321212,'Michael Miller',12),
(248965255,'Barbara Wilson',12),
(159542516,'William Moore',33),
(090873519,'Elizabeth Taylor',11),
(486512566,'David Anderson',20),
(619023588,'Jennifer Thomas',11),
(489221823,'Richard Jackson',33),
(548977562,'Ulysses Teach',20);


-- !Class
INSERT INTO Class (name, meets_at, room, fid, credits) VALUES
('Data Structures','MWF 10','R128',489456522,3),
('Database Systems','MWF 12:30-1:45','1320 DCL',142519864,4),
('Operating System Design','TuTh 12-1:20','20 AVW',489456522,5),
('Archaeology of the Incas','MWF 3-4:15','R128',248965255,4),
('Aviation Accident Investigation','TuTh 1-2:50','Q3',011564812,2),
('Air Quality Engineering','TuTh 10:30-11:45','R15',011564812,4),
('Introductory Latin','MWF 3-4:15','R12',248965255,3),
('American Political Parties','TuTh 2-3:15','20 AVW',619023588,4),
('Social Cognition','Tu 6:30-8:40','R15',159542516,4),
('Perception','MTuWTh 3','Q3',489221823,3),
('Multivariate Analysis','TuTh 2-3:15','R15',090873519,4),
('Patent Law','F 1-2:50','R128',090873519,3),
('Urban Economics','MWF 11','20 AVW',489221823,2),
('Organic Chemistry','TuTh 12:30-1:45','R12',489221823,4),
('Marketing Research','MW 10-11:15','1320 DCL',489221823,5),
('Seminar in American Art','M 4','R15',489221823,4),
('Orbital Mechanics','MWF 8','1320 DCL',011564812,3),
('Dairy Herd Management','TuTh 12:30-1:45','R128',356187925,2),
('Communication Networks','MW 9:30-10:45','20 AVW',141582651,3),
('Optical Electronics','TuTh 12:30-1:45','R15',254099823,4),
('Intoduction to Math','TuTh 8-9:30','R128',489221823,5);


-- !Enrolled
INSERT INTO Enrolled (snum, cname, grade) VALUES
(112348546,'Database Systems','A'),
(115987938,'Database Systems','B'),
(348121549,'Database Systems','F'),
(322654189,'Database Systems',NULL),
(552455318,'Database Systems','C'),
(455798411,'Operating System Design','A'),
(552455318,'Operating System Design','A'),
(567354612,'Operating System Design','B'),
(112348546,'Operating System Design','C'),
(115987938,'Operating System Design','F'),
(322654189,'Operating System Design','F'),
(567354612,'Data Structures','F'),
(552455318,'Communication Networks','F'),
(455798411,'Optical Electronics','F'),
(301221823,'Perception','A'),
(301221823,'Social Cognition','B'),
(301221823,'American Political Parties','C'),
(556784565,'Air Quality Engineering','D'),
(099354543,'Patent Law','A'),
(574489456,'Urban Economics','F');


-- !All rows of tables
SELECT * FROM student;
SELECT * FROM faculty;
SELECT * FROM class;
SELECT * FROM enrolled;


-- !Queries
-- !Q1: Number of students enrolled in courses taught by a given instructor
CREATE FUNCTION count_students_by_instructor(instructor_id INT)
RETURNS INT
DETERMINISTIC
RETURN (
    SELECT COUNT(*)
    FROM Enrolled e
    JOIN Class c ON e.cname = c.name
    WHERE c.fid = instructor_id
);

SELECT f.fname
FROM Faculty f
WHERE count_students_by_instructor(f.fid) > 1;


-- Optimised Q1:
-- 1. May include duplicates
SELECT f.fname
FROM Faculty f
JOIN Class c ON f.fid = c.fid
JOIN Enrolled e ON e.cname = c.name
GROUP BY f.fid, f.fname
HAVING COUNT(e.snum) > 1;

-- 2. Without duplicates
SELECT f.fname
FROM Faculty f
JOIN Class c ON f.fid = c.fid
JOIN Enrolled e ON e.cname = c.name
GROUP BY f.fid, f.fname
HAVING COUNT(DISTINCT e.snum) > 1;

-- !Q2: Number of students who have got an 'F' grade in a given course
CREATE FUNCTION count_F_students(course_name VARCHAR(40))
RETURNS INT
DETERMINISTIC
RETURN (
    SELECT COUNT(*)
    FROM Enrolled
    WHERE cname = course_name AND grade = 'F'
);

SELECT DISTINCT f.fname
FROM Faculty f
JOIN Class c ON f.fid = c.fid
WHERE count_F_students(c.name) > 1;


-- Optimised Q2:
SELECT f.fname
FROM Faculty f
JOIN Class c ON f.fid = c.fid
JOIN Enrolled e ON e.cname = c.name
WHERE e.grade = 'F'
GROUP BY f.fid
HAVING COUNT(e.snum) > 1;