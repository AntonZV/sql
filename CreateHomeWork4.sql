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

 CREATE TABLE Deliver
 (
	ID int identity not null unique,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	[Rank] nvarchar(20) not null,
	Weapon nvarchar(10) not null,
	primary key( FirstName, SecondName, ThirdName)
 )
 GO

 CREATE TABLE Officer
 (
	ID int identity not null unique,
	FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	[Rank] nvarchar(20) not null,
	Number int not null,
	primary key( FirstName, SecondName, ThirdName)
 )
 GO

 CREATE TABLE GiveWeapon
 (
	OfficerID int not null
		foreign key references Officer(ID),
	DeliverID int not null
		foreign key references Deliver(ID),
	primary key(OfficerID,DeliverID)	
 )
 GO

 INSERT INTO Deliver
 (FirstName,SecondName,ThirdName,[Rank],w)
 VALUES
 ('Буров', 'O.','C.','майор','AK-47'),
 ('Рыбаков', 'Н.','Г.','майор','Глок20'),
 ('Деребанов', 'В.','Я.','подполковник','AK-74')

 INSERT INTO Officer
 (FirstName,SecondName,ThirdName,[Rank],Number)
 VALUES
 ('Петров', 'В.', 'А.', 'оф.', 222),
 ('Лодарев', 'П.','С.','оф.',232),
 ('Леонтьев', 'К.','В.','оф.',212),
 ('Духов', 'Р.','М.','оф.',200)
  
 INSERT INTO GiveWeapon
 (OfficerID,DeliverID)
 VALUES
 (1,1),
 (1,2),
 (2,3),
 (2,2),
 (3,1),
 (3,2),
 (4,1)

 SELECT * FROM Deliver
 SELECT * FROM Officer
 SELECT * FROM GiveWeapon

 DROP TABLE Officer;
 DROP TABLE GiveWeapon;
 DROP TABLE Deliver;
