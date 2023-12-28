WITH DL_BenhNhan (Ma_BN, Ho_ten, Ngay_sinh, Dia_chi)
AS (SELECT MaBenhNhan, HoTen, NgaySinh, DiaChi
	FROM HoSoBenhNhan)

SELECT YEAR(Ngay_sinh) year, COUNT(*) row_count
FROM DL_BenhNhan
GROUP BY YEAR(Ngay_sinh);

ALTER DATABASE QL_PK_NHAKHOA
ADD FILEGROUP BenhNhan_1950;

ALTER DATABASE QL_PK_NHAKHOA
ADD FILEGROUP BenhNhan_1975;

ALTER DATABASE QL_PK_NHAKHOA
ADD FILEGROUP BenhNhan_2000;

SELECT
  name
FROM sys.filegroups
WHERE type = 'FG';

ALTER DATABASE QL_PK_NHAKHOA    
ADD FILE     (
    NAME = BenhNhan_1950,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BenhNhan_1950.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP BenhNhan_1950;

ALTER DATABASE QL_PK_NHAKHOA    
ADD FILE     (
    NAME = BenhNhan_1975,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BenhNhan_1975.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP BenhNhan_1975;

ALTER DATABASE QL_PK_NHAKHOA    
ADD FILE     (
    NAME = BenhNhan_2000,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BenhNhan_2000.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP BenhNhan_2000;

CREATE PARTITION FUNCTION BenhNhan1_by_year_function (date)
AS RANGE LEFT 
FOR VALUES ('1950-12-31', '1975-12-31');

CREATE PARTITION SCHEME BenhNhan_by_year_scheme
AS PARTITION BenhNhan1_by_year_function
TO ([BenhNhan_1950], [BenhNhan_1975], [BenhNhan_2000])


-- Tạo bảng mới --
CREATE TABLE BenhNhan_report (
  mabenhnhan char(12),
  hoten nvarchar(35),
  ngaysinh date,
  diachi nvarchar(150),
  PRIMARY KEY (mabenhnhan, ngaysinh)
) 
ON BenhNhan_by_year_scheme (ngaysinh);

INSERT INTO BenhNhan_report (mabenhnhan, hoten, ngaysinh, diachi)
SELECT MaBenhNhan, HoTen, NgaySinh, DiaChi
	FROM HoSoBenhNhan

SELECT 
	p.partition_number AS partition_number,
	f.name AS file_group, 
	p.rows AS row_count
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'BenhNhan_report'
order by partition_number;


-- Dựa trên bảng có sẵn --
alter table HoSoBenhNhan
drop constraint PK__HoSoBenh__22A8B330A67543A8

alter table HoSoBenhNhan
add primary key
nonclustered (MaBenhNhan)
on [primary]

create clustered index ix_NgaySinh
on HoSoBenhNhan
(
	NgaySinh
) on BenhNhan_by_year_scheme(NgaySinh)

SELECT 
	p.partition_number AS partition_number,
	f.name AS file_group, 
	p.rows AS row_count
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'HoSoBenhNhan'
order by partition_number;


SET STATISTICS IO ON
SELECT *
FROM BenhNhan_report
WHERE ngaysinh = '1976-01-19'
SET STATISTICS IO OFF


SET STATISTICS IO ON
SELECT *
FROM [dbo].[HoSoBenhNhan]
WHERE [NgaySinh] = '1976-01-19'
SET STATISTICS IO OFF


SET STATISTICS IO ON
SELECT *
FROM BenhNhan_report
WHERE YEAR(ngaysinh) <= 1950
SET STATISTICS IO OFF

SET STATISTICS IO ON
SELECT *
FROM [dbo].[HoSoBenhNhan]
WHERE YEAR([NgaySinh]) < 1950
SET STATISTICS IO OFF