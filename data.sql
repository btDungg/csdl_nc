
create table CuocHen 
(
      MaCuocHen char(12),
	  MaNguoiTao char(6),
	  MaBenhNhan char(12),
	  ThoiGian DateTime NOT NULL ,
	  TinhTrang nvarchar(12) CONSTRAINT CK_TT CHECK (TinhTrang IN (N'Tái khám', N'Cuộc hẹn mới'))
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