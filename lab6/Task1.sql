--------1-----------------------
create proc CountOfAvgMarkforPeriod1  as
select s.Kod_stud,s.Name_ini, avg(r.Reiting) as [AVG]
from(dbo_student s join Reiting r on s.Kod_stud = r.Kod_student)
join Rozklad_pids rp on r.K_zapis = rp.K_zapis
group by s.Kod_stud,s.Name_ini


exec CountOfAvgMarkforPeriod1



--------2---------------------------


create proc CountOfAvgMarkforPeriod2
As
begin
select s.Kod_stud,s.Name_ini, avg(r.Reiting) as [AVG]
from dbo_student s join Reiting r on s.Kod_stud = r.Kod_student
join Rozklad_pids rp on r.K_zapis = rp.K_zapis
where  r.Reiting >=60
group by s.Kod_stud,s.Name_ini
end

exec CountOfAvgMarkforPeriod2 


--------3----------------

create view avgStuds as
select s.Kod_stud, s.Name_ini, avg(r.Reiting) as [avg]
from [dbo_student] s join Reiting r on s.Kod_stud = r.Kod_student
group by s.Kod_stud, s.Name_ini

create proc Task3
as 
begin
select rw.Kod_stud, rw.Name_ini, rw.[avg]
from avgStuds rw
where  rw.[avg] >= 74
end

exec Task3




------4------------
create proc Task4 as
begin
select s.Name_ini, AVG(r.Reiting) as [Reiting],
CASE
when AVG(r.Reiting) between 90 and 100 then 5
when AVG(r.Reiting) between 74 and 89 then 4
when AVG(r.Reiting) between 60 and 74 then 3
when AVG(r.Reiting) between 1 and 59 then 2
end as 'Mark(2-5)',
CASE
when AVG(r.Reiting) between 90 and 100 then 'A'
when AVG(r.Reiting) between 85 and 89 then 'B'
when AVG(r.Reiting) between 75 and 84 then 'C'
when AVG(r.Reiting) between 65 and 74 then 'D'
when AVG(r.Reiting) between 60 and 65 then 'E'
when AVG(r.Reiting) between 35 and 59 then 'FX'
when AVG(r.Reiting) between 1 and 34 then 'F'
end as 'ECTS'
from dbo_student s join Reiting r on r.Kod_student = s.Kod_stud
group by s.Name_ini
end

execute Task4


-----------5---------
DROP TRIGGER IF EXISTS task1_5

GO
CREATE TRIGGER task1_5 ON dbo_student INSTEAD OF INSERT AS
DECLARE @Sname NVARCHAR(50) = (SELECT Sname FROM INSERTED)
DECLARE @Name NVARCHAR(50) = (SELECT [Name] FROM INSERTED)
DECLARE @Fname NVARCHAR(50) = (SELECT Fname FROM INSERTED)
DECLARE @N_ingroup INT = (SELECT N_ingroup FROM INSERTED)
DECLARE @group NVARCHAR(50) = (SELECT Kod_group FROM INSERTED)
BEGIN
	IF NOT EXISTS(
	SELECT Kod_group FROM dbo_groups
	WHERE Kod_group = @group
	)
	BEGIN
		INSERT dbo_groups ([Kod_group], [K_navch_plan], [kilk]) 
		VALUES (@group, 1, 1)
	END
	
	INSERT dbo_student ([Sname], [Name], [Fname], [N_ingroup], [Kod_group]) 
	VALUES (@Sname, @Name, @Fname, @N_ingroup, @group)
END


SELECT * FROM dbo_groups


-----------6------
DROP TRIGGER IF EXISTS task1_6

GO
CREATE TRIGGER task1_6 ON dbo_student AFTER DELETE AS
DECLARE @group NVARCHAR(50) = (SELECT Kod_group FROM DELETED)
BEGIN
	IF NOT EXISTS(
	SELECT Kod_group FROM dbo_student
	WHERE Kod_group = @group
	)
	BEGIN
		PRINT @group
		DELETE FROM dbo_groups 
		WHERE Kod_group = @group
	END
	ELSE
	BEGIN
		PRINT 'FOUND'
	END
END


