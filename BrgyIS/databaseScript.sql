USE [master]
GO
/****** Object:  Database [dbBrgyIS]    Script Date: 14/04/2024 8:06:10 pm ******/
CREATE DATABASE [dbBrgyIS]
GO
USE [dbBrgyIS]
GO
/****** Object:  StoredProcedure [dbo].[tbl_Person_Proc]    Script Date: 14/04/2024 8:06:10 pm ******/
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
@FamilyHead INT = null,
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
([fname],[mn],[lname],FamilyHead,[bday],[gender],[CivilStatus],[ShelterType],[Occupation],[isPWD],[RelationshipToHead],[StNo],[Address],[Remarks],[Encoder])
VALUES
(@fname,@mn,@lname,@FamilyHead,@bday,@gender,@CivilStatus,@ShelterType,@Occupation,@isPWD,@RelationshipToHead,@StNo,@Address,@Remarks,@Encoder)

END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Update'
BEGIN
UPDATE [tbl_Person] SET [fname] = @fname
,[mn] = @mn
,[lname] = @lname
,FamilyHead = @FamilyHead
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
SELECT * FROM [vw_Person] 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Find'
BEGIN
SELECT * FROM [vw_Person] WHERE  ID = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------

END





GO
/****** Object:  StoredProcedure [dbo].[tbl_ref_Position_Proc]    Script Date: 14/04/2024 8:06:10 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[tbl_ref_Position_Proc]
@Type VARCHAR(50),
@Search VARCHAR(max) = null,
@ID int = null,
@Position varchar(max) = null,
@Encoder int = null,
@Timestamp datetime = null
AS
BEGIN
IF @Type = 'Create'
BEGIN
	IF EXISTS (SELECT * FROM tbl_ref_Position WHERE Position = @Position)
	BEGIN
		SELECT CAST(0 AS BIT)
	END
	ELSE
	BEGIN
		INSERT INTO [tbl_ref_Position]
		([Position],[Encoder])
		VALUES
		(@Position,@Encoder)
		SELECT CAST(1 AS BIT)
	END
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Update'
BEGIN
	IF EXISTS (SELECT * FROM tbl_ref_Position WHERE Position = @Position AND ID != @ID)
	BEGIN
		SELECT CAST(0 AS BIT)
	END
	ELSE
	BEGIN
		UPDATE [tbl_ref_Position] SET [Position] = @Position
		,[Encoder] = @Encoder WHERE [ID] = @ID
		SELECT CAST(1 AS BIT)
	END
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Search'
BEGIN
SELECT * FROM [tbl_ref_Position] 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Find'
BEGIN
SELECT * FROM [tbl_ref_Position] WHERE  ID = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------

END



GO
/****** Object:  StoredProcedure [dbo].[tbl_Staff_Proc]    Script Date: 14/04/2024 8:06:10 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[tbl_Staff_Proc]
@Type VARCHAR(50),
@Search VARCHAR(max) = null,
@ID int = null,
@Name INT = null,
@Position int = null,
@Instated datetime = null,
@Active bit = null,
@Encoder int = null,
@Timestamp datetime = null
AS
BEGIN
IF @Type = 'Create'
BEGIN
INSERT INTO [tbl_Staff]
([Name],[Position],[Instated],[Encoder])
VALUES
(@Name,@Position,@Instated,@Encoder)

END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Update'
BEGIN
UPDATE [tbl_Staff] SET [Name] = @Name
,[Position] = @Position
,[Instated] = @Instated
,[Active] = @Active
 WHERE [ID] = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Search'
BEGIN
SELECT * FROM [vw_Staff] 
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Find'
BEGIN
SELECT * FROM [vw_Staff] WHERE  ID = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------

END


GO
/****** Object:  StoredProcedure [dbo].[tbl_User_Proc]    Script Date: 14/04/2024 8:06:10 pm ******/
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
/****** Object:  Table [dbo].[tbl_Person]    Script Date: 14/04/2024 8:06:10 pm ******/
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
	[FamilyHead] [int] NULL,
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
	[Timestamp] [datetime] NULL,
 CONSTRAINT [PK__tbl_Pers__3214EC272CFE972E] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ref_Position]    Script Date: 14/04/2024 8:06:10 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ref_Position](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Position] [varchar](max) NULL,
	[Encoder] [int] NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Staff]    Script Date: 14/04/2024 8:06:10 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Staff](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [int] NULL,
	[Position] [int] NULL,
	[Instated] [datetime] NULL,
	[Active] [bit] NULL,
	[Encoder] [int] NULL,
	[Timestamp] [datetime] NULL,
 CONSTRAINT [PK__tbl_Staf__3214EC275498A3BE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_User]    Script Date: 14/04/2024 8:06:10 pm ******/
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
	[Role] [int] NULL,
	[Active] [bit] NULL,
	[fname] [varchar](max) NULL,
	[mn] [varchar](max) NULL,
	[lname] [varchar](max) NULL,
	[gender] [varchar](50) NULL,
	[email] [varchar](max) NULL,
	[address] [varchar](max) NULL,
	[Timestamp] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vw_Person]    Script Date: 14/04/2024 8:06:10 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_Person]
