
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

create table PhongKham
(
     MaPhong char(4),
	 DiaChi nvarchar(50) NOT NULL

)