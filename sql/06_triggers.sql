USE CampusNavigationDB
GO

--Trigger for automatic date update
CREATE TRIGGER trg_SetCompletedTime
ON campus.MaintenanceRequest
AFTER UPDATE
AS
BEGIN
	UPDATE mr
	SET CompletedTime = GETDATE()
	FROM campus.MaintenanceRequest mr
	JOIN inserted i ON mr.RequestID = i.RequestID
	JOIN lookup.MaintenanceStatus ms ON ms.StatusID = mr.StatusID
	WHERE 
		ms.StatusName = 'Completed' AND mr.CompletedTime IS NULL;
END
GO
--
--Trigger for blocking same room-same hour inserting
CREATE TRIGGER trg_BlockRoomScheduleConflict
ON course.RoomSchedule
AFTER INSERT
AS
BEGIN
	IF EXISTS(
		SELECT 1
		FROM course.RoomSchedule rs
		JOIN inserted i ON i.RoomID = rs.RoomID
		AND rs.ScheduleDate = i.ScheduleDate
		AND rs.ScheduleID <> i.ScheduleID
		AND i.StartTime < rs.EndTime
		AND i.EndTime > rs.StartTime
	)
	BEGIN
		THROW 50020, 'Schedule conflict: Room is already booked at this time.', 1;
	END
END
GO

--
--Trigger for deleting student's course when the student deleted.
CREATE TRIGGER trg_DeleteStudentCourses
ON users.Student
AFTER DELETE
AS
BEGIN
	DELETE cs
	FROM course.Course_Student cs
	JOIN deleted d ON d.StudentID = cs.StudentID
END
GO
--
--Trigger for updating automatic room status
CREATE TRIGGER trg_SetRoomUnderMaintenance
ON campus.Room
AFTER INSERT
AS
BEGIN
	UPDATE r
	SET r.RoomStatusID = rs.RoomStatusID
	FROM campus.Room r
	JOIN inserted i ON i.RoomID = r.RoomID
	JOIN lookup.RoomStatus rs ON rs.RoomStatus = 'UnderMaintenance';
END
GO