AS
SELECT p.[ID]
      ,p.[fname]
      ,p.[mn]
      ,p.[lname]
	  ,Fullname = UPPER(CONCAT(p.fname, ' ', CASE WHEN p.mn IS NULL THEN '' ELSE p.mn END, ' ', p.lname))
	  ,p.FamilyHead
	  ,FamilyHeadName = (CASE WHEN (SELECT COUNT(*) FROM tbl_Person ep WHERE p.ID = ep.FamilyHead) >= 1 THEN 'I am the head' ELSE UPPER(CONCAT(h.fname, ' ', h.mn, ' ', h.lname)) END) 
      ,p.[bday]
      ,p.[gender]
      ,p.[CivilStatus]
      ,p.[ShelterType]
      ,p.[Occupation]
      ,p.[isPWD]
      ,p.[RelationshipToHead]
      ,p.[StNo]
      ,p.[Address]
      ,p.[Remarks]
      ,p.[Encoder]
      ,p.[Timestamp]
  FROM [tbl_Person] p LEFT JOIN tbl_Person h ON h.ID = p.FamilyHead



GO
/****** Object:  View [dbo].[vw_Staff]    Script Date: 14/04/2024 8:06:10 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Staff]
as
SELECT st.[ID]
      ,st.[Name]
	  ,OfficialName = ps.Fullname
      ,st.[Position]
	  ,PositionName = p.Position
      ,st.[Instated]
      ,st.[Active]
      ,st.[Encoder]
      ,st.[Timestamp]
  FROM [tbl_Staff] st
  LEFT JOIN tbl_ref_Position p ON p.ID = st.Position
  LEFT JOIN vw_Person ps ON ps.ID = st.Name

GO
SET IDENTITY_INSERT [dbo].[tbl_Person] ON 

GO
INSERT [dbo].[tbl_Person] ([ID], [fname], [mn], [lname], [FamilyHead], [bday], [gender], [CivilStatus], [ShelterType], [Occupation], [isPWD], [RelationshipToHead], [StNo], [Address], [Remarks], [Encoder], [Timestamp]) VALUES (1, N'Adrian', N'Aranilla', N'Jaspio', NULL, CAST(0x000086D600000000 AS DateTime), N'Male', N'Married', N'Rented', N'Computer Programmer', 1, N'Head of the Family', N'Kahusayan st', N'Pamana Homes sub kahusayan st, brgy bucal', NULL, NULL, NULL)
GO
INSERT [dbo].[tbl_Person] ([ID], [fname], [mn], [lname], [FamilyHead], [bday], [gender], [CivilStatus], [ShelterType], [Occupation], [isPWD], [RelationshipToHead], [StNo], [Address], [Remarks], [Encoder], [Timestamp]) VALUES (2, N'Margerie', N'Sidron', N'Jaspio', 1, CAST(0x000086C200000000 AS DateTime), N'Female', N'Married', N'Rented', N'Fisheries Technician', 0, N'Wife', N'Kahusayan st.', NULL, NULL, 1, CAST(0x0000B14101190FF4 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_Person] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_ref_Position] ON 

GO
INSERT [dbo].[tbl_ref_Position] ([ID], [Position], [Encoder], [Timestamp]) VALUES (1, N'Punong Barangay', NULL, CAST(0x0000B1460142CC2E AS DateTime))
GO
INSERT [dbo].[tbl_ref_Position] ([ID], [Position], [Encoder], [Timestamp]) VALUES (2, N'Secretary', 1, CAST(0x0000B15001631FE9 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_ref_Position] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Staff] ON 

GO
INSERT [dbo].[tbl_Staff] ([ID], [Name], [Position], [Instated], [Active], [Encoder], [Timestamp]) VALUES (1, 1, 1, CAST(0x0000B14500000000 AS DateTime), 1, 1, CAST(0x0000B15100869630 AS DateTime))
GO
INSERT [dbo].[tbl_Staff] ([ID], [Name], [Position], [Instated], [Active], [Encoder], [Timestamp]) VALUES (2, 2, 2, CAST(0x0000B14500000000 AS DateTime), 1, 1, CAST(0x0000B15100869C44 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_Staff] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_User] ON 

GO
INSERT [dbo].[tbl_User] ([ID], [Username], [Password], [Role], [Active], [fname], [mn], [lname], [gender], [email], [address], [Timestamp]) VALUES (1, N'admin', N'admin!!@@', 2, 1, N'adrian', N'aranilla', N'jaspio', N'Male', N'adrianjaspio@gmail.com', N'purok santol 1 mayao crossing lucena city', CAST(0x0000B13D00DA7267 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_User] OFF
GO
ALTER TABLE [dbo].[tbl_Person] ADD  CONSTRAINT [DF__tbl_Perso__Times__182C9B23]  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[tbl_ref_Position] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[tbl_Staff] ADD  CONSTRAINT [DF__tbl_Staff__Activ__1A14E395]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[tbl_Staff] ADD  CONSTRAINT [DF__tbl_Staff__Times__1B0907CE]  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[tbl_User] ADD  DEFAULT ((2)) FOR [Role]
GO
ALTER TABLE [dbo].[tbl_User] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[tbl_User] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
USE [master]
GO
ALTER DATABASE [dbBrgyIS] SET  READ_WRITE 
GO
