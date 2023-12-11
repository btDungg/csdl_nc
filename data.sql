create table NguoiDung (
  MaNguoiDung char(6) primary key,
  HoTen nvarchar(35) not null,
  TaiKhoan varchar(12) unique not null,
  MatKhau varchar(30) not null,
  LoaiNguoiDung varchar(3)
)
