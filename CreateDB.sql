﻿CREATE TABLE [User]( 
UserID INT IDENTITY(1,1) NOT NULL, 
UserUsername NVARCHAR(128) NOT NULL, 
UserPassword NVARCHAR(255) NOT NULL, 
UserEmail NVARCHAR(160) NOT NULL, 
UserSalt NVARCHAR(32) NOT NULL, 
UserRegisterDate DATETIME NOT NULL, 
UserLastLoginDate DATETIME NULL, 
CONSTRAINT PK_UserID PRIMARY KEY (UserID) 
)
 
CREATE TABLE DeliverableCountry( 
DeliverableCountryID INT IDENTITY(1,1) NOT NULL, 
DeliverableCountryName NVARCHAR(48) NOT NULL, 
CONSTRAINT PK_DeliverableCountryID PRIMARY KEY (DeliverableCountryID) 
)
 
CREATE TABLE DeliverablePrice( 
DeliverablePriceID INT IDENTITY(1,1) NOT NULL, 
DeliverablePriceName NVARCHAR(64) NOT NULL, 
DeliverablePriceTimeEstimation TINYINT NOT NULL, 
DeliverablePriceValue SMALLMONEY NOT NULL, 
DeliverablePriceCountryID INT NOT NULL, 
CONSTRAINT PK_DeliverablePriceID PRIMARY KEY (DeliverablePriceID), 
CONSTRAINT FK_DeliverablePrice_DeliverableCountry FOREIGN KEY (DeliverablePriceCountryID) REFERENCES DeliverableCountry(DeliverableCountryID) 
)
 
CREATE TABLE Customer( 
CustomerID INT IDENTITY(1,1) NOT NULL, 
CustomerLastName NVARCHAR(64) NOT NULL, 
CustomerFirstName NVARCHAR(64) NOT NULL, 
CustomerCompany NVARCHAR(96) NULL, 
CustomerActive BIT NOT NULL, 
UserID INT NOT NULL, 
CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID), 
CONSTRAINT FK_Customer_User FOREIGN KEY (UserID) REFERENCES [User](UserID) 
)

CREATE TABLE Adress( 
AdressID INT IDENTITY(1,1) NOT NULL, 
AdressCompany NVARCHAR(64) NULL, 
AdressLine1 NVARCHAR(128) NOT NULL, 
AdressLine2 NVARCHAR(128) NULL, 
AdressZipCode NVARCHAR(16) NOT NULL, 
AdressType BIT NOT NULL, 
AdressActive BIT NOT NULL, 
DeliverableCountryID INT NOT NULL, 
CustomerID INT NOT NULL 
CONSTRAINT PK_AdressID PRIMARY KEY (AdressID), 
CONSTRAINT FK_Adress_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), 
CONSTRAINT FK_Adress_DeliverableCountry FOREIGN KEY (DeliverableCountryID) REFERENCES DeliverableCountry(DeliverableCountryID) 
)
 
CREATE TABLE MediaType( 
MediaTypeID INT IDENTITY(1,1) NOT NULL, 
MediaTypeName NVARCHAR(64) NOT NULL, 
MediaTypeExtension NVARCHAR(8) NULL, 
CONSTRAINT PK_MediaTypeID PRIMARY KEY (MediaTypeID) 
) 

CREATE TABLE Media( 
MediaID INT IDENTITY(1,1) NOT NULL, 
[MediaName] NVARCHAR(64) NOT NULL, 
MediaAlt NVARCHAR(128) NULL, 
MediaUrl NVARCHAR(MAX) NOT NULL, 
MediaTypeID INT NOT NULL, 
CONSTRAINT PK_MediaID PRIMARY KEY (MediaID), 
CONSTRAINT FK_Media_MediaType FOREIGN KEY (MediaTypeID) REFERENCES MediaType(MediaTypeID) 
)
 
CREATE TABLE CommandStatus( 
CommandStatusID INT IDENTITY(1,1) NOT NULL, 
CommandStatusName NVARCHAR(64) NOT NULL, 
CommandStatusProgress SMALLINT NOT NULL, 
MediaID INT NOT NULL, 
CONSTRAINT PK_CommandStatusID PRIMARY KEY (CommandStatusID), 
CONSTRAINT FK_CommandStatus_Media FOREIGN KEY (MediaID) REFERENCES Media(MediaID) 
)
 
