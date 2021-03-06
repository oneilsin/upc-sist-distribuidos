USE [master]
GO
/****** Object:  Database [DbBagueteria]    Script Date: 26/04/2022 2:21:08 AM ******/
CREATE DATABASE [DbBagueteria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DbBagueteria', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DbBagueteria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DbBagueteria_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DbBagueteria_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DbBagueteria] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DbBagueteria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DbBagueteria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DbBagueteria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DbBagueteria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DbBagueteria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DbBagueteria] SET ARITHABORT OFF 
GO
ALTER DATABASE [DbBagueteria] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DbBagueteria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DbBagueteria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DbBagueteria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DbBagueteria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DbBagueteria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DbBagueteria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DbBagueteria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DbBagueteria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DbBagueteria] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DbBagueteria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DbBagueteria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DbBagueteria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DbBagueteria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DbBagueteria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DbBagueteria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DbBagueteria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DbBagueteria] SET RECOVERY FULL 
GO
ALTER DATABASE [DbBagueteria] SET  MULTI_USER 
GO
ALTER DATABASE [DbBagueteria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DbBagueteria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DbBagueteria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DbBagueteria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DbBagueteria] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DbBagueteria', N'ON'
GO
ALTER DATABASE [DbBagueteria] SET QUERY_STORE = OFF
GO
USE [DbBagueteria]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[StockID] [bigint] NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[Amount] [decimal](10, 3) NOT NULL,
	[StatusCart] [bit] NOT NULL,
	[SalesID] [bigint] NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[StockID] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Movement] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwToOrders]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VwToOrders]
AS
	SELECT o.OrderID, o.StockID, s.ProductID,
		o.CustomerID, o.[Date], o.StatusCart
	FROM Orders o
	LEFT JOIN Stock s ON s.StockID=o.StockID
	WHERE o.Deleted=0 AND StatusCart=1
