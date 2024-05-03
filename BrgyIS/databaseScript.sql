USE [master]
GO
/****** Object:  Database [dbBrgyIS]    Script Date: 03/05/2024 2:25:59 pm ******/
CREATE DATABASE [dbBrgyIS]
GO
USE [dbBrgyIS]
GO
/****** Object:  StoredProcedure [dbo].[tbl_Person_Proc]    Script Date: 03/05/2024 2:25:59 pm ******/
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
@Suffix varchar(50) = null,
@FamilyHead INT = null,
@bday datetime = null,
@gender varchar(max) = null,
@CivilStatus varchar(max) = null,
@ShelterType varchar(500) = null,
@Occupation varchar(max) = null,
@Father INT = null,
@Mother INT = null,
@Guardian INT = null,
@Partner INT = null,
@isPWD bit = null,
@RelationshipToHead varchar(50) = null,
@StNo varchar(max) = null,
@Address varchar(max) = null,
@HouseHoldNo varchar(50) = null,
@Remarks varchar(max) = null,
@Encoder int = null,
@Timestamp datetime = null
AS
BEGIN
IF @Type = 'Create'
BEGIN
INSERT INTO [tbl_Person]
([fname],[mn],[lname],Suffix,FamilyHead,[bday],[gender],[CivilStatus],[ShelterType],[Occupation],[Father],[Mother],[Guardian],[Partner],[isPWD],[RelationshipToHead],[StNo],[Address],HouseHoldNo,[Remarks],[Encoder])
VALUES
(@fname,@mn,@lname,@Suffix,@FamilyHead,@bday,@gender,@CivilStatus,@ShelterType,@Occupation,@Father,@Mother,@Guardian,@Partner,@isPWD,@RelationshipToHead,@StNo,@Address,@HouseHoldNo,@Remarks,@Encoder)

END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Update'
BEGIN
UPDATE [tbl_Person] SET [fname] = @fname
,[mn] = @mn
,[lname] = @lname
,Suffix = @Suffix
,FamilyHead = @FamilyHead
,[bday] = @bday
,[gender] = @gender
,[CivilStatus] = @CivilStatus
,[ShelterType] = @ShelterType
,[Occupation] = @Occupation
,[Father] = @Father
,[Mother] = @Mother
,[Guardian] = @Guardian
,[Partner] = @Partner
,[isPWD] = @isPWD
,[RelationshipToHead] = @RelationshipToHead
,[StNo] = @StNo
,[Address] = @Address
,[Remarks] = @Remarks
,HouseHoldNo = @HouseHoldNo
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
IF @Type = 'Household'
BEGIN
SELECT * FROM [vw_Person] WHERE ID = @ID OR FamilyHead = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------

END








GO
/****** Object:  StoredProcedure [dbo].[tbl_ref_Position_Proc]    Script Date: 03/05/2024 2:25:59 pm ******/
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
/****** Object:  StoredProcedure [dbo].[tbl_Staff_Proc]    Script Date: 03/05/2024 2:25:59 pm ******/
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
IF @Type = 'LatestCaptain'
BEGIN
SELECT TOP 1 * FROM [vw_Staff] WHERE Position = 1 ORDER BY Instated DESC
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------
IF @Type = 'Find'
BEGIN
SELECT * FROM [vw_Staff] WHERE  ID = @ID
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------

END





