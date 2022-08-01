use pck_bus_travel
go

insert into loai_tai_khoan_nhan_vien values 
	(1, N'Quản lí'),
	(2, N'Nhân sự'),
	(3, N'Hướng dẫn viên'),
	(4, N'Tài xế')
go

insert into nhan_vien (ma_nv, ma_loai_tknv, password, active, ten, ngay_sinh, cccd, he_so_luong, sdt, email, stk_nh, ten_nh, ten_cn_nh) values
	('nv1', 1, '123', 1, N'Nhân viên 1', '06-01-2001', 'cccdnv1', 1.0, 'sdtnv1', 'emailnv1', 'stk_nh_nv1', 'ten nh nv1', 'ten cn nh nv 1'),
	('nv2', 1, '123', 1, N'Nhân viên 2', '06-01-2001', 'cccdnv2', 1.0, 'sdtnv2', 'emailnv2', 'stk_nh_nv2', 'ten nh nv2', 'ten cn nh nv 2'),
	('nv3', 2, '123', 1, N'Nhân viên 3', '06-01-2001', 'cccdnv3', 1.0, 'sdtnv3', 'emailnv3', 'stk_nh_nv3', 'ten nh nv3', 'ten cn nh nv 3'),
	('nv4', 2, '123', 1, N'Nhân viên 4', '06-01-2001', 'cccdnv4', 1.0, 'sdtnv4', 'emailnv4', 'stk_nh_nv4', 'ten nh nv4', 'ten cn nh nv 4'),
	('nv5', 3, '123', 1, N'Nhân viên 5', '06-01-2001', 'cccdnv5', 1.0, 'sdtnv5', 'emailnv5', 'stk_nh_nv5', 'ten nh nv5', 'ten cn nh nv 5'),
	('nv6', 4, '123', 1, N'Nhân viên 6', '06-01-2001', 'cccdnv6', 1.0, 'sdtnv6', 'emailnv6', 'stk_nh_nv6', 'ten nh nv6', 'ten cn nh nv 6')
go