USE [master]
GO
/****** Object:  Database [MerlinAgg]    Script Date: 7/16/2015 3:32:32 PM ******/
CREATE DATABASE [MerlinAgg]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MerlinAgg', FILENAME = N'D:\RDSDBDATA\DATA\MerlinAgg.mdf' , SIZE = 2730048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MerlinAgg_log', FILENAME = N'D:\RDSDBDATA\DATA\MerlinAgg_log.ldf' , SIZE = 2927680KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MerlinAgg] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MerlinAgg].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MerlinAgg] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MerlinAgg] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MerlinAgg] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MerlinAgg] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MerlinAgg] SET ARITHABORT OFF 
GO
ALTER DATABASE [MerlinAgg] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MerlinAgg] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MerlinAgg] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MerlinAgg] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MerlinAgg] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MerlinAgg] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MerlinAgg] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MerlinAgg] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MerlinAgg] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MerlinAgg] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MerlinAgg] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MerlinAgg] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MerlinAgg] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MerlinAgg] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MerlinAgg] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MerlinAgg] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MerlinAgg] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MerlinAgg] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MerlinAgg] SET RECOVERY FULL 
GO
ALTER DATABASE [MerlinAgg] SET  MULTI_USER 
GO
ALTER DATABASE [MerlinAgg] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MerlinAgg] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MerlinAgg] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MerlinAgg] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [MerlinAgg]
GO
/****** Object:  User [sau_merlin]    Script Date: 7/16/2015 3:32:33 PM ******/
CREATE USER [sau_merlin] FOR LOGIN [sau_merlin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sau_merlin]
GO
/****** Object:  Table [dbo].[AllocationResult_EEZ]    Script Date: 7/16/2015 3:32:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllocationResult_EEZ](
	[UniversalDataID] [int] NOT NULL,
	[EEZID] [int] NOT NULL,
	[FaoAreaID] [tinyint] NOT NULL,
	[TotalCatch] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AllocationResult_Global]    Script Date: 7/16/2015 3:32:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllocationResult_Global](
	[UniversalDataID] [int] NOT NULL,
	[AreaID] [int] NOT NULL,
	[TotalCatch] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AllocationResult_LME]    Script Date: 7/16/2015 3:32:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllocationResult_LME](
	[UniversalDataID] [int] NOT NULL,
	[LMEID] [smallint] NULL,
	[TotalCatch] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AllocationResult_RFMO]    Script Date: 7/16/2015 3:32:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllocationResult_RFMO](
	[UniversalDataID] [int] NOT NULL,
	[RFMOID] [smallint] NULL,
	[TotalCatch] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Data]    Script Date: 7/16/2015 3:32:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Data](
	[UniversalDataID] [int] NOT NULL,
	[AllocationAreaTypeID] [tinyint] NOT NULL,
	[GenericAllocationAreaID] [int] NOT NULL,
	[DataLayerID] [tinyint] NOT NULL,
	[FishingEntityID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[TaxonKey] [int] NOT NULL,
	[CatchAmount] [float] NOT NULL,
	[SectorTypeID] [tinyint] NOT NULL,
	[CatchTypeID] [tinyint] NOT NULL,
	[InputTypeID] [tinyint] NOT NULL,
	[UniqueAreaID_AutoGen] [int] NULL,
	[OriginalFishingEntityID] [int] NOT NULL,
	[UnitPrice] [float] NOT NULL,
 CONSTRAINT [PK_Data] PRIMARY KEY CLUSTERED 
(
	[UniversalDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Data] ADD  CONSTRAINT [DF_Data_Price]  DEFAULT ((1466)) FOR [UnitPrice]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 7/16/2015 3:32:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [rds_deny_backups_trigger] ON DATABASE WITH EXECUTE AS 'dbo' FOR
 ADD_ROLE_MEMBER, GRANT_DATABASE AS BEGIN
   SET NOCOUNT ON;
   SET ANSI_PADDING ON;
 
   DECLARE @data xml;
   DECLARE @user sysname;
   DECLARE @role sysname;
   DECLARE @type sysname;
   DECLARE @sql NVARCHAR(MAX);
   DECLARE @permissions TABLE(name sysname PRIMARY KEY);
   
   SELECT @data = EVENTDATA();
   SELECT @type = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname');
    
   IF @type = 'ADD_ROLE_MEMBER' BEGIN
      SELECT @user = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
       @role = @data.value('(/EVENT_INSTANCE/RoleName)[1]', 'sysname');

      IF @role IN ('db_owner', 'db_backupoperator') BEGIN
         SELECT @sql = 'DENY BACKUP DATABASE, BACKUP LOG TO ' + QUOTENAME(@user);
         EXEC(@sql);
      END
   END ELSE IF @type = 'GRANT_DATABASE' BEGIN
      INSERT INTO @permissions(name)
      SELECT Permission.value('(text())[1]', 'sysname') FROM
       @data.nodes('/EVENT_INSTANCE/Permissions/Permission')
      AS DatabasePermissions(Permission);
      
      IF EXISTS (SELECT * FROM @permissions WHERE name IN ('BACKUP DATABASE',
       'BACKUP LOG'))
         RAISERROR('Cannot grant backup database or backup log', 15, 1) WITH LOG;       
   END
END


GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ENABLE TRIGGER [rds_deny_backups_trigger] ON DATABASE
GO
USE [master]
GO
ALTER DATABASE [MerlinAgg] SET  READ_WRITE 
GO
