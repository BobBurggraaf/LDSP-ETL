/****************************************************

	Name: Uf_All_Associations
	Date: 09/18/2018

****************************************************/

USE [LDSPhilanthropiesDW]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[Uf_All_Associations]()
RETURNS TABLE
AS
RETURN

SELECT DISTINCT ContactId AS Donor_Key
	, STUFF(( SELECT  ' \\ ' + All_Association_Memberships 
					FROM 
						(SELECT ContactId
							, COALESCE(Association_Name,' ') + ' | ' + COALESCE(StatusCode,' ') + ' | ' + RTRIM(COALESCE(New_StartDate,' ')) + ' | ' + RTRIM(COALESCE(New_EndDate,' ')) AS All_Association_Memberships
							, Order_Number
							FROM 
								(SELECT ROW_NUMBER() OVER(PARTITION BY ContactId ORDER BY ContactId, StatusCode, Association_Name) AS Order_Number  
									, ContactId
									, Association_Name
									, StatusCode
									, CASE WHEN New_StartDate = '1900-01-01' THEN NULL ELSE CONVERT(NVARCHAR(10),New_StartDate,1) END AS New_StartDate
									, CASE WHEN New_EndDate = '1900-01-01' THEN NULL ELSE CONVERT(NVARCHAR(10),New_EndDate,1) END AS New_EndDate
									FROM _Association_Dim 
								) A
						) B
					WHERE B.ContactId = A.ContactId
					ORDER BY Order_Number 
						FOR XML PATH('')),1 ,3, ''
			) All_Association_Memberships
	FROM (SELECT DISTINCT ContactId
					FROM _Association_Dim
					WHERE 1 = 1
						AND ContactId IS NOT NULL
			) A
	WHERE 1 = 1
AND ContactId IS NOT NULL