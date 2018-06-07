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

 