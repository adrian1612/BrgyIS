USE [master]
GO
/****** Object:  Database [dbBrgyIS]    Script Date: 25/03/2024 11:24:01 am ******/
CREATE DATABASE [dbBrgyIS]
GO
USE [dbBrgyIS]
GO
/****** Object:  StoredProcedure [dbo].[tbl_Person_Proc]    Script Date: 25/03/2024 11:24:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[tbl_Person_Proc]
@Type VARCHAR(50),
@Search VARCHAR(max) = null,
@ID int = null,
@fname varchar(max) = null,
@mn varchar(max) = null,
@lname varchar(max) = null,
@bday datetime = null,
@gender varchar(max) = null,
@CivilStatus varchar(max) = null,
@ShelterType varchar(500) = null,
@Occupation varchar(max) = null,
@isPWD bit = null,
@RelationshipToHead varchar(50) = null,
@StNo varchar(max) = null,
@Address varchar(max) = null,
@Remarks varchar(max) = null,
@Encoder int = null,
@Timestamp datetime = null
AS
BEGIN
IF @Type = 'Create'
BEGIN
INSERT INTO [tbl_Person]
([fname],[mn],[lname],[bday],[gender],[CivilStatus],[ShelterType],[Occupation],[isPWD],[RelationshipToHead],[StNo],[Address],[Remarks],[Encoder])
VALUES
(@fname,@mn,@lname,@bday,@gender,@CivilStatus,@ShelterType,@Occupation,@isPWD,@RelationshipToHead,@StNo,@Address,@Remarks,@Encoder)

END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Update'
BEGIN
UPDATE [tbl_Person] SET [fname] = @fname
,[mn] = @mn
,[lname] = @lname
,[bday] = @bday
,[gender] = @gender
,[CivilStatus] = @CivilStatus
,[ShelterType] = @ShelterType
,[Occupation] = @Occupation
,[isPWD] = @isPWD
,[RelationshipToHead] = @RelationshipToHead
,[StNo] = @StNo
,[Address] = @Address
,[Remarks] = @Remarks
 WHERE [ID] = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Search'
BEGIN
SELECT * FROM [tbl_Person] 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Find'
BEGIN
SELECT * FROM [tbl_Person] WHERE  ID = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------

END



GO
/****** Object:  StoredProcedure [dbo].[tbl_User_Proc]    Script Date: 25/03/2024 11:24:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[tbl_User_Proc]
@Type VARCHAR(50),
@Search VARCHAR(max) = null,
@ID int = null,
@Username varchar(max) = null,
@Password varchar(max) = null,
@Role int = null,
@Active bit = null,
@fname varchar(max) = null,
@mn varchar(max) = null,
@lname varchar(max) = null,
@gender varchar(50) = null,
@email varchar(max) = null,
@address varchar(max) = null,
@Timestamp datetime = null
AS
BEGIN
IF @Type = 'Create'
BEGIN
	IF (SELECT COUNT(*) FROM tbl_User WHERE Username = @Username) >= 1
	BEGIN
		SELECT CAST(0 AS BIT) Response
	END
	ELSE
	BEGIN
		INSERT INTO [tbl_User]
		([Username],[Password],[fname],[mn],[lname],[gender],[email],[address])
		VALUES
		(@Username,@Password,@fname,@mn,@lname,@gender,@email,@address)
		SELECT CAST(1 AS BIT) Response
	END
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Update'
BEGIN
	IF (SELECT COUNT(*) FROM tbl_User WHERE Username = @Username AND ID != @ID) >= 1
	BEGIN
		SELECT CAST(0 AS BIT) Response
	END
	ELSE
	BEGIN
		UPDATE [tbl_User] SET [Username] = @Username
		,[Password] = @Password
		,[Role] = @Role
		,[Active] = @Active
		,[fname] = @fname
		,[mn] = @mn
		,[lname] = @lname
		,[gender] = @gender
		,[email] = @email
		,[address] = @address WHERE [ID] = @ID
		SELECT CAST(1 AS BIT) Response
	END
	
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'UpdateProfile'
BEGIN
	UPDATE [tbl_User] SET [Password] = @Password
		,[fname] = @fname
		,[mn] = @mn
		,[lname] = @lname
		,[gender] = @gender
		,[email] = @email
		,[address] = @address WHERE [ID] = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Search'
BEGIN
	SELECT * FROM [tbl_User] 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Find'
BEGIN
	SELECT * FROM [tbl_User] WHERE  ID = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Login'
BEGIN
	SELECT * FROM [tbl_User] WHERE HASHBYTES('MD5', Username) = HASHBYTES('MD5', @Username) AND HASHBYTES('MD5', [Password]) = HASHBYTES('MD5', @Password) 
END
END

GO
/****** Object:  Table [dbo].[tbl_Person]    Script Date: 25/03/2024 11:24:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Person](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[fname] [varchar](max) NULL,
	[mn] [varchar](max) NULL,
	[lname] [varchar](max) NULL,
	[bday] [datetime] NULL,
	[gender] [varchar](max) NULL,
	[CivilStatus] [varchar](max) NULL,
	[ShelterType] [varchar](500) NULL,
	[Occupation] [varchar](max) NULL,
	[isPWD] [bit] NULL,
	[RelationshipToHead] [varchar](50) NULL,
	[StNo] [varchar](max) NULL,
	[Address] [varchar](max) NULL,
	[Remarks] [varchar](max) NULL,
	[Encoder] [int] NULL,
	[Timestamp] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_User]    Script Date: 25/03/2024 11:24:01 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](max) NULL,
	[Password] [varchar](max) NULL,
	[Role] [int] NULL DEFAULT ((2)),
	[Active] [bit] NULL DEFAULT ((1)),
	[fname] [varchar](max) NULL,
	[mn] [varchar](max) NULL,
	[lname] [varchar](max) NULL,
	[gender] [varchar](50) NULL,
	[email] [varchar](max) NULL,
	[address] [varchar](max) NULL,
	[Timestamp] [datetime] NULL DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Person] ON 

GO
INSERT [dbo].[tbl_Person] ([ID], [fname], [mn], [lname], [bday], [gender], [CivilStatus], [ShelterType], [Occupation], [isPWD], [RelationshipToHead], [StNo], [Address], [Remarks], [Encoder], [Timestamp]) VALUES (1, N'adrian', N'Aranilla', N'Jaspio', CAST(N'1994-07-05 00:00:00.000' AS DateTime), N'Male', N'Married', N'Rented', N'Computer Programmer', 0, N'Head of the Family', N'Kahusayan st', N'Pamana Homes sub kahusayan st, brgy bucal', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[tbl_Person] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_User] ON 

GO
INSERT [dbo].[tbl_User] ([ID], [Username], [Password], [Role], [Active], [fname], [mn], [lname], [gender], [email], [address], [Timestamp]) VALUES (1, N'admin', N'admin!!@@', 2, 1, N'adrian', N'aranilla', N'jaspio', N'Male', N'adrianjaspio@gmail.com', N'purok santol 1 mayao crossing lucena city', CAST(N'2024-03-24 13:15:20.450' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_User] OFF
GO
USE [master]
GO
ALTER DATABASE [dbBrgyIS] SET  READ_WRITE 
GO
