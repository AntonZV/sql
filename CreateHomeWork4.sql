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
   
 CREATE TABLE [Rank]
 (
	ID int identity not null primary key,
	Name nvarchar(20) not null
 )
 GO

 CREATE TABLE Weapon
 (
	ID int identity not null primary key,
	Name nvarchar(10) not null
 )
 GO

 CREATE TABLE Officer
 (
	ID int identity not null primary key,
    FirstName nvarchar(20) not null,
	SecondName nvarchar(20) not null,
	ThirdName nvarchar(20) not null,
	RankID int null foreign key references [Rank](ID),
	Number int null,
	Platoon int null,
 )
 GO

 CREATE TABLE GiveWeapon
 (
	ID int identity not null primary key,
	DeliverID int not null
		foreign key references Officer(ID),
	WeaponID int not null
		foreign key references Weapon(ID),
	ReceiverID int not null
		foreign key references Officer(ID),
 )
 GO

 INSERT INTO [Rank]
 VALUES
 ('�����'),
 ('������������'),
 ('��.')

 INSERT INTO Weapon
 VALUES
 ('��-47'),
 ('����20'),
 ('��-74')

 INSERT INTO Officer
 (FirstName, SecondName, ThirdName, RankID, Number, Platoon)
 VALUES
 ('�����', 'O.','C.', 1, null, null),
 ('�������', '�.','�.', 1, null, null),
 ('���������', '�.','�.', 2, null, null),
 ('������', '�.', '�.', 3, 205, 222),
 ('�������', '�.','�.', 3, 221, 232),
 ('��������', '�.','�.', 3, 201, 212),
 ('�����', '�.','�.', null, null, 200)
  
 INSERT INTO GiveWeapon
 (DeliverID, ReceiverID, WeaponID)
 VALUES
 (1,4,1),
 (1,6,1),
 (1,7,1),
 (2,4,2),
 (2,5,2),
 (2,6,2),
 (3,5,3)

 SELECT ID,Name as [Rank] FROM [Rank]
 SELECT ID,Name as Weapon FROM Weapon
 SELECT * FROM Officer
 SELECT * FROM GiveWeapon

 DROP TABLE GiveWeapon;
 DROP TABLE Officer;
 DROP TABLE Weapon;
 DROP TABLE [Rank];

 select firstname,secondname,thirdname, name from weapon,giveweapon,officer
 where officer.id=receiverid and weapon.id=weaponid and name='��-47'


 select firstname,secondname,thirdname,name from officer,weapon
 where officer.id in (select giveweapon.receiverid from giveweapon
				   where giveweapon.weaponid=(select weapon.id from weapon
											  where weapon.name='��-47')) and weapon.name='��-47'

 select firstname,secondname,thirdname,name from 
		officer
		inner join 
		giveweapon
		on officer.id=giveweapon.receiverid
		inner join 
		weapon
		on weapon.id=giveweapon.weaponid and weapon.name='��-47'


select firstname,secondname,thirdname , (select name from weapon
									     where name='��-47' and weapon.id in (select weaponid from giveweapon
														   where receiverid=officer.id)) as weapon
from officer
where officer.id in (select giveweapon.receiverid from giveweapon
					where giveweapon.weaponid=(select weapon.id from weapon
											   where weapon.name='��-47'))
