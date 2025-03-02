USE [QLBH002] 
GO 
 
/****** Object:  Database [QLBH]    ******/ 
CREATE DATABASE [QLBH002]  
ON  PRIMARY  
( NAME = 'QuanlyBH', FILENAME = 'D:\monsodulieu\QLBH1.mdf' , SIZE = 4048KB , MAXSIZE = 
10240KB , FILEGROWTH = 20%) 
 LOG ON  
( NAME = 'QLBH_log', FILENAME = 'D:\monsodulieu\QLBH_log1.ldf' , SIZE = 1024KB , MAXSIZE = 
10240KB , FILEGROWTH = 10%) 
GO 
 
use QLBH002 
GO 
CREATE TABLE NhomSanPham ( 
    [MaNhom] [int] PRIMARY KEY, 
    [TenNhom] [nvarchar](15) NULL ) 
GO 
 
/****** Object:  Table [dbo].[Nhanvien]    ******/ 
GO 
CREATE TABLE [dbo].[Nhanvien]( 
    [MaNV] [nchar](5) PRIMARY KEY, 
    [TenNV] [nvarchar](40) NOT NULL, 
    [DiaChi] [nvarchar](60) NULL, 
    [Dienthoai] [nvarchar](24) NULL ) 
GO 
 
/****** Object:  Table [dbo].[NhaCungCap]    ******/ 
 
GO 
CREATE TABLE [dbo].[NhaCungCap]( 
    [MaNCC] [int] NOT NULL, 
    [TenNcc] [nvarchar](40) NOT NULL, 
    [Diachi] [nvarchar](60) NULL, 
    [Phone] [nvarchar](24) NULL, 
    [SoFax] [nvarchar](24) NULL, 
    [DCMail] [nvarchar](50) NULL, 
PRIMARY KEY  (  [MaNCC]) ) 
GO 
 
/****** Object:  Table [dbo].[KhachHang]    ******/ 
 
GO 
CREATE TABLE [dbo].[KhachHang]( 
    [MaKh] [nchar](5) NOT NULL, 
    [TenKh] [nvarchar](40) NOT NULL, 
    [LoaiKh] [nvarchar](3) NULL, 
    [DiaChi] [nvarchar](60) NULL, 
    [Phone] [nvarchar](24) NULL, 
PRIMARY KEY ([MaKh]) )  
GO 
 
/****** Object:  Table [dbo].[SanPham]    ******/ 
 
CREATE TABLE [dbo].[SanPham]( 
    [MaSp] [int] NOT NULL, 
    [TenSp] [nvarchar](40) NOT NULL, 
    [MaNCC] [int] NULL, 
    [MoTa] [nvarchar](50) NULL, 
    [MaNhom] [int] NULL, 
    [Đonvitinh] [nvarchar](20) NULL, 
    [GiaGoc] [money] NULL, 
    [SLTON] [int] NULL, 
PRIMARY KEY ([MaSp]) ) 
GO 
 
/****** Object:  Table [dbo].[HoaDon]    ******/ 
CREATE TABLE [dbo].[HoaDon]( 
    [MaHD] [int] NOT NULL, 
    [NgayLapHD] [datetime] NULL, 
    [NgayGiao] [datetime] NULL, 
    [Noichuyen] [nvarchar](60) NOT NULL, 
    [MaNV] [nchar](5) NULL, 
    [MaKh] [nchar](5) NULL, 
PRIMARY KEY ([MaHD]) ) 
GO 
 
