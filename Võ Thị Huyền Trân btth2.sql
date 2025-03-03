CREATE DATABASE Movies01
ON PRIMARY
(NAME = 'Movies_data', FILENAME = 'D:\monsodulieu\Movies\Movies_data.mdf',
SIZE = 25MB, MAXSIZE = 40MB, FILEGROWTH = 1MB)
LOG ON
(NAME = 'Movies_log', FILENAME = 'D:\monsodulieu\Movies\Movies_log.ldf',
SIZE = 6MB, MAXSIZE = 8MB, FILEGROWTH = 1MB)

ALTER DATABASE Movies01 ADD FILE
(NAME = 'Movies_data2', FILENAME = 'D:\monsodulieu\Movies\Movies_data2.ndf',
SIZE = 10MB)

ALTER DATABASE Movies01 SET SINGLE_USER

ALTER DATABASE Movies01 SET RESTRICTED_USER

ALTER DATABASE Movies01 SET MULTI_USER

SELECT name, user_access_desc FROM sys.databases WHERE name = 'Movies01';

ALTER DATABASE Movies01
MODIFY FILE
(NAME = 'Movies_data2', SIZE = 15MB)

EXEC sp_helpdb Movies01;

ALTER DATABASE Movies01 SET AUTO_SHRINK ON

--DROP DATABASE Movies01

ALTER DATABASE Movies01 ADD FILEGROUP Data

ALTER DATABASE Movies01 MODIFY FILE
(NAME = 'Movies_log', MAXSIZE = 10MB)

ALTER DATABASE Movies01 MODIFY FILE
(NAME = 'Movies_data2', SIZE = 10MB,
 FILEGROUP = Data)

EXEC sp_helpDB Movies
--Movie:
---Movie_num (int, PK)
---Title (varchar(255), not null)
---Category_num (int, FK)
---Date_purch (datetime)
---Rental_price (decimal)
---Rating (varchar(10))
--Customer:
---Cust_num (int, PK)
---Lname (varchar(50), not null)
---Fname (varchar(50), not null)
---Address1 (varchar(255))
---Address2 (varchar(255))
---City (varchar(50))
---State (char(2))
---Zip (varchar(10))
---Phone (varchar(20), not null)
---Join_date (datetime, not null)
--Category:
---Category_num (int, PK)
---Description (varchar(255), not null)
--Rental:
---Invoice_num (int, PK)
----Cust_num (int, FK)
---Rental_date (datetime, not null)
---Due_date (datetime, not null)
--Rental_detail:
---Invoice_num (int, FK, PK)
---Line_num (int, PK)
---Movie_num (int, FK)
---Rental_price (decimal)

EXEC sp_addtype Movie_num, 'int', 'NOT NULL'

EXEC sp_addtype Category_num, 'int', 'NOT NULL'

EXEC sp_addtype Cust_num, 'int', 'NOT NULL'

EXEC sp_addtype Invoice_num, 'int', 'NOT NULL'

sp_help Movie_num

sp_help Category_num

sp_help Cust_num

sp_help Invoice_num


USE Movies01;
CREATE TABLE Customer
(Cust_num cust_num IDENTITY(300,1)  NOT NULL PRIMARY KEY,
Lname varchar(20) NOT NULL,
Fname varchar(20) NOT NULL,
Address1 varchar(30) NULL,
Address2 varchar(20) NULL,
City varchar(20) NULL,
State Char(2) NULL,
Zip Char(10) NULL,
Phone Varchar(10) NOT NULL,
Join_date Smalldatetime NOT NULL  DEFAULT GETDATE());

USE Movies01;
CREATE TABLE Category
(Category_num category_num IDENTITY(1,1) NOT NULL PRIMARY KEY,
 Description Varchar(20) NOT NULL)

USE Movies01;
CREATE TABLE Movie
(Movie_num movie_num NOT NULL PRIMARY KEY,
Title cust_num NOT NULL,
Category_Num category_num NOT NULL,
Date_purch Smalldatetime NULL,
Rental_price int NULL,
Rating char(5) NULL)

USE Movies01;
CREATE TABLE Rental
(Invoice_num invoice_num NOT NULL PRIMARY KEY,
Cust_num cust_num NOT NULL,
Rental_date smalldatetime NOT NULL,
Due_date smalldatetime NOT NULL)

USE Movies01;
CREATE TABLE Rental_Detail
(Invoice_num Invoice_num NOT NULL,
Line_num int NOT NULL,
Movie_num Movie_num NOT NULL,
Rental_price smallmoney NOT NULL)

EXEC sp_help 'Customer'

EXEC sp_help 'Category'

EXEC sp_help 'Movie'

EXEC sp_help 'Rental'

EXEC sp_help 'Rental_Detail'

--ALTER TABLE Movie ADD CONSTRAINT PK_movie PRIMARY KEY (Movie_num);

--ALTER TABLE Customer ADD CONSTRAINT PK_customer PRIMARY KEY (Cust_num);

--ALTER TABLE Category ADD CONSTRAINT PK_category PRIMARY KEY (Category_num);

--ALTER TABLE Rental ADD CONSTRAINT PK_rental PRIMARY KEY (Invoice_num);


EXEC sp_helpconstraint 'Movie';

EXEC sp_helpconstraint 'Customer';

EXEC sp_helpconstraint 'Category';

EXEC sp_helpconstraint 'Rental';

ALTER TABLE Movie ADD CONSTRAINT FK_movie FOREIGN KEY (Category_Num) REFERENCES Category(Category_num);

ALTER TABLE Rental ADD CONSTRAINT FK_rental FOREIGN KEY (Cust_num) REFERENCES Customer(Cust_num);

ALTER TABLE Rental_detail ADD CONSTRAINT FK_detail_invoice FOREIGN KEY (Invoice_num) REFERENCES Rental(Invoice_num) ON DELETE CASCADE;

ALTER TABLE Rental_detail ADD CONSTRAINT PK_detail_movie FOREIGN KEY (Movie_num) REFERENCES Movie(Movie_num);


EXEC sp_helpconstraint 'Movie';

EXEC sp_helpconstraint 'Rental';

EXEC sp_helpconstraint 'Rental_detail';

ALTER TABLE Movie ADD CONSTRAINT DK_movie_date_purch DEFAULT GETDATE() FOR Date_purch;

ALTER TABLE Rental ADD CONSTRAINT DK_rental_rental_date DEFAULT GETDATE() FOR Rental_date;

ALTER TABLE Rental ADD CONSTRAINT DK_rental_due_date DEFAULT DATEADD(DAY,2,GETDATE()) FOR Due_date;

ALTER TABLE Movie ADD CONSTRAINT CK_movie CHECK (Rating IN ('G', 'PG', 'R', 'NC17', 'NR'));

ALTER TABLE Rental ADD CONSTRAINT CK_Due_date CHECK (Due_date >= Rental_date);

EXEC sp_helpconstraint 'Movie';

EXEC sp_helpconstraint 'Rental';


