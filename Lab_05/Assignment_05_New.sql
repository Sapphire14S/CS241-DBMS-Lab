-- !Creating Database
CREATE DATABASE lab05New;

USE lab05new;

-- !Verify
SHOW DATABASES;
SELECT DATABASE();


-- !Create Tables
CREATE TABLE Employees_and_Supervisors (
    person VARCHAR(50),
    supervisor VARCHAR(50)
);

INSERT INTO Employees_and_Supervisors (person, supervisor) VALUES 
('Ravi', 'Aman'),
('Mary', 'Sujata'),
('Aman', 'Devi'),
('Devi', 'Mary');


-- !Verify Tables
SHOW TABLES;
DESC Employees_and_Supervisors;

-- !All rows of tables
SELECT * FROM Employees_and_Supervisors;


-- !Queries
-- !Q1: Supervisor of Ravi
SELECT person, supervisor
FROM employees_and_supervisors
WHERE person = 'Ravi';


-- !Q2: Supervisor of supervisor of Ravi
SELECT person, supervisor
FROM employees_and_supervisors
WHERE person = (
    SELECT supervisor
    FROM employees_and_supervisors
    WHERE (person = 'Ravi')
);


-- !Q3: All supervisors (direct + indirect) of Ravi
WITH RECURSIVE SuperChain(person, supervisor) AS (
    SELECT person, supervisor
    FROM employees_and_supervisors
    WHERE person = 'Ravi'

    UNION ALL

    SELECT E.person, E.supervisor
    FROM employees_and_supervisors E
    JOIN SuperChain S
    ON E.person = S.supervisor
)
SELECT supervisor
FROM SuperChain;
