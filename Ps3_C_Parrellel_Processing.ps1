###################################################################################################
#
#	Name: PowerShell_ETL_Parrellel_Processing
#	Date: 02/26/2018
#
###################################################################################################

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
[STRING]$Parrellel_Processing = "Parrellel_Processing_"              #<----------------------------------------------------------
[STRING]$Log_DateTime = Get-Date -Format "yyyyMMdd_HHmmss"
[String]$Log_File_Type = '.log'
[STRING]$Log_File_Name = $Log_Root + $Parrellel_Processing + "_" + $Log_DateTime + $Log_File_Type

Start-Transcript -Path $Log_File_Name -Force -NoClobber

Write-Host
Write-Host "~ This is the beginning of the Parrellel_Processing script."
Write-Host


#---------------------------------------------
# If this is the first than create the Alpha_Table_1
#   Else sleep for 10 seconds
#---------------------------------------------
Create-Alpha_Table_1                                                 #<----------------------------------------------------------
#Start-Sleep -s 10                                                   #<----------------------------------------------------------

#---------------------------------------------
# Destination Connection String
#---------------------------------------------

[STRING] $Dest_Instance = 'MSSQL12336\S01'
[STRING] $Dest_Db = 'OneAccord_Warehouse'
[STRING] $Dest_Connect_String = "Data Source=$Dest_Instance;Initial Catalog=$Dest_Db;Integrated Security=TRUE;"


#---------------------------------------------
# Loop Thru Tables
#---------------------------------------------

		#---------------------------------------------
		# Tables to Process
		#---------------------------------------------
		
		[STRING]$Tables_To_Process_Qry = "SELECT COUNT(Source_Table) AS Tables_To_Process
											FROM Oa_Extract.Extract_Tables
											WHERE 1 = 1 
												AND (Extract_Stage IS NULL 
													OR Extract_Stage = 'Incomplete'
													)
												AND Active = 1
										"                                                                                   
			$Tables_To_Process_var = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Tables_To_Process_Qry).Tables_To_Process
		
			[Int]$Tables_To_Process = [convert]::ToInt32($Tables_To_Process_var)
		
		Write-Host
		Write-Host $Tables_To_Process_Qry
		Write-Host "~ Tables to Process: $Tables_To_Process"
		

		#---------------------------------------------
		# Loop Begin Time
		#---------------------------------------------
		$Loop_Begin_DateTime = Get-Date
		
		Write-Host 
		Write-Host "~ Loop Begin Time: $Loop_Begin_DateTime"
		
		
