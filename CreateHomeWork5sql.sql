DROP DATABASE HomeWork5

CREATE DATABASE HomeWork5  
ON						
(
	NAME = 'HomeWork5',			
	FILENAME = 'D:\Praktika\SQL\HomeWork5.mdf',		
	SIZE = 30MB,                   
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB			
)
LOG ON						 
( 
	NAME = 'LogHomeWork5',				   
	FILENAME = 'D:\Praktika\SQL\HomeWork5.ldf',       
	SIZE = 5MB,                      
	MAXSIZE = 50MB,                  
	FILEGROWTH = 5MB                  
)               
COLLATE Cyrillic_General_CI_AS

EXECUTE sp_helpdb HomeWork5;

USE HomeWork5              
GO  
  
CREATE TABLE ContactInfo
 (
	ID int identity not null primary key,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	Phone char(12) unique check (Phone like '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), 
 )
 GO

 INSERT INTO ContactInfo
 (FirstName,SecondName,Phone)
 VALUES
 ('������','�.','(098)1234567'),
 ('�������','�.','(098)2345678'),
 ('��������','�.','(098)3456789'),
 ('�����', '�.','(098)4567891'),
 ('�����', 'O.','(098)5678912'),
 ('�������', '�.','(098)6789123'),
 ('���������', '�.','(098)7891234')

 CREATE TABLE WorkInfo
 (
	ID int identity not null primary key,
	Position nvarchar(20) not null,
	Salary int not null,
	PersonID int not null 
		foreign key references ContactInfo(ID)
 )
 GO

 CREATE TABLE PersonalInfo
 (
	ID int identity not null primary key,
	BirthDate date not null,
	Adress nvarchar(20) not null,
	[Status] nvarchar(20) null default 'Unknown',
	PersonID int not null 
		foreign key references ContactInfo(ID)
 )
 GO

 INSERT INTO WorkInfo
 VALUES
 ('������� ��������', 25000,7),
 ('��������',8000,6),
 ('��������',8000,4),
 ('�������',3000,3),
 ('�������',3000,5),
 ('�������',3000,2),
 ('�������',3000,1)
  
 DECLARE @start DATE = '1980-01-01'
 DECLARE @end DATE = '2000-12-31'

 INSERT INTO PersonalInfo
 VALUES
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Vinnytsia','Married',1),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Vinnytsia','UnMarried',2),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Kyiv','UnMarried',6),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Lviv','Married',5),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Lviv','UnMarried',4),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Kharkiv','UnMarried',3),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Kyiv','Married',7)

 DROP TABLE WorkInfo;
 DROP TABLE PersonalInfo;
 DROP TABLE ContactInfo;

 SELECT * FROM ContactInfo
 SELECT * FROM PersonalInfo
 SELECT * FROM WorkInfo

 SELECT FirstName,SecondName,Phone,Adress FROM 
	ContactInfo
	inner join
	PersonalInfo
 ON ContactInfo.ID=PersonalInfo.personID;

 SELECT FirstName,SecondName,BirthDate,Phone FROM 
	ContactInfo
	inner join
	PersonalInfo
 ON ContactInfo.ID=PersonalInfo.personID and [Status]='UnMarried';

 SELECT FirstName,SecondName,BirthDate,Phone FROM 
	ContactInfo
	inner join
	WorkInfo
	ON ContactInfo.ID=WorkInfo.personID and Position='��������'
	inner join
	PersonalInfo
	ON WorkInfo.ID=PersonalInfo.personID;

 --smth