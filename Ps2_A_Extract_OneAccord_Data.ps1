###################################################################################################
#
#	Name: PowerShell_ETL_Extract_From_OneAccord
#	Date: 02/20/2018
#
#
#	Description:
#		Copies tables from OneAccord source to target SQL instance. 
#
#	Logs:
#		C:\Users\fams\Documents\Year_2018\PowerShell\Logs
#
###################################################################################################


<#
.Synopsis
   Data extraction from source tables
.DESCRIPTION
   The ETL that creates the data warehouse for LDSP starts by pulling data from the source database, OneAccord.
   The data is extracted and placed in a development environment where additional transformations can occur.
   This is the base function that can be used with each of the tables that need to be extracted. The name of the 
   table and the column names are parameters. This function is set up so that it can be run in parallel for 
   greater performance.
.EXAMPLE
   Copy-OneAccord_Data -p1 "AccountBase"
.NOTES
   Can use the alias of cod to call the function instead of Get-OneAccord_Data.
.FUNCTIONALITY
   CmdletBinding - SupportsPaging adds the First, Skip, and IncludeTotalCount parameters to the function.
   First: Gets only the first n rows, Skip: ignores the first n rows and then gets the rest, IncludeTotalCount:
   Reports the number of objects in the data set followed by the objects.   
