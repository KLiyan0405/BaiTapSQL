use QLBH_T6
GO

--tuần 8: bài tập 4
-- 1. Các product có đơn giá bán lớn hơn đơn giá bán trung bình của tất cả products
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

-- 2. Các product có đơn giá bán lớn hơn đơn giá bán trung bình của các product có ProductName bắt đầu là 'N'
INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock) VALUES('Non bao hiem', 7, 25.00, 100);
INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock) VALUES('Noi gang', 5, 15.00, 150);
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products WHERE ProductName LIKE 'N%');

-- 3. Những sản phẩm có tên bắt đầu bằng chữ 'N' và đơn giá bán > đơn giá bán của sản phẩm khác
SELECT p1.ProductID, p1.ProductName, p1.UnitPrice
FROM Products p1
WHERE p1.ProductName LIKE 'N%'
AND p1.UnitPrice > ANY (
    SELECT p2.UnitPrice
    FROM Products p2
    WHERE p2.ProductID <> p1.ProductID
);

-- 4. Danh sách các products đã có khách hàng đặt hàng
SELECT DISTINCT P.ProductID, P.ProductName, P.UnitPrice
FROM Products P
JOIN OrdersDetails OD ON P.ProductID = OD.ProductID;

-- 5. Các products có đơn giá nhập lớn hơn đơn giá bán nhỏ nhất của tất cả các products
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT MIN(UnitPrice) FROM Products);

-- 6. Danh sách hóa đơn của Customers ở thành phố London và Madrid
SELECT * FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.City IN ('London', 'Madrid');

-- 7. Các products có đơn vị tính chứa chữ 'Box' và đơn giá mua < đơn giá bán trung bình
INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES 
('Chocolate Box', 8, 15.00, 50),
('Tea Box', 7, 20.00, 30);

SELECT * FROM Products
WHERE ProductName LIKE '%Box%'
AND UnitPrice < (SELECT AVG(UnitPrice) FROM Products);

-- 8. Danh sách các Products có số lượng (Quantity) bán được lớn nhất
SELECT ProductID, ProductName
FROM Products
WHERE ProductID IN (
    SELECT ProductID
    FROM OrdersDetails
    WHERE Quantity = (SELECT MAX(Quantity) FROM OrdersDetails));

-- 9. Danh sách các Customers chưa từng lập hóa đơn
INSERT INTO Customers (CompanyName, Address, City, Region, Country)
VALUES 
('Nhat Linh', 'duong 123', 'Lon Don', 'LonDon', 'My'),
('My Hanh', 'duong 789', 'My Tho', 'Tien Giang', 'VietNam');
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- 10--. Các sản phẩm có đơn vị tính chứa chữ 'Box' và có đơn giá bán cao nhất
INSERT INTO Products (ProductName, SupplierID, UnitPrice, UnitInStock)  
VALUES('Wine Box', 2, 200.00, 30)
SELECT * FROM Products
WHERE ProductName LIKE '%Box%'
AND UnitPrice = (SELECT MAX(UnitPrice) FROM Products);

-- 11. Các products có đơn giá bán lớn hơn đơn giá bán trung bình của Products có ProductID <= 5
SELECT * FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products WHERE ProductID <= 5);

-- 12. Các sản phẩm có tổng số lượng bán được lớn hơn số lượng trung bình bán ra
SELECT P.ProductID, P.ProductName
FROM Products P
JOIN OrdersDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductID, P.ProductName
HAVING SUM(OD.Quantity) > (SELECT AVG(Quantity) FROM OrdersDetails);

-- 13. Khách hàng mua hóa đơn mà hóa đơn chỉ mua sản phẩm có mã >= 3
SELECT DISTINCT C.*
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE NOT EXISTS (
    SELECT 1 FROM OrdersDetails OD
    WHERE OD.OrderID = O.OrderID AND OD.ProductID < 3
);

-- 14---. Sản phẩm có trên 20 đơn hàng trong quý 3 năm 1998
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)  
VALUES  
(1, 3, '1998-08-10'),  
(2, 4, '1998-09-15');

INSERT INTO OrdersDetails (OrderID, ProductID, UnitPrice, Quantity)  
VALUES  
(38, 1, 1500.00, 25), 
(39, 2, 1500.00, 30);  

SELECT p.ProductID, p.ProductName  
FROM Products p  
JOIN OrdersDetails od ON p.ProductID = od.ProductID  
JOIN Orders o ON od.OrderID = o.OrderID  
WHERE YEAR(o.OrderDate) = 1998  
AND MONTH(o.OrderDate) BETWEEN 7 AND 9  
GROUP BY p.ProductID, p.ProductName  
HAVING SUM(od.Quantity) > 20;

-- 15. Sản phẩm chưa bán trong tháng 6 năm 1996
SELECT * FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID FROM OrdersDetails OD
    JOIN Orders O ON OD.OrderID = O.OrderID
    WHERE YEAR(O.OrderDate) = 1996 AND MONTH(O.OrderDate) = 6
);

-- 16. Nhân viên không lập hóa đơn vào ngày hôm nay
SELECT * FROM Employees
WHERE EmployeeID NOT IN (
    SELECT EmployeeID FROM Orders WHERE OrderDate = CAST(GETDATE() AS DATE)
);

-- 17. Customers chưa mua hàng trong năm 1997
SELECT * FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1997
);

-- 18. Customers mua sản phẩm có tên bắt đầu bằng 'T' trong tháng 7
SELECT DISTINCT C.*
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrdersDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.ProductName LIKE 'T%' AND MONTH(O.OrderDate) = 7;

