
CREATE TABLE [dbo].[Address](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[AddressCompany] [nvarchar](64) NULL,
	[AddressLine1] [nvarchar](128) NOT NULL,
	[AddressLine2] [nvarchar](128) NULL,
	[AddressZipCode] [nvarchar](16) NOT NULL,
	[AddressType] [bit] NOT NULL,
	[AddressActive] [bit] NOT NULL,
	[DeliverableCountryID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
 CONSTRAINT [PK_AddressID] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](64) NOT NULL,
	[CategoryDescription] [nvarchar](255) NOT NULL,
	[CategoryIsMenu] [bit] NOT NULL,
	[MediaID] [int] NULL,
 CONSTRAINT [PK_CategoryID] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Command]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Command](
	[CommandID] [int] IDENTITY(1,1) NOT NULL,
	[CommandDate] [datetime] NOT NULL,
	[CommandFicsalDate] [datetime] NOT NULL,
	[CommandeReference] [nvarchar](32) NOT NULL,
	[CommandStatusID] [int] NOT NULL,
	[DeliveryAddressID] [int] NOT NULL,
	[InvoiceAddressID] [int] NULL,
 CONSTRAINT [PK_CommandID] PRIMARY KEY CLUSTERED 
(
	[CommandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CommandLine]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommandLine](
	[CommandLineID] [int] IDENTITY(1,1) NOT NULL,
	[CommandLineQuantity] [int] NOT NULL,
	[CommandLinePrice] [money] NOT NULL,
	[CommandID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_CommandLineID] PRIMARY KEY CLUSTERED 
(
	[CommandLineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CommandStatus]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommandStatus](
	[CommandStatusID] [int] IDENTITY(1,1) NOT NULL,
	[CommandStatusName] [nvarchar](64) NOT NULL,
	[CommandStatusProgress] [smallint] NOT NULL,
	[MediaID] [int] NOT NULL,
 CONSTRAINT [PK_CommandStatusID] PRIMARY KEY CLUSTERED 
(
	[CommandStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerLastName] [nvarchar](64) NOT NULL,
	[CustomerFirstName] [nvarchar](64) NOT NULL,
	[CustomerCompany] [nvarchar](96) NULL,
	[CustomerActive] [bit] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_CustomerID] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeliverableCountry]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliverableCountry](
	[DeliverableCountryID] [int] IDENTITY(1,1) NOT NULL,
	[DeliverableCountryName] [nvarchar](48) NOT NULL,
 CONSTRAINT [PK_DeliverableCountryID] PRIMARY KEY CLUSTERED 
(
	[DeliverableCountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeliverablePrice]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliverablePrice](
	[DeliverablePriceID] [int] IDENTITY(1,1) NOT NULL,
	[DeliverablePriceName] [nvarchar](64) NOT NULL,
	[DeliverablePriceTimeEstimation] [tinyint] NOT NULL,
	[DeliverablePriceValue] [smallmoney] NOT NULL,
	[DeliverablePriceCountryID] [int] NOT NULL,
 CONSTRAINT [PK_DeliverablePriceID] PRIMARY KEY CLUSTERED 
(
	[DeliverablePriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Media]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media](
	[MediaID] [int] IDENTITY(1,1) NOT NULL,
	[MediaName] [nvarchar](64) NOT NULL,
	[MediaAlt] [nvarchar](128) NULL,
	[MediaUrl] [nvarchar](max) NOT NULL,
	[MediaTypeID] [int] NULL,
 CONSTRAINT [PK_MediaID] PRIMARY KEY CLUSTERED 
(
	[MediaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MediaProduct]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaProduct](
	[ProductID] [int] NOT NULL,
	[MediaID] [int] NOT NULL,
 CONSTRAINT [PK_MediaProduct] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[MediaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MediaType]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaType](
	[MediaTypeID] [int] IDENTITY(1,1) NOT NULL,
	[MediaTypeName] [nvarchar](64) NOT NULL,
	[MediaTypeExtension] [nvarchar](8) NULL,
 CONSTRAINT [PK_MediaTypeID] PRIMARY KEY CLUSTERED 
(
	[MediaTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Price]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price](
	[PriceID] [int] IDENTITY(1,1) NOT NULL,
	[PriceDate] [datetime] NOT NULL,
	[PriceValue] [money] NOT NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_PriceID] PRIMARY KEY CLUSTERED 
(
	[PriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](128) NOT NULL,
	[ProductDescription] [nvarchar](255) NULL,
	[ProductLongDescription] [text] NULL,
	[ProductReference] [nvarchar](32) NULL,
	[ProductManufacturerReference] [nvarchar](128) NOT NULL,
	[ProductBarCode] [char](16) NULL,
	[ProductAddingDate] [datetime] NOT NULL,
	[ProductDiscontinued] [bit] NOT NULL,
	[VATCategoryID] [int] NOT NULL,
	[UnitTypeID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[MediaID] [int] NOT NULL,
 CONSTRAINT [PK_ProductID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductSizeCategory]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSizeCategory](
	[ProductID] [int] NOT NULL,
	[SizeCategoryID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_ProductSizeCategory] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[SizeCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SizeCategory]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SizeCategory](
	[SizeCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[SizeCategoryName] [nvarchar](64) NOT NULL,
	[SizeCategoryInitial] [char](4) NOT NULL,
 CONSTRAINT [PK_SizeCategoryID] PRIMARY KEY CLUSTERED 
(
	[SizeCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UnitType]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitType](
	[UnitTypeID] [int] IDENTITY(1,1) NOT NULL,
	[UnitTypeName] [nvarchar](48) NOT NULL,
	[UnitTypeSymbol] [nvarchar](16) NULL,
 CONSTRAINT [PK_UnitTypeID] PRIMARY KEY CLUSTERED 
(
	[UnitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 23/05/2014 14:32:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserUsername] [nvarchar](128) NOT NULL,
	[UserPassword] [nvarchar](255) NOT NULL,
	[UserEmail] [nvarchar](160) NOT NULL,
	[UserSalt] [nvarchar](32) NOT NULL,
	[UserRegisterDate] [datetime] NOT NULL,
	[UserLastLoginDate] [datetime] NULL,
 CONSTRAINT [PK_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT ((0)) FOR [CategoryIsMenu]
GO
ALTER TABLE [dbo].[Command] ADD  DEFAULT (getdate()) FOR [CommandDate]
GO
ALTER TABLE [dbo].[Price] ADD  DEFAULT (getdate()) FOR [PriceDate]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [ProductDiscontinued]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Customer]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_DeliverableCountry] FOREIGN KEY([DeliverableCountryID])
REFERENCES [dbo].[DeliverableCountry] ([DeliverableCountryID])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_DeliverableCountry]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Media] FOREIGN KEY([MediaID])
REFERENCES [dbo].[Media] ([MediaID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Media]
GO
ALTER TABLE [dbo].[Command]  WITH CHECK ADD  CONSTRAINT [FK_Command_CommandStatus] FOREIGN KEY([CommandStatusID])
REFERENCES [dbo].[CommandStatus] ([CommandStatusID])
GO
ALTER TABLE [dbo].[Command] CHECK CONSTRAINT [FK_Command_CommandStatus]
GO
ALTER TABLE [dbo].[Command]  WITH CHECK ADD  CONSTRAINT [FK_Command_DeliveryAddress] FOREIGN KEY([DeliveryAddressID])
REFERENCES [dbo].[Address] ([AddressID])
GO
ALTER TABLE [dbo].[Command] CHECK CONSTRAINT [FK_Command_DeliveryAddress]
GO
ALTER TABLE [dbo].[Command]  WITH CHECK ADD  CONSTRAINT [FK_Command_InvoiceAddress] FOREIGN KEY([InvoiceAddressID])
REFERENCES [dbo].[Address] ([AddressID])
GO
ALTER TABLE [dbo].[Command] CHECK CONSTRAINT [FK_Command_InvoiceAddress]
GO
ALTER TABLE [dbo].[CommandLine]  WITH CHECK ADD  CONSTRAINT [FK_CommandLine_Command] FOREIGN KEY([CommandID])
REFERENCES [dbo].[Command] ([CommandID])
GO
ALTER TABLE [dbo].[CommandLine] CHECK CONSTRAINT [FK_CommandLine_Command]
GO
ALTER TABLE [dbo].[CommandLine]  WITH CHECK ADD  CONSTRAINT [FK_CommandLine_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[CommandLine] CHECK CONSTRAINT [FK_CommandLine_Product]
GO
ALTER TABLE [dbo].[CommandStatus]  WITH CHECK ADD  CONSTRAINT [FK_CommandStatus_Media] FOREIGN KEY([MediaID])
REFERENCES [dbo].[Media] ([MediaID])
GO
ALTER TABLE [dbo].[CommandStatus] CHECK CONSTRAINT [FK_CommandStatus_Media]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_User]
GO
ALTER TABLE [dbo].[DeliverablePrice]  WITH CHECK ADD  CONSTRAINT [FK_DeliverablePrice_DeliverableCountry] FOREIGN KEY([DeliverablePriceCountryID])
REFERENCES [dbo].[DeliverableCountry] ([DeliverableCountryID])
GO
ALTER TABLE [dbo].[DeliverablePrice] CHECK CONSTRAINT [FK_DeliverablePrice_DeliverableCountry]
GO
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [FK_Media_MediaType] FOREIGN KEY([MediaTypeID])
REFERENCES [dbo].[MediaType] ([MediaTypeID])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [FK_Media_MediaType]
GO
ALTER TABLE [dbo].[MediaProduct]  WITH CHECK ADD  CONSTRAINT [FK_MediaProduct_Media] FOREIGN KEY([MediaID])
REFERENCES [dbo].[Media] ([MediaID])
GO
ALTER TABLE [dbo].[MediaProduct] CHECK CONSTRAINT [FK_MediaProduct_Media]
GO
ALTER TABLE [dbo].[MediaProduct]  WITH CHECK ADD  CONSTRAINT [FK_MediaProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[MediaProduct] CHECK CONSTRAINT [FK_MediaProduct_Product]
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD  CONSTRAINT [FK_Price_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Price] CHECK CONSTRAINT [FK_Price_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Media] FOREIGN KEY([MediaID])
REFERENCES [dbo].[Media] ([MediaID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Media]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_UnitType] FOREIGN KEY([UnitTypeID])
REFERENCES [dbo].[UnitType] ([UnitTypeID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_UnitType]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_VATCategory] FOREIGN KEY([VATCategoryID])
REFERENCES [dbo].[SizeCategory] ([SizeCategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_VATCategory]
GO
ALTER TABLE [dbo].[ProductSizeCategory]  WITH CHECK ADD  CONSTRAINT [FK_SizeCategory_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductSizeCategory] CHECK CONSTRAINT [FK_SizeCategory_Product]
GO
ALTER TABLE [dbo].[ProductSizeCategory]  WITH CHECK ADD  CONSTRAINT [FK_SizeCategory_SizeCategory] FOREIGN KEY([SizeCategoryID])
REFERENCES [dbo].[SizeCategory] ([SizeCategoryID])
GO
ALTER TABLE [dbo].[ProductSizeCategory] CHECK CONSTRAINT [FK_SizeCategory_SizeCategory]
GO
USE [master]
GO
ALTER DATABASE [eShopDB] SET  READ_WRITE 
GO
