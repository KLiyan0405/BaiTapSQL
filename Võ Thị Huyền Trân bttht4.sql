DELETE FROM CT_HoaDon;
DELETE FROM HoaDon;
DELETE FROM KhachHang;
DELETE FROM SanPham;
DELETE FROM NhaCungCap;
DELETE FROM NhomSanPham;

--câu 2
INSERT INTO NhomSanPham(Manhom, TenNhom)
VALUES (1, 'Điện Tử'),
       (2, 'Gia Dụng'),
       (3, 'Dụng Cụ Gia Đình'),
       (4, 'Các Mặt Hàng Khác');

INSERT INTO NhaCungCap (MaNCC, TenNcc, DiaChi, Phone, SoFax, DCMail)
VALUES (1, 'Công ty TNHH Nam Phương', '1 Lê Lợi Phường 4 Quận Gò Vấp', '083843456...', '32343434...', 'NamPhuong@yahoo.com'),
       (2, 'Công Ty Lan Ngọc', '12 Cao Bá Quát Quận 1 Tp . Hồ Chí Minh ...', '086234567...', '83434355...', 'LanNgoc@gmail.com');

INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa,MaNhom, Đonvitinh, GiaGoc, SLTON)
VALUES (1, 'Máy Tính', 1, 'Máy Sony Ram 2GB', 1,'Cái', 7000.0000, 100),
       (2, 'Bàn phím', 1, 'Bàn phím 101 phím',1 'Cái', 1000.0000, 50 ),
       (3, 'Chuột',1,'Chuột không dây',1,'Cái', 800.0000, 150),
       (4, 'CPU',1, 'CPU',1,'Cái', 3000.0000, 200),
       (5, 'USB',1, '8GB',1,'Cái', 500.0000, 100),
       (6, 'Lò Vi Sóng',2,'NULL',3, 'Cái', 1000000.0000, 20);

INSERT INTO KhachHang (MaKH, TenKH, DiaChi, LoaiKH, Phone , SoFax, DCMail, DiemTL)
VALUES ('KH1', 'Nguyễn Thu Hằng', '12 Nguyễn Du','VL',  NULL, , NULL, NULL, NULL),
       ('KH2', ' Lê Minh', '34 Điện Biên Phủ','TV', '0123943455', , NULL, 'LeMinh@yahoo.com', 100),
       ('KH3', ' Nguyễn Minh Trung', '3 Lê Lợi Quận Gò Vấp', 'VIP','098343434', NULL, 'Trung@gmail.com', 800);

INSERT INTO HoaDon (MaHD, NgayLapHD,NgayGiao,Noichuyen, MaKH, )
VALUES (1, '2015-09-30 00:00:00.000', '2015-10-05 00:00:00.000', 'Cửa Hàng ABC 3 Lý Chính Thắng Quận 3','KH1'),
       (2, '2015-07-29 00:00:00.000', '2015-08-10 00:00:00.000', '23 Lê Lợi Quận Gò Vấp', 'KH2'),
       (3, '2015-10-01 00:00:00.000', '2015-10-01 00:00:00.000', '2 Nguyễn Du Quận Gò Vấp', 'KH3');

INSERT INTO CT_HoaDon (MaHD, MaSp,Soluong, Dongia)
VALUES (1, 1,5, 8000.0000),
       (1, 2,4, 1200.0000),
       (1, 3,15 1000.0000),
       (2, 2,9, 1200.0000),
       (2, 4,5, 800.0000),
       (3, 2,20, 3500.0000),
       (3, 3,15, 1000.0000);

--câu 3
-- a) Tăng đơn giá bán lên 5% cho sản phẩm có mã là 2
UPDATE SanPham
SET GiaGoc = GiaGoc * 1.05
WHERE MaSp = 2;

-- b) Tăng số lượng tồn lên 100 cho các sản phẩm có nhóm mặt hàng là 3 của nhà cung cấp có mã là 2
UPDATE SanPham
SET SLTON = SLTON + 100
WHERE MaNhom = 3 AND MaNCC = 2;

-- c) Tăng điểm tích lũy lên 50 cho những khách hàng không phải là khách hàng vãng lai (VL)
UPDATE KhachHang
SET DiemTL = DiemTL + 50
WHERE LoaiKh <> 'VL';

-- d) Cập nhật cột mô tả cho sản phẩm có tên là 'Lò vi sóng'
UPDATE SanPham
SET MoTa = N'Lò vi sóng 23L, điều khiển điện tử, công suất 800W'
WHERE TenSp = N'Lò vi sóng';

-- e) Tăng đơn giá gốc lên 2% cho những sản phẩm mà phần tên có chứa chữ 'u' (không phân biệt hoa thường)
UPDATE SanPham
SET GiaGoc = GiaGoc * 1.02
WHERE TenSp LIKE N'%u%';
--câu 4
-- a) Xóa các sản phẩm có SLTon < 2
DELETE FROM SanPham
WHERE SLTON < 2;

-- b) Xóa các hóa đơn của khách hàng vãng lai (VL)
DELETE FROM HoaDon
WHERE MaKh IN (SELECT MaKh FROM KhachHang WHERE LoaiKh = 'VL');

-- c) Xóa khách hàng thuộc loại VIP mà có điểm tích lũy bằng 0
DELETE FROM KhachHang
WHERE LoaiKh = 'VIP' AND DiemTL = 0;
