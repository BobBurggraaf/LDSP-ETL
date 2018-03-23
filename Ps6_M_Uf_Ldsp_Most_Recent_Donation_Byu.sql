/****************************************************

	Name: Ldsp_Most_Recent_Donation_Byu
	Date: 01/20/2018
	
	This Table-valued Function returns a table with the date of the most recent donation given to BYU by a donor.

****************************************************/


USE [LDSPhilanthropiesDW]
GO
/****** Object:  UserDefinedFunction [dbo].[Ldsp_Most_Recent_Donation_Byu]    Script Date: 1/20/2018 2:05:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[Ldsp_Most_Recent_Donation_Byu]()
			RETURNS TABLE
			AS 
			RETURN
				SELECT A.Donor_Key
					, MAX(B.New_ReceiptDate) AS Max_Receipt_Date
					FROM _Donation_Fact A
						INNER JOIN _Donation_Dim B ON A.Donation_Key = B.Donation_Key
						INNER JOIN _Hier_Dim C ON A.Hier_Key = C.Hier_Key
					WHERE 1 = 1
						AND A.Plus_SharedCreditType != 'Matching' -- Not Matching
						AND A.Plus_Type IN ('Hard','Shared') -- Not Influence 100000001
						AND C.New_Inst = 'BYU'
					GROUP BY A.Donor_Key