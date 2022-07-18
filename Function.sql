CREATE OR ALTER FUNCTION GetStatus
(
	@Student_ID CHAR(8),
	@Subject_ID VARCHAR(10)
)
RETURNS VARCHAR(20)
AS
BEGIN
		DECLARE @Status VARCHAR(20);
		DECLARE @Total_grade FLOAT;
		DECLARE @Slot_attend FLOAT ;
		DECLARE @Total_slot FLOAT ;
		DECLARE @Com_point FLOAT;
		DECLARE @Final_Exam FLOAT;
		SET @Status = 'PASSED';

			
		--Attendance



		SELECT  @Slot_attend= COUNT(att.AttendaceStatus) FROM Attendance att
		WHERE att.AttendaceStatus = '1' AND att.StudentID = @Student_ID AND att.SubjectID = @Subject_ID;
		
		SELECT  @Total_slot = COUNT(att.AttendaceStatus) FROM Attendance att
		GROUP BY att.SubjectID
		HAVING att.SubjectID = @Student_ID;

		
		IF (@Slot_attend) /(@Total_slot) < 0.8
		BEGIN 
			SET @Status = 'False Attendance';
		END

			
		--TOTAL False

		SELECT @Total_grade = SUM(m.[value]  * sm.[weight])/100 FROM Student s
	INNER JOIN Mark m ON m.StudentID = s.StudentID
	INNER JOIN Subject_Mark sm ON sm.GradeCode = m.GradeCode
	INNER JOIN [Subject] sub ON sub.SubjectID = sm.SubjectID
	GROUP BY sub.SubjectName,s.StudentID,sub.SubjectID
	HAVING s.StudentID = '@Student_ID' AND  sub.SubjectID LIKE '@Subject_ID'
		
		
		IF( @Total_grade < 5 )
			BEGIN 
				SET @Status = 'NOT PASS(total false)';
			END

		--FE < 4

		SELECT @Final_Exam = (sm.[Weight] * m.[Value]) FROM Student s
		LEFT JOIN Mark m ON m.StudentID = s.StudentID
		LEFT JOIN Subject_Mark sm ON sm.GradeCode = m.GradeCode
		GROUP BY m.[Value],s.StudentID,sm.SubjectID,sm.[Weight],sm.GradeCode
		HAVING s.StudentID LIKE '@Subject_ID' AND sm.SubjectID LIKE '@Subject_ID' AND sm.GradeCode LIKE '%FE';

			IF @Final_Exam < 4
				BEGIN
					SET @Status = 'NOT PASS';
				END

		-- Component point = 0

		SELECT @Com_point = MIN(m.[Value]) FROM Student s
		LEFT JOIN Mark m ON m.StudentID = s.StudentID
		LEFT JOIN Subject_Mark sm ON sm.GradeCode = m.GradeCode
		GROUP BY m.[Value],s.StudentID,sm.SubjectID,sm.GradeCode
		HAVING s.StudentID LIKE '@Student_ID' AND sm.SubjectID LIKE '@Subject_ID' AND sm.GradeCode NOT LIKE '%FE%';

			IF @Com_point = 0
				BEGIN 
					SET @Status = 'NOT PASS';
				END

			RETURN @Status;
END;