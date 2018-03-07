USE [LDSPhilanthropiesDW]
GO

/****** Object:  StoredProcedure [dbo].[usp_Ldsp_Etl_Coupler]    Script Date: 8/24/2018 3:58:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE dbo.usp_Ldsp_Etl_Coupler 
AS
BEGIN
-- --------------------------
-- ALPHA
-- --------------------------
IF OBJECT_ID('LDSPhilanthropiesDW.dbo.Alpha_Table_1','U') IS NOT NULL
DROP TABLE LDSPhilanthropiesDW.dbo.Alpha_Table_1;


CREATE TABLE dbo.Alpha_Table_1 (
	Alpha_Key INT IDENTITY(1,1) PRIMARY KEY
	, Alpha_DateTime DATETIME
	, Alpha_Stage NVARCHAR(50)
	, Alpha_Step_Number NVARCHAR(10)
	, Alpha_Step_Name NVARCHAR(200)
	, Alpha_Begin_Time DATETIME
	, Alpha_End_Time DATETIME
	, Alpha_Duration_In_Seconds INT
	, Alpha_Count INT
	, Alpha_Query NVARCHAR(MAX)
	, Alpha_Result BIT DEFAULT 0
	, ErrorNumber INT
	, ErrorSeverity INT
	, ErrorState INT
	, ErrorProcedure NVARCHAR(500)
	, ErrorLine INT
	, ErrorMessage NVARCHAR(MAX)
)
	
; 


EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = 'Script Start', @Alpha_Step_Number = 'EXT_1A', @Alpha_Step_Name = 'Beginning', @Alpha_Result = 1;



DECLARE @FiveAttempts INT
SET @FiveAttempts = 0

WHILE @FiveAttempts < 5
BEGIN			

	DECLARE @Main_Total_Loop_Num INT
		SELECT @Main_Total_Loop_Num = (
			SELECT MAX(Extract_Tables_Key) AS Max_Field
				FROM Oa_Extract.Extract_Tables
				WHERE 1 = 1
					AND Active = 1
		)
	DECLARE @Main_LOOP_NUM INT
	SET @Main_LOOP_NUM = 1
		WHILE  @Main_LOOP_NUM <= @Main_Total_Loop_Num 
		BEGIN

			DECLARE @IsActive INT
			SELECT @IsActive = (
				SELECT Active 
					FROM Oa_Extract.Extract_Tables
					WHERE 1 = 1
						AND Extract_Tables_Key = @Main_LOOP_NUM
			)
			DECLARE @Table_Name_By_Loop NVARCHAR(200)
			SELECT @Table_Name_By_Loop = (
				SELECT Ext_Table
					FROM Oa_Extract.Extract_Tables
					WHERE 1 = 1
						AND Extract_Tables_Key = @Main_LOOP_NUM
			)
			DECLARE @NeedToRun INT
			SELECT @NeedToRun = (
				SELECT CASE WHEN COALESCE(CONVERT(DATE,Time_Stamp),CONVERT(DATE,GETDATE()-1)) < CONVERT(DATE,GETDATE()) OR Alpha_Result NOT IN (6,11,15,19,23) THEN 1 ELSE 0 END 
					FROM Oa_Extract.Extract_Tables A
						LEFT JOIN
							(SELECT Alpha_Stage AS Production_Table
								, COUNT(Alpha_Result) AS Alpha_Result
								, MAX(Alpha_DateTime) AS Time_Stamp
								FROM dbo.Alpha_Table_1 
								WHERE 1 = 1
								GROUP BY Alpha_Stage
							) B ON A.Ext_Table = B.Production_Table
					WHERE 1 = 1
						AND Extract_Tables_Key = @Main_LOOP_NUM
			)

			IF @IsActive = 1 AND @NeedToRun = 1
				BEGIN

					BEGIN TRY
	
					-- -----------------------------
					-- Create Table
					-- -----------------------------
					
						DECLARE @TABLE_NAME VARCHAR(100)
						DECLARE @CREATE_FIELDS VARCHAR(MAX)
						DECLARE @INSERT_FIELDS VARCHAR(MAX)
						DECLARE @FROM_STATEMENT VARCHAR(MAX)
						DECLARE @SQL_1 VARCHAR(MAX)
						DECLARE @SQL_2 VARCHAR(MAX)

						SELECT @TABLE_NAME = (SELECT Ext_Table FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @CREATE_FIELDS = (SELECT Ext_Create_Fields FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @INSERT_FIELDS = (SELECT Ext_Insert_Fields FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @FROM_STATEMENT = (SELECT Ext_From_Statement FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0A', @Alpha_Step_Name = 'Extract Table Creation - Begin', @Alpha_Result = 1;

						SET @SQL_2 = ' ''LDSPhilanthropiesDW.dbo.' + @TABLE_NAME + ''', ''U'' '
						SET @SQL_1 = '
							IF OBJECT_ID(' + @SQL_2 + ') IS NOT NULL
							DROP TABLE LDSPhilanthropiesDW.dbo.' + @TABLE_NAME + '
							
							CREATE TABLE LDSPhilanthropiesDW.dbo.' + @TABLE_NAME + '(' + @CREATE_FIELDS + ')'
							
						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0B', @Alpha_Step_Name = 'Extract Table Creation - Query', @Alpha_Query = @SQL_1, @Alpha_Result = 1;
						
						EXEC(@SQL_1)

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0C', @Alpha_Step_Name = 'Extract Table Creation - End', @Alpha_Result = 1;


					END TRY	
					BEGIN CATCH
						
						DECLARE @ERROR_NUMBER INT
						DECLARE @ERROR_SEVERITY INT
						DECLARE @ERROR_STATE INT
						DECLARE @ERROR_PROCEDURE NVARCHAR(500)
						DECLARE @ERROR_LINE INT
						DECLARE @ERROR_MESSAGE NVARCHAR(MAX)

						SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
						SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
						SELECT @ERROR_STATE = (SELECT ERROR_STATE())
						SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
						SELECT @ERROR_LINE = (SELECT ERROR_LINE())
						SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Extract Table Creation - Error', @Alpha_Result = 0
						, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;
						
					END CATCH
					
					
						
					BEGIN TRY

					-- -----------------------------
					-- Populate Table
					-- -----------------------------

						DECLARE @TABLE_NAME4 NVARCHAR(100)
						DECLARE @CREATE_FIELDS4 NVARCHAR(MAX)
						DECLARE @INSERT_FIELDS4 NVARCHAR(MAX)
						DECLARE @SELECT_STATEMENT4 NVARCHAR(MAX)
						DECLARE @FROM_STATEMENT4 NVARCHAR(MAX)
						DECLARE @WHERE_STATEMENT4 NVARCHAR(MAX)						
						DECLARE @SQL_Code_Block_1 NVARCHAR(MAX)
						DECLARE @SQL_Code_Block_2 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_3 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_4 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_5 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_6 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_7 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_8 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_9 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_10 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_11 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_12 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_13 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_14 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_15 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_16 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_17 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_18 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_19 NVARCHAR(MAX);
						DECLARE @SQL_Code_Block_20 NVARCHAR(MAX);
						DECLARE @SQL_4A NVARCHAR(MAX)
						
						SELECT @TABLE_NAME4 = (SELECT Ext_Table FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @CREATE_FIELDS4 = (SELECT Ext_Create_Fields FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @INSERT_FIELDS4 = (SELECT Ext_Insert_Fields FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @SELECT_STATEMENT4 = (SELECT Ext_Select_Statement FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @FROM_STATEMENT4 = (SELECT Ext_From_Statement FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @WHERE_STATEMENT4 = (SELECT Ext_Where_Statement FROM LDSPhilanthropiesDW.Oa_Extract.Extract_Tables WHERE Active = 1 AND Extract_Tables_Key = @Main_LOOP_NUM);
						SELECT @SQL_Code_Block_1 = (SELECT Code_Block_1 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_2 = (SELECT Code_Block_2 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_3 = (SELECT Code_Block_3 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_4 = (SELECT Code_Block_4 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_5 = (SELECT Code_Block_5 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_6 = (SELECT Code_Block_6 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_7 = (SELECT Code_Block_7 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_8 = (SELECT Code_Block_8 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_9 = (SELECT Code_Block_9 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_10 = (SELECT Code_Block_10 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_11 = (SELECT Code_Block_11 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_12 = (SELECT Code_Block_12 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_13 = (SELECT Code_Block_13 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_14 = (SELECT Code_Block_14 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_15 = (SELECT Code_Block_15 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_16 = (SELECT Code_Block_16 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_17 = (SELECT Code_Block_17 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_18 = (SELECT Code_Block_18 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_19 = (SELECT Code_Block_19 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						SELECT @SQL_Code_Block_20 = (SELECT Code_Block_20 FROM Oa_Extract.Extract_Tables WHERE Ext_Table = @Table_Name_By_Loop);
						
						SET @SQL_4A = 'INSERT INTO ' + @TABLE_NAME4 + ' (' + @INSERT_FIELDS4 + ') SELECT ' + @SELECT_STATEMENT4 + ' FROM ' + @FROM_STATEMENT4 + ' WHERE 1 = 1 ' + @WHERE_STATEMENT4										
						
						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0D', @Alpha_Step_Name = 'Extract Table Insert - Begin', @Alpha_Result = 1;
						
						EXEC(@SQL_4A)
						EXEC(@SQL_Code_Block_1 + ' ' + @SQL_Code_Block_2 + ' ' + @SQL_Code_Block_3)
						EXEC(@SQL_Code_Block_4 + ' ' + @SQL_Code_Block_5 + ' ' + @SQL_Code_Block_6)
						EXEC(@SQL_Code_Block_7 + ' ' + @SQL_Code_Block_8 + ' ' + @SQL_Code_Block_8)
						EXEC(@SQL_Code_Block_10 + ' ' + @SQL_Code_Block_11 + ' ' + @SQL_Code_Block_12)
						EXEC(@SQL_Code_Block_13 + ' ' + @SQL_Code_Block_14 + ' ' + @SQL_Code_Block_15)
						EXEC(@SQL_Code_Block_16 + ' ' + @SQL_Code_Block_18 + ' ' + @SQL_Code_Block_19)		

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0E', @Alpha_Step_Name = 'Extract Table Insert - End', @Alpha_Result = 1;
						
						DECLARE @BEG_TIME4 DATETIME
						DECLARE @END_TIME4 DATETIME
						DECLARE @DURATION4 INT
						DECLARE @RECORD_CNT4 INT
						
						DECLARE @RECORD_CNT4A NVARCHAR(MAX) = N'SELECT @RECORD_CNT4 = (SELECT COUNT(*) FROM ' + @TABLE_NAME4 + ')'
						EXEC sp_executesql @RECORD_CNT4A, N'@RECORD_CNT4 INT OUT', @RECORD_CNT4 OUT
						
						DECLARE @BEG_TIME4A NVARCHAR(MAX) = N'SELECT @BEG_TIME4 = (SELECT MAX(Alpha_DateTime) FROM dbo.Alpha_Table_1 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME4 + ''' AND RIGHT(Alpha_Step_Number,1) = ''A'')'
						EXEC sp_executesql @BEG_TIME4A, N'@BEG_TIME4 DATETIME OUT', @BEG_TIME4 OUT

						DECLARE @END_TIME4A NVARCHAR(MAX) = N'SELECT @END_TIME4 = (SELECT Alpha_DateTime FROM dbo.Alpha_Table_1 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME4 + ''' AND RIGHT(Alpha_Step_Number,1) = ''E'')'
						EXEC sp_executesql @END_TIME4A, N'@END_TIME4 DATETIME OUT', @END_TIME4 OUT

						SET @DURATION4 = DATEDIFF(SECOND,@BEG_TIME4,@END_TIME4)
					 
							
						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME4, @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Stats', @Alpha_Begin_Time = @BEG_TIME4, @Alpha_End_Time = @END_TIME4, @Alpha_Duration_In_Seconds = @DURATION4, @Alpha_Count = @RECORD_CNT4, @Alpha_Result = 1;

						EXEC(@SQL_Code_Block_20)
						
					END TRY	

					BEGIN CATCH

						SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
						SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
						SELECT @ERROR_STATE = (SELECT ERROR_STATE())
						SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
						SELECT @ERROR_LINE = (SELECT ERROR_LINE())
						SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME4, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Populate Table - Error', @Alpha_Result = 0
						, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;	

					END CATCH 
		 
				END
			
			SET @Main_LOOP_NUM = @Main_LOOP_NUM + 1
	
		END

	SET @Main_LOOP_NUM = 0

	SET @FiveAttempts = @FiveAttempts + 1

END

SET @FiveAttempts = 0


	

END

