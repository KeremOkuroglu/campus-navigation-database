USE CampusNavigationDB
GO

--Student Dashboard
SELECT * FROM vw_StudentProfile;

--Course + Instructor
SELECT * FROM vw_CourseDetails;

--Student Course List
SELECT * FROM vw_StudentCourseList
WHERE FullName = 'Ali Yilmaz';

--Room Schedule by Date
EXEC sp_GetRoomScheduleByDate '2026-03-25';

--Maintenance Tracking
SELECT * FROM vw_MaintenanceRequest;

--Room Accessibility
SELECT * FROM vw_RoomAccessibility
WHERE RoomName = 'E101';
