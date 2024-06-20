USE [master]
GO
/****** Object:  Database [dbBrgyIS]    Script Date: 20/06/2024 11:17:24 am ******/
CREATE DATABASE [dbBrgyIS]
GO
USE [dbBrgyIS]
GO
/****** Object:  StoredProcedure [dbo].[tbl_MapSetting_Proc]    Script Date: 20/06/2024 11:17:24 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[tbl_MapSetting_Proc]
@Type VARCHAR(50),
@Latitude DECIMAL(23, 15) = NULL,
@Longitude DECIMAL(23, 15) = NULL
AS
BEGIN
IF @Type = 'Get'
BEGIN
	SELECT * FROM tbl_MapSetting
END
IF @Type = 'Update'
BEGIN
	IF (SELECT COUNT(*) FROM tbl_MapSetting) >= 1
	BEGIN
		UPDATE tbl_MapSetting SET Latitude = @Latitude, Longitude = @Longitude
	END
	ELSE
	BEGIN
		INSERT INTO tbl_MapSetting (Latitude, Longitude) VALUES (@Latitude, @Longitude)
	END
END
END

GO
/****** Object:  StoredProcedure [dbo].[tbl_Person_Proc]    Script Date: 20/06/2024 11:17:24 am ******/
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
@ContactNo VARCHAR(50) = NULL,
@Email VARCHAR(500) = NULL,
@Encoder int = null,
@Timestamp datetime = null
AS
BEGIN
IF @Type = 'Create'
BEGIN
INSERT INTO [tbl_Person]
([fname],[mn],[lname],Suffix,FamilyHead,[bday],[gender],[CivilStatus],[ShelterType],[Occupation],[Father],[Mother],[Guardian],[Partner],[isPWD],[RelationshipToHead],[StNo],[Address],HouseHoldNo, ContactNo, Email,[Remarks],[Encoder])
VALUES
(@fname,@mn,@lname,@Suffix,@FamilyHead,@bday,@gender,@CivilStatus,@ShelterType,@Occupation,@Father,@Mother,@Guardian,@Partner,@isPWD,@RelationshipToHead,@StNo,@Address,@HouseHoldNo,@ContactNo,@Email,@Remarks,@Encoder)

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
,ContactNo = @ContactNo
,Email = @Email
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
SELECT * FROM [vw_Person] WHERE @ID IN (ID, FamilyHead)
END
--------------------------------------------------------------------------------------------------------------------------------------------------------------

END










GO
/****** Object:  StoredProcedure [dbo].[tbl_ref_Position_Proc]    Script Date: 20/06/2024 11:17:24 am ******/
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
/****** Object:  StoredProcedure [dbo].[tbl_Staff_Proc]    Script Date: 20/06/2024 11:17:24 am ******/
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
/****** Object:  StoredProcedure [dbo].[tbl_User_Proc]    Script Date: 20/06/2024 11:17:24 am ******/
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
	IF EXISTS (SELECT * FROM [tbl_User] WHERE HASHBYTES('MD5', Username) = HASHBYTES('MD5', @Username) AND HASHBYTES('MD5', [Password]) = HASHBYTES('MD5', @Password))
	BEGIN
		SELECT @ID = ID FROM [tbl_User] WHERE HASHBYTES('MD5', Username) = HASHBYTES('MD5', @Username) AND HASHBYTES('MD5', [Password]) = HASHBYTES('MD5', @Password) 
		INSERT INTO tbl_User_Log ([User]) VALUES (@ID)
		SELECT * FROM [tbl_User] WHERE HASHBYTES('MD5', Username) = HASHBYTES('MD5', @Username) AND HASHBYTES('MD5', [Password]) = HASHBYTES('MD5', @Password) 
	END
END
END

GO
/****** Object:  UserDefinedFunction [dbo].[FullnameFormat]    Script Date: 20/06/2024 11:17:24 am ******/
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
/****** Object:  Table [dbo].[tbl_FormIssuance]    Script Date: 20/06/2024 11:17:24 am ******/
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
	[Reason] [varchar](max) NULL,
	[Encoder] [int] NULL,
	[Timestamp] [datetime] NULL CONSTRAINT [DF__tbl_FormI__Times__15502E78]  DEFAULT (getdate()),
 CONSTRAINT [PK__tbl_Form__3214EC27362F5E8B] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_MapSetting]    Script Date: 20/06/2024 11:17:24 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_MapSetting](
	[Latitude] [decimal](23, 15) NULL,
	[Longitude] [decimal](23, 15) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Person]    Script Date: 20/06/2024 11:17:24 am ******/
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
	[isPWD] [bit] NULL CONSTRAINT [DF_tbl_Person_isPWD]  DEFAULT ((0)),
	[RelationshipToHead] [varchar](50) NULL,
	[StNo] [varchar](max) NULL,
	[Address] [varchar](max) NULL,
	[HouseHoldNo] [varchar](50) NULL,
	[ContactNo] [varchar](50) NULL,
	[Email] [varchar](500) NULL,
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
/****** Object:  Table [dbo].[tbl_ref_Position]    Script Date: 20/06/2024 11:17:24 am ******/
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
/****** Object:  Table [dbo].[tbl_Staff]    Script Date: 20/06/2024 11:17:24 am ******/
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
/****** Object:  Table [dbo].[tbl_User]    Script Date: 20/06/2024 11:17:24 am ******/
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
/****** Object:  Table [dbo].[tbl_User_Log]    Script Date: 20/06/2024 11:17:24 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_User_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[User] [int] NULL,
	[Timestamp] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vw_Person]    Script Date: 20/06/2024 11:17:24 am ******/
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
	  ,FamilyHeadName = (CASE WHEN (SELECT COUNT(*) FROM tbl_Person ep WHERE p.ID = ep.FamilyHead) >= 1 THEN 'Head' ELSE UPPER(CONCAT(h.fname, ' ', h.mn, ' ', h.lname)) END) 
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
	  ,p.ContactNo
	  ,p.Email
      ,p.[Remarks]
      ,p.[Encoder]
      ,p.[Timestamp]
  FROM [tbl_Person] p LEFT JOIN tbl_Person h ON h.ID = p.FamilyHead
  LEFT JOIN tbl_Person f ON f.ID = p.Father
  LEFT JOIN tbl_Person m ON m.ID = p.Mother
  LEFT JOIN tbl_Person g ON g.ID = p.Guardian
  LEFT JOIN tbl_Person pn ON pn.ID = p.[Partner]






GO
/****** Object:  View [dbo].[vw_Staff]    Script Date: 20/06/2024 11:17:24 am ******/
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
/****** Object:  View [dbo].[vw_FormIssuance]    Script Date: 20/06/2024 11:17:24 am ******/
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
	  ,f.Reason
      ,f.[Encoder]
	  ,EncoderName = UPPER(CONCAT(u.fname, ' ', u.lname))
      ,f.[Timestamp]
  FROM [tbl_FormIssuance] f
  LEFT JOIN vw_Person p ON p.ID = f.Person
  LEFT JOIN tbl_User u ON u.ID = f.Encoder






GO
/****** Object:  View [dbo].[vw_User_Log]    Script Date: 20/06/2024 11:17:24 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_User_Log]
AS
SELECT l.[ID]
      ,l.[User]
	  ,UserName = UPPER(CONCAT(u.fname, ' ' , u.lname))
      ,l.[Timestamp]
  FROM [tbl_User_Log] l
  LEFT JOIN tbl_User u ON u.ID = l.[User]
GO
USE [master]
GO
ALTER DATABASE [dbBrgyIS] SET  READ_WRITE 
GO
