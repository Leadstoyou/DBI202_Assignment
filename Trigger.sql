	-- Trigger
	
	CREATE OR ALTER TRIGGER UTG_InsertMark ON Mark
FOR INSERT
AS
	DECLARE @Grade  INT ;
	SELECT @Grade =[Value] FROM Mark WHERE GradeCode NOT LIKE 'LAB211_EX'

	IF (@Grade > 10)
	BEGIN 
		PRINT 'INVALID VALUE GRADE,PLEASE TRY AGAIN'
		ROLLBACK TRAN
		END

	-- Views


	CREATE VIEW [View_Subject_Detail] AS
	SELECT s.SubjectID,s.SubjectName,sd.Category,sd.CompletionCriteria,sd.Duration,sd.GradingGuide,sd.KnowledgeAndSkill,sd.NoQuestion,sd.QuestionType,sd.Note  FROM [Subject] s
	INNER JOIN Subject_Detail sd ON s.SubjectID = sd.SubjectID
	
	-- StoredProcedures


	CREATE OR ALTER PROC USP_Show_Lecture_List
	AS
	SELECT sem.SemesterName,sub.SubjectID,sub.SubjectName,ss.StartDate,ss.EndDate,ls.LectureID,l.LectureName FROM Semester sem
	INNER JOIN Semester_Subject ss ON sem.SemesterID = ss.SemesterID 
	INNER JOIN [Subject] sub ON sub.SubjectID = ss.SubjectID
	INNER JOIN Lecture_Subject ls ON ls.SubjectID = sub.SubjectID
	INNER JOIN Lecture l ON l.LectureID = ls.LectureID

	CREATE OR ALTER PROC USP_Show_Student_List
	AS
	SELECT gs.SubjectID,sub.SubjectName,s.StudentID,CONCAT(s.SurName , ' ', s.MiddleName , ' ' , s.GivenName) AS [FullName] FROM Student s 
	INNER JOIN Group_Student gs ON gs.StudentID = s.StudentID
	INNER JOIN [Subject] sub ON sub.SubjectID = gs.SubjectID
	GROUP BY s.StudentID,s.SurName,s.MiddleName,s.GivenName,gs.StudentID,gs.SubjectID,sub.SubjectName
	ORDER BY gs.SubjectID DESC
	

	--Indexed
	CREATE UNIQUE INDEX Index_Student_Name
	ON Student (StudentID);