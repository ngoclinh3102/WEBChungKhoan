USE [master]
GO
/****** Object:  Database [CHUNGKHOAN]    Script Date: 09/05/2022 18:48:35 ******/
CREATE DATABASE [CHUNGKHOAN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CHUNGKHOAN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.NGOCLINH\MSSQL\DATA\CHUNGKHOAN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CHUNGKHOAN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.NGOCLINH\MSSQL\DATA\CHUNGKHOAN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CHUNGKHOAN] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CHUNGKHOAN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CHUNGKHOAN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET ARITHABORT OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CHUNGKHOAN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CHUNGKHOAN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CHUNGKHOAN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CHUNGKHOAN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET RECOVERY FULL 
GO
ALTER DATABASE [CHUNGKHOAN] SET  MULTI_USER 
GO
ALTER DATABASE [CHUNGKHOAN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CHUNGKHOAN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CHUNGKHOAN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CHUNGKHOAN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CHUNGKHOAN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CHUNGKHOAN] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CHUNGKHOAN', N'ON'
GO
ALTER DATABASE [CHUNGKHOAN] SET QUERY_STORE = OFF
GO
USE [CHUNGKHOAN]
GO
/****** Object:  Table [dbo].[BangGiaTrucTuyen]    Script Date: 09/05/2022 18:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BangGiaTrucTuyen](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaCP] [nvarchar](7) NULL,
	[GiaMua3] [float] NULL,
	[SLMua3] [int] NULL,
	[GiaMua2] [float] NULL,
	[SLMua2] [int] NULL,
	[GiaMua1] [float] NULL,
	[SLMua1] [int] NULL,
	[GiaKhop] [float] NULL,
	[SLKhop] [int] NULL,
	[GiaBan1] [float] NULL,
	[SLBan1] [int] NULL,
	[GiaBan2] [float] NULL,
	[SLBan2] [int] NULL,
	[GiaBan3] [float] NULL,
	[SLBan3] [int] NULL,
	[TongSo] [int] NULL,
 CONSTRAINT [PK__BangGiaT__3213E83F1E331F34] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LENHDAT]    Script Date: 09/05/2022 18:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LENHDAT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MACP] [nchar](7) NULL,
	[NGAYDAT] [datetime] NULL,
	[LOAIGD] [nchar](10) NULL,
	[LOAILENH] [nchar](10) NULL,
	[SOLUONG] [int] NULL,
	[GIADAT] [float] NULL,
	[TRANGTHAILENH] [nvarchar](30) NULL,
 CONSTRAINT [PK_LENHDAT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LENHKHOP]    Script Date: 09/05/2022 18:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LENHKHOP](
	[IDKHOP] [int] IDENTITY(1,1) NOT NULL,
	[NGAYKHOP] [datetime] NULL,
	[SOLUONGKHOP] [int] NULL,
	[GIAKHOP] [float] NULL,
	[IDLENHDAT] [int] NULL,
 CONSTRAINT [PK_LENHKHOP] PRIMARY KEY CLUSTERED 
(
	[IDKHOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LENHKHOP]  WITH CHECK ADD  CONSTRAINT [FK_LENHKHOP_LENHDAT] FOREIGN KEY([IDLENHDAT])
REFERENCES [dbo].[LENHDAT] ([ID])
GO
ALTER TABLE [dbo].[LENHKHOP] CHECK CONSTRAINT [FK_LENHKHOP_LENHDAT]
GO
/****** Object:  StoredProcedure [dbo].[sp_CursorLoaiGiaoDich]    Script Date: 09/05/2022 18:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Cú pháp
CREATE PROCEDURE [dbo].[sp_CursorLoaiGiaoDich]
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
GO
/****** Object:  StoredProcedure [dbo].[sp_KhopLenhLienTuc]    Script Date: 09/05/2022 18:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_KhopLenhLienTuc]
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
			@flag INT = 0

	IF (@InputLoaiGiaoDich = 'B')
		EXEC sp_CursorLoaiGiaoDich  @CursorVariable OUTPUT, @InputMaCoPhieu, @InputNgay, 'M'
	ELSE
		EXEC sp_CursorLoaiGiaoDich  @CursorVariable OUTPUT, @InputMaCoPhieu, @InputNgay, 'B'
  
	FETCH NEXT FROM @CursorVariable INTO @ID, @NgayDat, @SoLuong, @GiaDat 
	
	WHILE (@@FETCH_STATUS <> -1 AND @InputSoLuong > 0)
	BEGIN
		IF  (@InputLoaiGiaoDich = 'B')
		BEGIN
			IF  (@InputGiaDat <= @GiaDat)
			BEGIN
				IF (@InputSoLuong >= @SoLuong)
				BEGIN
					SET @soluongkhop = @SoLuong
					SET @giakhop = @GiaDat
					SET @InputSoLuong = @InputSoLuong - @SoLuong

					UPDATE dbo.LenhDat
					SET SoLuong = 0, TrangThaiLenh = N'Khớp Hết' WHERE CURRENT OF @CursorVariable
				END
				
				ELSE
				BEGIN
					SET @soluongkhop = @InputSoLuong
					SET @giakhop = @GiaDat

					UPDATE dbo.LenhDat  
					SET SoLuong = SoLuong - @InputSoLuong, TrangThaiLenh = N'Khớp Lệnh Một Phần' WHERE CURRENT OF @CursorVariable
					
					SET @InputSoLuong = 0
				END
				
				INSERT INTO dbo.LenhKhop(NgayKhop, SoLuongKhop, GiaKhop, idLenhDat)
					VALUES (GETDATE(), @soluongkhop, @giakhop, @ID)

				SET @flag = @flag + 1
			END
			
			ELSE
			BEGIN
				GOTO THOAT
			END
		END
		
		ELSE
		BEGIN
			IF(@InputGiaDat >= @GiaDat)
			BEGIN
				IF(@InputSoLuong >= @SoLuong)
				BEGIN
					SET @soluongkhop = @SoLuong
					SET @giakhop = @GiaDat
					SET @InputSoLuong = @InputSoLuong - @SoLuong

					UPDATE dbo.LenhDat
					SET SoLuong = 0,TrangThaiLenh = N'Khớp Hết' WHERE CURRENT OF @CursorVariable
				END
				
				ELSE
				BEGIN
					SET @soluongkhop = @InputSoLuong
					SET @giakhop = @GiaDat

					UPDATE dbo.LenhDat
					SET SoLuong = SoLuong - @InputSoLuong, TrangThaiLenh = N'Khớp Lệnh Một Phần' WHERE CURRENT OF @CursorVariable
					
					SET @InputSoLuong = 0
				END
				
				INSERT INTO dbo.LenhKhop(NgayKhop, SoLuongKhop, GiaKhop, idLenhDat)
					VALUES (GETDATE(), @soluongkhop, @giakhop, @ID )
				
				SET @flag = @flag + 1

			END
			
			ELSE
			BEGIN
				GOTO THOAT
			END
		END
		
		FETCH NEXT FROM @CursorVariable INTO @ID,  @NgayDat, @SoLuong, @GiaDat
	END

THOAT:
	IF(@InputSoLuong > 0)
		IF(@flag = 0)
		BEGIN
			INSERT INTO dbo.LenhDat(MaCP, NgayDat, LoaiGD, LoaiLenh, SoLuong, GiaDat, TrangThaiLenh)
				VALUES(@InputMaCoPhieu, GETDATE(), @InputLoaiGiaoDich, N'LO', @InputSoLuong, @InputGiaDat, N'Chờ Khớp')
		END
		
		ELSE
		BEGIN
			INSERT INTO dbo.LenhDat(MaCP, NgayDat, LoaiGD, LoaiLenh, SoLuong, GiaDat, TrangThaiLenh)
				VALUES(@InputMaCoPhieu, GETDATE(), @InputLoaiGiaoDich, N'LO', @InputSoLuong, @InputGiaDat, N'Khớp Lệnh Một Phần')
		END
	
	ELSE
	BEGIN
		INSERT INTO dbo.LenhDat(MaCP, NgayDat, LoaiGD, LoaiLenh, SoLuong, GiaDat, TrangThaiLenh)
			VALUES(@InputMaCoPhieu, GETDATE(), @InputLoaiGiaoDich, N'LO', @InputSoLuong, @InputGiaDat, N'Khớp Hết')
	END
		
	CLOSE @CursorVariable 
	DEALLOCATE @CursorVariable

 -- DELETE FROM LENHKHOP
 -- DELETE FROM LENHDAT
GO
/****** Object:  StoredProcedure [dbo].[sp_ReloadGridView]    Script Date: 09/05/2022 18:48:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_ReloadGridView]
AS
SELECT [ID], [MACP], [NGAYDAT], [LOAIGD], [LOAILENH], [SOLUONG], [GIADAT], [TRANGTHAILENH] FROM [LENHDAT]
ORDER BY ID DESC
GO
USE [master]
GO
ALTER DATABASE [CHUNGKHOAN] SET  READ_WRITE 
GO
