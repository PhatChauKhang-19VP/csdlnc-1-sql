use pck_bus_travel
go

insert into buses values
	('16CN-16', 16, 'xe 16')

insert into khach_san values
	('sdt ks 1', 1),
	('sdt ks 2', 2)
go

select * from khach_san

insert into loai_phong_khach_san values
	(1, 1, N'Phòng đơn', 1, 2, 300),
	(2, 1, N'Phòng đôi', 2, 4, 500)
go

insert into tours (ma_tour, ten_tour, so_ngay, gia_tien_dk, tao_boi_nv) values
	('tour1', 'tour1', 1, 1000, 'nv1'),
	('tour2', 'tour2', 2, 2000, 'nv1'),
	('tour3', 'tour3', 4, 3000, 'nv1'),
	('tour4', 'tour4', 4, 4000, 'nv1')
go

insert into lo_trinh (ma_tour, stt, noi_khoi_hanh, noi_den, tg_di_chuyen, ma_ks) values
	('tour1', 1, '01', '02', 10 ,1)
go

insert into lich_trinh (ma_tour, ngay_thu, tg_bat_dau, tg_ket_thuc, ma_dia_diem) values
	('tour1', 1, '7:00', '8:00', 2),
	('tour1', 2, '7:00', '8:00', 2)
go

insert into tour_dang_ki (ma_tour, mo_lan_thu, mo_dk_ngay, kt_dk_ngay, mo_boi_nv, so_slot, so_slot_con_lai, ma_phuong_tien, bat_dau, ket_thuc) values
	('tour1', 1, GETDATE(), DATEADD(day, 10, GETDATE()), 'nv2', 20, 20, '16CN-16', '06-01-2022', '06-02-2022')
go



