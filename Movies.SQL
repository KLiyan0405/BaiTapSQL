USE [Movies01]
GO
/****** Object:  Database [Movies]    Script Date: 3/3/2025 10:35:30 AM ******/
CREATE DATABASE [Movies01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Movies_data', FILENAME = N'D:\monsodulieu\Movies\Movies_data.mdf' , SIZE = 25600KB , MAXSIZE = 40960KB , FILEGROWTH = 1024KB ), 
( NAME = N'Movies_data2', FILENAME = N'D:\monsodulieu\Movies\Movies_data2.ndf' , SIZE = 15360KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Movies_log', FILENAME = N'D:\monsodulieu\Movies\Movies_log.ldf' , SIZE = 6144KB , MAXSIZE = 8192KB , FILEGROWTH = 1024KB )
GO
ALTER DATABASE [Movies] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Movies].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Movies] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Movies] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Movies] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Movies] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Movies] SET ARITHABORT OFF 
GO
ALTER DATABASE [Movies] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Movies] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Movies] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Movies] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Movies] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Movies] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Movies] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Movies] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Movies] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Movies] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Movies] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Movies] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Movies] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Movies] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Movies] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Movies] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Movies] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Movies] SET  MULTI_USER 
GO
ALTER DATABASE [Movies] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Movies] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Movies] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Movies] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Movies] SET  READ_WRITE 
GO

ALTER DATABASE Movies ADD FILEGROUP Data

ALTER DATABASE Movies MODIFY FILE
(NAME = 'Movies_log', MAXSIZE = 10MB)

ALTER DATABASE Movies MODIFY FILE
(NAME = 'Movies_data2', SIZE = 10MB)

ALTER DATABASE Movies MODIFY FILE
(NAME = 'Movies_data2', FILEGROUP = Data)