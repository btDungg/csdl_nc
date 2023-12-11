<<<<<<< HEAD
﻿
create table CuocHen 
(
      MaCuocHen char(12),
	  MaNguoiTao char(6),
	  MaBenhNhan char(12),
	  ThoiGian DateTime NOT NULL ,
	  TinhTrang nvarchar(12) CONSTRAINT CK_TT CHECK (TinhTrang IN (N'Tái khám', N'Cuộc hẹn mới'))
)


--13--
CREATE TABLE ThanhToan
(
	MaThanhToan char(12) ,
	MaBenhNhan char(12) NOT NULL,
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
--11--
CREATE TABLE ChongChiDinh
(
	MaThuoc char(12) NOT NULL,
	MaBenhNhan char(12),
	PRIMARY KEY(MaThuoc,MaBenhNhan)
)
--12--
CREATE TABLE HoSoBenhNhan
(
	MaBenhNhan char(12),
	HoTen nvarchar(35) NOT NULL,
	GioiTinh nchar(3) CHECK (GioiTinh IN (N'Nam', N'Nữ')),
	NgaySinh DATE CHECK (NgaySinh < GETDATE()),
	DiaChi nvarchar(50) NOT NULL,
	SoDienThoai char(10) NOT NULL,
	TongTienDieuTri float CHECK(TongTienDieuTri >= 0),
	TongTienThanhToan float CHECK (TongTienThanhToan>= 0),
	GhiChu nvarchar(100),
	PRIMARY KEY (MaBenhNhan),
)

--7--
create table PhongKham
(
     MaPhong char(4),
	 DiaChi nvarchar(50) NOT NULL

)



--16
CREATE TABLE PhanCongDieuTri
(
	MaNhaSi char(6) NOT NULL,
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
	MaMatRang char(13) NOT NULL,
	MaRang char(5) NOT NULL FOREIGN KEY REFERENCES Rang(MaRang),
	TenMatRang nvarchar(20) NOT NULL,
	PRIMARY KEY (MaMatRang,MaRang)
)

--17
CREATE TABLE RangDieuTri
(
	MaRang char(5) NOT NULL,
	MaMatRang char(13) NOT NULL,
	MaKeHoach char(10) NOT NULL FOREIGN KEY REFERENCES KeHoachDieuTri(MaKeHoach),
	PRIMARY KEY(MaRang,MaMatRang,MaKeHoach),
	FOREIGN KEY(MaRang,MaMatRang)
	REFERENCES BeMatRang(MaRang,MaMatRang)
)

=======
﻿-- 1.NguoiDung --
>>>>>>> origin/TheDuyet
create table NguoiDung
(
	MaNguoiDung char(6) primary key,
	HoTen nvarchar(35) not null,
	TaiKhoan varchar(12) unique not null,
	MatKhau varchar(30) not null,
	LoaiNguoiDung varchar(3)
)

-- 2.QuanTriVien --
create table QuanTriVien
(
	MaQuanTriVien char(6) primary key,
	constraint QuanTriVien 
		foreign key (MaQuanTriVien) 
		references NguoiDung (MaNguoiDung) 
)

-- 3.NhanVien --
create table NhanVien
(
	MaNhanVien char(6) primary key,
	constraint NhanVien 
		foreign key (MaNhanVien) 
		references NguoiDung (MaNguoiDung) 
)

-- 4.NhaSi --
create table NhaSi
(
	MaNhaSi char(6) primary key,
	constraint NhaSi
		foreign key (MaNhaSi) 
		references NguoiDung (MaNguoiDung) 
)

-- 5.CuocHen --
create table CuocHen 
(
      MaCuocHen char(12),
	  MaNguoiTao char(6),
	  MaBenhNhan char(12),
	  ThoiGian DateTime NOT NULL ,
	  TinhTrang nvarchar(12) CONSTRAINT CK_TT CHECK (TinhTrang IN (N'Tái khám', N'Cuộc hẹn mới'))
)

-- 6.PhanCongCuocHen --
create table PhanCongCuocHen
(
	MaNhaSi char(6),
	MaCuocHen char(12),
	VaiTro nvarchar(10) not null,
	primary key(MaNhaSi, MaCuocHen),
	constraint PC_NhaSi
		foreign key (MaNhaSi)
		references NhaSi (MaNhaSi),
	constraint PC_CuocHen
		foreign key (MaCuocHen)
		references CuocHen (MaCuocHen)
)



--14--
CREATE TABLE DieuTri
(
	MaDieuTri char(4) NOT NULL,
	MoTa nvarchar(40),
	PhiDieuTri float CHECK (PhiDieuTri >= 0),
	PRIMARY KEY(MaDieuTri)
)
--11--
CREATE TABLE ChongChiDinh
(
	MaThuoc char(12) NOT NULL,
	MaBenhNhan char(12),
	PRIMARY KEY(MaThuoc,MaBenhNhan)
)

create table PhongKham
(
     MaPhong char(4),
	 DiaChi nvarchar(50) NOT NULL

)

-- 15
create table KeHoachDieuTri
(
	MaKeHoach char(10) primary key,
	MoTa nvarchar(40),
	NgayDieuTri datetime not null default current_date,
	GhiChu nvarchar(40),
	TrangThaiDieuTri nvarchar(20) check (TinhTrang in (N'xanh dương', N'xanh lá', N'vàng')),
	MaDieuTri char(4),
	MaBenhNhan char(12),
	constraint KH_DieuTri
		foreign key (MaDieuTri)
		references DieuTri (MaDieuTri),
	constraint KH_BenhNhan
		foreign key (MaBenhNhan)
		references BenhNhan (MaBenhNhan)
) 

--16
CREATE TABLE PhanCongDieuTri
(
	MaNhaSi char(6) NOT NULL,
	MaKeHoach char(10) NOT NULL FOREIGN KEY REFERENCES KeHoachDieuTri(MaKeHoach),
	VaiTro nvarchar(10) NOT NULL,
	PRIMARY KEY(MaNhaSi, MaKeHoach)
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
	MaMatRang char(13) NOT NULL,
	MaRang char(5) NOT NULL FOREIGN KEY REFERENCES Rang(MaRang),
	TenMatRang nvarchar(20) NOT NULL,
	PRIMARY KEY (MaMatRang,MaRang)
)

--17
CREATE TABLE RangDieuTri
(
	MaRang char(5) NOT NULL,
	MaMatRang char(13) NOT NULL,
	MaKeHoach char(10) NOT NULL FOREIGN KEY REFERENCES KeHoachDieuTri(MaKeHoach),
	PRIMARY KEY(MaRang,MaMatRang,MaKeHoach),
	FOREIGN KEY(MaRang,MaMatRang)
	REFERENCES BeMatRang(MaRang,MaMatRang)
)


