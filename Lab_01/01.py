import sqlite3

# Connect to an in-memory database
conn = sqlite3.connect(":memory:")
cur = conn.cursor()

# Tables
cur.execute("""
CREATE TABLE Student(
    snum INTEGER,
    sname TEXT,
    major TEXT,
    level TEXT,
    age INTEGER
)
""")

cur.execute("""
CREATE TABLE Class(
    name TEXT,
    meets_at TEXT,
    room TEXT,
    fid INTEGER
)
""")

cur.execute("""
CREATE TABLE Enrolled(
    snum INTEGER,
    cname TEXT
)
""")

cur.execute("""
CREATE TABLE Faculty(
    fid INTEGER,
    fname TEXT,
    deptid INTEGER
)
""")

# Sample Records
cur.executemany("INSERT INTO Student VALUES (?,?,?,?,?)", [
    (51135593, "Maria White", "English", "SR", 21),
    (60839453, "Charles Harris", "Architecture", "SR", 22),
    (99354543, "Susan Martin", "Law", "JR", 20),
    (112348546, "Joseph Thompson", "Computer Science", "SO", 19),
    (115987938, "Christopher Garcia", "Computer Science", "JR", 20),
    (132977562, "Angela Martinez", "History", "SR", 20),
    (269734834, "Thomas Robinson", "Psychology", "SO", 18),
    (280158572, "Margaret Clark", "Animal Science", "FR", 18),
    (301221823, "Juan Rodriguez", "Psychology", "JR", 20),
    (318548912, "Dorthy Lewis", "Finance", "FR", 18),
    (320874981, "Daniel Lee", "Electrical Engineering", "FR", 17),
    (322654189, "Lisa Walker", "Computer Science", "SO", 17),
    (348121549, "Paul Hall", "Computer Science", "JR", 18),
    (351565322, "Nancy Allen", "Accounting", "JR", 19),
    (451519864, "Mark Young", "Finance", "FR", 18),
    (455798411, "Luis Hernandez", "Electrical Engineering", "FR", 17),
    (462156489, "Donald King", "Mechanical Engineering", "SO", 19),
    (550156548, "George Wright", "Education", "SR", 21),
    (552455318, "Ana Lopez", "Computer Engineering", "SR", 19),
    (556784565, "Kenneth Hill", "Civil Engineering", "SR", 21),
    (567354612, "Karen Scott", "Computer Engineering", "FR", 18),
    (573284895, "Steven Green", "Kinesiology", "SO", 19),
    (574489456, "Betty Adams", "Economics", "JR", 20),
    (578875478, "Edward Baker", "Veterinary Medicine", "SR", 21)
])


cur.executemany("INSERT INTO Enrolled VALUES (?,?)", [
    (112348546, "Database Systems"),
    (115987938, "Database Systems"),
    (348121549, "Database Systems"),
    (322654189, "Database Systems"),
    (552455318, "Database Systems"),
    (455798411, "Operating System Design"),
    (552455318, "Operating System Design"),
    (567354612, "Operating System Design"),
    (112348546, "Operating System Design"),
    (115987938, "Operating System Design"),
    (322654189, "Operating System Design"),
    (567354612, "Data Structures"),
    (552455318, "Communication Networks"),
    (455798411, "Optical Electronics"),
    (301221823, "Perception"),
    (301221823, "Social Cognition"),
    (301221823, "American Political Parties"),
    (556784565, "Air Quality Engineering"),
    (99354543, "Patent Law"),
    (574489456, "Urban Economics")
])


cur.executemany("INSERT INTO Faculty VALUES (?,?,?)", [
    (142519864, "Ivana Teach", 20),
    (242518965, "James Smith", 68),
    (141582651, "Mary Johnson", 20),
    (11564812, "John Williams", 68),
    (254099823, "Patricia Jones", 68),
    (356187925, "Robert Brown", 12),
    (489456522, "Linda Davis", 20),
    (287321212, "Michael Miller", 12),
    (248965255, "Barbara Wilson", 12),
    (159542516, "William Moore", 33),
    (90873519, "Elizabeth Taylor", 11),
    (486512566, "David Anderson", 20),
    (619023588, "Jennifer Thomas", 11),
    (489221823, "Richard Jackson", 33),
    (548977562, "Ulysses Teach", 20)
])

conn.commit()


# Queries
# (1)
print("\n(1) Names and ages of all students")
query1 = """
SELECT sname, age
FROM Student
"""
for row in cur.execute(query1):
    print(row)

# (2)
age_limit = 18

print("\n(2) Students with age above", age_limit)
query2 = """
SELECT snum, sname, major, level, age
FROM Student
WHERE age > ?
"""
for row in cur.execute(query2, (age_limit,)):
    print(row)

# (3)
course = "Database Systems"

print("\n(3) Serial numbers enrolled in", course)
query3 = """
SELECT snum
FROM Enrolled
WHERE cname = ?
"""
for row in cur.execute(query3, (course,)):
    print(row)

# (4)
print("\n(4) Names of students enrolled in", course)
query4 = """
SELECT DISTINCT S.sname
FROM Student S
JOIN Enrolled E ON S.snum = E.snum
WHERE E.cname = ?
"""
for row in cur.execute(query4, (course,)):
    print(row)

# (5)
dept = 20

print("\n(5) Faculty members in department", dept)
query5 = """
SELECT fname
FROM Faculty
WHERE deptid = ?
"""
for row in cur.execute(query5, (dept,)):
    print(row)
