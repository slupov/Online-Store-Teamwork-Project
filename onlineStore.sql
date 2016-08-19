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
/****** Object:  Table [dbo].[Cart]    Script Date: 18-Aug-16 15:41:50 ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 18-Aug-16 15:41:50 ******/
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
/****** Object:  Table [dbo].[Member]    Script Date: 18-Aug-16 15:41:50 ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 18-Aug-16 15:41:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
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
/****** Object:  Table [dbo].[Rating]    Script Date: 18-Aug-16 15:41:50 ******/
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
/****** Object:  Table [dbo].[Transaction]    Script Date: 18-Aug-16 15:41:50 ******/
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
SET IDENTITY_INSERT [dbo].[Product] OFF
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
