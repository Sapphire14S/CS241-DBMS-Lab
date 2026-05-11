# Read Student File
students = []
with open("student.txt", "r") as f:
    for line in f:
        snum, name, major, level, age = line.strip().split(",")
        students.append({
            "snum": int(snum),
            "sname": name,
            "major": major,
            "level": level,
            "age": int(age)
        })

# Read Enrolled File
enrolled = []
with open("enrolled.txt", "r") as f:
    for line in f:
        snum, course = line.strip().split(",")
        enrolled.append((int(snum), course))

# Read Faculty File
faculty = []
with open("faculty.txt", "r") as f:
    for line in f:
        fid, name, dept = line.strip().split(",")
        faculty.append({
            "fid": int(fid),
            "fname": name,
            "deptid": int(dept)
        })

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
