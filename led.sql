USE [master]
GO
/****** Object:  Database [QuaTang]    Script Date: 9/28/2019 12:13:36 AM ******/
CREATE DATABASE [QuaTang]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuaTang', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QuaTang.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuaTang_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QuaTang_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuaTang] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuaTang].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuaTang] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuaTang] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuaTang] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuaTang] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuaTang] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuaTang] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuaTang] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuaTang] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuaTang] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuaTang] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuaTang] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuaTang] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuaTang] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuaTang] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuaTang] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuaTang] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuaTang] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuaTang] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuaTang] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuaTang] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuaTang] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuaTang] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuaTang] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuaTang] SET  MULTI_USER 
GO
ALTER DATABASE [QuaTang] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuaTang] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuaTang] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuaTang] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuaTang] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QuaTang]
GO
/****** Object:  UserDefinedFunction [dbo].[Fn_UnsignCharacter]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE FUNCTION [dbo].[Fn_UnsignCharacter](@inputVar NVARCHAR(MAX) )
RETURNS NVARCHAR(MAX)
AS
BEGIN    
    IF (@inputVar IS NULL OR @inputVar = '')  RETURN ''
   
    DECLARE @RT NVARCHAR(MAX)
    DECLARE @SIGN_CHARS NCHAR(256)
    DECLARE @UNSIGN_CHARS NCHAR (256)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
   
    SET @COUNTER = 1
    WHILE (@COUNTER <= LEN(@inputVar))
    BEGIN  
        SET @COUNTER1 = 1
        WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
        BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@inputVar,@COUNTER ,1))
            BEGIN          
                IF @COUNTER = 1
                    SET @inputVar = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)-1)      
                ELSE
                    SET @inputVar = SUBSTRING(@inputVar, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)- @COUNTER)
                BREAK
            END
            SET @COUNTER1 = @COUNTER1 +1
        END
        SET @COUNTER = @COUNTER +1
    END
    -- SET @inputVar = replace(@inputVar,' ','-')
    RETURN @inputVar
END





















GO
/****** Object:  Table [dbo].[About]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[About](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MetaTitle] [varchar](255) NULL,
	[Contents] [nvarchar](max) NULL,
	[Createddate] [datetime] NULL,
	[Tags] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbl_About_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdminMenu]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdminMenu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[ParentID] [int] NOT NULL,
	[Url] [varchar](250) NOT NULL,
	[Ordering] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Icon] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[LangCode] [varchar](5) NULL,
 CONSTRAINT [PK_AdminMenu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdvImag]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdvImag](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Image] [varchar](255) NULL,
	[Link] [varchar](255) NULL,
	[Position] [int] NOT NULL,
	[Type] [int] NULL,
	[TagetBlank] [bit] NULL,
	[DisplayOrder] [int] NULL,
	[Status] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AdvImag] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Contents] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Footer]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Footer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Contents] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Footer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HomeMenu]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HomeMenu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Link] [nvarchar](255) NULL,
	[LinkSeo] [varchar](255) NULL,
	[Icon] [nvarchar](255) NULL,
	[ParentId] [int] NOT NULL CONSTRAINT [DF_tbl_HomeMenu_ParentId]  DEFAULT ((0)),
	[Level] [int] NULL,
	[Ordering] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Product] [bit] NULL,
 CONSTRAINT [PK_tbl_HomeMenu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Instruction]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instruction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Contents] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Instruction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Logo]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Logo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Image] [varchar](150) NOT NULL,
	[Type] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Logo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[News]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[News](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MetaTitle] [nvarchar](255) NOT NULL,
	[Image] [varchar](255) NULL,
	[Desciption] [nvarchar](500) NOT NULL,
	[CreatedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[Contents] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Status] [int] NULL,
	[Tags] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbl_News] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[ProductID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Partner]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Partner](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Image] [varchar](250) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[DisplayOrder] [int] NOT NULL,
 CONSTRAINT [PK_Partner] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[Name] [nvarchar](255) NOT NULL,
	[ProductCode] [varchar](50) NULL,
	[Images] [nvarchar](255) NOT NULL,
	[ImageMore] [xml] NULL,
	[Price] [float] NULL,
	[Sale] [float] NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Slide]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slide](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Image] [nvarchar](250) NOT NULL,
	[DisplayOrder] [int] NULL CONSTRAINT [DF_Slide_DisplayOrder]  DEFAULT ((1)),
	[Link] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Slide] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_GroupUser]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_GroupUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[ExpandNews] [bit] NOT NULL,
	[Status] [bit] NOT NULL,
	[Permission] [varchar](max) NULL,
	[PermissionCatNews] [varchar](max) NULL,
 CONSTRAINT [PK_tbl_GroupUser] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Order]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](100) NULL,
	[CustomerAddress] [nvarchar](250) NULL,
	[CustomerPhone] [varchar](20) NULL,
	[CustomerEmail] [varchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_tbl_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](250) NOT NULL,
	[Email] [varchar](250) NULL,
	[FullName] [nvarchar](250) NULL,
	[Gender] [bit] NOT NULL,
	[Birthday] [datetime] NULL,
	[Photo] [nvarchar](max) NULL,
	[Address] [nvarchar](500) NULL,
	[City] [nvarchar](250) NULL,
	[District] [nvarchar](250) NULL,
	[Country] [nvarchar](150) NULL,
	[zip] [int] NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Password] [nvarchar](500) NOT NULL,
	[PasswordQuestion] [nvarchar](500) NULL,
	[PasswordAnswer] [nvarchar](500) NULL,
	[Telephone] [varchar](20) NULL,
	[Phone] [varchar](20) NULL,
	[DonviId] [int] NOT NULL,
	[ChucVuId] [int] NOT NULL,
	[UserType] [int] NOT NULL,
	[TimeLogin] [datetime] NULL,
	[IPLogin] [nvarchar](500) NULL,
	[GroupUserID] [nvarchar](50) NULL,
	[NoiBo] [tinyint] NULL,
	[PageNoiBo] [nvarchar](250) NULL,
	[isAdmin] [bit] NOT NULL CONSTRAINT [DF_tbl_User_isAdmin]  DEFAULT ((0)),
	[IsBanChapHanh] [bit] NOT NULL,
	[IsShow] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserAdmin]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserAdmin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](250) NOT NULL,
	[Email] [varchar](250) NOT NULL,
	[FullName] [nvarchar](250) NULL,
	[Gender] [tinyint] NULL,
	[Photo] [nvarchar](max) NULL,
	[Address] [nvarchar](500) NULL,
	[City] [nvarchar](250) NULL,
	[District] [nvarchar](250) NULL,
	[Country] [nvarchar](150) NULL,
	[zip] [int] NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Password] [nvarchar](500) NOT NULL,
	[PasswordQuestion] [nvarchar](500) NULL,
	[PasswordAnswer] [nvarchar](500) NULL,
	[Phone] [varchar](20) NULL,
	[UserType] [int] NOT NULL,
	[TimeLogin] [datetime] NULL,
	[IPLogin] [nvarchar](500) NULL,
	[GroupUserID] [nvarchar](250) NULL,
	[PageElementID] [varchar](250) NULL,
	[QuyTrinhXuatBanID] [varchar](250) NULL,
	[isAdmin] [bit] NOT NULL CONSTRAINT [DF_tbl_UserAdmin_isAdmin]  DEFAULT ((0)),
 CONSTRAINT [PK_tbl_UserAdmin] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[About] ON 

INSERT [dbo].[About] ([ID], [MetaTitle], [Contents], [Createddate], [Tags]) VALUES (3, NULL, N'<p>fgsdfgsdfg</p>
', CAST(N'2019-05-16 11:08:29.747' AS DateTime), NULL)
INSERT [dbo].[About] ([ID], [MetaTitle], [Contents], [Createddate], [Tags]) VALUES (4, NULL, N'<p>fgsdfgsdfg</p>
', CAST(N'2019-05-16 11:08:36.060' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[About] OFF
SET IDENTITY_INSERT [dbo].[AdminMenu] ON 

INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (1013, N'HỆ THỐNG', 0, N'#', 4, 1, N'fa fa-cogs', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (1014, N'Menu admin', 1013, N'/Admin/AdminMenu', 1, 1, N'fa fa-bars', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (1015, N'NGƯỜI DÙNG', 0, N'#', 10, 1, N'md md-person', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (1016, N'MenuHome', 1013, N'/Admin/HomeMenu', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (3022, N'Danh sách', 1015, N'/Admin/Account', 0, 1, N'md md-person', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (3023, N'Nhóm người dùng', 1015, N'/Admin/GroupUser', 0, 1, N'fa fa-users', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (3026, N'Video,hình ảnh', 0, N'/Admin/Slide ', 6, 1, N'md md-photo-library', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (3033, N'Cơ quan ban hành', 3032, N'/CoQuanBanHanh', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (3034, N'Lĩnh vực văn bản', 3032, N'/LinhVucVanBan', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (3035, N'Loại văn bản', 3032, N'/LoaiVanBan', 3, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (3036, N'Danh sách văn bản', 3032, N'/VanBan', 0, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (4050, N'Danh sách TTHC', 4049, N'/TTHC', 0, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (4051, N'Đơn vị thực hiện TTHC', 4049, N'/DonViTTHC', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (4052, N'Lĩnh vực TTHC', 4049, N'/LinhVucTTHC', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (4056, N'Hỏi đáp', 3042, N'/qa', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (4058, N'Lưu ý', 3042, N'/ConfigNote', 7, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (4059, N'Xin ý kiến đóng góp', 3042, N'/NewsPaper', 3, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (4060, N'Tố giác tội phạm', 3042, N'/ToGiacBE', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5062, N'Bình luận TTHC', 4049, N'/TTHC/Comment', 4, 0, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5063, N'Lĩnh vực', 3042, N'/QALinhVuc', 4, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5065, N'Danh sách', 5064, N'/Admin/VanBan', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5066, N'Loại văn bản', 5064, N'/Admin/LoaiVanBan', 3, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5069, N'CĐ cơ sở trực thuộc', 5084, N'/Admin/DMChung?code=tructhuoc', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5072, N'CĐ Y tế Tỉnh thành', 5084, N'/Admin/DMChung?code=tinhthanh', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5073, N'Nhóm đơn vị', 5084, N'/Admin/DMNhom', 3, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5075, N'Danh sách', 5074, N'/Admin/tailieu', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5076, N'Thư mục tài liệu', 5074, N'/Admin/danhmuctailieu', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5079, N'Danh sách', 5078, N'/Admin/Contact', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5080, N'Bản đồ', 5078, N'/Admin/ContactInfo', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (5083, N'Danh sách', 5077, N'/Admin/thanhvien', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6091, N'Lĩnh vực', 5091, N'/Admin/QALinhVuc', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6092, N'Lưu ý', 5091, N'/Admin/ConfigNote', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6095, N'Lưu ý', 5091, N'/Admin/ConfigNote', 3, 1, NULL, NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6097, N'Giới thiệu', 1013, N'/Admin/About', 3, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6099, N'Hướng dẫn mua hàng', 1013, N'/Admin/Instruction', 4, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6100, N'Footer', 0, N'/Admin/footer', 5, 1, N'fa fa-paw', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6102, N'Địa chỉ shop', 6100, N'/Admin/footer/add', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6103, N'Đầu trang', 1013, N'/Admin/header/add', 5, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6104, N'Sản phẩm', 0, N'/Admin/product', 2, 1, N'fa fa-gift', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6106, N'Tin tức', 0, N'/admin/news', 3, 1, N'fa fa-newspaper-o', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6107, N'Bài viết chưa đăng', 6106, N'/admin/news?status=1', 1, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6108, N'Bài viết đã đăng', 6106, N'/admin/news?status=2', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6109, N'Bài viết đã hủy', 6106, N'/admin/news?status=3', 3, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6110, N'Slide', 3026, N'/Admin/Slide ', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6111, N'Ảnh quảng cáo', 3026, N'/Admin/AdvImage', 2, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6113, N'Đơn hàng', 0, N'/Admin/Order', -1, 1, N'fa fa-truck', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6114, N'Logo', 3026, N'/Admin/Logo', 4, 1, N'md md-view-list', NULL, NULL)
INSERT [dbo].[AdminMenu] ([ID], [Name], [ParentID], [Url], [Ordering], [Active], [Icon], [CreatedDate], [LangCode]) VALUES (6115, N'Địa chỉ liên hệ', 1013, N'/Admin/Contact/Add', 5, 1, N'md md-view-list', NULL, NULL)
SET IDENTITY_INSERT [dbo].[AdminMenu] OFF
SET IDENTITY_INSERT [dbo].[AdvImag] ON 

INSERT [dbo].[AdvImag] ([ID], [Title], [Image], [Link], [Position], [Type], [TagetBlank], [DisplayOrder], [Status], [CreatedDate]) VALUES (8, NULL, N'/Upload/Images/Tulips.jpg', NULL, 1, 1, 1, 1, 1, CAST(N'2019-04-22 18:43:52.270' AS DateTime))
INSERT [dbo].[AdvImag] ([ID], [Title], [Image], [Link], [Position], [Type], [TagetBlank], [DisplayOrder], [Status], [CreatedDate]) VALUES (10, N'Ảnh cuối trang', N'/Upload/Images/traitimdo.jpg', NULL, 4, 1, 1, 1, 1, CAST(N'2019-04-26 21:33:18.607' AS DateTime))
SET IDENTITY_INSERT [dbo].[AdvImag] OFF
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([ID], [Contents]) VALUES (1, N'[{"Key":"Contact","Value":"<div class=\"col-inner\">\n                        <div class=\"row\" id=\"row-474886118\">\n                            <div class=\"col medium-6 small-12 large-6\">\n                                <div class=\"col-inner\">\n                                    <div class=\"container section-title-container\" style=\"margin-bottom:0px;\">\n                                        <h3 class=\"section-title section-title-normal\"><b></b><span class=\"section-title-main\">gấu sài gòn</span><b></b></h3>\n                                    </div>\n                                    <p>ĐC: 520/44/10A Quốc lộ 13, P. Hiệp Bình Phước, Q. Thủ Đức, HCM</p>\n                                    <p>Hotline: 0981.663.276 &#8211; 0908.038.577</p>\n                                    <p>Email: lyly@gausaigon.com</p>\n                                </div>\n                            </div>\n                            <div class=\"col medium-6 small-12 large-6\">\n                                <div class=\"col-inner\"></div>\n                            </div>\n                        </div>\n                        <div class=\"row\" id=\"row-2146028422\">\n                            <div class=\"col small-12 large-12\">\n                                <div class=\"col-inner\">\n                                    <p>\n                                        <iframe onload=\"Wpfcll.r(this,true);\" data-wpfc-original-src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.558008431345!2d106.71838031418308!3d10.84509726088942!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752877aa903c7d%3A0x6c3ade16d3522783!2zQ8O0bmcgVHkgVE5ISCBHaeG6o2kgUGjDoXAgTWluaCBIaeG7g24!5e0!3m2!1svi!2s!4v1516515699668\" width=\"100%\" height=\"450\" frameborder=\"0\" style=\"border:0\" allowfullscreen></iframe>\n                                    </p>\n                                </div>\n                            </div>\n                        </div>\n                    </div>"}]')
SET IDENTITY_INSERT [dbo].[Contact] OFF
SET IDENTITY_INSERT [dbo].[Footer] ON 

INSERT [dbo].[Footer] ([ID], [Contents]) VALUES (1, N'[{"Key":"Address","Value":"          <p>Địa chỉ: Số 1 Hoàng Đạo Thúy,Thanh Xuân, Hà Nội</p>\n          <p>Điện thoại: 0987 569 301- Hotline: 0919 333 444</p>\n          <p>Email: thangknt99@gmail.com</p>\n          <p>Facebook: facebook.com/thang.nguyenhuu123</p>"},{"Key":"AddressMap","Value":"<p>\n          <iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d932.8898920243491!2d105.78996632971013!3d20.728102057086463!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135cb28dc454eb7%3A0xac224445be54d9db!2zVGjhuq9uZw!5e0!3m2!1svi!2s!4v1559093726388!5m2!1svi!2s\" width=\"300\" height=\"200\" frameborder=\"0\" style=\"border:0\" allowfullscreen></iframe>\n          </p>"}]')
SET IDENTITY_INSERT [dbo].[Footer] OFF
SET IDENTITY_INSERT [dbo].[HomeMenu] ON 

INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (4, N'Trang chủ', N'/trang-chu', NULL, NULL, 0, 1, 1, CAST(N'2019-04-11 08:55:47.043' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (5, N'Gấu bông teddy', N'/gau-bong-teddy', NULL, NULL, 0, 1, 2, CAST(N'2019-04-11 09:03:22.340' AS DateTime), 1)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (6, N'Gối ôm', N'/goi-om', NULL, NULL, 0, 1, 3, CAST(N'2019-04-11 09:03:59.460' AS DateTime), 1)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (7, N'Thú bông hoạt hình', N'/thu-bong-hoat-hinh', NULL, NULL, 0, 1, 4, CAST(N'2019-04-11 09:04:31.397' AS DateTime), 1)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (9, N'Tin tức tổng hợp', N'/tin-tuc', NULL, NULL, 0, 1, 5, CAST(N'2019-04-11 09:07:05.133' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (10, N'Liên hệ', N'/lien-he', NULL, NULL, 0, 1, 6, CAST(N'2019-04-12 06:46:55.527' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (16, N'Gấu bông Pikachu', NULL, N'gau-bong-pikachu', NULL, 7, 2, 3, CAST(N'2019-09-13 08:48:06.413' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (17, N'Gấu bông Totoro', NULL, N'gau-bong-totoro', NULL, 7, 2, 4, CAST(N'2019-09-13 08:48:16.120' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (18, N'Gấu brown', NULL, N'gau-brown', NULL, 7, 2, 5, CAST(N'2019-09-13 08:48:27.500' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (19, N'Heo bông', NULL, N'heo-bong', NULL, 7, 2, 6, CAST(N'2019-09-13 08:48:46.603' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (20, N'Gấu bông Doremon', NULL, N'gau-bong-doremon', NULL, 7, 2, 1, CAST(N'2019-09-16 11:54:38.597' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (21, N'Gối ôm cổ chữ U', NULL, N'goi-om-co-chu-u', NULL, 6, 2, 1, CAST(N'2019-09-16 14:25:09.277' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (23, N'	Gấu bông Hello Kitty', NULL, N'	gau-bong-hello-kitty', NULL, 7, 2, 2, CAST(N'2019-09-16 14:25:46.980' AS DateTime), NULL)
INSERT [dbo].[HomeMenu] ([ID], [Name], [Link], [LinkSeo], [Icon], [ParentId], [Level], [Ordering], [CreatedDate], [Product]) VALUES (24, N'Gối tựa lưng', NULL, N'goi-tua-lung', NULL, 6, 2, 2, CAST(N'2019-09-16 14:26:52.210' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[HomeMenu] OFF
SET IDENTITY_INSERT [dbo].[Instruction] ON 

INSERT [dbo].[Instruction] ([ID], [Title], [Description], [Contents], [CreatedDate]) VALUES (1, N'Các bước mua hàng trên shop ledquatang', N'Bài viết hướng dẫn mua hàng', N'<p>C&aacute;c bạn chọn mua sản phẩm thế l&agrave; xong</p>
', CAST(N'2019-04-19 23:49:57.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Instruction] OFF
SET IDENTITY_INSERT [dbo].[Logo] ON 

INSERT [dbo].[Logo] ([ID], [Name], [Image], [Type], [Status]) VALUES (3, N'Trái tim', N'/Upload/Images/logoled.jpg', 1, 1)
INSERT [dbo].[Logo] ([ID], [Name], [Image], [Type], [Status]) VALUES (9, N'Cuối trang', N'/Upload/Images/logomini.png', 2, 1)
SET IDENTITY_INSERT [dbo].[Logo] OFF
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([ID], [MetaTitle], [Image], [Desciption], [CreatedBy], [ModifiedDate], [ModifiedBy], [Contents], [CreatedDate], [Status], [Tags]) VALUES (2, N'Vườn hoa', N'/Upload/Images/Tulips.jpg', N'Yêu thiên nhiên cũng là cái tội.Yêu hoa là một sở thích của đa số người', 1055, CAST(N'2019-04-21 23:02:44.910' AS DateTime), NULL, N'<p>&nbsp; &nbsp; &nbsp;&Ocirc;ng Giới rất th&iacute;ch ngắm hoa&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;<img alt="" src="/Upload/images/a3.jpg" style="width: 600px; height: 450px;" /><img alt="" src="/Upload/images/Hydrangeas.jpg" style="width: 600px; height: 450px;" /></p>

<p style="font-style: italic;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="color:#3498db;">Vườn hoa nh&agrave; &ocirc;ng Giới</span></p>
', CAST(N'2019-04-21 10:44:53.540' AS DateTime), 3, NULL)
INSERT [dbo].[News] ([ID], [MetaTitle], [Image], [Desciption], [CreatedBy], [ModifiedDate], [ModifiedBy], [Contents], [CreatedDate], [Status], [Tags]) VALUES (3, N'Có thầy Hàn, Văn Lâm và đồng đội vẫn thua', N'/Upload/Images/co-thay-han-2_ztaj.jpg', N'(PLO)-Tối 20-4, thủ môn Đặng Văn Lâm hai lần vào lưới nhặt bóng và la hét đồng đội, còn thuyền trưởng người Hàn chuốc thất bại đầu. Muangthong rơi xuống đáy bảng xếp hạng...', 1055, CAST(N'2019-05-04 15:10:57.953' AS DateTime), NULL, N'<p><strong>&nbsp; &nbsp;(PLO)-Tối 20-4, thủ m&ocirc;n Đặng Văn L&acirc;m hai lần v&agrave;o lưới nhặt b&oacute;ng v&agrave; la h&eacute;t đồng đội, c&ograve;n thuyền trưởng người H&agrave;n chuốc thất bại đầu. Muangthong rơi xuống đ&aacute;y bảng xếp hạng...</strong></p>

<p>Tối 20-4, tr&ecirc;n s&acirc;n nh&agrave; SCG, Muangthong, đội &aacute;p ch&oacute;t tiếp đội đầu bảng Thai Port v&agrave; lại trắng tay 1-2, thầy H&agrave;n Yoon Jong-hwan nhấm nh&aacute;p thất bại đầu ti&ecirc;n khi ngồi ghế thuyền trưởng.</p>

<p>D&ugrave; chơi s&acirc;n nh&agrave;, nhưng &ldquo;&ocirc;ng lớn&rdquo; Muanthong đang như kẻ&hellip;v&ocirc; hại v&agrave; ai cũng c&oacute; thể lấy điểm được.</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img alt="" src="/Upload/images/co-thay-han-2_ztaj.jpg" style="width: 660px; height: 401px;" /></p>

<p><em>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Văn L&acirc;m đang rất vất vả ở Muangthong</em></p>

<p>Một h&agrave;ng ph&ograve;ng ngự Muangthong chơi rất hời hợt, d&acirc;ng cao v&agrave; r&uacute;t về kh&ocirc;ng kịp trong khi đ&oacute; Thai Port đang c&oacute; phong độ cực cao.</p>

<p>Dự l&agrave; một trận đấu cực căng, cực th&aacute;ch thức&nbsp; cho t&acirc;n thuyền trưởng Yoo Jong-hwan, bởi đối thủ th&igrave; cực mạnh, c&ograve;n Muangthong th&igrave; như đang ốm yếu.</p>

<p>Tuy nhi&ecirc;n khi tiếng c&ograve;i khai cuộc vang l&ecirc;n th&igrave; Muangthong mới ch&iacute;nh l&agrave; đội tạo ra cơ hội nhiều trong đ&oacute; c&oacute; ba chuyền b&oacute;ng cực kỳ đẹp mắt, thể hiện sự từng trải của Dangda cho đồng đội loại ba hậu vệ Thai Port, nhưng đồng đội của Dangda đối mặt với thủ m&ocirc;n trong thế dễ ăn b&agrave;n nhưng c&uacute; ra ch&acirc;n đệm b&oacute;ng&hellip;.vọt x&agrave;. Trước đ&oacute; ngoại binh Herberty cũng bỏ lỡ cơ hội ăn b&agrave;n mười mươi.</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img alt="" src="/Upload/images/co-thay-han-3_eeco.jpg" style="width: 665px; height: 479px;" /></p>

<p><em>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Ng&agrave;y ngồi ghế l&aacute;i Muangthong, thầy H&agrave;n Yoon Jong-hwan thua trận đầu</em></p>

<p>Hiệp một kết th&uacute;c m&agrave; c&oacute; thể Muangthong tiếc nuối với c&aacute;c cơ hội kh&ocirc;ng biến được th&agrave;nh b&agrave;n thắng.</p>

<p>Sang hiệp 2, ngay ph&uacute;t 50 v&agrave; 57 th&igrave;&nbsp;<a href="https://plo.vn/tags/VsSDbiBMw6Jt/van-lam.html">Văn L&acirc;m</a>&nbsp;li&ecirc;n tiếp hai lần&nbsp;<a href="https://plo.vn/tags/dsOgbyBsxrDhu5tpIG5o4bq3dCBiw7NuZw==/vao-luoi-nhat-bong.html">v&agrave;o lưới nhặt b&oacute;ng</a>&nbsp;v&igrave; hậu vệ Muangthong tổ chức ph&ograve;ng ngự, bs ra căng người cứu thua, thủ m&ocirc;n Văn L&acirc;m li&ecirc;n tục la h&eacute;t đồng đội v&igrave; tổ chức bọc l&oacute;t, hỗ trợ cho nhau qu&aacute; k&eacute;m li&ecirc;n tục đẩy Văn L&acirc;m v&agrave;o thế đối mặt đối phương cực kỳ nguy hiểm. H&agrave;ng ph&ograve;ng ngự chơi d&acirc;ng cao nhưng lui về tổ chức ph&ograve;ng ngự qu&aacute; chậm chạp khiến bị &ldquo;ăn đ&ograve;n&rdquo; từ những lần hồi m&atilde; thương của Thai Port.</p>

<p>B&agrave;n thắng mở tỷ số 1-0 ph&uacute;t 50 cho&nbsp;<a href="https://plo.vn/tags/VGhhaSBQb3J0/thai-port.html">Thai Port</a>&nbsp;của Bordin l&agrave; pha phản c&ocirc;ng mẫu mực, rồi bất ngờ Bordin tung c&uacute; s&uacute;t xa chừng 25m, b&oacute;ng bay cực căng v&agrave; bất ngờ khiến Văn L&acirc;m kh&ocirc;ng kịp phản ứng.</p>

<p>Bảy ph&uacute;t sau, Muangthong đ&oacute;n nhận b&agrave;n thua thứ hai cũng từ sự hời hợt của ph&ograve;ng ngự dẫn đến Thai Port c&oacute; b&agrave;n gia tăng l&ecirc;n 2-0 do c&ocirc;ng&nbsp; Salonon đệm b&oacute;ng cận th&agrave;nh.</p>

<p>Gần hết trận Kayen c&oacute; b&agrave;n r&uacute;t ngắn cho chủ&nbsp;<a href="https://plo.vn/tags/c8OibiBTQ0c=/san-scg.html">s&acirc;n SCG</a>, tuy nhi&ecirc;n mọi chuyện đ&atilde; qu&aacute; muộn m&agrave;n với cựu v&ocirc; địch Muangthong.</p>

<p>Thua trận n&agrave;y Muangthong ch&iacute;nh thức xuống đ&aacute;y Thai-&nbsp;<a href="https://plo.vn/tags/bGVhZ3Vl/league.html">League</a>&nbsp;với chỉ s&aacute;u điểm c&oacute; được, c&ograve;n Thai Port x&acirc;y vững ng&ocirc;i đầu bảng.</p>

<p>B&agrave;n thắng mở tỷ số 1-0 ph&uacute;t 50 cho&nbsp;<a href="https://plo.vn/tags/VGhhaSBQb3J0/thai-port.html">Thai Port</a>&nbsp;của Bordin l&agrave; pha phản c&ocirc;ng mẫu mực, rồi bất ngờ Bordin tung c&uacute; s&uacute;t xa chừng 25m, b&oacute;ng bay cực căng v&agrave; bất ngờ khiến Văn L&acirc;m kh&ocirc;ng kịp phản ứng.</p>

<p>Bảy ph&uacute;t sau, Muangthong đ&oacute;n nhận b&agrave;n thua thứ hai cũng từ sự hời hợt của ph&ograve;ng ngự dẫn đến Thai Port c&oacute; b&agrave;n gia tăng l&ecirc;n 2-0 do c&ocirc;ng&nbsp; Salonon đệm b&oacute;ng cận th&agrave;nh.</p>

<p>Gần hết trận Kayen c&oacute; b&agrave;n r&uacute;t ngắn cho chủ&nbsp;<a href="https://plo.vn/tags/c8OibiBTQ0c=/san-scg.html">s&acirc;n SCG</a>, tuy nhi&ecirc;n mọi chuyện đ&atilde; qu&aacute; muộn m&agrave;n với cựu v&ocirc; địch Muangthong.</p>

<p>Thua trận n&agrave;y Muangthong ch&iacute;nh thức xuống đ&aacute;y Thai-&nbsp;<a href="https://plo.vn/tags/bGVhZ3Vl/league.html">League</a>&nbsp;với chỉ s&aacute;u điểm c&oacute; được, c&ograve;n Thai Port x&acirc;y vững ng&ocirc;i đầu bảng.</p>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <strong><span style="font-size:14px;">Thanh Phương</span></strong></p>
', CAST(N'2019-04-21 11:08:01.677' AS DateTime), 2, NULL)
INSERT [dbo].[News] ([ID], [MetaTitle], [Image], [Desciption], [CreatedBy], [ModifiedDate], [ModifiedBy], [Contents], [CreatedDate], [Status], [Tags]) VALUES (4, N'  Juventus, Ronaldo và quyền lực tuyệt đối ở Italy', N'/Upload/Images/juvetus.jpg', N'Với Ronaldo, ngai vàng của Juventus tại Italy vốn vững như bàn thạch nay càng trở nên chắc chắn. Việc vô địch sớm 5 vòng là minh chứng cho quyền lực của đội bóng thành Turin.', 1055, CAST(N'2019-05-04 15:11:09.083' AS DateTime), NULL, N'<p><strong>&nbsp; &nbsp;Với Ronaldo, ngai v&agrave;ng của Juventus tại Italy vốn vững như b&agrave;n thạch nay c&agrave;ng trở n&ecirc;n chắc chắn. Việc v&ocirc; địch sớm 5 v&ograve;ng l&agrave; minh chứng cho quyền lực của đội b&oacute;ng th&agrave;nh Turin.</strong></p>

<p dir="ltr">Trước khi&nbsp;<a href="https://news.zing.vn/tieu-diem/cristiano-ronaldo-nhan-vat.html" title="Tin tức Cristiano Ronaldo" topic-id="3850">Cristiano Ronaldo</a>&nbsp;gia nhập&nbsp;<a href="https://news.zing.vn/tieu-diem/juventus.html" title="Tin tức Juventus" topic-id="3860">Juventus</a>&nbsp;với gi&aacute; 112 triệu euro, giới chuy&ecirc;n m&ocirc;n tại Italy sớm dự đo&aacute;n chức v&ocirc; địch Serie A 2018/19 kh&oacute; tho&aacute;t khỏi tay Juventus. Lực lượng, tiềm lực kinh tế của &ldquo;B&agrave; đầm gi&agrave; th&agrave;nh Turin&rdquo; mạnh mẽ v&agrave; vượt trội hơn qu&aacute; nhiều so với phần c&ograve;n lại.</p>

<p dir="ltr">Tuy nhi&ecirc;n, kh&ocirc;ng phải v&igrave; thế m&agrave; đ&aacute;nh gi&aacute; thấp Scudetto thứ 8 li&ecirc;n tiếp n&agrave;y của Bianconeri.</p>

<p dir="ltr"><img alt="" src="/Upload/images/juvetus.jpg" style="width: 660px; height: 438px;" /></p>

<p dir="ltr"><em>Juventus v&ocirc; địch Serie A 2018/19 sớm 5 v&ograve;ng đấu sau chiến thắng 2-1 trước Fiorentina tr&ecirc;n s&acirc;n nh&agrave; Allianz.</em></p>

<p dir="ltr"><em>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<strong> &nbsp; &nbsp;&nbsp;</strong></em><strong>Nhật Anh</strong></p>
', CAST(N'2019-04-21 11:24:14.987' AS DateTime), 2, NULL)
INSERT [dbo].[News] ([ID], [MetaTitle], [Image], [Desciption], [CreatedBy], [ModifiedDate], [ModifiedBy], [Contents], [CreatedDate], [Status], [Tags]) VALUES (5, N'Kinh nghiệm du lịch Sapa tự đi', N'/Upload/Images/57168353_2123968404388332_3453342894998421504_n.jpg', N'• Lộ trình ngắn gọn: Hà Nội – Sơn Tây – Cầu Trung Hà – Thanh Sơn – Thu Cúc – Đèo Khế - Nghĩa Lộ - Tú Lệ - Đèo Khau Phạ - MCC – T.Uyên – Lai Châu – Đèo Ô Quy Hồ - Sa Pa (dọc đi sẽ check 2 trong tứ đại đỉnh đèo, thác tình yêu và thác bạc).', 1055, NULL, NULL, N'<p><span style="font-size:20px;"><span style="font-family:Comic Sans MS,cursive;"><span style="color:#16a085;">Lịch tr&igrave;nh cụ thể</span></span></span>: <span style="font-family:Comic Sans MS,cursive;">(3 ng&agrave;y 2 đ&ecirc;m 420km) - Ng&agrave;y 1 : 6h tập trung Cổng ch&agrave;o Ho&agrave;i Đức, 6h30 xuất ph&aacute;t &bull; <span style="color:#c0392b;">Lộ tr&igrave;nh : H&agrave; Nội &ndash; Sơn T&acirc;y &ndash; Cầu Trung H&agrave; &ndash; Thanh Sơn &ndash; Thu C&uacute;c &ndash; Đ&egrave;o Khế - Nghĩa Lộ - T&uacute; Lệ - Đ&egrave;o Khau Phạ - MCC &ndash; T.Uy&ecirc;n &ndash; Lai Ch&acirc;u &ndash; Đ&egrave;o &Ocirc; Quy Hồ - Sa Pa</span> (dọc đi sẽ check 2 trong tứ đại đỉnh đ&egrave;o, th&aacute;c t&igrave;nh y&ecirc;u v&agrave; th&aacute;c bạc) &bull; 17h c&oacute; mặt tại Sa Pa nhận ph&ograve;ng tắm giặt, nghỉ ngơi rồi đi ăn tối &bull; 19h30 dạo quanh khu nh&agrave; thờ chụp ảnh &bull; 20h30 check in phố cổ cầu m&acirc;y &bull; 22h check in hồ sapa ban đ&ecirc;m &bull; 22h30 đi ăn đồ nướng &bull; 23h30 về ph&ograve;ng nghỉ ngơi lấy sức - <span style="color:#2980b9;">Ng&agrave;y 2</span> : 6h30 dậy vscn, ăn s&aacute;ng &bull; 7h30 : đi bản Tả Ph&igrave;n thăm quan check in Nh&agrave; thờ đổ, suối ( v&eacute; 30k/ người ) &bull; 10h quay lại trung t&acirc;m thị trấn để di chuyển xuống c&aacute;c bản : lao chải &ndash; tả van &ndash; bản hồ - bản c&aacute;t c&aacute;t, tham quan (trưa đ&oacute;i đ&acirc;u ăn đ&oacute;) &bull; Ăn tối v&agrave; nghỉ đ&ecirc;m ở bản c&aacute;t c&aacute;t hoặc về trung t&acirc;m t&ugrave;y &yacute; mọi người (n&ecirc;n nghỉ lại homestay ở bản c&aacute;t c&aacute;t) - <span style="color:#2980b9;">Ng&agrave;y 3</span> : 6h dậy vscn quay về trung t&acirc;m thị trấn ăn s&aacute;ng 7h30 xuất ph&aacute;t về H&agrave; Nội Chiều về c&oacute; thể chạy đường ngắn hơn nếu đi theo lộ tr&igrave;nh : &bull; <span style="color:#c0392b;">Sa Pa &ndash; L&agrave;o cai &ndash; Y&ecirc;n B&aacute;i &ndash; Đoan H&ugrave;ng &ndash; Phong Ch&acirc;u &ndash; Việt Tr&igrave; &ndash; Vĩnh Ph&uacute;c &ndash; H&agrave; Nội (360km).</span></span></p>

<p>Mọi th&ocirc;ng tin th&ecirc;m xin li&ecirc;n hệ m&igrave;nh nh&eacute;: 0919 3355 36</p>

<p>Xem th&ecirc;m video tham khảo nh&oacute;m m&igrave;nh đi /04/2017 <a href="https://youtube.com/watch?v=GApLNcNwHpU">tại đ&acirc;y</a>:&nbsp;<a href="https://www.youtube.com/watch?v=GApLNcNwHpU">https://www.youtube.com/watch?v=GApLNcNwHpU</a></p>

<p>Mail: thegioidt1@gmail.com</p>
', CAST(N'2019-04-22 11:47:52.127' AS DateTime), 2, NULL)
INSERT [dbo].[News] ([ID], [MetaTitle], [Image], [Desciption], [CreatedBy], [ModifiedDate], [ModifiedBy], [Contents], [CreatedDate], [Status], [Tags]) VALUES (6, N'Kinh nghiệm đi du lịch Sapa tự đi', N'/Upload/Images/57168353_2123968404388332_3453342894998421504_n.jpg', N'Lịch trình cụ thể: (3 ngày 2 đêm 420km) - Ngày 1 : 6h tập trung Cổng chào Hoài Đức, 6h30 xuất phát • Lộ trình : Hà Nội – Sơn Tây – Cầu Trung Hà – Thanh Sơn – Thu Cúc – Đèo Khế - Nghĩa Lộ - Tú Lệ - Đèo Khau Phạ - MCC – T.Uyên – Lai Châu – Đèo Ô Quy Hồ - Sa', 1055, CAST(N'2019-05-04 15:11:22.480' AS DateTime), NULL, N'<h2><strong>Tuổi th&igrave; c&ograve;n trẻ h&atilde;y đi&nbsp;lịch Sapa&nbsp;</strong></h2>

<p><span style="font-family:Comic Sans MS,cursive;"><span style="color:#d35400;"><span style="font-size:20px;">Lịch tr&igrave;nh cụ thể:</span></span>&nbsp;(3 ng&agrave;y 2 đ&ecirc;m 420km) - Ng&agrave;y 1 : 6h tập trung Cổng ch&agrave;o Ho&agrave;i Đức, 6h30 xuất ph&aacute;t &bull;&nbsp;<span style="color:#c0392b;">Lộ tr&igrave;nh : H&agrave; Nội &ndash; Sơn T&acirc;y &ndash; Cầu Trung H&agrave; &ndash; Thanh Sơn &ndash; Thu C&uacute;c &ndash; Đ&egrave;o Khế - Nghĩa Lộ - T&uacute; Lệ - Đ&egrave;o Khau Phạ - MCC &ndash; T.Uy&ecirc;n &ndash; Lai Ch&acirc;u &ndash; Đ&egrave;o &Ocirc; Quy Hồ - Sa Pa&nbsp;</span>(dọc đi sẽ check 2 trong tứ đại đỉnh đ&egrave;o, th&aacute;c t&igrave;nh y&ecirc;u v&agrave; th&aacute;c bạc) &bull; 17h c&oacute; mặt tại Sa Pa nhận ph&ograve;ng tắm giặt, nghỉ ngơi rồi đi ăn tối &bull; 19h30 dạo quanh khu nh&agrave; thờ chụp ảnh &bull; 20h30 check in phố cổ cầu m&acirc;y &bull; 22h check in hồ sapa ban đ&ecirc;m &bull; 22h30 đi ăn đồ nướng &bull; 23h30 về ph&ograve;ng nghỉ ngơi lấy sức -&nbsp;<span style="color:#2980b9;">Ng&agrave;y 2&nbsp;</span>: 6h30 dậy vscn, ăn s&aacute;ng &bull; 7h30 : đi bản Tả Ph&igrave;n thăm quan check in Nh&agrave; thờ đổ, suối ( v&eacute; 30k/ người ) &bull; 10h quay lại trung t&acirc;m thị trấn để di chuyển xuống c&aacute;c bản : lao chải &ndash; tả van &ndash; bản hồ - bản c&aacute;t c&aacute;t, tham quan (trưa đ&oacute;i đ&acirc;u ăn đ&oacute;) &bull; Ăn tối v&agrave; nghỉ đ&ecirc;m ở bản c&aacute;t c&aacute;t hoặc về trung t&acirc;m t&ugrave;y &yacute; mọi người (n&ecirc;n nghỉ lại homestay ở bản c&aacute;t c&aacute;t) -&nbsp;<span style="color:#2980b9;">Ng&agrave;y 3</span>&nbsp;: 6h dậy vscn quay về trung t&acirc;m thị trấn ăn s&aacute;ng 7h30 xuất ph&aacute;t về H&agrave; Nội Chiều về c&oacute; thể chạy đường ngắn hơn nếu đi theo lộ tr&igrave;nh : &bull;&nbsp;<span style="color:#c0392b;">Sa Pa &ndash; L&agrave;o cai &ndash; Y&ecirc;n B&aacute;i &ndash; Đoan H&ugrave;ng &ndash; Phong Ch&acirc;u &ndash; Việt Tr&igrave; &ndash; Vĩnh Ph&uacute;c &ndash; H&agrave; Nội (360km).</span></span></p>

<p><span style="font-family:Comic Sans MS,cursive;"><span style="color:#c0392b;"><img alt="" src="/Upload/images/DSC01580.JPG" style="width: 750px; height: 400px;" /></span></span></p>

<p>Mọi th&ocirc;ng tin th&ecirc;m xin li&ecirc;n hệ m&igrave;nh nh&eacute;: 0919 3355 36</p>

<p>Xem th&ecirc;m video tham khảo nh&oacute;m m&igrave;nh đi /04/2017&nbsp;<a href="https://youtube.com/watch?v=GApLNcNwHpU">tại đ&acirc;y</a>:&nbsp;<a href="https://www.youtube.com/watch?v=GApLNcNwHpU">https://www.youtube.com/watch?v=GApLNcNwHpU</a></p>

<p>Mail: thegioidt1@gmail.com</p>
', CAST(N'2019-04-22 11:57:51.480' AS DateTime), 2, N'du lich sapa, sapa, kinh nghiệm du lich sapa')
INSERT [dbo].[News] ([ID], [MetaTitle], [Image], [Desciption], [CreatedBy], [ModifiedDate], [ModifiedBy], [Contents], [CreatedDate], [Status], [Tags]) VALUES (7, N'hfgdhfg', N'/Upload/Images/94D689DE-C97C-4BB9-8807-6DC62B5FB9A3.jpg', N'hdfghfgh', 1055, NULL, NULL, N'<p>hfdghfgh</p>
', CAST(N'2019-09-17 10:28:08.073' AS DateTime), 2, NULL)
INSERT [dbo].[News] ([ID], [MetaTitle], [Image], [Desciption], [CreatedBy], [ModifiedDate], [ModifiedBy], [Contents], [CreatedDate], [Status], [Tags]) VALUES (8, N'hfghfgdh', N'/Upload/Images/Screenshot_4.png', N'hfghdf', 1055, NULL, NULL, N'<p>hfghfgh</p>
', CAST(N'2019-09-23 12:37:07.510' AS DateTime), 2, N'hfgdhfgh')
SET IDENTITY_INSERT [dbo].[News] OFF
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (0, 10, 0)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (0, 21, 0)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (0, 22, 0)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (0, 23, 0)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (0, 24, 0)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (0, 25, 0)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (0, 27, 0)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (0, 28, 0)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (5, 2, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 3, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 18, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 20, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (11, 26, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (12, 20, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (14, 4, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (14, 7, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (14, 17, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (16, 5, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (16, 6, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (18, 3, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (18, 29, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (27, 30, 6)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (27, 31, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 8, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 9, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 10, 3)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 11, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 12, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 13, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 14, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 15, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 16, 1)
INSERT [dbo].[OrderDetail] ([ProductID], [OrderID], [Quantity]) VALUES (33, 19, 1)
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (11, 16, N'Gấu bông Teddy xoắn cafe áo len đỏ 1m6', N'LYLY19', N'/Upload/Images/gau-teddy-xoan-cafe-ao-len-do-1.6m-510x383.jpg', N'<Images><Image>http://localhost:81/Upload/Images/1712285_2952018.jpg</Image></Images>', 600000, 560000, N'<p><a href="https://gausaigon.com/danh-muc/gau-bong-teddy/"><strong>Gấu b&ocirc;ng Teddy</strong></a>&nbsp;xoắn cafe &aacute;o len đỏ&nbsp;nằm tr&ocirc;ng bộ sưu tập&nbsp;<strong>gấu teddy</strong>&nbsp;<a href="https://gausaigon.com/">GẤU S&Agrave;I G&Ograve;N</a>. với bộ l&ocirc;ng x&ugrave; h&igrave;nh vảy c&aacute; m&agrave;u lạ mắt, khu&ocirc;n mặt đ&aacute;ng y&ecirc;u, th&acirc;n h&igrave;nh mũm mĩm c&ugrave;ng chiếc &aacute;o len đỏ tay bắt mắt mắt. C&aacute;c c&ocirc; n&agrave;ng sẽ th&iacute;ch m&ecirc; m&oacute;n qu&agrave; n&agrave;y đấy!</p>

<h2>Gấu b&ocirc;ng Teddy xoắn cafe &aacute;o len đỏ 1.6m &ndash; 100% b&ocirc;ng g&ograve;n bi</h2>

<p>Ai m&agrave; kh&ocirc;ng th&iacute;ch gấu b&ocirc;ng, đặc biệt l&agrave; những b&eacute; gấu Teddy đ&uacute;ng kh&ocirc;ng n&agrave;o?</p>

<p>Nh&igrave;n trực diện b&eacute;&nbsp;<strong>gấu Teddy</strong>&nbsp;mặc &aacute;o len đỏ rất thu h&uacute;t với đ&ocirc;i mắt đen l&aacute;y, tai tr&ograve;n rũ xuống cực đ&aacute;ng y&ecirc;u. Đặc biệt nhất l&agrave; chiếc miệng lu&ocirc;n nở nụ cười v&agrave; chiếc mũi m&agrave;u n&acirc;u nổi bật tr&ecirc;n phần m&otilde;m m&agrave;u kem.</p>

<p><img alt="gau-teddy-xoan-cafe-ao-len-do-1.6m " height="525" sizes="(max-width: 700px) 100vw, 700px" src="https://gausaigon.com/wp-content/uploads/2019/02/gau-teddy-xoan-cafe-ao-len-do-1.6m-1-1-1024x768.jpg" srcset="https://gausaigon.com/wp-content/uploads/2019/02/gau-teddy-xoan-cafe-ao-len-do-1.6m-1-1-1024x768.jpg 1024w, https://gausaigon.com/wp-content/uploads/2019/02/gau-teddy-xoan-cafe-ao-len-do-1.6m-1-1-300x225.jpg 300w, https://gausaigon.com/wp-content/uploads/2019/02/gau-teddy-xoan-cafe-ao-len-do-1.6m-1-1-768x576.jpg 768w, https://gausaigon.com/wp-content/uploads/2019/02/gau-teddy-xoan-cafe-ao-len-do-1.6m-1-1-510x383.jpg 510w" width="700" /></p>

<p>Với bộ l&ocirc;ng m&agrave;u xoắn cafe, kết hợp chiếc &aacute;o len cao cấp c&oacute; phần th&acirc;n &aacute;o m&agrave;u đỏ, c&ugrave;ng với chiều cao 1m6 b&eacute; gấu Teddy xoắn cafe nhập khẩu n&agrave;y sẽ l&agrave; m&oacute;n qu&agrave; được c&aacute;c c&ocirc; n&agrave;ng cực k&igrave; y&ecirc;u mến đấy.</p>

<p>Tham khảo th&ecirc;m mẫu gấu Teddy được y&ecirc;u th&iacute;ch của GẤU S&Agrave;I G&Ograve;N ở đường link&nbsp;<a href="https://gausaigon.com/danh-muc/gau-bong-teddy/">https://gausaigon.com/danh-muc/gau-bong-teddy/</a>&nbsp;n&agrave;y nh&eacute;!</p>

<p>Với th&acirc;n h&igrave;nh mũm mĩm, mềm mịn như thế n&agrave;y th&igrave; bạn c&oacute; muốn c&oacute; một b&eacute; kh&ocirc;ng n&agrave;o? Gấu b&ocirc;ng Teddy xoắn cafe sẽ l&agrave; bờ vai mỗi khi mệt mỏi, c&aacute;i &ocirc;m khi buồn, h&agrave;nh hạ khi ức chế v&agrave; đặc biệt l&agrave; người nghe rất biết im lặng, k&iacute;n miệng.</p>

<p><img alt="gau-teddy-cao-cap" height="95" sizes="(max-width: 500px) 100vw, 500px" src="https://gausaigon.com/wp-content/uploads/2018/01/gau-teddy-cao-cap.png" srcset="https://gausaigon.com/wp-content/uploads/2018/01/gau-teddy-cao-cap.png 500w, https://gausaigon.com/wp-content/uploads/2018/01/gau-teddy-cao-cap-300x57.png 300w" width="500" /></p>
', CAST(N'2019-04-22 12:07:58.897' AS DateTime), 1)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (12, NULL, N'Led trái tim RGB 7 màu tặng sinh nhật bạn gái', N'FDHFGDRT', N'/Upload/Images/66599418_333166517621906_5354981124621729792_n.jpg', NULL, 450000, 400000, N'<p>hfgdhfgdh</p>
', CAST(N'2019-04-22 12:09:52.567' AS DateTime), 2)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (14, NULL, N'Led trái tim đôi có chữ ck - vk', N'MD123A', N'/Upload/Images/1712285_2952018.jpg', N'<Images><Image>http://localhost:1111/Upload/Images/66599418_333166517621906_5354981124621729792_n.jpg</Image><Image>http://localhost:1111/Upload/Images/66359152_2360999353994389_5779463462723780608_n.jpg</Image></Images>', 360000, 300000, N'<p>ledquatang.net - 0919 3355 36</p>
', CAST(N'2019-04-22 21:04:29.443' AS DateTime), 1)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (15, NULL, N'Món quà tặng Led trai tim đôi cùng tên hai bạn ', N'REGSRTEE', N'/Upload/Images/2DDA151B-6867-40E9-A71F-335D8F0E7BCB.jpg', NULL, 360000, 250000, N'<p>fdgdghf</p>
', CAST(N'2019-04-22 21:07:14.347' AS DateTime), 2)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (16, NULL, N'Led trái tim RGB 7 màu tặng sinh nhật bạn gái chữ i love you forever', NULL, N'/Upload/Images/hpvalentine.JPG', N'<Images><Image>http://localhost:1111/Upload/Images/forever.jpg</Image><Image>http://localhost:1111/Upload/Images/Koala.jpg</Image><Image>http://localhost:1111/Upload/Images/t225186163i_xu225187145ng.ico</Image><Image>http://localhost:1111/Upload/Images/kmdb.jpg</Image></Images>', 450000, 400000, N'<p><span style="font-size:18px;"><span style="color:#d35400;">14/2</span></span> l&agrave; một ng&agrave;y đặc biệt trong năm để c&aacute;c đ&ocirc;i c&ugrave;ng nhau viết th&ecirc;m v&agrave;o chặng đường t&igrave;nh y&ecirc;u của họ những kỷ niệm kh&oacute; qu&ecirc;n. Đ&acirc;y cũng l&agrave; dịp để những người quan t&acirc;m nhau dũng cảm b&agrave;y tỏ l&ograve;ng m&igrave;nh, b&agrave;y tỏ lời y&ecirc;u.</p>

<p>Mỗi m&oacute;n qu&agrave; d&ugrave; l&agrave; nhỏ b&eacute; được trao đi trong ng&agrave;y lễ t&igrave;nh nh&acirc;n <em><u><span style="color:#c0392b;">Valentine</span></u></em> đều mang một &yacute; nghĩa ri&ecirc;ng của n&oacute; m&agrave; kh&ocirc;ng phải ai cũng biết.</p>

<p><span style="font-size:20px;"><span style="color:#e74c3c;"><em>Socola </em></span></span>l&agrave; m&oacute;n qu&agrave; được nhiều người chọn nhất để gửi gắm t&igrave;nh cảm của m&igrave;nh trong dịp <span style="color:#c0392b;">Valentine</span>. Nếu như bạn thắc mắc socola c&oacute; &yacute; nghĩa g&igrave; th&igrave; h&atilde;y thử nếm một ch&uacute;t v&agrave; cảm nhận. Ban đầu bạn sẽ thấy vị đắng, 1 l&aacute;t sau bạn sẽ cảm nhận được vị ngọt đọng lại. Đ&oacute; cũng ch&iacute;nh l&agrave; vị của t&igrave;nh y&ecirc;u, l&uacute;c đắng l&uacute;c ngọt.</p>

<p>C&oacute; ki&ecirc;n tr&igrave; vượt qua những l&uacute;c s&oacute;ng gi&oacute; mới chạm đến gi&acirc;y ph&uacute;t ngọt ng&agrave;o trong t&igrave;nh y&ecirc;u.</p>

<p style="margin-left: 360px;"><img alt="LTT7001" src="/Upload/images/DSC_1185.JPG" style="width: 250px; height: 141px; float: left;" /></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>th&ecirc;m v&agrave;o đ&oacute; đi k&egrave;m với socola bạn n&ecirc;n chọn một m&oacute;n qu&agrave; m&agrave; để được l&acirc;u như led tr&aacute;i tim, rất đẹp mắt, để được l&acirc;u để người được tặng nhớ đến người đ&atilde; tặng m&igrave;nh mỗi khi nh&igrave;n v&agrave;o n&oacute;.</p>

<p>H&atilde;y d&agrave;nh cho nửa kia m&oacute;n qu&agrave; &yacute; nghĩa để m&ugrave;a&nbsp;<span style="color:#c0392b;">Valentine</span> năm nay thật ấm &aacute;p v&agrave; đ&aacute;ng nhớ nh&eacute; c&aacute;c bạn !</p>

<p style="margin-left: 280px;"><img alt="" src="/Upload/images/DSC_1178.JPG" style="width: 356px; height: 200px;" /></p>
', CAST(N'2019-04-23 10:18:20.737' AS DateTime), 2)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (17, NULL, N'Led trái tim RGB 7 màu tặng quà 20/10', NULL, N'/Upload/Images/cogai.JPG', NULL, 450000, 410000, N'<p>Led tr&aacute;i tim h&igrave;nh ảnh người y&ecirc;u</p>
', CAST(N'2019-04-23 22:27:07.207' AS DateTime), 2)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (18, NULL, N'Led trái tim RGB đổi màu love you forever', N'FSDGHFDH', N'/Upload/Images/BECE4BDB-E0E0-4B79-8E54-C528A558BD31.jpg', NULL, 450000, 400000, N'<p><span style="font-size:24px;"><strong>Lựa chọn Qu&agrave; Tặng</strong></span></p>

<p>L&agrave;m thế n&agrave;o để c&oacute; thể lựa chọn được một m&oacute;n<strong>&nbsp;<span style="color:#d35400;">qu&agrave; tặng sinh nhật cho bạn th&acirc;n</span></strong>&nbsp;vừa đẹp mắt m&agrave; lại &yacute; nghĩa? Việc lựa chọn qu&agrave; tặng l&uacute;c n&agrave;o cũng khiến ch&uacute;ng ta bối rối v&igrave; đặc th&ugrave; con người ở mỗi độ tuổi, giới t&iacute;nh, c&ocirc;ng việc chắc chắn đều c&oacute; sở th&iacute;ch ho&agrave;n to&agrave;n kh&aacute;c nhau, bạn kh&ocirc;ng thể ph&aacute;n đo&aacute;n được chắc chắn 100% rằng người bạn th&acirc;n của bạn&nbsp;th&iacute;ch những thứ g&igrave; để mua tặng, nếu kh&eacute;o l&eacute;o trong giao tiếp h&agrave;ng ng&agrave;y bạn c&oacute; thể tặng qu&agrave; theo t&iacute;nh c&aacute;ch của bạn ấy.&nbsp;B&agrave;i viết n&agrave;y, <a href="http://www.ledquatang.net/">Led&nbsp;Qu&agrave; tặng&nbsp;</a>sẽ gi&uacute;p cho mọi người c&oacute; c&aacute;i nh&igrave;n bao qu&aacute;t về c&aacute;c m&oacute;n qu&agrave; &yacute; nghĩa, phổ biến tr&ecirc;n thị trường hiện nay. xem chi tiết nhiều hơn <a href="http://www.ledquatang.net/danh-muc-san-pham/qua-tang-ban-than.html">tại đ&acirc;y</a></p>

<h2><span style="font-size:24px;"><strong>Tặng qu&agrave; sinh nhật cho bạn th&acirc;n nữ</strong></span></h2>

<p style="margin-left: 240px;"><span style="font-size:24px;"><strong><img alt="" src="/Upload/images/DSC_1306.JPG" style="width: 317px; height: 178px;" /></strong></span></p>

<p>Phụ nữ n&agrave;o cũng th&iacute;ch t&igrave;nh cảm nhẹ nh&agrave;ng, ch&acirc;n th&agrave;nh, họ mong muốn được tặng những m&oacute;n qu&agrave; dễ thương v&agrave; xinh xắn đặc biệt l&agrave; từ người kh&aacute;c ph&aacute;i. Bạn c&oacute; muốn thể hiện t&igrave;nh cảm của m&igrave;nh nhưng kh&ocirc;ng biết phải l&agrave;m sao! ng&agrave;y kỷ niệm đặc biệt &nbsp;ch&iacute;nh l&agrave; ng&agrave;y m&agrave; bạn g&aacute;i th&acirc;n đ&atilde; sinh ra đời. Ch&uacute;ng ta c&oacute; thể chọn ra những loại<strong>&nbsp;qu&agrave; tặng sinh nhật bạn th&acirc;n nữ</strong>&nbsp;theo những kiểu mẫu <strong><span style="color:#c0392b;">led tr&aacute;i tim 7 m&agrave;u</span></strong> d&aacute;n ảnh b&ecirc;n dưới đ&acirc;y.</p>

<p style="margin-left: 200px;"><img alt="" src="/Upload/images/DSC_1226.JPG" style="width: 356px; height: 200px;" /></p>

<h2><strong>Qu&agrave; tặng sinh nhật cho bạn th&acirc;n nam</strong></h2>

<p><strong>N&ecirc;n tặng qu&agrave; sinh nhật g&igrave; cho bạn nam chơi&nbsp;th&acirc;n?</strong>&nbsp;Những bạn nam lại th&iacute;ch c&aacute; t&iacute;nh mạnh mẽ v&agrave; sự độc đ&aacute;o hơn hẳn ở mỗi m&oacute;n qu&agrave;. Nếu tinh &yacute; một ch&uacute;t bạn c&oacute; thể biết r&otilde; được người ấy th&iacute;ch thứ g&igrave;, gợi &yacute; c&oacute; thể th&ocirc;ng qua c&aacute;ch ăn mặc thường ng&agrave;y, c&aacute;ch n&oacute;i chuyện, t&aacute;c phong đi lại&hellip; v&agrave; 168&nbsp;c&aacute;c t&iacute;n hiệu kh&aacute;c n&ecirc;n bạn đừng qu&aacute; lo về việc n&ecirc;n tặng qu&agrave; g&igrave; cho bạn tr&acirc;n trong ng&agrave;y sinh nhật, bạn c&oacute; thể lựa chọn một một qu&agrave; thật đơn giản như Led tr&aacute;i tim 7 đổi m&agrave;u ghi chữ Forever như dưới đ&acirc;y, vừa thể hiện được sự mạnh mẽ, nam t&iacute;nh lại mang nhiều &yacute; nghĩa tr&acirc;n trọng:</p>

<p style="margin-left: 200px;"><img alt="" src="/Upload/images/forever.png" style="width: 534px; height: 482px;" /></p>
', CAST(N'2019-04-30 17:47:37.160' AS DateTime), 3)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (27, NULL, N'Samsung', N'?df', N'/Upload/Images/Koala.jpg', NULL, 13000000, 12000000, N'<p>fsfgsdfgsfg<img alt="sad" height="23" src="http://localhost:1111/Content/plugins/ckeditor/plugins/smiley/images/sad_smile.png" title="sad" width="23" />&nbsp;</p>

<hr />
<p><img alt="" src="/Upload/images/co-thay-han-2_ztaj.jpg" style="width: 660px; height: 401px;" /></p>
', CAST(N'2019-05-16 15:09:49.697' AS DateTime), 3)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (28, NULL, N'abc', N'ADFASDF', N'/Upload/Images/Koala.jpg', NULL, NULL, NULL, N'<p>sdfghjkl</p>
', CAST(N'2019-05-17 11:52:17.270' AS DateTime), 3)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (29, NULL, N'ádfasdf', N'A', N'/Upload/Images/image_2019_08_28T02_59_23_550Z.png', NULL, NULL, NULL, N'<p>d</p>
', CAST(N'2019-05-17 11:55:21.217' AS DateTime), 1)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (30, NULL, N'A', N'D', N'/Upload/Images/Koala.jpg', NULL, NULL, NULL, N'<p>AAA</p>
', CAST(N'2019-05-17 11:58:34.127' AS DateTime), 1)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (31, NULL, N'B', N'B', N'/Upload/Images/Koala.jpg', NULL, NULL, NULL, N'<p>D</p>
', CAST(N'2019-05-17 11:59:14.053' AS DateTime), 3)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (32, NULL, N'DDD', N'F', N'/Upload/Images/Koala.jpg', NULL, NULL, NULL, N'<p>D</p>
', CAST(N'2019-05-17 12:00:00.607' AS DateTime), 3)
INSERT [dbo].[Product] ([ID], [CategoryId], [Name], [ProductCode], [Images], [ImageMore], [Price], [Sale], [Description], [CreatedDate], [Status]) VALUES (33, NULL, N'adasdad', N'MD123', N'/Upload/Images/image_2019_08_28T02_59_23_550Z.png', N'<Images><Image>http://localhost:1111/Upload/Images/66359152_2360999353994389_5779463462723780608_n.jpg</Image></Images>', 10000000, 900000, N'<p>đ&acirc;sda</p>
', CAST(N'2019-05-29 10:59:07.957' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[Slide] ON 

INSERT [dbo].[Slide] ([ID], [Title], [Image], [DisplayOrder], [Link], [Description], [Status]) VALUES (1, N'Sile1', N'/Upload/Images/Banner-new.png', 1, NULL, NULL, 1)
INSERT [dbo].[Slide] ([ID], [Title], [Image], [DisplayOrder], [Link], [Description], [Status]) VALUES (2, N'Sile2', N'/Upload/Images/psd-investment-finance-blue-gradient-banner-poster-background-heypik-8VU442M.jpg', 2, NULL, NULL, 1)
INSERT [dbo].[Slide] ([ID], [Title], [Image], [DisplayOrder], [Link], [Description], [Status]) VALUES (3, N'Sile2', N'/Upload/Images/pngtree-gradient-jobs-business-investment-image_13903.jpg', 3, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Slide] OFF
SET IDENTITY_INSERT [dbo].[tbl_GroupUser] ON 

INSERT [dbo].[tbl_GroupUser] ([ID], [Name], [ExpandNews], [Status], [Permission], [PermissionCatNews]) VALUES (4, N'Kỹ thuật (full quyền)', 0, 1, N'<?xml version="1.0" encoding="utf-16"?><ArrayOfPermission xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Permission><AdminMenuId>1013</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>1014</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>1015</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3022</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3023</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>1016</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3025</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3028</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3027</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3026</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3029</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3030</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3031</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3032</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3033</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3034</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3035</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3036</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3038</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3039</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3037</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3041</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3042</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3043</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3044</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3045</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3046</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4046</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4047</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4048</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3024</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4049</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4050</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4051</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4052</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4054</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4053</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4056</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4055</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4057</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4058</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4060</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4059</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4061</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5061</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5063</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5062</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5064</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5065</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5066</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5067</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5068</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5069</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5071</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5072</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5073</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5074</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5075</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5076</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5077</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5078</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5079</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5080</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5081</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5082</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5083</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5084</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5085</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5086</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5087</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5088</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5090</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5089</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5091</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6090</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6091</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6092</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6096</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6097</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6099</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>7100</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3040</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>7099</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6100</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6101</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6102</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6103</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6104</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6105</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6106</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6107</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6108</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6109</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6110</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6111</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6112</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6114</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6115</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6113</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission></ArrayOfPermission>', N'<?xml version="1.0" encoding="utf-16"?><ArrayOfPermission xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Permission><AdminMenuId>1</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>3</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>43</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1042</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>30</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1202</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1203</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1233</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1228</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1229</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>32</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>28</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1241</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1231</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1256</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1262</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1257</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1253</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1260</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1261</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1259</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1265</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1266</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1263</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1267</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1268</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1269</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1270</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1271</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1272</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1273</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1287</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1297</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1298</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1299</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1285</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1307</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1308</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1309</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1304</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1305</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1306</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1289</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1310</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1311</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1312</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1290</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1313</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1288</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1300</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1302</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1303</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1301</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1294</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1295</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1296</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1293</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1291</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1292</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1315</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1324</AdminMenuId><Roles>1,2,3,4</Roles></Permission></ArrayOfPermission>')
INSERT [dbo].[tbl_GroupUser] ([ID], [Name], [ExpandNews], [Status], [Permission], [PermissionCatNews]) VALUES (14, N'Quản trị tin bài', 0, 1, N'<?xml version="1.0" encoding="utf-16"?><ArrayOfPermission xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Permission><AdminMenuId>3024</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3040</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>1016</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>3039</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4048</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4054</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>4053</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5090</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5074</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5075</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5076</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5064</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5065</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5068</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5066</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>5067</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6097</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6099</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6103</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>6115</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>1014</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission><Permission><AdminMenuId>1013</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission></ArrayOfPermission>', N'<?xml version="1.0" encoding="utf-16"?><ArrayOfPermission xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Permission><AdminMenuId>1</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1262</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>43</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1257</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1042</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>30</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1260</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1265</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1266</AdminMenuId><Roles>1,2,3,4</Roles></Permission><Permission><AdminMenuId>1261</AdminMenuId><Roles>1,2,3,4</Roles></Permission></ArrayOfPermission>')
INSERT [dbo].[tbl_GroupUser] ([ID], [Name], [ExpandNews], [Status], [Permission], [PermissionCatNews]) VALUES (16, N'Xem tin', 0, 1, N'<?xml version="1.0" encoding="utf-16"?><ArrayOfPermission xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', NULL)
INSERT [dbo].[tbl_GroupUser] ([ID], [Name], [ExpandNews], [Status], [Permission], [PermissionCatNews]) VALUES (17, N'quản trị sản phẩm', 0, 1, N'<?xml version="1.0" encoding="utf-16"?><ArrayOfPermission xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><Permission><AdminMenuId>6104</AdminMenuId><Roles>1,2,3,4,6,5</Roles></Permission></ArrayOfPermission>', NULL)
SET IDENTITY_INSERT [dbo].[tbl_GroupUser] OFF
SET IDENTITY_INSERT [dbo].[tbl_Order] ON 

INSERT [dbo].[tbl_Order] ([ID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreatedDate], [Status]) VALUES (26, N'ghfjfghjfgh', N'jhgfjghjgh', N'0961582585', N'fdgaaaaafd@gmail.com', CAST(N'2019-09-20 08:37:33.967' AS DateTime), 1)
INSERT [dbo].[tbl_Order] ([ID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreatedDate], [Status]) VALUES (27, N'ghfjfghjfgh', N'ghfghfdghfgh', N'0961582585', N'fdgaaaaafd@gmail.com', CAST(N'2019-09-20 11:31:10.103' AS DateTime), 1)
INSERT [dbo].[tbl_Order] ([ID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreatedDate], [Status]) VALUES (28, N'ghfjfghjfgh', N'dsdadsada', N'0961582585', N'fdgaaaaafd@gmail.com', CAST(N'2019-09-20 11:34:18.800' AS DateTime), 1)
INSERT [dbo].[tbl_Order] ([ID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreatedDate], [Status]) VALUES (29, N'ghfjfghjfgh', N'gfhfdghfgh', N'0961582585', N'fdgaaaaafd@gmail.com', CAST(N'2019-09-20 13:53:42.747' AS DateTime), 1)
INSERT [dbo].[tbl_Order] ([ID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreatedDate], [Status]) VALUES (30, N'hggfhgfh', N'hfgdhgfh', N'0', N'hgfhdfgh', CAST(N'2019-09-28 00:05:07.993' AS DateTime), 1)
INSERT [dbo].[tbl_Order] ([ID], [CustomerName], [CustomerAddress], [CustomerPhone], [CustomerEmail], [CreatedDate], [Status]) VALUES (31, N'ytujytu', N'0', N'0961582585', N'fdgaaaaafd@gmail.com', CAST(N'2019-09-28 00:11:10.410' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tbl_Order] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1071, N'0918236584', N'fdgaaaaafd@gmail.com', N'ghfjfghjfgh', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 08:58:58.513' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0961582585', 60, 3, 1, NULL, NULL, N'', NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1073, N'0983314410', N'ttph@hsph.edu.vn', N'Trần Thị Phúc Hằng', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 09:11:36.390' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0983314410', 64, 7, 0, NULL, NULL, NULL, NULL, NULL, 0, 1, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1074, N'0989017503', N'thanhtana@yahoo.com', N'Thanh Tấn', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 09:14:51.047' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0989017503', 62, 7, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1075, N'0983010167', N'ngaht2006@yahoo.com', N'Hồ Thiên Nga', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 09:24:52.480' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0983010167', 65, 6, 0, NULL, NULL, N'', NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1076, N'0976096479', N'kieukhanh0408@gmail.com', N'Phạm Thùy Trang', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 09:28:35.313' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0976096479', 67, 6, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1077, N'0912774677', N'leanhtuyetbyt@gmail.com', N'Lê Ánh Tuyết', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 09:30:39.467' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0912774677', 66, 6, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1078, N'0908130422', N'tuyettbbd@gmail.com', N'Trần Thị Bạch Tuyết', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 09:45:43.820' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0908130422', 69, 6, 0, NULL, NULL, N'', NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1079, N'0974413582', N'lenghialo@yahoo.com', N'Lê Huy Toản', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 09:52:04.433' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0974413582', 71, 6, 0, NULL, NULL, N'', NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1080, N'0912570696', N'phamvanthuyen@benhnhietdoi.vn', N'Phạm Văn Thuyên', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 09:56:03.270' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0912570696', 72, 6, 0, NULL, NULL, N'', NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1082, N'0912095083', N'dongyvietnam@gmail.com', N'Công Minh', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-17 17:02:42.173' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, N'0912095083', 85, 6, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1087, N'gfdgfd', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(N'2019-09-10 11:49:10.833' AS DateTime), N'123456', NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1088, N'gdsgsfdgsfdgsfd', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(N'2019-09-10 11:52:05.987' AS DateTime), N'123456', NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)
INSERT [dbo].[User] ([ID], [UserName], [Email], [FullName], [Gender], [Birthday], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Telephone], [Phone], [DonviId], [ChucVuId], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [NoiBo], [PageNoiBo], [isAdmin], [IsBanChapHanh], [IsShow]) VALUES (1089, N'gsfdgfdg', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(N'2019-09-10 15:16:01.910' AS DateTime), N'1', NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[UserAdmin] ON 

INSERT [dbo].[UserAdmin] ([ID], [UserName], [Email], [FullName], [Gender], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Phone], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [PageElementID], [QuyTrinhXuatBanID], [isAdmin]) VALUES (1042, N'dev', N'tin@gmail.com', N'Nguyễn Văn Admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2017-05-16 15:28:25.477' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, 1, CAST(N'2019-09-20 09:17:23.247' AS DateTime), N'222.252.20.51', NULL, NULL, NULL, 0)
INSERT [dbo].[UserAdmin] ([ID], [UserName], [Email], [FullName], [Gender], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Phone], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [PageElementID], [QuyTrinhXuatBanID], [isAdmin]) VALUES (1055, N'admin', N'admin@gmail.com', N'Thắng KTV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2019-04-12 06:45:00.807' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, 1, CAST(N'2019-09-27 23:06:48.787' AS DateTime), N'183.91.7.155', N'4', NULL, NULL, 1)
INSERT [dbo].[UserAdmin] ([ID], [UserName], [Email], [FullName], [Gender], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Phone], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [PageElementID], [QuyTrinhXuatBanID], [isAdmin]) VALUES (1056, N'lam123', N'fgfdgd@gmail.com', N'fghgfdhgfdhdfg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2019-09-27 22:40:59.280' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, 1, CAST(N'2019-09-27 22:41:55.127' AS DateTime), NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[UserAdmin] ([ID], [UserName], [Email], [FullName], [Gender], [Photo], [Address], [City], [District], [Country], [zip], [Active], [CreatedDate], [Password], [PasswordQuestion], [PasswordAnswer], [Phone], [UserType], [TimeLogin], [IPLogin], [GroupUserID], [PageElementID], [QuyTrinhXuatBanID], [isAdmin]) VALUES (1057, N'admin11', N'fgfdgd@gmail.com', N'12sadasdad', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(N'2019-09-27 23:04:04.227' AS DateTime), N'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, 1, CAST(N'2019-09-27 23:06:07.383' AS DateTime), NULL, N'17', NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[UserAdmin] OFF
/****** Object:  StoredProcedure [dbo].[Sp_About_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
create proc [dbo].[Sp_About_Update]
@ID int,
@MetaTitle nvarchar(255),
@Contents varchar(max),
    @Tags varchar(500)
as
UPDATE [dbo].[About]
   SET  [MetaTitle] =  @MetaTitle,  
       [Contents] =  @Contents,  
       [Tags] =  @Tags 
      
 WHERE ID = @ID




GO
/****** Object:  StoredProcedure [dbo].[Sp_AccessWebsite_GetAll]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_AccessWebsite_GetAll]
as
select * from AccessWebsite 






GO
/****** Object:  StoredProcedure [dbo].[Sp_AccessWebsite_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_AccessWebsite_Insert]
           @BrowserName  varchar(50) ,
            @DeviceName  varchar(50) ,
			@IPAddress varchar(50) ,
            @EndTime  datetime 
AS
INSERT INTO [dbo].[AccessWebsite]
            (BrowserName ,
            DeviceName ,
			IPAddress,
            StartTime ,
            EndTime )
     VALUES
           (@BrowserName  ,
            @DeviceName ,
			@IPAddress,
            GETDATE() ,
            @EndTime)







GO
/****** Object:  StoredProcedure [dbo].[Sp_Adv_Image_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create proc [dbo].[Sp_Adv_Image_Update]
@ID int,
@Title nvarchar(255),
@Image varchar(255),
    @Link varchar(255),
    @Position int,
       @Type int,
       @TagetBlank bit,
      @DisplayOrder int,
   @Status bit
as
UPDATE [dbo].[AdvImag]
   SET [Title] = @Title ,
      [Image] = @Image,
      [Link] = @Link ,
      [Position] = @Position ,
      [Type] = @Type,
      [TagetBlank] = @TagetBlank,
      [DisplayOrder] = @DisplayOrder,
      [Status] = @Status
 WHERE ID = @ID




GO
/****** Object:  StoredProcedure [dbo].[Sp_Category_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Category_Update]
@ID int,
  @Name nvarchar(500),
       @LinkSeo nvarchar(500),
      @OrderDisplay int,
 @Icon varchar(50),
    @Type int
	  as
UPDATE [dbo].[Category]
   SET [Name] = @Name ,
      [LinkSeo] = @LinkSeo,
      [OrderDisplay] = @OrderDisplay,
      [Icon] = @Icon,
      [Type] = @Type 
 WHERE ID = @ID





GO
/****** Object:  StoredProcedure [dbo].[Sp_Contact_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Contact_Insert]
  @Contents  nvarchar(max) 
  as
INSERT INTO [dbo].[Contact]
          (Contents)
     VALUES 
           (@Contents)







GO
/****** Object:  StoredProcedure [dbo].[Sp_Contact_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Contact_Update]
@ID int,
 @Contents  nvarchar(max) 
 as
UPDATE [dbo].[Contact]
   SET [Contents] = @Contents 
 WHERE ID = @ID








GO
/****** Object:  StoredProcedure [dbo].[Sp_CountAccess]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_CountAccess]
as
select count(ID) as AccessCount from AccessWebsite






GO
/****** Object:  StoredProcedure [dbo].[Sp_Feedback_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Feedback_Insert]
            @FullName  nvarchar(100) ,
            @Phone  varchar(20) ,
            @Email  varchar(100) ,
            @Title  nvarchar(255) ,
            @Contents  nvarchar(max) , 
            @Status  bit  
		   as
INSERT INTO [dbo].[tbl_FeedBack]
           ([FullName],
            [Phone],
            [Email],
            [Title],
            [Contents],
            [CreatedDate],
            [Status])
     VALUES
           (@FullName  ,
            @Phone ,
            @Email ,
            @Title ,
            @Contents ,
            GETDATE()  ,
            @Status )







GO
/****** Object:  StoredProcedure [dbo].[Sp_Feedback_Reply]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Feedback_Reply]
@ID int,
@Status bit
as
update tbl_FeedBack set Status = @Status where ID = @ID






GO
/****** Object:  StoredProcedure [dbo].[Sp_Footer_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Footer_Insert]
  @Contents  nvarchar(max) 
  as
INSERT INTO [dbo].[Footer]
          (Contents)
     VALUES 
           (@Contents)














GO
/****** Object:  StoredProcedure [dbo].[Sp_Footer_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Footer_Update]
@ID int,
 @Contents  nvarchar(max) 
 as
UPDATE [dbo].[Footer]
   SET [Contents] = @Contents 
 WHERE ID = @ID














GO
/****** Object:  StoredProcedure [dbo].[Sp_Header_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Header_Insert]
  @Contents  nvarchar(max) 
  as
INSERT INTO [dbo].[Header]
          (Contents)
     VALUES 
           (@Contents)














GO
/****** Object:  StoredProcedure [dbo].[Sp_Header_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Header_Update]
@ID int,
 @Contents  nvarchar(max) 
 as
UPDATE [dbo].[Header]
   SET [Contents] = @Contents 
 WHERE ID = @ID














GO
/****** Object:  StoredProcedure [dbo].[Sp_HomeMenu_GetAll]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_HomeMenu_GetAll]
as
select mh.*,mnd.Name as ParentName from HomeMenu mh
LEFT JOIN HomeMenu mnd on mnd.ID = mh.ParentId















GO
/****** Object:  StoredProcedure [dbo].[Sp_HomeMenu_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_HomeMenu_Insert]
            @Name  nvarchar(255) ,
            @Link  nvarchar(255) ,
            @LinkSeo  varchar(255) ,
            @Icon  nvarchar(255) ,
            @ParentId  int,
			@Ordering int
		   as
INSERT INTO [dbo].[HomeMenu]
           ([Name],
            [Link],
            [LinkSeo],
            [Icon],
            [ParentId],
            [Level],
            [CreatedDate],
			[Ordering])
     VALUES
           (@Name,
            @Link ,
            @LinkSeo  ,
            @Icon ,
            @ParentId ,
            ( ISNULL(( SELECT ( Level + 1 )
                             FROM   HomeMenu
                             WHERE  ID = @ParentId
                           ), 1) ) ,
            getdate(),
		   @Ordering)
		



















GO
/****** Object:  StoredProcedure [dbo].[Sp_HomeMenu_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_HomeMenu_Update]
@ID int ,
  @Name  nvarchar(255) ,
     @Link  nvarchar(255) ,
       @LinkSeo  varchar(255) ,
       @Icon  nvarchar(255) ,
       @ParentId  int,
	   @Ordering int
as
UPDATE [dbo].[HomeMenu]
   SET [Name] = @Name ,
       [Link] = @Link  ,
       [LinkSeo] = @LinkSeo ,
       [Icon] = @Icon ,
       [ParentId] = @ParentId,
	   [Level] = ( ISNULL(( SELECT ( Level + 1 )
                             FROM   HomeMenu
                             WHERE  ID = @ParentId
                           ), 1) ),
						   [Ordering] = @Ordering
 WHERE ID = @ID














GO
/****** Object:  StoredProcedure [dbo].[Sp_InfoUseful_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Sp_InfoUseful_Insert]

@MetaTitle nvarchar(255),
@Desciption nvarchar(255),
@CreatedBy int,
@Contents nvarchar(Max),
@Status int,
@Tags nvarchar(500)
AS
insert into InfoUseful(MetaTitle,Desciption,CreatedBy,Contents,CreatedDate,Status,Tags)
values (@MetaTitle,@Desciption,@CreatedBy,@Contents,getdate(),@Status,@Tags)
















GO
/****** Object:  StoredProcedure [dbo].[Sp_InfoUseful_Publish]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Sp_InfoUseful_Publish] 
@ID int
as
Update InfoUseful set Status=2 where ID = @ID














GO
/****** Object:  StoredProcedure [dbo].[Sp_InfoUseful_UnPublish]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Sp_InfoUseful_UnPublish] 
@ID int
as
Update InfoUseful set Status=3 where ID = @ID















GO
/****** Object:  StoredProcedure [dbo].[Sp_InfoUseful_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Sp_InfoUseful_Update]
@ID int,
@MetaTitle nvarchar(255),
@Desciption nvarchar(255),
@ModifiedBy int,
@Contents nvarchar(Max),
@Status int,
@Tags nvarchar(500)

AS
update InfoUseful set
MetaTitle=@MetaTitle,
Desciption=@Desciption,
ModifiedDate=GETDATE(),
Contents=@Contents,
Status=@Status,Tags=@Tags
where  ID = @ID














GO
/****** Object:  StoredProcedure [dbo].[Sp_Logo_Active]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Logo_Active]
@ID int,
@Status bit
as
update Logo set Status = @Status where ID = @ID









GO
/****** Object:  StoredProcedure [dbo].[Sp_Logo_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Logo_Update]
@ID int,
@Name  nvarchar(150) ,
       @Image  varchar(150) ,
        @Type  int ,
       @Status  bit 
	  as
UPDATE [dbo].[Logo]
   SET [Name] = @Name ,
       [Image] = @Image ,
       [Type] = @Type ,
       [Status] = @Status
 WHERE ID= @ID 









GO
/****** Object:  StoredProcedure [dbo].[Sp_News_Delete]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Sp_News_Delete]
	@ID int
AS
BEGIN
	delete from News  where ID= @ID
END











GO
/****** Object:  StoredProcedure [dbo].[Sp_News_Detail]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Sp_News_Detail]
@ID int
as
select n.* from News n where n.ID = @ID

GO
/****** Object:  StoredProcedure [dbo].[Sp_News_Find]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Sp_News_Find]
@ID int 
AS
BEGIN
	select * from News
	where ID = @ID
END












GO
/****** Object:  StoredProcedure [dbo].[Sp_News_GetByCategory]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[Sp_News_GetByCategory]
@LinkSeo nvarchar(500)
as
declare @CateId int
set @CateId =(select ID from Category where LinkSeo = @LinkSeo)
select n.*,c.Name as CategoryNews from News n
left join Category c on c.ID = n.CategoryId  where n.CategoryId = @CateId and n.Status =2












GO
/****** Object:  StoredProcedure [dbo].[Sp_News_GetByTitle]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_News_GetByTitle]
@MetaTitle nvarchar(255)
as
select * from News 
where  MetaTitle = @MetaTitle
 










GO
/****** Object:  StoredProcedure [dbo].[Sp_News_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_News_Insert]
@MetaTitle nvarchar(255),
@Image varchar(255),
@Desciption nvarchar(255),
@CreatedBy int,
@Contents nvarchar(Max),
@Status int,
@Tags nvarchar(500)
AS
insert into News (MetaTitle,Image,Desciption,CreatedBy,Contents,CreatedDate,Status,Tags)
values (@MetaTitle,@Image,@Desciption,@CreatedBy,@Contents,getdate(),@Status,@Tags)

GO
/****** Object:  StoredProcedure [dbo].[Sp_News_ListAll]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_News_ListAll]
@MetaTitle nvarchar(255),
@Status int
as
SET @MetaTitle = dbo.Fn_UnsignCharacter(LOWER(@MetaTitle))
select * from News n
left join UserAdmin us on n.CreatedBy = us.ID
where n.Status = @Status  and (dbo.Fn_UnsignCharacter(LOWER(n.MetaTitle)) like '%'+ @MetaTitle + '%' or @MetaTitle ='') 

GO
/****** Object:  StoredProcedure [dbo].[Sp_News_Publish]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Sp_News_Publish] 
@ID int
as
Update News set Status=2 where ID = @ID














GO
/****** Object:  StoredProcedure [dbo].[Sp_News_UnPublish]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Sp_News_UnPublish] 
@ID int
as
Update News set Status=3 where ID = @ID













GO
/****** Object:  StoredProcedure [dbo].[SP_Order_GetAll]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_Order_GetAll]
@Status int,
@CustomerName nvarchar(100),
@TuNgay varchar(20),
@DenNgay varchar(20)
as
set @CustomerName = dbo.Fn_UnsignCharacter(LOWER(@CustomerName))
if @Status !=0 and @TuNgay !='' and @DenNgay !=''
	begin
	 select * from tbl_Order o where (dbo.Fn_UnsignCharacter(o.CustomerName) like '%' + @CustomerName +'%' or @CustomerName ='')
	  and (CONVERT(date,o.CreatedDate) BETWEEN CONVERT(date,@TuNgay) AND CONVERT(date,@DenNgay)) and o.Status = @Status
	end
else if  @Status = 0 and @TuNgay !='' and @DenNgay !=''
	begin
	 select * from tbl_Order o where dbo.Fn_UnsignCharacter(o.CustomerName) like '%' + @CustomerName +'%' or @CustomerName =''
	 and (CONVERT(date,o.CreatedDate) BETWEEN CONVERT(date,@TuNgay) AND CONVERT(date,@DenNgay))
	end
else if  @Status != 0 and @TuNgay !='' and @DenNgay =''
	begin
	 select * from tbl_Order o where (dbo.Fn_UnsignCharacter(o.CustomerName) like '%' + @CustomerName +'%' or @CustomerName ='')
	 and CONVERT(date,o.CreatedDate) = CONVERT(date,@TuNgay) and o.Status = @Status
	end
else if  @Status = 0 and @TuNgay !='' and @DenNgay =''
	begin
		select * from tbl_Order o where (dbo.Fn_UnsignCharacter(o.CustomerName) like '%' + @CustomerName +'%' or @CustomerName ='')
		and CONVERT(date,o.CreatedDate) = CONVERT(date,@TuNgay)  
	end
else if  @Status != 0 and @TuNgay ='' and @DenNgay =''
	begin
		select * from tbl_Order o where (dbo.Fn_UnsignCharacter(o.CustomerName) like '%' + @CustomerName +'%' or @CustomerName ='')
		and  o.Status = @Status 
	end
else
   begin
	 select * from tbl_Order o where dbo.Fn_UnsignCharacter(o.CustomerName) like '%' + @CustomerName +'%' or @CustomerName =''
	end









GO
/****** Object:  StoredProcedure [dbo].[Sp_Order_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Order_Update]
@ID int,
@Status int
as
update tbl_Order set Status = @Status where ID= @ID



GO
/****** Object:  StoredProcedure [dbo].[Sp_OrderDetail_GetList]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_OrderDetail_GetList]
@OrderID int
as
select od.*,p.Name as ProductName,p.Price,p.ProductCode,p.Sale from OrderDetail od inner join Product p on p.ID = od.ProductID where od.OrderID = @OrderID

GO
/****** Object:  StoredProcedure [dbo].[Sp_OrderDetail_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_OrderDetail_Insert]
 @ProductID  int ,
            @OrderID  int ,
            @Quantity  int  
		   as
INSERT INTO [dbo].[OrderDetail]
           ([ProductID],
            [OrderID],
            [Quantity])
     VALUES
           (@ProductID ,
            @OrderID  ,
            @Quantity  )










GO
/****** Object:  StoredProcedure [dbo].[Sp_Product_CheckCode]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_Product_CheckCode]
@ProductCode varchar(50)
as 
select * from Product where ProductCode  = UPPER(@ProductCode) 



GO
/****** Object:  StoredProcedure [dbo].[Sp_Product_Delete]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_Product_Delete]
@ID int
as
delete Product where ID = @ID









GO
/****** Object:  StoredProcedure [dbo].[Sp_Product_Find]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Sp_Product_Find]
@ID int 
AS
BEGIN
	select * from Product 
	where ID = @ID	
END












GO
/****** Object:  StoredProcedure [dbo].[Sp_Product_Find_Status]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Sp_Product_Find_Status]
@Status int 
AS
BEGIN
	select * from Product 
	where Status = @Status	
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Product_GetByCategory]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Sp_Product_GetByCategory]
@LinkSeo nvarchar(500)
as
declare @CateId int
set @CateId =(select ID from HomeMenu where LinkSeo =@LinkSeo)
select p.*,c.Name as MenuName from Product p
left join HomeMenu c on c.ID = p.CategoryId  where p.CategoryId = @CateId

GO
/****** Object:  StoredProcedure [dbo].[Sp_Product_ListAll]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Product_ListAll]
@Status INT,
@KeyWord nvarchar(255)
AS
SET @KeyWord = dbo.Fn_UnsignCharacter(LOWER(@KeyWord))
if @Status !=0
begin
select p.*,c.Name as CategoryName from Product p
left join HomeMenu c on c.ID = p.CategoryId
where p.Status = @Status AND (dbo.Fn_UnsignCharacter(LOWER(p.Name)) like '%'+ @KeyWord + '%' 
or @KeyWord ='' or p.ProductCode like '%'+ @KeyWord + '%')
end
else
begin
select p.*,c.Name as CategoryName from Product p
left join HomeMenu c on c.ID = p.CategoryId
where dbo.Fn_UnsignCharacter(LOWER(p.Name)) like '%'+ @KeyWord + '%' or @KeyWord ='' 
or p.ProductCode like '%'+ @KeyWord + '%'
end


GO
/****** Object:  StoredProcedure [dbo].[Sp_Product_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_Product_Update]
@ID int,
  @CategoryId  int ,
      @Name  nvarchar(255) ,
	  @ProductCode varchar(50),
       @Images  nvarchar(255) ,
     @Price  float ,
        @Sale  float ,
       @Description  nvarchar(max) ,
   @Status  int  
	  as
UPDATE [dbo].[Product]
   SET [CategoryId] = @CategoryId  ,
       [Name] = @Name  ,
	   [ProductCode] = @ProductCode,
       [Images] = @Images  ,
       [Price] = @Price  ,
       [Sale] = @Sale  ,
       [Description] = @Description ,
       [Status] = @Status   
 WHERE ID =@ID
GO
/****** Object:  StoredProcedure [dbo].[Sp_Product_Update_Images]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Product_Update_Images]
@ID INT,
@ImageMore xml
AS
UPDATE Product set ImageMore = @ImageMore where ID = @ID








GO
/****** Object:  StoredProcedure [dbo].[Sp_Video_GetAll]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Sp_Video_GetAll]
as
select * from Video









GO
/****** Object:  StoredProcedure [dbo].[Sp_Video_GetByName]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_Video_GetByName]
@keyword nvarchar(150)
as
SET @keyword = dbo.Fn_UnsignCharacter(LOWER(@keyword))
select V.*,U.FullName from Video v left join UserAdmin u ON v.CreatedBy = u.ID WHERE  dbo.Fn_UnsignCharacter(LOWER(v.Name)) like '%' + @keyword+'%' or Name =''









GO
/****** Object:  StoredProcedure [dbo].[Sp_Video_Insert]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Sp_Video_Insert]
            @Name  nvarchar(150) ,
            @Url  nvarchar(250) ,
            @Images  nvarchar(250) ,
            @Status  bit ,
            @CreatedBy  int ,
            @Type  int ,
            @Ordering  int,
			@IsShowPlay bit  
		   AS
INSERT INTO [dbo].[Video]
           ([Name],
            [Url],
            [Images],
            [Status],
            [CreatedDate],
            [CreatedBy],
            [Type],
            [Ordering],
			[IsShowPlay])
     VALUES
           (@Name,
            @Url  ,
            @Images ,
            @Status  ,
            GETDATE(),
            @CreatedBy ,
            @Type ,
            @Ordering ,
			@IsShowPlay )










GO
/****** Object:  StoredProcedure [dbo].[Sp_Video_Update]    Script Date: 9/28/2019 12:13:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Sp_Video_Update]
@ID int,
  @Name  nvarchar(150) ,
       @Status  bit ,
      @Ordering  int,
	  	@IsShowPlay bit    
	  AS
UPDATE [dbo].[Video]
   SET [Name] = @Name ,
       [Status] = @Status ,
       [Ordering] = @Ordering,
	   [IsShowPlay] =@IsShowPlay
 WHERE ID = @ID










GO
USE [master]
GO
ALTER DATABASE [QuaTang] SET  READ_WRITE 
GO
