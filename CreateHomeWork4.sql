CREATE DATABASE HomeWork4  
ON						
(
	NAME = 'HomeWork4',			
	FILENAME = 'D:\Praktika\MS SQL\HomeWork4.mdf',		
	SIZE = 30MB,                   
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB			
)
LOG ON						 
( 
	NAME = 'LogHomeWork4',				   
	FILENAME = 'D:\Praktika\MS SQL\HomeWork4.ldf',       
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
	ID int identity not null primary key,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	[Rank] nvarchar(20) not null,
 )
 GO

 CREATE TABLE Officer
 (
	ID int identity not null primary key,
	FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	[Rank] nvarchar(20) not null,
	Number int not null,
 )
 GO

 CREATE TABLE Weapon
 (
	Name nvarchar(10) not null,
	OfficerID int not null
		foreign key references Officer(ID),
	DeliverID int not null,
		foreign key references Deliver(ID)	
 )
 GO

 INSERT INTO Deliver
 (FirstName,SecondName,ThirdName,[Rank])
 VALUES
 ('�����', 'O.','C.','�����'),
 ('�������', '�.','�.','�����'),
 ('���������', '�.','�.','������������')

 INSERT INTO Officer
 (FirstName,SecondName,ThirdName,[Rank],Number)
 VALUES
 ('������', '�.', '�.', '��.', 222),
 ('�������', '�.','�.','��.',232),
 ('��������', '�.','�.','��.',212),
 ('�����', '�.','�.','��.',200)
  
 INSERT INTO Weapon
 (Name,ID)
 VALUES
 ('AK-47', 1),
 ('����20', 2),
 ('AK-74', 3)

 SELECT * FROM Deliver
 SELECT * FROM Weapon
 SELECT * FROM Officer

 DROP TABLE Officer;
 DROP TABLE Weapon;
 DROP TABLE Deliver;
