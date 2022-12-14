use reiting

/*1*/
SELECT Name_ini, SUM(reiting.Reiting)
FROM dbo_student join reiting on dbo_student.Kod_stud = reiting.Kod_student
GROUP BY Name_ini


/*2*/
SELECT Kod_group, kilk
FROM dbo_groups


/*3*/
SELECT  Kod_group, SUM(K_predm_pl)
FROM Rozklad_pids
GROUP BY Kod_group


/*4*/
SELECT  Kod_group, SUM(N_vedomost)
FROM Rozklad_pids
GROUP BY Kod_group


/*5*/
SELECT g.Kod_group,avg(r.Reiting)AS Avg_point
FROM dbo_groups g JOIN dbo_student s ON g.Kod_group=s.Kod_group
JOIN Reiting r ON s.Kod_stud=r.Kod_student
GROUP BY g.Kod_group


/*6*/
SELECT p.Nazva,avg(reit.Reiting)
FROM Reiting reit INNER JOIN Rozklad_pids rozk ON reit.K_zapis=rozk.K_zapis
JOIN Predmet_plan pp ON rozk.K_predm_pl=pp.K_predm_pl
JOIN predmet p ON pp.K_predmet=p.K_predmet
GROUP BY p.Nazva

/*7*/
SELECT Name_ini, Reiting, Nazva
FROM dbo_student s JOIN Reiting reit ON reit.Kod_student=s.Kod_stud
JOIN Rozklad_pids rozk ON reit.K_zapis=rozk.K_zapis
JOIN Predmet_plan pp ON rozk.K_predm_pl=pp.K_predm_pl
JOIN predmet p ON pp.K_predmet=p.K_predmet

/*8*/

SELECT p.Nazva,min(reit.Reiting)
FROM dbo_student s JOIN Reiting reit ON reit.Kod_student=s.Kod_stud
JOIN Rozklad_pids rozk ON reit.K_zapis=rozk.K_zapis
JOIN Predmet_plan pp ON rozk.K_predm_pl=pp.K_predm_pl
JOIN predmet p ON pp.K_predmet=p.K_predmet
GROUP BY p.Nazva

/*9*/
SELECT p.Nazva,max(reit.Reiting)
FROM dbo_student s JOIN Reiting reit ON reit.Kod_student=s.Kod_stud
JOIN Rozklad_pids rozk ON reit.K_zapis=rozk.K_zapis
JOIN Predmet_plan pp ON rozk.K_predm_pl=pp.K_predm_pl
JOIN predmet p ON pp.K_predmet=p.K_predmet
GROUP BY p.Nazva

/*10*/
SELECT p.Nazva,fn.V_form, sum(rozk.k_vilkad)
FROM Rozklad_pids rozk JOIN Predmet_plan pp ON rozk.K_predm_pl=pp.K_predm_pl
JOIN predmet p ON p.K_predmet=pp.K_predmet
JOIN Navch_plan np ON pp.K_navch_plan=np.K_navch_plan
JOIN Form_navch fn ON np.k_form=fn.K_form
GROUP BY p.Nazva, fn.V_form

/*11*/
SELECT s.Nazva, count(g.Kod_group)
FROM dbo_groups g JOIN Rozklad_pids rozk ON g.Kod_group=rozk.Kod_group
JOIN Predmet_plan pp ON rozk.K_predm_pl=pp.K_predm_pl
JOIN Navch_plan np ON pp.K_navch_plan=np.K_navch_plan
JOIN Spetsialnost s ON s.K_spets=np.K_spets
GROUP BY s.Nazva


/*12*/
Declare @name NVARCHAR(15) = 'Головок'
delete Reiting
FROM Reiting JOIN dbo_student ON Reiting.Kod_student = dbo_student.Kod_stud
WHERE dbo_student.Sname = @name;
select * from reiting


/*13*/
declare @disciplina int = 354
Delete 
from Predmet_plan
where K_predmet = @disciplina

/*14*/
UPDATE Reiting
SET Reiting.Reiting = Reiting.Reiting + (Reiting.Reiting * 0.15)
SELECT * FROM Reiting;

/*15*/
update reiting
set Reiting.Reiting = reiting.Reiting - (reiting.Reiting * 0.15)
select * from reiting

/*16*/
DECLARE @code_para int, @start_bal int;
SET @code_para=57
SET @start_bal=81
INSERT INTO Reiting (K_zapis,Kod_student,Reiting,Prisutn)
SELECT @code_para, s.Kod_stud, @start_bal, 1
FROM dbo_student s
WHERE s.Kod_group='ПІ-54'
SELECT r.*,s.Kod_group FROM Reiting r JOIN dbo_student s ON r.Kod_student=s.Kod_stud

/*17*/
INSERT INTO Predmet_plan(K_predmet,K_navch_plan,Chas_all,Kilk_modul,Semestr,k_fk)
VALUES
(399,17,78,2,2,2),
(399,17,86,2,1,2)

DECLARE @date_zan date, @hours smallint;
SET @date_zan='2019-06-07'
SET @hours=1
INSERT INTO Rozklad_pids(Date,K_predm_pl,Kod_group,k_vilkad,N_vedomost,Zdacha_type)
SELECT @date_zan,pp.K_predm_pl,'ПІ-53',@hours,243,fk.k_fk
FROM Predmet_plan pp 
INNER JOIN form_kontr fk ON pp.k_fk=fk.k_fk
INNER JOIN predmet p ON p.K_predmet=pp.K_predmet
WHERE p.Nazva like 'М%'

SELECT rp.*,p.Nazva FROM Rozklad_pids rp INNER JOIN Predmet_plan pp ON rp.K_predm_pl=pp.K_predm_pl
INNER JOIN form_kontr fk ON pp.k_fk=fk.k_fk
INNER JOIN predmet p ON p.K_predmet=pp.K_predmet

/*18*/
update Rozklad_pids
set rozklad_pids.Kod_group = 0
where Rozklad_pids.K_predm_pl = 90

select * from Rozklad_pids
select * from dbo_student


/*19*/

DECLARE @code NVARCHAR(20) = 'ПІ-54'
DELETE FROM dbo_student
WHERE Kod_group = @code 


/*20*/
select * from reiting
declare 
	@kodZap1	int = 10,
	@kodStud2   int = 54,
	@reit3		smallint = 90,
	@pris4		bit = 0
INSERT INTO Reiting
VALUES (@kodZap1,@kodStud2,@reit3,@Pris4)

SELECT * FROM Reiting;

