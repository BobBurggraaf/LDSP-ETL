###################################################################################################
#
#	Name: PowerShell_ETL_Create_Alpha_1
#	Date: 02/22/2018
#
###################################################################################################

<#
.Synopsis
   Create the Alpha_1 table
.DESCRIPTION
   At the beginning of the Extract portion of the ETL we need to drop and create the Alpha_1 table.
.EXAMPLE
   Create-Alpha_1 
.NOTES
   If the table already exists and this function is not run then it new inserts will be appended to the existing table.
.FUNCTIONALITY
   Creates a table.  
#>
FUNCTION Create-Alpha_Table_1
	{		
		#---------------------------------------------
		# Clear Console and Error Log
		#---------------------------------------------
		CLEAR
		$Error.Clear()

		#---------------------------------------------
		# Catch Non-Terminating Errors
		#---------------------------------------------
		$Old = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		
		#---------------------------------------------
		# Log file
		#---------------------------------------------
		[STRING]$Folder_Date = Get-Date -Format "yyyyMMdd"
		$New_Folder_Path = "C:\Users\fams\Documents\Year_2018\PowerShell\Logs\Extract_" + $Folder_Date
		IF(!(Test-Path $New_Folder_Path))
			{
				New-Item -ItemType Directory -Force -Path $New_Folder_Path
			}
				
		[STRING]$Log_Root = $New_Folder_Path + "\PS_Extract_Alpha_Table_1_"
		[STRING]$Log_DateTime = Get-Date -Format "yyyyMMdd_HHmmss"
		[String]$Log_File_Type = '.log'
		[STRING]$Log_File_Name = $Log_Root + $Log_DateTime + $Log_File_Type
		
		Start-Transcript -Path $Log_File_Name -Force -NoClobber
		
		Write-Host
		Write-Host "~ This is the beginning of the Create-Alpha_Table_1 script."
		Write-Host
				
		####################################################################################################################
		
		#---------------------------------------------
		# Destination variables
		#---------------------------------------------
		[STRING] $Dest_Instance = 'MSSQL12336\S01'
		[STRING] $Dest_Db = 'OneAccord_Warehouse'
		[STRING] $Dest_Connect_String = "Data Source=$Dest_Instance;Initial Catalog=$Dest_Db;Integrated Security=TRUE;"

		Write-Host
		Write-Host "~ Dest_Instance: $Dest_Instance"
		Write-Host "~ Dest_Db: $Dest_Db"
		Write-Host "~ Dest_Connect_String: $Dest_Connect_String"
		Write-Host
				
		####################################################################################################################

		#---------------------------------------------
		# Create Alpha Table
		#---------------------------------------------
		
		$Drop_Alpha_Table = "IF EXISTS (SELECT 1 WHERE OBJECT_ID('Oa_Extract.Alpha_Table_1') IS NOT NULL)
							BEGIN
								EXEC('DROP TABLE Oa_Extract.Alpha_Table_1')
							END"
 
		Invoke-Sqlcmd `
			-ServerInstance $Dest_Instance `
			-Database $Dest_Db `
			-Query $Drop_Alpha_Table
	
		$Create_Alpha_Table = "CREATE TABLE Oa_Extract.Alpha_Table_1 (
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
							, Alpha_Result INT DEFAULT 0
							, ErrorNumber INT
							, ErrorSeverity INT
							, ErrorCount INT
							, ErrorProcedure NVARCHAR(500)
							, ErrorLine INT
							, ErrorMessage NVARCHAR(MAX)
							)"
		 
		Invoke-Sqlcmd `
			-ServerInstance $Dest_Instance `
			-Database $Dest_Db `
			-Query $Create_Alpha_Table
		
		Write-Host
		Write-Host "~ Created Alpha Table"
		Write-Host	
		
		Insert-Alpha_Table_1 -p1 "Beginning" -p2 "1A" -p3 "Created Oa_Extract.Alpha_Table_1" -p8 $Create_Alpha_Table -p9 1
		
		#---------------------------------------------	 
		# Reset Extract_Stage in the Extract_Tables table
		#---------------------------------------------
		
		$Update_Extract_Tables = "UPDATE Oa_Extract.Extract_Tables 
									SET Extract_Stage = NULL
										, Extract_Stage_DateTime = NULL
									WHERE 1 = 1
									"
	
		Invoke-Sqlcmd `
			-ServerInstance $Dest_Instance `
			-Database $Dest_Db `
			-Query $Update_Extract_Tables
			
		write-host "~ Updated the Extract_Tables table with NULL values for Extract_Stage and Extract_Stage_DateTime."
		
		Insert-Alpha_Table_1 -p1 "Reset Extract_Stage" -p2 "1B" -p3 "Updated Extract_Tables table" -p8 $Update_Extract_Tables -p9 1
		
		#---------------------------------------------	 
		# Return to standard error handling
		#---------------------------------------------
		$ErrorActionPreference = $Old
				
		write-host "The End"
		
		#---------------------------------------------	 
		# Stop log
		#---------------------------------------------
		Stop-Transcript
	
	}
	

Create-Alpha_Table_1