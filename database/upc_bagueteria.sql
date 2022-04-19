USE [master]
GO
/****** Object:  Database [DbBagueteria]    Script Date: 19/04/2022 8:21:47 AM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 19/04/2022 8:21:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[StockMin] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 19/04/2022 8:21:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[StockID] [bigint] IDENTITY(1,1) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[Mont] [varchar](2) NOT NULL,
	[Day] [varchar](2) NOT NULL,
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
/****** Object:  View [dbo].[VwStock]    Script Date: 19/04/2022 8:21:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VwStock]
AS
	SELECT tmp.ProductID,
		pro.CategoryID,
		pro.[Name],
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
/****** Object:  Table [dbo].[Category]    Script Date: 19/04/2022 8:21:47 AM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 19/04/2022 8:21:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[LastName] [varchar](80) NOT NULL,
	[CardID] [varchar](13) NOT NULL,
	[Bithday] [date] NOT NULL,
	[Gender] [char](1) NOT NULL,
	[Email] [varchar](80) NOT NULL,
	[Password] [varchar](max) NOT NULL,
	[Role] [varchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 19/04/2022 8:21:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[Mont] [varchar](2) NOT NULL,
	[Day] [varchar](2) NOT NULL,
	[StockID] [bigint] NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[Amount] [decimal](10, 3) NOT NULL,
	[Delivery] [bit] NOT NULL,
	[DeliveryAmount] [decimal](10, 3) NOT NULL,
	[Status] [bit] NOT NULL,
	[EmployeeID] [bigint] NULL,
	[DateAttended] [datetime] NULL,
	[TotalAmount] [decimal](10, 3) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prices]    Script Date: 19/04/2022 8:21:47 AM ******/
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
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [Name], [Deleted]) VALUES (1, N'Pastel', 0)
INSERT [dbo].[Category] ([CategoryID], [Name], [Deleted]) VALUES (2, N'Pan', 0)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerID], [Name], [LastName], [CardID], [Bithday], [Gender], [Email], [Password], [Role], [Deleted]) VALUES (1, N'Johan', N'Jammons Smidth', N'2002320000001', CAST(N'2001-02-24' AS Date), N'M', N'jjammons@mail.com', N'123456', N'customer', 0)
INSERT [dbo].[Customer] ([CustomerID], [Name], [LastName], [CardID], [Bithday], [Gender], [Email], [Password], [Role], [Deleted]) VALUES (2, N'Artur', N'Duncan Logines', N'2002320000002', CAST(N'2001-02-26' AS Date), N'M', N'alogines@mail.com', N'123456', N'employee', 0)
INSERT [dbo].[Customer] ([CustomerID], [Name], [LastName], [CardID], [Bithday], [Gender], [Email], [Password], [Role], [Deleted]) VALUES (3, N'Jose', N'Altamirano Flores', N'202222001', CAST(N'1999-01-21' AS Date), N'M', N'jaltamirano@mail.com', N'123456', N'customer', 0)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Prices] ON 

INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (1, 1, 1, CAST(86.000 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (2, 2, 1, CAST(78.500 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (3, 3, 1, CAST(85.600 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (4, 4, 1, CAST(68.500 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (5, 5, 1, CAST(0.350 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (6, 6, 1, CAST(0.300 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (7, 7, 1, CAST(0.450 AS Decimal(10, 3)), 0)
INSERT [dbo].[Prices] ([PriceID], [ProductID], [Unity], [Price], [Deleted]) VALUES (8, 8, 1, CAST(0.350 AS Decimal(10, 3)), 0)
SET IDENTITY_INSERT [dbo].[Prices] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [StockMin], [Deleted]) VALUES (1, N'Pastel de fresas', 1, 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [StockMin], [Deleted]) VALUES (2, N'Pastel de Maracuya', 1, 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [StockMin], [Deleted]) VALUES (3, N'Torta de chocolate', 1, 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [StockMin], [Deleted]) VALUES (4, N'Torta helada', 1, 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [StockMin], [Deleted]) VALUES (5, N'Frances', 2, 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [StockMin], [Deleted]) VALUES (6, N'Baguete', 2, 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [StockMin], [Deleted]) VALUES (7, N'Ciabatta', 2, 5, 0)
INSERT [dbo].[Product] ([ProductID], [Name], [CategoryID], [StockMin], [Deleted]) VALUES (8, N'Caramanduca', 2, 5, 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Stock] ON 

INSERT [dbo].[Stock] ([StockID], [Year], [Mont], [Day], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (1, N'2022', N'03', N'25', 5, 30, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Year], [Mont], [Day], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (2, N'2022', N'03', N'25', 6, 30, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Year], [Mont], [Day], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (3, N'2022', N'03', N'25', 7, 30, 1, 0)
INSERT [dbo].[Stock] ([StockID], [Year], [Mont], [Day], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (4, N'2022', N'03', N'25', 5, 3, 0, 0)
INSERT [dbo].[Stock] ([StockID], [Year], [Mont], [Day], [ProductID], [Quantity], [Movement], [Deleted]) VALUES (6, N'2022', N'03', N'25', 1, 20, 1, 0)
SET IDENTITY_INSERT [dbo].[Stock] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__55FECD8FF1E844CC]    Script Date: 19/04/2022 8:21:47 AM ******/
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
ALTER TABLE [dbo].[Prices] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((1)) FOR [StockMin]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Stock] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
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
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD CHECK  (([Gender] like '[MF]'))
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD CHECK  (([Amount]>(-1)))
GO
USE [master]
GO
ALTER DATABASE [DbBagueteria] SET  READ_WRITE 
GO
