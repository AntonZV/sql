DROP DATABASE Task

CREATE DATABASE Task  
ON						
(
	NAME = 'Task',			
	FILENAME = 'D:\Praktika\SQL\Task.mdf',		
	SIZE = 30MB,                   
	MAXSIZE = 100MB,				
	FILEGROWTH = 10MB			
)
LOG ON						 
( 
	NAME = 'LogTask',				   
	FILENAME = 'D:\Praktika\SQL\Task.ldf',       
	SIZE = 5MB,                      
	MAXSIZE = 50MB,                  
	FILEGROWTH = 5MB                  
)               
COLLATE Cyrillic_General_CI_AS

EXECUTE sp_helpdb Task;

 USE Task              
 GO
   
 CREATE TABLE TaskTypes
 (
	ID int identity not null primary key,
	Name nvarchar(20) not null
 )
 GO

 CREATE TABLE WorkerTypes
 (
	ID int identity not null primary key,
	Name nvarchar(20) not null
 )
 GO

 CREATE TABLE Workers
 (
	ID int identity not null primary key,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	BirthDate date not null,
	WorkerType int not null 
		foreign key references WorkerTypes(ID),
 )
 GO

 CREATE TABLE [Enable]
 (
	ID int identity not null primary key,
	TaskType int not null
		foreign key references TaskTypes(ID),
	WorkerType int not null
		foreign key references Workers(ID)
 )
 GO

 CREATE TABLE Tasks
 (
	ID int identity not null primary key,
	StartDate date not null,
	EndDate date not null,
	EnableID int not null
		foreign key references [Enable](ID)
 )
 GO

 INSERT INTO TaskTypes
 VALUES
 ('Проектування'),
 ('Дизайн'),
 ('Будівництво'),
 ('Розробка')

 INSERT INTO WorkerTypes
 VALUES
 ('Проектант'),
 ('Дизайнер'),
 ('Будівельник'),
 ('Розробник')

 DECLARE @start DATE = '1980-01-01'
 DECLARE @end DATE = '2000-12-31'
 
 INSERT INTO Workers
 VALUES
 ('Буров', 'O.','C.', DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start), 1),
 ('Рыбаков', 'Н.','Г.', DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start), 2),
 ('Деребанов', 'В.','Я.', DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start), 2),
 ('Петров', 'В.', 'А.', DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start), 1),
 ('Лодарев', 'П.','С.', DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start), 3),
 ('Леонтьев', 'К.','В.', DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start), 4),
 ('Духов', 'Р.','М.', DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start), 4)
  
 INSERT INTO [Enable]
 VALUES
 (1,1),
 (2,2),
 (3,3),
 (4,4),
 (1,2),
 (2,1)

 INSERT INTO Tasks
 VALUES
 (GETDATE(),GETDATE(),1),
 (GETDATE(),GETDATE(),2),
 (GETDATE(),GETDATE(),3),
 (GETDATE(),GETDATE(),4),
 (GETDATE(),GETDATE(),5),
 (GETDATE(),GETDATE(),6)

 SELECT * FROM TaskTypes
 SELECT * FROM WorkerTypes
 SELECT * FROM Workers
 SELECT * FROM [Enable]
 SELECT * FROM Tasks

 DROP TABLE Tasks;
 DROP TABLE [Enable];
 DROP TABLE Workers;
 DROP TABLE WorkerTypes;
 DROP TABLE TaskTypes;

