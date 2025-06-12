raiserror('Creating LaptopStore database....',0,1)
SET NOCOUNT ON
GO
USE [master]
GO
CREATE DATABASE [LaptopStore]
GO
USE [LaptopStore]
GO

CREATE TABLE [dbo].[Account](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[username]  VARCHAR(100) UNIQUE NOT NULL,
	[email]  VARCHAR(100) UNIQUE NOT NULL,
	[password]VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
)
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[name] [varchar](50) NOT NULL
)
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[name] [varchar](255) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [float] NOT NULL,
	[categoryId] [int] references Category(id) NOT NULL
)
GO

CREATE TABLE [dbo].[Admin](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[name] [varchar](255) NOT NULL,
	[phone] [varchar](12) NOT NULL,
	[email] [varchar](30) NOT NULL,
)

CREATE TABLE [dbo].[Customer](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[name] [varchar](255) NOT NULL,
	[address] [varchar](50) NOT NULL,
	[phone] [varchar](12) NOT NULL,
	[email] [varchar](30) NOT NULL,
	[shipToAddress] [varchar](50) NOT NULL
)
GO
CREATE TABLE [dbo].[OrderHeader](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[date] [datetime] NOT NULL,	
	[customerId] [int] references Customer(id) NOT NULL,
	[status] [varchar](30) NOT NULL default('New') CHECK([status] IN ('New','Shipping','Cancel','Close')),
)
GO
CREATE TABLE [dbo].[OrderDetail](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[orderHeaderId] [int] references OrderHeader(id) NOT NULL,
	[productId] [int] references Product(id) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [float] NOT NULL,
)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category]([id], [name]) VALUES (1, N'Lenovo')
INSERT [dbo].[Category]([id], [name]) VALUES (2, N'MSI')
INSERT [dbo].[Category]([id], [name]) VALUES (3, N'Acer')
INSERT [dbo].[Category]([id], [name]) VALUES (4, N'ASUS')
INSERT [dbo].[Category]([id], [name]) VALUES (5, N'Dell')
INSERT [dbo].[Category]([id], [name]) VALUES (6, N'Gigabyte')
INSERT [dbo].[Category]([id], [name]) VALUES (7, N'Macbook')
INSERT [dbo].[Category]([id], [name]) VALUES (8, N'HP')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (1, N'Laptop Lenovo IdeaPad Slim 3 15IRH10 83K1000GVN', 1, 17490, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (2, N'Laptop MSI Modern 14 F13MG 027VN', 2, 14690, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (3, N'Laptop Gaming Acer Nitro V 16 ProPanel ANV16-41-R6NA', 3, 34990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (4, N'Laptop ASUS Vivobook 14 OLED A1405ZA KM264W', 4, 18990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (5, N'Laptop ASUS ExpertBook P1 P1403CVA-I5SE16-63WS', 4, 13990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (6, N'Laptop Dell Inspiron 15 3530 N3530 i3U085W11SLU', 5, 13890, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (7, N'Laptop gaming MSI Thin 15 B13UC 2044VN', 2, 19490, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (8, N'Laptop gaming MSI Katana 15 B13VEK 252VN', 2, 23490, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (9, N'Laptop gaming Acer Predator Helios Neo 16 PHN16 72 78L4', 3, 38990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (10, N'Laptop gaming Gigabyte G5 MF5 H2VN353KH', 6, 25490, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (11, N'Laptop gaming MSI Sword 16 HX B14VEKG 856VN', 2, 35990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (12, N'Laptop gaming Acer Nitro V ANV15 51 91T5', 3, 32990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (13, N'Laptop gaming Acer Nitro Lite 16 NL16 71G 71UJ', 3, 23990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (14, N'Laptop gaming MSI Cyborg 14 A13VE 090VN', 2,27990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (15, N'Laptop gaming MSI Cyborg 14 A13VE 090VN', 2, 21990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (16, N'MacBook Air M4 13 inch 2025 10CPU 10GPU 16GB 512GB', 7, 31990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (17, N'Laptop ASUS ROG Strix G16 G614JU-N3206WLaptop ASUS ROG Strix G16 G614JU-N3206W', 4, 38990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (18, N'Apple MacBook Air M2 2024 8CPU 8GPU 16GB 256GB', 7, 24990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (19, N'Laptop ASUS VivoBook S 16 OLED S5606MA-MX051W', 4, 29990, 140)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (20, N'Laptop ASUS TUF Gaming F15 FX507ZC4-HN095W', 4, 24990, 150)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (21, N'Laptop Lenovo IdeaPad Slim 5 14Q8X9 83HL000KVN', 1, 24990, 120)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (22, N'Laptop Gaming Acer Nitro 5 Tiger AN515 58 773Y', 3, 25990, 400)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (23, N'Laptop MSI Gaming Thin 15 B12UCX-1419VN V2', 2, 17990, 500)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (24, N'Laptop Lenovo IdeaPad Flex 5 14ABR8 82XX00DMVN', 1, 16990, 250)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (25, N'Laptop HP Victus 16-R0376TX AY8Z2PA', 8, 24490, 280)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (26, N'Laptop ASUS Gaming V16 K3607VJ-RP106W', 4, 24490, 425)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (27, N'MacBook Pro 16 M4 Max 16CPU 40GPU 64GB 2TB', 7, 117490, 523)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (28, N'Laptop Acer Aspire Lite AL16-51P-55N7 NX.KX0SV.001', 3, 14990, 421)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (29, N'MacBook Air M4 13 inch 2025 10CPU 10GPU 16GB 512GB Sạc 70W', 7, 32990, 200)
INSERT [dbo].[Product] ([id], [name], [categoryId], [price], [quantity]) VALUES (30, N'MacBook Pro 14 M4 Pro 12CPU 16GPU 24GB 512GB', 7, 49990, 200)

SET IDENTITY_INSERT [dbo].[Product] OFF

SET IDENTITY_INSERT [dbo].[Customer] ON 
INSERT [dbo].[Customer] ([id], [name], [address], [phone], [email], [shipToAddress]) VALUES
(1, N'Customer1', N'1873 Lion Circle', N'5678901234', N'c1@gmail.com', N'1873 Lion Circle'),
(2, N'Customer2', N'5747 Shirley Drive', N'6789872314', N'c2@gmail.com', N'5747 Shirley Drive')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO

SET IDENTITY_INSERT [dbo].[Admin] ON 
INSERT [dbo].[Admin] ([id], [name], [phone], [email]) VALUES
(1, N'Admin 1', N'09012345675', N'admin1@gmail.com'),
(2, N'Admin 2',  N'0912546891', N'admin2@gmail.com')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO

SET NOCOUNT OFF
raiserror('The LaptopStore database in now ready for use.',0,1)
GO

Select *from OrderDetail;
Select *from OrderHeader;
Select *from Product;

SET IDENTITY_INSERT [dbo].[OrderHeader] ON 
INSERT INTO OrderHeader([id],[date],[customerId]) VALUES (2, '2025-05-06 14:33:00', 1);
SET IDENTITY_INSERT [dbo].[OrderHeader] OFF 


SET IDENTITY_INSERT [dbo].[OrderDetail] ON
INSERT INTO OrderDetail([id],[orderHeaderId],[productId],[quantity],[price]) VALUES (2, 2,3,5,74.11);
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF 