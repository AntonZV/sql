DROP DATABASE HomeWork8

CREATE DATABASE HomeWork8  
ON						
(
	NAME = 'HomeWork8',			
	FILENAME = 'D:\Praktika\SQL\HomeWork8.mdf',		
	SIZE = 30MB,                   
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB			
)
LOG ON						 
( 
	NAME = 'LogHomeWork8',				   
	FILENAME = 'D:\Praktika\SQL\HomeWork8.ldf',       
	SIZE = 5MB,                      
	MAXSIZE = 50MB,                  
	FILEGROWTH = 5MB                  
)               
COLLATE Cyrillic_General_CI_AS

EXECUTE sp_helpdb HomeWork8;

USE HomeWork8              
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


 create proc proc1
 as
	begin
	 SELECT ContactInfo.FirstName,ContactInfo.SecondName,ContactInfo.Phone,PersonalInfo.Adress
	 FROM ContactInfo
	 join PersonalInfo
	 on ContactInfo.ID=PersonID;
	end;

 create proc proc2
 as
	begin
	 select Contactinfo.FirstName,contactinfo.SecondName,contactinfo.Phone, personalinfo.BirthDate
	 from ContactInfo
	 join personalinfo
	 on PersonID=ContactInfo.ID and [Status]='UnMarried'; 
	end;

 create proc proc3
 as
	begin
	 select contactinfo.FirstName,contactinfo.SecondName,contactinfo.Phone, personalinfo.BirthDate
	 from ContactInfo
	 join personalinfo
	 on personalinfo.PersonID=ContactInfo.ID
	 join workinfo
	 on WorkInfo.personID=ContactInfo.ID and Position='менеджер';
	end;	
 
 exec proc1;
 exec proc2;
 exec proc3;

 create function func1()
 returns table
 as
	return (SELECT ContactInfo.FirstName,ContactInfo.SecondName,ContactInfo.Phone,PersonalInfo.Adress
			FROM ContactInfo
			join PersonalInfo
			on ContactInfo.ID=PersonID );

create function func2()
 returns table
 as
	return (select Contactinfo.FirstName,contactinfo.SecondName,contactinfo.Phone, personalinfo.BirthDate
			from ContactInfo
			join personalinfo
			on PersonID=ContactInfo.ID and [Status]='UnMarried');


create function func3()
 returns table
 as
	return ( select contactinfo.FirstName,contactinfo.SecondName,contactinfo.Phone, personalinfo.BirthDate
			 from ContactInfo
			 join personalinfo
			 on personalinfo.PersonID=ContactInfo.ID
			 join workinfo
			 on WorkInfo.personID=ContactInfo.ID and Position='менеджер');

select * from dbo.func1()
select * from dbo.func2()
select * from dbo.func3()

