
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 06/02/2014 13:21:58
-- Generated from EDMX file: C:\Users\Admin.PC-CZC1213R5T\Desktop\Project\eShopLab\Models\eShopDB.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [eShopDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Address_Customer]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Address_Customer];
GO
IF OBJECT_ID(N'[dbo].[FK_Address_DeliverableCountry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Address_DeliverableCountry];
GO
IF OBJECT_ID(N'[dbo].[FK_Category_Media]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Category] DROP CONSTRAINT [FK_Category_Media];
GO
IF OBJECT_ID(N'[dbo].[FK_Command_CommandStatus]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Command] DROP CONSTRAINT [FK_Command_CommandStatus];
GO
IF OBJECT_ID(N'[dbo].[FK_Command_DeliveryAddress]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Command] DROP CONSTRAINT [FK_Command_DeliveryAddress];
GO
IF OBJECT_ID(N'[dbo].[FK_Command_InvoiceAddress]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Command] DROP CONSTRAINT [FK_Command_InvoiceAddress];
GO
IF OBJECT_ID(N'[dbo].[FK_CommandLine_Command]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommandLine] DROP CONSTRAINT [FK_CommandLine_Command];
GO
IF OBJECT_ID(N'[dbo].[FK_CommandLine_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommandLine] DROP CONSTRAINT [FK_CommandLine_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_CommandStatus_Media]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommandStatus] DROP CONSTRAINT [FK_CommandStatus_Media];
GO
IF OBJECT_ID(N'[dbo].[FK_Customer_User]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [FK_Customer_User];
GO
IF OBJECT_ID(N'[dbo].[FK_DeliverablePrice_DeliverableCountry]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[DeliverablePrice] DROP CONSTRAINT [FK_DeliverablePrice_DeliverableCountry];
GO
IF OBJECT_ID(N'[dbo].[FK_Media_MediaType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Media] DROP CONSTRAINT [FK_Media_MediaType];
GO
IF OBJECT_ID(N'[dbo].[FK_MediaProduct_Media]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MediaProduct] DROP CONSTRAINT [FK_MediaProduct_Media];
GO
IF OBJECT_ID(N'[dbo].[FK_MediaProduct_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MediaProduct] DROP CONSTRAINT [FK_MediaProduct_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_Price_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Price] DROP CONSTRAINT [FK_Price_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_Product_Category]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_Category];
GO
IF OBJECT_ID(N'[dbo].[FK_SizeCategory_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductSizeCategory] DROP CONSTRAINT [FK_SizeCategory_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_SizeCategory_SizeCategory]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductSizeCategory] DROP CONSTRAINT [FK_SizeCategory_SizeCategory];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Address]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Address];
GO
IF OBJECT_ID(N'[dbo].[Category]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Category];
GO
IF OBJECT_ID(N'[dbo].[Command]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Command];
GO
IF OBJECT_ID(N'[dbo].[CommandLine]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CommandLine];
GO
IF OBJECT_ID(N'[dbo].[CommandStatus]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CommandStatus];
GO
IF OBJECT_ID(N'[dbo].[Customer]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Customer];
GO
IF OBJECT_ID(N'[dbo].[DeliverableCountry]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DeliverableCountry];
GO
IF OBJECT_ID(N'[dbo].[DeliverablePrice]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DeliverablePrice];
GO
IF OBJECT_ID(N'[dbo].[Media]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Media];
GO
IF OBJECT_ID(N'[dbo].[MediaProduct]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MediaProduct];
GO
IF OBJECT_ID(N'[dbo].[MediaType]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MediaType];
GO
IF OBJECT_ID(N'[dbo].[Price]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Price];
GO
IF OBJECT_ID(N'[dbo].[Product]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Product];
GO
IF OBJECT_ID(N'[dbo].[ProductSizeCategory]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductSizeCategory];
GO
IF OBJECT_ID(N'[dbo].[SizeCategory]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SizeCategory];
GO
IF OBJECT_ID(N'[dbo].[User]', 'U') IS NOT NULL
    DROP TABLE [dbo].[User];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Addresses'
CREATE TABLE [dbo].[Addresses] (
    [AddressID] int IDENTITY(1,1) NOT NULL,
    [AddressCompany] nvarchar(64)  NULL,
    [AddressLine1] nvarchar(128)  NOT NULL,
    [AddressLine2] nvarchar(128)  NULL,
    [AddressZipCode] nvarchar(16)  NOT NULL,
    [AddressType] bit  NOT NULL,
    [AddressActive] bit  NOT NULL,
    [DeliverableCountryID] int  NOT NULL,
    [CustomerID] int  NOT NULL
);
GO

-- Creating table 'Categories'
CREATE TABLE [dbo].[Categories] (
    [CategoryID] int IDENTITY(1,1) NOT NULL,
    [CategoryName] nvarchar(64)  NOT NULL,
    [CategoryDescription] nvarchar(255)  NOT NULL,
    [CategoryIsMenu] bit  NOT NULL,
    [MediaID] int  NULL
);
GO

-- Creating table 'Commands'
CREATE TABLE [dbo].[Commands] (
    [CommandID] int IDENTITY(1,1) NOT NULL,
    [CommandDate] datetime  NOT NULL,
    [CommandFicsalDate] datetime  NOT NULL,
    [CommandeReference] nvarchar(32)  NOT NULL,
    [CommandStatusID] int  NOT NULL,
    [DeliveryAddressID] int  NOT NULL,
    [InvoiceAddressID] int  NULL
);
GO

-- Creating table 'CommandLines'
CREATE TABLE [dbo].[CommandLines] (
    [CommandLineID] int IDENTITY(1,1) NOT NULL,
    [CommandLineQuantity] int  NOT NULL,
    [CommandLinePrice] decimal(19,4)  NOT NULL,
    [CommandID] int  NOT NULL,
    [ProductID] int  NOT NULL
);
GO

-- Creating table 'CommandStatus'
CREATE TABLE [dbo].[CommandStatus] (
    [CommandStatusID] int IDENTITY(1,1) NOT NULL,
    [CommandStatusName] nvarchar(64)  NOT NULL,
    [CommandStatusProgress] smallint  NOT NULL,
    [MediaID] int  NOT NULL
);
GO

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [CustomerID] int IDENTITY(1,1) NOT NULL,
    [CustomerLastName] nvarchar(64)  NOT NULL,
    [CustomerFirstName] nvarchar(64)  NOT NULL,
    [CustomerCompany] nvarchar(96)  NULL,
    [CustomerActive] bit  NOT NULL,
    [UserID] int  NOT NULL
);
GO

-- Creating table 'DeliverableCountries'
CREATE TABLE [dbo].[DeliverableCountries] (
    [DeliverableCountryID] int IDENTITY(1,1) NOT NULL,
    [DeliverableCountryName] nvarchar(48)  NOT NULL
);
GO

-- Creating table 'DeliverablePrices'
CREATE TABLE [dbo].[DeliverablePrices] (
    [DeliverablePriceID] int IDENTITY(1,1) NOT NULL,
    [DeliverablePriceName] nvarchar(64)  NOT NULL,
    [DeliverablePriceTimeEstimation] tinyint  NOT NULL,
    [DeliverablePriceValue] decimal(10,4)  NOT NULL,
    [DeliverablePriceCountryID] int  NOT NULL
);
GO

-- Creating table 'Media'
CREATE TABLE [dbo].[Media] (
    [MediaID] int IDENTITY(1,1) NOT NULL,
    [MediaName] nvarchar(64)  NOT NULL,
    [MediaAlt] nvarchar(128)  NULL,
    [MediaUrl] nvarchar(max)  NOT NULL,
    [MediaTypeID] int  NULL
);
GO

-- Creating table 'MediaTypes'
CREATE TABLE [dbo].[MediaTypes] (
    [MediaTypeID] int IDENTITY(1,1) NOT NULL,
    [MediaTypeName] nvarchar(64)  NOT NULL,
    [MediaTypeExtension] nvarchar(8)  NULL
);
GO

-- Creating table 'Prices'
CREATE TABLE [dbo].[Prices] (
    [PriceID] int IDENTITY(1,1) NOT NULL,
    [PriceDate] datetime  NOT NULL,
    [PriceValue] decimal(19,4)  NOT NULL,
    [ProductID] int  NOT NULL
);
GO

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [ProductID] int IDENTITY(1,1) NOT NULL,
    [ProductName] nvarchar(128)  NOT NULL,
    [ProductDescription] nvarchar(255)  NULL,
    [ProductLongDescription] varchar(max)  NULL,
    [ProductReference] nvarchar(32)  NULL,
    [ProductManufacturerReference] nvarchar(128)  NOT NULL,
    [ProductBarCode] char(16)  NULL,
    [ProductAddingDate] datetime  NOT NULL,
    [ProductDiscontinued] bit  NOT NULL,
    [CategoryID] int  NOT NULL
);
GO

-- Creating table 'ProductSizeCategories'
CREATE TABLE [dbo].[ProductSizeCategories] (
    [ProductID] int  NOT NULL,
    [SizeCategoryID] int  NOT NULL,
    [Quantity] int  NOT NULL
);
GO

-- Creating table 'SizeCategories'
CREATE TABLE [dbo].[SizeCategories] (
    [SizeCategoryID] int IDENTITY(1,1) NOT NULL,
    [SizeCategoryName] nvarchar(64)  NOT NULL,
    [SizeCategoryInitial] char(4)  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [UserID] int IDENTITY(1,1) NOT NULL,
    [UserUsername] nvarchar(128)  NOT NULL,
    [UserPassword] nvarchar(255)  NOT NULL,
    [UserEmail] nvarchar(160)  NOT NULL,
    [UserSalt] nvarchar(32)  NOT NULL,
    [UserRegisterDate] datetime  NOT NULL,
    [UserLastLoginDate] datetime  NULL
);
GO

-- Creating table 'MediaProduct'
CREATE TABLE [dbo].[MediaProduct] (
    [Media_MediaID] int  NOT NULL,
    [Products_ProductID] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [AddressID] in table 'Addresses'
ALTER TABLE [dbo].[Addresses]
ADD CONSTRAINT [PK_Addresses]
    PRIMARY KEY CLUSTERED ([AddressID] ASC);
GO

-- Creating primary key on [CategoryID] in table 'Categories'
ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [PK_Categories]
    PRIMARY KEY CLUSTERED ([CategoryID] ASC);
GO

-- Creating primary key on [CommandID] in table 'Commands'
ALTER TABLE [dbo].[Commands]
ADD CONSTRAINT [PK_Commands]
    PRIMARY KEY CLUSTERED ([CommandID] ASC);
GO

-- Creating primary key on [CommandLineID] in table 'CommandLines'
ALTER TABLE [dbo].[CommandLines]
ADD CONSTRAINT [PK_CommandLines]
    PRIMARY KEY CLUSTERED ([CommandLineID] ASC);
GO

-- Creating primary key on [CommandStatusID] in table 'CommandStatus'
ALTER TABLE [dbo].[CommandStatus]
ADD CONSTRAINT [PK_CommandStatus]
    PRIMARY KEY CLUSTERED ([CommandStatusID] ASC);
GO

-- Creating primary key on [CustomerID] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([CustomerID] ASC);
GO

-- Creating primary key on [DeliverableCountryID] in table 'DeliverableCountries'
ALTER TABLE [dbo].[DeliverableCountries]
ADD CONSTRAINT [PK_DeliverableCountries]
    PRIMARY KEY CLUSTERED ([DeliverableCountryID] ASC);
GO

-- Creating primary key on [DeliverablePriceID] in table 'DeliverablePrices'
ALTER TABLE [dbo].[DeliverablePrices]
ADD CONSTRAINT [PK_DeliverablePrices]
    PRIMARY KEY CLUSTERED ([DeliverablePriceID] ASC);
GO

-- Creating primary key on [MediaID] in table 'Media'
ALTER TABLE [dbo].[Media]
ADD CONSTRAINT [PK_Media]
    PRIMARY KEY CLUSTERED ([MediaID] ASC);
GO

-- Creating primary key on [MediaTypeID] in table 'MediaTypes'
ALTER TABLE [dbo].[MediaTypes]
ADD CONSTRAINT [PK_MediaTypes]
    PRIMARY KEY CLUSTERED ([MediaTypeID] ASC);
GO

-- Creating primary key on [PriceID] in table 'Prices'
ALTER TABLE [dbo].[Prices]
ADD CONSTRAINT [PK_Prices]
    PRIMARY KEY CLUSTERED ([PriceID] ASC);
GO

-- Creating primary key on [ProductID] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([ProductID] ASC);
GO

-- Creating primary key on [ProductID], [SizeCategoryID] in table 'ProductSizeCategories'
ALTER TABLE [dbo].[ProductSizeCategories]
ADD CONSTRAINT [PK_ProductSizeCategories]
    PRIMARY KEY CLUSTERED ([ProductID], [SizeCategoryID] ASC);
GO

-- Creating primary key on [SizeCategoryID] in table 'SizeCategories'
ALTER TABLE [dbo].[SizeCategories]
ADD CONSTRAINT [PK_SizeCategories]
    PRIMARY KEY CLUSTERED ([SizeCategoryID] ASC);
GO

-- Creating primary key on [UserID] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([UserID] ASC);
GO

-- Creating primary key on [Media_MediaID], [Products_ProductID] in table 'MediaProduct'
ALTER TABLE [dbo].[MediaProduct]
ADD CONSTRAINT [PK_MediaProduct]
    PRIMARY KEY NONCLUSTERED ([Media_MediaID], [Products_ProductID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CustomerID] in table 'Addresses'
ALTER TABLE [dbo].[Addresses]
ADD CONSTRAINT [FK_Address_Customer]
    FOREIGN KEY ([CustomerID])
    REFERENCES [dbo].[Customers]
        ([CustomerID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Address_Customer'
CREATE INDEX [IX_FK_Address_Customer]
ON [dbo].[Addresses]
    ([CustomerID]);
GO

-- Creating foreign key on [DeliverableCountryID] in table 'Addresses'
ALTER TABLE [dbo].[Addresses]
ADD CONSTRAINT [FK_Address_DeliverableCountry]
    FOREIGN KEY ([DeliverableCountryID])
    REFERENCES [dbo].[DeliverableCountries]
        ([DeliverableCountryID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Address_DeliverableCountry'
CREATE INDEX [IX_FK_Address_DeliverableCountry]
ON [dbo].[Addresses]
    ([DeliverableCountryID]);
GO

-- Creating foreign key on [DeliveryAddressID] in table 'Commands'
ALTER TABLE [dbo].[Commands]
ADD CONSTRAINT [FK_Command_DeliveryAddress]
    FOREIGN KEY ([DeliveryAddressID])
    REFERENCES [dbo].[Addresses]
        ([AddressID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Command_DeliveryAddress'
CREATE INDEX [IX_FK_Command_DeliveryAddress]
ON [dbo].[Commands]
    ([DeliveryAddressID]);
GO

-- Creating foreign key on [InvoiceAddressID] in table 'Commands'
ALTER TABLE [dbo].[Commands]
ADD CONSTRAINT [FK_Command_InvoiceAddress]
    FOREIGN KEY ([InvoiceAddressID])
    REFERENCES [dbo].[Addresses]
        ([AddressID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Command_InvoiceAddress'
CREATE INDEX [IX_FK_Command_InvoiceAddress]
ON [dbo].[Commands]
    ([InvoiceAddressID]);
GO

-- Creating foreign key on [MediaID] in table 'Categories'
ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [FK_Category_Media]
    FOREIGN KEY ([MediaID])
    REFERENCES [dbo].[Media]
        ([MediaID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Category_Media'
CREATE INDEX [IX_FK_Category_Media]
ON [dbo].[Categories]
    ([MediaID]);
GO

-- Creating foreign key on [CategoryID] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_Product_Category]
    FOREIGN KEY ([CategoryID])
    REFERENCES [dbo].[Categories]
        ([CategoryID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Product_Category'
CREATE INDEX [IX_FK_Product_Category]
ON [dbo].[Products]
    ([CategoryID]);
GO

-- Creating foreign key on [CommandStatusID] in table 'Commands'
ALTER TABLE [dbo].[Commands]
ADD CONSTRAINT [FK_Command_CommandStatus]
    FOREIGN KEY ([CommandStatusID])
    REFERENCES [dbo].[CommandStatus]
        ([CommandStatusID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Command_CommandStatus'
CREATE INDEX [IX_FK_Command_CommandStatus]
ON [dbo].[Commands]
    ([CommandStatusID]);
GO

-- Creating foreign key on [CommandID] in table 'CommandLines'
ALTER TABLE [dbo].[CommandLines]
ADD CONSTRAINT [FK_CommandLine_Command]
    FOREIGN KEY ([CommandID])
    REFERENCES [dbo].[Commands]
        ([CommandID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CommandLine_Command'
CREATE INDEX [IX_FK_CommandLine_Command]
ON [dbo].[CommandLines]
    ([CommandID]);
GO

-- Creating foreign key on [ProductID] in table 'CommandLines'
ALTER TABLE [dbo].[CommandLines]
ADD CONSTRAINT [FK_CommandLine_Product]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ProductID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CommandLine_Product'
CREATE INDEX [IX_FK_CommandLine_Product]
ON [dbo].[CommandLines]
    ([ProductID]);
GO

-- Creating foreign key on [MediaID] in table 'CommandStatus'
ALTER TABLE [dbo].[CommandStatus]
ADD CONSTRAINT [FK_CommandStatus_Media]
    FOREIGN KEY ([MediaID])
    REFERENCES [dbo].[Media]
        ([MediaID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CommandStatus_Media'
CREATE INDEX [IX_FK_CommandStatus_Media]
ON [dbo].[CommandStatus]
    ([MediaID]);
GO

-- Creating foreign key on [UserID] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [FK_Customer_User]
    FOREIGN KEY ([UserID])
    REFERENCES [dbo].[Users]
        ([UserID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Customer_User'
CREATE INDEX [IX_FK_Customer_User]
ON [dbo].[Customers]
    ([UserID]);
GO

-- Creating foreign key on [DeliverablePriceCountryID] in table 'DeliverablePrices'
ALTER TABLE [dbo].[DeliverablePrices]
ADD CONSTRAINT [FK_DeliverablePrice_DeliverableCountry]
    FOREIGN KEY ([DeliverablePriceCountryID])
    REFERENCES [dbo].[DeliverableCountries]
        ([DeliverableCountryID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_DeliverablePrice_DeliverableCountry'
CREATE INDEX [IX_FK_DeliverablePrice_DeliverableCountry]
ON [dbo].[DeliverablePrices]
    ([DeliverablePriceCountryID]);
GO

-- Creating foreign key on [MediaTypeID] in table 'Media'
ALTER TABLE [dbo].[Media]
ADD CONSTRAINT [FK_Media_MediaType]
    FOREIGN KEY ([MediaTypeID])
    REFERENCES [dbo].[MediaTypes]
        ([MediaTypeID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Media_MediaType'
CREATE INDEX [IX_FK_Media_MediaType]
ON [dbo].[Media]
    ([MediaTypeID]);
GO

-- Creating foreign key on [ProductID] in table 'Prices'
ALTER TABLE [dbo].[Prices]
ADD CONSTRAINT [FK_Price_Product]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ProductID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Price_Product'
CREATE INDEX [IX_FK_Price_Product]
ON [dbo].[Prices]
    ([ProductID]);
GO

-- Creating foreign key on [ProductID] in table 'ProductSizeCategories'
ALTER TABLE [dbo].[ProductSizeCategories]
ADD CONSTRAINT [FK_SizeCategory_Product]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ProductID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [SizeCategoryID] in table 'ProductSizeCategories'
ALTER TABLE [dbo].[ProductSizeCategories]
ADD CONSTRAINT [FK_SizeCategory_SizeCategory]
    FOREIGN KEY ([SizeCategoryID])
    REFERENCES [dbo].[SizeCategories]
        ([SizeCategoryID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SizeCategory_SizeCategory'
CREATE INDEX [IX_FK_SizeCategory_SizeCategory]
ON [dbo].[ProductSizeCategories]
    ([SizeCategoryID]);
GO

-- Creating foreign key on [Media_MediaID] in table 'MediaProduct'
ALTER TABLE [dbo].[MediaProduct]
ADD CONSTRAINT [FK_MediaProduct_Media]
    FOREIGN KEY ([Media_MediaID])
    REFERENCES [dbo].[Media]
        ([MediaID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Products_ProductID] in table 'MediaProduct'
ALTER TABLE [dbo].[MediaProduct]
ADD CONSTRAINT [FK_MediaProduct_Product]
    FOREIGN KEY ([Products_ProductID])
    REFERENCES [dbo].[Products]
        ([ProductID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_MediaProduct_Product'
CREATE INDEX [IX_FK_MediaProduct_Product]
ON [dbo].[MediaProduct]
    ([Products_ProductID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------