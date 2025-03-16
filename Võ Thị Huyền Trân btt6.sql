CREATE DATABASE [QLBH_T6]  
ON  PRIMARY  
( NAME = 'QuanlyBH_T6', FILENAME = 'D:\monsodulieu\T6\QLBHT6.mdf' , SIZE = 4048KB , MAXSIZE = 
10240KB , FILEGROWTH = 20%) 
 LOG ON  
( NAME = 'QLBHT6_log', FILENAME = 'D:\monsodulieu\T6\QLBHT6_log.ldf' , SIZE = 1024KB , MAXSIZE = 
10240KB , FILEGROWTH = 10%) 
GO 
 
use QLBH_T6
GO 

create table Suppliers
(SuppliersID int IDENTITY(1,1)  primary key,
SupplierName nvarchar(255) not null)

create table Products
(ProductID int IDENTITY(1,1) primary key, 
ProductName varchar(255),
SupplierID int,
UnitPrice decimal(10, 2),
UnitInStock int,
foreign key (SupplierID) references Suppliers(SuppliersID))

create table Customers
(CustomerID int IDENTITY(1,1) primary key,
CompanyName nvarchar(255) not null, 
Address nvarchar(255),
City nvarchar(255),
Region nvarchar(255),
Country nvarchar(255))

create table Employees
(EmployeeID int IDENTITY(1,1)  primary key,
LastName nvarchar(255) not null,
FirstName nvarchar(255) not null,
BirthDate Date,
City nvarchar(255))

create table Orders
(OrderID int IDENTITY(1,1) primary key,
CustomerID int,
EmployeeID int,
OrderDate Date,
foreign key (CustomerID) references Customers(CustomerID),
foreign key (EmployeeID) references Employees(EmployeeID))

create table OrdersDetails
(OrderID int,
ProductID int,
UnitPrice decimal(18, 2) not null,
Quantity int not null,
Discount decimal(4, 2) default 0,
primary key (OrderID, ProductID),
foreign key (OrderID) references Orders(OrderID),
foreign key (ProductID) references Products(ProductID))


INSERT INTO Suppliers (SupplierName) 
VALUES ('Congty ABC'), ('Congty CEF'), ('Congty Nutri'), ('Congty TKN'), ('Congty Tiki');


INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock) VALUES ('May Tinh', 1, 10.05, 105)
INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock) VALUES ('Lo vi song', 2, 22.15, 75)
INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock) VALUES ('Sua trai cay', 3,10.00,223)
INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock) VALUES ('Sua dinh duong', 4, 15.15, 45)
INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock) VALUES ('Banh quy', 5, 26.00,6)


ALTER TABLE Customers ADD Phone NVARCHAR(50)
Go

ALTER TABLE Customers ADD Fax NVARCHAR(50)
Go

ALTER TABLE Customers ADD ContactTitle NVARCHAR(100)
Go

INSERT INTO Customers (CompanyName, Address, City, Region, Country, ContactTitle, Phone, Fax) VALUES ('Hoa Hao', 'so 97 Pham Ngoc Thach' , 'Lam Dong', 'Tay Nguyen', 'VietNam', 'CEO', '012345678', NULL)
INSERT INTO Customers (CompanyName, Address, City, Region, Country, ContactTitle, Phone, Fax) VALUES ('An Phuoc', '9/7 Tan Thoi Nhat', 'Bac Giang', 'Dong Bac Bo', 'VietNam', 'Quan ly', '098765432', '1234543')
INSERT INTO Customers (CompanyName, Address, City, Region, Country, ContactTitle, Phone, Fax) VALUES ('Cadina', '520 Truong Chinh', 'Lang Son', 'Dong Bac Bo', 'VietNam', 'CEO', '097523678', NULL)
INSERT INTO Customers (CompanyName, Address, City, Region, Country, ContactTitle, Phone, Fax) VALUES ('Viet Tien', '10 Nguyen Oanh', 'Lao Cai', 'Tay Bac Bo', 'VietNam', 'Truong Nhom', '023415672', '8645798')
INSERT INTO Customers (CompanyName, Address, City, Region, Country, ContactTitle, Phone, Fax) VALUES ('Ngoc Gia', '12 Ha Dong', 'Ha Giang', 'Dong Bac Bo', 'VietNam', 'CEO', '022335679', NULL)


ALTER TABLE Employees ADD Phone NVARCHAR(50)
Go

INSERT INTO Employees (LastName, FirstName, BirthDate, City, Phone) VALUES ('Nguyen', 'Hoang', '1955-06-15', 'Tuyen Quang', '091234678')
INSERT INTO Employees (LastName, FirstName, BirthDate, City, Phone) VALUES ('Duong', 'Sang', '1962-04-10', 'Cao Bang', '056789234')
INSERT INTO Employees (LastName, FirstName, BirthDate, City, Phone) VALUES ('Le', 'Ngoc', '1975-12-25', 'My Tho', '012344325')
INSERT INTO Employees (LastName, FirstName, BirthDate, City, Phone) VALUES ('Vo', 'Nhan', '1981-07-20', 'Ba Ria', '098456724')
INSERT INTO Employees (LastName, FirstName, BirthDate, City, Phone) VALUES ('Ha', 'Canh', '1990-01-05', 'Bac Ninh', '098347982')

INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES (1, 1, '1996-09-12')
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES (2, 2, '1996-10-05')
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES (3, 3, '1997-12-06')
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES (4, 4, '1998-12-07')
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES (5, 5, '1997-12-13')