DO 
	{

		#---------------------------------------------
		# Processing Key
		#---------------------------------------------
	
		[STRING]$Processing_Key_Qry = "SELECT MIN(Extract_Tables_Key) AS Next_Table
										FROM Oa_Extract.Extract_Tables
										WHERE 1 = 1 
											AND (Extract_Stage IS NULL 
												OR Extract_Stage = 'Incomplete'
												)
											AND Active = 1
									"                                                                                   
			$Processing_Key_Var = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Processing_Key_Qry).Next_Table
			
			[Int]$Processing_Key = [convert]::ToInt32($Processing_Key_Var)
		
		Write-Host
		Write-Host $Processing_Key_Qry
		Write-Host "~ Processing Key: $Processing_Key"
		
		#---------------------------------------------
		# Extract_Tables Update
		#---------------------------------------------
		$Update_DateTime = Get-Date
	
		$Update_Extract_Tables = "UPDATE Oa_Extract.Extract_Tables 
							SET Extract_Stage = 'Processing'
								, Extract_Stage_DateTime = '$Update_DateTime'
							WHERE 1 = 1
								AND Extract_Tables_Key = $Processing_Key"
		
		Invoke-Sqlcmd `
			-ServerInstance $Dest_Instance `
			-Database $Dest_Db `
			-Query $Update_Extract_Tables
		
		Write-Host $Update_Extract_Tables
		
		
		#---------------------------------------------
		# Source Table
		#---------------------------------------------
		
		[STRING]$Source_Table_Qry = "SELECT Source_Table
								FROM Oa_Extract.Extract_Tables
								WHERE 1 = 1
									AND Extract_Tables_Key = $Processing_Key
												  "                                                                                   
						$Source_Table = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Source_Table_Qry).Source_Table
		
		Write-Host
		Write-Host $Source_Table_Qry
		Write-Host "~ Source Table: $Source_Table"
		
		#---------------------------------------------
		# Destination Table
		#---------------------------------------------
		
		[STRING]$Dest_Table_Qry = "SELECT Destination_Table
								FROM Oa_Extract.Extract_Tables
								WHERE 1 = 1
									AND Extract_Tables_Key = $Processing_Key
												  "                                                                                   
						$Dest_Table = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Dest_Table_Qry).Destination_Table
		
		Write-Host
		Write-Host $Dest_Table
		Write-Host "~ Destination Table: $Dest_Table"
		
		
		#---------------------------------------------
		# Extract Data
		#---------------------------------------------
		
		Copy-OneAccord_Data -p1 $Source_Table -p2 $Processing_Key
		
		
		#---------------------------------------------
		# Check If Extract was successful
		#---------------------------------------------
		
		[STRING]$Extract_Success_Qry = "SELECT SUM(Alpha_Result) AS Sum_Alpha_Result
								FROM Oa_Extract.Alpha_Table_1
								WHERE 1 = 1
									AND Alpha_Stage = '$Dest_Table'
									AND Alpha_Step_Name = 'Stats'
												  "                                                                                   
			$Extract_Success_Var = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Extract_Success_Qry).Sum_Alpha_Result
			
			[Int]$Extract_Success = [convert]::ToInt32($Extract_Success_Var)
		
		Write-Host
		Write-Host $Extract_Success_Qry
		Write-Host "~ Extract Success: $Extract_Success"
		
		IF ($Extract_Success -gt 0)
			{
				#---------------------------------------------
				# Extract_Tables Update
				#---------------------------------------------
				$Update_Complete_DateTime = Get-Date
			
				$Update_Complete_Extract_Tables = "UPDATE Oa_Extract.Extract_Tables 
									SET Extract_Stage = 'Complete'
										, Extract_Stage_DateTime = '$Update_Complete_DateTime'
									WHERE 1 = 1
										AND Extract_Tables_Key = $Processing_Key"
				
				Invoke-Sqlcmd `
					-ServerInstance $Dest_Instance `
					-Database $Dest_Db `
					-Query $Update_Complete_Extract_Tables
				
				Write-Host
				Write-Host $Update_Complete_Extract_Tables
				Write-Host "~ Extract_Tables updated to Complete."
			}
			ELSE
			{
				#---------------------------------------------
				# Extract_Tables Update
				#---------------------------------------------
				$Update_Incomplete_DateTime = Get-Date
			
				$Update_Incomplete_Extract_Tables = "UPDATE Oa_Extract.Extract_Tables 
														SET Extract_Stage = 'Incomplete'
															, Extract_Stage_DateTime = '$Update_Complete_DateTime'
														WHERE 1 = 1
															AND Extract_Tables_Key = $Processing_Key
													"
				
				Invoke-Sqlcmd `
					-ServerInstance $Dest_Instance `
					-Database $Dest_Db `
					-Query $Update_Incomplete_Extract_Tables
				
				Write-Host
				Write-Host $Update_Incomplete_Extract_Tables
				Write-Host "~ Extract_Tables updated to Incomplete."
				
			}
		
		
		#---------------------------------------------
		# Tables to Process
		#---------------------------------------------
		
		[STRING]$Tables_To_Process_Qry = "SELECT COUNT(Source_Table) AS Tables_To_Process
											FROM Oa_Extract.Extract_Tables
											WHERE 1 = 1 
												AND (Extract_Stage IS NULL 
													OR Extract_Stage = 'Incomplete'
													)
												AND Active = 1
										"                                                                                   
			$Tables_To_Process_Var = (Invoke-Sqlcmd -ServerInstance $Dest_Instance -Database $Dest_Db -Query $Tables_To_Process_Qry).Tables_To_Process
			
			[Int]$Tables_To_Process = [convert]::ToInt32($Tables_To_Process_Var)
		
		Write-Host
		Write-Host $Tables_To_Process_Qry
		Write-Host "~ Tables to Process: $Tables_To_Process"
		
		
		#---------------------------------------------
		# Current Process Time
		#---------------------------------------------
		$Current_Process_DateTime = Get-Date
		
		Write-Host 
		Write-Host "~ Current Process Time: $Current_Process_DateTime"
		
		$Total_Processing_Time = New-TimeSpan -Start $Loop_Begin_DateTime -End $Current_Process_DateTime
		
		Write-Host 
		Write-Host "~ Total Processing Time: $Total_Processing_Time"
		
	
	} UNTIL ($Tables_To_Process -eq 0 -OR $Total_Processing_Time -gt '00:30:00')

#---------------------------------------------	 
# Return to standard error handling
#---------------------------------------------
$ErrorActionPreference = $Old

Write-Host
Write-Host "~ The process finished."

#---------------------------------------------	 
# Stop log
#---------------------------------------------
Stop-Transcript