-- 19. Các City có hơn 3 khách hàng
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 3;

-- 20. Sự khác nhau của 3 truy vấn ALL, ANY
-- Câu 1: Lấy các sản phẩm có đơn giá lớn hơn tất cả sản phẩm có tên bắt đầu bằng 'B'
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > ALL (SELECT UnitPrice FROM Products WHERE ProductName LIKE 'B%');

-- Câu 2: Lấy các sản phẩm có đơn giá lớn hơn ít nhất một sản phẩm có tên bắt đầu bằng 'B'
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > ANY (SELECT UnitPrice FROM Products WHERE ProductName LIKE 'B%');

-- Câu 3: Lấy các sản phẩm có đơn giá bằng ít nhất một sản phẩm có tên bắt đầu bằng 'B'
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice = ANY (SELECT UnitPrice FROM Products WHERE ProductName LIKE 'B%');

--bài tập 5:
--câu 1:
SELECT 
    CAST(CustomerID AS NVARCHAR) AS CodeID, 
    CompanyName AS Name, 
    Address, 
    Phone
FROM Customers
UNION ALL
SELECT 
    CAST(EmployeeID AS NVARCHAR) AS CodeID, 
    LastName + ' ' + FirstName AS Name, 
    NULL AS Address, --Employees không có Address, dùng NULL
     Phone AS HomePhone
FROM Employees;

--câu 2:
SELECT 
    c.CustomerID, 
    c.CompanyName, 
    c.Address, 
    SUM(od.Quantity * od.UnitPrice) AS Total
INTO HDKH_71997  -- Tạo bảng mới và chèn dữ liệu vào đó
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrdersDetails od ON o.OrderID = od.OrderID
WHERE MONTH(o.OrderDate) = 7 AND YEAR(o.OrderDate) = 1997
GROUP BY c.CustomerID, c.CompanyName, c.Address;

--câu 3:
SELECT 
    e.EmployeeID, 
    e.LastName + ' ' + e.FirstName AS Name, 
    e.City, 
    SUM(od.Quantity * od.UnitPrice) AS Total
INTO LuongNV  
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrdersDetails od ON o.OrderID = od.OrderID
WHERE MONTH(o.OrderDate) = 12 AND YEAR(o.OrderDate) = 1996
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.City;

--câu 4:
SELECT 
    o.CustomerID, 
    c.CompanyName, 
    SUM(od.Quantity * od.UnitPrice) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrdersDetails od ON o.OrderID = od.OrderID
WHERE 
    c.Region IN ('Germany', 'USA') 
    AND o.OrderDate BETWEEN '1998-01-01' AND '1998-03-31'
GROUP BY o.CustomerID, c.CompanyName
HAVING SUM(od.Quantity * od.UnitPrice) > 0;

--câu 5:
CREATE TABLE dbo.HoaDonBanHang 
(orderid INT NOT NULL, 
orderdate DATE NOT NULL, 
empid INT NOT NULL, 
custid VARCHAR(5) NOT NULL, 
qty INT NOT NULL, 
CONSTRAINT PK_Orders PRIMARY KEY(orderid))
 INSERT INTO HoaDonBanHang (orderid, orderdate, empid, custid, qty) 
 VALUES
(30001, '20070802', 3, 'A', 10), 
(10001, '20071224', 2, 'A', 12), 
(10005, '20071224', 1, 'B', 20), 
(40001, '20080109', 2, 'A', 40), 
(10006, '20080118', 1, 'C', 14), 
(20001, '20080212', 2, 'B', 12), 
(40005, '20090212', 3, 'A', 10), 
(20002, '20090216', 1, 'C', 20), 
(30003, '20090418', 2, 'B', 15), 
(30004, '20070418', 3, 'C', 22), 
(30007, '20090907', 3, 'D', 30);
--câu a:
SELECT 
    empid, 
    custid, 
    SUM(qty) AS TotalQty
FROM dbo.HoaDonBanHang
GROUP BY empid, custid
ORDER BY empid, custid;

--câu b:
SELECT empid, A, B, C, D
FROM (
    SELECT empid, custid, qty
    FROM dbo.HoaDonBanHang  
) AS D
PIVOT (
    SUM(qty)
    FOR custid IN (A, B, C, D)  
) AS P;

--câu c:
SELECT 
    YEAR(orderdate) AS OrderYear, 
    empid, 
    COUNT(orderid) AS TotalOrders
FROM dbo.HoaDonBanHang
GROUP BY YEAR(orderdate), empid
ORDER BY OrderYear, empid;
--câu d:
INSERT INTO dbo.HoaDonBanHang (orderid, orderdate, empid, custid, qty)  
VALUES  
(50001, '2007-03-15', 164, 'A', 10),  
(50002, '2008-07-10', 198, 'B', 12),  
(50003, '2009-06-20', 223, 'C', 15),  
(50004, '2007-09-25', 231, 'D', 8);

SELECT * 
FROM (
    SELECT empid, YEAR(orderdate) AS OrderYear, COUNT(orderid) AS OrderCount
    FROM dbo.HoaDonBanHang
    WHERE empid IN (164, 198, 223, 231, 233)
    GROUP BY empid, YEAR(orderdate)
) AS SourceTable
PIVOT (
    SUM(OrderCount)
    FOR OrderYear IN ([2007], [2008], [2009])  -- Điều chỉnh theo năm có trong dữ liệu
) AS PivotTable;


