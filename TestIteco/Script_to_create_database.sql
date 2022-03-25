USE [master]
GO
/****** Object:  Database [TestIteco]    Script Date: 26.03.2022 0:03:52 ******/
CREATE DATABASE [TestIteco]
 ON  PRIMARY 
( NAME = N'TestIteco', FILENAME = N'C:\DataBase\TestIteco\TestIteco.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestIteco_log', FILENAME = N'C:\DataBase\TestIteco\TestIteco_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [TestIteco] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestIteco].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestIteco] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestIteco] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestIteco] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestIteco] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestIteco] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestIteco] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestIteco] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestIteco] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestIteco] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestIteco] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestIteco] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestIteco] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestIteco] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestIteco] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestIteco] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestIteco] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestIteco] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestIteco] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestIteco] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestIteco] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestIteco] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestIteco] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestIteco] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestIteco] SET  MULTI_USER 
GO
ALTER DATABASE [TestIteco] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestIteco] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestIteco] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestIteco] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestIteco] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestIteco', N'ON'
GO
ALTER DATABASE [TestIteco] SET QUERY_STORE = OFF
GO
USE [TestIteco]
GO
/****** Object:  Table [dbo].[Calls]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calls](
	[CallID] [int] NOT NULL,
	[SourceContactID] [int] NOT NULL,
	[TargetContactID] [int] NOT NULL,
	[CallDate] [datetime] NOT NULL,
	[CallDuration] [int] NOT NULL,
	[CallSubject] [varchar](200) NOT NULL,
	[CallComment] [text] NOT NULL,
	[CallStatusID] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Table_CallID] PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CallStatuses]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CallStatuses](
	[CallStatusID] [int] NOT NULL,
	[CallStatusName] [varchar](100) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_CallStatuses] PRIMARY KEY CLUSTERED 
(
	[CallStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConferenceContacts]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConferenceContacts](
	[ConferenceID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
 CONSTRAINT [PK_ConferenceContacts] PRIMARY KEY CLUSTERED 
(
	[ConferenceID] ASC,
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conferences]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conferences](
	[ConferenceID] [int] NOT NULL,
	[ConferencePlannedDate] [datetime] NOT NULL,
	[ConferenceBeganDate] [datetime] NOT NULL,
	[ConferenceStatusID] [int] NOT NULL,
	[ConferenceSubject] [varchar](200) NOT NULL,
	[ConferenceComment] [text] NOT NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Conferences] PRIMARY KEY CLUSTERED 
(
	[ConferenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConferenceStatuses]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConferenceStatuses](
	[ConferenceStatusID] [int] NOT NULL,
	[ConferenceStatusName] [varchar](100) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_ConferenceStatuses] PRIMARY KEY CLUSTERED 
(
	[ConferenceStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactID] [int] NOT NULL,
	[ContactName] [varchar](200) NOT NULL,
	[ContactAddress] [varchar](300) NOT NULL,
	[ContactDateOfBirth] [date] NOT NULL,
	[GroupName] [varchar](200) NOT NULL,
	[CompanyName] [varchar](200) NOT NULL,
	[ContactPosition] [varchar](200) NOT NULL,
	[ContactEmail] [varchar](100) NOT NULL,
	[ContactPhone] [bigint] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Routes]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Routes](
	[RouteID] [varchar](50) NOT NULL,
	[RouteURL] [varchar](150) NOT NULL,
	[RouteFile] [varchar](150) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_SourceContactID]    Script Date: 26.03.2022 0:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_Table_SourceContactID] ON [dbo].[Calls]
(
	[SourceContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_TargetContactID]    Script Date: 26.03.2022 0:03:52 ******/
