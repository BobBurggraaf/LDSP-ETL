###################################################################################################
#
#	Name: PowerShell_ETL_Insert_Into_Alpha_1
#	Date: 02/22/2018
#
###################################################################################################

<#
.Synopsis
   Insert log data into the Alpha_1 table.
.DESCRIPTION
   In a number of places in the Copy-OneAccord_Data script this function is called to insert data into the Alpha_1 table.
.EXAMPLE
   Insert-Alpha_Table_1 -p1 "Test_Stage" -p2 "0A" -p3 "First Step" 
.NOTES
   Some of the parameters are optional.
.FUNCTIONALITY
   Insert log data into the Alpha_1 table.  
#>
FUNCTION Insert-Alpha_Table_1
	{
		[CmdletBinding(
					PositionalBinding=$FALSE,
					SupportsPaging = $TRUE					  
					  )
		]
		[Alias("iat1")]

		Param
		(			
			# Alpha_Stage 
			[Parameter(Mandatory=$TRUE)]
			[Alias("p1")]
			[String]
			$Alpha_Stage ,
			
			# Alpha_Step_Number  
			[Parameter(Mandatory=$TRUE)]
			[Alias("p2")]
			[String]
			$Alpha_Step_Number  ,
			
			# Alpha_Step_Name  
			[Parameter(Mandatory=$TRUE)]
			[Alias("p3")]
			[String]
			$Alpha_Step_Name  ,
			
			# Alpha_Begin_Time  
			[Parameter(Mandatory=$FALSE)]
			[Alias("p4")]
			[DateTime]
			$Alpha_Begin_Time  ,
			
			# Alpha_End_Time 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p5")]
			[DateTime]
			$Alpha_End_Time  ,
			
			# Alpha_Duration_In_Seconds 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p6")]
			[Int]
			$Alpha_Duration_In_Seconds  ,
			
			# Alpha_Count 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p7")]
			[Int]
			$Alpha_Count  ,
			
			# Alpha_Query 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p8")]
			[String]
			$Alpha_Query  ,
			
			# Alpha_Result 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p9")]
			[Int]
			$Alpha_Result  ,
			
			# ErrorNumber 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p10")]
			[Int]
			$ErrorNumber  ,
			
			# ErrorSeverity 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p11")]
			[Int]
			$ErrorSeverity  ,
			
			# ErrorCount 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p12")]
			[Int]
			$ErrorCount  ,
			
			# ErrorProcedure 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p13")]
			[String]
			$ErrorProcedure  ,
			
			# ErrorLine 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p14")]
			[Int]
			$ErrorLine  ,
			
			# ErrorMessage 
			[Parameter(Mandatory=$FALSE)]
			[Alias("p15")]
			[String]
			$ErrorMessage
		)

		#---------------------------------------------
		# Catch Non-Terminating Errors
		#---------------------------------------------
		$Old = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
						
		####################################################################################################################
		
		#---------------------------------------------
		# Destination variables
		#---------------------------------------------
		[STRING] $Dest_Instance = 'MSSQL12336\S01'
		[STRING] $Dest_Db = 'OneAccord_Warehouse'
		[STRING] $Dest_Connect_String = "Data Source=$Dest_Instance;Initial Catalog=$Dest_Db;Integrated Security=TRUE;"
				
		####################################################################################################################

		#---------------------------------------------
		# Alpha Insert
		#---------------------------------------------
		$DateTime = Get-Date

		$Insert_Alpha_Table = "INSERT INTO Oa_Extract.Alpha_Table_1 (
							Alpha_DateTime
							, Alpha_Stage
							, Alpha_Step_Number
							, Alpha_Step_Name
							, Alpha_Begin_Time
							, Alpha_End_Time
							, Alpha_Duration_In_Seconds
							, Alpha_Count
							, Alpha_Query
							, Alpha_Result
							, ErrorNumber
							, ErrorSeverity
							, ErrorCount
							, ErrorProcedure
							, ErrorLine
							, ErrorMessage
							)
							VALUES ('$DateTime'                     /*Alpha_DateTime*/
									, '$Alpha_Stage'            	/*Alpha_Stage*/
									, '$Alpha_Step_Number'          /*Alpha_Step_Number*/
									, '$Alpha_Step_Name' 			/*Alpha_Step_Name*/
									, '$Alpha_Begin_Time'           /*Alpha_Begin_Time*/
									, '$Alpha_End_Time'             /*Alpha_End_Time*/
									, $Alpha_Duration_In_Seconds    /*Alpha_Duration_In_Seconds*/
									, $Alpha_Count                  /*Alpha_Count*/
									, '$Alpha_Query'                /*Alpha_Query*/
									, $Alpha_Result                 /*Alpha_Result*/
									, $ErrorNumber                  /*ErrorNumber*/
									, $ErrorSeverity                /*ErrorSeverity*/
									, $ErrorCount                   /*ErrorCount*/
									, '$ErrorProcedure'             /*ErrorProcedure*/
									, $ErrorLine                    /*ErrorLine*/
									, '$ErrorMessage'               /*ErrorMessage*/
									)
								"
		Invoke-Sqlcmd `
			-ServerInstance $Dest_Instance `
			-Database $Dest_Db `
			-Query $Insert_Alpha_Table

		#---------------------------------------------	 
		# Return to standard error handling
		#---------------------------------------------
		$ErrorActionPreference = $Old	
	}
	

