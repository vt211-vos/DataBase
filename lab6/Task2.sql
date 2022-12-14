--------1-----------------------
create proc Proc1 as
select [Group].[Name], count(Student.StudentID)
from Student join [Group] on Student.GroupID = [Group].GroupID
group by [Group].Name


exec Proc1

create proc Proc2 as
select [Group].[Name], [Group].Amount
from [Group]
where Amount > 10

exec Proc2

create proc Proc3 as
select *
from Student
where FirstName like ('M%')

exec Proc3





------------------2-------------------
DROP TRIGGER IF EXISTS Trig1

GO
CREATE TRIGGER Trig1 ON Student INSTEAD OF INSERT AS
DECLARE @FName NVARCHAR(50) = (SELECT FirstName FROM INSERTED)
DECLARE @LName NVARCHAR(50) = (SELECT LastName FROM INSERTED)
DECLARE @DB NVARCHAR(50) = (SELECT DateOfBirth FROM INSERTED)
DECLARE @HA NVARCHAR(50) = (SELECT HomeAddress FROM INSERTED)
DECLARE @CA NVARCHAR(50) = (SELECT CurrentAddress FROM INSERTED)
DECLARE @DS NVARCHAR(50) = (SELECT DareOfStart FROM INSERTED)
DECLARE @TS NVARCHAR(50) = (SELECT TypeOfStudy FROM INSERTED)
DECLARE @Dep NVARCHAR(50) = (SELECT Department FROM INSERTED)
DECLARE @NGB int = (SELECT NumberOfGradeBook FROM INSERTED)
DECLARE @DD NVARCHAR(50) = (SELECT DateOfDeduction FROM INSERTED)
DECLARE @GroupId int = (SELECT GroupID FROM INSERTED)
BEGIN
	IF NOT EXISTS(
	SELECT GroupID FROM [Group]
	WHERE GroupID = @GroupId
	)
	BEGIN
		INSERT [Group] ([Name], Amount, SpecialityID) 
		VALUES ('Нова група', 1, 1)
	END
	
	
	Insert into Student(FirstName, LastName, DateOfBirth, HomeAddress, CurrentAddress, DareOfStart, TypeOfStudy, Department, NumberOfGradeBook, DateOfDeduction, GroupID)
	Values (@FName, @LName, @DB, @HA, @CA, @DS, @TS, @Dep, @NGB, @DD, @GroupId)
END

---------------------------------------------
DROP TRIGGER IF EXISTS Trig2

GO
CREATE TRIGGER Trig2 ON [Group] INSTEAD OF INSERT AS
DECLARE @Name NVARCHAR(50) = (SELECT [Name] FROM INSERTED)
DECLARE @Amount NVARCHAR(50) = (SELECT Amount FROM INSERTED)
DECLARE @Sp int = (SELECT SpecialityID FROM INSERTED)

BEGIN
	IF NOT EXISTS(
	SELECT GroupID FROM [Group]
	WHERE [Name] = @Name
	)
	BEGIN
		INSERT [Group] ([Name], Amount, SpecialityID) 
		VALUES (@Name, @Amount, @Sp)
	END
	
	ELSE
	BEGIN
		PRINT 'FOUND'
	END
END

---------------------------------------

DROP TRIGGER IF EXISTS Trig3

GO
CREATE TRIGGER Trig3 ON Student AFTER DELETE AS
DECLARE @group NVARCHAR(50) = (SELECT GroupID FROM DELETED)
BEGIN
	IF NOT EXISTS(
	SELECT GroupID FROM Student
	WHERE GroupID = @group
	)
	BEGIN
		PRINT @group
		DELETE FROM [Group] 
		WHERE GroupID = @group
	END
END



