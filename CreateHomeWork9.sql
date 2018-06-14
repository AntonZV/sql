DROP DATABASE HomeWork9

CREATE DATABASE HomeWork9  
ON						
(
	NAME = 'HomeWork9',			
	FILENAME = 'D:\Praktika\SQL\HomeWork9.mdf',		
	SIZE = 30MB,                   
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB			
)
LOG ON						 
( 
	NAME = 'LogHomeWork9',				   
	FILENAME = 'D:\Praktika\SQL\HomeWork9.ldf',       
	SIZE = 5MB,                      
	MAXSIZE = 50MB,                  
	FILEGROWTH = 5MB                  
)               
COLLATE Cyrillic_General_CI_AS

USE HomeWork9              
GO  
  
CREATE TABLE ContactInfo
 (
	ID int identity not null primary key,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	Phone char(12) 
 )
 GO

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

 create trigger dbo.contact_insert
 on dbo.contactinfo
 for insert
 as
	if exists
	(
	select * from inserted
	where inserted.Phone not like '([0-9][0-9][0-9])[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	)
   begin
	    commit tran
   end;
   else
   begin
	   RAISERROR('Phone number is not correct!', 1, 16); 
	   ROLLBACK TRAN
   end;
 go

 begin tran
 go

 INSERT INTO ContactInfo
 (FirstName,SecondName,Phone)
 VALUES
 ('Петров','В.','(098)123456*'),
 ('Лодарев','П.','(098)2345678'),
 ('Леонтьев','К.','(098)3456789'),
 ('Духов', 'Р.','(098)4567891'),
 ('Буров', 'O.','(098)5678912'),
 ('Рыбаков', 'Н.','(098)6789123'),
 ('Деребанов', 'В.','(098)7891234')

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
 go

 DROP TABLE WorkInfo;
 DROP TABLE PersonalInfo;
 DROP TABLE ContactInfo;
 drop trigger dbo.contact_insert;
 go

 SELECT * FROM ContactInfo
 SELECT * FROM PersonalInfo
 SELECT * FROM WorkInfo
 go
