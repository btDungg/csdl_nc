create database QL_PK_NHAKHOA

--use master
--go
--drop database QL_PK_NHAKHOA
GO
use QL_PK_NHAKHOA

go

-- 1.NguoiDung --
create table NguoiDung
(
	MaNguoiDung char(6) primary key,
	HoTen nvarchar(35) not null,
	TaiKhoan varchar(12) unique  not null,
	MatKhau varchar(30) not null,
	LoaiNguoiDung varchar(3) CHECK (LoaiNguoiDung IN ('QTV', 'NV', 'NS'))
)



-- 2.QuanTriVien --
create table QuanTriVien
(
	MaQuanTriVien char(6) primary key,
	constraint QuanTriVien_NguoiDung
		foreign key (MaQuanTriVien) 
		references NguoiDung (MaNguoiDung) 
)

-- 3.NhanVien --
create table NhanVien
(
	MaNhanVien char(6) primary key,
	constraint NhanVien_NguoiDung
		foreign key (MaNhanVien) 
		references NguoiDung (MaNguoiDung) 
)

-- 4.NhaSi --
create table NhaSi
(
	MaNhaSi char(6) primary key,
	constraint NhaSi_NguoiDung
		foreign key (MaNhaSi) 
		references NguoiDung (MaNguoiDung) 
)


--12--
CREATE TABLE HoSoBenhNhan
(
	MaBenhNhan char(12) PRIMARY KEY,
	HoTen nvarchar(35) NOT NULL,
	GioiTinh nchar(3) CHECK (GioiTinh IN (N'Nam', N'Nữ')),
	NgaySinh DATE CHECK (NgaySinh < GETDATE()),
	DiaChi nvarchar(150) NOT NULL,
	SoDienThoai char(10) NOT NULL,
	TongTienDieuTri float CHECK(TongTienDieuTri >= 0),
	TongTienThanhToan float CHECK (TongTienThanhToan>= 0),
	GhiChu nvarchar(150)
	
)


-- 5.CuocHen --
create table CuocHen 
(
      MaCuocHen char(12),
	  MaNguoiTao char(6) FOREIGN KEY REFERENCES NhanVien(MaNhanVien),
	  MaBenhNhan char(12),
	  ThoiGian DateTime NOT NULL ,
	  TinhTrang nvarchar(12) CONSTRAINT CK_TT CHECK (TinhTrang IN (N'Tái khám', N'Cuộc hẹn mới')),
	  PRIMARY KEY (MaCuocHen),
	  constraint CH_HSBenhNHan
			foreign key (MaBenhNhan)
			references HoSoBenhNhan(MaBenhNhan),
)

-- 6.PhanCongCuocHen --
create table PhanCongCuocHen
(
	MaNhaSi char(6),
	MaCuocHen char(12) FOREIGN KEY REFERENCES CuocHen(MaCuocHen),
	VaiTro nvarchar(10) not null,
	primary key(MaNhaSi, MaCuocHen),
	constraint PC_NhaSi
		foreign key (MaNhaSi)
		references NhaSi (MaNhaSi),
	
)


--7--
create table PhongKham
(
     MaPhong char(4) primary key,
	 DiaChi nvarchar(50) NOT NULL
)


--8--
create table ChiTietNoiLamViec
(
    MaNhaSi char(6) FOREIGN KEY REFERENCES NhaSi(MaNhaSi),
	MaPhong char(4) FOREIGN KEY REFERENCES PhongKham(MaPhong),
	NgayLamViec date not null,
	primary key(MaNhaSi, MaPhong)
)


--10--
create table Thuoc
(
    MaThuoc char(12) primary key,
	TenThuoc varchar(35) not null,
	DonVi nvarchar(5) not null,
	SoLuongTon int not null check (SoLuongTon >=0),
	NgayHetHan date not null,
	GiaThuoc float not null check (GiaThuoc > 0)
)

--9--
create table DonThuoc 
(
   MaThuoc char(12) FOREIGN KEY REFERENCES Thuoc(MaThuoc),
   MaBenhNhan char(12) FOREIGN KEY REFERENCES HoSoBenhNhan(MaBenhNhan),
   SoLuong int not null,
   TongTien float NOT NULL CHECK (TongTien >= 0),
   primary key (MaThuoc, MaBenhNhan)
)


--11--
CREATE TABLE ChongChiDinh
(
	MaThuoc char(12) NOT NULL FOREIGN KEY REFERENCES Thuoc(MaThuoc),
	MaBenhNhan char(12) FOREIGN KEY REFERENCES HoSoBenhNhan(MaBenhNhan),
	PRIMARY KEY(MaThuoc,MaBenhNhan)
)