CREATE TABLE Category( 
CategoryID INT IDENTITY(1,1) NOT NULL, 
CategoryName NVARCHAR(64) NOT NULL, 
CategoryDescription NVARCHAR(255) NOT NULL, 
CategoryIsMenu BIT NOT NULL DEFAULT ((0)), 
MediaID INT NOT NULL, 
CONSTRAINT PK_CategoryID PRIMARY KEY (CategoryID), 
CONSTRAINT FK_Category_Media FOREIGN KEY (MediaID) REFERENCES Media(MediaID) 
)
 
CREATE TABLE UnitType( 
UnitTypeID INT IDENTITY(1,1) NOT NULL, 
UnitTypeName NVARCHAR(48) NOT NULL, 
UnitTypeSymbol NVARCHAR(16) NULL, 
CONSTRAINT PK_UnitTypeID PRIMARY KEY (UnitTypeID) 
)

CREATE TABLE VATCategory( 
VATCategoryID INT IDENTITY(1,1) NOT NULL, 
VATCategoryName NVARCHAR(64) NOT NULL, 
VATCategoryValue DECIMAL(5,3) NOT NULL DEFAULT ((0)), 
CONSTRAINT PK_VATCategoryID PRIMARY KEY (VATCategoryID) 
)
 
CREATE TABLE Product( 
ProductID INT IDENTITY(1,1) NOT NULL, 
ProductName NVARCHAR(128) NOT NULL, 
ProductDescription NVARCHAR(255) NULL, 
ProductLongDescription TEXT NULL, 
ProductReference NVARCHAR(32) NULL, 
ProductManufacturerReference NVARCHAR(128) NOT NULL, 
ProductBarCode CHAR(16) NULL, 
ProductAddingDate DATETIME NOT NULL, 
ProductDiscontinued BIT NOT NULL DEFAULT((0)), 
VATCategoryID INT NOT NULL, 
UnitTypeID INT NOT NULL, 
CategoryID INT NOT NULL, 
MediaID INT NOT NULL, 
CONSTRAINT PK_ProductID PRIMARY KEY (ProductID), 
CONSTRAINT FK_Product_VATCategory FOREIGN KEY (VATCategoryID) REFERENCES VATCategory(VATCategoryID), 
CONSTRAINT FK_Product_UnitType FOREIGN KEY (UnitTypeID) REFERENCES UnitType(UnitTypeID), 
CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID), 
CONSTRAINT FK_Product_Media FOREIGN KEY (MediaID) REFERENCES Media(MediaID) 
) 

CREATE TABLE Price( 
PriceID INT IDENTITY(1,1) NOT NULL, 
PriceDate DATETIME NOT NULL DEFAULT GetDate(), 
PriceValue MONEY NOT NULL, 
ProductID INT NOT NULL, 
CONSTRAINT PK_PriceID PRIMARY KEY (PriceID), 
CONSTRAINT FK_Price_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID) 
) 

CREATE TABLE Command( 
CommandID INT IDENTITY(1,1) NOT NULL, 
CommandDate DATETIME NOT NULL DEFAULT GetDate(), 
CommandFicsalDate DATETIME NOT NULL, 
CommandeReference NVARCHAR(32) NOT NULL, 
CommandStatusID INT NOT NULL, 
DeliveryAdressID INT NOT NULL, 
InvoiceAdressID INT NULL, 
CONSTRAINT PK_CommandID PRIMARY KEY (CommandID), 
CONSTRAINT FK_Command_CommandStatus FOREIGN KEY (CommandStatusID) REFERENCES CommandStatus(CommandStatusID), 
CONSTRAINT FK_Command_DeliveryAdress FOREIGN KEY (DeliveryAdressID) REFERENCES Adress(AdressID), 
CONSTRAINT FK_Command_InvoiceAdress FOREIGN KEY (InvoiceAdressID) REFERENCES Adress(AdressID) 
) 

CREATE TABLE CommandLine( 
CommandLineID INT IDENTITY(1,1) NOT NULL, 
CommandLineQuantity INT NOT NULL, 
CommandLinePrice MONEY NOT NULL, 
CommandID INT NOT NULL, 
ProductID INT NOT NULL, 
CONSTRAINT PK_CommandLineID PRIMARY KEY (CommandLineID), 
CONSTRAINT FK_CommandLine_Command FOREIGN KEY (CommandID) REFERENCES Command(CommandID), 
CONSTRAINT FK_CommandLine_Product FOREIGN KEY (ProductID) REFERENCES PRoduct(ProductID) 
) 
