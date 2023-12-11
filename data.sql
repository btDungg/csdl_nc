
create table CuocHen 
(
      MaCuocHen char(12),
	  MaNguoiTao char(6),
	  MaBenhNhan char(12),
	  ThoiGian DateTime NOT NULL ,
	  TinhTrang nvarchar(12) CONSTRAINT CK_TT CHECK (TinhTrang IN (N'Tái khám', N'Cuộc hẹn mới'))
)

CREATE TABLE PhanCongDieuTri
(
	MaNhaSi char(6) NOT NULL,
	MaKeHoach char(10) NOT NULL,
	VaiTro nvarchar(10),
	PRIMARY KEY(MaNhaSi,MaKeHoach)
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