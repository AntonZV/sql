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

 CREATE TABLE WorkInfo
 (
	ID int identity not null primary key,
	Position nvarchar(20) not null,
	Salary int not null,
 )
 GO

 CREATE TABLE PersonalInfo
 (
	ID int identity not null primary key,
	BirthDate date not null,
	Adress nvarchar(20) not null,
	[Status] nvarchar(20) null default 'Unknown',
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

 INSERT INTO WorkInfo
 (Position,Salary)
 VALUES
 ('������� ��������', 25000),
 ('��������',8000),
 ('��������',8000),
 ('�������',3000),
 ('�������',3000),
 ('�������',3000),
 ('�������',3000)
  
 DECLARE @start DATE = '1980-01-01'
 DECLARE @end DATE = '2000-12-31'

 INSERT INTO PersonalInfo
 (BirthDate,Adress,[Status])
 VALUES
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Vinnytsia','Married'),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Vinnytsia','UnMarried'),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Kyiv','UnMarried'),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Lviv','Married'),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Lviv','UnMarried'),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Kharkiv','UnMarried'),
 (DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start),'Kyiv','Married')

 SELECT * FROM WorkInfo
 SELECT * FROM ContactInfo
 SELECT * FROM PersonalInfo

 DROP TABLE WorkInfo;
 DROP TABLE ContactInfo;
 DROP TABLE PersonalInfo;

 /*SELECT FirstName,SecondName,Phone,Adress FROM ContactInfo,PersonalInfo
 WHERE ContactInfo.ID=PersonalInfo.ID*/
 SELECT FirstName,SecondName,Phone, (SELECT Adress FROM PersonalInfo
									 WHERE ContactInfo.ID=PersonalInfo.ID) AS Adress
 FROM ContactInfo

 /*SELECT FirstName,SecondName,Phone,BirthDate FROM ContactInfo,PersonalInfo
 WHERE ContactInfo.ID=PersonalInfo.ID and [Status]='UnMarried'*/
 /*SELECT BirthDate, (SELECT FirstName FROM ContactInfo
					WHERE  ContactInfo.ID=PersonalInfo.ID) AS FirstName,
					(SELECT SecondName FROM ContactInfo
					WHERE  ContactInfo.ID=PersonalInfo.ID) AS SecondName,
					(SELECT Phone FROM ContactInfo
					WHERE  ContactInfo.ID=PersonalInfo.ID) AS Phone
 FROM PersonalInfo
 WHERE [Status]='UnMarried' */

 select FirstName,SecondName,Phone, (select BirthDate from PersonalInfo
									 where PersonalInfo.ID=ContactInfo.ID) as BirthDate
 from ContactInfo
 where ContactInfo.ID = (select PersonalInfo.ID from PersonalInfo
						 where  PersonalInfo.ID=ContactInfo.ID and [Status]='UnMarried') 

 /*SELECT FirstName,SecondName,BirthDate,Phone FROM ContactInfo, WorkInfo, PersonalInfo
 WHERE ContactInfo.ID=WorkInfo.ID and Position='��������' and PersonalInfo.ID=WorkInfo.ID*/
 /*select BirthDate, ( select FirstName from ContactInfo
					 where ContactInfo.ID=
							(select WorkInfo.ID from WorkInfo
							 where WorkInfo.ID=ContactInfo.ID and Position='��������' and WorkInfo.ID=PersonalInfo.ID)  ) as FirstName,
				   ( select SecondName from ContactInfo
					 where ContactInfo.ID=
							(select WorkInfo.ID from WorkInfo
							 where WorkInfo.ID=ContactInfo.ID and Position='��������' and WorkInfo.ID=PersonalInfo.ID)  ) as SecondName,
                   ( select Phone from ContactInfo
					 where ContactInfo.ID=
							(select WorkInfo.ID from WorkInfo
							 where WorkInfo.ID=ContactInfo.ID and Position='��������' and WorkInfo.ID=PersonalInfo.ID)  ) as Phone 
 from PersonalInfo
 where PersonalInfo.ID= (select WorkInfo.ID from WorkInfo
						 where position='��������' and WorkInfo.ID=PersonalInfo.ID)*/
select FirstName,SecondName,Phone, (select BirthDate from PersonalInfo
									 where PersonalInfo.ID=ContactInfo.ID) as BirthDate
 from ContactInfo
 where ContactInfo.ID = (select WorkInfo.ID from WorkInfo
						 where  WorkInfo.ID=ContactInfo.ID and Position='��������') 


