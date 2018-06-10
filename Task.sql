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
	ID int identity not null ,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	BirthDate date not null,
	WorkerType_ID int not null 
		foreign key references WorkerTypes(ID),
	primary key(ID,WorkerType_ID)
 )
 GO

 CREATE TABLE Tasks
 (
	ID int identity not null primary key,
	TaskType int not null
		foreign key references TaskTypes(ID),
	StartDate date not null,
	EndDate date not null,
	WorkerID int not null,
	WorkerType int not null,
	foreign key(WorkerID,WorkerType) references Workers(ID,WorkerType_ID),

	CONSTRAINT CHK CHECK ((TaskType=WorkerType) or (TaskType=1 and WorkerType=2) or (TaskType=2 and WorkerType=1))
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
  
 INSERT INTO Tasks
 VALUES
 (1,GETDATE(),GETDATE(),1,1),
-- (2,GETDATE(),GETDATE(),1,4),
 (1,GETDATE(),GETDATE(),2,2),
 (3,GETDATE(),GETDATE(),3,5),
 (4,GETDATE(),GETDATE(),4,6),
 (4,GETDATE(),GETDATE(),4,7)

 SELECT * FROM TaskTypes
 SELECT * FROM WorkerTypes
 SELECT * FROM Workers
 SELECT * FROM Tasks

 DROP TABLE Tasks;
 DROP TABLE Workers;
 DROP TABLE WorkerTypes;
 DROP TABLE TaskTypes;

