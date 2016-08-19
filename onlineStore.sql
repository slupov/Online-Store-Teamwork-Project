USE [master]

WHILE EXISTS(select NULL from sys.databases where name='OnlineStorePSGM')
BEGIN
    DECLARE @SQL varchar(max)
    SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
    FROM MASTER..SysProcesses
    WHERE DBId = DB_ID(N'OnlineStorePSGM') AND SPId <> @@SPId
    EXEC(@SQL)
    DROP DATABASE [OnlineStorePSGM]
END
GO

CREATE DATABASE [OnlineStorePSGM]
GO
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineStorePSGM', FILENAME = N'C:\Users\Pesho\OnlineStorePSGM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineStorePSGM_log', FILENAME = N'C:\Users\Pesho\OnlineStorePSGM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [OnlineStorePSGM] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineStorePSGM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineStorePSGM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineStorePSGM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineStorePSGM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlineStorePSGM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineStorePSGM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OnlineStorePSGM] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineStorePSGM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineStorePSGM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineStorePSGM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineStorePSGM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlineStorePSGM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OnlineStorePSGM] SET QUERY_STORE = OFF
GO
USE [OnlineStorePSGM]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [OnlineStorePSGM]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 19-Aug-16 19:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 19-Aug-16 19:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Message] [ntext] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Member]    Script Date: 19-Aug-16 19:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Member](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[Password] [varbinary](64) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Fullname] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[Gender] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
 CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 19-Aug-16 19:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](400) NOT NULL,
	[ProductType] [nvarchar](50) NULL,
	[Description] [text] NULL,
	[Stock] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[ImageSource] [text] NULL,
	[MemberID] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rating]    Script Date: 19-Aug-16 19:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[RatingID] [int] NOT NULL,
	[MemberID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Value] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[RatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 19-Aug-16 19:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [int] NOT NULL,
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ApprovalStatus] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentID], [MemberID], [ProductID], [Message]) VALUES (1, 4, 1, N'A very very nice phone. I recommend it')
INSERT [dbo].[Comment] ([CommentID], [MemberID], [ProductID], [Message]) VALUES (2, 3, 2, N'Cool laptop computer, i got mine 3 days ago')
INSERT [dbo].[Comment] ([CommentID], [MemberID], [ProductID], [Message]) VALUES (3, 1, 3, N'Best audio on the market!')
INSERT [dbo].[Comment] ([CommentID], [MemberID], [ProductID], [Message]) VALUES (4, 4, 4, N'I like the picture clarity here , 10/10 :)')
SET IDENTITY_INSERT [dbo].[Comment] OFF
SET IDENTITY_INSERT [dbo].[Member] ON 

