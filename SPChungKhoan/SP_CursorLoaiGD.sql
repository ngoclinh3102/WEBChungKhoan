USE [CHUNGKHOAN]
GO
/****** Object:  StoredProcedure [dbo].[sp_CursorLoaiGiaoDich]    Script Date: 09/05/2022 05:59:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Cú pháp
ALTER PROCEDURE [dbo].[sp_CursorLoaiGiaoDich]
	@OutputCursor CURSOR VARYING OUTPUT, 
	@MaCoPhieu NVARCHAR(10),
	@Ngay NVARCHAR(10),
	@LoaiGD CHAR 
AS
SET DATEFORMAT DMY 
IF (@LoaiGD = 'M') --  lệnh BÁN nên tìm MUA: ưu tiên giá MUA cao, ưu tiên ngày đặt MUA trước
BEGIN
	SET @OutputCursor = CURSOR KEYSET FOR 
	SELECT ID, NgayDat, SoLuong, GiaDat 
		FROM LenhDat 
		WHERE MaCP = @MaCoPhieu 
			AND DAY(NgayDat) = DAY(@Ngay)
			AND MONTH(NgayDat) = MONTH(@Ngay) 
			AND YEAR(NgayDat) = YEAR(@Ngay)  
			AND LoaiGD = @LoaiGD 
			AND SoLuong > 0  
		ORDER BY GiaDat DESC, NgayDat
END

ELSE --(@LoaiGiaoDich = 'B') -- lệnh MUA nên tìm BÁN: ưu tiên giá THẤP cao, ưu tiên ngày đặt BÁN trước
BEGIN
	SET @OutputCursor = CURSOR KEYSET FOR 
		SELECT ID, NgayDat, SoLuong, GiaDat 
		FROM LenhDat 
		WHERE MaCP=@MaCoPhieu 
			AND DAY(NgayDat) = DAY(@Ngay)
			AND MONTH(NgayDat) = MONTH(@Ngay) 
			AND YEAR(NgayDat) = YEAR(@Ngay)  
			AND LoaiGD = @LoaiGD 
			AND SoLuong > 0  
		ORDER BY GiaDat, NgayDat
END

OPEN @OutputCursor
