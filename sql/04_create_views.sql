USE CampusNavigationDB
GO
--
--Student information view
CREATE VIEW vw_StudentProfile AS
SELECT
	u.FullName,
	u.Email,
	sm.MajorName,
	ut.UserType
FROM users.Users u
JOIN users.Student s ON s.UserID = u.UserID
JOIN lookup.StudentMajor sm ON sm.MajorID = s.MajorID
JOIN lookup.UserType ut ON ut.UserTypeID = u.UserTypeID
GO
--
--Staff information view
CREATE VIEW vw_StaffProfile AS
SELECT
	u.FullName,
	u.Email,
	st.TitleName,
	sd.DepartmentName
FROM users.Users u
JOIN users.Staff s ON s.UserID = u.UserID
JOIN lookup.StaffTitle st ON st.TitleID = s.TitleID
JOIN lookup.StaffDepartment sd ON sd.DepartmentID = s.DepartmentID
GO
--
--Course info view
CREATE VIEW vw_CourseDetails AS
SELECT
	c.CourseName,
	c.Credits,
	u.FullName AS InstructorName
FROM course.Course c
JOIN users.Staff s ON s.StaffID = c.StaffID
JOIN users.Users u ON u.UserID = s.UserID
GO
--
--Courses taken by the student
CREATE VIEW vw_StudentCourseList AS
SELECT
	u.FullName,
	c.CourseName,
	c.Credits
FROM users.Student s
JOIN users.Users u ON u.UserID = s.UserID
JOIN course.Course_Student cs ON cs.StudentID = s.StudentID
JOIN course.Course c ON c.CourseID = cs.CourseID
GO
--
--Room Schedule info view
CREATE VIEW vw_RoomSchedule AS
SELECT
	f.FacilityName,
	r.RoomName,
	c.CourseName,
	rs.StartTime,
	rs.EndTime
FROM course.RoomSchedule rs
JOIN campus.Room r ON r.RoomID = rs.RoomID
JOIN campus.Facility f ON f.FacilityID = r.FacilityID
JOIN course.Course c ON c.CourseID = rs.CourseID
GO
--
--Info about maintenance
CREATE VIEW vw_MaintenanceRequest AS
SELECT
	mr.RequestID,
	u.FullName,
	f.FacilityName,
	r.RoomName,
	ms.StatusName,
	mr.RequestTime,
	mr.CompletedTime
FROM campus.MaintenanceRequest mr
JOIN users.Users u ON u.UserID = mr.UserID
JOIN campus.Room r ON r.RoomID = mr.RoomID
JOIN campus.Facility f ON f.FacilityID = r.FacilityID
JOIN lookup.MaintenanceStatus ms ON ms.StatusID = mr.StatusID
GO
--
--Accessibilty Feature infos
CREATE VIEW vw_RoomAccessibility AS
SELECT
	r.RoomID,
	r.RoomName,
	af.FeatureName
FROM campus.Room r
JOIN campus.RoomAccessibilityFeature raf ON raf.RoomID = r.RoomID
JOIN campus.AccessibilityFeature af ON af.FeatureID = raf.FeatureID
JOIN campus.Facility f ON f.FacilityID = r.FacilityID
GO
--
