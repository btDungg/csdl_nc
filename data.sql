
create table CuocHen 
(
      MaCuocHen char(12),
	  MaNguoiTao char(6),
	  MaBenhNhan char(12),
	  ThoiGian DateTime,
	  TinhTrang nvarchar(12) CONSTRAINT CK_TT CHECK (TinhTrang IN (N'Tái khám', N'Cuộc hẹn mới'))
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
