--6--
create table CuocHen 
(
      MaCuocHen char(12) PRIMARY KEY, 
	  MaNguoiTao char(6) FOREIGN KEY REFERENCES NguoiDung(MaNguoiDung),
	  MaBenhNhan char(12) FOREIGN KEY REFERENCES HoSoBenhNhan(MaBenhNhan),
	  ThoiGian DateTime NOT NULL ,
	  TinhTrang nvarchar(12) CHECK (TinhTrang IN (N'Tái khám', N'Cuộc hẹn mới'))
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

--9--
create table DonThuoc 
(
   MaThuoc char(12) FOREIGN KEY REFERENCES Thuoc(MaThuoc),
   MaBenhNhan char(12) FOREIGN KEY REFERENCES HoSoBenhNhan(MaBenhNhan),
   SoLuong int not null,
   TongTien float NOT NULL CHECK (TongTien >= 0),
   primary key (MaThuoc, MaBenhNhan)
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

create table NguoiDung
(
	MaNguoiDung char(6) primary key,
	HoTen nvarchar(35) not null,
	TaiKhoan varchar(12) unique not null,
	MatKhau varchar(30) not null,
	LoaiNguoiDung varchar(3)
)

create table QuanTriVien
(
	MaQuanTriVien char(6) primary key,
	constraint QuanTriVien 
		foreign key (MaQuanTriVien) 
		references NguoiDung (MaNguoiDung) 
)

create table NhanVien
(
	MaNhanVien char(6) primary key,
	constraint NhanVien 
		foreign key (MaNhanVien) 
		references NguoiDung (MaNguoiDung) 
)

create table NhaSi
(
	MaNhaSi char(6) primary key,
	constraint NhaSi
		foreign key (MaNhaSi) 
		references NguoiDung (MaNguoiDung) 
)

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