INSERT [dbo].[Member] ([MemberID], [Username], [Password], [Email], [Fullname], [Address], [Gender], [BirthDate]) VALUES (1, N'Slupov', 0xA320480F534776BDDB5CDB54B1E93D210A3C7D199E80A23C1B2178497B184C76, N'stoyan.lupov@gmail.com', N'Stoyan Lupov', NULL, N'Male', NULL)
INSERT [dbo].[Member] ([MemberID], [Username], [Password], [Email], [Fullname], [Address], [Gender], [BirthDate]) VALUES (2, N'Geri', 0xA320480F534776BDDB5CDB54B1E93D210A3C7D199E80A23C1B2178497B184C76, N'geri@gmail.com', N'Gergana', NULL, N'Female', NULL)
INSERT [dbo].[Member] ([MemberID], [Username], [Password], [Email], [Fullname], [Address], [Gender], [BirthDate]) VALUES (3, N'PeshoBre', 0xA320480F534776BDDB5CDB54B1E93D210A3C7D199E80A23C1B2178497B184C76, N'pesho@gmail.com', N'Petar Chernev', NULL, N'Male', NULL)
INSERT [dbo].[Member] ([MemberID], [Username], [Password], [Email], [Fullname], [Address], [Gender], [BirthDate]) VALUES (4, N'mimzi3', 0xA320480F534776BDDB5CDB54B1E93D210A3C7D199E80A23C1B2178497B184C76, N'mimzi3@gmail.com', N'Maria Velikova', NULL, N'Female', NULL)
SET IDENTITY_INSERT [dbo].[Member] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (1, N'Samsung Galaxy Note 5', N'Cell phone', NULL, 5, 699, N'https://fscl01.fonpit.de/userfiles/6727621/image/2nd_YEAR/Note5/androidpit-samsung-galaxy-note-5-16.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (2, N'Acer Aspire S7', N'Laptop', NULL, 12, 1199, N'https://images-na.ssl-images-amazon.com/images/I/61-KXWjHQcL._SL1000_.jpg', 4)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (3, N'Panasonic Dynamic Stereo Headphone RP-HTX7-C Beige', N'Headphones', NULL, 3, 79, N'http://thumbs.ebaystatic.com/images/g/ktAAAOSwD2pXF6FM/s-l225.jpg', 2)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (4, N'PSony KDL-48R510C 48-Inch 1080p Smart LED Television', N'TV', NULL, 4, 999, N'https://i.ytimg.com/vi/6NAkPmeMFXk/maxresdefault.jpg', 3)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (6, N'Kindle Voyage E-reader, 6&quot; High-Resolution Display (300 ppi) with Adaptive Built-in Light, PagePress Sensors, Wi-Fi - Includes Special Offers', N'kindle', N'<li>High-resolution 300 ppi display--reads even more like the printed page</li>;<li>PagePress enables you to turn the page without lifting a finger</li>;<li>Adaptive front light--provides ideal brightness, day or night</li>;<li>Battery lasts weeks, not hours</li>;<li>Try Kindle Unlimited free for 30 days--choose from over 1 million titles</li>', 2, 199.99000549316406, N'Kindle Voyage E-reader, 6&quot; High-Resolution Display (300 ppi) with Adaptive Built-in Light, PagePress Sensors, Wi-Fi - Includes Special Offers.jpg', 2)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (151, N'Samsung UN55KU6600 Curved 55-Inch 4K Ultra HD Smart LED TV (2016 Model)', N'Smart TVs', N'<li>Motion Rate: 120MR (Effective) designed with the sports and gaming enthusiast in mind</li>;<li>Smart Functionality: Yes- built in Wi-Fi, Bluetooth: Yes</li>;<li>Dimensions (W x H x D): TV without stand: 48.9 x 28.3 x 3.7, TV with stand: 48.9 x 30.7 x 12.2</li>;<li>Inputs: 3 HDMI, 2 USB, 1 Ethernet, 1 Component, 1 Composite In, 1 RF In, 1 Optical Audio</li>', 0, 847.99, N'Samsung UN55KU6600 Curved 55-Inch 4K Ultra HD Smart LED TV (2016 Model).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (153, N'Samsung UN65KS8500 Curved 65-Inch 4K Ultra HD Smart LED TV (2016 Model)', N'Smart TVs', N'<li>Backlight: LED</li>;<li>Smart Functionality: Yes, Built in Wi-Fi: Yes</li>;<li>Dimensions (W x H x D): TV without stand: 56.8" x 32.7" x 4.1", TV with stand: 56.8" x 35.7" x 11.7"</li>;<li>Inputs: 4 HDMI, 3 USB</li>', 0, 2197.99, N'Samsung UN65KS8500 Curved 65-Inch 4K Ultra HD Smart LED TV (2016 Model).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (198, N'Dickies Men''s Short-Sleeve Work Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Button closure</li>;<li>Machine Wash</li>;<li>Moisture-wicking for comfortable wear</li>;<li>Square tail design stays tucked in</li>;<li>Button-front work shirt featuring short sleeves and button-flap chest pockets</li>;<li>Logo label at front hem</li>', 63, 4.7, N'Dickies Men''s Short-Sleeve Work Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (199, N'Dickies Men''s Long-Sleeve Work Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Button Down closure</li>;<li>Machine Wash</li>;<li>Button-front work shirt in relaxed fit featuring long sleeves and twin button-flap chest pockets</li>;<li>Logo patch at center hem</li>', 21, 5.96, N'Dickies Men''s Long-Sleeve Work Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (200, N'Columbia Men''s Silver Ridge Long-Sleeve Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Relaxed-fitting dress shirt featuring long convertible sleeves with tab keepers and double flap chest pockets</li>;<li>Spread collar</li>', 197, 29.95, N'Columbia Men''s Silver Ridge Long-Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (201, N'Youstar Men''s Western Casual Button Down Shirt', N'Button-Down Shirts', N'<li>Button closure</li>;<li>Casual essential item daily at work and school, Night out for clubbing and dating. Suitable in any circumstances</li>', 132, 11.56, N'Youstar Men''s Western Casual Button Down Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (202, N'Youstar Men''s Short Sleeve Button Down Shirts', N'Button-Down Shirts', N'<li>Short sleeve button down shirt</li>;<li>Machine wash cold. Do not bleach. Tumble dry low. Iron low if needed.</li>;<li>Slim fit. *Please check our size chart. Style# AMTSTS040 Designed with unique plaid patterns with front pocket.</li>;<li>This Short Sleeve Button Down Checkered Plaid Shirt will work perfect for you if you are seeking for plaid shirt with short sleeve and not too ordinary. This Short Sleeve Button Down Checkered Plaid Shirt is designed snug and loose which makes you comfortable when wearing. Great thing about plaid is simple styling. With unique plaid pattern, other matching clothes can be basic.</li>;<li>Please refer to our image for the size wise.</li>', 58, 13.99, N'Youstar Men''s Short Sleeve Button Down Shirts.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (203, N'Dickies Men''s Short Sleeve Two-Tone Work Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Machine Wash</li>;<li>Easy care stain release</li>;<li>Moisture wicking</li>;<li>Pencil division in left pocket</li>;<li>Regular fit is designed to fit close to the body while staying comfortable and classic</li>', 75, 18.5, N'Dickies Men''s Short Sleeve Two-Tone Work Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (204, N'Columbia Men''s Plus Tamiami Ii Long Sleeve Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Omni-Wick Product^Omni-Shade UPF 40 sun protection.^Antimicrobial treatment protects this product from bacterial growth.^Vented for comfort.^Roll-up sleeve.</li>', 160, 26.73, N'Columbia Men''s Plus Tamiami Ii Long Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (205, N'Columbia Sportswear Men''s Tamiami II Long Sleeve Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Omni-Wick Shirt</li>;<li>Omni-Shade UPF 40 sun protection</li>;<li>Antimicrobial treatment protects this product from bacterial growth</li>;<li>Quick dry. Vented. Roll-up sleeves with tab holders. Rod holder</li>;<li>Omni-Wick Advanced Evaporation</li>;<li>Intended to protect the garment from odor Caused by bacteria</li>;<li>Roll-up sleeves with tab holders</li>', 60, 31.19, N'Columbia Sportswear Men''s Tamiami II Long Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (206, N'Youstar Men''s Hawaiian Print Button Down Short Sleeve Shirt', N'Button-Down Shirts', N'<li>Pull On closure</li>;<li>This shirt features a button up closure, short sleeves, one front chest pocket, and a faded tropical pattern.</li>', 163, 11.99, N'Youstar Men''s Hawaiian Print Button Down Short Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (207, N'Quiksilver Waterman Men''s Centinela Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Hand Wash</li>;<li>Short-sleeve button-front shirt in subtle slub texture featuring pick stitches at shoulders and back yoke</li>;<li>Patch pocket at chest with logo embroidery</li>', 128, 17.16, N'Quiksilver Waterman Men''s Centinela Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (208, N'Columbia Men''s Silver Ridge Plaid Long Sleeve Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Omni-Wick. 31" center back. Crew neck styling</li>;<li>31" center back</li>;<li>Crew neck styling</li>;<li>Omni-Wick Advanced Evaporation</li>;<li>Omni-Shade UPF 30 Sun Protection</li>;<li>Pockets with Hook and Loop Closure</li>;<li>Sun Protection Cuff</li>', 11, 18.48, N'Columbia Men''s Silver Ridge Plaid Long Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (209, N'Dickies Men''s Big-Tall Long-Sleeve Work Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>No Closure closure</li>;<li>Machine Wash</li>;<li>Long-sleeve work shirt with button-front entry and dual button-flap chest pockets</li>;<li>Stain-release fabrication</li>;<li>Pencil division in left chest pocket</li>;<li>Logo patch at placket near hem</li>', 103, 11, N'Dickies Men''s Big-Tall Long-Sleeve Work Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (210, N'Royal Robbins Men''s Desert Pucker Short Sleeve Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>UPF 27+ sun protection</li>;<li>Single chest pocket with pen slot</li>;<li>Sand washed finish</li>;<li>Straight hem with side vents</li>;<li>Drop-in chest pocket with pen slot</li>', 198, 10.75, N'Royal Robbins Men''s Desert Pucker Short Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (211, N'Ed Garments Men''s Big And Tall Banded Collar Long Sleeve Shirt', N'Button-Down Shirts', N'<li>Machine wash warm, only non-chlorine bleach, tumble dry warm, use warm iron, use no solvents</li>;<li>Performance broadcloth banded collar shirt.</li>;<li>Two button adjustable cuff.</li>;<li>Banded collar with covered placket.</li>;<li>Long sleeve and no pocket.</li>', 168, 7.5, N'Ed Garments Men''s Big And Tall Banded Collar Long Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (212, N'SBW Men''s Striped Button Down Short Sleeve Shirt', N'Button-Down Shirts', N'<li>Button closure</li>;<li>This button down shirt features button closure, collars, front chest pockets, and is lightweight. Pair with jeans or shorts, for any occasion.</li>;<li>Machine wash cold with like colors. Gentle cycle. Tumble dry low. Warm iron as needed. Only non chlorine bleach when needed.</li>;<li>This shirt is super versatile and has a great fit.</li>;<li>Color Disclaimer : Due to monitor settings, monitor pixel definitions, we cannot guarantee that the color you see on your screen as an exact color of the product. We strive to make our colors as accurate as possible. however, colors are approximations of actual colors.</li>;<li>Size Disclaimer : Please view our size converting chart image prior to ordering.</li>', 134, 17.2, N'SBW Men''s Striped Button Down Short Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (213, N'Columbia Men''s Low Drag Offshore Long Sleeve Shirt', N'Button-Down Shirts', N'<li>Vented, Rod Holder</li>;<li>Omni-Shade UPF 40 sun protection</li>;<li>Omni-Wick moisture management</li>;<li>Quick Dry fabric</li>', 32, 29.96, N'Columbia Men''s Low Drag Offshore Long Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (214, N'Columbia Sportswear Men''s Slack Tide Camp Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Omni-Wick product</li>;<li>Omni-Shade UPF 50 sun protection.</li>;<li>Vented for comfort.</li>;<li>Omni-Wick moisture Management</li>;<li>Omni-Shade UPF 50 sun protection</li>;<li>Vented in back</li>', 5, 29.74, N'Columbia Sportswear Men''s Slack Tide Camp Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (215, N'Columbia Sportswear Men''s Super Low Drag Long Sleeve Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Omni-Wick Shirt</li>;<li>Omni-Shade UPF 40 sun protection</li>;<li>Antimicrobial treatment protects this product from bacterial growth</li>;<li>Quick dry. Vented. Rod holder</li>;<li>Omni-Wick Moisture Management</li>;<li>Trement Protects This Product From Bacterial Growth</li>;<li>Vented in Back</li>', 59, 20.65, N'Columbia Sportswear Men''s Super Low Drag Long Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (216, N'Youstar Men''s Long Sleeve Western Casual Button Down Shirt', N'Button-Down Shirts', N'<li>Button-End closure</li>;<li>Casual essential item daily at work and school, Night out for clubbing and dating. Suitable in any circumstances.</li>;<li>Hand wash Do not bleach. Drip dry or low tumble dry Cool iron if necessary.</li>;<li>Featuring spread collar, snap button down, long sleeve, plaid checkered. Plz view our size chart for the perfect fit</li>;<li>Designed with western inspired details and features bold plaid pattern. This casual shirt is easy to care wearable very casually.</li>;<li>Style # : AMTSTL0132</li>', 26, 14.98, N'Youstar Men''s Long Sleeve Western Casual Button Down Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (217, N'Youstar Men''s Color Contrast Vertical Striped Short Sleeve Shirts', N'Button-Down Shirts', N'<li>YOUSTAR is a company that carries men''s basic and fashionable unique clothes. We are here for all the men looking to shop for basic or stylish clothes with fast and easy access without having to walk around the mall.</li>;<li>Striped short sleeve shirt with pocket. Hand wash or machine wash cold. Do not bleach. Tumble dry low. Remove promptly. Cool iron. Pocket and yoke color contrast with matching buttons. Great for dailywear and also as neat uniform.</li>;<li>It''s always hard to find a neat and unique shirts for guys. If you like the design, the fit might be too tight. If you''ve been looking for some neat shirt you can wear at office or as uniform, and wear casually after work, this is perfect shirt for you. The fit is snug and you will feel comfortable wearing this.</li>;<li>Plus, vertical stripes will make you look slim and in shape. Color contrast is a big plus. With pocket and yoke color contrast, throw in some jeans or white or black pants to match with it and you won''t have to think about styling. We carry variety of color options and sizes so please look through our charts before purchase. Slim fit. *** PLEASE CHECK OUR SIZE CHART ON PRODUCT DESCRIPTION ***</li>;<li>Style : AMTSTS037, AMTSTS036, AMTSTS038, AMTSTS053, AMTSTS049, AMTSTS050, AMTSTS051, AMTSTS052</li>', 117, 18.97, N'Youstar Men''s Color Contrast Vertical Striped Short Sleeve Shirts.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (218, N'White Sierra Men''s Dardanelle Ombre Long Sleeve Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Shirttail hem</li>;<li>Garment washed for softness</li>;<li>Chest patch pocket</li>;<li>Bias back yoke</li>', 138, 10.22, N'White Sierra Men''s Dardanelle Ombre Long Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (219, N'Columbia Men''s Tamiami Ii Short Sleeve Shirt', N'Button-Down Shirts', N'<li>Imported</li>;<li>Omni-Wick Product</li>;<li>Omni-Shade UPF 40 sun protection.</li>;<li>Antimicrobial treatment protects this product from bacterial growth. Quick dry.</li>;<li>Vented. Rod holder.</li>;<li>Omni-Shade UPF 40 sun protection</li>;<li>Omni-Wick moisture Management</li>;<li>Quick dry fabric</li>;<li>Vented in back</li>', 50, 24, N'Columbia Men''s Tamiami Ii Short Sleeve Shirt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (220, N'Columbia Men''s Bahama II Long Sleeve Shirt (Tall)', N'Button-Down Shirts', N'<li>Omni-shade sun protection, UPF 30</li>;<li>Features quick dry and vented</li>;<li>Features a rod holder</li>;<li>2 Big chest pockets hold smaller gear and available in several extra-tall sizes</li>', 23, 18.84, N'Columbia Men''s Bahama II Long Sleeve Shirt (Tall).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (221, N'Ninja Master Prep Professional (QB1004)', N'Small Appliances', N'<li>Patented ninjaÂ® technology</li>;<li>Dishwasher safe parts</li>;<li>450-watt motor</li>;<li>Crush solid ice cubes into fluffy snow</li>;<li>Interchangeable 450 Watt Power Pod with Chrome Button can be used with all three containers.</li>;<li>Frozen Blending</li>;<li>Perfect, Even Food Processing and Chopping</li>;<li>3 conveniently sized jars</li>;<li>Anti-spill splashguards, easy-flip pour spouts, and no slip bases</li>', 160, 49, N'Ninja Master Prep Professional (QB1004).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (222, N'Conair Cuisinart Mini-Prep Plus DLC-2A Food Processor (White)', N'Small Appliances', N'<li>250-watt food processor with 3-cup plastic work bowl</li>;<li>Chops and grinds with patented reversible stainless-steel blade</li>;<li>Simple push-button control panel; durable, yet lightweight plastic body</li>;<li>Dishwasher-safe bowl and lid for quick cleanup; spatula included</li>;<li>Product Built to North American Electrical Standards</li>', 139, 39.93, N'Conair Cuisinart Mini-Prep Plus DLC-2A Food Processor (White).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (223, N'Cuisinart DLC-2011CHBY Prep 11 Plus 11-Cup Food Processor, Brushed Stainless', N'Small Appliances', N'<li>Set includes a stainless steel medium slicing disc (4mm), a stainless steel shredding disc and 1 blade that can be used for chopping/mixing/kneading.</li>;<li>Speed automatically adjusts to ensure proper dough consistency</li>;<li>Includes spatula, recipe/instruction book; dishwasher-safe parts</li>;<li>One-piece Supreme wide mouth feed tube holds whole fruits and vegetables</li>;<li>Product Built to North American Electrical Standards</li>', 174, 156.99, N'Cuisinart DLC-2011CHBY Prep 11 Plus 11-Cup Food Processor, Brushed Stainless.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (224, N'Cuisinart DLC-2009CHBMY Prep 9 9-Cup Food Processor, Brushed Stainless', N'Small Appliances', N'<li>Includes slicer disc, shredding disc, new chopping blade, detachable stem, spatula, and recipe/instruction book</li>;<li>Brushed Stainless Steel housing for enhanced durability</li>;<li>Lexan work bowl virtually shatterproof, dishwasher-safe</li>;<li>Speed automatically adjusts to ensure proper dough consistency; does not include DVD and the blade</li>;<li>One-piece Supreme wide mouth feed tube holds whole fruits and vegetables</li>', 94, 147.44, N'Cuisinart DLC-2009CHBMY Prep 9 9-Cup Food Processor, Brushed Stainless.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (225, N'Cake Boss 7-Piece Countertop Accessories Melamine Complete Mixing and Prep Bowl Set, Icing', N'Small Appliances', N'<li>The mixing and prep bowl set is crafted from sturdy melamine and features three ample-sized mixing bowls and four 8-ounce prep bowls</li>;<li>The mixing bowls are designed with convenient pour spouts and handles and all of the bowls are top-rack dishwasher safe</li>;<li>The mixing bowls feature handle grips and pour spouts and a rubberized base helps keep all the bowls steady on countertops while prepping and mixing</li>;<li>Each colorful bowl features a bright hue inside-red, yellow, pink and light blue-with icing accents on the cream-colored exterior</li>;<li>Quality Assurance Guarantee ensures that these Cake Boss Countertop Accessories work great with many other items in the Cake Boss collections</li>', 108, 57.27, N'Cake Boss 7-Piece Countertop Accessories Melamine Complete Mixing and Prep Bowl Set, Icing.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (226, N'Cuisinart DLC-4CHB Mini-Prep Plus 4-Cup Food Processor', N'Small Appliances', N'<li>Mini food processor with 4-cup capacity work bowl</li>;<li>Touch-pad controls; auto-reversing blade for chopping or grinding</li>;<li>Easy-grip handle; dishwasher-safe parts make cleanup a snap</li>;<li>Custom spatula and instruction book with recipes included</li>;<li>Measures 5-2/5 by 7-3/5 by 9-8/9 inches; 18-month limited warranty</li>', 114, 45.38, N'Cuisinart DLC-4CHB Mini-Prep Plus 4-Cup Food Processor.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (227, N'Cuisinart DLC-1SS Mini-Prep Processor, Brushed Stainless Steel', N'Small Appliances', N'<li>Powerful chopper/grinder;  21-ounce work bowl; 2 speeds for precision chopping</li>;<li>Patented reversible blade chops or grinds; brushed stainless steel base</li>;<li>Dishwasher-safe parts,Product Dimensions :4.63"x 8.00" x 6.25"</li>;<li>Instruction/recipe book</li>;<li>Product Built to North American Electrical Standards</li>', 39, 34.95, N'Cuisinart DLC-1SS Mini-Prep Processor, Brushed Stainless Steel.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (228, N'Cuisinart DLC-2AMRFR Mini-Prep Plus Processor, Metallic Red (Certified Refurbished)', N'Small Appliances', N'<li>250-watt food processor with 3-cup plastic work bowl</li>;<li>Chops and grinds with patented reversible stainless-steel blade</li>;<li>Simple push-button control panel; durable, yet lightweight plastic body</li>;<li>Dishwasher-safe bowl and lid for quick cleanup; spatula included</li>;<li>Product Built to North American Electrical Standards</li>', 168, 35.97, N'Cuisinart DLC-2AMRFR Mini-Prep Plus Processor, Metallic Red (Certified Refurbished).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (229, N'Prep Solutions by Progressive Microwavable Omelet Maker', N'Small Appliances', N'<li>Microwave omlet maker holds up to 4 eggs to make a quick and easy omlet</li>;<li>Non-stick surface makes cleaning quick and easy</li>;<li>Measures 8 inches wide by 6 inches long</li>;<li>Made of heat heat polypropylene; BPA free</li>;<li>Dishwasher safe</li>', 16, 3.99, N'Prep Solutions by Progressive Microwavable Omelet Maker.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (230, N'Waring Commercial MX1200XTX Xtreme Hi-Power Variable-Speed Food Blender with Raptor Copolyester Container, 64-Ounce', N'Small Appliances', N'<li>Xtreme hi-power blender comes with high-performance 3.5 peak horsepower motor</li>;<li>Includes container which is constructed of BPA-free copolyester material</li>;<li>Features ultra-aggressive stainless steel blade and jar design delivers smoother consistencies and faster results</li>;<li>Comes with variable speed control is perfect for all types of food preparation</li>;<li>Available with 64-ounce capacity</li>', 172, 366.12, N'Waring Commercial MX1200XTX Xtreme Hi-Power Variable-Speed Food Blender with Raptor Copolyester Container, 64-Ounce.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (231, N'Black &amp; Decker SL1050 Lean Prep Machine Food Processor, Green', N'Small Appliances', N'<li>4 blade options</li>;<li>Food pusher</li>;<li>Frozen dessert attachment</li>;<li>Folding handle</li>;<li>Wide mouth feed chute</li>', 195, 34.98, N'Black &amp; Decker SL1050 Lean Prep Machine Food Processor, Green.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (232, N'Nutri Ninja Auto-iQ Compact System (BL493Z)', N'Small Appliances', N'<li>Nutri Ninja Auto-qi Compact System now includes Smooth Boost Technology, allowing you to truly customize your drink-making experience</li>;<li>Nutrient & Vitamin EXTRACTION Combined with Pro Extractor Blades breaks down whole fruits and veggies for refreshing, full-bodied nutrient juices</li>;<li>High-Performance Blending combined with the blender''s high-performance blades powers through frozen ingredients and ice for cool smoothies and shakes</li>;<li>40 oz. Blend & Prep Bowl for added versatility and functionality</li>;<li>Double-walled stainless steel Nutri Ninja keeps your favorite frozen smoothies colder for up to 4 hours</li>', 175, 169.99, N'Nutri Ninja Auto-iQ Compact System (BL493Z).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (233, N'Oster FPSTFP1355 2-Speed 10-Cup Food Processor, 500-watt', N'Small Appliances', N'<li>500-Watt Motor with 2 Speeds and Pulse Control buttons</li>;<li>5" Wide, Large-Mouth Food Chute w/Food Pusher</li>;<li>Reversible slicing/shredding disc</li>;<li>10 Cup Capacity Work Bowl with locking lid</li>;<li>Includes Dough Blade</li>', 176, 33.99, N'Oster FPSTFP1355 2-Speed 10-Cup Food Processor, 500-watt.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (234, N'Hamilton Beach 70670 Chef Prep 525-Watt Food Processor, Black', N'Small Appliances', N'<li>Full-size 10-cup food processor with powerful 525-watt motor</li>;<li>2 reversible slicing/shredding discs; stainless-steel chopping blade</li>;<li>2 speed options plus pulse for precision results; oversized feed chute</li>;<li>Dishwasher-safe bowl, lid, blades, and discs; internal cord storage</li>;<li>Measures approximately 10 by 9 by 16 inches; 1-year warranty</li>', 42, 42.99, N'Hamilton Beach 70670 Chef Prep 525-Watt Food Processor, Black.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (235, N'Cuisinart DLC-2AMWFR Mini-Prep Plus Processor, Pearl White (Certified Refurbished)', N'Small Appliances', N'<li>250-watt food processor with 3-cup plastic work bowl</li>;<li>Chops and grinds with patented reversible stainless-steel blade</li>;<li>Simple push-button control panel; durable, yet lightweight plastic body</li>;<li>Dishwasher-safe bowl and lid for quick cleanup; spatula included</li>;<li>Product Built to North American Electrical Standards</li>', 7, 34.01, N'Cuisinart DLC-2AMWFR Mini-Prep Plus Processor, Pearl White (Certified Refurbished).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (236, N'Brentwood JB-220G 12-Speed Blender, 1.5-Liter, Lime Green', N'Small Appliances', N'<li>Non-Skid base</li>;<li>12 speed controls</li>;<li>Plastic pitcher jar</li>;<li>350 watts of power</li>;<li>Cul approved for safety</li>', 21, 22.82, N'Brentwood JB-220G 12-Speed Blender, 1.5-Liter, Lime Green.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (237, N'Cuisinart DLC-1SSFR Mini-Prep Processor, Brushed Metal (Certified Refurbished)', N'Small Appliances', N'<li>Chopper/grinder with powerful motor base and 21-ounce work bowl</li>;<li>2 speeds for precision processing; patented reversible stainless-steel blade</li>;<li>Accessories include instruction/recipe book, spatula, and cleaning brush</li>;<li>Dishwasher-safe bowl, cover, and blade assembly</li>;<li>Measures approximately 4 by 6 by 8 inches; 90-day warranty</li>', 6, 24.27, N'Cuisinart DLC-1SSFR Mini-Prep Processor, Brushed Metal (Certified Refurbished).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (238, N'Prepworks by Progressive Food Prep Machine', N'Small Appliances', N'<li>An ultra-handy kitchen tool that performs a large variety of tasks in one easy-care unit</li>;<li>Includes drip-free pour spout, chopping and blending blades, salad spinner, and egg separator</li>;<li>Large handle great for leverage; take apart for easy cleaning</li>;<li>4 cup liquid capacity; great for making salsa</li>;<li>Fantastic gift idea, even for the foodie who has everything</li>', 154, 17.9, N'Prepworks by Progressive Food Prep Machine.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (239, N'Cuisinart CSB-33 QuikPrep Hand Blender, White', N'Small Appliances', N'<li>Versatile tool to blend, mix, emulsify, whip, mince, and puree</li>;<li>Use for drinks, soups, sauces, baby food, and salad dressings</li>;<li>2-speed control</li>;<li>Compact (14 inches high) but powerful</li>;<li>Product Built to North American Electrical Standards</li>', 22, 24.49, N'Cuisinart CSB-33 QuikPrep Hand Blender, White.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (240, N'Prep Solutions by Progressive Rice Cooker, 4 Piece Set - 6 Cup Capacity', N'Small Appliances', N'<li>Microwavable 6 cup capacity rice cooker</li>;<li>Set includes rice cooker, locking lid, rice paddle and measuring cup</li>;<li>Lid and paddle are green with a frosted clear base and measuring cup</li>;<li>Measures 9.25 Inch wide and 7 Inch deep</li>;<li>BPA free; dishwasher safe</li>;<li>NOTE: Please ensure to measure rice in the cup that comes along with the product ONLY</li>', 29, 12.04, N'Prep Solutions by Progressive Rice Cooker, 4 Piece Set - 6 Cup Capacity.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (241, N'Prep Solutions by Progressive Compact Kitchen Scale', N'Small Appliances', N'<li>The Compact Kitchen Scale from Prep Solutions by Progressive features a digital output screen, an integrated measuring container, and automatic turn off.</li>;<li>Featuring two sensor buttons, you can easily change units of measure, zero out weight, and power on and off and convert to milliliters, grams, pounds, and ounces.</li>;<li>The angled body provides easy readability for the scale output screen and nice, organized home for the measuring container underneath when not in use.</li>;<li>The scale should be cleaned by hand, but the measuring container is dishwasher safe.</li>;<li>The dimensions of the Compact Kitchen Scale are 5.5" L x 2" H x 7.24" W</li>', 148, 19.99, N'Prep Solutions by Progressive Compact Kitchen Scale.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (242, N'Holstein Housewares HB-07038E 3 Speed Hand Mixer, Teal', N'Small Appliances', N'<li>Choose from three speed settings to tackle a variety of mixing and whisking tasks</li>;<li>Save on prep time hassle-free with clip-on detachable beater storage</li>;<li>Conveniently compact, store anywhere in the kitchen to save counter and storage space</li>;<li>With 150 watts of power, quickly mix batters right in the bowl</li>;<li>Available in magenta or teal, compliment any personality and decor</li>', 7, 24.99, N'Holstein Housewares HB-07038E 3 Speed Hand Mixer, Teal.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (243, N'Oster BLSTCC-RFP 16 Speed Blender with Food Processor, Red', N'Small Appliances', N'<li>700 power watts/450 blending watts</li>;<li>3-cup BPA-free food chopper jar and stainless steel S-blade to make food prep easier</li>;<li>Crush Pro  4 Blade uses stainless steel, 4-point design to pulverize and chop with precision</li>;<li>All Metal Drive is extra durable for a  metal-to-metal connection</li>;<li>16 Speeds from PULSE to PUREE	6-Cup Boroclass Glass Jar is dishwasher safe for easy clean up</li>;<li>2-ounce filler cap has built in markings to measure and pour ingredients while blending</li>;<li>Faceplate design may vary</li>', 91, 49.99, N'Oster BLSTCC-RFP 16 Speed Blender with Food Processor, Red.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (244, N'Samsung Galaxy J7 - No Contract Phone - White - (Boost Mobile)', N'Smart Phones', N'<li>Android 6.0 Marshmallow OS</li>;<li>5.5" HD Super AMOLED Display</li>;<li>13MP Rear Camera and 5MP Front Facing Camera</li>;<li>16GB ROM/2GB ROM</li>', 38, 164.99, N'Samsung Galaxy J7 - No Contract Phone - White - (Boost Mobile).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (245, N'TracFone LG 306G No Contract Phone - Retail Packaging - Black', N'Smart Phones', N'<li>3G/Wi-Fi connectivity</li>;<li>2.0 megapixel camera and video recorder</li>;<li>4GB micro SD Card (Included in phone)</li>;<li>Bluetooth 2.1 wireless technology</li>', 175, 6.99, N'TracFone LG 306G No Contract Phone - Retail Packaging - Black.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (246, N'LG Stylo 2 Prepaid Carrier Locked - Retail Packaging (Boost)', N'Smart Phones', N'<li>13MP Rear-Facing Camera with 5MP Front-Facing Camera</li>;<li>5.7" HD IPS Display</li>;<li>LG Signature Rear Keys</li>', 160, 94.98, N'LG Stylo 2 Prepaid Carrier Locked - Retail Packaging (Boost).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (247, N'Tracfone Alcatel Onetouch Sonic LTE 4.6-Inch Android Prepaid Phone with Triple Minutes', N'Smart Phones', N'', 65, 32.99, N'Tracfone Alcatel Onetouch Sonic LTE 4.6-Inch Android Prepaid Phone with Triple Minutes.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (248, N'Nokia Lumia 640 (AT&amp;T Go Phone) No Annual Contract', N'Smart Phones', N'<li>5" HD screen</li>;<li>Built in Word, Excel</li>;<li>5-Inch display</li>;<li>8MP rear-facing camera</li>;<li>Media Card Slot: microSD</li>;<li>Built in Word, Excel, PowerPoint and OneNote</li>', 119, 65.8, N'Nokia Lumia 640 (AT&amp;T Go Phone) No Annual Contract.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (249, N'Ting GSM SIM card - No contract, Universal SIM, Nationwide coverage, Only pay for what you use', N'Smart Phones', N'<li>Only pay for the usage levels you reach each month</li>;<li>Nationwide coverage on a GSM network</li>;<li>Average Ting bill of just $23 per phone on an account</li>', 184, 9, N'Ting GSM SIM card - No contract, Universal SIM, Nationwide coverage, Only pay for what you use.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (250, N'LG Optimus Zone 3 (Verizon LTE Prepaid)', N'Smart Phones', N'<li>See clearly with a bright, vivid display the Optimus Zone 3 offers One of the best viewing experiences in its class. The 4.5-Inch display brings movies, photos and games to life.</li>;<li>Take the perfect selfie.The front-facing 2-megapixel camera puts you in a great light, while gesture shot helps you take a selfie using a simple hand movement. The 5-megapixel rear Camera captures vivid videos and photos.</li>;<li>Don''t compromise on style with a sleek, Compact design, the Optimus Zone 3 looks as good as it feels in your hand.</li>;<li>No annual contract and no credit checks Verizon prepaid plans offer you flexible monthly options to pay for what you want, when you want it.</li>', 109, 29.88, N'LG Optimus Zone 3 (Verizon LTE Prepaid).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (251, N'LG Destiny 4G Android Prepaid Phone with Triple Minutes (Tracfone)', N'Smart Phones', N'<li>Android 5.0 (Lollipop) OS</li>;<li>1.2GHz quad-core processor</li>;<li>4G/Wi-Fi capable</li>;<li>Internal Memory: 8GB</li>', 94, 59.99, N'LG Destiny 4G Android Prepaid Phone with Triple Minutes (Tracfone).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (252, N'LG Stylo 2 Prepaid Carrier Locked - Retail Packaging (Virgin Mobile)', N'Smart Phones', N'<li>13MP Rear-Facing Camera with 5MP Front-Facing Camera</li>;<li>5.7" HD IPS Display</li>;<li>LG Signature Rear Keys</li>;<li>Embedded Stylus</li>', 15, 97.98, N'LG Stylo 2 Prepaid Carrier Locked - Retail Packaging (Virgin Mobile).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (253, N'Apple iTunes $50 Gift Card (Packaging May Vary)', N'Smart Phones', N'', 157, 58.49, N'Apple iTunes $50 Gift Card (Packaging May Vary).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (254, N'ZTE Warp Elite No Contract Phone - Retail Packaging - Boost', N'Smart Phones', N'<li>13MP Rear-Facing Camera with 5MP Front-Facing Camera</li>;<li>64GB microSDHC Card Compatible</li>', 158, 74.99, N'ZTE Warp Elite No Contract Phone - Retail Packaging - Boost.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (255, N'ZTE Z222 Go Phone (AT&amp;T)', N'Smart Phones', N'<li>Media Mall allows you to personalize your phone with polyphonic ringtones, games and graphics</li>;<li>Push to Talk- walkie talkie style communication</li>;<li>Display size: 2-Inch</li>;<li>Chipset: QSC 6270</li>;<li>Internal memory storage: 50MB</li>;<li>Battery:  900mAh</li>', 133, 18.72, N'ZTE Z222 Go Phone (AT&amp;T).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (256, N'LG G Stylo LS770AVB Android 5.1 5.7-Inch HD IPS Display 8 MP Virgin Mobile Locked Phone with Stylus Pen', N'Smart Phones', N'<li>5.7" HD IPS touchscreen display with Corning Gorilla glass 3</li>;<li>8MP rear-facing Camera/5MP front-facing Camera</li>;<li>Actual usable memory is guaranteed at 8GB</li>', 78, 59.99, N'LG G Stylo LS770AVB Android 5.1 5.7-Inch HD IPS Display 8 MP Virgin Mobile Locked Phone with Stylus Pen.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (257, N'Samsung Galaxy S4 16GB Black SPH-L720T Tri-Band (Boost Mobile)', N'Smart Phones', N'<li>AndroidTM 5.0 (Lollipop)</li>;<li>13MP Rear-Facing Camera/2MP Front-Facing Camera</li>;<li>16GB ROM/2GB RAM Memory</li>;<li>5" HD Super AMOLEDTM Plus Display</li>', 26, 129.99, N'Samsung Galaxy S4 16GB Black SPH-L720T Tri-Band (Boost Mobile).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (258, N'Samsung Galaxy Centura Android Prepaid Phone (TracFone)', N'Smart Phones', N'<li>3.5" Touch Screen</li>;<li>3 MP Camera/Video Recorder</li>;<li>No activation fees, contracts, monthly bills or credit checks. An Airtime Card is required for activation of this phone.</li>;<li>Safelink customers cannot upgrade or transfer service to this phone</li>', 135, 12.99, N'Samsung Galaxy Centura Android Prepaid Phone (TracFone).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (259, N'Nokia Lumia 635 (AT&amp;T Go Phone) No Annual Contract', N'Smart Phones', N'<li>8 GB storage 512 MB RAM Expandable Memory</li>;<li>5.0 MP Camera with 720p HD Video and Autofocus</li>;<li>1.2 GHz MSM8x26 Quad core Processor</li>;<li>5-Inch display</li>;<li>8MP rear-facing camera</li>;<li>8GB Memory</li>;<li>1.2GHz quad core processor</li>;<li>Media Card Slot: microSD</li>', 138, 54.11, N'Nokia Lumia 635 (AT&amp;T Go Phone) No Annual Contract.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (260, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-K Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones - Black', N'Earbud Headphones', N'<li>Eight vivid fashion color options with color-matching earbuds and cords (color-matching for iPod Nano 5th generation)</li>;<li>Wider frequency response for fuller listening enjoyment</li>;<li>Long 3.6-ft cord threads comfortably through clothing and bags</li>', 96, 10.46, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-K Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones - Black.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (261, N'Bose SoundSport in-ear headphones - Charcoal', N'Earbud Headphones', N'<li>Proprietary Stay Hear tips, in three sizes, conform to your ear''s shape to stay comfortably in place all day</li>;<li>Sweat and weather-resistant; engineered and tested for lasting quality and durability</li>;<li>Matching protective carrying case included</li>', 102, 79, N'Bose SoundSport in-ear headphones - Charcoal.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (262, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-SDynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones - Silver', N'Earbud Headphones', N'<li>Ergo-Fit Design for ulitmate comfort and fit</li>;<li>Drive Unit (diam.in mm) - Diameter 9mm</li>', 119, 6.78, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-SDynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones - Silver.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (263, N'Bose QuietComfort 20 Acoustic Noise Cancelling Headphones, Apple Devices, Black', N'Earbud Headphones', N'<li>Noise cancelling reduces surrounding distractions, letting music stand out</li>;<li>Aware mode lets you hear what''s around you when you need to, at the touch of a button</li>;<li>Exclusive TriPort technology and Active EQ help deliver lifelike, digital-quality audio</li>;<li>Stay Hear+ tips provide long-lasting comfort plus stability</li>', 19, 249, N'Bose QuietComfort 20 Acoustic Noise Cancelling Headphones, Apple Devices, Black.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (264, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-V (Purple) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones', N'Earbud Headphones', N'<li>Eight vivid fashion color options with color-matching earbuds and cords (color-matching for iPod Nano 5th generation)</li>;<li>Wider frequency response for fuller listening enjoyment</li>;<li>Long 3.6-ft cord threads comfortably through clothing and bags</li>;<li>android earbuds,android headphones,around ear headphones,athletic headphones,bass earbuds,best earbuds,best earphones for running,best headphones,best workout headphones,cell phone headset,cheap earbuds,ear headphones,ear monitor,earbud,earbud headphones,earbuds,earbuds bass,earbuds for kids,earbuds panasonic,earhook headphones,earphone,earphones,enhanced bass hi-fi noise isolating earphones,exercise headphones,gym headphones,headphone,headphones,headphones for running,headphones in ear,headphones panasonic,iem,in ear,in ear headphone,in ear headphones,in ear monitor,in ear monitor headphones,in ear monitors,in ears,in-ear headphone,in-ear headphone black,in-ear headphones,in-ear monitors,iphone earbuds,iphone earphones,iphone headset,kids earbuds,kindle fire headphones,microphone iphone 5,mp3 headphones,noise isolating earbuds,noise isolating headphones,panasonic ear buds,panasonic earbud,panasonic earbuds,panasonic earphone,panasonic earphones,panasonic ergo fit,panasonic ergofit,panasonic ergo-fit,panasonic ergofit rp-hje120,panasonic headphone,panasonic headphones,panasonic headset,panasonic in ear headphones,panasonic in-ear headphone,panasonic rphje 120,retractable earbuds,retractable headphones,running earbuds,running earphones,running headphones,single earbud,sport earbuds,sport earphones,sport headphones,sports earbuds,sports headphones,top rated earbuds,workout earbuds,workout headphones</li>', 193, 7.64, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-V (Purple) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (265, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-A (Blue) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones', N'Earbud Headphones', N'<li>Eight vivid fashion color options with color-matching earbuds and cords (color-matching for iPod Nano 5th generation)</li>;<li>Wider frequency response for fuller listening enjoyment</li>;<li>Long 3.6-ft cord threads comfortably through clothing and bags</li>;<li>android earbuds,android headphones,around ear headphones,athletic headphones,bass earbuds,best earbuds,best earphones for running,best headphones,best workout headphones,cell phone headset,cheap earbuds,ear headphones,ear monitor,earbud,earbud headphones,earbuds,earbuds bass,earbuds for kids,earbuds panasonic,earhook headphones,earphone,earphones,enhanced bass hi-fi noise isolating earphones,exercise headphones,gym headphones,headphone,headphones,headphones for running,headphones in ear,headphones panasonic,iem,in ear,in ear headphone,in ear headphones,in ear monitor,in ear monitor headphones,in ear monitors,in ears,in-ear headphone,in-ear headphone black,in-ear headphones,in-ear monitors,iphone earbuds,iphone earphones,iphone headset,kids earbuds,kindle fire headphones,microphone iphone 5,mp3 headphones,noise isolating earbuds,noise isolating headphones,panasonic ear buds,panasonic earbud,panasonic earbuds,panasonic earphone,panasonic earphones,panasonic ergo fit,panasonic ergofit,panasonic ergo-fit,panasonic ergofit rp-hje120,panasonic headphone,panasonic headphones,panasonic headset,panasonic in ear headphones,panasonic in-ear headphone,panasonic rphje 120,retractable earbuds,retractable headphones,running earbuds,running earphones,running headphones,single earbud,sport earbuds,sport earphones,sport headphones,sports earbuds,sports headphones,top rated earbuds,workout earbuds,workout headphones</li>', 74, 14.2, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-A (Blue) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (266, N'Bose SoundSport in-ear headphones - Apple devices Charcoal', N'Earbud Headphones', N'<li>Proprietary Stay Hear tips, in three sizes, conform to your ear''s shape to stay comfortably in place all day</li>;<li>Sweat- and weather-resistant; engineered and tested for lasting quality and durability</li>;<li>Inline microphone and remote for easy switching between calls and music with select iPhone models</li>;<li>Matching protective carrying case included</li>', 199, 99, N'Bose SoundSport in-ear headphones - Apple devices Charcoal.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (267, N'Apple EarPods 827 In-Ear StereoHeadphones with Remote and Mic - White', N'Earbud Headphones', N'<li>Inline remote & microphone</li>;<li>Unique in-ear design</li>;<li>White color</li>;<li>Stereo Headphones</li>', 147, 10.49, N'Apple EarPods 827 In-Ear StereoHeadphones with Remote and Mic - White.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (268, N'Samsung 3.5mm Stereo Headset for Galaxy S5, S4, S3, Note - Non-Retail Packaging - White', N'Earbud Headphones', N'<li>Compact, Light-Weight Design</li>;<li>Use these headphones to talk on your smartphone with ease while driving or working</li>;<li>Samsung Stereo Headset for the Samsung Galaxy S5 and Galaxy Note 3</li>;<li>Part # EHS64AVFWE</li>', 181, 5.29, N'Samsung 3.5mm Stereo Headset for Galaxy S5, S4, S3, Note - Non-Retail Packaging - White.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (269, N'Bose QuietComfort 20 Acoustic Noise Cancelling Headphones, Apple Devices, White', N'Earbud Headphones', N'<li>Noise cancelling reduces surrounding distractions, letting music stand out</li>;<li>Aware mode lets you hear what''s around you when you need to, at the touch of a button</li>;<li>Exclusive TriPort technology and Active EQ help deliver lifelike, digital-quality audio</li>;<li>Stay Hear+ tips provide long-lasting comfort plus stability</li>', 41, 249, N'Bose QuietComfort 20 Acoustic Noise Cancelling Headphones, Apple Devices, White.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (270, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-P Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones - Pink', N'Earbud Headphones', N'', 35, 9.92, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-P Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones - Pink.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (271, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-D (Orange) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones', N'Earbud Headphones', N'<li>Eight vivid fashion color options with color-matching earbuds and cords (color-matching for iPod Nano 5th generation)</li>;<li>Wider frequency response for fuller listening enjoyment</li>;<li>Long 3.6-ft cord threads comfortably through clothing and bags</li>;<li>android earbuds,android headphones,around ear headphones,athletic headphones,bass earbuds,best earbuds,best earphones for running,best headphones,best workout headphones,cell phone headset,cheap earbuds,ear headphones,ear monitor,earbud,earbud headphones,earbuds,earbuds bass,earbuds for kids,earbuds panasonic,earhook headphones,earphone,earphones,enhanced bass hi-fi noise isolating earphones,exercise headphones,gym headphones,headphone,headphones,headphones for running,headphones in ear,headphones panasonic,iem,in ear,in ear headphone,in ear headphones,in ear monitor,in ear monitor headphones,in ear monitors,in ears,in-ear headphone,in-ear headphone black,in-ear headphones,in-ear monitors,iphone earbuds,iphone earphones,iphone headset,kids earbuds,kindle fire headphones,microphone iphone 5,mp3 headphones,noise isolating earbuds,noise isolating headphones,panasonic ear buds,panasonic earbud,panasonic earbuds,panasonic earphone,panasonic earphones,panasonic ergo fit,panasonic ergofit,panasonic ergo-fit,panasonic ergofit rp-hje120,panasonic headphone,panasonic headphones,panasonic headset,panasonic in ear headphones,panasonic in-ear headphone,panasonic rphje 120,retractable earbuds,retractable headphones,running earbuds,running earphones,running headphones,single earbud,sport earbuds,sport earphones,sport headphones,sports earbuds,sports headphones,top rated earbuds,workout earbuds,workout headphones</li>', 194, 7.97, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-D (Orange) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (272, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-G (Green) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones', N'Earbud Headphones', N'<li>Eight vivid fashion color options with color-matching earbuds and cords (color-matching for iPod Nano 5th generation)</li>;<li>Wider frequency response for fuller listening enjoyment</li>;<li>Long 3.6-ft cord threads comfortably through clothing and bags</li>;<li>android earbuds,android headphones,around ear headphones,athletic headphones,bass earbuds,best earbuds,best earphones for running,best headphones,best workout headphones,cell phone headset,cheap earbuds,ear headphones,ear monitor,earbud,earbud headphones,earbuds,earbuds bass,earbuds for kids,earbuds panasonic,earhook headphones,earphone,earphones,enhanced bass hi-fi noise isolating earphones,exercise headphones,gym headphones,headphone,headphones,headphones for running,headphones in ear,headphones panasonic,iem,in ear,in ear headphone,in ear headphones,in ear monitor,in ear monitor headphones,in ear monitors,in ears,in-ear headphone,in-ear headphone black,in-ear headphones,in-ear monitors,iphone earbuds,iphone earphones,iphone headset,kids earbuds,kindle fire headphones,microphone iphone 5,mp3 headphones,noise isolating earbuds,noise isolating headphones,panasonic ear buds,panasonic earbud,panasonic earbuds,panasonic earphone,panasonic earphones,panasonic ergo fit,panasonic ergofit,panasonic ergo-fit,panasonic ergofit rp-hje120,panasonic headphone,panasonic headphones,panasonic headset,panasonic in ear headphones,panasonic in-ear headphone,panasonic rphje 120,retractable earbuds,retractable headphones,running earbuds,running earphones,running headphones,single earbud,sport earbuds,sport earphones,sport headphones,sports earbuds,sports headphones,top rated earbuds,workout earbuds,workout headphones</li>', 17, 9.99, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-G (Green) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (273, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-R (Red) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones', N'Earbud Headphones', N'<li>Eight vivid fashion color options with color-matching earbuds and cords (color-matching for iPod Nano 5th generation)</li>;<li>Wider frequency response for fuller listening enjoyment</li>;<li>Long 3.6-ft cord threads comfortably through clothing and bags</li>;<li>android earbuds,android headphones,around ear headphones,athletic headphones,bass earbuds,best earbuds,best earphones for running,best headphones,best workout headphones,cell phone headset,cheap earbuds,ear headphones,ear monitor,earbud,earbud headphones,earbuds,earbuds bass,earbuds for kids,earbuds panasonic,earhook headphones,earphone,earphones,enhanced bass hi-fi noise isolating earphones,exercise headphones,gym headphones,headphone,headphones,headphones for running,headphones in ear,headphones panasonic,iem,in ear,in ear headphone,in ear headphones,in ear monitor,in ear monitor headphones,in ear monitors,in ears,in-ear headphone,in-ear headphone black,in-ear headphones,in-ear monitors,iphone earbuds,iphone earphones,iphone headset,kids earbuds,kindle fire headphones,microphone iphone 5,mp3 headphones,noise isolating earbuds,noise isolating headphones,panasonic ear buds,panasonic earbud,panasonic earbuds,panasonic earphone,panasonic earphones,panasonic ergo fit,panasonic ergofit,panasonic ergo-fit,panasonic ergofit rp-hje120,panasonic headphone,panasonic headphones,panasonic headset,panasonic in ear headphones,panasonic in-ear headphone,panasonic rphje 120,retractable earbuds,retractable headphones,running earbuds,running earphones,running headphones,single earbud,sport earbuds,sport earphones,sport headphones,sports earbuds,sports headphones,top rated earbuds,workout earbuds,workout headphones</li>', 125, 11.99, N'Panasonic ErgoFit Best in Class In-Ear Earbud Headphones RP-HJE120-R (Red) Dynamic Crystal Clear Sound, Ergonomic Comfort-Fit, iPhone, Android Compatible, Noise Isolating Headphones.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (274, N'Sony MDRXB50AP Extra Bass Earbud Headset (Black)', N'Earbud Headphones', N'<li>Frequency Response: 4 - 24,000 Hz</li>;<li>Microphone: Elecret condenser / Omni Directional</li>;<li>Remote Control: Multi-function button / SmartKey app</li>;<li>Plug: Gold-plated four-conductor L-type stereo mini plug</li>', 31, 27.01, N'Sony MDRXB50AP Extra Bass Earbud Headset (Black).jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (275, N'Shure SE215-K Sound Isolating Earphones with Single Dynamic MicroDriver', N'Earbud Headphones', N'<li>Detachable Cable with Wireform Fit</li>;<li>Sound Isolation technology prevents outside noise from interfering with your audio experience, whether on-stage or on-the-go.</li>;<li>Lightweight, low-profile shape with optimized nozzle angle is designed to rest comfortably in the ear.</li>;<li>Soft, flexible sleeves in multiple shapes and sizes gently contour to your ears. Carrying case also included.</li>;<li>"-K" designates the product''s color variation (black)</li>', 84, 99, N'Shure SE215-K Sound Isolating Earphones with Single Dynamic MicroDriver.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (276, N'Amazon Premium Headphones', N'Earbud Headphones', N'<li>Features a mic and multi-function button to allow you to control your calls, music, and more</li>;<li>Delivers clear, crisp sound through ergonomically-designed earbuds</li>;<li>Ships in box with Fire phone and is compatible with Kindle Fire, Fire HD 8, and Fire HD 10 tablets</li>', 146, 14.99, N'Amazon Premium Headphones.jpg', 1)
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductType], [Description], [Stock], [Price], [ImageSource], [MemberID]) VALUES (277, N'Bose QuietComfort 20 Acoustic Noise Cancelling Headphones, Samsung and Android Devices, Black', N'Earbud Headphones', N'<li>Noise cancelling reduces surrounding distractions, letting music stand out</li>;<li>Aware mode lets you hear what''s around you when you need to, at the touch of a button</li>;<li>Exclusive TriPort technology and Active EQ help deliver lifelike, digital-quality audio</li>;<li>Stay Hear+ tips provide long-lasting comfort plus stability</li>', 92, 249, N'Bose QuietComfort 20 Acoustic Noise Cancelling Headphones, Samsung and Android Devices, Black.jpg', 1)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Product]    Script Date: 19-Aug-16 19:38:08 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [IX_Product] UNIQUE NONCLUSTERED 
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [MemberCart] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [MemberCart]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [ProductCart] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [ProductCart]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [MemberComment] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [MemberComment]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [ProductComment] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [ProductComment]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [MemberProduct] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [MemberProduct]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_Product]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [MemberRating] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [MemberRating]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [ProductTransaction] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [ProductTransaction]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [TransactionMember] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Member] ([MemberID])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [TransactionMember]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Link comments -> product' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Comment', @level2type=N'CONSTRAINT',@level2name=N'ProductComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Each product has a seller' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'MemberProduct'
GO
USE [master]
GO
ALTER DATABASE [OnlineStorePSGM] SET  READ_WRITE 
GO
