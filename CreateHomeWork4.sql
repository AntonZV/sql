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
 
 CREATE TABLE Officer
 (
	ID int identity not null unique,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	[Rank] nvarchar(20) not null,
	primary key (FirstName,SecondName,ThirdName)
 )

 CREATE TABLE Delivering
 (
	ID int not null 
		foreign key references Officer(ID)
		on delete cascade,
	Weapon nvarchar(10) not null,
	FK_ID int identity unique not null,
	primary key(ID,Weapon)
 )
 GO

 CREATE TABLE Receiver
 (
	ID int unique not null 
		foreign key references Officer(ID)
		on delete cascade,
	Platoon int not null,

	primary key(ID,Platoon)
 )
 GO

 CREATE TABLE GiveWeapon
 (
	ReceiverID int not null
		foreign key references Receiver(ID),
	DeliveringID int not null
		foreign key references Delivering(FK_ID),
	primary key(ReceiverID,DeliveringID)	
 )
 GO

 INSERT INTO Officer
 (FirstName,SecondName,ThirdName,[Rank])
 VALUES
 ('Буров', 'O.','C.','майор'),
 ('Рыбаков', 'Н.','Г.','майор'),
 ('Деребанов', 'В.','Я.','подполковник'),
 ('Петров', 'В.', 'А.', 'оф.'),
 ('Лодарев', 'П.','С.','оф.'),
 ('Леонтьев', 'К.','В.','оф.'),
 ('Духов', 'Р.','М.','оф.')

 INSERT INTO Delivering
 (ID,Weapon)
 VALUES
 (1,'AK-47'),
 (2,'Глок20'),
 (3,'AK-74'),
 (1,'Глок20')

 INSERT INTO Receiver
 (ID,Platoon)
 VALUES
 (4,222),
 (5,232),
 (6,212),
 (7,200)
  
 INSERT INTO GiveWeapon
 (ReceiverID,DeliveringID)
 VALUES
 (4,1),
 (4,2),
 (5,3),
 (5,2),
 (6,1),
 (6,2),
 (7,1)

 SELECT * FROM Officer
 SELECT * FROM Delivering
 SELECT * FROM Receiver
 SELECT * FROM GiveWeapon

 TRUNCATE TABLE GiveWeapon
 TRUNCATE TABLE Delivering
 TRUNCATE TABLE Receiver
 TRUNCATE TABLE Officer

 DROP TABLE GiveWeapon;
 DROP TABLE Delivering;
 DROP TABLE Receiver;
 DROP TABLE Officer;

--smth
