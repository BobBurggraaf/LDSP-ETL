/****************************************************

	Name: _All_Current_Former_Employment_
	Date: 08/09/2018
	
	

****************************************************/


USE [LDSPhilanthropiesDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[_All_Current_Former_Employment_]()
	RETURNS TABLE
	AS 
	RETURN
	SELECT DISTINCT A.Donor_Key
		, EA.All_Employment 
		, EC.Current_Employment
		, EF.Former_Employment
		FROM _All_Donors_ A  
			LEFT JOIN
				(SELECT ContactId 
					, STUFF(( SELECT  ' ; ' + All_Employment 
								FROM 
									(SELECT DISTINCT ContactId
										, '(' + COALESCE(StatusCode,' ') + ') ' + COALESCE(Organization_Name,Plus_AlternateOrganizationName,Institutional_Hierarchy,' ') + ' | ' + RTRIM(COALESCE(New_Title,' ')) + ' | ' + RTRIM(COALESCE(New_JobCode,' ')) + ' | ' + COALESCE(CONVERT(NVARCHAR(50),New_DateStarted,1),' ') AS All_Employment
										FROM 
											(SELECT *
												FROM _All_Employment
											) A                                                                                                               
									) A
								WHERE B.ContactId = A.ContactId FOR XML PATH('')),1 ,2, ''
							)  All_Employment
					FROM 
						(SELECT *
							FROM _All_Employment
						)  B
					WHERE 1 = 1
						AND ContactId IS NOT NULL
					GROUP BY ContactId
				) EA ON A.Donor_Key = EA.ContactId
			LEFT JOIN
				(SELECT ContactId 
					, STUFF(( SELECT  ' ; ' + Current_Employment 
								FROM 
									(SELECT DISTINCT ContactId
										, '(' + COALESCE(StatusCode,' ') + ') ' + COALESCE(Organization_Name,Plus_AlternateOrganizationName,Institutional_Hierarchy,' ') + ' | ' + RTRIM(COALESCE(New_Title,' ')) + ' | ' + RTRIM(COALESCE(New_JobCode,' ')) + ' | ' + COALESCE(CONVERT(NVARCHAR(50),New_DateStarted,1),' ') AS Current_Employment
										FROM 
											(SELECT *
												FROM _All_Employment
												WHERE 1 = 1
													AND StatusCode = 'C'
											) A                                                                                                               
									) A
								WHERE B.ContactId = A.ContactId FOR XML PATH('')),1 ,2, ''
							)  Current_Employment
					FROM 
						(SELECT *
							FROM _All_Employment
							WHERE 1 = 1
								AND StatusCode = 'C'
						)  B
					WHERE 1 = 1
						AND ContactId IS NOT NULL
					GROUP BY ContactId
				) EC ON A.Donor_Key = EC.ContactId
			LEFT JOIN
				(SELECT ContactId 
					, STUFF(( SELECT  ' ; ' + Former_Employment 
								FROM 
									(SELECT DISTINCT ContactId
										, '(' + COALESCE(StatusCode,' ') + ') ' + COALESCE(Organization_Name,Plus_AlternateOrganizationName,Institutional_Hierarchy,' ') + ' | ' + RTRIM(COALESCE(New_Title,' ')) + ' | ' + RTRIM(COALESCE(New_JobCode,' ')) + ' | ' + COALESCE(CONVERT(NVARCHAR(50),New_DateStarted,1),' ') AS Former_Employment
										FROM 
											(SELECT *
												FROM _All_Employment
												WHERE 1 = 1
													AND StatusCode IN ('F','R')
											) A                                                                                                              
									) A
								WHERE B.ContactId = A.ContactId FOR XML PATH('')),1 ,2, ''
							)  Former_Employment
					FROM 
						(SELECT *
							FROM _All_Employment
							WHERE 1 = 1
								AND StatusCode IN ('F','R')
						)  B
					WHERE 1 = 1
						AND ContactId IS NOT NULL
					GROUP BY ContactId
				) EF ON A.Donor_Key = EF.ContactId 