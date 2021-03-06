use master
go
Drop database eShopDB
go
Create database eShopDB
go
use eShopDB
go
 
CREATE TABLE [Role]( 
RoleID INT IDENTITY(1,1) NOT NULL, 
RoleName NVARCHAR(128) NOT NULL, 
CONSTRAINT PK_RoleID PRIMARY KEY (RoleID)
)

CREATE TABLE [User]( 
UserID INT IDENTITY(1,1) NOT NULL, 
UserUsername NVARCHAR(128) NOT NULL UNIQUE, 
UserPassword NVARCHAR(255) NOT NULL, 
UserEmail NVARCHAR(160) NOT NULL UNIQUE, 
UserSalt NVARCHAR(32) NOT NULL, 
UserRegisterDate DATETIME NOT NULL, 
UserLastLoginDate DATETIME NULL, 
CONSTRAINT PK_UserID PRIMARY KEY (UserID),
) 

CREATE TABLE UsersInRoles(
UsersInRolesUserID INT NOT NULL,
UsersInRolesRoleID INT NOT NULL,
CONSTRAINT PKUsersInRoles PRIMARY KEY (UsersInRolesUserID, UsersInRolesRoleID),
CONSTRAINT FK_UsersInRoles_Role FOREIGN KEY (UsersInRolesRoleID) REFERENCES [Role](RoleID),
CONSTRAINT FK_User_UsersInRoles FOREIGN KEY (UsersInRolesUserID) REFERENCES [User](UserID)
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

CREATE TABLE [Address]( 
AddressID INT IDENTITY(1,1) NOT NULL, 
AddressCompany NVARCHAR(64) NULL, 
AddressLine1 NVARCHAR(128) NOT NULL, 
AddressLine2 NVARCHAR(128) NULL, 
AddressZipCode NVARCHAR(16) NOT NULL, 
AddressType BIT NOT NULL, 
AddressActive BIT NOT NULL, 
DeliverableCountryID INT NOT NULL, 
CustomerID INT NOT NULL 
CONSTRAINT PK_AddressID PRIMARY KEY (AddressID), 
CONSTRAINT FK_Address_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), 
CONSTRAINT FK_Address_DeliverableCountry FOREIGN KEY (DeliverableCountryID) REFERENCES DeliverableCountry(DeliverableCountryID) 
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
MediaTypeID INT NULL, 
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
MediaID INT NULL, 
CONSTRAINT PK_CategoryID PRIMARY KEY (CategoryID), 
CONSTRAINT FK_Category_Media FOREIGN KEY (MediaID) REFERENCES Media(MediaID) 
)

CREATE TABLE SizeCategory( 
SizeCategoryID INT IDENTITY(1,1) NOT NULL, 
SizeCategoryName NVARCHAR(64) NOT NULL,
SizeCategoryInitial NVARCHAR(4) NOT NULL,
CONSTRAINT PK_SizeCategoryID PRIMARY KEY (SizeCategoryID) 
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
CategoryID INT NOT NULL, 
CONSTRAINT PK_ProductID PRIMARY KEY (ProductID), 
CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
) 

CREATE TABLE MediaProduct( 
ProductID INT NOT NULL, 
MediaID INT NOT NULL,  
CONSTRAINT PK_MediaProduct PRIMARY KEY (ProductID, MediaID),
CONSTRAINT FK_MediaProduct_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
CONSTRAINT FK_MediaProduct_Media FOREIGN KEY (MediaID) REFERENCES Media(MediaID) ON DELETE CASCADE
) 

CREATE TABLE ProductSizeCategory( 
ProductID INT NOT NULL, 
SizeCategoryID INT NOT NULL,
Quantity INT NOT NULL, 
CONSTRAINT PK_ProductSizeCategory PRIMARY KEY (ProductID, SizeCategoryID),
CONSTRAINT FK_SizeCategory_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
CONSTRAINT FK_SizeCategory_SizeCategory FOREIGN KEY (SizeCategoryID) REFERENCES SizeCategory(SizeCategoryID) ON DELETE CASCADE
)

CREATE TABLE Price( 
PriceID INT IDENTITY(1,1) NOT NULL, 
PriceDate DATETIME NOT NULL DEFAULT GetDate(), 
PriceValue MONEY NOT NULL, 
ProductID INT NOT NULL, 
CONSTRAINT PK_PriceID PRIMARY KEY (PriceID), 
CONSTRAINT FK_Price_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
) 

