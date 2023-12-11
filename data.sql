
create table CuocHen 
(
      MaCuocHen char(12),
	  MaNguoiTao char(6),
	  MaBenhNhan char(12),
	  ThoiGian DateTime,
	  TinhTrang nvarchar(12) CONSTRAINT CK_TT CHECK (TinhTrang IN (N'Tái khám', N'Cuộc hẹn mới'))
)

