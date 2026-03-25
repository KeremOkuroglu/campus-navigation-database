USE CampusNavigationDB
GO

--Inserting values into lookup tables
-- USER TYPES
INSERT INTO lookup.UserType(UserType)
VALUES ('Student'), ('Staff'), ('Admin');

-- MAJORS
INSERT INTO lookup.StudentMajor(MajorName)
VALUES ('Computer Engineering'), ('Architecture'), ('Business Administration');

-- STAFF TITLES
INSERT INTO lookup.StaffTitle(TitleName)
VALUES ('Professor'), ('Assistant Professor'), ('Lecturer');

-- DEPARTMENTS
INSERT INTO lookup.StaffDepartment(DepartmentName)
VALUES ('Engineering Faculty'), ('Architecture Faculty'), ('Business Faculty');

-- ROOM TYPES
INSERT INTO lookup.RoomType(RoomTypeName)
VALUES ('Classroom'), ('Laboratory'), ('Office');

-- ROOM STATUS
INSERT INTO lookup.RoomStatus(RoomStatus)
VALUES ('Available'), ('Occupied'), ('UnderMaintenance');

-- MAINTENANCE STATUS
INSERT INTO lookup.MaintenanceStatus(StatusName)
VALUES ('Pending'), ('InProgress'), ('Completed');

-- ACCESSIBILITY FEATURES
INSERT INTO campus.AccessibilityFeature(FeatureName)
VALUES ('Wheelchair Access'), ('Elevator'), ('Braille Signs');

----------------------------------------------------------------

--USERS
INSERT INTO users.Users (UserTypeID, FullName, Gender, Email, BirthDate)
VALUES
(1,'Ali Yilmaz','M','ali@uni.edu','2002-05-10'),
(1,'Ayse Demir','F','ayse@uni.edu','2001-08-22'),
(1,'Can Kaya','M','can@uni.edu','2003-02-12'),
(1,'Zeynep Arslan','F','zeynep@uni.edu','2002-11-05'),
(1,'Emre Aydin','M','emre@uni.edu','2001-03-17'),
(1,'Elif Koc','F','elif@uni.edu','2002-07-19'),
(1,'Mert Sahin','M','mert@uni.edu','2003-01-01'),
(1,'Deniz Celik','F','deniz@uni.edu','2002-09-09'),
(1,'Burak Yildiz','M','burak@uni.edu','2001-12-12'),
(1,'Selin Kurt','F','selin@uni.edu','2002-04-04'),

(2,'Dr. Mehmet Kaya','M','mehmet@uni.edu','1980-03-15'),
(2,'Dr. Ayhan Demir','M','ayhan@uni.edu','1975-06-20'),
(2,'Dr. Seda Yilmaz','F','seda@uni.edu','1985-11-11'),
(2,'Dr. Murat Can','M','murat@uni.edu','1978-08-08'),
(2,'Dr. Elif Ozturk','F','elif.staff@uni.edu','1982-02-02');

--STUDENTS
INSERT INTO users.Student (UserID, MajorID)
VALUES
(1,1),(2,2),(3,1),(4,3),(5,1),
(6,2),(7,1),(8,3),(9,2),(10,1);

--STAFF
INSERT INTO users.Staff (UserID, TitleID, DepartmentID)
VALUES
(11,1,1),
(12,2,1),
(13,1,2),
(14,3,1),
(15,2,3);

--FACILITY
INSERT INTO campus.Facility(FacilityName, NumberOfFloors, FacilityLocation)
VALUES
('Engineering Building',5,'North Campus'),
('Architecture Building',3,'Central Campus'),
('Business Building',4,'South Campus'),
('Library',6,'Central Campus'),
('Science Lab Complex',4,'West Campus');

--ROOM
INSERT INTO campus.Room(RoomTypeID, RoomStatusID, FacilityID, RoomName, Capacity, FloorNumber)
VALUES
(1,1,1,'E101',40,1),(1,1,1,'E102',35,1),(2,1,1,'Lab201',25,2),
(1,1,2,'A101',30,1),(1,1,2,'A202',45,2),(3,1,2,'Office1',10,1),
(1,1,3,'B101',50,1),(1,1,3,'B202',60,2),(3,1,3,'Office2',8,2),
(1,1,4,'L101',100,1),(3,1,4,'Admin1',15,2),
(2,1,5,'SciLab1',20,1),(2,1,5,'SciLab2',20,2),
(1,1,5,'S101',35,1),(1,1,5,'S102',30,1);