CREATE TABLE Command( 
CommandID INT IDENTITY(1,1) NOT NULL, 
CommandDate DATETIME NOT NULL DEFAULT GetDate(), 
CommandFicsalDate DATETIME NOT NULL, 
CommandeReference NVARCHAR(32) NOT NULL, 
CommandStatusID INT NOT NULL, 
DeliveryAddressID INT NOT NULL, 
InvoiceAddressID INT NULL, 
CONSTRAINT PK_CommandID PRIMARY KEY (CommandID), 
CONSTRAINT FK_Command_CommandStatus FOREIGN KEY (CommandStatusID) REFERENCES CommandStatus(CommandStatusID), 
CONSTRAINT FK_Command_DeliveryAddress FOREIGN KEY (DeliveryAddressID) REFERENCES Address(AddressID), 
CONSTRAINT FK_Command_InvoiceAddress FOREIGN KEY (InvoiceAddressID) REFERENCES Address(AddressID) 
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

use eShopDB
go
DELETE FROM [User];
INSERT INTO [User] VALUES('admin', '63d9b16ce049763fc9d600b94daaa784', 'admin@prov.com', '791e30428f', '2014-06-25', '2014-06-25');
INSERT INTO [User] VALUES('user1', '34938585126483e176e87ee97320f236', 'user1@prov.com', '6fa7bcc595', '2014-06-26', '2014-06-26');

use eShopDB
go
DELETE FROM [Role];
INSERT INTO [Role] VALUES('Admin');

use eShopDB
go
DELETE FROM UsersInRoles;
INSERT INTO UsersInRoles VALUES(1, 1);

use eShopDB
go
DELETE FROM SizeCategory;
INSERT INTO SizeCategory VALUES('Small', 'S');
INSERT INTO SizeCategory VALUES('Medium', 'M');
INSERT INTO SizeCategory VALUES('Large', 'L');
INSERT INTO SizeCategory VALUES('X Large', 'XL');
INSERT INTO SizeCategory VALUES('XX Large', 'XXL');

use eShopDB
go
DELETE FROM Category;
INSERT INTO Category VALUES('Shirt', 'Men Shirt', 1, null);
INSERT INTO Category VALUES('T-shirts & Polos', 'Men T-shirts & Polos', 1, null);
INSERT INTO Category VALUES('Coats & Jackets', 'Men Coats & Jackets', 1, null);

use eShopDB
go
DELETE FROM Product;
INSERT INTO Product VALUES('China', 'Desigual China', 'Desigual men''s China shirt - available in plain and neutral tones, with a Desigual touch on the front that''s neither over-the-top nor too detailed: an ensemble of prints, embroidery and patches.', 'CHINAD25FD254', 'DESIGUAL45SDF4', '1565465668', '02/05/2014', 0, 1 );
INSERT INTO Product VALUES('Cachos', 'Desigual Cachos', 'Desigual men''s Cachos shirt. This shirt was worn by the best international models on the catwalk at New York Fashion Week.', 'Cachos25FD254', 'DESIGUAL45SDF4', '8546327915', '03/05/2014', 0, 1 );
INSERT INTO Product VALUES('Ciudad Flores', 'Desigual Ciudad Flores', 'Desigual men�s Ciudad Flores shirt. An item for the boldest Desigual men who prefer their garments with lots of graphics.', 'CIUDADFLORES', 'DESIGUAL45SDF4', '31568735647', '02/02/2014', 0, 1 );
INSERT INTO Product VALUES('Miguelito', 'Desigual Miguelito', 'Desigual men�s Miguelito T-shirt with a wide horizontal stripe print.', 'MIGUELITO254', 'DESIGUAL45SDF4', '7541635894', '05/04/2014', 0, 2 );
INSERT INTO Product VALUES('Divin', 'Desigual Divin', 'Desigual men�s Divin T-shirt. Short-sleeved.', 'DIVIND25FD254', 'DESIGUAL45SDF4', '3246315874', '02/03/2014', 0, 2 );
INSERT INTO Product VALUES('Imporahi', 'Desigual Imporahi', 'Desigual men''s Imporahi blazer. A plain, very simple blazer that reflects the essence of Desigual thanks to the handwritten messages and doodles.', 'IMPORAHIFD254', 'DESIGUAL45SDF4', '3452178965', '02/04/2014', 0, 3 );
INSERT INTO Product VALUES('Sigula', 'Desigual Sigula', 'MAN WOVEN OVERCOAT BLAZER LONG SLEEVE.', 'SIGULAHIFD254', 'DESIGUAL45SDF4', '31524785421', '06/04/2014', 0, 3 );
INSERT INTO Product VALUES('Flores', 'Desigual Flores', 'Desigual men�s Flores short-sleeved shirt. An item for the boldest Desigual men who prefer their garments with more graphics so they don�t go unnoticed.', 'FLORESFD254', 'DESIGUAL45SDF4', '1565465668', '02/02/2014', 0, 1 );
INSERT INTO Product VALUES('David', 'Desigual David', 'Desigual men''s David shirt. This T-shirt was worn by the best international models on the catwalk at New York Fashion Week.', 'DAVIDFD254', 'DESIGUAL45SDF4', '1565465668', '02/02/2014', 0, 1 );
INSERT INTO Product VALUES('Cucumis', 'Desigual Cucumis', 'Desigual men''s Cucumis shirt, in a naval style for a very original sporty look.', 'CUCUMIS254', 'DESIGUAL45SDF4', '1565465668', '02/02/2014', 0, 1 );

use eShopDB
go
DELETE FROM ProductSizeCategory;
INSERT INTO ProductSizeCategory VALUES(1, 1, 35);
INSERT INTO ProductSizeCategory VALUES(1, 2, 85);
INSERT INTO ProductSizeCategory VALUES(1, 3, 45);
INSERT INTO ProductSizeCategory VALUES(1, 4, 147);
INSERT INTO ProductSizeCategory VALUES(2, 1, 35);
INSERT INTO ProductSizeCategory VALUES(2, 3, 45);
INSERT INTO ProductSizeCategory VALUES(2, 4, 78);

INSERT INTO ProductSizeCategory VALUES(3, 1, 35);
INSERT INTO ProductSizeCategory VALUES(3, 2, 85);
INSERT INTO ProductSizeCategory VALUES(3, 3, 45);
INSERT INTO ProductSizeCategory VALUES(3, 4, 147);
INSERT INTO ProductSizeCategory VALUES(4, 1, 35);
INSERT INTO ProductSizeCategory VALUES(4, 3, 45);
INSERT INTO ProductSizeCategory VALUES(4, 4, 78);

INSERT INTO ProductSizeCategory VALUES(5, 2, 35);
INSERT INTO ProductSizeCategory VALUES(5, 3, 45);
INSERT INTO ProductSizeCategory VALUES(6, 4, 147);
INSERT INTO ProductSizeCategory VALUES(6, 2, 85);
INSERT INTO ProductSizeCategory VALUES(7, 1, 35);
INSERT INTO ProductSizeCategory VALUES(7, 3, 45);
INSERT INTO ProductSizeCategory VALUES(7, 4, 78);

INSERT INTO ProductSizeCategory VALUES(8, 1, 14);
INSERT INTO ProductSizeCategory VALUES(8, 3, 4);
INSERT INTO ProductSizeCategory VALUES(8, 4, 102);
INSERT INTO ProductSizeCategory VALUES(9, 1, 14);
INSERT INTO ProductSizeCategory VALUES(9, 2, 4);
INSERT INTO ProductSizeCategory VALUES(9, 3, 102);
INSERT INTO ProductSizeCategory VALUES(10, 1, 15);
INSERT INTO ProductSizeCategory VALUES(10, 2, 43);
INSERT INTO ProductSizeCategory VALUES(10, 3, 12);

use eShopDB
go
DELETE FROM Price;
INSERT INTO Price VALUES('02/02/2014', 78.00, 1);
INSERT INTO Price VALUES('02/03/2014', 68.00, 1);
INSERT INTO Price VALUES('02/02/2014', 120.00, 2);
INSERT INTO Price VALUES('02/02/2014', 150.00, 3);
INSERT INTO Price VALUES('02/04/2014', 180.00, 3);
INSERT INTO Price VALUES('02/02/2014', 85.00, 4);
INSERT INTO Price VALUES('02/02/2014', 25.00, 5);
INSERT INTO Price VALUES('02/02/2014', 123.00, 6);
INSERT INTO Price VALUES('02/02/2014', 60.00, 7);
INSERT INTO Price VALUES('02/05/2014', 75.00, 7);
INSERT INTO Price VALUES('02/02/2014', 68.00, 8);
INSERT INTO Price VALUES('02/05/2014', 102.00, 8);
INSERT INTO Price VALUES('02/05/2014', 86.00, 9);
INSERT INTO Price VALUES('02/05/2014', 96.00, 10);

use eShopDB
go
DELETE FROM Media;
INSERT INTO Media VALUES('China', '', '~/Uploads/Product/1/1.jpg', null);
INSERT INTO Media VALUES('China', '', '~/Uploads/Product/1/2.jpg', null);
INSERT INTO Media VALUES('China', '', '~/Uploads/Product/1/3.jpg', null);

INSERT INTO Media VALUES('Cachos', '', '~/Uploads/Product/2/1.jpg', null);
INSERT INTO Media VALUES('Cachos', '', '~/Uploads/Product/2/2.jpg', null);
INSERT INTO Media VALUES('Cachos', '', '~/Uploads/Product/2/3.jpg', null);

INSERT INTO Media VALUES('Ciudad Flores', '', '~/Uploads/Product/3/1.jpg', null);
INSERT INTO Media VALUES('Ciudad Flores', '', '~/Uploads/Product/3/2.jpg', null);
INSERT INTO Media VALUES('Ciudad Flores', '', '~/Uploads/Product/3/3.jpg', null);

INSERT INTO Media VALUES('Miguelito', '', '~/Uploads/Product/4/1.jpg', null);
INSERT INTO Media VALUES('Miguelito', '', '~/Uploads/Product/4/2.jpg', null);
INSERT INTO Media VALUES('Miguelito', '', '~/Uploads/Product/4/3.jpg', null);

INSERT INTO Media VALUES('Divin', '', '~/Uploads/Product/5/1.jpg', null);
INSERT INTO Media VALUES('Divin', '', '~/Uploads/Product/5/2.jpg', null);
INSERT INTO Media VALUES('Divin', '', '~/Uploads/Product/5/3.jpg', null);

INSERT INTO Media VALUES('Imporahi', '', '~/Uploads/Product/6/1.jpg', null);
INSERT INTO Media VALUES('Imporahi', '', '~/Uploads/Product/6/2.jpg', null);
INSERT INTO Media VALUES('Imporahi', '', '~/Uploads/Product/6/3.jpg', null);

INSERT INTO Media VALUES('Sigula', '', '~/Uploads/Product/7/1.jpg', null);
INSERT INTO Media VALUES('Sigula', '', '~/Uploads/Product/7/2.jpg', null);
INSERT INTO Media VALUES('Sigula', '', '~/Uploads/Product/7/3.jpg', null);

INSERT INTO Media VALUES('Flores', '', '~/Uploads/Product/8/1.jpg', null);
INSERT INTO Media VALUES('Flores', '', '~/Uploads/Product/8/2.jpg', null);
INSERT INTO Media VALUES('Flores', '', '~/Uploads/Product/8/3.jpg', null);

INSERT INTO Media VALUES('David', '', '~/Uploads/Product/9/1.jpg', null);
INSERT INTO Media VALUES('David', '', '~/Uploads/Product/9/2.jpg', null);
INSERT INTO Media VALUES('David', '', '~/Uploads/Product/9/3.jpg', null);

INSERT INTO Media VALUES('Cucumis', '', '~/Uploads/Product/10/1.jpg', null);
INSERT INTO Media VALUES('Cucumis', '', '~/Uploads/Product/10/2.jpg', null);
INSERT INTO Media VALUES('Cucumis', '', '~/Uploads/Product/10/3.jpg', null);

use eShopDB
go
DELETE FROM MediaProduct;
INSERT INTO MediaProduct VALUES(1, 1);
INSERT INTO MediaProduct VALUES(1, 2);
INSERT INTO MediaProduct VALUES(1, 3);

INSERT INTO MediaProduct VALUES(2, 4);
INSERT INTO MediaProduct VALUES(2, 5);
INSERT INTO MediaProduct VALUES(2, 6);

INSERT INTO MediaProduct VALUES(3, 7);
INSERT INTO MediaProduct VALUES(3, 8);
INSERT INTO MediaProduct VALUES(3, 9);

INSERT INTO MediaProduct VALUES(4, 10);
INSERT INTO MediaProduct VALUES(4, 11);
INSERT INTO MediaProduct VALUES(4, 12);

INSERT INTO MediaProduct VALUES(5, 13);
INSERT INTO MediaProduct VALUES(5, 14);
INSERT INTO MediaProduct VALUES(5, 15);

INSERT INTO MediaProduct VALUES(6, 16);
INSERT INTO MediaProduct VALUES(6, 17);
INSERT INTO MediaProduct VALUES(6, 18);

INSERT INTO MediaProduct VALUES(7, 19);
INSERT INTO MediaProduct VALUES(7, 20);
INSERT INTO MediaProduct VALUES(7, 21);

INSERT INTO MediaProduct VALUES(8, 22);
INSERT INTO MediaProduct VALUES(8, 23);
INSERT INTO MediaProduct VALUES(8, 24);

INSERT INTO MediaProduct VALUES(9, 25);
INSERT INTO MediaProduct VALUES(9, 26);
INSERT INTO MediaProduct VALUES(9, 27);

INSERT INTO MediaProduct VALUES(10, 28);
INSERT INTO MediaProduct VALUES(10, 29);
INSERT INTO MediaProduct VALUES(10, 30);