GO
/****** Object:  StoredProcedure [dbo].[tbl_User_Proc]    Script Date: 03/05/2024 2:25:59 pm ******/
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
/****** Object:  UserDefinedFunction [dbo].[FullnameFormat]    Script Date: 03/05/2024 2:25:59 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FullnameFormat](@fname varchar(max),@mn varchar(max),@lname varchar(max),@suffix varchar(50))
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @OUTPUT VARCHAR(MAX)
	SET @OUTPUT = UPPER(CONCAT(@fname, ' ', CASE WHEN @mn IS NULL THEN '' ELSE @mn END, ' ', @lname, CASE WHEN @suffix IS NOT NULL THEN ' ' + @suffix END))
	RETURN @OUTPUT	
END


GO
/****** Object:  Table [dbo].[tbl_FormIssuance]    Script Date: 03/05/2024 2:25:59 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_FormIssuance](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Person] [int] NULL,
	[Form] [varchar](max) NULL,
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
/****** Object:  Table [dbo].[tbl_Person]    Script Date: 03/05/2024 2:25:59 pm ******/
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
	[Suffix] [varchar](50) NULL,
	[FamilyHead] [int] NULL,
	[bday] [datetime] NULL,
	[gender] [varchar](max) NULL,
	[CivilStatus] [varchar](max) NULL,
	[ShelterType] [varchar](500) NULL,
	[Occupation] [varchar](max) NULL,
	[Father] [int] NULL,
	[Mother] [int] NULL,
	[Guardian] [int] NULL,
	[Partner] [int] NULL,
	[isPWD] [bit] NULL,
	[RelationshipToHead] [varchar](50) NULL,
	[StNo] [varchar](max) NULL,
	[Address] [varchar](max) NULL,
	[HouseHoldNo] [varchar](50) NULL,
	[Remarks] [varchar](max) NULL,
	[Encoder] [int] NULL,
	[Timestamp] [datetime] NULL CONSTRAINT [DF__tbl_Perso__Times__182C9B23]  DEFAULT (getdate()),
 CONSTRAINT [PK__tbl_Pers__3214EC272CFE972E] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ref_Position]    Script Date: 03/05/2024 2:25:59 pm ******/
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
	[Timestamp] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Staff]    Script Date: 03/05/2024 2:25:59 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Staff](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [int] NULL,
	[Position] [int] NULL,
	[Instated] [datetime] NULL,
	[Active] [bit] NULL CONSTRAINT [DF__tbl_Staff__Activ__1A14E395]  DEFAULT ((1)),
	[Encoder] [int] NULL,
	[Timestamp] [datetime] NULL CONSTRAINT [DF__tbl_Staff__Times__1B0907CE]  DEFAULT (getdate()),
 CONSTRAINT [PK__tbl_Staf__3214EC275498A3BE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_User]    Script Date: 03/05/2024 2:25:59 pm ******/
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
/****** Object:  View [dbo].[vw_Person]    Script Date: 03/05/2024 2:25:59 pm ******/
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
	  ,p.Suffix
	  ,Fullname = dbo.FullnameFormat(p.fname, p.mn, p.lname, p.Suffix)
	  ,p.FamilyHead
	  ,FamilyHeadName = (CASE WHEN (SELECT COUNT(*) FROM tbl_Person ep WHERE p.ID = ep.FamilyHead) >= 1 THEN 'I am the head' ELSE UPPER(CONCAT(h.fname, ' ', h.mn, ' ', h.lname)) END) 
      ,p.[bday]
	  ,Age = DATEDIFF(YEAR, p.bday, GETDATE())
	  ,isSenior = CASE WHEN DATEDIFF(YEAR, p.bday, GETDATE()) >= 60 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
      ,p.[gender]
      ,p.[CivilStatus]
      ,p.[ShelterType]
      ,p.[Occupation]
	  ,p.Father
	  ,FatherName = dbo.FullnameFormat(f.fname, f.mn, f.lname, f.Suffix)
	  ,p.Mother
	  ,MotherName = dbo.FullnameFormat(m.fname, m.mn, m.lname, m.Suffix)
	  ,p.Guardian
	  ,GuardianName = dbo.FullnameFormat(g.fname, g.mn, g.lname, g.Suffix)
	  ,p.[Partner]
	  ,PartnerName = dbo.FullnameFormat(pn.fname, pn.mn, pn.lname, pn.Suffix)
      ,p.[isPWD]
      ,p.[RelationshipToHead]
      ,p.[StNo]
      ,p.[Address]
	  ,p.HouseHoldNo
      ,p.[Remarks]
      ,p.[Encoder]
      ,p.[Timestamp]
  FROM [tbl_Person] p LEFT JOIN tbl_Person h ON h.ID = p.FamilyHead
  LEFT JOIN tbl_Person f ON f.ID = p.Father
  LEFT JOIN tbl_Person m ON m.ID = p.Mother
  LEFT JOIN tbl_Person g ON g.ID = p.Guardian
  LEFT JOIN tbl_Person pn ON pn.ID = p.[Partner]


GO
/****** Object:  View [dbo].[vw_Staff]    Script Date: 03/05/2024 2:25:59 pm ******/
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
/****** Object:  View [dbo].[vw_FormIssuance]    Script Date: 03/05/2024 2:25:59 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_FormIssuance]
AS
SELECT f.[ID]
      ,f.[Person]
	  ,Fullname = p.Fullname
      ,f.[Form]
      ,f.[Encoder]
      ,f.[Timestamp]
  FROM [tbl_FormIssuance] f
  LEFT JOIN vw_Person p ON p.ID = f.Person


GO
SET IDENTITY_INSERT [dbo].[tbl_FormIssuance] ON 

GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (1, 1, N'Brgy. Clearance', 0, CAST(N'2024-04-19 16:22:01.113' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (2, 2, N'Brgy. Clearance', 1, CAST(N'2024-04-19 16:53:31.410' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (3, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 12:02:57.243' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (4, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 12:04:04.360' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (5, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 12:06:09.323' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (6, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 12:06:34.447' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (7, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 21:57:22.550' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (8, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 21:58:53.237' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (9, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 21:59:51.140' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (10, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 22:00:14.433' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (11, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 22:00:25.477' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (12, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 22:00:35.770' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (13, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 22:01:05.157' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (14, 1, N'Late Filing of Birth', 1, CAST(N'2024-04-28 22:01:59.013' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (15, 1, N'Late Filing of Birth', 1, CAST(N'2024-04-28 22:03:23.307' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (16, 1, N'Late Filing of Birth', 1, CAST(N'2024-04-28 22:04:22.920' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (17, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 22:04:30.717' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (18, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 22:05:07.613' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (19, 1, N'Brgy. Clearance', 1, CAST(N'2024-04-28 22:06:48.910' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (20, 1, N'Certificate of Residency', 1, CAST(N'2024-04-28 22:12:03.270' AS DateTime))
GO
INSERT [dbo].[tbl_FormIssuance] ([ID], [Person], [Form], [Encoder], [Timestamp]) VALUES (21, 1, N'Certificate of Residency', 1, CAST(N'2024-04-28 22:13:00.200' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_FormIssuance] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Person] ON 

GO
INSERT [dbo].[tbl_Person] ([ID], [fname], [mn], [lname], [Suffix], [FamilyHead], [bday], [gender], [CivilStatus], [ShelterType], [Occupation], [Father], [Mother], [Guardian], [Partner], [isPWD], [RelationshipToHead], [StNo], [Address], [HouseHoldNo], [Remarks], [Encoder], [Timestamp]) VALUES (1, N'Adrian', N'Aranilla', N'Jaspio', N'Sr', NULL, CAST(N'1994-07-05 00:00:00.000' AS DateTime), N'Male', N'Married', N'Rented', N'Computer Programmer', 1, 2, NULL, 2, 1, N'Head of the Family', N'Kahusayan st', N'Pamana Homes sub kahusayan st, brgy bucal', N'34', NULL, NULL, NULL)
GO
INSERT [dbo].[tbl_Person] ([ID], [fname], [mn], [lname], [Suffix], [FamilyHead], [bday], [gender], [CivilStatus], [ShelterType], [Occupation], [Father], [Mother], [Guardian], [Partner], [isPWD], [RelationshipToHead], [StNo], [Address], [HouseHoldNo], [Remarks], [Encoder], [Timestamp]) VALUES (2, N'Margerie', N'Sidron', N'Jaspio', NULL, 1, CAST(N'1994-06-15 00:00:00.000' AS DateTime), N'Female', N'Married', N'Rented', N'Fisheries Technician', NULL, NULL, NULL, 1, 0, N'Wife', N'Kahusayan st.', NULL, N'34', NULL, 1, CAST(N'2024-03-28 17:03:19.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_Person] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_ref_Position] ON 

GO
INSERT [dbo].[tbl_ref_Position] ([ID], [Position], [Encoder], [Timestamp]) VALUES (1, N'Punong Barangay', NULL, CAST(N'2024-04-02 19:35:16.207' AS DateTime))
GO
INSERT [dbo].[tbl_ref_Position] ([ID], [Position], [Encoder], [Timestamp]) VALUES (2, N'Secretary', 1, CAST(N'2024-04-12 21:32:58.163' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_ref_Position] OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_Staff] ON 

GO
INSERT [dbo].[tbl_Staff] ([ID], [Name], [Position], [Instated], [Active], [Encoder], [Timestamp]) VALUES (1, 1, 1, CAST(N'2024-04-01 00:00:00.000' AS DateTime), 1, 1, CAST(N'2024-04-13 08:10:00.907' AS DateTime))
GO
INSERT [dbo].[tbl_Staff] ([ID], [Name], [Position], [Instated], [Active], [Encoder], [Timestamp]) VALUES (2, 2, 2, CAST(N'2024-04-01 00:00:00.000' AS DateTime), 1, 1, CAST(N'2024-04-13 08:10:06.093' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_Staff] OFF
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
