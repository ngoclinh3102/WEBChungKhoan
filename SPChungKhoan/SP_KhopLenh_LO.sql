USE [CHUNGKHOAN]
GO
/****** Object:  StoredProcedure [dbo].[sp_KhopLenhLienTuc]    Script Date: 09/05/2022 06:00:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[sp_KhopLenhLienTuc]
	@InputMaCoPhieu NVARCHAR( 10), 
	@InputNgay NVARCHAR( 10),  
	@InputLoaiGiaoDich CHAR, 
	@InputSoLuong INT, 
	@InputGiaDat FLOAT 
AS
	SET DATEFORMAT DMY
	DECLARE @CursorVariable CURSOR ,
			@ID int, 
			@NgayDat NVARCHAR( 10), 
			@SoLuong INT, 
			@GiaDat FLOAT,  
			@soluongkhop INT, 
			@giakhop FLOAT,
			@flag INT = 0 -- kiểm tra lệnh đặt mới đã khớp lần nào chưa

	IF (@InputLoaiGiaoDich = 'B')
		EXEC sp_CursorLoaiGiaoDich  @CursorVariable OUTPUT, @InputMaCoPhieu, @InputNgay, 'M'
	ELSE -- (@InputLoaiGiaoDich = 'M')
		EXEC sp_CursorLoaiGiaoDich  @CursorVariable OUTPUT, @InputMaCoPhieu, @InputNgay, 'B'
  
	FETCH NEXT FROM @CursorVariable INTO @ID, @NgayDat, @SoLuong, @GiaDat 
	
	WHILE (@@FETCH_STATUS <> -1 AND @InputSoLuong > 0)
	BEGIN
		IF  (@InputLoaiGiaoDich = 'B') -- đang BÁN
		BEGIN
			IF  (@InputGiaDat <= @GiaDat) -- tìm MUA giá lớn hơn hoặc bằng,
			BEGIN
				IF (@InputSoLuong >= @SoLuong)
				BEGIN
					SET @soluongkhop = @SoLuong
					SET @giakhop = @GiaDat
					SET @InputSoLuong = @InputSoLuong - @SoLuong

					-- cập nhật dữ liệu tại record mà cursor đang đứng
					UPDATE dbo.LenhDat
					SET SoLuong = 0, TrangThaiLenh = N'Khớp Hết' WHERE CURRENT OF @CursorVariable
				END
				
				ELSE -- (@InputSoLuong < @SoLuong )
				BEGIN
					SET @soluongkhop = @InputSoLuong
					SET @giakhop = @GiaDat

					UPDATE dbo.LenhDat  
					SET SoLuong = SoLuong - @InputSoLuong, TrangThaiLenh = N'Khớp Lệnh Một Phần' WHERE CURRENT OF @CursorVariable
					
					SET @InputSoLuong = 0
				END
				
				-- cập nhật table LENHKHOP
				INSERT INTO dbo.LenhKhop(NgayKhop, SoLuongKhop, GiaKhop, idLenhDat)
					VALUES (GETDATE(), @soluongkhop, @giakhop, @ID)
				-- thiếu 1 lệnh insert nữa (khi MUA khớp BÁN hoặc ngược lại thì sẽ có 1 lệnh khớp của BÁN và 1 lệnh khớp của MUA)

				SET @flag = @flag + 1
			END
			
			ELSE -- giá Mua nhỏ hơn
			BEGIN
				GOTO THOAT
			END
		END
		
		ELSE --  đang MUA
		BEGIN
			IF(@InputGiaDat >= @GiaDat) -- tìm giá BÁN nhỏ hơn hoặc bằng
			BEGIN
				IF(@InputSoLuong >= @SoLuong)
				BEGIN
					SET @soluongkhop = @SoLuong
					SET @giakhop = @GiaDat
					SET @InputSoLuong = @InputSoLuong - @SoLuong

					UPDATE dbo.LenhDat
					SET SoLuong = 0,TrangThaiLenh = N'Khớp Hết' WHERE CURRENT OF @CursorVariable
				END
				
				ELSE -- (@InputSoLuong < @SoLuong)
				BEGIN
					SET @soluongkhop = @InputSoLuong
					SET @giakhop = @GiaDat

					UPDATE dbo.LenhDat
					SET SoLuong = SoLuong - @InputSoLuong, TrangThaiLenh = N'Khớp Lệnh Một Phần' WHERE CURRENT OF @CursorVariable
					
					SET @InputSoLuong = 0
				END
				
				-- Cập nhật table LENHKHOP
				INSERT INTO dbo.LenhKhop(NgayKhop, SoLuongKhop, GiaKhop, idLenhDat)
					VALUES (GETDATE(), @soluongkhop, @giakhop, @ID )
				-- thiếu 1 lệnh insert nữa (khi MUA khớp BÁN hoặc ngược lại thì sẽ có 1 lệnh khớp của BÁN và 1 lệnh khớp của MUA)
				

				SET @flag = @flag + 1

			END
			
			ELSE -- giá BÁN lớn hơn
			BEGIN
				GOTO THOAT
			END
		END
		
		FETCH NEXT FROM @CursorVariable INTO @ID,  @NgayDat, @SoLuong, @GiaDat -- đọc dòng kế tiếp
	END

THOAT:
	IF(@InputSoLuong > 0) -- còn cổ phiếu do không khớp hoặc khớp không hết
		IF(@flag = 0) -- không khớp
		BEGIN
			INSERT INTO dbo.LenhDat(MaCP, NgayDat, LoaiGD, LoaiLenh, SoLuong, GiaDat, TrangThaiLenh)
				VALUES(@InputMaCoPhieu, GETDATE(), @InputLoaiGiaoDich, N'LO', @InputSoLuong, @InputGiaDat, N'Chờ Khớp')
		END
		
		ELSE -- khớp không hết
		BEGIN
			INSERT INTO dbo.LenhDat(MaCP, NgayDat, LoaiGD, LoaiLenh, SoLuong, GiaDat, TrangThaiLenh)
				VALUES(@InputMaCoPhieu, GETDATE(), @InputLoaiGiaoDich, N'LO', @InputSoLuong, @InputGiaDat, N'Khớp Lệnh Một Phần')
		END
	
	ELSE -- khớp hết
	BEGIN
		INSERT INTO dbo.LenhDat(MaCP, NgayDat, LoaiGD, LoaiLenh, SoLuong, GiaDat, TrangThaiLenh)
			VALUES(@InputMaCoPhieu, GETDATE(), @InputLoaiGiaoDich, N'LO', @InputSoLuong, @InputGiaDat, N'Khớp Hết')
	END
		
	CLOSE @CursorVariable 
	DEALLOCATE @CursorVariable

 -- DELETE FROM LENHKHOP
 -- DELETE FROM LENHDAT