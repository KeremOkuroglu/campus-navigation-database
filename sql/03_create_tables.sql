
USE CampusNavigationDB
GO

CREATE TABLE lookup.UserType(
	UserTypeID int NOT NULL IDENTITY(1,1),
	UserType varchar(50) UNIQUE NOT NULL,

	PRIMARY KEY(UserTypeID)
);

CREATE TABLE users.Users(
	UserID int NOT NULL IDENTITY(1,1),
	UserTypeID int NOT NULL,
	FullName varchar(100) NOT NULL,
	Gender char(1) NOT NULL,
	Email varchar(100) UNIQUE NOT NULL,
	PhoneNumber varchar(15),
	BirthDate date,
	UserAddress varchar(255),

	PRIMARY KEY(UserID),
	FOREIGN KEY(UserTypeID) REFERENCES lookup.UserType(UserTypeID)
);

CREATE TABLE lookup.StudentMajor(
	MajorID int NOT NULL IDENTITY(1,1),
	MajorName varchar(50) UNIQUE NOT NULL,

	PRIMARY KEY(MajorID)
);

CREATE TABLE users.Student(
	StudentID int NOT NULL IDENTITY(1,1),
	UserID int NOT NULL,
	MajorID int NOT NULL,

	UNIQUE(UserID),
	PRIMARY KEY(StudentID),
	FOREIGN KEY(UserID) REFERENCES users.Users(UserID),
	FOREIGN KEY(MajorID) REFERENCES lookup.StudentMajor(MajorID)
);

CREATE TABLE lookup.StaffTitle(
	TitleID int NOT NULL IDENTITY(1,1),
	TitleName varchar(50) UNIQUE NOT NULL,

	PRIMARY KEY(TitleID)
);

CREATE TABLE lookup.StaffDepartment(
	DepartmentID int NOT NULL IDENTITY(1,1),
	DepartmentName varchar(255) UNIQUE NOT NULL,

	PRIMARY KEY(DepartmentID)
);

CREATE TABLE users.Staff(
	StaffID int NOT NULL IDENTITY(1,1),
	UserID int NOT NULL,
	TitleID int NOT NULL,
	DepartmentID int NOT NULL,

	UNIQUE(UserID),
	PRIMARY KEY(StaffID),
	FOREIGN KEY(UserID) REFERENCES users.Users(UserID),
	FOREIGN KEY (TitleID) REFERENCES lookup.StaffTitle(TitleID),
	FOREIGN KEY(DepartmentID) REFERENCES lookup.StaffDepartment(DepartmentID)
);

CREATE TABLE course.Course(
	CourseID int NOT NULL IDENTITY(1,1),
	StaffID int NOT NULL,
	CourseName varchar(100) NOT NULL,
	Credits int NOT NULL,

	PRIMARY KEY(CourseID),
	FOREIGN KEY(StaffID) REFERENCES users.Staff(StaffID)
);

CREATE TABLE course.Course_Student(
	CourseID int NOT NULL,
	StudentID int NOT NULL,

	PRIMARY KEY(CourseID,StudentID),
	FOREIGN KEY(CourseID) REFERENCES course.Course(CourseID),
	FOREIGN KEY(StudentID) REFERENCES users.Student(StudentID)
);

CREATE TABLE campus.Facility(
	FacilityID int NOT NULL IDENTITY(1,1),
	FacilityName varchar(255) UNIQUE NOT NULL,
	NumberOfFloors int NOT NULL,
	FacilityLocation varchar(255) NOT NULL,

	PRIMARY KEY(FacilityID)
);

CREATE TABLE lookup.RoomType(
	RoomTypeID int NOT NULL IDENTITY(1,1),
	RoomTypeName varchar(255) UNIQUE NOT NULL,

	PRIMARY KEY(RoomTypeID)
);

CREATE TABLE lookup.RoomStatus(
	RoomStatusID int NOT NULL IDENTITY(1,1),
	RoomStatus varchar(100) UNIQUE NOT NULL,

	PRIMARY KEY(RoomStatusID)
);

CREATE TABLE campus.Room(
	RoomID int NOT NULL IDENTITY(1,1),
	RoomTypeID int NOT NULL,
	RoomStatusID int NOT NULL,
	FacilityID int NOT NULL,
	RoomName varchar(100),
	Capacity int NOT NULL,
	FloorNumber int NOT NULL,
	Corridor varchar(50),

	UNIQUE(FacilityID, RoomName),
	PRIMARY KEY(RoomID),
	FOREIGN KEY(RoomTypeID) REFERENCES lookup.RoomType(RoomTypeID),
	FOREIGN KEY(RoomStatusID) REFERENCES lookup.RoomStatus(RoomStatusID),
	FOREIGN KEY(FacilityID) REFERENCES campus.Facility(FacilityID)
);

CREATE TABLE course.RoomSchedule(
	ScheduleID int NOT NULL IDENTITY(1,1),
	RoomID int NOT NULL,
	CourseID int NOT NULL,
	ScheduleDate date NOT NULL,
	StartTime datetime NOT NULL,
	EndTime datetime NOT NULL,

	PRIMARY KEY(ScheduleID),
	FOREIGN KEY(RoomID) REFERENCES campus.Room(RoomID),
	FOREIGN KEY(CourseID) REFERENCES course.Course(CourseID)
);

CREATE TABLE campus.AccessibilityFeature(
	FeatureID int NOT NULL IDENTITY(1,1),
	FeatureName varchar(100) NOT NULL,

	PRIMARY KEY(FeatureID)
);

CREATE TABLE campus.RoomAccessibilityFeature(
	RoomID int NOT NULL,
	FeatureID int NOT NULL,

	PRIMARY KEY(RoomID, FeatureID),
	FOREIGN KEY(RoomID) REFERENCES campus.Room(RoomID),
	FOREIGN KEY(FeatureID) REFERENCES campus.AccessibilityFeature(FeatureID)
);

CREATE TABLE lookup.MaintenanceStatus(
	StatusID int NOT NULL IDENTITY(1,1),
	StatusName varchar(100) NOT NULL,

	PRIMARY KEY(StatusID)
);

CREATE TABLE campus.MaintenanceRequest(
	RequestID int NOT NULL IDENTITY(1,1),
	UserID int NOT NULL,
	RoomID int NOT NULL,
	StatusID int NOT NULL,
	MaintenanceDescription varchar(255) NOT NULL,
	RequestTime datetime NOT NULL,
	CompletedTime datetime NULL,

	PRIMARY KEY(RequestID),
	FOREIGN KEY(UserID) REFERENCES users.Users(UserID),
	FOREIGN KEY(RoomID) REFERENCES campus.Room(RoomID),
	FOREIGN KEY(StatusID) REFERENCES lookup.MaintenanceStatus(StatusID)
);
