use University
---------1------------

SELECT Student.FirstName, Student.LastName, [Group].Name, Speciality.Name
FROM (Student join [Group] on Student.GroupID = [Group].GroupID)
join Speciality on [Group].SpecialityID = Speciality.SpecialityID


DELETE Student FROM Student join Deduction on Student.StudentID = Deduction.StudentID
WHERE Reason = '��������� ����������'


SELECT Speciality.Name, COUNT(Student.StudentID) as NumberOfStudent
FROM (Student join [Group] on Student.GroupID = [Group].GroupID)
join Speciality on [Group].SpecialityID = Speciality.SpecialityID
GROUP BY Speciality.Name


---------2------------

Insert into Speciality (Nubmer, [Name], Qualification)
Values (1234, '��������� �����','��������')

Insert into [Group] ([Name], Amount, SpecialityID)
Values ('��-21-2', 13, 2)

Insert into Student(FirstName, LastName, DateOfBirth, HomeAddress, CurrentAddress, DareOfStart, TypeOfStudy, Department, NumberOfGradeBook, DateOfDeduction, GroupID)
Values ('�����', '�����', '1/30/2005','��� �������', '��� ��������', '01/09/2021', '�����������', 'Բ��', 1247, '10/06/2025', 4)

Insert into  Deduction(Reason, StudentID)
Values ('��������� ���������', 1)

---Update----

UPDATE Speciality SET Nubmer =  1234, [Name] = '��������� �����', Qualification = '��������' where Speciality.SpecialityID = 1
UPDATE [Group] SET [Name] =  '��-21-2', Amount = 13, SpecialityID = 2 where [Group].GroupID = 1
UPDATE Student SET FirstName = '�����', LastName = '�����', DateOfBirth = '1/30/2005', HomeAddress = '��� �������',
CurrentAddress = '��� ��������', DareOfStart = '01/09/2021', TypeOfStudy = '�����������', Department = 'Բ��',
NumberOfGradeBook = 1247, DateOfDeduction = '10/06/2025', GroupID = 4 where StudentID = 1
UPDATE Deduction SET Reason = '��������� ���������', StudentID = 1 where Deduction.DeductionID = 1



---------3------------

Insert into Speciality (Nubmer, [Name], Qualification)
Values (1234, '��������� �����','��������'),
(1235, '���������� �����','��������')

Insert into [Group] ([Name], Amount, SpecialityID)
Values ('��-21-3', 14, 2),
('��-21-2', 13, 2)


Insert into Student(FirstName, LastName, DateOfBirth, HomeAddress, CurrentAddress, DareOfStart, TypeOfStudy, Department, NumberOfGradeBook, DateOfDeduction, GroupID)
Values ('�����', '�����', '1/30/2005','��� �������', '��� ��������', '01/09/2021', '�����������', 'Բ��', 1247, '10/06/2025', 4),
('�����', '�����', '1/30/2005','��� �������', '��� ��������', '01/09/2021', '�����������', 'Բ��', 1247, '10/06/2025', 4)


Insert into  Deduction(Reason, StudentID)
Values ('��������� ���������', 1),
('��������� ���������', 2)


UPDATE Speciality SET Nubmer =  1234, [Name] = '��������� �����', Qualification = '��������' where Speciality.Qualification = '����������'
UPDATE [Group] SET [Name] =  '��-21-2', Amount = 13, SpecialityID = 2 where [Group].Amount > 10
UPDATE Student SET FirstName = '�����', LastName = '�����', DateOfBirth = '1/30/2005', HomeAddress = '��� �������',
CurrentAddress = '��� ��������', DareOfStart = '01/09/2021', TypeOfStudy = '�����������', Department = 'Բ��',
NumberOfGradeBook = 1247, DateOfDeduction = '10/06/2025', GroupID = 4 where Department = 'Բ��'
UPDATE Deduction SET Reason = '��������� ���������', StudentID = 1 where Deduction.Reason = '��������� ���������'




-----------4---------------

declare @id_stud int = 5
SELECT * FROM Student 
WHERE StudentID > @id_stud

declare @studName varchar(20) ='������'
SELECT StudentID, NumberOfGradeBook, FirstName, LastName FROM Student 
WHERE FirstName like @studName


declare
@from int = 15,
@to int = 30
SELECT * FROM [Group] 
WHERE Amount Between @from and @to

SELECT FirstName, LastName FROM Student 
WHERE not(StudentID  is null)



SELECT * from [Group] join Student
on Student.GroupID = [Group].GroupID


SELECT *
FROM Student
WHERE Student.StudentID In (2,5);