INSERT INTO OrdersDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES (1, 1, 10.05, 5, 0.10)
INSERT INTO OrdersDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES (2, 2, 22.15, 2, 0.05)
INSERT INTO OrdersDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES (3, 3, 10.00, 1, 0.01)
INSERT INTO OrdersDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES (4, 4, 15.15, 10, 0.20)
INSERT INTO OrdersDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES (5, 5, 26.00, 3, 0.15)

--cau 1:
select C.CustomerID, CompanyName, Address, OrderID, O.Orderdate
FROM Customers C INNER JOIN Orders O
ON C.CustomerID = O.CustomerID 
where MONTH(O.OrderDate) = 7 and Year(O.OrderDate) = 1997
ORDER by C.CustomerID, O.OrderDate DESC
INSERT INTO Employees (LastName, FirstName, BirthDate, City, Phone) VALUES ('Ha', 'Khanh', '1989-12-05', 'Bac Ninh', '0534678298')
INSERT INTO Customers (CompanyName, Address, City, Region, Country, ContactTitle, Phone, Fax) VALUES ('Hanh Thong', '23 Pham Van Dong' , 'My Tho', 'Tien Giang', 'VietNam', 'CEO', '0234568234', NULL)
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES (6, 6, '1997-07-12')
--cau 2:
select C.CustomerID, CompanyName, Address, OrderID, O.Orderdate
FROM Customers C INNER JOIN Orders O
ON C.CustomerID = O.CustomerID 
WHERE O.OrderDate BETWEEN '1997-01-01' AND '1997-01-15'
ORDER BY c.CustomerID, o.OrderDate DESC;
INSERT INTO Employees (LastName, FirstName, BirthDate, City, Phone) VALUES ('Nguyen', 'Khanh', '1988-2-15', 'ha Giang', '01234675893')
INSERT INTO Customers (CompanyName, Address, City, Region, Country, ContactTitle, Phone, Fax) VALUES ('Nhat Anh', '73 Nguyen Kim' , 'Dong Thap', 'dong Thap', 'VietNam', 'Quan ly', '0789654637', 2345765)
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate) VALUES (7, 7, '1997-01-12')
--cau3:
SELECT P.ProductID, P.ProductName, OD.OrderID, O.OrderDate
FROM Products P INNER JOIN OrdersDetails OD  ON P.ProductID = OD.ProductID
INNER JOIN Orders O ON OD.OrderID = O.OrderID
WHERE O.OrderDate = '1996-07-16';
--cau4:
SELECT O.OrderID, C.CompanyName, O.OrderDate, O.RequiredDate
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE (MONTH(O.OrderDate) IN (4, 9) AND YEAR(O.OrderDate) = 1997)
ORDER BY C.CompanyName, O.OrderDate DESC;

ALTER TABLE Orders ADD RequiredDate Date
Go

--cau5:
SELECT O.OrderID, E.LastName, E.FirstName, O.OrderDate
FROM Orders O
INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
WHERE E.LastName = 'Fuller';
--cau6:
SELECT P.ProductID, P.ProductName, P.SupplierID
FROM Products P
INNER JOIN OrdersDetails OD ON P.ProductID = OD.ProductID
INNER JOIN Orders O ON OD.OrderID = O.OrderID
WHERE P.SupplierID IN (1, 3, 6) 
AND DATEPART(QUARTER, O.OrderDate) = 2 
AND YEAR(O.OrderDate) = 1997
ORDER BY P.SupplierID, P.ProductID;
--cau7:
SELECT P.ProductID, P.ProductName, P.UnitPrice
FROM Products P
INNER JOIN OrdersDetails OD ON P.ProductID = OD.ProductID
WHERE P.UnitPrice = OD.UnitPrice;
--cau8:
SELECT P.ProductID, P.ProductName, OD.Quantity, OD.UnitPrice
FROM Products P
INNER JOIN OrdersDetails OD ON P.ProductID = OD.ProductID
WHERE OD.OrderID = 10248;
--cau9:
SELECT DISTINCT E.EmployeeID, E.LastName, E.FirstName
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE MONTH(O.OrderDate) = 7 AND YEAR(O.OrderDate) = 1996;
--cau10:
SELECT P.ProductID, P.ProductName, OD.OrderID, O.OrderDate, O.CustomerID,
       OD.UnitPrice, OD.Quantity, (OD.Quantity * OD.UnitPrice) AS Total
FROM Products P
INNER JOIN OrdersDetails OD ON P.ProductID = OD.ProductID
INNER JOIN Orders O ON OD.OrderID = O.OrderID
WHERE MONTH(O.OrderDate) = 12 AND YEAR(O.OrderDate) = 1996
AND DATENAME(WEEKDAY, O.OrderDate) IN ('Saturday', 'Sunday')
ORDER BY P.ProductID, OD.Quantity DESC;
--cau11:
SELECT E.EmployeeID, E.FirstName + ' ' + E.LastName AS EmployeeName,
       O.OrderID, O.OrderDate, OD.ProductID, OD.Quantity, OD.UnitPrice,
       (OD.Quantity * OD.UnitPrice) AS Total
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN OrdersDetails OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1996;
--cau12:
SELECT O.OrderID, O.ShippedDate
FROM Orders O
WHERE MONTH(O.ShippedDate) = 12 AND YEAR(O.ShippedDate) = 1996
AND DATENAME(WEEKDAY, O.ShippedDate) = 'Saturday';

ALTER TABLE Orders ADD ShippedDate Date
Go
--cau13:
SELECT E.EmployeeID, E.LastName, E.FirstName
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE O.EmployeeID IS NULL;

--cau14:
SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN OrdersDetails OD ON P.ProductID = OD.ProductID
WHERE OD.ProductID IS NULL;

--cau15:
SELECT C.CustomerID, C.CompanyName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL;