--COURSES
INSERT INTO course.Course(StaffID, CourseName, Credits)
VALUES
(1,'Database Systems',4),
(2,'Data Structures',3),
(3,'Architectural Design',5),
(4,'Algorithms',4),
(5,'Project Management',3),
(1,'Operating Systems',4),
(2,'Computer Networks',3),
(3,'Urban Design',4),
(4,'Software Engineering',4),
(5,'Business Analytics',3);


--COURSE-STUDENT
EXEC sp_AssignStudentToCourse 1,1;
EXEC sp_AssignStudentToCourse 2,1;
EXEC sp_AssignStudentToCourse 3,2;
EXEC sp_AssignStudentToCourse 4,3;
EXEC sp_AssignStudentToCourse 5,4;
EXEC sp_AssignStudentToCourse 6,5;
EXEC sp_AssignStudentToCourse 7,6;
EXEC sp_AssignStudentToCourse 8,7;
EXEC sp_AssignStudentToCourse 9,8;
EXEC sp_AssignStudentToCourse 10,9;

EXEC sp_AssignStudentToCourse 1,2;
EXEC sp_AssignStudentToCourse 2,3;
EXEC sp_AssignStudentToCourse 3,4;
EXEC sp_AssignStudentToCourse 4,5;
EXEC sp_AssignStudentToCourse 5,6;

--ROOM SCHEDULE (15 kay�t)
INSERT INTO course.RoomSchedule(RoomID, CourseID, ScheduleDate, StartTime, EndTime)
VALUES
(1,1,'2026-03-25','2026-03-25 09:00','2026-03-25 11:00'),
(2,2,'2026-03-25','2026-03-25 11:00','2026-03-25 13:00'),
(3,3,'2026-03-25','2026-03-25 13:00','2026-03-25 15:00'),
(4,4,'2026-03-26','2026-03-26 09:00','2026-03-26 11:00'),
(5,5,'2026-03-26','2026-03-26 11:00','2026-03-26 13:00'),
(6,6,'2026-03-26','2026-03-26 13:00','2026-03-26 15:00'),
(7,7,'2026-03-27','2026-03-27 09:00','2026-03-27 11:00'),
(8,8,'2026-03-27','2026-03-27 11:00','2026-03-27 13:00'),
(9,9,'2026-03-27','2026-03-27 13:00','2026-03-27 15:00'),
(10,10,'2026-03-28','2026-03-28 09:00','2026-03-28 11:00'),
(11,1,'2026-03-28','2026-03-28 11:00','2026-03-28 13:00'),
(12,2,'2026-03-28','2026-03-28 13:00','2026-03-28 15:00'),
(13,3,'2026-03-29','2026-03-29 09:00','2026-03-29 11:00'),
(14,4,'2026-03-29','2026-03-29 11:00','2026-03-29 13:00'),
(15,5,'2026-03-29','2026-03-29 13:00','2026-03-29 15:00');

--ACCESSIBILITY
INSERT INTO campus.RoomAccessibilityFeature(RoomID, FeatureID)
VALUES
(1,1),(1,2),(2,1),(3,1),(4,2),
(5,1),(6,3),(7,1),(8,2),(9,1);

--MAINTENANCE
EXEC sp_CreateMaintenanceRequest 1,1,'Projector not working';
EXEC sp_CreateMaintenanceRequest 2,2,'Air conditioning broken';
EXEC sp_CreateMaintenanceRequest 3,3,'Lighting issue';
EXEC sp_CreateMaintenanceRequest 4,4,'Broken chair';
EXEC sp_CreateMaintenanceRequest 5,5,'Smart board error';
EXEC sp_CreateMaintenanceRequest 6,6,'Door lock issue';
EXEC sp_CreateMaintenanceRequest 7,7,'Window broken';
EXEC sp_CreateMaintenanceRequest 8,8,'Cleaning required';
EXEC sp_CreateMaintenanceRequest 9,9,'Electric problem';
EXEC sp_CreateMaintenanceRequest 10,10,'Heating issue';

GO
