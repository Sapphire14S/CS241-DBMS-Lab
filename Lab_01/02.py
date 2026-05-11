# Student Table
students = [
    {"snum": 51135593,  "sname": "Maria White",        "major": "English",                "level": "SR", "age": 21},
    {"snum": 60839453,  "sname": "Charles Harris",     "major": "Architecture",           "level": "SR", "age": 22},
    {"snum": 99354543,  "sname": "Susan Martin",       "major": "Law",                    "level": "JR", "age": 20},
    {"snum": 112348546, "sname": "Joseph Thompson",    "major": "Computer Science",       "level": "SO", "age": 19},
    {"snum": 115987938, "sname": "Christopher Garcia", "major": "Computer Science",       "level": "JR", "age": 20},
    {"snum": 132977562, "sname": "Angela Martinez",    "major": "History",                "level": "SR", "age": 20},
    {"snum": 269734834, "sname": "Thomas Robinson",    "major": "Psychology",             "level": "SO", "age": 18},
    {"snum": 280158572, "sname": "Margaret Clark",     "major": "Animal Science",         "level": "FR", "age": 18},
    {"snum": 301221823, "sname": "Juan Rodriguez",     "major": "Psychology",             "level": "JR", "age": 20},
    {"snum": 318548912, "sname": "Dorthy Lewis",       "major": "Finance",                "level": "FR", "age": 18},
    {"snum": 320874981, "sname": "Daniel Lee",         "major": "Electrical Engineering", "level": "FR", "age": 17},
    {"snum": 322654189, "sname": "Lisa Walker",        "major": "Computer Science",       "level": "SO", "age": 17},
    {"snum": 348121549, "sname": "Paul Hall",          "major": "Computer Science",       "level": "JR", "age": 18},
    {"snum": 351565322, "sname": "Nancy Allen",        "major": "Accounting",             "level": "JR", "age": 19},
    {"snum": 451519864, "sname": "Mark Young",         "major": "Finance",                "level": "FR", "age": 18},
    {"snum": 455798411, "sname": "Luis Hernandez",     "major": "Electrical Engineering", "level": "FR", "age": 17},
    {"snum": 462156489, "sname": "Donald King",        "major": "Mechanical Engineering", "level": "SO", "age": 19},
    {"snum": 550156548, "sname": "George Wright",      "major": "Education",              "level": "SR", "age": 21},
    {"snum": 552455318, "sname": "Ana Lopez",          "major": "Computer Engineering",   "level": "SR", "age": 19},
    {"snum": 556784565, "sname": "Kenneth Hill",       "major": "Civil Engineering",      "level": "SR", "age": 21},
    {"snum": 567354612, "sname": "Karen Scott",        "major": "Computer Engineering",   "level": "FR", "age": 18},
    {"snum": 573284895, "sname": "Steven Green",       "major": "Kinesiology",            "level": "SO", "age": 19},
    {"snum": 574489456, "sname": "Betty Adams",        "major": "Economics",              "level": "JR", "age": 20},
    {"snum": 578875478, "sname": "Edward Baker",       "major": "Veterinary Medicine",    "level": "SR", "age": 21},
]

# Enrolled Table
enrolled = [
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
    (99354543,  "Patent Law"),
    (574489456, "Urban Economics"),
]

# Faculty Table
faculty = [
    {"fid": 142519864, "fname": "Ivana Teach",     "deptid": 20},
    {"fid": 242518965, "fname": "James Smith",     "deptid": 68},
    {"fid": 141582651, "fname": "Mary Johnson",    "deptid": 20},
    {"fid": 11564812,  "fname": "John Williams",   "deptid": 68},
    {"fid": 254099823, "fname": "Patricia Jones",  "deptid": 68},
    {"fid": 356187925, "fname": "Robert Brown",    "deptid": 12},
    {"fid": 489456522, "fname": "Linda Davis",     "deptid": 20},
    {"fid": 287321212, "fname": "Michael Miller",  "deptid": 12},
    {"fid": 248965255, "fname": "Barbara Wilson",  "deptid": 12},
    {"fid": 159542516, "fname": "William Moore",   "deptid": 33},
    {"fid": 90873519,  "fname": "Elizabeth Taylor","deptid": 11},
    {"fid": 486512566, "fname": "David Anderson",  "deptid": 20},
    {"fid": 619023588, "fname": "Jennifer Thomas", "deptid": 11},
    {"fid": 489221823, "fname": "Richard Jackson", "deptid": 33},
    {"fid": 548977562, "fname": "Ulysses Teach",   "deptid": 20},
]

# Queries
# (1)
print("(1) Names and ages of all students")
for s in students:
    print(s["sname"], s["age"])

# (2)
print("\n(2) Students with age above 18")
for s in students:
    if s["age"] > 18:
        print(s["snum"], s["sname"], s["major"], s["level"], s["age"])

# (3)
print("\n(3) Serial numbers enrolled in Database Systems")
for snum, cname in enrolled:
    if cname == "Database Systems":
        print(snum)

# (4)
print("\n(4) Names of students enrolled in Database Systems")

db_students = {snum for snum, cname in enrolled if cname == "Database Systems"}
for s in students:
    if s["snum"] in db_students:
        print(s["sname"])

# (5)
print("\n(5) Faculty members in department 20")
for f in faculty:
    if f["deptid"] == 20:
        print(f["fname"])