GO
/****** Object:  Table [dbo].[Product]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ImageName] [varchar](40) NOT NULL,
	[Description] [varchar](200) NOT NULL,
	[StockMin] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwStock]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VwStock]
AS
	SELECT tmp.ProductID,
		pro.CategoryID,
		pro.[Name],
		pro.ImageName AS Photo, 
		pro.[Description],
		tmp.Stock
	FROM(
		SELECT tmp.ProductID, SUM(tmp.Quantity) AS Stock
		FROM(
			SELECT st.ProductID, SUM(st.Quantity) AS Quantity
			FROM Stock st
			WHERE st.Deleted=0 AND st.Movement=1
			GROUp BY st.ProductID
			UNION ALL
			SELECT st.ProductID, (SUM(st.Quantity)*-1) AS Quantity
			FROM Stock st
			WHERE st.Deleted=0 AND st.Movement=0
			GROUp BY st.ProductID
		) AS tmp
		GROUP BY tmp.ProductID
	) AS tmp
	INNER JOIN Product pro ON pro.ProductID=tmp.ProductID
GO
/****** Object:  Table [dbo].[Category]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[LastName] [varchar](80) NOT NULL,
	[CardID] [varchar](13) NULL,
	[Bithday] [date] NOT NULL,
	[Gender] [char](1) NOT NULL,
	[Email] [varchar](80) NOT NULL,
	[Address] [varchar](250) NULL,
	[Referece] [varchar](250) NULL,
	[Password] [varchar](max) NOT NULL,
	[Role] [varchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](70) NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prices]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prices](
	[PriceID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Unity] [int] NOT NULL,
	[Price] [decimal](10, 3) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[SalesID] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[Delivery] [bit] NOT NULL,
	[PaymentID] [int] NOT NULL,
	[TotalAmount] [decimal](10, 3) NOT NULL,
	[EmployeeID] [bigint] NULL,
	[DateAttended] [datetime] NULL,
	[AttendedStatus] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [Name], [Deleted]) VALUES (1, N'Otros', 0)
INSERT [dbo].[Category] ([CategoryID], [Name], [Deleted]) VALUES (2, N'Pastel', 0)
INSERT [dbo].[Category] ([CategoryID], [Name], [Deleted]) VALUES (3, N'Pan', 0)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerID], [Name], [LastName], [CardID], [Bithday], [Gender], [Email], [Address], [Referece], [Password], [Role], [Deleted]) VALUES (1, N'Johan Fabian', N'Jammons Smidth', N'2002320000001', CAST(N'2017-01-31' AS Date), N'M', N'cliente1@mail.com', N'Direccion de domicilio - x2', N'qweqwe', N'123456', N'customer', 0)
INSERT [dbo].[Customer] ([CustomerID], [Name], [LastName], [CardID], [Bithday], [Gender], [Email], [Address], [Referece], [Password], [Role], [Deleted]) VALUES (2, N'Artur Guido', N'Duncan Logines', N'2002320000002', CAST(N'2001-02-26' AS Date), N'M', N'vendedor1@mail.com', N'', N'', N'123456', N'employee', 0)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [Date], [StockID], [CustomerID], [Amount], [StatusCart], [SalesID], [Deleted]) VALUES (1, CAST(N'2022-04-26' AS Date), 48, 1, CAST(258.000 AS Decimal(10, 3)), 0, 1, 0)
INSERT [dbo].[Orders] ([OrderID], [Date], [StockID], [CustomerID], [Amount], [StatusCart], [SalesID], [Deleted]) VALUES (2, CAST(N'2022-04-26' AS Date), 49, 1, CAST(1.500 AS Decimal(10, 3)), 0, 1, 0)
INSERT [dbo].[Orders] ([OrderID], [Date], [StockID], [CustomerID], [Amount], [StatusCart], [SalesID], [Deleted]) VALUES (3, CAST(N'2022-04-26' AS Date), 50, 1, CAST(314.000 AS Decimal(10, 3)), 0, 2, 0)
INSERT [dbo].[Orders] ([OrderID], [Date], [StockID], [CustomerID], [Amount], [StatusCart], [SalesID], [Deleted]) VALUES (4, CAST(N'2022-04-26' AS Date), 51, 1, CAST(1.500 AS Decimal(10, 3)), 0, 2, 0)
INSERT [dbo].[Orders] ([OrderID], [Date], [StockID], [CustomerID], [Amount], [StatusCart], [SalesID], [Deleted]) VALUES (5, CAST(N'2022-04-26' AS Date), 52, 1, CAST(8.400 AS Decimal(10, 3)), 0, 3, 0)
INSERT [dbo].[Orders] ([OrderID], [Date], [StockID], [CustomerID], [Amount], [StatusCart], [SalesID], [Deleted]) VALUES (6, CAST(N'2022-04-26' AS Date), 53, 1, CAST(1.500 AS Decimal(10, 3)), 0, 3, 0)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([PaymentID], [Description], [Deleted]) VALUES (1, N'Contra entrega - Efectivo', 0)
INSERT [dbo].[Payment] ([PaymentID], [Description], [Deleted]) VALUES (2, N'Contra entrega - POS', 0)
INSERT [dbo].[Payment] ([PaymentID], [Description], [Deleted]) VALUES (3, N'Contra entrega - Aplicativo', 0)
INSERT [dbo].[Payment] ([PaymentID], [Description], [Deleted]) VALUES (4, N'Directo - Efectivo', 0)
INSERT [dbo].[Payment] ([PaymentID], [Description], [Deleted]) VALUES (5, N'Directo - POS', 0)
INSERT [dbo].[Payment] ([PaymentID], [Description], [Deleted]) VALUES (6, N'Directo - Aplicativo', 0)
INSERT [dbo].[Payment] ([PaymentID], [Description], [Deleted]) VALUES (7, N'Virtual - Aplicativo', 0)
INSERT [dbo].[Payment] ([PaymentID], [Description], [Deleted]) VALUES (8, N'Virtual - Pasarela', 0)
SET IDENTITY_INSERT [dbo].[Payment] OFF
GO
SET IDENTITY_INSERT [dbo].[Prices] ON 

INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (1, 1, 1, CAST(1.500 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (2, 2, 1, CAST(86.000 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (3, 3, 1, CAST(78.500 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (4, 4, 1, CAST(85.600 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (5, 5, 1, CAST(68.500 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (6, 6, 1, CAST(45.500 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (7, 7, 1, CAST(46.500 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (8, 8, 1, CAST(0.450 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (9, 9, 1, CAST(0.350 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (10, 11, 1, CAST(0.350 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (11, 12, 1, CAST(0.350 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (12, 13, 1, CAST(0.350 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (13, 14, 1, CAST(0.350 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (14, 15, 1, CAST(0.350 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (15, 16, 1, CAST(0.350 AS Decimal(10, 3)), 0)
SET IDENTITY_INSERT [dbo].[Prices] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (1, N'Delivery', 1, N'C1_Delivery', N'', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (2, N'Torta de Chantilli', 2, N'C2_Chantilli', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (3, N'Torta de Chocolate', 2, N'C2_Chocolate', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (4, N'Pie de Fresas', 2, N'C2_Fresa', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (5, N'Torta Helada', 2, N'C2_Helada', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (6, N'Pie de Limon', 2, N'C2_Limon', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (7, N'Chesse Cake de Maracuya', 2, N'C2_Maracuya', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (8, N'Cachito de Mantequilla', 3, N'C3_Cachito', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (9, N'Cariocas especial', 3, N'C3_Carioca', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (11, N'Chapla artesanal', 3, N'C3_Chapla', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (12, N'Ciabatta especial', 3, N'C3_Ciabatta', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (13, N'Coliza especial', 3, N'C3_Coliza', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (14, N'Frances especial', 3, N'C3_Frances', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (15, N'Integral especial', 3, N'C3_Integral', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [ImageName], [Description], [StockMin], [Deleted]) VALUES (16, N'Yema especial', 3, N'C3_Yema', N'Deliciosa "nombre del producto", elaborado con ingredientes de calidad, horneado con "alguna info extra", información acerca del azucar, etc.', 5, 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Sales] ON 

INSERT [dbo].[Sales] ([SalesID], [Date], [CustomerID], [Delivery], [PaymentID], [TotalAmount], [EmployeeID], [DateAttended], [AttendedStatus], [Deleted]) VALUES (1, CAST(N'2022-04-26' AS Date), 1, 1, 2, CAST(259.500 AS Decimal(10, 3)), 2, CAST(N'2022-04-26T02:15:41.377' AS DateTime), 1, 0)
INSERT [dbo].[Sales] ([SalesID], [Date], [CustomerID], [Delivery], [PaymentID], [TotalAmount], [EmployeeID], [DateAttended], [AttendedStatus], [Deleted]) VALUES (2, CAST(N'2022-04-26' AS Date), 1, 1, 8, CAST(315.500 AS Decimal(10, 3)), 2, CAST(N'2022-04-26T02:15:54.300' AS DateTime), 1, 0)
INSERT [dbo].[Sales] ([SalesID], [Date], [CustomerID], [Delivery], [PaymentID], [TotalAmount], [EmployeeID], [DateAttended], [AttendedStatus], [Deleted]) VALUES (3, CAST(N'2022-04-26' AS Date), 1, 1, 7, CAST(9.900 AS Decimal(10, 3)), 2, CAST(N'2022-04-26T02:16:00.397' AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Sales] OFF
GO
SET IDENTITY_INSERT [dbo].[Stock] ON 

INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (21, CAST(N'2022-04-01' AS Date), 1, 999999, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (22, CAST(N'2022-04-01' AS Date), 2, 10, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (23, CAST(N'2022-04-01' AS Date), 3, 10, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (24, CAST(N'2022-04-01' AS Date), 4, 10, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (25, CAST(N'2022-04-01' AS Date), 5, 10, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (26, CAST(N'2022-04-01' AS Date), 6, 10, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (27, CAST(N'2022-04-01' AS Date), 7, 10, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (28, CAST(N'2022-04-01' AS Date), 8, 500, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (29, CAST(N'2022-04-01' AS Date), 9, 500, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (30, CAST(N'2022-04-01' AS Date), 11, 500, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (31, CAST(N'2022-04-01' AS Date), 12, 500, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (32, CAST(N'2022-04-01' AS Date), 13, 500, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (33, CAST(N'2022-04-01' AS Date), 14, 500, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (34, CAST(N'2022-04-01' AS Date), 15, 500, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (35, CAST(N'2022-04-01' AS Date), 16, 500, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (36, CAST(N'2022-04-24' AS Date), 7, 2, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (37, CAST(N'2022-04-24' AS Date), 9, 20, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (38, CAST(N'2022-04-24' AS Date), 4, 2, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (39, CAST(N'2022-04-24' AS Date), 1, 1, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (40, CAST(N'2022-04-24' AS Date), 2, 12, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (41, CAST(N'2022-04-24' AS Date), 1, 1, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (42, CAST(N'2022-04-24' AS Date), 3, 2, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (43, CAST(N'2022-04-24' AS Date), 12, 50, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (44, CAST(N'2022-04-25' AS Date), 1, 1, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (45, CAST(N'2022-04-25' AS Date), 1, 1, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (46, CAST(N'2022-04-25' AS Date), 4, 2, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (47, CAST(N'2022-04-25' AS Date), 1, 1, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (48, CAST(N'2022-04-26' AS Date), 2, 3, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (49, CAST(N'2022-04-26' AS Date), 1, 1, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (50, CAST(N'2022-04-26' AS Date), 3, 4, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (51, CAST(N'2022-04-26' AS Date), 1, 1, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (52, CAST(N'2022-04-26' AS Date), 9, 24, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Date], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (53, CAST(N'2022-04-26' AS Date), 1, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Stock] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__55FECD8FE3292862]    Script Date: 26/04/2022 2:21:08 AM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[CardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Payment] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Prices] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ('') FOR [ImageName]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((5)) FOR [StockMin]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Sales] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Stock] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([StockID])
REFERENCES [dbo].[Stock] ([StockID])
GO
ALTER TABLE [dbo].[Prices]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD FOREIGN KEY([PaymentID])
REFERENCES [dbo].[Payment] ([PaymentID])
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD CHECK  (([Gender] like '[MF]'))
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD CHECK  (([Amount]>(-1)))
GO
/****** Object:  StoredProcedure [dbo].[UspCustomerCreate]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UspCustomerCreate](
	@Name VARCHAR(30),
	@Email VARCHAR(50),
	@Password VARCHAR(100)
)
AS BEGIN
	DECLARE @_doc VARCHAR(13)=(
		SELECT RIGHT(RAND(),13)
	)
	INSERT INTO Customer 
	OUTPUT inserted.CustomerID 
	VALUES(@Name, '', @_doc, '', 'M', 
		@Email,'','', @Password, 'customer', 0
	);
	UPDATE Customer SET CardID=(
		SELECT RIGHT('D'+CONVERT(VARCHAR(35),GETDATE(),112)+CONVERT(VARCHAR,@@IDENTITY),13)
	)
	WHERE CustomerID=(SELECT @@IDENTITY);	
END
GO
/****** Object:  StoredProcedure [dbo].[UspProductAddCart]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UspProductAddCart](
	@ProductID BIGINT,
	@CustomerID BIGINT,
	@Quantity INT
)
AS BEGIN
	--<> Validamos si los productos están en canastilla y pendiente de despacho.
	DECLARE @_exist INT=(
		SELECT COUNT(1) FROM VwToOrders 
		WHERE ProductID=@ProductID AND CustomerID=@CustomerID
	);
	--<> Obtener precios
	DECLARE @_price DECIMAL(10,3)=(
		SELECT Price FROM Prices WHERE ProductID=@ProductID
	);
	IF(@_exist>0) --<> Si la canastilla está activa, se actualiza las cantidades y precios.
		BEGIN
			--<> Obtener Ids
			DECLARE @_idOrder BIGINT, @_idStock BIGINT;
			SELECT TOP(1) @_idOrder=v.OrderID, @_idStock=v.StockID FROM VwToOrders v
			WHERE ProductID=@ProductID AND CustomerID=@CustomerID
			--<> Obtener cantidades
			DECLARE @_quantity INT=(
				SELECT Quantity+@Quantity FROM Stock WHERE StockID=@_idStock
			);
			--<> Actualizar cantidades
			UPDATE Stock
			SET Quantity=@_quantity
			WHERE StockID=@_idStock;				
			--<> Actualizar orden-precios
			UPDATE Orders
			SET Amount=(@_quantity*@_price)
			WHERE OrderID=@_idOrder;

			--<> Obtener Id-Stock Insertado
			SELECT @_idStock;
		END
	ELSE
		BEGIN
			DECLARE @t TABLE(Id INT);
			INSERT INTO Stock
			OUTPUT inserted.StockID INTO @t
			VALUES(GETDATE(),
				@ProductID, @Quantity, 0, 0);
			--<> Create Order
			DECLARE @StockID BIGINT=(SELECT TOP(1) * FROM @t);
			INSERT INTO Orders
			VALUES(GETDATE(),
				@StockID, @CustomerID, (@Quantity*@_price), 1,
				NULL, 0);
			--<> Obtener Id-Stock Insertado
			SELECT @StockID;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[UspProductEditCart]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UspProductEditCart](
	@StockID BIGINT,
	@Quantity INT,
	@OrderID BIGINT	
)
AS BEGIN
	--<> Obtener precios
	DECLARE @_price DECIMAL(10,3)=(
		SELECT Price FROM Prices WHERE ProductID=(
			SELECT ProductID FROM Stock 
			WHERE StockID=@StockID
		)
	);	
	
	UPDATE Stock
    SET Quantity=@Quantity
    WHERE StockID=@StockID;  
	--<> Modificar Orden
    UPDATE Orders
    SET Amount=(@Quantity*@_price)
    WHERE OrderID=@OrderID;
END
GO
/****** Object:  StoredProcedure [dbo].[UspProductSearchCart]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UspProductSearchCart](
	@CustomerID BIGINT
)
AS BEGIN
	SELECT o.OrderID,
		o.StockID,
		p.[Name] AS Product,
		pc.Price AS UnitPrice,
		s.Quantity,
		o.Amount,
		p.ImageName AS Photo
	FROM Orders o
	INNER JOIN Stock s ON s.StockID=o.StockID
	INNER JOIN Product p ON p.ProductID=s.ProductID
	INNER JOIN Prices pc ON pc.ProductID=p.ProductID
	WHERE CustomerID=@CustomerID
	AND StatusCart=1
END
GO
/****** Object:  StoredProcedure [dbo].[UspSalesCreate]    Script Date: 26/04/2022 2:21:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UspSalesCreate](
	@CustomerID BIGINT,
	@Delivery BIT,
	@PaymentID INT
)
AS BEGIN
	DECLARE @_date DATE=(GETDATE());
	--<> Si es por delivery, crear concepto
	IF(@Delivery=1)
		BEGIN
			--<> Obtener precios
			DECLARE @_price DECIMAL(10,3)=(
				SELECT Price FROM Prices WHERE ProductID=1 --(1:Id:Delivery)
			);	
			--<> Insertamos el valor delivery
			DECLARE @t TABLE(Id INT);
			INSERT INTO Stock
			OUTPUT inserted.StockID INTO @t
			VALUES(@_date, 1, 1, 0, 0);
			--<> Create Order
			DECLARE @_stockID BIGINT=(SELECT TOP(1) * FROM @t);
			INSERT INTO Orders
			VALUES(@_date,@_stockID, @CustomerID, (1*@_price), 1, NULL, 0);
		END
	--<> Obtenemos el importe total.
	DECLARE @_totalAmount DECIMAL(10,3)=(
		SELECT SUM(Amount) FROM Orders
		WHERE CustomerID=@CustomerID AND StatusCart=1 AND SalesID IS NULL
	);
	--<> Creamos la venta
	DECLARE @ts TABLE(Id INT);
	INSERT INTO Sales
	OUTPUT inserted.SalesID INTO @ts
	VALUES(@_date, @CustomerID, @Delivery, @PaymentID, @_totalAmount,
		NULL, NULL,	0, 0
	);
	--<> Actualizar StatusCart de las Ordenes, para cerrar carrito y establecer ID(Venta).
	DECLARE @_salesID BIGINT=(SELECT TOP(1) Id FROM @ts);
	UPDATE Orders SET StatusCart=0, SalesID=@_salesID
	WHERE CustomerID=@CustomerID AND StatusCart=1 AND SalesID IS NULL

	SELECT @@ROWCOUNT
END
GO
USE [master]
GO
ALTER DATABASE [DbBagueteria] SET  READ_WRITE 
GO
