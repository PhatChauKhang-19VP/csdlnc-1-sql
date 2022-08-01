use pck_bus_travel
go

create table loai_tai_khoan_nhan_vien (
	ma_loai_tknv int primary key not null,
	ten_loai_tknv nvarchar(255) not null,
)
go 

create table nhan_vien(
	ma_nv varchar(255) primary key not null,
	ma_loai_tknv int not null,
	password varchar(255) not null,
	tao_ngay datetime default current_timestamp,
	active bit not null default 1,
	ten nvarchar(255) not null,
	ngay_sinh date not null,
	cccd char(20) not null,
	he_so_luong float not null,
	sdt char(10) not null,
	email nvarchar(255) not null,
	stk_nh char(50),
	ten_nh nvarchar(255),
	ten_cn_nh nvarchar(255),
	ma_dc int,
	
	constraint FK_ma_dc_nv_to_address foreign key (ma_dc) references addresses(code)
);
go

create table lich_su_lam_viec(
	ma_nv varchar(255) primary key not null,
	stt int not null,
	hanh_dong nvarchar(255) not null default(N''),
	tg_thuc_hien datetime default current_timestamp,

	constraint FK_ma_nv_lslv_to_nv foreign key (ma_nv) references nhan_vien(ma_nv)
);
go

create table tai_khoan_khach(
	username varchar(255) primary key,
	password varchar(255),
	tao_ngay datetime default current_timestamp,
	active bit not null default 1,
);
go

-- khach san
create table khach_san (
	ma_ks int primary key identity(1,1),
	sdt char(10) not null,
	ma_dia_chi int not null,
	foreign key (ma_dia_chi) references addresses(code)
);
go

create table loai_phong_khach_san (
	ma_loai_phong_ks int not null,
	ma_ks int not null,
	primary key (ma_ks, ma_loai_phong_ks),

	ten_loai_phong_ks nvarchar(255) not null,
	so_giuong int not null,
	check (so_giuong > 0),
	so_nguoi int not null,
	check (so_nguoi > 0),
	gia_thue float not null,
	check (gia_thue > 0)

);
go

-- tours
create table tours (
	ma_tour varchar(255) primary key,
	ten_tour nvarchar(255) not null,
	so_ngay int not null,
	check (so_ngay > 0),
	tao_ngay datetime default current_timestamp,
	gia_tien_dk float not null,
	check (gia_tien_dk > 0),
	tao_boi_nv varchar(255) not null,
	foreign key (tao_boi_nv) references nhan_vien(ma_nv),
);
go

create table lo_trinh (
	ma_tour varchar(255) not null,
	foreign key (ma_tour) references tours(ma_tour),

	stt int not null,
	noi_khoi_hanh varchar(20) not null,
	foreign key (noi_khoi_hanh) references provinces(code),
	noi_den varchar(20) not null,
	foreign key (noi_den) references provinces(code),
	tg_di_chuyen float not null,
	check (tg_di_chuyen > 0),
	ma_ks int not null,
	foreign key (ma_ks) references khach_san(ma_ks)
);
go

create table lich_trinh (
	ma_tour varchar(255) not null,
	foreign key (ma_tour) references tours(ma_tour),
	ngay_thu int not null,
	check (ngay_thu > 0),
	primary key (ma_tour, ngay_thu),
	tg_bat_dau time not null,
	tg_ket_thuc time not null,
	
	ma_dia_diem int not null,
	foreign key (ma_dia_diem) references addresses(code)
);
go

create table buses(
	bien_so_xe varchar(20) primary key,
	so_cho_ngoi int not null,
	mo_ta nvarchar(255)
);
go

create table tour_dang_ki (
	ma_tour varchar(255) not null,
	foreign key (ma_tour) references tours(ma_tour),

	mo_lan_thu int not null,
	primary key (ma_tour, mo_lan_thu),
	
	mo_dk_ngay datetime default current_timestamp,

	kt_dk_ngay datetime not null,

	mo_boi_nv varchar(255) not null,
	foreign key (mo_boi_nv) references nhan_vien(ma_nv),

	so_slot int not null,
	so_slot_con_lai int not null,

	ma_phuong_tien varchar(20) not null,
	foreign key (ma_phuong_tien) references buses(bien_so_xe),

	bat_dau datetime not null,
	ket_thuc datetime not null,
);
go

create table khach_hang_dang_ki (
	ma_tour varchar(255) not null,
	mo_lan_thu int not null,
	foreign key (ma_tour, mo_lan_thu) references tour_dang_ki(ma_tour, mo_lan_thu),
	ma_kh_dk varchar(255) not null,
	foreign key (ma_kh_dk) references tai_khoan_khach(username),
	stt int not null,
	primary key (ma_tour, mo_lan_thu, ma_kh_dk, stt),

	ten nvarchar(255) not null,
	ngay_sinh date not null,
	cccd char(20),
	sdt char(10),
	so_phong char(10),
);
go

create table dang_ki_phong(
	ma_tour varchar(255) not null,
	mo_lan_thu int not null,
	foreign key (ma_tour, mo_lan_thu) references tour_dang_ki(ma_tour, mo_lan_thu),
	ma_kh_dk varchar(255) not null,
	foreign key (ma_kh_dk) references tai_khoan_khach(username),
	stt int not null,
	primary key (ma_tour, mo_lan_thu, ma_kh_dk, stt),

	ma_ks int not null,
	ma_loai_phong_ks int not null,
	foreign key (ma_ks, ma_loai_phong_ks) references loai_phong_khach_san(ma_ks, ma_loai_phong_ks)
);
go