/****** Object:  Table [dbo].[CT_HoaDon]    ******/ 
GO 
CREATE TABLE [dbo].[CT_HoaDon]( 
    [MaHD] [int] NOT NULL, 
    [MaSp] [int] NOT NULL, 
    [Soluong] [smallint] NULL, 
    [Dongia] [money] NULL, 
    [ChietKhau] [money] NULL, 
PRIMARY KEY CLUSTERED  
( 
    [MaHD] ASC, 
    [MaSp] ASC 
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
) ON [PRIMARY] 
GO 
 
/****** Object:  Default [HD_df]    ******/ 
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [HD_df]  DEFAULT (getdate()) FOR 
[NgayLapHD] 
GO 
 
/****** Object:  Check [kh_ck]    ******/ 
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [kh_ck] CHECK  
(([LoaiKH]='VL' OR [LoaiKH]='TV' OR [LoaiKH]='VIP')) 
GO 
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [kh_ck] 
GO 
 
/****** Object:  Check [Sanpham_ck]    ******/ 
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [Sanpham_ck] CHECK  
(([giagoc]>(0))) 
GO 
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [Sanpham_ck] 
GO 
 
/****** Object:  Check [Sanpham_ck1]    ******/ 
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [Sanpham_ck1] CHECK  
(([slton]>(0))) 
GO 
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [Sanpham_ck1] 
GO 
 
/****** Object:  Check [sp_ck]    ******/ 
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [sp_ck] CHECK  (([SlTon]>(0))) 
GO 
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [sp_ck] 
GO 
 
/****** Object:  Check [HD_ck]    ******/ 
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [HD_ck] CHECK  
(([NgayLapHD]>=getdate())) 
GO 
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [HD_ck] 
GO 
 
/****** Object:  Check [CK__CT_HoaDon__Chiet__1CF15040]    ******/ 
ALTER TABLE [dbo].[CT_HoaDon]  WITH CHECK ADD CHECK  (([chietkhau]>=(0))) 
GO 
 
/****** Object:  Check [CK__CT_HoaDon__Soluo__1BFD2C07]    ******/ 
ALTER TABLE [dbo].[CT_HoaDon]  WITH CHECK ADD CHECK  (([soluong]>(0))) 
GO 
 
/****** Object:  ForeignKey [FK__SanPham__MaNCC__08EA5793]   ******/ 
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaNCC]) 
REFERENCES [dbo].[NhaCungCap] ([MaNCC]) 
GO 
 
/****** Object:  ForeignKey [FK__SanPham__MaNhom__09DE7BCC]   ******/ 
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD FOREIGN KEY([MaNhom]) 
REFERENCES [dbo].[NhomSanPham] ([MaNhom]) 
GO 
 
/****** Object:  ForeignKey [FK__HoaDon__MaKh__173876EA]   ******/ 
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD FOREIGN KEY([MaKh]) 
REFERENCES [dbo].[KhachHang] ([MaKh]) 
GO 
 
/****** Object:  ForeignKey [FK__HoaDon__MaNV__164452B1]    ******/ 
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD FOREIGN KEY([MaNV]) 
REFERENCES [dbo].[Nhanvien] ([MaNV]) 
GO 
 
/****** Object:  ForeignKey [FK__CT_HoaDon__MaHD__1DE57479]    ******/ 
ALTER TABLE [dbo].[CT_HoaDon]  WITH CHECK ADD FOREIGN KEY([MaHD]) 
REFERENCES [dbo].[HoaDon] ([MaHD]) 
GO 
 
/****** Object:  ForeignKey [FK__CT_HoaDon__MaSp__1ED998B2]  ******/ 
ALTER TABLE [dbo].[CT_HoaDon]  WITH CHECK ADD FOREIGN KEY([MaSp]) 
REFERENCES [dbo].[SanPham] ([MaSp]) 
GO 
 
ALTER TABLE [dbo].[KhachHang] ADD SoFax nvarchar(24)
GO

ALTER TABLE [dbo].[KhachHang] ADD DCMail nvarchar(50)
GO

ALTER TABLE [dbo].[KhachHang] ADD DiemTL int NULL
GO

ALTER TABLE [dbo].[HoaDon] ADD LoaiHD char(1) DEFAULT 'N' CHECK (LoaiHD IN ('N', 'X', 'C', 'T'))
GO

ALTER TABLE [dbo].[HoaDon] ADD CONSTRAINT CK_HOADON_NGAYGIAO CHECK (NGAYGIAO >= NGAYLAPHD);
GO