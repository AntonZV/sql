DROP DATABASE HomeWork6

CREATE DATABASE HomeWork6  
ON						
(
	NAME = 'HomeWork6',			
	FILENAME = 'D:\Praktika\SQL\HomeWork6.mdf',		
	SIZE = 30MB,                   
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB			
)
LOG ON						 
( 
	NAME = 'LogHomeWork6',				   
	FILENAME = 'D:\Praktika\SQL\HomeWork6.ldf',       
	SIZE = 5MB,                      
	MAXSIZE = 50MB,                  
	FILEGROWTH = 5MB                  
)               
COLLATE Cyrillic_General_CI_AS

EXECUTE sp_helpdb HomeWork6;

USE HomeWork6              
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
 ('Петров','В.','(098)1234567'),
 ('Лодарев','П.','(098)2345678'),
 ('Леонтьев','К.','(098)3456789'),
 ('Духов', 'Р.','(098)4567891'),
 ('Буров', 'O.','(098)5678912'),
 ('Рыбаков', 'Н.','(098)6789123'),
 ('Деребанов', 'В.','(098)7891234')

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
 ('главный директор', 25000,7),
 ('менеджер',8000,6),
 ('менеджер',8000,4),
 ('рабочий',3000,3),
 ('рабочий',3000,5),
 ('рабочий',3000,2),
 ('рабочий',3000,1)
  
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


 SELECT FirstName,SecondName,Phone, (SELECT Adress FROM PersonalInfo
									 WHERE ContactInfo.ID=PersonID) AS Adress
 FROM ContactInfo


 select FirstName,SecondName,Phone, (select BirthDate from PersonalInfo
									 where PersonID=ContactInfo.ID) as BirthDate
 from ContactInfo
 where ContactInfo.ID = (select PersonID from PersonalInfo
						 where  PersonID=ContactInfo.ID and [Status]='UnMarried') 

 
select FirstName,SecondName,Phone, (select BirthDate from PersonalInfo
									 where PersonID=ContactInfo.ID) as BirthDate
 from ContactInfo
 where ContactInfo.ID = (select PersonID from WorkInfo
						 where  PersonID=ContactInfo.ID and Position='менеджер') 



--1
 /*SELECT FirstName,SecondName,Phone,Adress FROM ContactInfo,PersonalInfo
 WHERE ContactInfo.ID=PersonID*/

 --2
 /*SELECT FirstName,SecondName,Phone,BirthDate FROM ContactInfo,PersonalInfo
 WHERE ContactInfo.ID=PersonID and [Status]='UnMarried'*/
 /*SELECT BirthDate, (SELECT FirstName FROM ContactInfo
					WHERE  ContactInfo.ID=PersonID) AS FirstName,
					(SELECT SecondName FROM ContactInfo
					WHERE  ContactInfo.ID=PersonID) AS SecondName,
					(SELECT Phone FROM ContactInfo
					WHERE  ContactInfo.ID=PersonID) AS Phone
 FROM PersonalInfo
 WHERE [Status]='UnMarried' */

 --3
 /*SELECT FirstName,SecondName,BirthDate,Phone FROM ContactInfo, WorkInfo, PersonalInfo
 WHERE ContactInfo.ID=WorkInfo.PersonID and Position='менеджер' and PersonalInfo.PersonID=WorkInfo.PersonID*/
 /*select BirthDate, ( select FirstName from ContactInfo
					 where ContactInfo.ID=
							(select PersonID from WorkInfo
							 where PersonID=ContactInfo.ID and Position='менеджер' and WorkInfo.PersonID=PersonalInfo.PersonID)  ) as FirstName,
				   ( select SecondName from ContactInfo
					 where ContactInfo.ID=
							(select PersonID from WorkInfo
							 where PersonID=ContactInfo.ID and Position='менеджер' and WorkInfo.PersonID=PersonalInfo.PersonID)  ) as SecondName,
                   ( select Phone from ContactInfo
					 where ContactInfo.ID=
							(select PersonID from WorkInfo
							 where PersonID=ContactInfo.ID and Position='менеджер' and WorkInfo.PersonID=PersonalInfo.PersonID)  ) as Phone 
 from PersonalInfo
 where PersonalInfo.PersonID= (select WorkInfo.PersonID from WorkInfo
						 where position='менеджер' and WorkInfo.PersonID=PersonalInfo.PersonID)*/


