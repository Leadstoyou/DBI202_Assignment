--•	Create 10 sample queries that demonstrate the expressiveness of your database system 




-- 1.Query the final result of a subject that a student finished

SELECT CONCAT(s.SurName , ' ', s.MiddleName , ' ' , s.GivenName) AS [FullName],sub.SubjectName,SUM(m.[value] * sm.[weight])/100 AS  [Total]
  FROM Student s
INNER JOIN Mark m ON m.StudentID = s.StudentID
INNER JOIN Subject_Mark sm ON sm.GradeCode = m.GradeCode
INNER JOIN [Subject] sub ON sub.SubjectID = sm.SubjectID
GROUP BY s.SurName,s.MiddleName,s.GivenName,sub.SubjectName,s.StudentID,sub.SubjectID
HAVING s.StudentID = 'HE160153' AND  sub.SubjectID LIKE 'DBI202'


SELECT CONCAT(SurName ,' ', MiddleName , ' ', GivenName) AS [FullName] FROM Student 

--2.Query all result of a subject that a student finished 

SELECT CONCAT(s.SurName , ' ', s.MiddleName , ' ' , s.GivenName) AS [FullName],Sm.Category,m.[Value] 
FROM Student s
LEFT JOIN Mark m ON m.StudentID = s.StudentID
LEFT JOIN Subject_Mark sm ON sm.GradeCode = m.GradeCode
GROUP BY s.SurName,s.MiddleName,s.GivenName,sm.Category,m.[Value],s.StudentID,sm.SubjectID
HAVING s.StudentID = 'HE161275' AND sm.SubjectID LIKE 'DBI202'

--3.Query all a subject grade of whole class in descending order
	
	SELECT CONCAT(s.SurName , ' ', s.MiddleName , ' ' , s.GivenName) AS [FullName],sub.SubjectName,SUM(m.[value] * sm.[weight])/100 AS  [Total]
	FROM Student s
	INNER JOIN Mark m ON m.StudentID = s.StudentID
	INNER JOIN Subject_Mark sm ON sm.GradeCode = m.GradeCode
	INNER JOIN [Subject] sub ON sub.SubjectID = sm.SubjectID
	GROUP BY s.SurName,s.MiddleName,s.GivenName,sub.SubjectName,s.StudentID,sub.SubjectID
	HAVING sub.SubjectID LIKE 'DBI202'
	ORDER BY [Total] DESC

--4.   Query all the attendace of a student in a subject

	SELECT CONCAT(s.SurName , ' ', s.MiddleName , ' ' , s.GivenName) AS [FullName] ,att.Number,att.AttendaceDate,att.AttendaceStatus
	FROM Student s
	INNER JOIN Attendance att ON att.StudentID = s.StudentID
	WHERE s.StudentID = 'HE160929' AND att.SubjectID = 'CSD201'

--5.Query total attendance of a student in all subject
	SELECT CONCAT(s.SurName , ' ', s.MiddleName , ' ' , s.GivenName) AS [FullName] ,sub.SubjectName,COUNT(att.AttendaceStatus) AS [TOTAL]
	FROM Student s
	INNER JOIN Attendance att ON att.StudentID = s.StudentID
	INNER JOIN [Subject] sub ON sub.SubjectID = att.SubjectID
	WHERE att.AttendaceStatus = '1'
	GROUP BY s.SurName,s.MiddleName,s.GivenName,s.StudentID,sub.SubjectName
	HAVING s.StudentID = 'HE160929'

--6. Query all the student by date of birth
	SELECT * FROM Student 
	ORDER BY DOB DESC

--7.Query all the female student 

	SELECT * FROM Student 
	WHERE Gender = '0'

--8. Return the student passed a subject or not 
	SELECT [dbo].[GetStatus] ('HE160153', 'DBI202')
	SELECT [dbo].[GetStatus] ('HE151011', 'JPD113')
--9.
	SELECT  COUNT(att.AttendaceStatus) FROM Attendance att
		WHERE att.AttendaceStatus = '1' AND att.StudentID LIKE 'HE151011' AND att.SubjectID LIKE 'JPD113';
		
		SELECT  COUNT(att.AttendaceStatus) FROM Attendance att
		WHERE att.StudentID LIKE 'HE151011' AND att.SubjectID LIKE 'JPD113';