CREATE NONCLUSTERED INDEX [IX_Table_TargetContactID] ON [dbo].[Calls]
(
	[TargetContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Calls] ADD  CONSTRAINT [DF_Calls_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[CallStatuses] ADD  CONSTRAINT [DF_CallStatuses_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Conferences] ADD  CONSTRAINT [DF_Conferences_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[ConferenceStatuses] ADD  CONSTRAINT [DF_ConferenceStatuses_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Contacts] ADD  CONSTRAINT [DF_Contacts_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Routes] ADD  CONSTRAINT [DF_Routes_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  StoredProcedure [dbo].[up_Call_Delete]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Call_Delete]
@CallID int
AS
BEGIN

	SET NOCOUNT ON;

	update Calls 
	set
		Deleted = 1
	where CallID = @CallID

END
GO
/****** Object:  StoredProcedure [dbo].[up_Call_Save]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Call_Save]
@CallID int,
@SourceContactID int,
@TargetContactID int,
@CallDate datetime,
@CallDuration int,
@CallSubject varchar(200),
@CallComment text,
@CallStatusID int
AS
BEGIN

	SET NOCOUNT ON;

	begin transaction

	if (@CallID = 0)
	begin

	set @CallID = isnull((select max(t1.CallID) from Calls t1 with(tablockx,holdlock,updlock)),0) + 1

	insert into Calls
	(CallID,SourceContactID,TargetContactID,CallDate,CallDuration,CallSubject,CallComment,CallStatusID)
	values
	(@CallID,@SourceContactID,@TargetContactID,@CallDate,@CallDuration,@CallSubject,@CallComment,@CallStatusID)

	end
	else
	begin

	update Calls
	set
		SourceContactID = @SourceContactID,
		TargetContactID = @TargetContactID,
		CallDate = @CallDate,
		CallDuration = @CallDuration,
		CallSubject = @CallSubject,
		CallComment = @CallComment,
		CallStatusID = @CallStatusID 
	where CallID = @CallID

	end

	select @CallID CallID

	if @@ERROR = 0
		commit transaction
	else
		rollback transaction

END
GO
/****** Object:  StoredProcedure [dbo].[up_Call_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Call_Select]
@CallID int
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.SourceContactID,
		t1.TargetContactID,
		t1.CallDate,
		t1.CallDuration,
		t1.CallSubject,
		t1.CallComment,
		t1.CallStatusID,

		t2.CallStatusName
	from Calls t1
	left join CallStatuses t2
	on t1.CallStatusID = t2.CallStatusID
	where t1.CallID = @CallID

END
GO
/****** Object:  StoredProcedure [dbo].[up_Calls_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Calls_Select]
@SourceContactID int,
@TargetContactID int
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.CallID,
		t1.SourceContactID,
		t1.TargetContactID,
		t1.CallDate,
		t1.CallDuration,
		t1.CallSubject,
		t1.CallComment,
		t1.CallStatusID,

		t2.CallStatusName
	from Calls t1
	left join CallStatuses t2
	on t1.CallStatusID = t2.CallStatusID
	where (t1.SourceContactID = @SourceContactID or @SourceContactID = 0) and
		  (t1.TargetContactID = @TargetContactID or @TargetContactID = 0) and
		   t1.Deleted = 0

END
GO
/****** Object:  StoredProcedure [dbo].[up_CallStatus_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 23.04.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_CallStatus_Select]
@CallStatusID int
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.CallStatusName
	from CallStatuses t1
	where t1.CallStatusID = @CallStatusID


END
GO
/****** Object:  StoredProcedure [dbo].[up_CallStatuses_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 23.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_CallStatuses_Select]

AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.CallStatusID,
		t1.CallStatusName
	from CallStatuses t1
	where t1.Deleted = 0

END
GO
/****** Object:  StoredProcedure [dbo].[up_Conference_Delete]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Conference_Delete]
@ConferenceID int
AS
BEGIN

	SET NOCOUNT ON;

	update Conferences 
	set
		Deleted = 1
	where ConferenceID = @ConferenceID


END
GO
/****** Object:  StoredProcedure [dbo].[up_Conference_Save]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Conference_Save]
@ConferenceID int,
@ConferencePlannedDate datetime,
@ConferenceBeganDate datetime,
@ConferenceStatusID int,
@ConferenceSubject varchar(200),
@ConferenceComment text
AS
BEGIN

	SET NOCOUNT ON;

	begin transaction

	if (@ConferenceID = 0)
	begin

	set @ConferenceID = isnull((select max(t1.ConferenceID) from Conferences t1 with(tablockx,holdlock,updlock)),0) + 1

	insert into Conferences 
	(ConferenceID,ConferencePlannedDate,ConferenceBeganDate,ConferenceStatusID,ConferenceSubject,ConferenceComment)
	values
	(@ConferenceID,@ConferencePlannedDate,@ConferenceBeganDate,@ConferenceStatusID,@ConferenceSubject,@ConferenceComment)

	end
	else
	begin

	update Conferences 
	set
		ConferencePlannedDate = @ConferencePlannedDate,
		ConferenceBeganDate = @ConferenceBeganDate,
		ConferenceStatusID = @ConferenceStatusID,
		ConferenceSubject = @ConferenceSubject,
		ConferenceComment = @ConferenceComment
	where ConferenceID = @ConferenceID
		
	end

	select @ConferenceID ConferenceID

	if @@ERROR = 0
		commit transaction
	else
		rollback transaction

END
GO
/****** Object:  StoredProcedure [dbo].[up_Conference_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Conference_Select]
@ConferenceID int
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.ConferencePlannedDate,
		t1.ConferenceBeganDate,
		t1.ConferenceStatusID,
		t1.ConferenceSubject,
		t1.ConferenceComment
	from Conferences t1
	where t1.ConferenceID = @ConferenceID

END
GO
/****** Object:  StoredProcedure [dbo].[up_ConferenceContact_Delete]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_ConferenceContact_Delete]
@ConferenceID int,
@ContactID int
AS
BEGIN

	SET NOCOUNT ON;

	delete from ConferenceContacts 
	where ConferenceID = @ConferenceID and ContactID = @ContactID

END
GO
/****** Object:  StoredProcedure [dbo].[up_ConferenceContact_Save]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_ConferenceContact_Save]
@ConferenceID int,
@ContactID int
AS
BEGIN

	SET NOCOUNT ON;

	begin transaction

	if not exists(select top 1 * from ConferenceContacts t1 with(tablockx,holdlock,updlock) where t1.ConferenceID = @ConferenceID and t1.ContactID = @ContactID)
	begin

	insert into ConferenceContacts
	(ConferenceID,ContactID)
	values
	(@ConferenceID,@ContactID)

	end

	if @@ERROR = 0
		commit transaction
	else
		rollback transaction

END
GO
/****** Object:  StoredProcedure [dbo].[up_ConferenceContacts_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_ConferenceContacts_Select]
@ConferenceID int,
@ContactID int
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.ConferenceID,
		t1.ContactID
	from ConferenceContacts t1
	where (t1.ConferenceID = @ConferenceID or @ConferenceID = 0) and
		  (t1.ContactID = @ContactID or @ContactID = 0)


END
GO
/****** Object:  StoredProcedure [dbo].[up_Conferences_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Conferences_Select]
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.ConferenceID,
		t1.ConferencePlannedDate,
		t1.ConferenceBeganDate,
		t1.ConferenceStatusID,
		t1.ConferenceSubject,
		t1.ConferenceComment
	from Conferences t1
	where t1.Deleted = 0

END
GO
/****** Object:  StoredProcedure [dbo].[up_ConferenceStatus_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 23.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_ConferenceStatus_Select]
@ConferenceStatusID int
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.ConferenceStatusName
	from ConferenceStatuses t1
	where t1.ConferenceStatusID = @ConferenceStatusID

END
GO
/****** Object:  StoredProcedure [dbo].[up_ConferenceStatuses_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 23.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_ConferenceStatuses_Select]

AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.ConferenceStatusID,
		t1.ConferenceStatusName
	from ConferenceStatuses t1
	where t1.Deleted = 0

END
GO
/****** Object:  StoredProcedure [dbo].[up_Contact_Delete]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Contact_Delete]
@ContactID int
AS
BEGIN

	SET NOCOUNT ON;

	update Contacts
	set
		Deleted = 1
	where ContactID = @ContactID

END
GO
/****** Object:  StoredProcedure [dbo].[up_Contact_Save]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Contact_Save]
@ContactID int,
@ContactName varchar(200),
@ContactAddress varchar(300),
@ContactDateOfBirth datetime,
@GroupName varchar(200),
@CompanyName varchar(200),
@ContactPosition varchar(200),
@ContactEmail varchar(100),
@ContactPhone bigint
AS
BEGIN

	SET NOCOUNT ON;

	begin transaction

	if (@ContactID = 0)
	begin

	set @ContactID = isnull((select max(t1.ContactID) from Contacts t1 with(tablockx,holdlock,updlock)),0) + 1

	insert into Contacts
	(ContactID,ContactName,ContactAddress,ContactDateOfBirth,GroupName,CompanyName,ContactPosition,ContactEmail,ContactPhone)
	values
	(@ContactID,@ContactName,@ContactAddress,@ContactDateOfBirth,@GroupName,@CompanyName,@ContactPosition,@ContactEmail,@ContactPhone)

	end
	else
	begin

	update Contacts
	set
		ContactName = @ContactName,
		ContactAddress = @ContactAddress,
		ContactDateOfBirth = @ContactDateOfBirth,
		GroupName = @GroupName,
		CompanyName = @CompanyName,
		ContactPosition = @ContactPosition,
		ContactEmail = @ContactEmail,
		ContactPhone = @ContactPhone
	where ContactID = @ContactID

	end

	select @ContactID ContactID

	if @@ERROR = 0
		commit transaction
	else
		rollback transaction


END
GO
/****** Object:  StoredProcedure [dbo].[up_Contact_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Contact_Select]
@ContactID int
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.ContactName,
		t1.ContactAddress,
		t1.ContactDateOfBirth,
		t1.GroupName,
		t1.CompanyName,
		t1.ContactPosition,
		t1.ContactEmail,
		t1.ContactPhone
	from Contacts t1
	where t1.ContactID = @ContactID


END
GO
/****** Object:  StoredProcedure [dbo].[up_ContactHistory_select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 25.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_ContactHistory_select]
@ContactID int
AS
BEGIN

	SET NOCOUNT ON;

	create table #tmp (CallID int, ConferenceID int, ActionDate datetime, ActionName varchar(200), ActionStatus varchar(100), ActionDescription varchar(500), ContactPhone bigint)


	insert into #tmp
	select 
		t1.CallID,
		0,
		t1.CallDate,
		'Исходящий вызов',
		t3.CallStatusName,
		'Кому звонил: ' + t2.ContactName,
		t2.ContactPhone
	from Calls t1
	left join Contacts t2
	on t1.TargetContactID = t2.ContactID
	left join CallStatuses t3
	on t1.CallStatusID = t3.CallStatusID
	where t1.SourceContactID = @ContactID and t1.Deleted = 0

	insert into #tmp
	select 
		t1.CallID,
		0,
		t1.CallDate,
		'Входящий вызов',
		t3.CallStatusName,
		'Кто звонил: ' + t2.ContactName,
		t2.ContactPhone
	from Calls t1
	left join Contacts t2
	on t1.SourceContactID = t2.ContactID
		left join CallStatuses t3
	on t1.CallStatusID = t3.CallStatusID
	where t1.TargetContactID = @ContactID and t1.Deleted = 0

	insert into #tmp
	select 0,
	t1.ConferenceID,
	t1.ConferencePlannedDate,
	'Участие в конференции',
	t2.ConferenceStatusName,
	'Тема: ' + t1.ConferenceSubject,
	0
	from Conferences t1
	left join ConferenceStatuses t2
	on t1.ConferenceStatusID + 1 = t2.ConferenceStatusID
	where t1.Deleted = 0

	select 
		t1.CallID,
		t1.ConferenceID,
		t1.ActionDate,
		t1.ActionName,
		t1.ActionStatus,
		t1.ActionDescription,
		t1.ContactPhone
	from #tmp t1

	drop table #tmp
END
GO
/****** Object:  StoredProcedure [dbo].[up_Contacts_Select]    Script Date: 26.03.2022 0:03:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		D.Dymov
-- Create date: 22.03.2022
-- =============================================
CREATE PROCEDURE [dbo].[up_Contacts_Select]
AS
BEGIN

	SET NOCOUNT ON;

	select 
		t1.ContactID,
		t1.ContactName,
		t1.ContactAddress,
		t1.ContactDateOfBirth,
		t1.GroupName,
		t1.CompanyName,
		t1.ContactPosition,
		t1.ContactEmail,
		t1.ContactPhone
	from Contacts t1
	where t1.Deleted = 0

END
GO
USE [master]
GO
ALTER DATABASE [TestIteco] SET  READ_WRITE 
GO
