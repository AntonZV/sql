DROP DATABASE HomeWork4

CREATE DATABASE HomeWork4  
ON						
(
	NAME = 'HomeWork4',			
	FILENAME = 'D:\Praktika\SQL\HomeWork4.mdf',		
	SIZE = 30MB,                   
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB			
)
LOG ON						 
( 
	NAME = 'LogHomeWork4',				   
	FILENAME = 'D:\Praktika\SQL\HomeWork4.ldf',       
	SIZE = 5MB,                      
	MAXSIZE = 50MB,                  
	FILEGROWTH = 5MB                  
)               
COLLATE Cyrillic_General_CI_AS

EXECUTE sp_helpdb HomeWork4;

 USE HomeWork4              
 GO
   
 CREATE TABLE [Rank]
 (
	ID int identity not null primary key,
	Name nvarchar(20) not null
 )
 GO

 CREATE TABLE Weapon
 (
	ID int identity not null primary key,
	Name nvarchar(10) not null
 )
 GO

 CREATE TABLE Officer
 (
	ID int identity not null primary key,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	RankID int null foreign key references [Rank](ID),
	Number int null,
	Platoon int null,
 )
 GO

 CREATE TABLE GiveWeapon
 (
	ID int identity not null primary key,
	ReceiverID int not null
		foreign key references Officer(ID),
	DeliverID int not null
		foreign key references Officer(ID),
	WeaponID int not null
		foreign key references Weapon(ID),
 )
 GO

 INSERT INTO [Rank]
 VALUES
 ('майор'),
 ('подполковник'),
 ('оф.')

 INSERT INTO Weapon
 VALUES
 ('АК-47'),
 ('Глок20'),
 ('АК-74')

 INSERT INTO Officer
 (FirstName, SecondName, ThirdName, RankID, Number, Platoon)
 VALUES
 ('Буров', 'O.','C.', 1, null, null),
 ('Рыбаков', 'Н.','Г.', 1, null, null),
 ('Деребанов', 'В.','Я.', 2, null, null),
 ('Петров', 'В.', 'А.', 3, 205, 222),
 ('Лодарев', 'П.','С.', 3, 221, 232),
 ('Леонтьев', 'К.','В.', 3, 201, 212),
 ('Духов', 'Р.','М.', null, null, null)
  
 INSERT INTO GiveWeapon
 (DeliverID, ReceiverID, WeaponID)
 VALUES
 (1,4,1),
 (1,6,1),
 (1,7,1),
 (2,4,2),
 (2,5,2),
 (2,6,2),
 (3,5,3)

 SELECT Name as [Rank] FROM [Rank]
 SELECT Name as Weapon FROM Weapon
 SELECT * FROM Officer
 SELECT * FROM GiveWeapon

 TRUNCATE TABLE GiveWeapon
 TRUNCATE TABLE Officer
 TRUNCATE TABLE Weapon
 TRUNCATE TABLE [Rank]

 DROP TABLE GiveWeapon;
 DROP TABLE Officer;
 DROP TABLE Weapon;
 DROP TABLE [Rank];

--smth
