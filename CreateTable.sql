
USE master
GO


CREATE DATABASE Assignment_DBI202
GO

USE Assignment_DBI202
GO

CREATE TABLE Student (
	StudentID VARCHAR (8)  NOT NULL,
	SurName NVARCHAR(15) NOT NULL,
	MiddleName NVARCHAR(15) NOT NULL,
	GivenName NVARCHAR(15) NOT NULL,
	[Address] NVARCHAR(50) NOT NULL,
	Gender BIT NOT NULL,
	DOB DATE NOT NULL,
	PhoneNumber CHAR (10) NOT NULL,

	PRIMARY KEY(StudentID),
	)


CREATE TABLE Lecture (
	LectureID VARCHAR(10) NOT NULL,
	LectureName NVARCHAR (30) NOT NULL,
	PRIMARY KEY (LectureID),
	)

CREATE TABLE Semester (
	SemesterID VARCHAR(10) NOT NULL,
	SemesterName VARCHAR (20) NOT NULL,

	PRIMARY KEY (SemesterID),
	)

CREATE TABLE [Subject](
	SubjectID VARCHAR (10)  NOT NULL,
	SubjectName NVARCHAR (30) NOT NULL,

	PRIMARY KEY (SubjectID),
	)




CREATE TABLE Subject_Mark (
	SubjectID VARCHAR (10) NOT NULL,
	GradeCode VARCHAR (15) NOT NULL,
	Category VARCHAR (20) NOT NULL,
	GradeItem VARCHAR(20) NOT NULL,
	[Weight] INT ,

	PRIMARY KEY (GradeCode),
	FOREIGN KEY (SubjectID) REFERENCES [Subject](SubjectID),
	)
CREATE TABLE Subject_Detail(
	SubjectID VARCHAR (10) NOT NULL,
	Category VARCHAR (20) NOT NULL,
	CompletionCriteria CHAR(3),
	Duration VARCHAR (20),
	QuestionType VARCHAR(30),
	NoQuestion TINYINT,
	KnowledgeAndSkill VARCHAR(40),
	GradingGuide VARCHAR(30),
	Note VARCHAR(50),

	PRIMARY KEY(SubjectID,Category),
	FOREIGN KEY (SubjectID) REFERENCES [Subject](SubjectID),
	)	
CREATE TABLE Mark (
	StudentID VARCHAR (8) NOT NULL,
	GradeCode VARCHAR (15) NOT NULL,
	[Value] FLOAT,
	Comment VARCHAR(50),

	PRIMARY KEY (StudentID,GradeCode),
	FOREIGN KEY (GradeCode) REFERENCES [Subject_Mark](GradeCode),
	FOREIGN KEY (StudentID) REFERENCES [Student](StudentID),
	)

CREATE TABLE [Group](
	GroupID VARCHAR (8) NOT NULL,
	GroupName VARCHAR (25) NOT NULL,
	PRIMARY KEY (GroupID),
	
)

CREATE TABLE Group_Student(
	SemesterID VARCHAR(10) NOT NULL,
	GroupID VARCHAR (8) NOT NULL,
	SubjectID VARCHAR (10) NOT NULL,
	StudentID VARCHAR (8)  NOT NULL,
	

	PRIMARY KEY (StudentID,SemesterID,GroupID,SubjectID),

	FOREIGN KEY (SubjectID) REFERENCES [Subject](SubjectID),
	FOREIGN KEY (GroupID) REFERENCES [Group](GroupID),
	FOREIGN KEY (StudentID) REFERENCES [Student](StudentID),
	FOREIGN KEY (SemesterID) REFERENCES [Semester](SemesterID),
	)


CREATE TABLE Lecture_Subject(
	LectureID VARCHAR(10) NOT NULL,
	SubjectID VARCHAR (10) NOT NULL,
	GroupID VARCHAR (8) NOT NULL,
	PRIMARY KEY (LectureID,SubjectID,GroupID),

	FOREIGN KEY (LectureID) REFERENCES [Lecture](LectureID),
	FOREIGN KEY (SubjectID) REFERENCES [Subject](SubjectID),
	FOREIGN KEY (GroupID) REFERENCES [Group](GroupID),
	)



CREATE TABLE Attendance (
	SubjectID VARCHAR (10) NOT NULL,
	StudentID VARCHAR (8) NOT NULL,
	Number INT,
	AttendaceDate DATE NOT NULL,
	
	[AttendaceStatus] BIT , 
	PRIMARY KEY ( StudentID,SubjectID,Number),
	FOREIGN KEY (SubjectID) REFERENCES  [Subject](SubjectID),
	FOREIGN KEY (StudentID) REFERENCES  [Student](StudentID),

	)
	CREATE TABLE Semester_Subject (
		SemesterID VARCHAR(10) NOT NULL,
		SubjectID VARCHAR (10)  NOT NULL,
		StartDate DATE NOT NULL,
		EndDate DATE NOT NULL,

		PRIMARY KEY(SemesterID,SubjectID),
	FOREIGN KEY (SemesterID) REFERENCES [Semester](SemesterID),
	FOREIGN KEY (SubjectID) REFERENCES [Subject](SubjectID),
	)


	