#>
FUNCTION Copy-OneAccord_Data
	{
		[CmdletBinding(
					PositionalBinding=$FALSE,
					SupportsPaging = $TRUE					  
					  )
		]
		[Alias("eod")]

		Param
		(
			# Name of the source schema and table
			[Parameter(Mandatory=$true)]
			[ValidatePattern("[a-z]*")]
			[ValidateLength(0,100)]
			[Alias("p1")]
			[String]
			$Source_Table_Name

		)


		####################################################################################################################
		
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
				
		[STRING]$Log_Root = $New_Folder_Path + "\PS_Extract_"
		$Pos = $Source_Table_Name.IndexOf(".")
        [STRING]$Table_Name = $Source_Table_Name.Substring($Pos+1)
		[STRING]$Log_DateTime = Get-Date -Format "yyyyMMdd_HHmmss"
		[String]$Log_File_Type = '.log'
		[STRING]$Log_File_Name = $Log_Root + $Table_Name + "_" + $Log_DateTime + $Log_File_Type
		
		Start-Transcript -Path $Log_File_Name -Force -NoClobber
		
		Write-Host
		Write-Host "~ This is the beginning of the Copy-OneAccord_Data script."
		Write-Host
		
		
		####################################################################################################################
		
		#---------------------------------------------
		# Source Variables
		#---------------------------------------------
		$SQLServer = "MSSQL12316\S06"
		$Database = "OneAccord_MSCRM"
		$SQLUser = "" 
		$Password = "" | ConvertTo-SecureString -AsPlainText -Force
		$Password.MakeReadOnly()
		[STRING] $Source_Table_And_Schema = $Source_Table_Name
		
		Write-Host
		Write-Host "~ SQLServer: $SQLServer"
		Write-Host "~ Database: $Database"
		Write-Host "~ SQLUser: $SQLUser"
		Write-Host "~ Password: $Password"
		Write-Host "~ Source_Table_And_Schema: $Source_Table_And_Schema"
		Write-Host
		
		#---------------------------------------------
		# Destination variables
		#---------------------------------------------
		[STRING] $Dest_Instance = 'MSSQL12336\S01'
		[STRING] $Dest_Db = 'OneAccord_Warehouse'
		[STRING] $Dest_Connect_String = "Data Source=$Dest_Instance;Initial Catalog=$Dest_Db;Integrated Security=TRUE;"
		[INT] $Bulk_Copy_Batch_Size = 10000
		[INT] $Bulk_Copy_Timeout = 600

		Write-Host
		Write-Host "~ Dest_Instance: $Dest_Instance"
		Write-Host "~ Dest_Db: $Dest_Db"
		Write-Host "~ Dest_Connect_String: $Dest_Connect_String"
		Write-Host "~ Bulk_Copy_Batch_Size: $Bulk_Copy_Batch_Size"
		Write-Host "~ Bulk_Copy_Timeout: $Bulk_Copy_Timeout"
		Write-Host
		
		#---------------------------------------------
		# Open connection to the database
		#---------------------------------------------
		[string]$connectionString = "Data Source=$SQLServer;Initial Catalog=$Database;"
		$cred = New-Object System.Data.SqlClient.SqlCredential($SQLUser,$Password)
		$SqlConnection = New-Object System.Data.SqlClient.SqlConnection($connectionString)
		$SqlConnection.credential = $cred
		$SqlConnection.Open()
		
		####################################################################################################################
		
		
		#---------------------------------------------
		# Get Variables from DDL Table
		#---------------------------------------------	
		[STRING]$Dest_Table_Name_Qry = "SELECT Destination_Table
                                            	FROM Oa_Extract.Extract_Tables
												WHERE 1 = 1
													AND Source_Table = '$Source_Table_And_Schema'
                                          "                                                                                   
                $Dest_Table_Name = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Dest_Table_Name_Qry).Destination_Table
		
		[STRING]$Dest_Create_Fields_Qry = "SELECT Dest_Create_Fields
                                            	FROM Oa_Extract.Extract_Tables
												WHERE 1 = 1
													AND Source_Table = '$Source_Table_And_Schema'
                                          "                                                                                    
                $Dest_Create_Fields = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Dest_Create_Fields_Qry).Dest_Create_Fields
		
		[STRING]$Dest_Insert_Fields_Qry = "SELECT Dest_Insert_Fields
                                            	FROM Oa_Extract.Extract_Tables
												WHERE 1 = 1
													AND Source_Table = '$Source_Table_And_Schema'
                                          "                                                                                    
                $Dest_Insert_Fields = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Dest_Insert_Fields_Qry).Dest_Insert_Fields
	
		[STRING]$Dest_Where_Statement_Qry = "SELECT Dest_Where_Statement
                                            	FROM Oa_Extract.Extract_Tables
												WHERE 1 = 1
													AND Source_Table = '$Source_Table_And_Schema'
                                          "                                                                                    
                $Dest_Where_Statement = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Dest_Where_Statement_Qry).Dest_Where_Statement

		Write-Host
		Write-Host "~ Dest_Table_Name: $Dest_Table_Name"
		Write-Host "~ Dest_Create_Fields: $Dest_Create_Fields"
		Write-Host "~ Dest_Insert_Fields: $Dest_Insert_Fields"
		Write-Host "~ Dest_Where_Statement: $Dest_Where_Statement"
		Write-Host		
				
		TRY
			{
					
				####################################################################################################################
				
				#---------------------------------------------
				# Insert Into Alpha Table
				#---------------------------------------------
				$Beg_DateTime = Get-Date
				Insert-Alpha_Table_1 -p1 $Dest_Table_Name -p2 "2A" -p3 "Drop, Create, Insert - Begin" -p4 $Beg_DateTime -p9 1
				
				Write-Host
				Write-Host "~ Alpha_DateTime: $Beg_DateTime"
				Write-Host "~ Beginning of $Dest_Table_Name"
				Write-Host "~ Alpha_Stage: $Dest_Table_Name"
				Write-Host "~ Alpha_Step_Number: 2A"
				Write-Host "~ Alpha_Step_Name: Drop, Create, Insert - Begin"
				Write-Host
				
				####################################################################################################################
			
				#---------------------------------------------
				# Get source data
				#---------------------------------------------
				$Sql = "SELECT $Dest_Insert_Fields FROM $Source_Table_And_Schema WHERE 1 = 1 $Dest_Where_Statement"
				
			    $Sql_Command = New-Object system.Data.SqlClient.SqlCommand($Sql, $SqlConnection) 
				[System.Data.SqlClient.SqlDataReader] $Sql_Reader = $Sql_Command.ExecuteReader()
				
				
				#---------------------------------------------
				# Drop table is it exists in destination
				#---------------------------------------------
				$Drop_Table = "IF EXISTS (SELECT 1 WHERE OBJECT_ID('$Dest_Table_Name') IS NOT NULL)
									BEGIN
										EXEC('DROP TABLE $Dest_Table_Name')
									END"
		 
				Invoke-Sqlcmd `
					-ServerInstance $Dest_Instance `
					-Database $Dest_Db `
					-Query $Drop_Table
				
				
				#---------------------------------------------
				# Create destination table
				#---------------------------------------------
				$Create_Table = "CREATE TABLE $Dest_Table_Name (
									$Dest_Create_Fields
									)"
				 
				Invoke-Sqlcmd `
					-ServerInstance $Dest_Instance `
					-Database $Dest_Db `
					-Query $Create_Table
				
				
				
				#---------------------------------------------
				# Copy to destination
				#---------------------------------------------
				$Bulk_Copy = New-Object Data.SqlClient.SqlBulkCopy($Dest_Connect_String, [System.Data.SqlClient.SqlBulkCopyOptions]::KeepIdentity)
				$Bulk_Copy.DestinationTableName = $Dest_Table_Name
				$Bulk_Copy.BulkCopyTimeOut = $Bulk_Copy_Timeout
				$Bulk_Copy.BatchSize = $Bulk_Copy_Batch_Size
				$Bulk_Copy.WriteToServer($Sql_Reader)
				$Sql_Reader.Close()
				$Bulk_Copy.Close()
				
				
				
				
				
				
				
				####################################################################################################################
				
				#---------------------------------------------
				# Insert Into Alpha Table
				#---------------------------------------------				
				$End_DateTime = Get-Date
				Insert-Alpha_Table_1 -p1 $Dest_Table_Name -p2 "2B" -p3 "Drop, Create, Insert - End" -p4 $Beg_DateTime -p5 $End_DateTime -p8 $Create_Table -p9 1
				
				Write-Host
				Write-Host "~ Alpha_DateTime: $End_DateTime"
				Write-Host "~ Ending of $Dest_Table_Name"
				Write-Host "~ Alpha_Stage: $Dest_Table_Name"
				Write-Host "~ Alpha_Step_Number: 2B"
				Write-Host "~ Alpha_Step_Name: Drop, Create, Insert - End"
				Write-Host
				
				####################################################################################################################
	
				
				
				####################################################################################################################
				
				#---------------------------------------------
				# Insert Into Alpha Table - Stats
				#---------------------------------------------
				[STRING] $Stats_Query_Time = "SELECT DATEDIFF(S,Beg_Time,End_Time) AS Time_Diff
	                                            FROM
		                                            (SELECT Min(Alpha_DateTime) AS Beg_Time 
			                                            FROM Oa_Extract.Alpha_Table_1
			                                            WHERE 1 = 1
				                                            AND Alpha_Stage = '$Dest_Table_Name'
		                                            ) A ,
		                                            (SELECT Max(Alpha_DateTime) AS End_Time 
			                                            FROM Oa_Extract.Alpha_Table_1
			                                            WHERE 1 = 1
				                                            AND Alpha_Stage = '$Dest_Table_Name'
		                                            ) B
                                          "
                
                $Stats_Time_Qry = Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Stats_Query_Time

                [Int]$Stats_Time = [convert]::ToInt32($Stats_Time_Qry.Time_Diff)



                [STRING]$Stats_Query_Cnt = "SELECT COUNT(*) AS Record_Cnt
                                            	FROM $Dest_Table_Name
                                          "
                                                                                     
                $Stats_Cnt_Qry = Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Stats_Query_Cnt

                [Int]$Stats_Cnt = [convert]::ToInt32($Stats_Cnt_Qry.Record_Cnt)
				
				$Stat_DateTime = Get-Date
				Insert-Alpha_Table_1 -p1 $Dest_Table_Name -p2 "2S" -p3 "Stats" -p4 $Beg_DateTime -p5 $End_DateTime -p6 $Stats_Time -p7 $Stats_Cnt -p9 1
				
				Write-Host
				Write-Host "~ Alpha_DateTime: $Stat_DateTime"
				Write-Host "~ Stats of $Dest_Table_Name"
				Write-Host "~ Alpha_Stage: $Dest_Table_Name"
				Write-Host "~ Alpha_Step_Number: 2S"
				Write-Host "~ Alpha_Step_Name: Stats"
				Write-Host "~ Run Time: $Stats_Time"
				Write-Host "~ Row Count: $Stats_Cnt"
				Write-Host
				
				####################################################################################################################
				
				
				
					
						

					
			}
		CATCH [System.Exception]
			{
				[STRING]$Error_Message = $_.Exception.Message -replace "'",""
				[INT]$Error_Count = $Error.Count
				
				####################################################################################################################
				
				#---------------------------------------------
				# Insert Into Alpha Table - Error
				#---------------------------------------------
				
				$Error_DateTime = Get-Date
				Insert-Alpha_Table_1 -p1 $Dest_Table_Name -p2 "2X" -p3 "Error" -p9 0 -p12 $Error_Count -p15 $Error_Message
				
				Write-Host
				Write-Host "~ Alpha_DateTime: $Error_DateTime"
				Write-Host "~ Error on $Dest_Table_Name"
				Write-Host "~ Alpha_Stage: $Dest_Table_Name"
				Write-Host "~ Alpha_Step_Number: 2X"
				Write-Host "~ Alpha_Step_Name: Error"
				Write-Host
				Write-Host "~ Error Message: $Error_Message"
				Write-Host "~ Error Count: $Error_Count"
				Write-Host
				
				####################################################################################################################
				
				
				
				
                
			}
		FINALLY
			{
				#---------------------------------------------	 
				#Close connection to the database
				#---------------------------------------------
				$SqlConnection.Close()
				
				#---------------------------------------------	 
				# Return to standard error handling
				#---------------------------------------------
                $ErrorActionPreference = $Old
				
				
				write-host "The End (Finally)"
				
				#---------------------------------------------	 
				# Stop log
				#---------------------------------------------
				Stop-Transcript
				
				
			}
		
		
	}
	

Copy-OneAccord_Data -p1 "dbo.AccountBase"