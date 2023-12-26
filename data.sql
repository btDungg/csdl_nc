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
	TaiKhoan varchar(12) unique not null,
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
INSERT INTO NguoiDung (MaNguoiDung, HoTen, TaiKhoan, MatKhau, LoaiNguoiDung) VALUES
('980845', N'Cao Thanh Huy', 'christinamas', '@2OE9Yu+LC', 'QTV'),
('746127', N'Lê Thanh Linh', 'amy21', ')$7YobtIjT', 'NV'),
('578644', N'Đặng Thị Bảo', 'cruzjason', 'ubCm04Lru&', 'NS'),
('100079', N'Nguyễn Hồng Hằng', 'leahadams', 'MP^92Zct4B', 'NS'),
('952567', N'Hoàng Văn Trường', 'lisa80', ')9sNLh$x$d', 'NV'),
('426959', N'Trần Công Định', 'rdaniels', '%uTEAsBW$9', 'QTV'),
('356176', N'Hoàng Công Dũng', 'robinmiller', 'xq2W!A19r@', 'QTV'),
('327545', N'Hồ Hồng Thư', 'ogreen', 'D9TjfEdJ%4', 'NV'),
('812369', N'Đỗ Thị Định', 'davidbernard', '*&(9nQvvt+', 'NS'),
('480709', N'Bùi Công An', 'vbeck', '@@t5BQWqXx', 'NV'),
('698844', N'Cao Diễm Định', 'barry54', 'dPuKRVPc_4', 'NS'),
('116637', N'Trần Văn Khoa', 'tgrant', '5gJ5&hZu+9', 'NS'),
('387358', N'Trần Hải Huy', 'dawn69', ')kS0Qs^Da0', 'NS'),
('437812', N'Đỗ Thành Định', 'christinejon', 'T336*mGx+F', 'NV'),
('610971', N'Đào Thị Vy', 'ferrellteres', '0^4KZbnrKB', 'NV'),
('295576', N'Đào Thị Diễm', 'baldwinevan', 'E5!WioZ3_7', 'NV'),
('575395', N'Vũ Hải Anh', 'ashley82', 'LCO29SCi$6', 'QTV'),
('759892', N'Bùi Minh Thư', 'zachary35', 'p6Gk$xb4%3', 'NS'),
('352659', N'Huỳnh Thị Thu', 'cookeyvonne', 'ps*5ROaZ)$', 'NS'),
('414847', N'Bùi Văn Anh', 'tylerlee', 'g1GJfMD+%z', 'NV'),
('903178', N'Đỗ Vân Phương', 'lhoffman', '#9%exWyE(X', 'NV'),
('377219', N'Nguyễn Thị Linh', 'schaeferashl', 'Pm0L0O$^4*', 'NV'),
('53192', N'Đặng Minh Dũng', 'courtneyhigg', '&b2$QaH9OH', 'NV'),
('684509', N'Bùi Thị Diễm', 'pcameron', '+k#ke9QaT^', 'NS'),
('906600', N'Cao Diễm Thư', 'ulam', '(!DVsjSXh5', 'NS'),
('110406', N'Hồ Quốc Dũng', 'pachecojenni', 'j_^3EuCd*Q', 'QTV'),
('801651', N'Hoàng Thành Hằng', 'rodriguezjos', 'f#1BkD+ORm', 'NS'),
('122085', N'Bùi Vân Diễm', 'morgan59', '+IN2rmb+W6', 'NS'),
('249942', N'Lê Ngọc Huy', 'hectorwhite', 'FYR7%UgwR(', 'QTV'),
('413867', N'Vũ Ngọc Phương', 'dgarrett', '4U8hQmWl#R', 'NS'),
('981108', N'Võ Thị Vy', 'cliffordthom', 'gT#4WRkR#7', 'NV'),
('504116', N'Bùi Vân An', 'sknight', 'gnB1OhHt)z', 'QTV'),
('618035', N'Trần Thành Thư', 'hjones', '%(5UPZ0yM0', 'QTV'),
('394607', N'Đặng Thanh Trường', 'judy27', 'l#3H%Ab4pg', 'NS'),
('61024', N'Cao Thành Huy', 'xtyler', '+7zTAtrN&9', 'QTV'),
('488700', N'Huỳnh Thành Dũng', 'keithtorres', 'u%5X0kNa!u', 'NS'),
('667758', N'Lê Quốc Thu', 'ray52', 'h#70HOjdud', 'NS'),
('719840', N'Phạm Ngọc Định', 'xmcguire', '+U1MS*FbRw', 'NS'),
('998114', N'Đào Hải Dũng', 'michael92', 'pDt@v1Ya)+', 'NV'),
('858815', N'Hoàng Vân Khoa', 'walkerjustin', '+TR^1Np3hv', 'NS'),
('724788', N'Cao Quốc Linh', 'cfrancis', '5N%S3bt)*4', 'NS'),
('688205', N'Lê Đình Vy', 'steven81', '&5xSDc48Pt', 'QTV'),
('584096', N'Hoàng Diễm An', 'hoffmansteph', 'I9L^WjkV_R', 'NS'),
('165684', N'Vũ Văn Duyệt', 'normanterri', '_af5aRorT@', 'NS'),
('715269', N'Hoàng Thành Phương', 'hernandezsha', 'qN26p&dY4*', 'NV'),
('807836', N'Trần Đình Khoa', 'michelle76', '^1@u9Ftm17', 'NV'),
('730811', N'Huỳnh Vân Trường', 'urichard', 'kG55Tv)dQ&', 'QTV'),
('876436', N'Cao Công Bảo', 'jordanrick', 'qsn&3Go*f!', 'NV'),
('556234', N'Lê Minh Tuấn', 'nmacias', 'FI8)Oafk_E', 'QTV'),
('754675', N'Bùi Thị Định', 'ukim', 'm57Tol7UP$', 'QTV'),
('760833', N'Huỳnh Ngọc Thu', 'jason69', '%KBvbRD8v5', 'QTV'),
('298840', N'Cao Văn Tuấn', 'gary99', '3pKvpw6A&b', 'QTV'),
('30236', N'Huỳnh Vân Khoa', 'rita94', 'B435QNXC_n', 'NS'),
('283685', N'Hoàng Vân Thanh', 'martinkennet', '7QyltZzX((', 'QTV'),
('673562', N'Phạm Vân Hiếu', 'cameron49', '+^82XlVI$Z', 'NS'),
('166672', N'Đặng Hải Thu', 'connor27', 'Rx)s6LZl8)', 'NV'),
('561456', N'Bùi Thanh Phương', 'mcclurematth', 'K4*Vpy#p!d', 'QTV'),
('149168', N'Võ Vân Thư', 'andrewblack', 'CX!11K&tgD', 'NV'),
('268494', N'Võ Ngọc Thu', 'vferguson', 'K7lJC8Lx*X', 'NV'),
('75818', N'Huỳnh Đình Thu', 'jocelyn94', '&8HW^ErU(c', 'NV'),
('528970', N'Võ Hồng Vy', 'kreed', 'D_5_hGo1(E', 'QTV'),
('126363', N'Đỗ Công Dũng', 'jwright', 'n07XGBbz&4', 'NV'),
('540381', N'Phạm Công An', 'brian48', '*sQWEpQyE5', 'QTV'),
('300466', N'Phạm Hải Diễm', 'qbennett', 'JmgP3DWR)^', 'QTV'),
('332427', N'Võ Đình Phương', 'susanrodrigu', 'rv3ohcJr+0', 'NS'),
('196169', N'Võ Đình Linh', 'christianemi', 'iqILjojz*9', 'NV'),
('606576', N'Huỳnh Diễm An', 'ricardo76', 'p8#A5Ckv)$', 'NV'),
('41913', N'Vũ Hồng An', 'bowmaneric', '%F&N1AphZs', 'QTV'),
('312764', N'Đỗ Đình Định', 'ycurry', '14pnZ1Ok9*', 'QTV'),
('601446', N'Lê Hồng My', 'gleach', 'Pg#87Pbr2p', 'NS'),
('708769', N'Huỳnh Thị Vy', 'qbailey', '02Jh^ZZC$t', 'NV'),
('114647', N'Cao Thị Tú', 'ogarcia', '%aYMNXUn3h', 'QTV'),
('540026', N'Hoàng Văn An', 'davischristi', '7h^VkLMq(f', 'NS'),
('150436', N'Đỗ Thành Dũng', 'michellesmit', '(0QDWUEGor', 'NV'),
('279264', N'Đào Quốc Phương', 'anthony39', 'eGRZ^v67+6', 'NV'),
('698386', N'Huỳnh Ngọc Huy', 'murraymichae', ')sz*EIciL8', 'QTV'),
('224779', N'Phạm Văn Bảo', 'tstevens', '+y62Bkie&s', 'NV'),
('273823', N'Võ Đình Thanh', 'fchaney', 'cH1E%(nr+4', 'QTV'),
('200563', N'Đặng Công Định', 'tanya67', '649#Fi#3)C', 'NV'),
('358881', N'Hoàng Minh An', 'misty12', 'B#_0pHva3G', 'NS'),
('667069', N'Đào Hải Trường', 'robertberger', '@d$T0T6w3R', 'QTV'),
('179202', N'Lê Thị Bảo', 'winterswalte', 'v+OO0GfX*)', 'QTV'),
('90845', N'Hồ Thị Anh', 'robertsmith', '(8SFrOs)23', 'NS'),
('436060', N'Đặng Diễm Tuấn', 'ybaxter', 'J%37NveRvO', 'NS'),
('413408', N'Nguyễn Văn Bảo', 'nancyschaefe', '$4RE9d9BmO', 'NV'),
('958676', N'Huỳnh Vân An', 'bsmith', 'r%36l)ulzJ', 'QTV'),
('227809', N'Bùi Diễm Hằng', 'astone', '+_EizYf_6v', 'NV'),
('692244', N'Cao Hồng My', 'warnold', '&7I*QmjU&k', 'NS'),
('61180', N'Đỗ Thị Phương', 'henry31', 'l(P24OoZ^o', 'NS'),
('263300', N'Bùi Quốc Hiếu', 'seanpotter', 'o_8WYAyjJm', 'QTV'),
('63066', N'Đào Vân Linh', 'thill', '84*$tFP(_j', 'QTV'),
('746476', N'Đào Hải Linh', 'kimlee', '^8X85Dv*cf', 'QTV'),
('889298', N'Lê Ngọc Dũng', 'alanmcfarlan', 'qhqXoJ(@$2', 'NS'),
('725767', N'Bùi Công Linh', 'shawn12', 'b(M2LqtSlV', 'NV'),
('490334', N'Huỳnh Hồng Diễm', 'peterrodrigu', 'O&e2LYIn@C', 'QTV'),
('518336', N'Hoàng Minh Khoa', 'dustin62', '4N0JbBSI!!', 'NS'),
('556735', N'Trần Thị Khoa', 'stephanie91', 'PC1og3Bw!Z', 'NS'),
('918387', N'Lê Vân Linh', 'cgilbert', 'I9Fv%mSm+)', 'QTV'),
('39655', N'Đỗ Thành Linh', 'clarkwilliam', ')Q0&wSKdU2', 'NS'),
('678454', N'Hoàng Hồng Hằng', 'ycoleman', 'Rlu8MNkp$d', 'QTV');