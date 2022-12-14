use Company

create table Goods
 (GoodID int IDENTITY(1,1) not null primary key,
 [Name] varchar(50),
 Unit varchar(50))


 create table Delivery 
 (DeliveryID int IDENTITY(1,1) not null primary key,
 Amount int default 0,
 [Date] date,
 Price int default 0, 
 GoodID int references Goods(GoodID)
 on update cascade on delete cascade,
  SupplierID int references Supplier(SupplierID)
 on update cascade on delete cascade)


 create table Supplier 
 (SupplierID int IDENTITY(1,1) not null primary key,
 [Address] varchar(50) default 0,
 Phone varchar(50),
 NumberOfBill int)






 INSERT INTO Delivery(Amount, [Date], Price, GoodID, SupplierID)
 VALUES(30, '7/9/2021', 80, 3, 3)

 select * from Goods
 select * from Supplier
 select * from Delivery join Goods on Delivery.GoodID = Goods.GoodID




 ---------------------------1--------------------------------
 create view NOG as 
 select Supplier.SupplierID, count(*) as NOG
 from Delivery join Supplier on Delivery.SupplierID = Supplier.SupplierID  
 group by Supplier.SupplierID

 select *
 from NOG
 where NOG.NOG = (select COUNT(*) from Goods)


 ------------------2-----------------------


 create view Task2 as
 select Supplier.SupplierID
 from Supplier inner join Delivery on Delivery.SupplierID = Supplier.SupplierID
 where GoodID = 2 and Price >= (
 select avg(Delivery.Price) 
 from Delivery
 where Delivery.DeliveryID = 2)



 ------------------3------------------------


 create proc Task3
 @min int = 10,
 @max int = 200
 as
 select * 
 from Delivery join Goods on Delivery.GoodID = Goods.GoodID 
 where Price > @min and Price < @max

 exec Task3
 


 --------------4----------------

 declare
  @price1 float = (select avg(Delivery.Price) from Delivery where Delivery.GoodID = 3)

  print(@price1)

 create proc Task4 
 @Date1 date = '1/1/2021', @Date2 date = '1/1/2022',
 @x float OUTPUT
 as
 declare
 @price1 float = (select avg(Delivery.Price) from Delivery where Delivery.GoodID = 3 and Delivery.[Date] > @Date1 and Delivery.[Date] < @Date2),
 @price2 float = (select avg(Delivery.Price) from Delivery where Delivery.GoodID = 3 and  Delivery.[Date] > @Date2)
 select @x = @price2 - @price2



 ----------------5------------------

 DROP TRIGGER IF EXISTS task5

GO
CREATE TRIGGER task5 ON Goods INSTEAD OF INSERT AS
DECLARE @Name NVARCHAR(50) = (SELECT [Name] FROM INSERTED)
DECLARE @Unit NVARCHAR(50) = (SELECT Unit FROM INSERTED)


BEGIN
	IF NOT EXISTS(
	SELECT Goods.GoodID FROM Goods
	WHERE Goods.Name = @Name
	)
	BEGIN
		INSERT Goods (Name, Unit) 
		VALUES (@Name, @Unit)
	END
	ELSE
	BEGIN
		print('Такий товар уже існує')
	END
END


insert into Goods (Name, Unit)
values('Сніг', 'м^3')