--13--
CREATE TABLE ThanhToan
(
	MaThanhToan char(12) ,
	MaBenhNhan char(12) NOT NULL FOREIGN KEY REFERENCES HoSoBenhNhan(MaBenhNhan),
	NgayGiaoDich DATE CHECK (NgayGiaoDich < GETDATE()) NOT NULL,
	NguoiThanhToan nvarchar(35),
	TongTien float CHECK (TongTien >= 0) NOT NULL,
	TienDaTra float CHECK (TienDaTra >=0 ) NOT NULL,
	TienThoi float CHECK (TienThoi >=0) NOT NULL,
	LoaiThanhToan nvarchar(35),
	GhiChu nvarchar(100),
	PRIMARY KEY(MaThanhToan)
)

--14--
CREATE TABLE DieuTri
(
	MaDieuTri char(4) NOT NULL,
	MoTa nvarchar(40),
	PhiDieuTri float CHECK (PhiDieuTri >= 0),
	PRIMARY KEY(MaDieuTri)
)

-- 15
create table KeHoachDieuTri
(
	MaKeHoach char(10) primary key,
	MoTa nvarchar(40),
	NgayDieuTri datetime not null default current_timestamp,
	GhiChu nvarchar(40),
	TrangThaiDieuTri nvarchar(20) check (TrangThaiDieuTri in (N'xanh dương', N'xanh lá', N'vàng')),
	MaDieuTri char(4),
	MaBenhNhan char(12),
	constraint KH_DieuTri
		foreign key (MaDieuTri)
		references DieuTri (MaDieuTri),
	constraint KH_BenhNhan
		foreign key (MaBenhNhan)
		references HoSoBenhNhan (MaBenhNhan)
) 




--16
CREATE TABLE PhanCongDieuTri
(
	MaNhaSi char(6) NOT NULL FOREIGN KEY REFERENCES NhaSi(MaNhaSi),
	MaKeHoach char(10) NOT NULL FOREIGN KEY REFERENCES KeHoachDieuTri(MaKeHoach),
	VaiTro nvarchar(10) NOT NULL,
	PRIMARY KEY(MaNhaSi,MaKeHoach)
)

--19
CREATE TABLE Rang
(
	MaRang char(5) NOT NULL PRIMARY KEY,
	TenRang nvarchar(20) NOT NULL
)


--18
CREATE TABLE BeMatRang
(
    MaRang char(5) NOT NULL,
    MaMatRang char(13) NOT NULL,
    TenMatRang nvarchar(20) NOT NULL,
    PRIMARY KEY (MaRang, MaMatRang),
    FOREIGN KEY (MaRang) REFERENCES Rang(MaRang)
);

--17
CREATE TABLE RangDieuTri
(
    MaRang char(5) NOT NULL,
    MaMatRang char(13) NOT NULL,
    MaKeHoach char(10) NOT NULL,
    PRIMARY KEY(MaRang, MaMatRang, MaKeHoach),
    FOREIGN KEY (MaRang, MaMatRang)
        REFERENCES BeMatRang(MaRang, MaMatRang),
    FOREIGN KEY (MaKeHoach)
        REFERENCES KeHoachDieuTri(MaKeHoach)
);

Go
CREATE TRIGGER trg_AfterInsertNguoiDung
ON NguoiDung
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Thêm dữ liệu vào bảng QuanTriVien nếu LoaiNguoiDung là 'QTV'
    INSERT INTO QuanTriVien (MaQuanTriVien)
    SELECT i.MaNguoiDung
    FROM inserted i
    WHERE i.LoaiNguoiDung = 'QTV';

    -- Thêm dữ liệu vào bảng NhanVien nếu LoaiNguoiDung là 'NV'
    INSERT INTO NhanVien (MaNhanVien)
    SELECT i.MaNguoiDung
    FROM inserted i
    WHERE i.LoaiNguoiDung = 'NV';

    -- Thêm dữ liệu vào bảng NhaSi nếu LoaiNguoiDung là 'NS'
    INSERT INTO NhaSi (MaNhaSi)
    SELECT i.MaNguoiDung
    FROM inserted i
    WHERE i.LoaiNguoiDung = 'NS';
END;	



go
BULK INSERT NguoiDung
FROM 'C:\Users\dungtb\Desktop\CSDL_NC\csdl_nc\NguoiDung.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,  -- Nếu file Excel có dòng tiêu đề
    FORMAT = 'CSV',
    CODEPAGE = '65001'  -- UTF-8 encoding
);

go
----insert tu file
BULK INSERT HoSoBenhNhan
FROM 'C:\Users\dungtb\Desktop\CSDL_NC\csdl_nc\HSBN.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,  -- Nếu file Excel có dòng tiêu đề
    FORMAT = 'CSV',
    CODEPAGE = '65001'  -- UTF-8 encoding
);


go
INSERT INTO QuanTriVien (MaQuanTriVien)
SELECT MaNguoiDung FROM NguoiDung WHERE LoaiNguoiDung = 'QTV';

go
INSERT INTO NhanVien (MaNhanVien)
SELECT MaNguoiDung FROM NguoiDung WHERE LoaiNguoiDung = 'NV';
go
INSERT INTO NhaSi (MaNhaSi)
SELECT MaNguoiDung FROM NguoiDung WHERE LoaiNguoiDung = 'NS';

go
select * from NhanVien
select * from NguoiDung



