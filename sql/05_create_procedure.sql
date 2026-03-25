USE CampusNavigationDB
GO
--Procedure for adding a new student
CREATE PROCEDURE sp_AddStudent 
	@FullName varchar(100),
	@Email varchar(100),
	@Gender char(1),
	@BirthDate date,
	@MajorID int
AS
BEGIN

	DECLARE @UserTypeID int;
	DECLARE @UserID int;

	BEGIN TRANSACTION
		BEGIN TRY
			SELECT @UserTypeID = UserTypeID
			FROM lookup.UserType
			WHERE UserType = 'Student';

			INSERT into users.Users(FullName, Email, Gender, BirthDate, UserTypeID)
			VALUES (@FullName, @Email, @Gender, @BirthDate, @UserTypeID);

			SET @UserID = SCOPE_IDENTITY();

			INSERT INTO users.Student(UserID, MajorID)
			VALUES (@UserID, @MajorID);
			
	COMMIT TRANSACTION
		END TRY

		BEGIN CATCH
			ROLLBACK TRANSACTION
			THROW;
		END CATCH
END
GO
--
--
--Procedure for assigning a Student to a course
CREATE PROCEDURE sp_AssignStudentToCourse
	@StudentID int,
	@CourseID int
AS
BEGIN
	BEGIN TRY

		IF NOT EXISTS(
			SELECT 1
			FROM users.Student
			WHERE StudentID = @StudentID
		)
		BEGIN
			THROW 50002, 'Student not found.', 1;
		END

		IF NOT EXISTS(
			SELECT 1
			FROM course.Course
			WHERE CourseID = @CourseID
		)
		BEGIN 
			THROW 500010, 'Course not found.', 1;
		END

		IF EXISTS (
			SELECT 1
			FROM course.Course_Student
			WHERE StudentID = @StudentID AND CourseID = @CourseID
		)
		BEGIN
			THROW 50001, 'Student is already enrolled in this course.', 1;
		END
		ELSE
		BEGIN
			INSERT into course.Course_Student(StudentID, CourseID)
			VALUES (@StudentID, @CourseID);
		END

	END TRY
	BEGIN CATCH 
		THROW;
	END CATCH
END
GO
--
--Procedure for Creating a Maintenance Request
CREATE PROCEDURE sp_CreateMaintenanceRequest
	@UserID int,
	@RoomID int,
	@Description varchar(255)
AS
BEGIN

	DECLARE @StatusID int;

	SELECT @StatusID = StatusID
	FROM lookup.MaintenanceStatus
	WHERE  StatusName = 'Pending';

	INSERT into campus.MaintenanceRequest(UserID, RoomID, StatusID, MaintenanceDescription,RequestTime,CompletedTime)
	VALUES (@UserID, @RoomID, @StatusID, @Description, GETDATE(), NULL);
END
GO
--
--Procedure For Updating Maintenance request Status
CREATE PROCEDURE sp_UpdateMaintenanceStatus
	@RequestID int,
	@NewStatusID int
AS
BEGIN
	BEGIN TRY
		IF EXISTS(
			SELECT 1
			FROM campus.MaintenanceRequest
			WHERE RequestID = @RequestID AND CompletedTime IS NULL)
		BEGIN
			UPDATE campus.MaintenanceRequest 
			SET 
				StatusID = @NewStatusID,
				CompletedTime = GETDATE()
			WHERE RequestID = @RequestID;
		END
		ELSE
		BEGIN
			THROW 50003, 'Maintenance request not found or already completed.', 1;
		END
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
--
--Procedure for retrieving room schedules by date
CREATE PROCEDURE sp_GetRoomScheduleByDate
	@Date date
AS
BEGIN
	SELECT 
		r.RoomName,
		c.CourseName,
		rs.StartTime,
		rs.EndTime
	FROM course.RoomSchedule rs
	JOIN campus.Room r ON r.RoomID = rs.RoomID
	JOIN course.Course c ON c.CourseID = rs.CourseID
	WHERE rs.ScheduleDate = @Date
END
GO
--
--Procedure for assigning an instructor to a course
CREATE PROCEDURE sp_AssignInstructorToCourse
	@CourseID int,
	@NewStaffID int
AS
BEGIN
	BEGIN TRY
		IF NOT EXISTS(
			SELECT 1
			FROM course.Course
			WHERE CourseID = @CourseID
		)
		BEGIN
			THROW 50004, 'Course not found.', 1;
		END

		IF NOT EXISTS(
			SELECT 1
			FROM users.Staff
			WHERE StaffID = @NewStaffID
		)
		BEGIN
			THROW 50005, 'Instructor (Staff) not found.', 1;
		END

		UPDATE course.Course 
		SET StaffID = @NewStaffID
		WHERE CourseID = @CourseID;
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END
GO
