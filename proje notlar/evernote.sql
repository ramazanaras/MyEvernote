USE [master]
GO
/****** Object:  Database [MyEvernoteDB]    Script Date: 8.10.2017 19:58:14 ******/
CREATE DATABASE [MyEvernoteDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyEvernoteDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MyEvernoteDB.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MyEvernoteDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MyEvernoteDB_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MyEvernoteDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyEvernoteDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyEvernoteDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyEvernoteDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyEvernoteDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MyEvernoteDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyEvernoteDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [MyEvernoteDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MyEvernoteDB] SET  MULTI_USER 
GO
ALTER DATABASE [MyEvernoteDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyEvernoteDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyEvernoteDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyEvernoteDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MyEvernoteDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyEvernoteDB', N'ON'
GO
USE [MyEvernoteDB]
GO
/****** Object:  User [ra]    Script Date: 8.10.2017 19:58:15 ******/
CREATE USER [ra] FOR LOGIN [ra] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 8.10.2017 19:58:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 8.10.2017 19:58:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](150) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[ModifiedUserName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 8.10.2017 19:58:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](300) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[ModifiedUserName] [nvarchar](30) NOT NULL,
	[Note_Id] [int] NULL,
	[Owner_Id] [int] NULL,
 CONSTRAINT [PK_dbo.Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EvernoteUsers]    Script Date: 8.10.2017 19:58:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EvernoteUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NULL,
	[Surname] [nvarchar](25) NULL,
	[UserName] [nvarchar](25) NOT NULL,
	[Email] [nvarchar](70) NOT NULL,
	[Password] [nvarchar](25) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[ActivateGuid] [uniqueidentifier] NOT NULL,
	[ProfileImageFileName] [nvarchar](70) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[ModifiedUserName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dbo.EvernoteUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Likes]    Script Date: 8.10.2017 19:58:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Likes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LikedUser_Id] [int] NULL,
	[Note_Id] [int] NULL,
 CONSTRAINT [PK_dbo.Likes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notes]    Script Date: 8.10.2017 19:58:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](60) NOT NULL,
	[Text] [nvarchar](250) NOT NULL,
	[IsDraft] [bit] NOT NULL,
	[LikeCount] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[ModifiedUserName] [nvarchar](30) NOT NULL,
	[Owner_Id] [int] NULL,
 CONSTRAINT [PK_dbo.Notes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201710021829282_InitialCreate', N'MyEvernote.DataAccessLayer.EntityFramework.DatabaseContext', 0x1F8B0800000000000400ED5D5B6FE3B8157E2FD0FF20E8B1C8DAB96077DBC0D9C5AC932C824E92C138BBE85BC048B4438C2E5E89CEC428FACBFAD09FD4BF504AA224DE454AB22733351618C4A4787878F89D73783987FBDF7FFF67F6F36B1C792F30CB519A5CF8279363DF8349908628595DF81BBCFCEEAFFECF3FFDF94FB3AB307EF57EAFBF3B2BBE232D93FCC27FC6787D3E9DE6C1338C413E895190A579BAC493208DA7204CA7A7C7C77F9B9E9C4C2121E1135A9E37FBB849308A61F983FC9CA74900D77803A2DB3484514ECB49CDA2A4EADD8118E66B10C00BFF767B45D84D520C27970083774100F3FC3DD8C26C724588E2ED75463EFE9C669F7CEF5D8400E17001A3A5EF8184340298F07FFE5B0E17384B93D5624D0A40F4B05D43F2DD124439A4E33A6F3FB71DE2F16931C469DBB026156C729CC68E044FCEA8CCA662F35E92F71B9912A956822A465D4AF6C29F030C5769B6F53DB1B3F37994151F72822FDB23984FEA76479EA2F6A8C10B8155F1DF9137DF447893C18B046E7006A223EFC3E62942C1DFE1F621FD04938B6413452CA7845752C71590A20F59BA8619DE7E844BCAFF4DE87B53BEDD546CD83463DA5423BB49F0D9A9EFDD91CEC153041B20305258E03483BFC2046664C4E1078031196C410396A2947A17FA7A4038827577047A44BB7CEF16BCBE87C90A3F5FF8DF1375BA46AF30AC0B2807BF2588E8226983B30D547068EEF512E64186D61566B47D9F58766EEE6B9EC14232F74D4F4439E103D17167AE8909404B342A29A2EF59516290C2D9383370075ED0AA848CC0CA1DD18CDCF73EC2A8ACCD9FD1BA324C93A2E6B155C0EB2C8D3FA6116DD2543C3E806C05311941AAAA5DA49B2C10D8994D5B3D376A7F41CA55F38B3607AD1FA6F53FEC44EB1FE02B36747ABA1B5B73935F6660D974FC4B4A400A126732EFD127384FC9EAA06B963AAC11D58BEED93E58B52156AD355BFD0D5B6DBAD486AD367BD61CA5714CB4536D6A69E56365F05A86D872C9D072952A3B6B62A7C0B39A97A2269438694B253E982A572EEE3F1313A6E4A236DF05961EA98F6AB9916B25AE149F0CF24554DACE0BD1AAD9C1230DF20D67C73BF10D072B6A56CFCA08F4B557A2FD541AB3912D456B6535C6A2FEC06C2F9AAF06990C96A4ABDD60DB1E8C8759633AB4E4F4FB11B6918B4D96ECA11B0BA5B7ECC7D1EA5CC50045865E7FDC8901FE00F2FC739A857B1FEE4DFE2EC0E8050EDD16103A618C92A1644A6608F67FDDA04616D5DFAE02CDD2258AE04D0C56F09AFCD18125CB593D78D1417B11D3CABFA7F7127DABD9C78DB52928FFADBC99B83368AA34DB83B6DE758FA03FA072DE2318A5C66F237A39FC7290AE9EBE6C7470F12E18A5181C8653110C3A1C0F5E2C776EA8D59C6897C93A38BECBF3344065EF0C4BED41073F8EAB24F48CA71E95B9ACCF4B88C524D0436B0236D2F585FF1749303A828D3D6809B6672F3CD1135F44EA7D72092388A15778C8E2826A0EF20084B2F9203209F912026E9815E802D19CCC075117946059135012A035884CAC0B8D2C15A860AA212FD65CC2354C0AEC9BE6C0A65FF64051EEBFE9461056976C6653064C668C715B411D22D4FB420610F5E18A3DC8D4476366D01E4F2627A22E590F54EDA975EC75B8ED964F7E93D8C5AF451F2A7DB312AF832C4433ABE3506B735BDEA8CFB49F78ED7AA3AF4C9DC76D84BACAAE0F1EED970179B5A4B2429FB0BE1A1FDEC221AF9373D28EBFF2A3C4026262FF6056DF4E030C9E400E8BF2F258525ACF118EE8922EA7BB03710C05DD05C4BC9146C502B5F5DD92339424C153A12B5C894025818EC6EDD64266A0B60E1D24D8F950D1E1A7BA8318DD6A4844A88208AD99F9E3E5C15CE330DF28EF7944E7D8B5006A386E242FF9D7AE250F43828580B874E147673172FEF8551EB8DE27777B6596E7063386912BFD7097EC7A8C59B35196076FE1A71D3C35331201FF0699981DB385847BC847DAF9C892317A6D2BBFCDB04E15D820059DA3B615696F21E8D442E7BDBBFC778F51EF551B28D10E555078735B7F3E5C0978F73D4020F5E6B771DA4DDD6C5AC564D282D95413BC39BB05EB354A564C30272DF1165524E7FCBB857B28635CD19806B922A2B1E1B6E909A7195841A1B6300821BC46598EEB4588EFCDC358FA4C5CA2687C6DDD9BB40A9167AD76C37593E26F7A926A1DD73AD1F9DA56C4E4DB5561F14A0140D93F2A9A7A45B02D8840A6387E9AA7D1264EF43B707D6B1A02C512A045F634B83046961257614F8F394867A931C5F6B4D8A37496185BEE4EAD3D4D57D16C6B65CAB3A98000E9AC42C2A074C0C3A3DA0AF33AA3370ADC559EC402EAEA666F17E6556C0647A22CB1A7D0C4E07103A90BEDE93041782C25A6D841D99883334EDB0C076A066A07D51D5B750D4BF7719C15DDF6F6F055BA963BD2E1C1FA7740E7E8E8E4D7C13B822877A2E28E5373F3DD80559E44DDC4E9283491362C91A6D09E8E1A522628E928D1D818960C2DB2A7D146BAB064DA5217675A87AEF0DEB42E75A25405AF0884AA427B3A7CF40A4B8CAF719096328C85939CF28B83492CE97E1993589D8DECC81456E7C2EE3650D36E98F1DBB580F9D30FE5B2881E720D59F9501296AB9BE264471DD8C41D76C9B2B2927349427D87CDF4EBC892F61ABDF7D41BB999A74988CABBB49BBC088569C2602C062A9E7839C342733C3E78D9C1D0EA0F14E3117BCFE92903C2C7808CF1B0FE4D614737E4C1E091EE0EFA9B68968A952D56CC88E6E2A0E75CB47446008BE662E44DC1C434E091A032C0F9B0048601E40DB91DF9D2E84D21622F4E87DEE40CF7389490CDB1699739E7AEB1DE94A3E12EC4DE1458FA7B19E96E4EFCA45937377774C25DDC8CDE8B75BFB6225D94559FF81E19FB0B0A8B4BB2C536C7302EB13759FC11CD235446B9D41FDC82042D618EABC069FFF4F8E4547898E5ED3C9232CDF33052DC2BAA5E4AE1276D0FD1DFA8906A677CB7EB6301EC1305C90BC8826790494F930C7F774449FA84A7DD2B0926243FF13849308349894930CA419F75C9D3EDD98EFF1718FEE00E4336D95949F3B407B685772E9E101EFEC64529D2C12F5C2065D6FC4D12C2D70BFF9F65B373EFE61F8F6DCB23EF3E2316FADC3BF6FE353CA9FBDBD344997EEBB4DD645EB7D3495C367DCE0F267C2386A04B67CB270A0E50EDA6DF6C46DC904A9BD903F5AB5012FD15DD57AB299D982932BADD264E48BE1F89AA15C079B2EEA9F44AA23FBA6B8D98293F16B362227C9F75839004DF87842A017E93A03F361095382406291B3519DE625E0ECB7E6A502C6D99E2F4EEAB3562FC19AA9BBB60DB0E7157FB729463E713B72939FB4EF9E5F3717AE430F7CA1936443DEF244FF81BCA0BB69AA68E34C1267DAD4F3E71EF24F17D4CB63E4251EECA7093B187C9EE9F1B3D56B2E8FE51D0119CF745D160BAB3D8031C6CD3C37701049A40EA9E73FD55804017062577D475EDBD3718ECDC01EC77C6F765FCED67FA0D997EFB1703C652F77D2EF4F6ADECD650DBABB917EE789BE59E98B828CE98F24984ADF14184EA4E97EC849F5232C7D5FEC590482FF6514141A24F634F14B4D5C9A812EBF5B242E6BCAE5132AECBF516E9F3DA2075C257AB7A3267558BDD516329F543CB551D28B3A077FC488308183E6BD49488CCC2A08D24199E833DD22B0C56ECA9D7BA8A60CC9153CB77F5D08236A7FC0B0E7CD41714860F96D34B263C6EAC810E7A25C11DB4BB1BCE8EDF42E8377B438D8EC33B0772CC14F1EECCFFC78AAC2B72B46A49146160090C38BFDE7C73932CD37A812170547F229E36430CC222BE2FC36809024CAA8B40BFF295D5DF41B4296F449E607893DC6FF07A83C99061FC147136BB58A698FA2F1F73E0799EDD97713CF91843206CA2E2B4FD3EF96583A2B0E1FB5A711AAE2151AC7FE8F9733197B838875E6D1B4A77696249888AAF59B63DC0781D1162F97DB200C53D8D3B6F04ACEFE10A04DB3AF44D4FA47B2278B1CF2E11586520CE298DB63DF949301CC6AF3FFD0FE752AD0ACE6D0000, N'6.1.3-40302')
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (1, N'Summers Park', N'76 Blair Mews', CAST(N'2017-10-02 21:29:30.020' AS DateTime), CAST(N'2017-10-02 21:29:30.020' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (2, N'Welch Cul de sac', N'13 White Cottages', CAST(N'2017-10-02 21:29:30.027' AS DateTime), CAST(N'2017-10-02 21:29:30.027' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (3, N'Jennings Valley', N'665 Robinson Rise', CAST(N'2017-10-02 21:29:30.057' AS DateTime), CAST(N'2017-10-02 21:29:30.057' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (4, N'Stuart Hill', N'465 Vaughan Gate', CAST(N'2017-10-02 21:29:30.057' AS DateTime), CAST(N'2017-10-02 21:29:30.057' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (5, N'Thorne Road', N'556 Whittaker Hill', CAST(N'2017-10-02 21:29:30.060' AS DateTime), CAST(N'2017-10-02 21:29:30.060' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (6, N'Mcfarlane Road', N'314 Cassidy Crescent', CAST(N'2017-10-02 21:29:30.067' AS DateTime), CAST(N'2017-10-02 21:29:30.067' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (7, N'Wright Square', N'888 Wilson Grove', CAST(N'2017-10-02 21:29:30.070' AS DateTime), CAST(N'2017-10-02 21:29:30.070' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (8, N'Fleming Way', N'365 Kenny Avenue', CAST(N'2017-10-02 21:29:30.073' AS DateTime), CAST(N'2017-10-02 21:29:30.073' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (9, N'Thorne Park', N'274 Whitehead Grove', CAST(N'2017-10-02 21:29:30.080' AS DateTime), CAST(N'2017-10-02 21:29:30.080' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (10, N'Lewis Close', N'123 Whittaker Park', CAST(N'2017-10-02 21:29:30.083' AS DateTime), CAST(N'2017-10-02 21:29:30.083' AS DateTime), N'muratbaseren')
INSERT [dbo].[Categories] ([Id], [Title], [Description], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (11, N'sdfs', N'ewrw', CAST(N'2017-10-08 12:12:27.427' AS DateTime), CAST(N'2017-10-08 12:12:27.427' AS DateTime), N'muratbaseren')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (1, N'Vivamus et felis ut augue laoreet mollis.', CAST(N'2017-04-03 10:02:30.243' AS DateTime), CAST(N'2016-11-29 11:54:17.163' AS DateTime), N'user4', 1, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (2, N'Ut eget neque porttitor, aliquet nibh at, sodales tellus.', CAST(N'2017-09-09 05:33:04.677' AS DateTime), CAST(N'2017-08-31 13:19:31.433' AS DateTime), N'kadirbaseren', 1, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (3, N'Suspendisse tempor dui id libero interdum, vulputate malesuada felis dapibus.', CAST(N'2016-11-17 04:01:37.383' AS DateTime), CAST(N'2017-01-30 09:58:34.400' AS DateTime), N'user6', 1, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (4, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', CAST(N'2016-12-15 05:01:55.197' AS DateTime), CAST(N'2017-04-17 05:39:41.350' AS DateTime), N'user4', 2, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (5, N'Phasellus tincidunt nunc eu orci vehicula bibendum.', CAST(N'2017-06-22 08:39:18.997' AS DateTime), CAST(N'2017-01-20 05:03:18.280' AS DateTime), N'user2', 2, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (6, N'Nullam et tellus posuere, consectetur ante eget, iaculis lorem.', CAST(N'2017-08-25 21:07:48.500' AS DateTime), CAST(N'2016-11-02 04:59:39.610' AS DateTime), N'user5', 2, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (7, N'Donec varius libero nec ligula congue volutpat.', CAST(N'2017-09-03 11:52:09.390' AS DateTime), CAST(N'2016-12-24 09:02:20.267' AS DateTime), N'kadirbaseren', 3, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (8, N'Proin at leo eget odio condimentum faucibus.', CAST(N'2017-07-21 23:59:13.227' AS DateTime), CAST(N'2017-01-10 16:01:59.063' AS DateTime), N'kadirbaseren', 3, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (9, N'Duis gravida erat et euismod consequat.', CAST(N'2017-01-14 20:56:11.247' AS DateTime), CAST(N'2017-08-21 06:20:25.273' AS DateTime), N'user1', 3, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (10, N'Vivamus porta neque non neque malesuada scelerisque.', CAST(N'2016-12-29 21:41:44.677' AS DateTime), CAST(N'2017-06-28 20:04:30.300' AS DateTime), N'user6', 3, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (11, N'Phasellus pharetra leo eu tempor molestie.', CAST(N'2016-10-17 04:32:05.593' AS DateTime), CAST(N'2017-02-11 09:20:18.680' AS DateTime), N'user1', 4, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (12, N'Etiam imperdiet nibh vitae sapien fringilla, vitae vulputate quam tincidunt.', CAST(N'2017-09-07 09:25:51.093' AS DateTime), CAST(N'2017-02-14 18:35:22.807' AS DateTime), N'muratbaseren', 4, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (13, N'Duis cursus risus et nisi suscipit sollicitudin.', CAST(N'2017-07-21 03:48:25.227' AS DateTime), CAST(N'2017-08-09 20:56:18.277' AS DateTime), N'user0', 4, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (14, N'Maecenas ac ligula interdum, faucibus leo in, faucibus quam.', CAST(N'2017-04-22 20:23:53.967' AS DateTime), CAST(N'2017-06-17 17:07:23.023' AS DateTime), N'user0', 5, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (15, N'
                    
                    Etiam scelerisque nisl sed urna dictum mattisssssssssRR', CAST(N'2016-10-24 08:10:55.697' AS DateTime), CAST(N'2017-10-08 17:03:34.610' AS DateTime), N'muratbaseren', 5, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (16, N'Maecenas ac ligula interdum, faucibus leo in, faucibus quam.', CAST(N'2017-04-13 07:41:34.517' AS DateTime), CAST(N'2017-07-10 02:28:08.740' AS DateTime), N'user0', 5, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (17, N'Etiam scelerisque nisl sed urna dictum mattis.', CAST(N'2017-02-01 19:24:53.630' AS DateTime), CAST(N'2016-12-23 20:56:04.733' AS DateTime), N'user0', 6, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (18, N'Nullam et enim congue, pretium eros id, pretium nibh.', CAST(N'2017-05-03 21:55:33.090' AS DateTime), CAST(N'2017-07-18 11:09:14.030' AS DateTime), N'kadirbaseren', 6, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (19, N'Suspendisse a lectus at nibh luctus faucibus.', CAST(N'2016-11-30 23:04:19.623' AS DateTime), CAST(N'2017-04-01 01:03:42.150' AS DateTime), N'user0', 6, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (20, N'Curabitur sed urna eget dui laoreet semper id sit amet erat.', CAST(N'2017-02-27 06:44:48.027' AS DateTime), CAST(N'2016-11-04 20:46:54.017' AS DateTime), N'user0', 7, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (21, N'Vivamus porta neque non neque malesuada scelerisque.', CAST(N'2017-05-17 17:53:13.160' AS DateTime), CAST(N'2017-05-10 08:52:53.890' AS DateTime), N'muratbaseren', 7, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (22, N'Duis eu augue sed lectus pellentesque rutrum non eu augue.', CAST(N'2017-05-10 01:31:26.607' AS DateTime), CAST(N'2016-10-12 11:20:13.973' AS DateTime), N'user6', 7, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (23, N'Phasellus tincidunt nunc eu orci vehicula bibendum.', CAST(N'2017-02-22 19:37:59.183' AS DateTime), CAST(N'2017-01-10 19:09:25.640' AS DateTime), N'user4', 7, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (24, N'Pellentesque accumsan mi eu velit ultrices varius.', CAST(N'2017-07-22 11:37:41.783' AS DateTime), CAST(N'2017-01-09 05:21:38.447' AS DateTime), N'user0', 8, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (25, N'Nam tincidunt orci vel pellentesque sagittis.', CAST(N'2017-02-09 23:59:44.643' AS DateTime), CAST(N'2017-02-21 14:29:28.387' AS DateTime), N'user6', 8, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (26, N'Nunc iaculis metus a tristique adipiscing.', CAST(N'2017-05-08 18:42:47.343' AS DateTime), CAST(N'2016-11-21 19:49:12.367' AS DateTime), N'user2', 8, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (27, N'Fusce scelerisque sapien ornare neque pharetra aliquam.', CAST(N'2017-08-02 11:05:42.660' AS DateTime), CAST(N'2017-03-22 15:00:40.847' AS DateTime), N'kadirbaseren', 9, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (28, N'Mauris nec est quis libero interdum condimentum.', CAST(N'2017-07-16 07:47:32.070' AS DateTime), CAST(N'2017-08-04 15:34:58.883' AS DateTime), N'kadirbaseren', 9, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (29, N'Vivamus scelerisque felis sed nisl feugiat, mattis consequat lacus pulvinar.', CAST(N'2017-07-28 14:21:06.333' AS DateTime), CAST(N'2017-06-08 01:42:33.290' AS DateTime), N'user2', 9, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (30, N'Ut eget neque porttitor, aliquet nibh at, sodales tellus.', CAST(N'2017-07-09 06:49:20.997' AS DateTime), CAST(N'2017-05-18 04:12:48.963' AS DateTime), N'user3', 9, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (31, N'Suspendisse tempor dui id libero interdum, vulputate malesuada felis dapibus.', CAST(N'2017-09-26 10:16:39.527' AS DateTime), CAST(N'2017-01-29 18:07:58.803' AS DateTime), N'user1', 10, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (32, N'Pellentesque commodo risus vitae orci pretium tincidunt.', CAST(N'2017-05-13 21:39:18.040' AS DateTime), CAST(N'2016-11-20 07:24:20.513' AS DateTime), N'user4', 10, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (33, N'Etiam imperdiet nibh vitae sapien fringilla, vitae vulputate quam tincidunt.', CAST(N'2017-06-11 07:33:57.920' AS DateTime), CAST(N'2016-10-22 03:21:12.993' AS DateTime), N'user6', 10, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (34, N'Proin at leo eget odio condimentum faucibus.', CAST(N'2017-01-26 18:28:17.247' AS DateTime), CAST(N'2017-09-07 12:47:23.433' AS DateTime), N'user1', 11, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (35, N'Maecenas ac ligula interdum, faucibus leo in, faucibus quam.', CAST(N'2017-07-17 00:20:24.270' AS DateTime), CAST(N'2017-03-25 04:46:35.513' AS DateTime), N'user2', 11, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (36, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', CAST(N'2017-09-16 09:45:51.033' AS DateTime), CAST(N'2017-04-11 16:05:49.157' AS DateTime), N'user3', 11, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (37, N'Donec volutpat turpis congue, suscipit dui eget, tempus lorem.', CAST(N'2017-08-29 09:25:15.460' AS DateTime), CAST(N'2016-10-22 16:32:14.367' AS DateTime), N'user1', 11, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (38, N'Suspendisse a diam vitae erat pretium pharetra.', CAST(N'2016-11-11 15:53:13.287' AS DateTime), CAST(N'2017-07-31 02:18:18.907' AS DateTime), N'user5', 12, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (39, N'Phasellus tincidunt nunc eu orci vehicula bibendum.', CAST(N'2017-08-14 01:29:04.283' AS DateTime), CAST(N'2017-07-15 19:19:40.780' AS DateTime), N'kadirbaseren', 12, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (40, N'Donec interdum velit a orci consectetur, non mollis diam hendrerit.', CAST(N'2017-03-22 08:24:17.223' AS DateTime), CAST(N'2017-05-30 21:36:53.797' AS DateTime), N'muratbaseren', 12, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (41, N'Fusce sollicitudin magna ut risus ullamcorper, ut ullamcorper elit adipiscing.', CAST(N'2017-06-23 04:12:00.617' AS DateTime), CAST(N'2016-10-25 13:42:56.607' AS DateTime), N'user5', 12, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (42, N'Nunc iaculis metus a tristique adipiscing.', CAST(N'2016-12-16 15:42:54.847' AS DateTime), CAST(N'2016-10-23 22:36:39.727' AS DateTime), N'kadirbaseren', 13, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (43, N'Pellentesque accumsan mi eu velit ultrices varius.', CAST(N'2017-02-14 16:19:48.030' AS DateTime), CAST(N'2017-06-02 11:51:36.430' AS DateTime), N'user1', 13, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (44, N'In laoreet justo et condimentum bibendum.', CAST(N'2017-02-13 01:16:18.193' AS DateTime), CAST(N'2017-05-29 14:52:16.707' AS DateTime), N'user5', 13, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (45, N'Fusce scelerisque sapien ornare neque pharetra aliquam.', CAST(N'2017-08-26 09:53:30.953' AS DateTime), CAST(N'2017-05-10 02:46:53.877' AS DateTime), N'user5', 14, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (46, N'Ut eget neque porttitor, aliquet nibh at, sodales tellus.', CAST(N'2016-11-27 10:17:49.930' AS DateTime), CAST(N'2017-01-07 12:06:59.047' AS DateTime), N'muratbaseren', 14, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (47, N'Nulla malesuada massa eget nunc accumsan placerat.', CAST(N'2017-01-16 05:41:40.663' AS DateTime), CAST(N'2017-10-02 16:53:41.897' AS DateTime), N'user5', 14, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (48, N'Ut eget neque porttitor, aliquet nibh at, sodales tellus.', CAST(N'2017-09-06 19:54:19.817' AS DateTime), CAST(N'2017-06-22 09:56:21.500' AS DateTime), N'user3', 15, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (49, N'Mauris nec est quis libero interdum condimentum.', CAST(N'2017-02-25 07:16:30.777' AS DateTime), CAST(N'2017-08-29 14:45:45.153' AS DateTime), N'muratbaseren', 15, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (50, N'Donec dignissim massa nec urna porttitor facilisis.', CAST(N'2017-08-20 19:43:20.297' AS DateTime), CAST(N'2016-12-30 07:27:01.923' AS DateTime), N'user0', 15, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (51, N'Duis gravida erat et euismod consequat.', CAST(N'2017-09-08 13:17:14.783' AS DateTime), CAST(N'2017-03-24 15:36:16.407' AS DateTime), N'user2', 16, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (52, N'Etiam tincidunt augue vestibulum, tempus mi ac, facilisis lectus.', CAST(N'2017-01-01 06:53:14.490' AS DateTime), CAST(N'2016-10-27 04:29:18.840' AS DateTime), N'user0', 16, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (53, N'In facilisis dui sed odio dictum laoreet.', CAST(N'2017-05-25 12:55:34.963' AS DateTime), CAST(N'2017-09-13 05:41:33.453' AS DateTime), N'user2', 16, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (54, N'Nam vitae purus gravida, dignissim lacus in, venenatis elit.', CAST(N'2017-01-28 06:03:23.773' AS DateTime), CAST(N'2017-09-17 07:31:49.717' AS DateTime), N'user5', 16, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (55, N'Proin at leo eget odio condimentum faucibus.', CAST(N'2017-01-18 16:45:27.347' AS DateTime), CAST(N'2017-02-20 14:00:13.973' AS DateTime), N'user2', 17, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (56, N'Nunc vel quam laoreet, congue erat a, suscipit neque.', CAST(N'2017-06-13 08:44:08.557' AS DateTime), CAST(N'2016-12-01 00:52:46.183' AS DateTime), N'user6', 17, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (57, N'Suspendisse pharetra massa sed leo commodo malesuada.', CAST(N'2016-12-10 20:07:05.263' AS DateTime), CAST(N'2017-06-29 06:15:05.150' AS DateTime), N'kadirbaseren', 17, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (58, N'Vestibulum in enim nec eros faucibus elementum sed vitae dolor.', CAST(N'2017-04-11 06:32:56.037' AS DateTime), CAST(N'2017-07-08 12:02:33.407' AS DateTime), N'kadirbaseren', 17, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (59, N'Ut rutrum massa sit amet tortor lacinia, id mollis massa bibendum.', CAST(N'2017-03-01 03:53:49.547' AS DateTime), CAST(N'2016-10-21 19:20:37.627' AS DateTime), N'muratbaseren', 18, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (60, N'Nullam consectetur enim in sem varius gravida.', CAST(N'2017-09-23 18:30:35.780' AS DateTime), CAST(N'2016-11-24 22:25:30.827' AS DateTime), N'user3', 18, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (61, N'Nulla malesuada massa eget nunc accumsan placerat.', CAST(N'2017-04-13 04:29:15.430' AS DateTime), CAST(N'2017-04-14 01:04:33.483' AS DateTime), N'user5', 18, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (62, N'Duis cursus risus et nisi suscipit sollicitudin.', CAST(N'2016-11-14 13:55:38.697' AS DateTime), CAST(N'2016-11-28 09:36:21.767' AS DateTime), N'kadirbaseren', 18, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (63, N'Vivamus porta neque non neque malesuada scelerisque.', CAST(N'2017-07-28 12:48:02.037' AS DateTime), CAST(N'2017-08-07 05:49:31.180' AS DateTime), N'user0', 19, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (64, N'Nullam et tellus posuere, consectetur ante eget, iaculis lorem.', CAST(N'2017-03-05 16:21:17.657' AS DateTime), CAST(N'2017-08-21 08:36:34.567' AS DateTime), N'user2', 19, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (65, N'Mauris nec est quis libero interdum condimentum.', CAST(N'2016-12-01 19:38:21.993' AS DateTime), CAST(N'2017-07-23 01:43:51.833' AS DateTime), N'muratbaseren', 19, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (66, N'Donec volutpat turpis congue, suscipit dui eget, tempus lorem.', CAST(N'2017-05-07 20:27:27.793' AS DateTime), CAST(N'2017-03-19 13:49:18.203' AS DateTime), N'user1', 19, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (67, N'Praesent id magna sed massa hendrerit pellentesque ut quis enim.', CAST(N'2017-02-06 16:23:06.087' AS DateTime), CAST(N'2017-04-02 04:54:55.270' AS DateTime), N'user1', 20, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (68, N'Vivamus et felis ut augue laoreet mollis.', CAST(N'2016-11-23 17:11:19.847' AS DateTime), CAST(N'2016-11-01 06:59:48.630' AS DateTime), N'user0', 20, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (69, N'Nulla a ligula laoreet, viverra purus vel, suscipit enim.', CAST(N'2016-12-05 10:40:39.013' AS DateTime), CAST(N'2017-01-31 13:06:43.767' AS DateTime), N'user3', 20, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (70, N'Donec varius libero nec ligula congue volutpat.', CAST(N'2017-04-28 14:29:25.360' AS DateTime), CAST(N'2017-02-22 09:33:00.060' AS DateTime), N'user5', 20, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (71, N'Donec varius libero nec ligula congue volutpat.', CAST(N'2017-02-12 08:58:01.640' AS DateTime), CAST(N'2016-11-13 22:55:48.507' AS DateTime), N'user4', 21, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (72, N'Morbi sit amet libero vitae augue porttitor tempus.', CAST(N'2017-08-28 04:16:42.537' AS DateTime), CAST(N'2017-02-27 11:01:14.650' AS DateTime), N'user3', 21, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (73, N'Etiam scelerisque nisl sed urna dictum mattis.', CAST(N'2017-01-31 07:34:05.227' AS DateTime), CAST(N'2017-06-06 00:18:55.040' AS DateTime), N'user3', 21, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (74, N'Suspendisse tempor dui id libero interdum, vulputate malesuada felis dapibus.', CAST(N'2017-05-31 14:12:17.377' AS DateTime), CAST(N'2016-10-05 13:49:18.067' AS DateTime), N'user1', 22, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (75, N'Morbi sit amet nibh eget eros tempor mollis vel nec lacus.', CAST(N'2017-03-02 18:02:03.197' AS DateTime), CAST(N'2017-03-16 08:45:52.393' AS DateTime), N'kadirbaseren', 22, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (76, N'Phasellus pharetra leo eu tempor molestie.', CAST(N'2017-06-15 23:52:26.797' AS DateTime), CAST(N'2017-09-15 19:47:05.457' AS DateTime), N'user4', 22, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (77, N'Nulla malesuada massa eget nunc accumsan placerat.', CAST(N'2017-01-17 04:56:13.353' AS DateTime), CAST(N'2017-02-04 16:44:32.160' AS DateTime), N'user2', 23, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (78, N'Nulla hendrerit ligula in eros suscipit sagittis.', CAST(N'2017-03-23 12:59:19.530' AS DateTime), CAST(N'2017-06-11 02:51:24.937' AS DateTime), N'user2', 23, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (79, N'Nunc vel quam laoreet, congue erat a, suscipit neque.', CAST(N'2016-11-27 00:00:24.507' AS DateTime), CAST(N'2017-06-03 16:52:35.827' AS DateTime), N'user4', 23, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (80, N'Nunc ac ipsum sed purus consectetur sodales.', CAST(N'2017-08-01 05:06:13.373' AS DateTime), CAST(N'2017-06-05 00:39:33.110' AS DateTime), N'user3', 23, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (81, N'Morbi bibendum nulla non lectus posuere convallis.', CAST(N'2016-11-30 09:26:01.443' AS DateTime), CAST(N'2016-12-13 22:32:11.920' AS DateTime), N'kadirbaseren', 24, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (82, N'Sed adipiscing dolor eget turpis eleifend eleifend.', CAST(N'2017-07-04 07:00:08.720' AS DateTime), CAST(N'2016-11-25 07:47:32.547' AS DateTime), N'user6', 24, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (83, N'Fusce scelerisque sapien ornare neque pharetra aliquam.', CAST(N'2017-01-02 03:45:58.667' AS DateTime), CAST(N'2016-11-01 03:55:38.187' AS DateTime), N'user0', 24, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (84, N'Phasellus et dui vitae mi laoreet malesuada.', CAST(N'2017-02-04 12:41:18.953' AS DateTime), CAST(N'2017-02-21 14:35:40.823' AS DateTime), N'user4', 25, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (85, N'Nullam et enim congue, pretium eros id, pretium nibh.', CAST(N'2017-07-18 22:34:54.907' AS DateTime), CAST(N'2017-09-05 05:56:28.337' AS DateTime), N'user1', 25, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (86, N'Duis eu augue sed lectus pellentesque rutrum non eu augue.', CAST(N'2017-02-08 14:01:38.113' AS DateTime), CAST(N'2017-01-15 18:38:33.227' AS DateTime), N'user3', 25, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (87, N'Duis cursus risus et nisi suscipit sollicitudin.', CAST(N'2017-02-12 11:44:45.630' AS DateTime), CAST(N'2017-05-18 22:25:54.087' AS DateTime), N'user5', 25, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (88, N'Nulla malesuada massa eget nunc accumsan placerat.', CAST(N'2017-03-14 06:55:54.397' AS DateTime), CAST(N'2017-01-28 21:05:01.127' AS DateTime), N'muratbaseren', 26, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (89, N'Curabitur sed lorem a dui consequat congue.', CAST(N'2016-11-21 04:24:42.693' AS DateTime), CAST(N'2017-08-29 01:02:08.657' AS DateTime), N'user0', 26, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (90, N'Nulla hendrerit ligula in eros suscipit sagittis.', CAST(N'2017-01-18 02:14:48.127' AS DateTime), CAST(N'2017-01-24 15:59:04.880' AS DateTime), N'user0', 26, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (91, N'Vestibulum in enim nec eros faucibus elementum sed vitae dolor.', CAST(N'2017-05-08 15:15:20.250' AS DateTime), CAST(N'2016-11-12 16:24:37.540' AS DateTime), N'user3', 27, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (92, N'Nulla a ligula laoreet, viverra purus vel, suscipit enim.', CAST(N'2017-04-07 04:36:45.300' AS DateTime), CAST(N'2017-06-04 22:45:50.140' AS DateTime), N'user4', 27, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (93, N'Nullam et enim congue, pretium eros id, pretium nibh.', CAST(N'2016-11-05 06:06:31.053' AS DateTime), CAST(N'2017-03-06 22:57:10.687' AS DateTime), N'muratbaseren', 27, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (94, N'Vivamus porta neque non neque malesuada scelerisque.', CAST(N'2016-12-15 15:34:57.513' AS DateTime), CAST(N'2017-04-18 10:11:58.323' AS DateTime), N'user2', 28, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (95, N'Etiam tincidunt augue vestibulum, tempus mi ac, facilisis lectus.', CAST(N'2017-04-01 18:26:01.027' AS DateTime), CAST(N'2017-07-06 20:50:44.813' AS DateTime), N'kadirbaseren', 28, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (96, N'Pellentesque commodo risus vitae orci pretium tincidunt.', CAST(N'2016-11-02 21:49:00.187' AS DateTime), CAST(N'2016-10-13 02:33:27.227' AS DateTime), N'muratbaseren', 28, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (97, N'Donec interdum velit a orci consectetur, non mollis diam hendrerit.', CAST(N'2017-06-29 05:51:21.553' AS DateTime), CAST(N'2017-06-16 01:04:07.627' AS DateTime), N'user6', 28, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (98, N'Curabitur sed urna eget dui laoreet semper id sit amet erat.', CAST(N'2017-05-28 07:08:04.080' AS DateTime), CAST(N'2016-11-12 03:24:23.590' AS DateTime), N'user6', 29, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (99, N'Suspendisse tempor dui id libero interdum, vulputate malesuada felis dapibus.', CAST(N'2017-07-14 10:05:03.600' AS DateTime), CAST(N'2017-02-03 16:29:36.283' AS DateTime), N'user0', 29, 3)
GO
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (100, N'Curabitur sed urna eget dui laoreet semper id sit amet erat.', CAST(N'2017-04-15 07:23:53.050' AS DateTime), CAST(N'2017-05-24 00:34:14.627' AS DateTime), N'user2', 29, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (101, N'Suspendisse laoreet ligula ac dolor egestas gravida.', CAST(N'2016-10-30 18:54:55.700' AS DateTime), CAST(N'2017-01-12 12:43:52.947' AS DateTime), N'user4', 30, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (102, N'Etiam imperdiet nibh vitae sapien fringilla, vitae vulputate quam tincidunt.', CAST(N'2017-05-19 23:56:28.030' AS DateTime), CAST(N'2017-08-08 23:10:39.007' AS DateTime), N'user1', 30, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (103, N'Suspendisse tempor dui id libero interdum, vulputate malesuada felis dapibus.', CAST(N'2017-06-01 14:11:32.490' AS DateTime), CAST(N'2017-03-21 05:36:50.833' AS DateTime), N'user1', 30, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (104, N'In laoreet justo et condimentum bibendum.', CAST(N'2017-07-03 11:16:59.013' AS DateTime), CAST(N'2016-10-17 22:27:32.293' AS DateTime), N'user4', 31, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (105, N'Fusce scelerisque sapien ornare neque pharetra aliquam.', CAST(N'2016-11-09 08:12:48.457' AS DateTime), CAST(N'2017-02-15 11:55:44.577' AS DateTime), N'user1', 31, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (106, N'Phasellus tincidunt nunc eu orci vehicula bibendum.', CAST(N'2017-07-29 04:47:49.157' AS DateTime), CAST(N'2016-10-09 17:55:39.000' AS DateTime), N'user2', 31, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (107, N'Pellentesque non risus sed odio dapibus gravida quis non dolor.', CAST(N'2017-06-20 09:07:36.103' AS DateTime), CAST(N'2017-09-03 18:26:05.403' AS DateTime), N'user4', 32, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (108, N'In eu justo sed est faucibus tincidunt non quis ligula.', CAST(N'2017-06-07 00:50:10.733' AS DateTime), CAST(N'2017-07-03 05:29:40.570' AS DateTime), N'user6', 32, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (109, N'Morbi sit amet nibh eget eros tempor mollis vel nec lacus.', CAST(N'2017-09-16 20:56:41.700' AS DateTime), CAST(N'2017-07-23 13:53:07.400' AS DateTime), N'user2', 32, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (110, N'Fusce scelerisque sapien ornare neque pharetra aliquam.', CAST(N'2017-05-12 23:41:25.633' AS DateTime), CAST(N'2017-01-29 00:54:34.250' AS DateTime), N'muratbaseren', 32, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (111, N'Curabitur sed urna eget dui laoreet semper id sit amet erat.', CAST(N'2016-10-17 22:52:29.277' AS DateTime), CAST(N'2017-08-13 23:45:06.023' AS DateTime), N'user0', 33, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (112, N'Morbi sit amet libero vitae augue porttitor tempus.', CAST(N'2016-10-22 01:07:30.247' AS DateTime), CAST(N'2017-05-15 23:59:13.627' AS DateTime), N'user5', 33, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (113, N'Pellentesque commodo risus vitae orci pretium tincidunt.', CAST(N'2017-02-09 16:20:39.810' AS DateTime), CAST(N'2017-05-24 13:08:06.967' AS DateTime), N'user1', 33, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (114, N'Vestibulum in enim nec eros faucibus elementum sed vitae dolor.', CAST(N'2017-01-28 03:59:28.487' AS DateTime), CAST(N'2016-12-20 00:48:48.190' AS DateTime), N'user6', 34, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (115, N'Nunc iaculis metus a tristique adipiscing.', CAST(N'2017-06-11 03:47:49.407' AS DateTime), CAST(N'2017-06-28 00:24:12.357' AS DateTime), N'user5', 34, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (116, N'Nunc ac ipsum sed purus consectetur sodales.', CAST(N'2016-10-18 09:34:20.040' AS DateTime), CAST(N'2017-03-16 04:30:32.353' AS DateTime), N'user1', 34, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (117, N'Suspendisse laoreet ligula ac dolor egestas gravida.', CAST(N'2016-10-13 00:49:33.513' AS DateTime), CAST(N'2017-06-17 06:28:13.223' AS DateTime), N'user4', 34, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (118, N'Proin at leo eget odio condimentum faucibus.', CAST(N'2017-04-11 09:47:34.677' AS DateTime), CAST(N'2017-03-09 19:35:30.283' AS DateTime), N'user2', 35, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (119, N'Phasellus pharetra leo eu tempor molestie.', CAST(N'2017-06-24 12:50:05.833' AS DateTime), CAST(N'2017-03-08 22:20:33.233' AS DateTime), N'user2', 35, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (120, N'Phasellus tincidunt nunc eu orci vehicula bibendum.', CAST(N'2017-06-05 20:20:44.513' AS DateTime), CAST(N'2017-03-06 12:08:20.683' AS DateTime), N'user6', 35, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (121, N'Praesent id magna sed massa hendrerit pellentesque ut quis enim.', CAST(N'2017-08-15 03:42:26.150' AS DateTime), CAST(N'2016-10-31 22:03:51.547' AS DateTime), N'user5', 36, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (122, N'Curabitur sed urna eget dui laoreet semper id sit amet erat.', CAST(N'2017-05-23 12:59:55.750' AS DateTime), CAST(N'2017-08-29 02:46:08.407' AS DateTime), N'user4', 36, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (123, N'Vestibulum in enim nec eros faucibus elementum sed vitae dolor.', CAST(N'2017-02-08 03:26:51.857' AS DateTime), CAST(N'2017-08-03 04:20:11.077' AS DateTime), N'user2', 36, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (124, N'Phasellus pharetra leo eu tempor molestie.', CAST(N'2017-05-19 05:44:50.447' AS DateTime), CAST(N'2017-06-26 22:31:40.857' AS DateTime), N'kadirbaseren', 37, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (125, N'Donec volutpat turpis congue, suscipit dui eget, tempus lorem.', CAST(N'2017-09-10 13:23:23.103' AS DateTime), CAST(N'2017-03-04 12:05:01.317' AS DateTime), N'user1', 37, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (126, N'Phasellus tincidunt nunc eu orci vehicula bibendum.', CAST(N'2017-08-27 05:14:15.937' AS DateTime), CAST(N'2017-04-19 09:23:25.897' AS DateTime), N'user2', 37, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (127, N'Nullam tincidunt arcu sit amet nisl tempor, ac dictum odio tincidunt.', CAST(N'2017-10-02 13:01:40.527' AS DateTime), CAST(N'2017-06-15 02:44:57.610' AS DateTime), N'user6', 38, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (128, N'Vivamus porta neque non neque malesuada scelerisque.', CAST(N'2016-12-13 08:38:57.833' AS DateTime), CAST(N'2017-04-25 14:07:39.390' AS DateTime), N'user6', 38, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (129, N'Ut rutrum massa sit amet tortor lacinia, id mollis massa bibendum.', CAST(N'2017-05-19 20:38:20.673' AS DateTime), CAST(N'2016-12-10 03:16:44.137' AS DateTime), N'user3', 38, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (130, N'Pellentesque non risus sed odio dapibus gravida quis non dolor.', CAST(N'2017-04-15 15:08:20.373' AS DateTime), CAST(N'2016-10-30 04:57:18.293' AS DateTime), N'user2', 38, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (131, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', CAST(N'2017-07-06 07:39:27.487' AS DateTime), CAST(N'2016-11-24 10:59:51.263' AS DateTime), N'user1', 39, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (132, N'Pellentesque non risus sed odio dapibus gravida quis non dolor.', CAST(N'2017-04-01 10:20:11.770' AS DateTime), CAST(N'2016-11-12 15:14:47.393' AS DateTime), N'user4', 39, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (133, N'Vivamus et felis ut augue laoreet mollis.', CAST(N'2016-11-30 12:21:36.320' AS DateTime), CAST(N'2016-12-27 06:34:54.843' AS DateTime), N'muratbaseren', 39, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (134, N'Donec tincidunt felis sit amet rutrum faucibus.', CAST(N'2016-11-14 17:29:27.840' AS DateTime), CAST(N'2017-07-31 16:27:16.727' AS DateTime), N'user4', 40, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (135, N'Nullam et tellus posuere, consectetur ante eget, iaculis lorem.', CAST(N'2016-11-10 14:35:30.107' AS DateTime), CAST(N'2017-07-26 17:03:27.510' AS DateTime), N'user6', 40, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (136, N'Curabitur sed lorem a dui consequat congue.', CAST(N'2017-05-11 14:33:09.087' AS DateTime), CAST(N'2017-07-12 17:38:08.223' AS DateTime), N'user0', 40, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (137, N'Morbi et mi id sapien consequat rutrum in quis risus.', CAST(N'2017-08-19 13:25:26.643' AS DateTime), CAST(N'2017-03-13 00:18:38.230' AS DateTime), N'user2', 40, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (138, N'Suspendisse tempor dui id libero interdum, vulputate malesuada felis dapibus.', CAST(N'2017-09-04 13:43:38.737' AS DateTime), CAST(N'2017-08-07 12:24:07.940' AS DateTime), N'user2', 41, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (139, N'Vivamus facilisis lectus in suscipit facilisis.', CAST(N'2017-03-17 17:26:01.303' AS DateTime), CAST(N'2016-11-26 17:35:51.900' AS DateTime), N'user6', 41, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (140, N'Vivamus porta neque non neque malesuada scelerisque.', CAST(N'2017-06-16 01:11:51.373' AS DateTime), CAST(N'2017-03-13 20:32:43.980' AS DateTime), N'kadirbaseren', 41, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (141, N'Maecenas ac ligula interdum, faucibus leo in, faucibus quam.', CAST(N'2017-07-11 01:12:11.360' AS DateTime), CAST(N'2017-09-23 20:53:05.997' AS DateTime), N'user2', 42, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (142, N'Vestibulum in enim nec eros faucibus elementum sed vitae dolor.', CAST(N'2017-09-02 13:02:45.940' AS DateTime), CAST(N'2017-03-20 06:42:13.607' AS DateTime), N'kadirbaseren', 42, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (143, N'Maecenas sed leo mollis, egestas mauris vitae, porta risus.', CAST(N'2017-01-25 17:08:52.743' AS DateTime), CAST(N'2017-03-20 00:05:48.630' AS DateTime), N'user6', 42, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (144, N'Nulla a ligula laoreet, viverra purus vel, suscipit enim.', CAST(N'2017-03-15 22:10:25.290' AS DateTime), CAST(N'2017-06-29 03:13:07.060' AS DateTime), N'user3', 43, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (145, N'Vivamus scelerisque felis sed nisl feugiat, mattis consequat lacus pulvinar.', CAST(N'2017-03-18 16:19:32.877' AS DateTime), CAST(N'2017-01-04 21:07:44.097' AS DateTime), N'user0', 43, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (146, N'Suspendisse pharetra massa sed leo commodo malesuada.', CAST(N'2017-02-19 10:01:52.687' AS DateTime), CAST(N'2017-05-17 16:01:26.160' AS DateTime), N'user4', 43, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (147, N'Nullam et enim congue, pretium eros id, pretium nibh.', CAST(N'2017-03-09 04:04:26.063' AS DateTime), CAST(N'2017-02-15 16:33:50.713' AS DateTime), N'muratbaseren', 44, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (148, N'Vivamus et felis ut augue laoreet mollis.', CAST(N'2017-05-03 18:13:15.273' AS DateTime), CAST(N'2017-09-12 06:29:41.177' AS DateTime), N'muratbaseren', 44, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (149, N'Maecenas sed leo mollis, egestas mauris vitae, porta risus.', CAST(N'2017-06-15 14:15:31.153' AS DateTime), CAST(N'2017-06-05 04:45:09.677' AS DateTime), N'user5', 44, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (150, N'Vivamus facilisis lectus in suscipit facilisis.', CAST(N'2016-11-10 22:09:46.897' AS DateTime), CAST(N'2017-07-09 17:48:13.203' AS DateTime), N'user0', 44, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (151, N'Nunc vel quam laoreet, congue erat a, suscipit neque.', CAST(N'2017-01-01 22:49:26.633' AS DateTime), CAST(N'2016-10-20 23:13:24.940' AS DateTime), N'user5', 45, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (152, N'Etiam scelerisque nisl sed urna dictum mattis.', CAST(N'2017-07-27 14:34:32.697' AS DateTime), CAST(N'2016-12-25 18:01:44.743' AS DateTime), N'muratbaseren', 45, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (153, N'Vestibulum in enim nec eros faucibus elementum sed vitae dolor.', CAST(N'2016-11-15 17:26:36.987' AS DateTime), CAST(N'2017-05-06 20:39:19.860' AS DateTime), N'user4', 45, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (154, N'Maecenas sed leo mollis, egestas mauris vitae, porta risus.', CAST(N'2017-03-05 04:41:18.320' AS DateTime), CAST(N'2016-10-15 09:39:25.610' AS DateTime), N'user1', 45, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (155, N'Suspendisse tempor dui id libero interdum, vulputate malesuada felis dapibus.', CAST(N'2017-02-18 09:56:51.100' AS DateTime), CAST(N'2017-01-05 09:52:16.430' AS DateTime), N'user6', 46, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (156, N'Praesent hendrerit odio quis arcu feugiat luctus.', CAST(N'2016-10-03 12:29:07.153' AS DateTime), CAST(N'2016-12-04 14:12:06.537' AS DateTime), N'user6', 46, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (157, N'Pellentesque commodo risus vitae orci pretium tincidunt.', CAST(N'2016-12-20 09:11:10.737' AS DateTime), CAST(N'2017-02-09 09:02:55.983' AS DateTime), N'user6', 46, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (158, N'Donec dignissim massa nec urna porttitor facilisis.', CAST(N'2016-11-16 07:04:49.507' AS DateTime), CAST(N'2017-02-13 21:52:27.913' AS DateTime), N'user6', 47, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (159, N'Nunc iaculis metus a tristique adipiscing.', CAST(N'2017-09-15 04:58:29.977' AS DateTime), CAST(N'2017-05-10 19:58:32.847' AS DateTime), N'user2', 47, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (160, N'Praesent non tortor dictum, interdum ligula vel, dapibus tortor.', CAST(N'2017-03-30 14:10:05.407' AS DateTime), CAST(N'2017-05-01 22:06:00.250' AS DateTime), N'user5', 47, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (161, N'Etiam scelerisque nisl sed urna dictum mattis.', CAST(N'2017-04-01 16:41:13.517' AS DateTime), CAST(N'2017-05-27 02:24:57.520' AS DateTime), N'user3', 48, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (162, N'In eu justo sed est faucibus tincidunt non quis ligula.', CAST(N'2017-03-02 00:18:15.757' AS DateTime), CAST(N'2017-03-20 22:59:44.797' AS DateTime), N'kadirbaseren', 48, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (163, N'Sed adipiscing dolor eget turpis eleifend eleifend.', CAST(N'2017-08-03 17:55:34.197' AS DateTime), CAST(N'2017-01-06 22:54:07.130' AS DateTime), N'user0', 48, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (164, N'Nunc iaculis metus a tristique adipiscing.', CAST(N'2016-11-20 07:35:28.780' AS DateTime), CAST(N'2017-04-12 15:31:54.473' AS DateTime), N'user6', 48, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (165, N'Sed dignissim augue eget orci vulputate, a pellentesque odio facilisis.', CAST(N'2017-08-06 13:46:31.553' AS DateTime), CAST(N'2017-09-21 13:13:59.923' AS DateTime), N'kadirbaseren', 49, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (166, N'Nunc vel quam laoreet, congue erat a, suscipit neque.', CAST(N'2016-12-11 12:21:31.100' AS DateTime), CAST(N'2017-08-25 20:45:51.570' AS DateTime), N'user1', 49, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (167, N'Ut rutrum massa sit amet tortor lacinia, id mollis massa bibendum.', CAST(N'2017-09-15 19:01:17.677' AS DateTime), CAST(N'2016-10-22 17:24:30.790' AS DateTime), N'kadirbaseren', 49, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (168, N'Phasellus non ante non lectus ullamcorper faucibus id a eros.', CAST(N'2017-01-11 22:10:20.880' AS DateTime), CAST(N'2016-12-24 09:41:49.047' AS DateTime), N'user2', 49, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (169, N'Vivamus facilisis lectus in suscipit facilisis.', CAST(N'2017-05-05 07:53:57.120' AS DateTime), CAST(N'2016-11-17 18:54:05.817' AS DateTime), N'user3', 50, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (170, N'Fusce sollicitudin magna ut risus ullamcorper, ut ullamcorper elit adipiscing.', CAST(N'2017-03-09 18:21:26.207' AS DateTime), CAST(N'2016-12-22 15:23:56.440' AS DateTime), N'user4', 50, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (171, N'Nam tincidunt orci vel pellentesque sagittis.', CAST(N'2016-12-12 20:02:48.523' AS DateTime), CAST(N'2016-12-06 22:19:38.683' AS DateTime), N'user5', 50, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (172, N'Duis gravida erat et euismod consequat.', CAST(N'2017-04-23 21:01:59.130' AS DateTime), CAST(N'2016-10-23 22:18:33.583' AS DateTime), N'user4', 50, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (173, N'Morbi sit amet nibh eget eros tempor mollis vel nec lacus.', CAST(N'2016-10-12 04:28:04.537' AS DateTime), CAST(N'2017-01-09 11:55:07.613' AS DateTime), N'user2', 51, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (174, N'Phasellus tincidunt nunc eu orci vehicula bibendum.', CAST(N'2017-05-15 13:11:44.697' AS DateTime), CAST(N'2017-04-26 14:42:42.850' AS DateTime), N'user0', 51, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (175, N'Duis cursus risus et nisi suscipit sollicitudin.', CAST(N'2017-05-01 17:24:38.037' AS DateTime), CAST(N'2017-07-16 16:51:37.077' AS DateTime), N'user1', 51, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (176, N'Duis eu augue sed lectus pellentesque rutrum non eu augue.', CAST(N'2017-07-02 13:16:45.160' AS DateTime), CAST(N'2016-11-16 20:49:02.347' AS DateTime), N'kadirbaseren', 52, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (177, N'Donec varius libero nec ligula congue volutpat.', CAST(N'2017-04-29 02:40:08.347' AS DateTime), CAST(N'2017-06-28 06:58:14.580' AS DateTime), N'user3', 52, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (178, N'In laoreet justo et condimentum bibendum.', CAST(N'2016-12-05 22:06:23.410' AS DateTime), CAST(N'2017-08-30 01:01:41.087' AS DateTime), N'user1', 52, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (179, N'Ut eget neque porttitor, aliquet nibh at, sodales tellus.', CAST(N'2017-08-02 01:37:22.957' AS DateTime), CAST(N'2017-06-01 17:32:04.813' AS DateTime), N'kadirbaseren', 53, 2)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (180, N'Fusce scelerisque sapien ornare neque pharetra aliquam.', CAST(N'2017-03-29 03:46:00.620' AS DateTime), CAST(N'2017-02-23 18:03:57.437' AS DateTime), N'user3', 53, 6)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (181, N'Donec dignissim massa nec urna porttitor facilisis.', CAST(N'2017-07-13 16:07:53.520' AS DateTime), CAST(N'2017-01-23 01:10:22.217' AS DateTime), N'user0', 53, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (182, N'Vivamus et felis ut augue laoreet mollis.', CAST(N'2017-05-19 16:28:29.730' AS DateTime), CAST(N'2017-03-28 17:13:41.767' AS DateTime), N'user1', 54, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (183, N'In eu justo sed est faucibus tincidunt non quis ligula.', CAST(N'2016-11-11 07:20:01.473' AS DateTime), CAST(N'2016-10-31 03:11:27.750' AS DateTime), N'muratbaseren', 54, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (184, N'Vestibulum in enim nec eros faucibus elementum sed vitae dolor.', CAST(N'2017-05-01 14:43:21.777' AS DateTime), CAST(N'2017-08-14 10:29:26.530' AS DateTime), N'user1', 54, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (185, N'Sed adipiscing dolor eget turpis eleifend eleifend.', CAST(N'2016-12-08 13:14:45.337' AS DateTime), CAST(N'2017-08-03 23:10:50.423' AS DateTime), N'user0', 54, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (186, N'Nulla a ligula laoreet, viverra purus vel, suscipit enim.', CAST(N'2017-03-30 01:25:12.980' AS DateTime), CAST(N'2017-02-07 12:15:49.527' AS DateTime), N'user2', 55, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (187, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', CAST(N'2017-05-30 18:29:39.890' AS DateTime), CAST(N'2017-07-14 17:32:13.887' AS DateTime), N'user5', 55, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (188, N'Curabitur imperdiet dolor eget volutpat ultrices.', CAST(N'2016-11-26 15:46:22.723' AS DateTime), CAST(N'2017-06-22 11:46:16.207' AS DateTime), N'user0', 55, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (189, N'Morbi et mi id sapien consequat rutrum in quis risus.', CAST(N'2017-03-12 11:25:45.840' AS DateTime), CAST(N'2017-08-21 14:18:42.633' AS DateTime), N'user2', 55, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (190, N'Suspendisse a lectus at nibh luctus faucibus.', CAST(N'2017-04-22 06:00:35.650' AS DateTime), CAST(N'2017-01-17 11:10:24.893' AS DateTime), N'user2', 56, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (192, N'Vivamus facilisis lectus in suscipit facilisis.', CAST(N'2017-04-19 10:42:31.550' AS DateTime), CAST(N'2017-02-08 00:24:49.897' AS DateTime), N'user1', 56, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (193, N'In laoreet justo et condimentum bibendum.', CAST(N'2017-05-25 15:41:06.833' AS DateTime), CAST(N'2017-08-19 12:52:07.873' AS DateTime), N'user0', 57, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (194, N'Ut eget neque porttitor, aliquet nibh at, sodales tellus.', CAST(N'2017-05-23 08:54:49.600' AS DateTime), CAST(N'2016-11-29 03:27:59.100' AS DateTime), N'user1', 57, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (195, N'Donec interdum velit a orci consectetur, non mollis diam hendrerit.', CAST(N'2017-09-12 22:28:30.150' AS DateTime), CAST(N'2017-04-14 06:36:28.393' AS DateTime), N'user4', 57, 7)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (196, N'Suspendisse a diam vitae erat pretium pharetra.', CAST(N'2016-10-21 10:51:32.980' AS DateTime), CAST(N'2017-04-11 05:45:24.120' AS DateTime), N'user0', 57, 3)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (197, N'Nullam quis turpis eu urna vehicula ornare vel et enim.', CAST(N'2017-02-08 22:22:31.960' AS DateTime), CAST(N'2016-10-08 01:17:27.653' AS DateTime), N'user1', 58, 4)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (198, N'Nulla malesuada massa eget nunc accumsan placerat.', CAST(N'2017-02-08 00:21:58.740' AS DateTime), CAST(N'2016-12-24 10:02:50.033' AS DateTime), N'user2', 58, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (199, N'Donec tincidunt felis sit amet rutrum faucibus.', CAST(N'2016-10-23 16:18:27.720' AS DateTime), CAST(N'2017-04-11 02:04:10.823' AS DateTime), N'user5', 58, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (200, N'Proin at leo eget odio condimentum faucibus.', CAST(N'2017-06-16 12:43:05.343' AS DateTime), CAST(N'2016-11-14 03:58:56.187' AS DateTime), N'user3', 59, 6)
GO
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (201, N'Nullam et enim congue, pretium eros id, pretium nibh.', CAST(N'2017-09-17 13:52:22.867' AS DateTime), CAST(N'2016-12-17 18:03:31.483' AS DateTime), N'user5', 59, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (202, N'Etiam tincidunt augue vestibulum, tempus mi ac, facilisis lectus.', CAST(N'2017-02-13 13:53:07.917' AS DateTime), CAST(N'2017-02-11 19:42:49.370' AS DateTime), N'user2', 59, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (203, N'Nullam et enim congue, pretium eros id, pretium nibh.', CAST(N'2017-09-17 13:11:22.423' AS DateTime), CAST(N'2017-04-02 00:32:52.643' AS DateTime), N'user5', 60, 8)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (204, N'Morbi sit amet libero vitae augue porttitor tempus.', CAST(N'2017-09-26 19:16:32.280' AS DateTime), CAST(N'2017-06-05 00:56:44.267' AS DateTime), N'user6', 60, 9)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (205, N'Nullam tincidunt arcu sit amet nisl tempor, ac dictum odio tincidunt.', CAST(N'2016-10-19 18:12:52.243' AS DateTime), CAST(N'2016-12-17 00:44:41.057' AS DateTime), N'user2', 60, 5)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (206, N'dfgg', CAST(N'2017-10-08 17:29:21.250' AS DateTime), CAST(N'2017-10-08 17:29:21.250' AS DateTime), N'muratbaseren', 7, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (207, N'eewrwerewr', CAST(N'2017-10-08 17:29:31.660' AS DateTime), CAST(N'2017-10-08 17:29:31.660' AS DateTime), N'muratbaseren', 7, 1)
INSERT [dbo].[Comments] ([Id], [Text], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Note_Id], [Owner_Id]) VALUES (210, N'gbnmbnm', CAST(N'2017-10-08 17:40:28.443' AS DateTime), CAST(N'2017-10-08 17:40:28.443' AS DateTime), N'muratbaseren', 41, 1)
SET IDENTITY_INSERT [dbo].[Comments] OFF
SET IDENTITY_INSERT [dbo].[EvernoteUsers] ON 

INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (1, N'Murat', N'Başerennnn', N'muratbaseren', N'muratbaseren@gmail.com', N'123456', 1, 1, N'9a9b53c8-2576-4133-a854-7bcbf766c915', N'user_boy.png', CAST(N'2017-10-02 21:29:29.383' AS DateTime), CAST(N'2017-10-02 23:20:45.767' AS DateTime), N'muratbaseren')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (2, N'Kadir', N'Başeren', N'kadirbaseren', N'kadirbaseren@gmail.com', N'654321', 1, 0, N'0ec50e77-8fdb-4c34-b47a-13af4e8ce0bc', N'user_boy.png', CAST(N'2017-10-02 22:29:29.383' AS DateTime), CAST(N'2017-10-02 22:34:29.383' AS DateTime), N'muratbaseren')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (3, N'Lauren', N'Summers', N'user0', N'A.Thompson@bet365.org', N'123', 1, 0, N'882ed034-0509-4bb8-9432-1dba51ecbc8c', N'user_boy.png', CAST(N'2016-12-31 16:28:32.630' AS DateTime), CAST(N'2017-07-17 18:29:39.380' AS DateTime), N'user0')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (4, N'Sydney', N'Schofield', N'user1', N'Angel.Osborne@sky.co.uk', N'123', 1, 0, N'3a9ab326-6c1a-432e-b0ac-75be33bad9ea', N'user_boy.png', CAST(N'2016-10-21 02:07:12.533' AS DateTime), CAST(N'2016-11-03 03:28:37.797' AS DateTime), N'user1')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (5, N'Isaac', N'Buckley', N'user2', N'J.Lindsay@sky.com', N'123', 1, 0, N'c02d8be4-7197-460e-97ae-103a43feb5a6', N'user_boy.png', CAST(N'2017-09-30 01:00:57.980' AS DateTime), CAST(N'2017-03-26 00:41:46.787' AS DateTime), N'user2')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (6, N'Madelyn', N'Fleming', N'user3', N'Claire.Whitehouse@taobao.com', N'123', 1, 0, N'4f0c2cff-1790-4fa6-a9c6-8661252bba6f', N'user_boy.png', CAST(N'2017-01-30 20:39:48.213' AS DateTime), CAST(N'2017-06-06 15:39:17.137' AS DateTime), N'user3')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (7, N'Matthew', N'Vaughan', N'user4', N'J.Nash@stackoverflow.biz', N'123', 1, 0, N'50e92c38-90d5-4eaa-afeb-5e42950109f8', N'user_boy.png', CAST(N'2016-11-04 14:08:17.013' AS DateTime), CAST(N'2017-03-22 17:56:19.687' AS DateTime), N'user4')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (8, N'Faith', N'Savage', N'user5', N'Nathan.Welch@studio1337.info', N'123', 1, 0, N'057e9330-2d98-4505-aa9e-78ed71dd5d05', N'user_boy.png', CAST(N'2016-11-15 03:40:40.037' AS DateTime), CAST(N'2017-07-20 14:58:10.807' AS DateTime), N'user5')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (9, N'Henry', N'Thorne', N'user6', N'C.Stuart@techcrunch.info', N'123', 1, 0, N'313d1937-6db0-43cd-99bb-5ae41a0bd552', N'user_boy.png', CAST(N'2017-08-10 16:55:58.160' AS DateTime), CAST(N'2017-07-06 04:18:18.987' AS DateTime), N'user6')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (10, N'Aubree', N'Weaver', N'user7', N'Jordan.Johnson@qq.us', N'123', 1, 0, N'12617b87-22d4-45bb-97e0-74cb5a33b8d8', N'user_boy.png', CAST(N'2017-02-14 08:48:18.723' AS DateTime), CAST(N'2017-02-21 08:02:59.177' AS DateTime), N'user7')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (11, NULL, NULL, N'ayse', N'asdad@hotmail.com', N'1', 0, 0, N'38d2222f-aede-41fc-aa20-15a5901cde81', NULL, CAST(N'2017-10-02 22:35:17.923' AS DateTime), CAST(N'2017-10-02 22:35:17.923' AS DateTime), N'system')
INSERT [dbo].[EvernoteUsers] ([Id], [Name], [Surname], [UserName], [Email], [Password], [IsActive], [IsAdmin], [ActivateGuid], [ProfileImageFileName], [CreatedOn], [ModifiedOn], [ModifiedUserName]) VALUES (12, NULL, NULL, N'tarık', N'q653600@mvrht.net', N'3', 1, 0, N'8bc7dbf0-2c83-4f29-b112-78f7b34e60ae', NULL, CAST(N'2017-10-02 22:37:00.647' AS DateTime), CAST(N'2017-10-02 22:37:49.877' AS DateTime), N'system')
SET IDENTITY_INSERT [dbo].[EvernoteUsers] OFF
SET IDENTITY_INSERT [dbo].[Likes] ON 

INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (1, 1, 1)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (2, 1, 2)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (3, 2, 2)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (4, 3, 2)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (5, 4, 2)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (6, 1, 3)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (7, 2, 3)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (8, 3, 3)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (9, 1, 4)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (10, 1, 5)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (11, 2, 5)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (12, 3, 5)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (13, 4, 5)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (14, 5, 5)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (15, 6, 5)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (16, 7, 5)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (17, 1, 6)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (18, 2, 6)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (19, 3, 6)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (20, 1, 7)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (21, 2, 7)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (22, 1, 8)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (23, 1, 9)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (24, 2, 9)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (25, 1, 10)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (26, 2, 10)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (27, 1, 11)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (28, 2, 11)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (29, 1, 12)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (30, 2, 12)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (31, 3, 12)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (32, 4, 12)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (33, 5, 12)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (34, 6, 12)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (35, 1, 13)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (36, 2, 13)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (37, 3, 13)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (38, 4, 13)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (39, 5, 13)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (40, 6, 13)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (41, 7, 13)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (42, 8, 13)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (43, 1, 14)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (44, 2, 14)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (45, 1, 15)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (46, 2, 15)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (47, 1, 16)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (48, 2, 16)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (49, 3, 16)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (50, 4, 16)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (51, 5, 16)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (52, 6, 16)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (53, 7, 16)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (54, 8, 16)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (55, 1, 17)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (56, 2, 17)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (57, 1, 18)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (58, 2, 18)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (59, 3, 18)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (60, 4, 18)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (61, 5, 18)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (62, 6, 18)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (63, 7, 18)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (64, 1, 19)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (65, 2, 19)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (66, 3, 19)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (67, 4, 19)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (68, 5, 19)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (69, 6, 19)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (70, 7, 19)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (71, 8, 19)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (72, 1, 20)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (73, 2, 20)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (74, 1, 21)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (75, 2, 21)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (76, 3, 21)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (77, 4, 21)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (78, 5, 21)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (79, 6, 21)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (80, 1, 22)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (81, 2, 22)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (82, 3, 22)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (83, 4, 22)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (84, 1, 23)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (85, 1, 24)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (86, 1, 25)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (87, 2, 25)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (88, 3, 25)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (89, 4, 25)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (90, 5, 25)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (91, 1, 26)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (92, 1, 27)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (93, 2, 27)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (94, 3, 27)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (95, 4, 27)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (96, 5, 27)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (97, 1, 28)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (98, 2, 28)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (99, 3, 28)
GO
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (100, 4, 28)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (101, 5, 28)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (102, 6, 28)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (103, 1, 29)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (104, 2, 29)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (105, 3, 29)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (106, 1, 30)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (107, 2, 30)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (108, 3, 30)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (109, 4, 30)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (110, 5, 30)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (111, 6, 30)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (112, 7, 30)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (113, 1, 31)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (114, 2, 31)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (115, 3, 31)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (116, 4, 31)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (117, 5, 31)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (118, 1, 32)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (119, 2, 32)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (120, 3, 32)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (121, 4, 32)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (122, 5, 32)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (123, 6, 32)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (124, 1, 33)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (125, 2, 33)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (126, 3, 33)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (127, 1, 34)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (128, 2, 34)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (129, 3, 34)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (130, 4, 34)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (131, 5, 34)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (132, 6, 34)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (133, 1, 35)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (134, 2, 35)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (135, 3, 35)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (136, 1, 36)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (137, 2, 36)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (138, 3, 36)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (139, 4, 36)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (140, 5, 36)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (141, 6, 36)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (142, 7, 36)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (143, 8, 36)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (144, 1, 37)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (145, 2, 37)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (146, 3, 37)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (147, 4, 37)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (148, 5, 37)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (149, 1, 38)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (150, 1, 39)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (151, 2, 39)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (152, 3, 39)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (153, 1, 40)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (154, 2, 40)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (155, 3, 40)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (156, 1, 41)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (157, 2, 41)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (158, 3, 41)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (159, 4, 41)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (160, 5, 41)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (161, 6, 41)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (162, 1, 42)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (163, 2, 42)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (164, 3, 42)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (165, 4, 42)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (166, 5, 42)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (167, 6, 42)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (168, 1, 43)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (169, 2, 43)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (170, 3, 43)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (171, 1, 44)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (172, 2, 44)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (173, 1, 45)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (174, 2, 45)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (175, 3, 45)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (176, 1, 46)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (177, 2, 46)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (178, 3, 46)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (179, 4, 46)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (180, 5, 46)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (181, 6, 46)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (182, 1, 47)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (183, 2, 47)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (184, 3, 47)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (185, 4, 47)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (186, 5, 47)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (187, 6, 47)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (188, 1, 48)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (189, 2, 48)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (190, 1, 49)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (191, 2, 49)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (192, 3, 49)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (193, 4, 49)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (194, 5, 49)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (195, 6, 49)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (196, 1, 50)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (197, 2, 50)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (198, 3, 50)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (199, 4, 50)
GO
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (200, 5, 50)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (201, 1, 51)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (202, 2, 51)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (203, 3, 51)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (204, 4, 51)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (205, 5, 51)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (206, 1, 52)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (207, 2, 52)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (208, 3, 52)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (209, 4, 52)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (210, 1, 53)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (211, 1, 54)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (212, 2, 54)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (213, 3, 54)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (214, 4, 54)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (215, 5, 54)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (216, 6, 54)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (217, 1, 55)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (218, 2, 55)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (219, 3, 55)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (220, 4, 55)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (221, 5, 55)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (222, 6, 55)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (223, 1, 56)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (224, 2, 56)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (225, 3, 56)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (226, 4, 56)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (227, 5, 56)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (228, 6, 56)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (229, 7, 56)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (230, 1, 57)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (231, 2, 57)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (232, 3, 57)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (233, 4, 57)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (234, 5, 57)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (235, 1, 58)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (236, 2, 58)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (237, 3, 58)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (238, 4, 58)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (239, 5, 58)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (240, 6, 58)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (241, 1, 59)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (242, 2, 59)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (243, 3, 59)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (244, 4, 59)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (245, 5, 59)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (246, 6, 59)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (247, 7, 59)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (248, 1, 60)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (249, 2, 60)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (250, 3, 60)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (251, 4, 60)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (252, 5, 60)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (253, 6, 60)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (254, 7, 60)
INSERT [dbo].[Likes] ([Id], [LikedUser_Id], [Note_Id]) VALUES (255, 8, 60)
SET IDENTITY_INSERT [dbo].[Likes] OFF
SET IDENTITY_INSERT [dbo].[Notes] ON 

INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (1, N'tqoxomqgezzri', N'Morbi et mi id sapien consequat rutrum in quis risus. Phasellus tincidunt nunc eu orci vehicula bibendum.', 0, 1, 1, CAST(N'2016-12-12 22:00:23.787' AS DateTime), CAST(N'2017-01-29 05:20:11.483' AS DateTime), N'user5', 8)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (2, N'envwqfzsbhtqsidmsad', N'Phasellus tincidunt nunc eu orci vehicula bibendum.', 0, 4, 1, CAST(N'2017-09-13 02:08:20.720' AS DateTime), CAST(N'2017-06-10 14:49:05.137' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (3, N'ffhvqrs', N'Sed dignissim augue eget orci vulputate, a pellentesque odio facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 0, 3, 1, CAST(N'2017-01-03 19:27:52.043' AS DateTime), CAST(N'2017-07-12 19:08:14.993' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (4, N'wjpwij', N'Vivamus facilisis lectus in suscipit facilisis.', 0, 1, 1, CAST(N'2017-01-03 03:37:28.473' AS DateTime), CAST(N'2017-01-17 17:57:55.777' AS DateTime), N'user2', 5)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (5, N'nvrkbwfhskvoibz', N'Nam tincidunt orci vel pellentesque sagittis.', 0, 7, 1, CAST(N'2017-07-30 16:45:17.193' AS DateTime), CAST(N'2017-08-20 09:50:56.023' AS DateTime), N'muratbaseren', 1)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (6, N'edghacw', N'Maecenas ac ligula interdum, faucibus leo in, faucibus quam.', 0, 3, 1, CAST(N'2017-01-29 21:43:52.113' AS DateTime), CAST(N'2017-03-18 04:54:55.963' AS DateTime), N'user6', 9)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (7, N'tkrqtyygkwkuwtb', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec interdum velit a orci consectetur, non mollis diam hendrerit.', 0, 2, 1, CAST(N'2017-04-19 03:01:34.033' AS DateTime), CAST(N'2017-09-06 11:01:25.473' AS DateTime), N'user0', 3)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (8, N'eqtpcedfrywkvg', N'Nulla malesuada massa eget nunc accumsan placerat.', 0, 1, 2, CAST(N'2016-11-20 03:54:37.060' AS DateTime), CAST(N'2016-10-09 13:45:17.573' AS DateTime), N'user0', 3)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (9, N'nwomukkww', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla a ligula laoreet, viverra purus vel, suscipit enim.', 0, 2, 2, CAST(N'2017-02-21 13:21:52.230' AS DateTime), CAST(N'2016-11-29 04:25:47.947' AS DateTime), N'user0', 3)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (10, N'jwvcvidsbtpzxuuhjbtqa', N'Pellentesque commodo risus vitae orci pretium tincidunt. Donec volutpat turpis congue, suscipit dui eget, tempus lorem.', 0, 2, 2, CAST(N'2017-07-08 10:50:59.293' AS DateTime), CAST(N'2017-03-05 04:26:01.537' AS DateTime), N'user5', 8)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (11, N'yvtmgdygvkjuyaykhhu', N'Vivamus et felis ut augue laoreet mollis.', 0, 2, 2, CAST(N'2017-01-19 10:40:47.820' AS DateTime), CAST(N'2016-12-08 16:33:14.127' AS DateTime), N'user0', 3)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (12, N'ngtckaaunohxbqhwwczmfiki', N'Nunc iaculis metus a tristique adipiscing. Integer eu neque at lectus imperdiet tincidunt.', 0, 6, 2, CAST(N'2017-01-08 07:56:21.393' AS DateTime), CAST(N'2016-12-30 15:38:03.510' AS DateTime), N'muratbaseren', 1)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (13, N'djngpnqyvrqkgf', N'In laoreet justo et condimentum bibendum. Nulla a ligula laoreet, viverra purus vel, suscipit enim.', 0, 8, 3, CAST(N'2017-06-09 01:57:44.577' AS DateTime), CAST(N'2016-11-29 03:29:32.187' AS DateTime), N'user0', 3)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (14, N'eawybkuwerpxxtdjzkhfsb', N'Morbi et mi id sapien consequat rutrum in quis risus.', 0, 2, 3, CAST(N'2017-08-03 00:50:14.587' AS DateTime), CAST(N'2017-08-05 23:02:12.947' AS DateTime), N'user5', 8)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (15, N'ybazrrgpeczgufpnzqt', N'Curabitur sed lorem a dui consequat congue. Duis eu augue sed lectus pellentesque rutrum non eu augue.', 0, 2, 3, CAST(N'2017-09-29 19:26:56.740' AS DateTime), CAST(N'2016-11-15 12:38:23.593' AS DateTime), N'user5', 8)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (16, N'ezmqeuaqfvgcv', N'Vivamus porta neque non neque malesuada scelerisque.', 0, 8, 3, CAST(N'2016-10-29 20:33:52.037' AS DateTime), CAST(N'2017-06-30 17:58:52.007' AS DateTime), N'user5', 8)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (17, N'wzdvygbz', N'Morbi sit amet nibh eget eros tempor mollis vel nec lacus.', 0, 2, 3, CAST(N'2017-03-09 16:42:02.873' AS DateTime), CAST(N'2016-11-10 03:40:09.943' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (18, N'bmnsppgryqt', N'In laoreet justo et condimentum bibendum.', 0, 7, 4, CAST(N'2017-04-05 17:55:31.567' AS DateTime), CAST(N'2017-06-02 01:19:39.710' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (19, N'immxawy', N'Fusce sollicitudin magna ut risus ullamcorper, ut ullamcorper elit adipiscing. Pellentesque non risus sed odio dapibus gravida quis non dolor.', 0, 8, 4, CAST(N'2017-09-16 21:14:43.410' AS DateTime), CAST(N'2017-06-21 16:27:23.950' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (20, N'tqdfjcyppfubgiupdpx', N'Suspendisse laoreet ligula ac dolor egestas gravida. Duis eu augue sed lectus pellentesque rutrum non eu augue.', 0, 2, 4, CAST(N'2017-06-06 20:46:55.623' AS DateTime), CAST(N'2016-11-18 19:32:47.083' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (21, N'ahpearxjm', N'Nullam quis turpis eu urna vehicula ornare vel et enim.', 0, 6, 4, CAST(N'2016-11-08 15:48:27.570' AS DateTime), CAST(N'2016-12-28 15:44:05.647' AS DateTime), N'muratbaseren', 1)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (22, N'piezcrmevddt', N'Vivamus porta neque non neque malesuada scelerisque. Morbi sit amet nibh eget eros tempor mollis vel nec lacus.', 0, 4, 4, CAST(N'2017-08-26 08:49:38.133' AS DateTime), CAST(N'2017-08-21 22:28:09.540' AS DateTime), N'user2', 5)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (23, N'sksrbuwtrytqxukadqyiuu', N'Suspendisse a diam vitae erat pretium pharetra.', 0, 1, 4, CAST(N'2017-05-12 01:26:32.150' AS DateTime), CAST(N'2016-11-08 14:32:53.637' AS DateTime), N'user6', 9)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (24, N'tpodyykqmrxhxrkyjpyhm', N'Suspendisse pharetra massa sed leo commodo malesuada. Nulla hendrerit ligula in eros suscipit sagittis.', 0, 1, 4, CAST(N'2017-01-06 22:35:26.067' AS DateTime), CAST(N'2017-08-02 18:57:40.167' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (25, N'vjiupjbrcwk', N'Donec varius libero nec ligula congue volutpat. Vivamus et felis ut augue laoreet mollis.', 0, 5, 5, CAST(N'2017-09-03 03:11:12.150' AS DateTime), CAST(N'2016-11-04 07:03:16.817' AS DateTime), N'user0', 3)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (26, N'pmkrrtpvsxp', N'Phasellus non ante non lectus ullamcorper faucibus id a eros.', 0, 1, 5, CAST(N'2017-03-16 12:26:03.710' AS DateTime), CAST(N'2017-01-29 11:24:12.240' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (27, N'yrsbbixyyudhvxarskia', N'Nulla hendrerit ligula in eros suscipit sagittis. Nunc iaculis metus a tristique adipiscing.', 0, 5, 5, CAST(N'2017-07-09 22:00:48.370' AS DateTime), CAST(N'2016-10-19 10:06:42.303' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (28, N'pxkdrqbrqfttehacgoiraqpj', N'Vivamus facilisis lectus in suscipit facilisis.', 0, 6, 5, CAST(N'2017-06-17 15:13:24.597' AS DateTime), CAST(N'2016-12-29 19:50:44.630' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (29, N'bzzia', N'Nulla in metus sed mauris faucibus scelerisque ut vel augue. Nunc iaculis metus a tristique adipiscing.', 0, 3, 5, CAST(N'2017-03-06 11:55:39.490' AS DateTime), CAST(N'2016-10-06 00:23:34.553' AS DateTime), N'user2', 5)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (30, N'gkywd', N'Nunc ac sem quis augue pharetra volutpat. Duis eu augue sed lectus pellentesque rutrum non eu augue.', 0, 7, 5, CAST(N'2017-06-21 19:51:54.777' AS DateTime), CAST(N'2017-03-31 23:19:33.623' AS DateTime), N'user6', 9)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (31, N'vbjbxaobhgxnmgua', N'Phasellus non ante non lectus ullamcorper faucibus id a eros. In laoreet justo et condimentum bibendum.', 0, 5, 6, CAST(N'2016-10-12 22:01:04.897' AS DateTime), CAST(N'2016-11-28 12:19:44.030' AS DateTime), N'kadirbaseren', 2)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (32, N'imjpyzo', N'Phasellus non ante non lectus ullamcorper faucibus id a eros. Proin at leo eget odio condimentum faucibus.', 0, 6, 6, CAST(N'2016-12-10 03:10:10.207' AS DateTime), CAST(N'2017-04-26 06:25:50.170' AS DateTime), N'user5', 8)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (33, N'cfunuammeiyuzhkowast', N'Proin at leo eget odio condimentum faucibus.', 0, 3, 6, CAST(N'2016-10-15 00:28:20.467' AS DateTime), CAST(N'2017-06-27 18:43:13.937' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (34, N'aazscbmkzy', N'Donec volutpat turpis congue, suscipit dui eget, tempus lorem. Donec dignissim massa nec urna porttitor facilisis.', 0, 6, 6, CAST(N'2017-07-10 11:36:27.230' AS DateTime), CAST(N'2016-11-15 19:19:13.810' AS DateTime), N'user0', 3)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (35, N'jsxbnpursfyihabygbajycuy', N'Donec volutpat turpis congue, suscipit dui eget, tempus lorem.', 0, 3, 6, CAST(N'2017-08-11 00:28:11.767' AS DateTime), CAST(N'2017-06-15 02:32:03.143' AS DateTime), N'user1', 4)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (36, N'bhxyo', N'Duis gravida erat et euismod consequat.', 0, 8, 7, CAST(N'2017-09-25 10:48:27.797' AS DateTime), CAST(N'2017-05-25 06:33:40.753' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (37, N'qqwmnjqqfezvanaqghirmi', N'Praesent non tortor dictum, interdum ligula vel, dapibus tortor. Nullam et enim congue, pretium eros id, pretium nibh.', 0, 5, 7, CAST(N'2017-05-08 16:32:53.157' AS DateTime), CAST(N'2017-08-22 18:37:29.117' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (38, N'zjspcmxkgsxtw', N'Fusce sollicitudin magna ut risus ullamcorper, ut ullamcorper elit adipiscing. Donec interdum velit a orci consectetur, non mollis diam hendrerit.', 0, 1, 7, CAST(N'2017-10-01 10:16:35.957' AS DateTime), CAST(N'2017-02-10 21:58:36.393' AS DateTime), N'muratbaseren', 1)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (39, N'ibsmss', N'Nullam quis turpis eu urna vehicula ornare vel et enim. Maecenas sed leo mollis, egestas mauris vitae, porta risus.', 0, 3, 7, CAST(N'2016-10-09 19:26:20.067' AS DateTime), CAST(N'2017-03-25 14:37:30.707' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (40, N'gharrdnd', N'Fusce sollicitudin magna ut risus ullamcorper, ut ullamcorper elit adipiscing.', 0, 3, 7, CAST(N'2016-12-17 11:25:18.420' AS DateTime), CAST(N'2016-10-09 18:52:31.687' AS DateTime), N'user6', 9)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (41, N'tjqrmfcdxonzkckuzqdmkk', N'Curabitur sed urna eget dui laoreet semper id sit amet erat.', 0, 6, 7, CAST(N'2017-05-10 14:42:53.197' AS DateTime), CAST(N'2017-09-30 02:24:49.543' AS DateTime), N'kadirbaseren', 2)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (42, N'djecmmqskifcywgzsdqq', N'Ut eget neque porttitor, aliquet nibh at, sodales tellus.', 0, 6, 7, CAST(N'2017-09-15 04:58:09.367' AS DateTime), CAST(N'2017-05-24 07:03:49.837' AS DateTime), N'kadirbaseren', 2)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (43, N'fbigq', N'Donec tincidunt felis sit amet rutrum faucibus. Nunc ac sem quis augue pharetra volutpat.', 0, 3, 7, CAST(N'2017-03-27 09:28:46.537' AS DateTime), CAST(N'2017-02-04 18:49:25.240' AS DateTime), N'user2', 5)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (44, N'jgrafwxypvzsypnx', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris nec est quis libero interdum condimentum.', 0, 2, 8, CAST(N'2017-02-10 16:58:02.983' AS DateTime), CAST(N'2017-01-26 08:07:14.430' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (45, N'jgrnvaxnfb', N'Nunc ac ipsum sed purus consectetur sodales.', 0, 3, 8, CAST(N'2017-07-19 12:19:06.313' AS DateTime), CAST(N'2017-04-04 21:53:31.307' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (46, N'obaqhiapkwixphpciavgwg', N'Maecenas sed leo mollis, egestas mauris vitae, porta risus.', 0, 6, 8, CAST(N'2016-12-11 05:06:36.857' AS DateTime), CAST(N'2016-10-06 19:15:27.047' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (47, N'hbuiscrhahprzcitsr', N'Sed dignissim augue eget orci vulputate, a pellentesque odio facilisis.', 0, 6, 8, CAST(N'2017-04-25 09:45:45.360' AS DateTime), CAST(N'2017-05-09 03:13:04.847' AS DateTime), N'user4', 7)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (48, N'zkknkudnrrarbtmfjuzhfojq', N'Donec volutpat turpis congue, suscipit dui eget, tempus lorem.', 0, 2, 8, CAST(N'2017-02-14 07:48:55.943' AS DateTime), CAST(N'2016-12-29 21:08:35.927' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (49, N'kpugoavejdgbzi', N'Suspendisse laoreet ligula ac dolor egestas gravida. Nunc ac ipsum sed purus consectetur sodales.', 0, 6, 9, CAST(N'2016-11-09 20:18:12.817' AS DateTime), CAST(N'2017-06-13 18:28:18.273' AS DateTime), N'user5', 8)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (50, N'geeyrgctydihmxgqryznadua', N'Nunc vel quam laoreet, congue erat a, suscipit neque.', 0, 5, 9, CAST(N'2017-01-30 12:44:11.113' AS DateTime), CAST(N'2017-03-03 06:33:44.637' AS DateTime), N'user2', 5)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (51, N'azdkdruruiboysiinxgs', N'Vivamus et felis ut augue laoreet mollis.', 0, 5, 9, CAST(N'2017-09-06 16:41:19.850' AS DateTime), CAST(N'2017-05-06 12:45:28.963' AS DateTime), N'kadirbaseren', 2)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (52, N'drrbyf', N'Suspendisse tempor dui id libero interdum, vulputate malesuada felis dapibus. Duis gravida erat et euismod consequat.', 0, 4, 9, CAST(N'2017-06-21 10:27:05.370' AS DateTime), CAST(N'2017-01-30 18:12:37.527' AS DateTime), N'muratbaseren', 1)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (53, N'urpuytmrvs', N'Suspendisse pharetra massa sed leo commodo malesuada.', 0, 1, 9, CAST(N'2017-08-27 00:14:09.410' AS DateTime), CAST(N'2016-12-27 17:59:35.407' AS DateTime), N'user2', 5)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (54, N'yrukxaro', N'Mauris nec est quis libero interdum condimentum. Nullam et tellus posuere, consectetur ante eget, iaculis lorem.', 0, 6, 9, CAST(N'2016-10-29 00:31:41.610' AS DateTime), CAST(N'2017-03-12 06:36:19.410' AS DateTime), N'user5', 8)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (55, N'qvasvuysnxzkquybdvpsa', N'Morbi et mi id sapien consequat rutrum in quis risus. Proin at leo eget odio condimentum faucibus.', 0, 6, 9, CAST(N'2017-01-30 00:26:51.503' AS DateTime), CAST(N'2017-03-29 00:08:39.407' AS DateTime), N'muratbaseren', 1)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (56, N'yamgydgkq', N'Fusce sollicitudin magna ut risus ullamcorper, ut ullamcorper elit adipiscing.', 0, 7, 10, CAST(N'2017-01-19 18:21:58.683' AS DateTime), CAST(N'2017-01-08 04:32:33.180' AS DateTime), N'muratbaseren', 1)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (57, N'kvhwbfppdyidthwwruunkem', N'Donec volutpat turpis congue, suscipit dui eget, tempus lorem. Ut rutrum massa sit amet tortor lacinia, id mollis massa bibendum.', 0, 5, 10, CAST(N'2017-07-10 07:22:47.573' AS DateTime), CAST(N'2017-06-23 23:19:29.983' AS DateTime), N'muratbaseren', 1)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (58, N'pmgjovuq', N'Integer eu neque at lectus imperdiet tincidunt. Proin at leo eget odio condimentum faucibus.', 0, 6, 10, CAST(N'2016-12-06 16:41:32.053' AS DateTime), CAST(N'2017-04-05 10:42:10.753' AS DateTime), N'user3', 6)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (59, N'zbjqbzvjsyfwwtukqch', N'Praesent non tortor dictum, interdum ligula vel, dapibus tortor. Fusce sollicitudin magna ut risus ullamcorper, ut ullamcorper elit adipiscing.', 0, 7, 10, CAST(N'2016-11-18 22:35:33.383' AS DateTime), CAST(N'2016-10-10 22:20:40.350' AS DateTime), N'user1', 4)
INSERT [dbo].[Notes] ([Id], [Title], [Text], [IsDraft], [LikeCount], [CategoryId], [CreatedOn], [ModifiedOn], [ModifiedUserName], [Owner_Id]) VALUES (60, N'dibdyrxetrtffgqritspj', N'In laoreet justo et condimentum bibendum.', 0, 8, 10, CAST(N'2017-04-15 02:08:24.723' AS DateTime), CAST(N'2017-02-01 13:42:36.853' AS DateTime), N'user4', 7)
SET IDENTITY_INSERT [dbo].[Notes] OFF
/****** Object:  Index [IX_Note_Id]    Script Date: 8.10.2017 19:58:15 ******/
CREATE NONCLUSTERED INDEX [IX_Note_Id] ON [dbo].[Comments]
(
	[Note_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Owner_Id]    Script Date: 8.10.2017 19:58:15 ******/
CREATE NONCLUSTERED INDEX [IX_Owner_Id] ON [dbo].[Comments]
(
	[Owner_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LikedUser_Id]    Script Date: 8.10.2017 19:58:15 ******/
CREATE NONCLUSTERED INDEX [IX_LikedUser_Id] ON [dbo].[Likes]
(
	[LikedUser_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Note_Id]    Script Date: 8.10.2017 19:58:15 ******/
CREATE NONCLUSTERED INDEX [IX_Note_Id] ON [dbo].[Likes]
(
	[Note_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CategoryId]    Script Date: 8.10.2017 19:58:15 ******/
CREATE NONCLUSTERED INDEX [IX_CategoryId] ON [dbo].[Notes]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Owner_Id]    Script Date: 8.10.2017 19:58:15 ******/
CREATE NONCLUSTERED INDEX [IX_Owner_Id] ON [dbo].[Notes]
(
	[Owner_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Comments_dbo.EvernoteUsers_Owner_Id] FOREIGN KEY([Owner_Id])
REFERENCES [dbo].[EvernoteUsers] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_dbo.Comments_dbo.EvernoteUsers_Owner_Id]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Comments_dbo.Notes_Note_Id] FOREIGN KEY([Note_Id])
REFERENCES [dbo].[Notes] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_dbo.Comments_dbo.Notes_Note_Id]
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Likes_dbo.EvernoteUsers_LikedUser_Id] FOREIGN KEY([LikedUser_Id])
REFERENCES [dbo].[EvernoteUsers] ([Id])
GO
ALTER TABLE [dbo].[Likes] CHECK CONSTRAINT [FK_dbo.Likes_dbo.EvernoteUsers_LikedUser_Id]
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Likes_dbo.Notes_Note_Id] FOREIGN KEY([Note_Id])
REFERENCES [dbo].[Notes] ([Id])
GO
ALTER TABLE [dbo].[Likes] CHECK CONSTRAINT [FK_dbo.Likes_dbo.Notes_Note_Id]
GO
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Notes_dbo.Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_dbo.Notes_dbo.Categories_CategoryId]
GO
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Notes_dbo.EvernoteUsers_Owner_Id] FOREIGN KEY([Owner_Id])
REFERENCES [dbo].[EvernoteUsers] ([Id])
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_dbo.Notes_dbo.EvernoteUsers_Owner_Id]
GO
USE [master]
GO
ALTER DATABASE [MyEvernoteDB] SET  READ_WRITE 
GO
