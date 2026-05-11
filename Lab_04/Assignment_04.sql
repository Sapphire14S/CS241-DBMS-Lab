-- !Creating Database
CREATE DATABASE Lab04;

USE Lab04;


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
-- !Q1: Youngest student who is either a Finance age, OR enrolled in a course taught by Linda Davis
WITH EligibleStudents AS (
    SELECT snum, sname, age
    FROM Student
    WHERE major = 'Finance'

    UNION

    SELECT s.snum, s.sname, s.age
    FROM Student s
    JOIN Enrolled e ON s.snum = e.snum
    JOIN Class c ON e.cname = c.name
    JOIN Faculty f ON c.fid = f.fid
    WHERE f.fname = 'Linda Davis'
)
SELECT sname
FROM EligibleStudents
WHERE age = (SELECT MIN(age) FROM EligibleStudents);



-- !Q2: Classes that meet in room 20 AVW, OR have ≥ 5 students enrolled
SELECT c.name
FROM class c
WHERE c.room = '20 AVW' 
    OR EXISTS (
        SELECT 1
        FROM enrolled e
        WHERE e.cname = c.name
        GROUP BY e.cname
        HAVING count(*) >= 5
);


-- !Q3: Faculty who teach in every room in which some class is taught
SELECT f.fname
FROM Faculty f
WHERE NOT EXISTS (
    SELECT DISTINCT c1.room
    FROM Class c1
    WHERE NOT EXISTS (
        SELECT 1
        FROM Class c2
        WHERE c2.fid = f.fid
          AND c2.room = c1.room
    )
);


-- !Q4: Faculty who teach the minimum number of classes
WITH class_count AS (
    SELECT f.fid, COUNT(c.name) AS num_classes
    FROM Faculty f
    LEFT JOIN Class c 
    ON f.fid = c.fid
    GROUP BY f.fid
)
SELECT f.fname
FROM class_count cc
JOIN Faculty f ON cc.fid = f.fid
WHERE cc.num_classes = (
    SELECT MIN(num_classes)
    FROM class_count
);


-- !Q5: Faculty who do not teach any class
SELECT fname
FROM faculty f
WHERE NOT EXISTS (
    SELECT 1
    FROM class c 
    where f.fid = c.fid
);


-- !Q6: For each age, find the level that appears most often
WITH AgeLevelCount AS (
    SELECT age, level, COUNT(*) AS cnt
    FROM Student
    GROUP BY age, level
),
MaxPerAge AS (
    SELECT age, MAX(cnt) AS max_cnt
    FROM AgeLevelCount
    GROUP BY age
)
SELECT a.age, a.level
FROM AgeLevelCount a
JOIN MaxPerAge m
  ON a.age = m.age AND a.cnt = m.max_cnt;


-- !Q7: Number of courses conducted per room
SELECT room, count(*) as num_courses
FROM class
GROUP BY room;


-- !Q8: Courses conducted in room R128 with ≥ 1 student enrolled
SELECT c.name
FROM class c
WHERE c.room = 'R128' 
    AND EXISTS (
        SELECT 1
        FROM enrolled e 
        WHERE e.cname = c.name
);


-- !Q9: Times at which classes occur for courses with ≥ 1 student enrolled
SELECT DISTINCT c.meets_at
FROM class c
WHERE EXISTS (
    SELECT 1
    FROM enrolled e 
    WHERE e.cname = c.name
);


-- !Q10: JR students enrolled in a course conducted in room R128
SELECT DISTINCT s.sname
FROM Student s
WHERE s.level = 'JR'
AND EXISTS (
    SELECT 1
    FROM Enrolled e
    JOIN Class c ON e.cname = c.name
    WHERE e.snum = s.snum
      AND c.room = 'R128'
);


-- !Q11: Students whose age > 18 AND level = SR AND age not Engineering branch
SELECT snum, sname
FROM Student
WHERE age > 18 AND level = 'SR' AND major NOT LIKE '%Engineering%'
ORDER BY age;


-- !Q12: Classes for which no student has enrolled
SELECT c.name
FROM Class c
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrolled e
    WHERE e.cname = c.name
);


