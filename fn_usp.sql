/*
json format:
@ds_kh_dk
[
{"stt": 1, "ten": "ho va ten kh", "sdt": "sdt kh", "cccd": "cccd kh", "ngay_sinh_kh": "DD-MM-YYYY"},
...
]
@ds_phong_dk
[
{"stt": 1, "loai_phong": "loai phong"},
...
]

*/
create proc usp_dk_tour
	@ma_tour varchar(255),
	@mo_lan_thu int,
	@ma_kh_dk varchar(255),
	@ds_kh_dk nvarchar(max),
	@ma_ks int,
	@ds_phong_dk nvarchar(max)
as
begin

begin try
    begin tran

	declare @get_ds_kh_dk cursor

	-- insert to khach_hang_dang_ki
	set @get_ds_kh_dk = cursor for (
			select * from openjson(@ds_kh_dk) with (
				stt int 'strict $.stt',
				ten nvarchar(255) '$.ten',
				sdt char(10) '$.sdt',
				cccd char(20) '$.cccd',
				ngay_sinh_kh date '$.ngay_sinh_kh'
			)
		)
	declare @stt_ds_kh_dk int
	declare @ten nvarchar(255)
	declare @sdt char(10)
	declare @cccd varchar(20)
	declare @ngay_sinh_kh date
	open @get_ds_kh_dk
	fetch next from @get_ds_kh_dk into @stt_ds_kh_dk, @ten, @sdt, @cccd, @ngay_sinh_kh
	while @@FETCH_STATUS = 0
	begin
		insert into khach_hang_dang_ki 
			(ma_tour, mo_lan_thu, ma_kh_dk, stt, ten, ngay_sinh, cccd, sdt) values 
			(@ma_tour, @mo_lan_thu, @ma_kh_dk, @stt_ds_kh_dk, @ten, @ngay_sinh_kh, @cccd, @sdt)

		fetch next from @get_ds_kh_dk into @stt_ds_kh_dk, @ten, @sdt, @cccd, @ngay_sinh_kh
	end

	close @get_ds_kh_dk
	deallocate @get_ds_kh_dk


	-- insert into dang_ki_phong
	declare @get_ds_phong cursor

	-- insert to khach_hang_dang_ki
	set @get_ds_phong = cursor for (
			select * from openjson(@ds_phong_dk) with (
				stt int 'strict $.stt',
				loai_phong int '$.loai_phong'
			)
		)
	declare @stt_dk_phong int
	declare @loai_phong int

	open @get_ds_phong
	fetch next from @get_ds_phong into @stt_dk_phong, @loai_phong
	while @@FETCH_STATUS = 0
	begin
		insert into dang_ki_phong 
			(ma_tour, mo_lan_thu, ma_kh_dk, stt, ma_ks, ma_loai_phong_ks) values 
			(@ma_tour, @mo_lan_thu, @ma_kh_dk, @stt_dk_phong, @ma_ks, @loai_phong)

		fetch next from @get_ds_phong into @stt_ds_kh_dk, @ten, @sdt, @cccd, @ngay_sinh_kh
	end

	close @get_ds_phong
	deallocate @get_ds_phong

    commit tran -- Transaction Success!
end try
begin catch
    if @@trancount > 0
        rollback tran --RollBack in case of Error

		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()

		print @ErrorMessage
end catch
end
go

-- TEST usp_dk_tour
	--@ma_tour varchar(255),
	--@mo_lan_thu int,
	--@ma_kh_dk varchar(255),
	--@ds_kh_dk nvarchar(max),
	--@ma_ks int,
	--@ds_phong_dk nvarchar(max)
exec dbo.usp_dk_tour 
	@ma_tour = 'tour1', 
	@mo_lan_thu = 1, 
	@ma_kh_dk = 'kh1', 
	@ds_kh_dk = N'[{"stt": 1, "ten": "ho va ten kh 1", "sdt": "sdt kh", "cccd": "cccd kh", "ngay_sinh_kh": "06-01-2001"},{"stt": 2, "ten": "ho va ten kh 2", "sdt": "sdt kh", "cccd": "cccd kh", "ngay_sinh_kh": "06-01-2001"}]',
	@ma_ks = 1,
	@ds_phong_dk =N'[{"stt": 1, "loai phong": 1},{"stt": 2, "loai_phong": 1}]'

select * from khach_hang_dang_ki
--delete khach_hang_dang_ki