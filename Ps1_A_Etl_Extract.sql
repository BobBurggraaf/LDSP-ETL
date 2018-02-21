/******************************************************************************
   NAME: Ps1_A_Etl_Extract.sql 
   PURPOSE: Extract tables from source database (MSSQL12316\S06) and populate tables in stage database (MSSQL12336\S01)
 
******************************************************************************/


IF OBJECT_ID('OneAccord_Warehouse.Oa_Extract.Extract_Tables','U') IS NOT NULL
DROP TABLE OneAccord_Warehouse.Oa_Extract.Extract_Tables;
GO

CREATE TABLE OneAccord_Warehouse.Oa_Extract.Extract_Tables
	(
	Extract_Tables_Key  INT IDENTITY(1,1) PRIMARY KEY
	, Source_Table NVARCHAR(100)
	, Destination_Table NVARCHAR(100)
	, Create_Fields NVARCHAR(4000)
	, Insert_Fields NVARCHAR(4000)
	, Select_Statement NVARCHAR(4000)
	, From_Statement NVARCHAR(4000)
	, Where_Statement NVARCHAR(4000)
	, Code_Block_1 NVARCHAR(4000)
	, Code_Block_2 NVARCHAR(4000)
	, Code_Block_3 NVARCHAR(4000)
	, Code_Block_4 NVARCHAR(4000)
	, Code_Block_5 NVARCHAR(4000)
	, Code_Block_6 NVARCHAR(4000)
	, Code_Block_7 NVARCHAR(4000)
	, Code_Block_8 NVARCHAR(4000)
	, Code_Block_9 NVARCHAR(4000)
	, Code_Block_10 NVARCHAR(4000)
	, Code_Block_11 NVARCHAR(4000)
	, Code_Block_12 NVARCHAR(4000)
	, Code_Block_13 NVARCHAR(4000)
	, Code_Block_14 NVARCHAR(4000)
	, Code_Block_15 NVARCHAR(4000)
	, Code_Block_16 NVARCHAR(4000)
	, Code_Block_17 NVARCHAR(4000)
	, Code_Block_18 NVARCHAR(4000)
	, Code_Block_19 NVARCHAR(4000)
	, Code_Block_20 NVARCHAR(MAX)
	, Active BIT
	, Insert_Date DATETIME
	, Update_Date DATETIME
	);
	
INSERT INTO OneAccord_Warehouse.Oa_Extract.Extract_Tables
	(
	Source_Table
	, Destination_Table
	, Create_Fields
	, Insert_Fields
	, Select_Statement
	, From_Statement
	, Where_Statement
	, Code_Block_1
	, Code_Block_2
	, Code_Block_3
	, Code_Block_4
	, Code_Block_5
	, Code_Block_6
	, Code_Block_7
	, Code_Block_8
	, Code_Block_9
	, Code_Block_10
	, Code_Block_11
	, Code_Block_12
	, Code_Block_13
	, Code_Block_14
	, Code_Block_15
	, Code_Block_16
	, Code_Block_17
	, Code_Block_18
	, Code_Block_19
	, Code_Block_20
	, Active
	, Insert_Date
	, Update_Date
	)
	VALUES
-- --------------------------
-- ACCOUNT (Ext_Account)
-- --------------------------
	('dbo.AccountBase' -- Source_Table
		, 'Oa_Extract.Ext_Account' -- Destination_Table
		,'AccountId UNIQUEIDENTIFIER
			, New_LdspId NVARCHAR(100)
			, Name NVARCHAR(160)
			, ParentAccountId UNIQUEIDENTIFIER
			, Description NVARCHAR(4000)
			, DoNotPostalMail BIT
			, DoNotBulkPostalMail BIT
			, DoNotEmail BIT
			, DoNotBulkEmail BIT
			, DoNotPhone BIT
			, DoNotFax BIT
			, AccountClassificationCode INT
			, New_RetireeRatio INT
			, New_SplitRatio INT
			, New_MatchingRatio INT
			, PreferredContactMethodCode INT
			, Plus_CoordinatingLiaison UNIQUEIDENTIFIER
			, Plus_ConnectedLiaison UNIQUEIDENTIFIER
			, Plus_PendingLiaison UNIQUEIDENTIFIER
			, Plus_MatchingGiftProgram INT
			, Plus_TotalGivenLast5Years MONEY
			, Lds_IsQualified BIT
			, Lds_QualifiedOn DATETIME
			, Lds_QualifiedBy UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'AccountId
			, New_LdspId
			, Name
			, ParentAccountId
			, Description
			, DoNotPostalMail
			, DoNotBulkPostalMail
			, DoNotEmail
			, DoNotBulkEmail
			, DoNotPhone
			, DoNotFax
			, AccountClassificationCode
			, New_RetireeRatio
			, New_SplitRatio
			, New_MatchingRatio
			, PreferredContactMethodCode
			, Plus_CoordinatingLiaison
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, Plus_MatchingGiftProgram
			, Plus_TotalGivenLast5Years
			, Lds_IsQualified
			, Lds_QualifiedOn
			, Lds_QualifiedBy
			' -- Insert_Fields
		, 'AccountId
			, New_LdspId
			, Name
			, ParentAccountId
			, CONVERT(NVARCHAR(3000),Description) AS Description
			, DoNotPostalMail
			, DoNotBulkPostalMail
			, DoNotEmail
			, DoNotBulkEmail
			, DoNotPhone
			, DoNotFax
			, AccountClassificationCode
			, New_RetireeRatio
			, New_SplitRatio
			, New_MatchingRatio
			, PreferredContactMethodCode
			, Plus_CoordinatingLiaison
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, Plus_MatchingGiftProgram
			, Plus_TotalGivenLast5Years
			, Lds_IsQualified
			, CASE WHEN DATENAME(dy,A.Lds_QualifiedOn) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Lds_QualifiedOn)
					ELSE DATEADD(hh,-7,A.Lds_QualifiedOn) END AS Lds_QualifiedOn
			, Lds_QualifiedBy
			' -- Select_Statement
		, 'AccountBase A
			LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Lds_QualifiedOn) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ACTIVITY (Ext_Activity)
-- --------------------------
	('dbo.ActivityPartyBase' -- Source_Table
		, 'Oa_Extract.Ext_Activity' -- Destination_Table
		, 'ActivityPartyId UNIQUEIDENTIFIER
			, ActivityId UNIQUEIDENTIFIER
			, PartyId UNIQUEIDENTIFIER
			, PartyObjectTypeCode INT
			, ScheduledStart DATETIME
			, PartyIdName NVARCHAR(4000)
			, ParticipationTypeMask INT
			' -- Create_Fields
		, 'ActivityPartyId
			, ActivityId
			, PartyId
			, PartyObjectTypeCode
			, ScheduledStart
			, PartyIdName
			, ParticipationTypeMask
			' -- Insert_Fields
		, 'ActivityPartyId
			, ActivityId
			, PartyId
			, PartyObjectTypeCode
			, CASE WHEN DATENAME(dy,A.ScheduledStart) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ScheduledStart)
					ELSE DATEADD(hh,-7,A.ScheduledStart) END AS ScheduledStart
			, PartyIdName
			, ParticipationTypeMask
			' -- Select_Statement
		, 'ActivityPartyBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.ScheduledStart) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ACTIVITY_POINTER (Ext_Activity_Pointer)
-- --------------------------
	('dbo.ActivityPointerBase' -- Source_Table
		, 'Oa_Extract.Ext_Activity_Pointer' -- Destination_Table
		, 'ActivityId UNIQUEIDENTIFIER
			, ActivityTypeCode INT
			, RegardingObjectTypeCode INT
			, ScheduledStart DATETIME
			, ScheduledEnd DATETIME
			, ActualStart DATETIME
			, ActualEnd DATETIME
			, RegardingObjectId UNIQUEIDENTIFIER
			, Subject NVARCHAR(200)
			, RegardingObjectIdName NVARCHAR(4000)
			, Description NVARCHAR(4000)
			, OwnerId UNIQUEIDENTIFIER
			, CampactChannelTypeCode INT
			, CreatedOn DATETIME
			, StateCode INT
			, StatusCode INT
			, ModifiedOn DATETIME
			' -- Create_Fields
		, 'ActivityId
			, ActivityTypeCode
			, RegardingObjectTypeCode
			, ScheduledStart
			, ScheduledEnd
			, ActualStart
			, ActualEnd
			, RegardingObjectId
			, Subject
			, RegardingObjectIdName
			, Description
			, OwnerId
			, CampactChannelTypeCode
			, CreatedOn
			, StateCode
			, StatusCode
			, ModifiedOn
			' -- Insert_Fields
		, 'ActivityId
			, ActivityTypeCode
			, RegardingObjectTypeCode
			, CASE WHEN DATENAME(dy,A.ScheduledStart) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ScheduledStart)
					ELSE DATEADD(hh,-7,A.ScheduledStart) END AS ScheduledStart
			, CASE WHEN DATENAME(dy,A.ScheduledEnd) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ScheduledEnd)
					ELSE DATEADD(hh,-7,A.ScheduledEnd) END AS ScheduledEnd
			, CASE WHEN DATENAME(dy,A.ActualStart) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ActualStart)
					ELSE DATEADD(hh,-7,A.ActualStart) END AS ActualStart
			, CASE WHEN DATENAME(dy,A.ActualEnd) BETWEEN E.Mdt_Begin_Date_Number AND E.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ActualEnd)
					ELSE DATEADD(hh,-7,A.ActualEnd) END AS ActualEnd
			, RegardingObjectId
			, Subject
			, RegardingObjectIdName
			, CONVERT(NVARCHAR(4000),Description) AS Description
			, OwnerId
			, CampactChannelTypeCode
			, CASE WHEN DATENAME(dy,A.CreatedOn) BETWEEN F.Mdt_Begin_Date_Number AND F.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.CreatedOn)
					ELSE DATEADD(hh,-7,A.CreatedOn) END AS CreatedOn
			, StateCode
			, StatusCode
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN G.Mdt_Begin_Date_Number AND G.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS ModifiedOn
			' -- Select_Statement
		, 'ActivityPointerBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.ScheduledStart) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.ScheduledEnd) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.ActualStart) = D.Date_Year
				LEFT JOIN _MDT_Conversion_Dim E ON YEAR(A.ActualEnd) = E.Date_Year
				LEFT JOIN _MDT_Conversion_Dim F ON YEAR(A.CreatedOn) = F.Date_Year
				LEFT JOIN _MDT_Conversion_Dim G ON YEAR(A.ModifiedOn) = G.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ADDRESS (Ext_Address)
-- --------------------------
	('dbo.New_AddressBase' -- Source_Table
		, 'Oa_Extract.Ext_Address' -- Destination_Table
		, 'Plus_RelatedContact  UNIQUEIDENTIFIER
			, New_Primary BIT
			, New_Street1 NVARCHAR(100)
			, New_Street2 NVARCHAR(100)
			, New_Street3 NVARCHAR(100)
			, New_Zip4 NVARCHAR(15)
			, Plus_AddressDisplay NVARCHAR(300)
			, Plus_Longitude FLOAT
			, Plus_Latitude FLOAT
			, StateCode INT
			, New_Confidential BIT
			, New_CityLookUp UNIQUEIDENTIFIER
			, New_CountyId UNIQUEIDENTIFIER
			, New_StatesProvinces UNIQUEIDENTIFIER
			, New_CountryRegions UNIQUEIDENTIFIER
			, New_PostalCodes UNIQUEIDENTIFIER
			, Plus_OneAccordQuality INT
			, New_AddressType INT
			, New_AddressId UNIQUEIDENTIFIER
			, New_ConfirmedDate DATETIME
			, Plus_ForeignPostalCode NVARCHAR(100)
			, Lds_PostalCode NVARCHAR(100)
			, Lds_StateProvince NVARCHAR(100)
			, Lds_County NVARCHAR(100)
			, Lds_City NVARCHAR(100)
			' -- Create_Fields
		, 'Plus_RelatedContact
			, New_Primary
			, New_Street1
			, New_Street2
			, New_Street3
			, New_Zip4
			, Plus_AddressDisplay
			, Plus_Longitude
			, Plus_Latitude
			, StateCode
			, New_Confidential
			, New_CityLookUp
			, New_CountyId
			, New_StatesProvinces
			, New_CountryRegions
			, New_PostalCodes
			, Plus_OneAccordQuality
			, New_AddressType
			, New_AddressId
			, New_ConfirmedDate
			, Plus_ForeignPostalCode
			, Lds_PostalCode
			, Lds_StateProvince
			, Lds_County
			, Lds_City
			' -- Insert_Fields
		, 'COALESCE(Plus_RelatedContact,Plus_RelatedAccount) AS Plus_RelatedContact
			, New_Primary
			, New_Street1
			, New_Street2
			, New_Street3
			, New_Zip4
			, CONVERT(NVARCHAR(300),Plus_AddressDisplay) AS Plus_AddressDisplay
			, Plus_Longitude
			, Plus_Latitude
			, StateCode
			, New_Confidential
			, New_CityLookUp
			, New_CountyId
			, New_StatesProvinces
			, New_CountryRegions
			, New_PostalCodes
			, Plus_OneAccordQuality
			, New_AddressType
			, New_AddressId
			, New_ConfirmedDate
			, Plus_ForeignPostalCode
			, Lds_PostalCode
			, Lds_StateProvince
			, Lds_County
			, Lds_City
			' -- Select_Statement
		, 'New_AddressBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ADDRESSFORMAT (Ext_Address_Format)
-- --------------------------
	('dbo.Plus_AddressFormatBase' -- Source_Table
		, 'Oa_Extract.Ext_Address_Format' -- Destination_Table
		, 'Plus_AddressFormatId UNIQUEIDENTIFIER
			, New_UseStateAbreviation BIT
			' -- Create_Fields
		, 'Plus_AddressFormatId
			, New_UseStateAbreviation
			' -- Insert_Fields
		, 'Plus_AddressFormatId
			, New_UseStateAbreviation
			' -- Select_Statement
		, 'Plus_AddressFormatBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Alumni (Ext_Alumni)
-- --------------------------
	('dbo.Plus_AlumniBase' -- Source_Table
		, 'Oa_Extract.Ext_Alumni' -- Destination_Table
		, 'Plus_AlumniId UNIQUEIDENTIFIER
			, Plus_Name NVARCHAR(100)
			, Plus_ActualGraduationDate DATETIME
			, Plus_AlumniStatus INT
			, Plus_DgId INT
			, Plus_HoursCredits NVARCHAR(100)
			, Plus_PreferredGraduationDate DATETIME
			, Plus_Constituent UNIQUEIDENTIFIER
			, Plus_College UNIQUEIDENTIFIER
			, Plus_Degree UNIQUEIDENTIFIER
			, Plus_University UNIQUEIDENTIFIER
			, Plus_Source UNIQUEIDENTIFIER
			, Plus_Program UNIQUEIDENTIFIER
			, Plus_Emphasis UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'Plus_AlumniId 
			, Plus_Name
			, Plus_ActualGraduationDate
			, Plus_AlumniStatus
			, Plus_DgId
			, Plus_HoursCredits
			, Plus_PreferredGraduationDate
			, Plus_Constituent
			, Plus_College
			, Plus_Degree
			, Plus_University
			, Plus_Source
			, Plus_Program
			, Plus_Emphasis
			' -- Insert_Fields
		, 'Plus_AlumniId 
			, Plus_Name
			, CASE WHEN DATENAME(dy,A.Plus_ActualGraduationDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_ActualGraduationDate)
					ELSE DATEADD(hh,-7,A.Plus_ActualGraduationDate) END AS Plus_ActualGraduationDate
			, Plus_AlumniStatus
			, Plus_DgId
			, Plus_HoursCredits
			, CASE WHEN DATENAME(dy,A.Plus_PreferredGraduationDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PreferredGraduationDate)
					ELSE DATEADD(hh,-7,A.Plus_PreferredGraduationDate) END AS Plus_PreferredGraduationDate
			, Plus_Constituent
			, Plus_College
			, Plus_Degree
			, Plus_University
			, Plus_Source
			, Plus_Program
			, Plus_Emphasis
			' -- Select_Statement
		, 'Plus_AlumniBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_ActualGraduationDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_PreferredGraduationDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- APPOINTMENT BASE (Ext_Appointment)
-- --------------------------
	('dbo.AppointmentBase' -- Source_Table
		, 'Oa_Extract.Ext_Appointment' -- Destination_Table
		, 'ActivityId UNIQUEIDENTIFIER
			, Plus_FaceToFace BIT
			' -- Create_Fields
		, 'ActivityId
			, Plus_FaceToFace
			' -- Insert_Fields
		, 'ActivityId
			, Plus_FaceToFace
			' -- Select_Statement
		, 'AppointmentBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ASSOCIATION (Ext_Association)
-- --------------------------
	('dbo.New_AssociationBase' -- Source_Table
		, 'Oa_Extract.Ext_Association' -- Destination_Table
		, 'New_AssociationId UNIQUEIDENTIFIER
			, New_ShortName NVARCHAR(100)
			, New_Acronym NVARCHAR(100)
			, New_Region NVARCHAR(100)
			, New_ChapterLevel NVARCHAR(100)
			, StateCode INT
			, New_Type INT
			, New_Sponsor INT
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_AssociationId
			, New_ShortName
			, New_Acronym
			, New_Region
			, New_ChapterLevel
			, StateCode
			, New_Type
			, New_Sponsor
			, New_Name
			' -- Insert_Fields
		, 'New_AssociationId
			, New_ShortName
			, New_Acronym
			, New_Region
			, New_ChapterLevel
			, StateCode
			, New_Type
			, New_Sponsor
			, New_Name
			' -- Select_Statement
		, 'New_AssociationBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- ASSOCIATION MEMBERSHIP (Ext_Association_Membership)
-- --------------------------
	('dbo.New_AssociationMembershipBase' -- Source_Table
		, 'Oa_Extract.Ext_Association_Membership' -- Destination_Table
		, 'New_AssociationMembershipId UNIQUEIDENTIFIER
			, New_ConstituentId  UNIQUEIDENTIFIER
			, New_Association UNIQUEIDENTIFIER
			, New_StartDate DATETIME
			, New_EndDate DATETIME
			, StatusCode INT
			, New_RelatedOrganization UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_AssociationMembershipId
			, New_ConstituentId
			, New_Association
			, New_StartDate
			, New_EndDate
			, StatusCode
			, New_RelatedOrganization
			' -- Insert_Fields
		, 'New_AssociationMembershipId
			, New_ConstituentId
			, New_Association
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, StatusCode
			, New_RelatedOrganization
			' -- Select_Statement
		, 'New_AssociationMembershipBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_StartDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_EndDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- AWARD (Ext_Recognition_Association)
-- --------------------------
	('dbo.New_RecognitionAssociationBase' -- Source_Table
		, 'Oa_Extract.Ext_Recognition_Association' -- Destination_Table
		, 'New_RecognitionAssociationId UNIQUEIDENTIFIER
			, New_Constituent UNIQUEIDENTIFIER
			, New_EndDate DATETIME
			, New_StartDate DATETIME
			, Plus_ScholarshipOfferedAmount MONEY
			, Plus_ScholarshipAwardTerm NVARCHAR(15)
			, Plus_ScholarshipGrantingOffice NVARCHAR(25)
			, Plus_ScholarshipAwardDate DATETIME
			, Plus_ScholarshipCode NVARCHAR(100)
			, New_Recognition UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_RecognitionAssociationId
			, New_Constituent
			, New_EndDate
			, New_StartDate
			, Plus_ScholarshipOfferedAmount
			, Plus_ScholarshipAwardTerm
			, Plus_ScholarshipGrantingOffice
			, Plus_ScholarshipAwardDate
			, Plus_ScholarshipCode
			, New_Recognition
			' -- Insert_Fields
		, 'New_RecognitionAssociationId
			, New_Constituent
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, Plus_ScholarshipOfferedAmount
			, Plus_ScholarshipAwardTerm
			, Plus_ScholarshipGrantingOffice
			, CASE WHEN DATENAME(dy,A.Plus_ScholarshipAwardDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_ScholarshipAwardDate)
					ELSE DATEADD(hh,-7,A.Plus_ScholarshipAwardDate) END AS Plus_ScholarshipAwardDate
			, Plus_ScholarshipCode
			, New_Recognition
			' -- Select_Statement
		, 'New_RecognitionAssociationBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_EndDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_StartDate) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.Plus_ScholarshipAwardDate) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Campaign (Ext_Campaign)
-- --------------------------
	('dbo.CampaignBase' -- Source_Table
		, 'Oa_Extract.Ext_Campaign' -- Destination_Table
		, 'CampaignId UNIQUEIDENTIFIER
			, Name NVARCHAR(128)
			, Type_Code	INT			
			, StatusCode INT
			, Plus_Affiliate INT
			, Plus_Requestor NVARCHAR(100)
			, Plus_Association UNIQUEIDENTIFIER
			, Plus_DepartmentFunction INT	
			, Plus_Cause INT		
			, Description NVARCHAR(4000)
			, BudgetedCost_Base NVARCHAR(50)
			, ExpectedRevenue NVARCHAR(50)
			, OtherCost NVARCHAR(50)
			, TotalCampaignActivityActualCost NVARCHAR(50)
			, TotalActualCost NVARCHAR(50)
			, Plus_CostToRaise1_Base NVARCHAR(50)
			, Plus_TotalGiftRevenueFromCampaign NVARCHAR(50)
			, Plus_CampaignProfit_Base NVARCHAR(50)
			' -- Create_Fields
		, 'CampaignId
			, Name
			, Type_Code			
			, StatusCode
			, Plus_Affiliate
			, Plus_Requestor
			, Plus_Association
			, Plus_DepartmentFunction	
			, Plus_Cause		
			, Description
			, BudgetedCost_Base
			, ExpectedRevenue
			, OtherCost
			, TotalCampaignActivityActualCost
			, TotalActualCost
			, Plus_CostToRaise1_Base
			, Plus_TotalGiftRevenueFromCampaign
			, Plus_CampaignProfit_Base
			' -- Insert_Fields
		, 'CampaignId
			, Name
			, TypeCode			
			, StatusCode
			, Plus_Affiliate
			, NULL AS Plus_Requestor
			, Plus_Association
			, Plus_DepartmentFunction	
			, Plus_Cause		
			, CONVERT(NVARCHAR(4000),Description) AS Description
			, CONVERT(NVARCHAR(50),BudgetedCost_Base) AS BudgetedCost_Base
			, CONVERT(NVARCHAR(50),ExpectedRevenue) AS ExpectedRevenue
			, CONVERT(NVARCHAR(50),OtherCost) AS OtherCost
			, CONVERT(NVARCHAR(50),TotalCampaignActivityActualCost) AS TotalCampaignActivityActualCost
			, CONVERT(NVARCHAR(50),TotalActualCost) AS TotalActualCost
			, CONVERT(NVARCHAR(50),Plus_CostToRaise1_Base) AS Plus_CostToRaise1_Base
			, CONVERT(NVARCHAR(50),Plus_TotalGiftRevenueFromCampaign) AS Plus_TotalGiftRevenueFromCampaign
			, CONVERT(NVARCHAR(50),Plus_CampaignProfit_Base) AS Plus_CampaignProfit_Base
			' -- Select_Statement
		, 'CampaignBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Campaign_Activity (Ext_Campaign_Activity)
-- --------------------------
	('dbo.CampaignActivityBase' -- Source_Table
		, 'Oa_Extract.Ext_Campaign_Activity' -- Destination_Table
		, 'ActivityId UNIQUEIDENTIFIER
			, Plus_InstitutionalHierarchy UNIQUEIDENTIFIER
			, Plus_AppealCode NVARCHAR(20)
			, Plus_CommunicationType INT
			, Plus_Format INT
			' -- Create_Fields
		, 'ActivityId
			, Plus_InstitutionalHierarchy
			, Plus_AppealCode
			, Plus_CommunicationType
			, Plus_Format
			' -- Insert_Fields
		, 'ActivityId
			, Plus_InstitutionalHierarchy
			, Plus_AppealCode
			, Plus_CommunicationType
			, Plus_Format
			' -- Select_Statement
		, 'CampaignActivityBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- College (Ext_College)
-- --------------------------
	('dbo.New_CollegeBase' -- Source_Table
		, 'Oa_Extract.Ext_College' -- Destination_Table
		, 'New_CollegeId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, New_CollegeCode NVARCHAR(10)
			' -- Create_Fields
		, 'New_CollegeId
			, New_Name
			, New_CollegeCode
			' -- Insert_Fields
		, 'New_CollegeId
			, New_Name
			, New_CollegeCode
			' -- Select_Statement
		, 'New_CollegeBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- CITY (Ext_City)
-- --------------------------
	('dbo.New_CityBase' -- Source_Table
		, 'Oa_Extract.Ext_City' -- Destination_Table
		, 'New_CityId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_CityId
			, New_Name
			' -- Insert_Fields
		, 'New_CityId
			, New_Name
			' -- Select_Statement
		, 'New_CityBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Connection (Ext_Connection)
-- --------------------------
	('dbo.ConnectionBase' -- Source_Table
		, 'Oa_Extract.Ext_Connection' -- Destination_Table
		, 'Record1Id UNIQUEIDENTIFIER
			, Record2Id UNIQUEIDENTIFIER
			, Plus_AlternateName NVARCHAR(100)
			, Record1RoleId UNIQUEIDENTIFIER
			, Record2RoleId UNIQUEIDENTIFIER
			, Record1ObjectTypeCode INT
			, Record2ObjectTypeCode INT
			, ConnectionId UNIQUEIDENTIFIER
			, Record1IdObjectTypeCode INT
			, Record2IdObjectTypeCode INT
			' -- Create_Fields
		, 'Record1Id
			, Record2Id
			, Plus_AlternateName
			, Record1RoleId
			, Record2RoleId
			, Record1ObjectTypeCode
			, Record2ObjectTypeCode
			, ConnectionId
			, Record1IdObjectTypeCode
			, Record2IdObjectTypeCode
			' -- Insert_Fields
		, 'Record1Id
			, Record2Id
			, Plus_AlternateName
			, Record1RoleId
			, Record2RoleId
			, Record1ObjectTypeCode
			, Record2ObjectTypeCode
			, ConnectionId
			, Record1IdObjectTypeCode
			, Record2IdObjectTypeCode
			' -- Select_Statement
		, 'ConnectionBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Connection_Role (Ext_Connection_Role)
-- --------------------------
	('dbo.ConnectionRoleBase' -- Source_Table
		, 'Oa_Extract.Ext_Connection_Role' -- Destination_Table
		, 'ConnectionRoleId UNIQUEIDENTIFIER
			, Name NVARCHAR(100)
			, OverwriteTime DATETIME
			' -- Create_Fields
		, 'ConnectionRoleId
			, Name
			, OverwriteTime
			' -- Insert_Fields
		, 'ConnectionRoleId
			, Name
			, OverwriteTime
			' -- Select_Statement
		, 'ConnectionRoleBase			
			' -- From_Statement
		, 'AND OverwriteTime = ''1900-01-01 00:00:00.000'' 
			' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- CONTACT (Ext_Contact)
-- --------------------------
	('dbo.ContactBase' -- Source_Table
		, 'Oa_Extract.Ext_Contact' -- Destination_Table
		, 'ContactId UNIQUEIDENTIFIER
			, New_Ldspid NVARCHAR(100)
			, Plus_CoordinatingLiaison UNIQUEIDENTIFIER
			, FullName NVARCHAR(160)
			, FirstName NVARCHAR(50)
			, MiddleName NVARCHAR(50)
			, LastName NVARCHAR(50)
			, NickName NVARCHAR(50)
			, New_MiddleName2 NVARCHAR(100)
			, New_LastName2 NVARCHAR(100)
			, New_PreferredName NVARCHAR(100)
			, Plus_DisplayName NVARCHAR(100)
			, New_BirthName NVARCHAR(100)
			, Plus_CurrentStudent BIT
			, New_BirthDate NVARCHAR(100)
			, New_BirthdateDay NVARCHAR(100)
			, New_BirthdateMonth NVARCHAR(100)
			, New_BirthdateYear NVARCHAR(100)
			, New_Deceased BIT
			, New_DeceasedDate NVARCHAR(100)
			, New_DeceasedDay NVARCHAR(100)
			, New_DeceasedMonth NVARCHAR(100)
			, New_DeceasedYear NVARCHAR(100)
			, Plus_WealthDate DATETIME
			, SpousesName NVARCHAR(100)
			, New_Title UNIQUEIDENTIFIER
			, New_ProfessionalSuffix UNIQUEIDENTIFIER
			, New_HomeCountry UNIQUEIDENTIFIER
			, GenderCode INT
			, FamilyStatusCode INT
			, Plus_ChurchMember INT
			, New_PersonalSuffix INT
			, StatusCode INT
			, New_MajorGiftPropensity1 INT
			, Plus_AnnualGift1 INT
			, Plus_PlannedGift INT
			, Plus_GiftCapacityEnp INT
			, Plus_GiftCapacityEn INT
			, Plus_PhilanthropicCapacityRatingPcr INT
			, Plus_EstimatedHouseHoldIncome INT
			, Plus_EstimatedHomemarketValue INT
			, Plus_BlockClusters INT
			, Plus_PlannedGiftTier INT
			, Plus_PreferredFirstName NVARCHAR(100)
			, Plus_PreferredMiddleName NVARCHAR(100)
			, Plus_PreferredLastName NVARCHAR(100)
			, Plus_PreferredFullName NVARCHAR(100)
			, Plus_SpousePreferredFirstName NVARCHAR(100)
			, Plus_SpousePreferredMiddleName NVARCHAR(100)
			, Plus_SpousePreferredLastName NVARCHAR(100)
			, Plus_SpousePreferredFullName NVARCHAR(100)
			, Plus_ConnectedLiaison UNIQUEIDENTIFIER
			, Plus_PendingLiaison UNIQUEIDENTIFIER
			, Plus_I5TextLinesLdsp NVARCHAR(4000)
			, Plus_TotalGivenLast5Years MONEY
			, Lds_IsQualified BIT
			, Lds_QualifiedOn DATETIME
			, Lds_QualifiedBy UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'ContactId
			, New_Ldspid
			, Plus_CoordinatingLiaison
			, FullName
			, FirstName
			, MiddleName
			, LastName
			, NickName
			, New_MiddleName2
			, New_LastName2
			, New_PreferredName
			, Plus_DisplayName
			, New_BirthName
			, Plus_CurrentStudent
			, New_BirthDate
			, New_BirthdateDay
			, New_BirthdateMonth
			, New_BirthdateYear
			, New_Deceased
			, New_DeceasedDate
			, New_DeceasedDay
			, New_DeceasedMonth
			, New_DeceasedYear
			, Plus_WealthDate
			, SpousesName
			, New_Title
			, New_ProfessionalSuffix
			, New_HomeCountry
			, GenderCode
			, FamilyStatusCode
			, Plus_ChurchMember
			, New_PersonalSuffix
			, StatusCode
			, New_MajorGiftPropensity1
			, Plus_AnnualGift1
			, Plus_PlannedGift
			, Plus_GiftCapacityEnp
			, Plus_GiftCapacityEn
			, Plus_PhilanthropicCapacityRatingPcr
			, Plus_EstimatedHouseHoldIncome
			, Plus_EstimatedHomemarketValue
			, Plus_BlockClusters
			, Plus_PlannedGiftTier
			, Plus_PreferredFirstName
			, Plus_PreferredMiddleName
			, Plus_PreferredLastName
			, Plus_PreferredFullName
			, Plus_SpousePreferredFirstName
			, Plus_SpousePreferredMiddleName
			, Plus_SpousePreferredLastName
			, Plus_SpousePreferredFullName
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, Plus_I5TextLinesLdsp
			, Plus_TotalGivenLast5Years
			, Lds_IsQualified
			, Lds_QualifiedOn
			, Lds_QualifiedBy
			' -- Insert_Fields
		, 'ContactId
			, New_Ldspid
			, Plus_CoordinatingLiaison
			, FullName
			, FirstName
			, MiddleName
			, LastName
			, NickName
			, New_MiddleName2
			, New_LastName2
			, New_PreferredName
			, Plus_DisplayName
			, New_BirthName
			, Plus_CurrentStudent
			, New_BirthDate
			, New_BirthdateDay
			, New_BirthdateMonth
			, New_BirthdateYear
			, New_Deceased
			, New_DeceasedDate
			, New_DeceasedDay
			, New_DeceasedMonth
			, New_DeceasedYear
			, CASE WHEN DATENAME(dy,A.Plus_WealthDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_WealthDate)
					ELSE DATEADD(hh,-7,A.Plus_WealthDate) END AS Plus_WealthDate
			, SpousesName
			, New_Title
			, New_ProfessionalSuffix
			, New_HomeCountry
			, GenderCode
			, FamilyStatusCode
			, Plus_ChurchMember
			, New_PersonalSuffix
			, StatusCode
			, New_MajorGiftPropensity1
			, Plus_AnnualGift1
			, Plus_PlannedGift
			, Plus_GiftCapacityEnp
			, Plus_GiftCapacityEn
			, Plus_PhilanthropicCapacityRatingPcr
			, Plus_EstimatedHouseHoldIncome
			, Plus_EstimatedHomemarketValue
			, Plus_BlockClusters
			, Plus_PlannedGiftTier
			, Plus_PreferredFirstName
			, Plus_PreferredMiddleName
			, Plus_PreferredLastName
			, Plus_PreferredFullName
			, Plus_SpousePreferredFirstName
			, Plus_SpousePreferredMiddleName
			, Plus_SpousePreferredLastName
			, Plus_SpousePreferredFullName
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, CONVERT(NVARCHAR(4000),Plus_I5TextLinesLdsp) AS Plus_I5TextLinesLdsp
			, Plus_TotalGivenLast5Years
			, Lds_IsQualified
			, CASE WHEN DATENAME(dy,A.Lds_QualifiedOn) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Lds_QualifiedOn)
					ELSE DATEADD(hh,-7,A.Lds_QualifiedOn) END AS Lds_QualifiedOn
			, Lds_QualifiedBy
			' -- Select_Statement
		, 'ContactBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_WealthDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Lds_QualifiedOn) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- COUNTRY (Ext_Country)
-- --------------------------
	('dbo.New_CountryBase' -- Source_Table
		, 'Oa_Extract.Ext_Country' -- Destination_Table
		, 'New_CountryId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, Plus_AdderessFormat UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_CountryId
			, New_Name
			, Plus_AdderessFormat
			' -- Insert_Fields
		, 'New_CountryId
			, New_Name
			, Plus_AdderessFormat
			' -- Select_Statement
		, 'New_CountryBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- COUNTY (Ext_County)
-- --------------------------
	('dbo.New_CountyBase' -- Source_Table
		, 'Oa_Extract.Ext_County' -- Destination_Table
		, 'New_CountyId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, Plus_CountyCode NVARCHAR(10)
			' -- Create_Fields
		, 'New_CountyId
			, New_Name
			, Plus_CountyCode
			' -- Insert_Fields
		, 'New_CountyId
			, New_Name
			, Plus_CountyCode
			' -- Select_Statement
		, 'New_CountyBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Degree (Ext_Degree)
-- --------------------------
	('dbo.New_DegreeBase' -- Source_Table
		, 'Oa_Extract.Ext_Degree' -- Destination_Table
		, 'New_DegreeId UNIQUEIDENTIFIER
			, New_Degree NVARCHAR(100)
			, New_DegreeCode NVARCHAR(100)
			, Plus_DegreeLevel INT
			' -- Create_Fields
		, 'New_DegreeId
			, New_Degree
			, New_DegreeCode
			, Plus_DegreeLevel
			' -- Insert_Fields
		, 'New_DegreeId
			, New_Degree
			, New_DegreeCode
			, Plus_DegreeLevel
			' -- Select_Statement
		, 'New_DegreeBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- DONOR_SCORE_BASE (Ext_Donor_Score)
-- --------------------------
	('dbo.Plus_DonorScoreBase' -- Source_Table
		, 'Oa_Extract.Ext_Donor_Score' -- Destination_Table
		, '	Plus_DonorScoreId UNIQUEIDENTIFIER
			, Plus_Constituent UNIQUEIDENTIFIER
			, Plus_Institution UNIQUEIDENTIFIER
			, Plus_I5LegacyDonorTypeDate DATETIME
			, Plus_I5LegacyDonorType NVARCHAR(10)
			, ModifiedOn DATETIME
			, StatusCode INT
			, StateCode INT
			' -- Create_Fields
		, '	Plus_DonorScoreId
			, Plus_Constituent
			, Plus_Institution
			, Plus_I5LegacyDonorTypeDate
			, Plus_I5LegacyDonorType
			, ModifiedOn
			, StatusCode
			, StateCode
			' -- Insert_Fields
		, 'Plus_DonorScoreId
			, Plus_Constituent
			, Plus_Institution
			, Plus_I5LegacyDonorTypeDate
			, Plus_I5LegacyDonorType
			, ModifiedOn
			, StatusCode
			, StateCode
			' -- Select_Statement
		, 'Plus_DonorScoreBase				
			' -- From_Statement
		, 'AND YEAR(Plus_I5LegacyDonorTypeDate) >= YEAR(GETDATE())-5 
			' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- DROP_INCLUDE (Ext_Drop_Include)
-- --------------------------
	('dbo.New_DropIncludeBase' -- Source_Table
		, 'Oa_Extract.Ext_Drop_Include' -- Destination_Table
		, 'New_DropIncludeId UNIQUEIDENTIFIER
			, New_DropIncludesId UNIQUEIDENTIFIER
			, New_InstitutionalHierarchy UNIQUEIDENTIFIER
			, New_EmailDeliveryType BIT
			, New_PhoneDeliveryType BIT
			, New_WebDeliverytype BIT
			, New_VisitDeliveryType BIT
			, New_Reason INT
			, New_CommType INT
			, New_Interaction INT
			, New_Type INT
			, StateCode INT
			, New_MailDeliveryType BIT
			, New_TextDeliveryType BIT
			, New_StartDate DATETIME
			, New_EndDate DATETIME
			, Plus_CampaignId UNIQUEIDENTIFIER
			, New_Association UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_DropIncludeId
			, New_DropIncludesId
			, New_InstitutionalHierarchy
			, New_EmailDeliveryType
			, New_PhoneDeliveryType
			, New_WebDeliverytype
			, New_VisitDeliveryType
			, New_Reason
			, New_CommType
			, New_Interaction
			, New_Type
			, StateCode
			, New_MailDeliveryType
			, New_TextDeliveryType
			, New_StartDate
			, New_EndDate
			, Plus_CampaignId
			, New_Association
			' -- Insert_Fields
		, 'New_DropIncludeId
			, New_DropIncludesId
			, New_InstitutionalHierarchy
			, New_EmailDeliveryType
			, New_PhoneDeliveryType
			, New_WebDeliverytype
			, New_VisitDeliveryType
			, New_Reason
			, New_CommType
			, New_Interaction
			, New_Type
			, StateCode
			, New_MailDeliveryType
			, New_TextDeliveryType
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, Plus_CampaignId
			, New_Association
			' -- Select_Statement
		, 'New_DropIncludeBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_StartDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_EndDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- EMAIL (Ext_Email)
-- --------------------------
	('dbo.New_EmailBase' -- Source_Table
		, 'Oa_Extract.Ext_Email' -- Destination_Table
		, 'New_EmailId UNIQUEIDENTIFIER
			, New_ConstituentId UNIQUEIDENTIFIER
			, New_Emails NVARCHAR(150)
			, New_Primary BIT
			, Statecode INT
			, New_Confidential BIT
			, New_Emailtype INT
			, New_ConfirmationDate DATETIME
			' -- Create_Fields
		, 'New_EmailId
			, New_ConstituentId
			, New_Emails
			, New_Primary
			, Statecode
			, New_Confidential
			, New_Emailtype
			, New_ConfirmationDate
			' -- Insert_Fields
		, 'New_EmailId
			, COALESCE(New_ConstituentId,New_EmailsId) AS New_ConstituentId
			, New_Emails
			, New_Primary
			, Statecode
			, New_Confidential
			, New_Emailtype
			, New_ConfirmationDate
			' -- Select_Statement
		, 'New_EmailBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- EMPLOYMENT (Ext_Employment)
-- --------------------------
	('dbo.New_EmploymentBase' -- Source_Table
		, 'Oa_Extract.Ext_Employment' -- Destination_Table
		, 'New_EmploymentsId UNIQUEIDENTIFIER
			, New_EmploymentId UNIQUEIDENTIFIER
			, StateCode INT
			, New_Type INT
			, New_PaymentFrequency INT
			, New_Department NVARCHAR(100)
			, New_ChurchAff BIT
			, Plus_AlternateOrganizationName NVARCHAR(100)
			, New_Title NVARCHAR(100)
			, New_DateStarted DATETIME
			, New_DateEnded DATETIME
			, New_Internship BIT
			, New_InstitutionalHierarchyId UNIQUEIDENTIFIER
			, New_Source UNIQUEIDENTIFIER
			, New_IndustryCategory UNIQUEIDENTIFIER
			, New_JobCode UNIQUEIDENTIFIER
			, Plus_ChurchEmploymentStatus INT
			, New_Company UNIQUEIDENTIFIER
			, StatusCode INT
			, ModifiedOn DATETIME
			, Plus_RelatedAddress UNIQUEIDENTIFIER
			, Plus_RelatedPhone UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_EmploymentsId
			, New_EmploymentId
			, StateCode
			, New_Type
			, New_PaymentFrequency
			, New_Department
			, New_ChurchAff
			, Plus_AlternateOrganizationName
			, New_Title
			, New_DateStarted
			, New_DateEnded
			, New_Internship
			, New_InstitutionalHierarchyId
			, New_Source
			, New_IndustryCategory
			, New_JobCode
			, Plus_ChurchEmploymentStatus
			, New_Company
			, StatusCode
			, ModifiedOn
			, Plus_RelatedAddress
			, Plus_RelatedPhone
			' -- Insert_Fields
		, 'New_EmploymentsId
			, New_EmploymentId
			, StateCode
			, New_Type
			, New_PaymentFrequency
			, New_Department
			, New_ChurchAff
			, Plus_AlternateOrganizationName
			, New_Title
			, CASE WHEN DATENAME(dy,A.New_DateStarted) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_DateStarted)
					ELSE DATEADD(hh,-7,A.New_DateStarted) END AS New_DateStarted
			, CASE WHEN DATENAME(dy,A.New_DateEnded) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_DateEnded)
					ELSE DATEADD(hh,-7,A.New_DateEnded) END AS New_DateEnded
			, New_Internship
			, New_InstitutionalHierarchyId
			, New_Source
			, New_IndustryCategory
			, New_JobCode
			, Plus_ChurchEmploymentStatus
			, New_Company
			, StatusCode
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS ModifiedOn
			, Plus_RelatedAddress
			, Plus_RelatedPhone
			' -- Select_Statement
		, 'New_EmploymentBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_DateStarted) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_DateEnded) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.ModifiedOn) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ENVELOPENAMES_AND_SALUTATIONS (Ext_Envelope_Names_And_Salutations)
-- --------------------------
	('dbo.Plus_EnvelopeNamesAndSalutationsBase' -- Source_Table
		, 'Oa_Extract.Ext_Envelope_Names_And_Salutations' -- Destination_Table
		, 'Plus_Etiquette INT
			, Plus_EnvelopeSalutationConstituent UNIQUEIDENTIFIER
			, Plus_SalutationEnvelopeName NVARCHAR(300)
			, Plus_Household INT
			, StateCode INT
			, Plus_NameType INT
			, Plus_EnvelopeNamesAndSalutationsId UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'Plus_Etiquette
			, Plus_EnvelopeSalutationConstituent
			, Plus_SalutationEnvelopeName
			, Plus_Household
			, StateCode
			, Plus_NameType
			, Plus_EnvelopeNamesAndSalutationsId
			' -- Insert_Fields
		, 'Plus_Etiquette
			, Plus_EnvelopeSalutationConstituent
			, Plus_SalutationEnvelopeName
			, Plus_Household
			, StateCode
			, Plus_NameType
			, Plus_EnvelopeNamesAndSalutationsId
			' -- Select_Statement
		, 'Plus_EnvelopeNamesAndSalutationsBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- FUND (Ext_Fund_Account)
-- --------------------------
	('dbo.New_FundAccountBase' -- Source_Table
		, 'Oa_Extract.Ext_Fund_Account' -- Destination_Table
		, 'New_FundAccountId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, New_FundName NVARCHAR(100)
			, New_AccountNumber  NVARCHAR(100)
			, Plus_GiftPurposeSubtype NVARCHAR(500)
			, Plus_GiftPurposeType NVARCHAR(500)
			, Plus_LdspAccountNumberInt INT
			, New_FormalAccountName NVARCHAR(100)
			, New_InstitutionalHierarchy UNIQUEIDENTIFIER
			, New_InstitutionAccountNumber NVARCHAR(100)
			, Plus_Unrestricted NVARCHAR(1)
			, Plus_Scholarship NVARCHAR(1)
			, New_Endowment BIT
			, Plus_EffectiveFrom DATETIME
			, Plus_EffectiveTo DATETIME
			, New_CaePurpose NVARCHAR(500)
			, Plus_SubClassAccountNumber NVARCHAR(100)
			, New_Description NVARCHAR(300)
			, Plus_Notes NVARCHAR(200)
			, Plus_AwardRestrictionGender NVARCHAR(500)
			, Plus_AwardRestrictionClassYear NVARCHAR(500)
			, Plus_AwardRestrictionCollege UNIQUEIDENTIFIER
			, Plus_AwardRestrictionEthnicity NVARCHAR(500)
			, Plus_AwardRestrictionGPA DECIMAL
			, Plus_AwardRestrictionMajor UNIQUEIDENTIFIER
			, Plus_GeographicArea UNIQUEIDENTIFIER
			, Plus_AwardRestrictionSeminaryGraduate NVARCHAR(1)
			, Plus_NeedBased NVARCHAR(1)
			, Plus_AwardRestrictionSingleParent NVARCHAR(1)
			, Plus_AwardRestrictionReturnedMissionary NVARCHAR(1)
			, Plus_PayItForward NVARCHAR(1)
			, Plus_AwardRestrictionNotes NVARCHAR(4000)
			, Plus_Athletics NVARCHAR(1)
			, Plus_FourYear NVARCHAR(1)
			, Plus_GraduateProfessional NVARCHAR(1)
			, Plus_TvRadio NVARCHAR(1)
			, Plus_TechnologySpec NVARCHAR(1)
			, Plus_AlumniAssociation NVARCHAR(1)
			, Plus_MatchingGiftText	NVARCHAR(4000)
			, Plus_PrincipalAccountNumber NVARCHAR(100)
			, Plus_Spendable NVARCHAR(25)
			, Plus_ProposedEndowment BIT
			, Plus_ReportFrequency INT
			, StatusCode INT
			, New_AllowGifts BIT
			' -- Create_Fields
		, 'New_FundAccountId
			, New_Name
			, New_FundName
			, New_AccountNumber
			, Plus_GiftPurposeSubtype
			, Plus_GiftPurposeType
			, Plus_LdspAccountNumberInt
			, New_FormalAccountName
			, New_InstitutionalHierarchy 
			, New_InstitutionAccountNumber
			, Plus_Unrestricted
			, Plus_Scholarship
			, New_Endowment
			, Plus_EffectiveFrom
			, Plus_EffectiveTo
			, New_CaePurpose
			, Plus_SubClassAccountNumber
			, New_Description
			, Plus_Notes
			, Plus_AwardRestrictionGender
			, Plus_AwardRestrictionClassYear
			, Plus_AwardRestrictionCollege
			, Plus_AwardRestrictionEthnicity
			, Plus_AwardRestrictionGPA
			, Plus_AwardRestrictionMajor
			, Plus_GeographicArea
			, Plus_AwardRestrictionSeminaryGraduate
			, Plus_NeedBased
			, Plus_AwardRestrictionSingleParent
			, Plus_AwardRestrictionReturnedMissionary
			, Plus_PayItForward
			, Plus_AwardRestrictionNotes
			, Plus_Athletics
			, Plus_FourYear
			, Plus_GraduateProfessional
			, Plus_TvRadio
			, Plus_TechnologySpec
			, Plus_AlumniAssociation
			, Plus_MatchingGiftText
			, Plus_PrincipalAccountNumber
			, Plus_Spendable
			, Plus_ProposedEndowment
			, Plus_ReportFrequency
			, StatusCode
			, New_AllowGifts
			' -- Insert_Fields
		, 'New_FundAccountId
			, New_Name
			, New_FundName
			, New_AccountNumber
			, Plus_GiftPurposeSubtype
			, Plus_GiftPurposeType
			, Plus_LdspAccountNumberInt
			, New_FormalAccountName
			, New_InstitutionalHierarchy
			, New_InstitutionAccountNumber
			, Plus_Unrestricted
			, Plus_Scholarship
			, New_Endowment
			, CASE WHEN DATENAME(dy,A.Plus_EffectiveFrom) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EffectiveFrom)
					ELSE DATEADD(hh,-7,A.Plus_EffectiveFrom) END AS Plus_EffectiveFrom
			, CASE WHEN DATENAME(dy,A.Plus_EffectiveTo) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EffectiveTo)
					ELSE DATEADD(hh,-7,A.Plus_EffectiveTo) END AS Plus_EffectiveTo
			, New_CaePurpose
			, Plus_SubClassAccountNumber
			, CONVERT(NVARCHAR(300),New_Description) AS New_Description
			, CONVERT(NVARCHAR(200),Plus_Notes) AS Plus_Notes
			, Plus_AwardRestrictionGender
			, Plus_AwardRestrictionClassYear
			, Plus_AwardRestrictionCollege
			, Plus_AwardRestrictionEthnicity
			, Plus_AwardRestrictionGPA
			, Plus_AwardRestrictionMajor
			, Plus_GeographicArea
			, Plus_AwardRestrictionSeminaryGraduate
			, Plus_NeedBased
			, Plus_AwardRestrictionSingleParent
			, Plus_AwardRestrictionReturnedMissionary
			, Plus_PayItForward
			, CONVERT(NVARCHAR(4000),Plus_AwardRestrictionNotes) AS Plus_AwardRestrictionNotes
			, Plus_Athletics
			, Plus_FourYear
			, Plus_GraduateProfessional
			, Plus_TvRadio
			, Plus_TechnologySpec
			, Plus_AlumniAssociation
			, CONVERT(NVARCHAR(4000),Plus_MatchingGiftText) AS Plus_MatchingGiftText
			, Plus_PrincipalAccountNumber
			, Plus_Spendable
			, Plus_ProposedEndowment
			, Plus_ReportFrequency
			, StatusCode
			, New_AllowGifts
			' -- Select_Statement
		, 'New_FundAccountBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_EffectiveFrom) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_EffectiveTo) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- GIFT (Ext_Gift)
-- --------------------------
	('dbo.New_GiftBase' -- Source_Table
		, 'Oa_Extract.Ext_Gift' -- Destination_Table
		, 'New_ConstituentDonor UNIQUEIDENTIFIER
			, New_OrganizationDonor UNIQUEIDENTIFIER
			, New_FundAccount UNIQUEIDENTIFIER
			, New_InstitutionalHierarchyId UNIQUEIDENTIFIER
			, New_AssociatedPledge UNIQUEIDENTIFIER
			, New_GiftAmount MONEY
			, New_BatchNumber NVARCHAR(50)
			, New_GiftId UNIQUEIDENTIFIER
			, OwnerId UNIQUEIDENTIFIER			
			, New_GiftNumber NVARCHAR(50)
			, StatusCode INT
			, Plus_ReceiptText NVARCHAR(4000)
			, Plus_SpecialGiftInstructions NVARCHAR(4000)
			, Plus_CheckNumber NVARCHAR(50)
			, Plus_GiftSource INT
			, Plus_Kind INT
			, New_TenderType INT
			, New_AccountingDate DATETIME
			, New_ReceiptDate DATETIME
			, New_PostDate DATETIME
			, Plus_PlannedGift BIT
			, New_Transmitted BIT
			, Plus_AnonymousGift BIT
			, Plus_ReceiptDeliveryMethod INT
			, Plus_GiftInstructions NVARCHAR(4000)
			, Plus_AcknowledgementInstructions NVARCHAR(4000)
			, Plus_ExcludeFromReport BIT
			, Plus_IncludeOnYearEndReceipt BIT
			, Plus_GoodsServicesProvided BIT
			, Plus_EntitledBenefitValue MONEY
			, Plus_AcknowledgeContact NVARCHAR(100)
			, Plus_ContactRole INT
			, Plus_Salutation INT
			, Plus_Signer UNIQUEIDENTIFIER
			, Plus_NoAcknowledgement BIT
			, Match_Gift_Number NVARCHAR(50)
			, Plus_Appeal UNIQUEIDENTIFIER
			, Plus_MatchExpected BIT
			, New_Batch UNIQUEIDENTIFIER
			, Plus_Description NVARCHAR(4000)
			, Lds_RecurringGiftRule UNIQUEIDENTIFIER
			, Lds_RecurringGiftGroup UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_ConstituentDonor
			, New_OrganizationDonor
			, New_FundAccount
			, New_InstitutionalHierarchyId
			, New_AssociatedPledge
			, New_GiftAmount
			, New_BatchNumber
			, New_GiftId
			, OwnerId			
			, New_GiftNumber
			, StatusCode
			, Plus_ReceiptText
			, Plus_SpecialGiftInstructions
			, Plus_CheckNumber
			, Plus_GiftSource
			, Plus_Kind
			, New_TenderType
			, New_AccountingDate
			, New_ReceiptDate
			, New_PostDate
			, Plus_PlannedGift
			, New_Transmitted
			, Plus_AnonymousGift
			, Plus_ReceiptDeliveryMethod
			, Plus_GiftInstructions
			, Plus_AcknowledgementInstructions
			, Plus_ExcludeFromReport
			, Plus_IncludeOnYearEndReceipt
			, Plus_GoodsServicesProvided
			, Plus_EntitledBenefitValue
			, Plus_AcknowledgeContact
			, Plus_ContactRole
			, Plus_Salutation
			, Plus_Signer
			, Plus_NoAcknowledgement
			, Match_Gift_Number
			, Plus_Appeal
			, Plus_MatchExpected
			, New_Batch
			, Plus_Description
			, Lds_RecurringGiftRule
			, Lds_RecurringGiftGroup
			' -- Insert_Fields
		, 'New_ConstituentDonor
			, New_OrganizationDonor
			, New_FundAccount
			, New_InstitutionalHierarchyId
			, New_AssociatedPledge
			, New_GiftAmount
			, New_BatchNumber
			, New_GiftId
			, OwnerId
			, New_GiftNumber
			, StatusCode
			, CONVERT(NVARCHAR(4000),Plus_ReceiptText) AS Plus_ReceiptText
			, CONVERT(NVARCHAR(4000),Plus_SpecialGiftInstructions) AS Plus_SpecialGiftInstructions
			, Plus_CheckNumber
			, Plus_GiftSource
			, Plus_Kind
			, New_TenderType
			, CASE WHEN DATENAME(dy,A.New_AccountingDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_AccountingDate)
					ELSE DATEADD(hh,-7,A.New_AccountingDate) END AS New_AccountingDate
			, CASE WHEN DATENAME(dy,A.New_ReceiptDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_ReceiptDate)
					ELSE DATEADD(hh,-7,A.New_ReceiptDate) END AS New_ReceiptDate
			, CASE WHEN DATENAME(dy,A.New_PostDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_PostDate)
					ELSE DATEADD(hh,-7,A.New_PostDate) END AS New_PostDate
			, Plus_PlannedGift
			, New_Transmitted
			, Plus_AnonymousGift
			, Plus_ReceiptDeliveryMethod
			, CONVERT(NVARCHAR(4000),Plus_GiftInstructions) AS Plus_GiftInstructions
			, CONVERT(NVARCHAR(4000),Plus_AcknowledgementInstructions) AS Plus_AcknowledgementInstructions
			, Plus_ExcludeFromReport
			, Plus_IncludeOnYearEndReceipt
			, Plus_GoodsServicesProvided
			, Plus_EntitledBenefitValue
			, Plus_AcknowledgeContact
			, Plus_ContactRole
			, Plus_Salutation
			, Plus_Signer
			, Plus_NoAcknowledgement
			, CASE WHEN Plus_ParentGift IS NOT NULL THEN New_GiftNumber ELSE NULL END AS Match_Gift_Number
			, Plus_Appeal AS Appeal_Key
			, Plus_MatchExpected
			, New_Batch
			, CONVERT(NVARCHAR(4000),Plus_Description) AS Plus_Description
			, Lds_RecurringGiftRule
			, Lds_RecurringGiftGroup
			' -- Select_Statement
		, 'New_GiftBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_AccountingDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_ReceiptDate) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.New_PostDate) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Industry (Ext_Industry)
-- --------------------------
	('dbo.New_IndustryBase' -- Source_Table
		, 'Oa_Extract.Ext_Industry' -- Destination_Table
		, 'New_IndustryId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_IndustryId
			, New_Name
			' -- Insert_Fields
		, 'New_IndustryId
			, New_Name
			' -- Select_Statement
		, 'New_IndustryBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- INSTITUTION (Ext_Institution)
-- --------------------------
	('dbo.New_InstitutionBase' -- Source_Table
		, 'Oa_Extract.Ext_Institution' -- Destination_Table
		, 'New_Institutionid UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, Plus_ParentInstitutionalHieararchy UNIQUEIDENTIFIER
			, New_Level1 NVARCHAR(100)
			, New_Level2 NVARCHAR(100)
			, New_Level3 NVARCHAR(100)
			, New_AvailableToAlumni BIT
			, New_AvailableToStudent BIT
			, New_IsEndNode BIT
			, New_EducationUsage BIT
			, New_AssociationUsage BIT
			, New_DonationUsage BIT
			, New_Inst NVARCHAR(100)
			' -- Create_Fields
		, 'New_Institutionid
			, New_Name
			, Plus_ParentInstitutionalHieararchy
			, New_Level1
			, New_Level2
			, New_Level3
			, New_AvailableToAlumni
			, New_AvailableToStudent
			, New_IsEndNode
			, New_EducationUsage
			, New_AssociationUsage
			, New_DonationUsage
			, New_Inst
			' -- Insert_Fields
		, 'New_Institutionid
			, New_Name
			, Plus_ParentInstitutionalHieararchy
			, New_Level1
			, New_Level2
			, New_Level3
			, New_AvailableToAlumni
			, New_AvailableToStudent
			, New_IsEndNode
			, New_EducationUsage
			, New_AssociationUsage
			, New_DonationUsage
			, New_Inst
			' -- Select_Statement
		, 'New_InstitutionBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- Interest (Ext_Interest)
-- --------------------------
	('dbo.Plus_InterestBase' -- Source_Table
		, 'Oa_Extract.Ext_Interest' -- Destination_Table
		, 'Plus_InterestId UNIQUEIDENTIFIER
			, Plus_Name NVARCHAR(100)
			' -- Create_Fields
		, 'Plus_InterestId
			, Plus_Name
			' -- Insert_Fields
		, 'Plus_InterestId
			, Plus_Name
			' -- Select_Statement
		, 'Plus_InterestBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- International_ExperienceBase (Ext_International_Experience)
-- --------------------------
	('dbo.New_InternationalExperienceBase' -- Source_Table
		, 'Oa_Extract.Ext_International_Experience' -- Destination_Table
		, 'New_InternationalExperienceId UNIQUEIDENTIFIER
			, New_InternationalExperiencesAId UNIQUEIDENTIFIER
			, New_Experience INT
			, Plus_Emeritus BIT   
			, Plus_StudyAbroad BIT   
			, New_Source UNIQUEIDENTIFIER 
			, New_StartDate DATETIME
			, New_EndDate  DATETIME
			, Plus_Interest UNIQUEIDENTIFIER 
			, Plus_LdsPosition INT 
			, Plus_InstitutionalHierarchy UNIQUEIDENTIFIER 
			, New_Country UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_InternationalExperienceId
			, New_InternationalExperiencesAId
			, New_Experience
			, Plus_Emeritus   
			, Plus_StudyAbroad   
			, New_Source 
			, New_StartDate
			, New_EndDate
			, Plus_Interest 
			, Plus_LdsPosition 
			, Plus_InstitutionalHierarchy 
			, New_Country
			' -- Insert_Fields
		, 'New_InternationalExperienceId
			, New_InternationalExperiencesAId
			, New_Experience
			, Plus_Emeritus   
			, Plus_StudyAbroad   
			, New_Source 
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, Plus_Interest 
			, Plus_LdsPosition 
			, Plus_InstitutionalHierarchy 
			, New_Country
			' -- Select_Statement
		, 'New_InternationalExperienceBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_StartDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_EndDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- Job_Code (Ext_Job_Code)
-- --------------------------
	('dbo.New_JobCodeBase' -- Source_Table
		, 'Oa_Extract.Ext_Job_Code' -- Destination_Table
		, 'New_JobCodeId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_JobCodeId
			, New_Name
			' -- Insert_Fields
		, 'New_JobCodeId
			, New_Name
			' -- Select_Statement
		, 'New_JobCodeBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- LANGUAGE (Ext_Language)
-- --------------------------
	('dbo.New_LanguageSpecialAffiliationBase' -- Source_Table
		, 'Oa_Extract.Ext_Language' -- Destination_Table
		, 'New_LanguageSpecialAffiliationId  UNIQUEIDENTIFIER
			, New_LanguageSAId  UNIQUEIDENTIFIER
			, New_Language INT
			, New_Missionary INT
			, New_ReadLevel INT
			, New_Speech INT
			, New_Teacher INT
			, New_Translator INT
			, New_WriteLevel INT
			, New_BusinessPerson INT
			, Plus_I5CreatedBy NVARCHAR(75)
			, Plus_I5CreatedOn NVARCHAR(15)
			, Plus_Notes NVARCHAR(4000)
			, New_Source UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_LanguageSpecialAffiliationId
			, New_LanguageSAId
			, New_Language
			, New_Missionary
			, New_ReadLevel
			, New_Speech
			, New_Teacher
			, New_Translator
			, New_WriteLevel
			, New_BusinessPerson
			, Plus_I5CreatedBy
			, Plus_I5CreatedOn
			, Plus_Notes
			, New_Source
			' -- Insert_Fields
		, 'New_LanguageSpecialAffiliationId
			, New_LanguageSAId
			, New_Language
			, New_Missionary
			, New_ReadLevel
			, New_Speech
			, New_Teacher
			, New_Translator
			, New_WriteLevel
			, New_BusinessPerson
			, Plus_I5CreatedBy
			, Plus_I5CreatedOn
			, CONVERT(NVARCHAR(4000),Plus_Notes) AS Plus_Notes
			, New_Source
			' -- Select_Statement
		, 'New_LanguageSpecialAffiliationBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Major (Ext_Major)
-- --------------------------
	('dbo.New_MajorBase' -- Source_Table
		, 'Oa_Extract.Ext_Major' -- Destination_Table
		, 'New_College UNIQUEIDENTIFIER
			, New_University UNIQUEIDENTIFIER
			, New_MajorId UNIQUEIDENTIFIER
			, New_Major NVARCHAR(100)
			, New_MajorName NVARCHAR(100)
			, New_MajorCode NVARCHAR(10)
			' -- Create_Fields
		, 'New_College
			, New_University
			, New_MajorId
			, New_Major
			, New_MajorName
			, New_MajorCode
			' -- Insert_Fields
		, 'New_College
			, New_University
			, New_MajorId
			, New_Major
			, New_MajorName
			, New_MajorCode
			' -- Select_Statement
		, 'New_MajorBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- OPPORTUNITY (Ext_Opportunity)
-- --------------------------
	('dbo.OpportunityBase' -- Source_Table
		, 'Oa_Extract.Ext_Opportunity' -- Destination_Table
		, 'OpportunityId UNIQUEIDENTIFIER
			, Plus_TotalAskAmount MONEY
			, Plus_TotalCommittedAmount MONEY
			, Plus_TotalGiven MONEY
			, Name NVARCHAR(600)
			, StepName NVARCHAR(400)
			, StateCode INT
			, StatusCode INT
			, CustomerId UNIQUEIDENTIFIER
			, CustomerIdType INT
			, Plus_ProposalStatus INT
			, Plus_ProposalDate DATE
			, Plus_TargetedCommitment DATE
			, Plus_CommittedDate DATE
			, Plus_FundAccount UNIQUEIDENTIFIER
			, Plus_CultivationProcessStage1Date DATE
			, Plus_CultivationProcessStage2Date DATE
			, Plus_CultivationProcessStage3Date DATE
			, Plus_CultivationProcessStage4Date DATE
			, Plus_GiftNoticeCreatedOn DATE
			, Plus_ProposalStatusChangeDate DATE
			, Plus_NewAccount BIT
			, Plus_CoordinatingLiaisonId UNIQUEIDENTIFIER
			, OwnerId UNIQUEIDENTIFIER
			, Lds_PrimaryInitiative BIT
			, Plus_ParentInitiative UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'OpportunityId
			, Plus_TotalAskAmount
			, Plus_TotalCommittedAmount
			, Plus_TotalGiven
			, Name
			, StepName
			, StateCode
			, StatusCode
			, CustomerId
			, CustomerIdType
			, Plus_ProposalStatus
			, Plus_ProposalDate
			, Plus_TargetedCommitment
			, Plus_CommittedDate
			, Plus_FundAccount
			, Plus_CultivationProcessStage1Date
			, Plus_CultivationProcessStage2Date
			, Plus_CultivationProcessStage3Date
			, Plus_CultivationProcessStage4Date
			, Plus_GiftNoticeCreatedOn
			, Plus_ProposalStatusChangeDate
			, Plus_NewAccount
			, Plus_CoordinatingLiaisonId
			, OwnerId
			, Lds_PrimaryInitiative
			, Plus_ParentInitiative
			' -- Insert_Fields
		, 'OpportunityId
			, Plus_TotalAskAmount
			, Plus_TotalCommittedAmount
			, Plus_TotalGiven
			, Name
			, StepName
			, StateCode
			, StatusCode
			, CustomerId
			, CustomerIdType
			, Plus_ProposalStatus
			, CASE WHEN DATENAME(dy,A.Plus_ProposalDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_ProposalDate)
					ELSE DATEADD(hh,-7,A.Plus_ProposalDate) END AS Plus_ProposalDate
			, CASE WHEN DATENAME(dy,A.Plus_TargetedCommitment) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_TargetedCommitment)
					ELSE DATEADD(hh,-7,A.Plus_TargetedCommitment) END AS Plus_TargetedCommitment
			, CASE WHEN DATENAME(dy,A.Plus_CommittedDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CommittedDate)
					ELSE DATEADD(hh,-7,A.Plus_CommittedDate) END AS Plus_CommittedDate
			, Plus_FundAccount
			, CASE WHEN DATENAME(dy,A.Plus_CultivationProcessStage1Date) BETWEEN E.Mdt_Begin_Date_Number AND E.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CultivationProcessStage1Date)
					ELSE DATEADD(hh,-7,A.Plus_CultivationProcessStage1Date) END AS Plus_CultivationProcessStage1Date
			, CASE WHEN DATENAME(dy,A.Plus_CultivationProcessStage2Date) BETWEEN F.Mdt_Begin_Date_Number AND F.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CultivationProcessStage2Date)
					ELSE DATEADD(hh,-7,A.Plus_CultivationProcessStage2Date) END AS Plus_CultivationProcessStage2Date
			, CASE WHEN DATENAME(dy,A.Plus_CultivationProcessStage3Date) BETWEEN G.Mdt_Begin_Date_Number AND G.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CultivationProcessStage3Date)
					ELSE DATEADD(hh,-7,A.Plus_CultivationProcessStage3Date) END AS Plus_CultivationProcessStage3Date
			, CASE WHEN DATENAME(dy,A.Plus_CultivationProcessStage4Date) BETWEEN H.Mdt_Begin_Date_Number AND H.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CultivationProcessStage4Date)
					ELSE DATEADD(hh,-7,A.Plus_CultivationProcessStage4Date) END AS Plus_CultivationProcessStage4Date
			, CASE WHEN DATENAME(dy,A.Plus_GiftNoticeCreatedOn) BETWEEN I.Mdt_Begin_Date_Number AND I.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_GiftNoticeCreatedOn)
					ELSE DATEADD(hh,-7,A.Plus_GiftNoticeCreatedOn) END AS Plus_GiftNoticeCreatedOn
			, CASE WHEN DATENAME(dy,A.Plus_ProposalStatusChangeDate) BETWEEN J.Mdt_Begin_Date_Number AND J.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_ProposalStatusChangeDate)
					ELSE DATEADD(hh,-7,A.Plus_ProposalStatusChangeDate) END AS Plus_ProposalStatusChangeDate
			, Plus_NewAccount
			, Plus_CoordinatingLiaisonId
			, OwnerId
			, Lds_PrimaryInitiative
			, Plus_ParentInitiative
			' -- Select_Statement
		, 'OpportunityBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_ProposalDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_TargetedCommitment) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.Plus_CommittedDate) = D.Date_Year
				LEFT JOIN _MDT_Conversion_Dim E ON YEAR(A.Plus_CultivationProcessStage1Date) = E.Date_Year
				LEFT JOIN _MDT_Conversion_Dim F ON YEAR(A.Plus_CultivationProcessStage2Date) = F.Date_Year
				LEFT JOIN _MDT_Conversion_Dim G ON YEAR(A.Plus_CultivationProcessStage3Date) = G.Date_Year
				LEFT JOIN _MDT_Conversion_Dim H ON YEAR(A.Plus_CultivationProcessStage4Date) = H.Date_Year
				LEFT JOIN _MDT_Conversion_Dim I ON YEAR(A.Plus_GiftNoticeCreatedOn) = I.Date_Year
				LEFT JOIN _MDT_Conversion_Dim J ON YEAR(A.Plus_ProposalStatusChangeDate) = J.Date_Year				
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- OTHER_IDENTIFIER (Ext_Other_Identifiers)
-- --------------------------
	('dbo.New_OtherIdentifiersBase' -- Source_Table
		, 'Oa_Extract.Ext_Other_Identifiers' -- Destination_Table
		, 'New_OtherIdentifiersId UNIQUEIDENTIFIER
			, StateCode INT
			, New_Type INT
			, New_InstitutionalHierarchy UNIQUEIDENTIFIER
			, ModifiedOn DATETIME
			, New_EmploymentId UNIQUEIDENTIFIER
			, New_Id NVARCHAR(100)
			, Plus_Id NVARCHAR(100)
			, New_OtherIdentifiers UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_OtherIdentifiersId
			, StateCode
			, New_Type
			, New_InstitutionalHierarchy
			, ModifiedOn
			, New_EmploymentId
			, New_Id
			, Plus_Id
			, New_OtherIdentifiers
			' -- Insert_Fields
		, 'New_OtherIdentifiersId
			, StateCode
			, New_Type
			, New_InstitutionalHierarchy
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS ModifiedOn
			, New_EmploymentId
			, New_Id
			, Plus_Id
			, New_OtherIdentifiers
			' -- Select_Statement
		, 'New_OtherIdentifiersBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.ModifiedOn) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- PHONE (Ext_Phone)
-- --------------------------
	('dbo.New_PhoneBase' -- Source_Table
		, 'Oa_Extract.Ext_Phone' -- Destination_Table
		, 'New_PhoneId UNIQUEIDENTIFIER
			, New_NumberId UNIQUEIDENTIFIER
			, Plus_PhoneNumberUnformatted NVARCHAR(100)
			, New_PhoneNumber NVARCHAR(100)
			, New_CountryCode NVARCHAR(100)
			, New_Ext NVARCHAR(100)
			, StateCode INT
			, New_Primary BIT
			, New_ReceiveText BIT
			, New_Confidential BIT
			, New_Type INT
			, Plus_LineType INT
			, New_PreferredTime INT
			, StatusCode INT
			, ModifiedOn DATETIME
			, New_ConfirmationDate DATETIME
			' -- Create_Fields
		, 'New_PhoneId
			, New_NumberId
			, Plus_PhoneNumberUnformatted
			, New_PhoneNumber
			, New_CountryCode
			, New_Ext
			, StateCode
			, New_Primary
			, New_ReceiveText
			, New_Confidential
			, New_Type
			, Plus_LineType
			, New_PreferredTime
			, StatusCode
			, ModifiedOn
			, New_ConfirmationDate
			' -- Insert_Fields
		, 'New_PhoneId
			, COALESCE(New_NumberId,New_PhonesId) AS New_NumberId
			, Plus_PhoneNumberUnformatted
			, New_PhoneNumber
			, New_CountryCode
			, New_Ext
			, StateCode
			, New_Primary
			, New_ReceiveText
			, New_Confidential
			, New_Type
			, Plus_LineType
			, New_PreferredTime
			, StatusCode
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS ModifiedOn
			, New_ConfirmationDate
			' -- Select_Statement
		, 'New_PhoneBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.ModifiedOn) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- PLEDGE (Ext_Pledge)
-- --------------------------
	('dbo.New_PledgeBase' -- Source_Table
		, 'Oa_Extract.Ext_Pledge' -- Destination_Table
		, 'New_PledgeId UNIQUEIDENTIFIER
			, New_TotalPledged MONEY
			, New_BeginDate DATETIME
			, New_EndDate DATETIME
			, Plus_Kind INT
			, Plus_TenderType INT
			, Plus_GiftSource INT
			, Plus_PlannedGift BIT
			, Plus_CheckNumber NVARCHAR(50)
			, New_Confidential BIT
			, Plus_AcknowledgementInstructions NVARCHAR(MAX)
			, Plus_NewAccountInstructions NVARCHAR(MAX)
			, Plus_SpecialGiftInstructions NVARCHAR(MAX)
			, Plus_TelefundRep UNIQUEIDENTIFIER
			, New_BalanceDue_Base MONEY
			, New_TotalPaid_Base MONEY
			, New_PaymentsToMake INT
			, New_PaymentsReceived INT
			, Plus_PlannedGivingPaymentFrequency INT
			, New_InstallmentAmount_Base MONEY
			, Plus_InstallmentDate DATETIME
			, New_Bookable BIT
			, Plus_MatchExpected BIT
			, Plus_ParentGift UNIQUEIDENTIFIER
			, OwnerId UNIQUEIDENTIFIER
			, Plus_GiftRevocability INT
			, Plus_RemainderBeneficiary INT
			, Plus_FairMarketValue_Base MONEY
			, Plus_PresentValue_Base MONEY
			, New_SignatureDate DATETIME
			, New_Documentation BIT
			, New_NotificationDate DATETIME
			, Plus_FundingDate DATETIME
			, Plus_EstimatedMaturityDate DATETIME
			, Plus_Designation NVARCHAR(MAX)
			, Plus_NameOfTrust NVARCHAR(200)
			, plus_PlannedGivingType INT
			, Plus_VehicleType INT
			, Plus_VehicleSubType INT
			, Plus_PayoutRate DECIMAL
			, Plus_PaymentAmount_Base MONEY
			, Plus_AnnualAmount_Base MONEY
			, Plus_Duration INT
			, Plus_LivesType INT
			, Plus_Years INT
			, Plus_Lives DECIMAL
			, Plus_TermBeneficiaryLives DECIMAL
			, Plus_TermBeneficiaryYears INT
			, Plus_Cri DECIMAL
			, Plus_PaymentStartDate DATETIME
			, Plus_GpsNotes NVARCHAR(MAX)
			, Plus_Appeal UNIQUEIDENTIFIER
			, New_FundAccount UNIQUEIDENTIFIER
			, New_InstitutionalHierarchy UNIQUEIDENTIFIER
			, New_ConstituentDonor UNIQUEIDENTIFIER
			, New_OrganizationDonor UNIQUEIDENTIFIER
			, New_Opportunity UNIQUEIDENTIFIER
			, New_BalanceDue  MONEY
			, New_InstallmentAmount MONEY
			, New_TotalPaid MONEY
			, Plus_RecurringGiftRules UNIQUEIDENTIFIER
			, New_PledgeNumber NVARCHAR(100)
			, StatusCode INT
			, Lds_ExpectancyType INT
			' -- Create_Fields
		, 'New_PledgeId
			, New_TotalPledged
			, New_BeginDate
			, New_EndDate
			, Plus_Kind
			, Plus_TenderType
			, Plus_GiftSource
			, Plus_PlannedGift
			, Plus_CheckNumber
			, New_Confidential
			, Plus_AcknowledgementInstructions
			, Plus_NewAccountInstructions
			, Plus_SpecialGiftInstructions
			, Plus_TelefundRep
			, New_BalanceDue_Base
			, New_TotalPaid_Base
			, New_PaymentsToMake
			, New_PaymentsReceived
			, Plus_PlannedGivingPaymentFrequency
			, New_InstallmentAmount_Base
			, Plus_InstallmentDate
			, New_Bookable
			, Plus_MatchExpected
			, Plus_ParentGift
			, OwnerId
			, Plus_GiftRevocability
			, Plus_RemainderBeneficiary
			, Plus_FairMarketValue_Base
			, Plus_PresentValue_Base
			, New_SignatureDate
			, New_Documentation
			, New_NotificationDate
			, Plus_FundingDate
			, Plus_EstimatedMaturityDate
			, Plus_Designation
			, Plus_NameOfTrust
			, plus_PlannedGivingType
			, Plus_VehicleType
			, Plus_VehicleSubType
			, Plus_PayoutRate
			, Plus_PaymentAmount_Base
			, Plus_AnnualAmount_Base
			, Plus_Duration
			, Plus_LivesType
			, Plus_Years
			, Plus_Lives
			, Plus_TermBeneficiaryLives
			, Plus_TermBeneficiaryYears
			, Plus_Cri
			, Plus_PaymentStartDate
			, Plus_GpsNotes
			, Plus_Appeal
			, New_FundAccount
			, New_InstitutionalHierarchy
			, New_ConstituentDonor
			, New_OrganizationDonor
			, New_Opportunity
			, New_BalanceDue
			, New_InstallmentAmount
			, New_TotalPaid
			, Plus_RecurringGiftRules
			, New_PledgeNumber
			, StatusCode
			, Lds_ExpectancyType
			' -- Insert_Fields
		, 'New_PledgeId
			, New_TotalPledged
			, CASE WHEN DATENAME(dy,A.New_BeginDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_BeginDate)
					ELSE DATEADD(hh,-7,A.New_BeginDate) END AS New_BeginDate
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, Plus_Kind
			, Plus_TenderType
			, Plus_GiftSource
			, Plus_PlannedGift
			, Plus_CheckNumber
			, New_Confidential
			, CONVERT(NVARCHAR(4000),Plus_AcknowledgementInstructions) AS Plus_AcknowledgementInstructions
			, CONVERT(NVARCHAR(4000),Plus_NewAccountInstructions) AS Plus_NewAccountInstructions
			, CONVERT(NVARCHAR(4000),Plus_SpecialGiftInstructions) AS Plus_SpecialGiftInstructions
			, Plus_TelefundRep
			, New_BalanceDue_Base
			, New_TotalPaid_Base
			, New_PaymentsToMake
			, New_PaymentsReceived
			, Plus_PlannedGivingPaymentFrequency
			, New_InstallmentAmount_Base
			, CASE WHEN DATENAME(dy,A.Plus_InstallmentDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_InstallmentDate)
					ELSE DATEADD(hh,-7,A.Plus_InstallmentDate) END AS Plus_InstallmentDate
			, New_Bookable
			, Plus_MatchExpected
			, Plus_ParentGift
			, OwnerId
			, Plus_GiftRevocability
			, Plus_RemainderBeneficiary
			, Plus_FairMarketValue_Base
			, Plus_PresentValue_Base
			, CASE WHEN DATENAME(dy,A.New_SignatureDate) BETWEEN E.Mdt_Begin_Date_Number AND E.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_SignatureDate)
					ELSE DATEADD(hh,-7,A.New_SignatureDate) END AS New_SignatureDate
			, New_Documentation
			, CASE WHEN DATENAME(dy,A.New_NotificationDate) BETWEEN F.Mdt_Begin_Date_Number AND F.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_NotificationDate)
					ELSE DATEADD(hh,-7,A.New_NotificationDate) END AS New_NotificationDate
			, CASE WHEN DATENAME(dy,A.Plus_FundingDate) BETWEEN G.Mdt_Begin_Date_Number AND G.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_FundingDate)
					ELSE DATEADD(hh,-7,A.Plus_FundingDate) END AS Plus_FundingDate
			, CASE WHEN DATENAME(dy,A.Plus_EstimatedMaturityDate) BETWEEN H.Mdt_Begin_Date_Number AND H.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EstimatedMaturityDate)
					ELSE DATEADD(hh,-7,A.Plus_EstimatedMaturityDate) END AS Plus_EstimatedMaturityDate
			, CONVERT(NVARCHAR(4000),Plus_Designation) AS Plus_Designation
			, Plus_NameOfTrust
			, plus_PlannedGivingType
			, Plus_VehicleType
			, Plus_VehicleSubType
			, Plus_PayoutRate
			, Plus_PaymentAmount_Base
			, Plus_AnnualAmount_Base
			, Plus_Duration
			, Plus_LivesType
			, Plus_Years
			, Plus_Lives
			, Plus_TermBeneficiaryLives
			, Plus_TermBeneficiaryYears
			, Plus_Cri
			, CASE WHEN DATENAME(dy,A.Plus_PaymentStartDate) BETWEEN I.Mdt_Begin_Date_Number AND I.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PaymentStartDate)
					ELSE DATEADD(hh,-7,A.Plus_PaymentStartDate) END AS Plus_PaymentStartDate
			, CONVERT(NVARCHAR(4000),Plus_GpsNotes) AS Plus_GpsNotes
			, Plus_Appeal
			, New_FundAccount
			, New_InstitutionalHierarchy
			, New_ConstituentDonor
			, New_OrganizationDonor
			, New_Opportunity
			, New_BalanceDue
			, New_InstallmentAmount
			, New_TotalPaid
			, Plus_RecurringGiftRules
			, New_PledgeNumber
			, StatusCode
			, Lds_ExpectancyType
			' -- Select_Statement
		, 'New_PledgeBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_BeginDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_EndDate) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.Plus_InstallmentDate) = D.Date_Year
				LEFT JOIN _MDT_Conversion_Dim E ON YEAR(A.New_SignatureDate) = E.Date_Year
				LEFT JOIN _MDT_Conversion_Dim F ON YEAR(A.New_NotificationDate) = F.Date_Year
				LEFT JOIN _MDT_Conversion_Dim G ON YEAR(A.Plus_FundingDate) = G.Date_Year
				LEFT JOIN _MDT_Conversion_Dim H ON YEAR(A.Plus_EstimatedMaturityDate) = H.Date_Year
				LEFT JOIN _MDT_Conversion_Dim I ON YEAR(A.Plus_PaymentStartDate) = I.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- POSTALCODE (Ext_Postal)
-- --------------------------
	('dbo.New_PostalCodeBase' -- Source_Table
		, 'Oa_Extract.Ext_Postal' -- Destination_Table
		, 'New_PostalcodeId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_PostalcodeId
			, New_Name
			' -- Insert_Fields
		, 'New_PostalcodeId
			, New_Name
			' -- Select_Statement
		, 'New_PostalCodeBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- PROFESSIONALSUFFIX (Ext_Professional_Suffix)
-- --------------------------
	('dbo.New_ProfessionalSuffixBase' -- Source_Table
		, 'Oa_Extract.Ext_Professional_Suffix' -- Destination_Table
		, 'New_ProfessionalSuffixId UNIQUEIDENTIFIER
			,New_ProfessionalSuffix NVARCHAR(100)
			' -- Create_Fields
		, 'New_ProfessionalSuffixId
			,New_ProfessionalSuffix
			' -- Insert_Fields
		, 'New_ProfessionalSuffixId
			,New_ProfessionalSuffix
			' -- Select_Statement
		, 'New_ProfessionalSuffixBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- PSA (Ext_Psa)
-- --------------------------
	('dbo.Plus_LegacyPsaCodeBase' -- Source_Table
		, 'Oa_Extract.Ext_Psa' -- Destination_Table
		, 'ContactId UNIQUEIDENTIFIER
			, Psa_Key UNIQUEIDENTIFIER
			, Psa_Code NVARCHAR(50)
			, Psa_Eff_From DATETIME
			, Psa_Eff_Thru DATETIME
			, Psa_Act_Src NVARCHAR(100)
			, Psa_Entered_Dt DATETIME
			, Psa_Change_Dt DATETIME
			, Psa_Type NVARCHAR(100)
			, Psa_Text_Line NVARCHAR(500)
			' -- Create_Fields
		, 'ContactId
			, Psa_Key
			, Psa_Code
			, Psa_Eff_From
			, Psa_Eff_Thru
			, Psa_Act_Src
			, Psa_Entered_Dt
			, Psa_Change_Dt
			, Psa_Type
			, Psa_Text_Line
			' -- Insert_Fields
		, 'DISTINCT Plus_Constituent AS ContactId 
			, Plus_LegacyPsaCodeId AS Psa_Key
			, CONVERT(NVARCHAR(50),Plus_PsaCode) AS Psa_Code
			, CASE WHEN DATENAME(dy,A.Plus_EffectiveFrom) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EffectiveFrom)
					ELSE DATEADD(hh,-7,A.Plus_EffectiveFrom) END AS Psa_Eff_From
			, CASE WHEN DATENAME(dy,A.Plus_EffectiveTo) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EffectiveTo)
					ELSE DATEADD(hh,-7,A.Plus_EffectiveTo) END AS Psa_Eff_Thru
			, Plus_Source AS Psa_Act_Src
			, CASE WHEN DATENAME(dy,A.CreatedOn) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.CreatedOn)
					ELSE DATEADD(hh,-7,A.CreatedOn) END AS Psa_Entered_Dt
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN E.Mdt_Begin_Date_Number AND E.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS Psa_Change_Dt
			, Plus_Category AS Psa_Type
			, CONVERT(NVARCHAR(500),Plus_CodeDescription) AS Psa_Text_Line
			' -- Select_Statement
		, 'Plus_LegacyPsaCodeBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_EffectiveFrom) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_EffectiveTo) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.CreatedOn) = D.Date_Year
				LEFT JOIN _MDT_Conversion_Dim E ON YEAR(A.ModifiedOn) = E.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- RECOGNITION (Ext_Recognition)
-- --------------------------
	('dbo.New_RecognitionBase' -- Source_Table
		, 'Oa_Extract.Ext_Recognition' -- Destination_Table
		, 'New_RecognitionId UNIQUEIDENTIFIER
			, StateCode INT
			, StatusCode INT
			, New_EndDate DATETIME
			, New_ShortName NVARCHAR(100)
			, New_InstitutionId UNIQUEIDENTIFIER
			, New_Description NVARCHAR(500)
			, New_Affiliate INT
			, New_AssociationId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, New_StartDate DATETIME
			, New_Type INT
			' -- Create_Fields
		, 'New_RecognitionId
			, StateCode
			, StatusCode
			, New_EndDate
			, New_ShortName
			, New_InstitutionId
			, New_Description
			, New_Affiliate
			, New_AssociationId
			, New_Name
			, New_StartDate
			, New_Type
			' -- Insert_Fields
		, 'New_RecognitionId
			, StateCode
			, StatusCode
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, New_ShortName
			, New_InstitutionId
			, CONVERT(NVARCHAR(500),New_Description) AS New_Description			
			, New_Affiliate
			, New_AssociationId
			, New_Name
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, New_Type
			' -- Select_Statement
		, 'New_RecognitionBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_EndDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_StartDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- RECOGNITION CREDIT (Ext_Recognition_Credit)
-- --------------------------
	('dbo.New_RecognitionCreditBase' -- Source_Table
		, 'Oa_Extract.Ext_Recognition_Credit' -- Destination_Table
		, 'New_RecognitionCreditId UNIQUEIDENTIFIER
			, New_RelatedConstituent UNIQUEIDENTIFIER
			, New_OrganizationId UNIQUEIDENTIFIER
			, New_RelatedGift UNIQUEIDENTIFIER
			, New_CreditAmount MONEY
			, Plus_Type INT
			, Plus_OriginatingConstituent UNIQUEIDENTIFIER
			, Plus_SubType INT
			, New_ReceiptDate DATETIME
			, Plus_InstitutionalHieararchy UNIQUEIDENTIFIER
			, StatusCode INT
			' -- Create_Fields
		, 'New_RecognitionCreditId
			, New_RelatedConstituent
			, New_OrganizationId
			, New_RelatedGift
			, New_CreditAmount
			, Plus_Type
			, Plus_OriginatingConstituent
			, Plus_SubType
			, New_ReceiptDate
			, Plus_InstitutionalHieararchy
			, StatusCode
			' -- Insert_Fields
		, 'New_RecognitionCreditId
			, New_RelatedConstituent
			, New_OrganizationId
			, New_RelatedGift
			, New_CreditAmount
			, Plus_Type
			, Plus_OriginatingConstituent
			, Plus_SubType
			, CASE WHEN DATENAME(dy,A.New_ReceiptDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_ReceiptDate)
					ELSE DATEADD(hh,-7,A.New_ReceiptDate) END AS New_ReceiptDate
			, Plus_InstitutionalHieararchy
			, StatusCode
			' -- Select_Statement
		, 'New_RecognitionCreditBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_ReceiptDate) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL	
	)	
	,
-- --------------------------
-- Source (Ext_Source)
-- --------------------------
	('dbo.New_SourceBase' -- Source_Table
		, 'Oa_Extract.Ext_Source' -- Destination_Table
		, 'New_SourceId UNIQUEIDENTIFIER
			, New_Source NVARCHAR(100)
			, New_LongDescription NVARCHAR(100)
			' -- Create_Fields
		, 'New_SourceId
			, New_Source
			, New_LongDescription
			' -- Insert_Fields
		, 'New_SourceId
			, New_Source
			, New_LongDescription
			' -- Select_Statement
		, 'New_SourceBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- STATE (Ext_State)
-- --------------------------
	('dbo.New_StateBase' -- Source_Table
		, 'Oa_Extract.Ext_State' -- Destination_Table
		, 'New_StateId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, Plus_Abbreviation NVARCHAR(50)
			' -- Create_Fields
		, 'New_StateId
			, New_Name
			, Plus_Abbreviation
			' -- Insert_Fields
		, 'New_StateId
			, New_Name
			, Plus_Abbreviation
			' -- Select_Statement
		, 'New_StateBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Student (Ext_Student)
-- --------------------------
	('dbo.New_StudentAttendanceBase' -- Source_Table
		, 'Oa_Extract.Ext_Student' -- Destination_Table
		, 'New_StudentAttendanceId UNIQUEIDENTIFIER
			, New_Term NVARCHAR(100)
			, New_Year NVARCHAR(100)
			, New_HoursCompleted INT
			, New_ExpectedGraduationDate DATETIME
			, Plus_Year NVARCHAR(10)
			, New_StudentsAttendanceId UNIQUEIDENTIFIER
			, New_Source UNIQUEIDENTIFIER
			, New_College UNIQUEIDENTIFIER
			, New_University UNIQUEIDENTIFIER
			, New_Major UNIQUEIDENTIFIER
			, Plus_Emphasis UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_StudentAttendanceId
			, New_Term
			, New_Year
			, New_HoursCompleted
			, New_ExpectedGraduationDate
			, Plus_Year
			, New_StudentsAttendanceId
			, New_Source
			, New_College
			, New_University
			, New_Major
			, Plus_Emphasis
			' -- Insert_Fields
		, 'New_StudentAttendanceId
			, New_Term
			, New_Year
			, New_HoursCompleted
			, CASE WHEN DATENAME(dy,A.New_ExpectedGraduationDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_ExpectedGraduationDate)
					ELSE DATEADD(hh,-7,A.New_ExpectedGraduationDate) END AS New_ExpectedGraduationDate
			, Plus_Year
			, New_StudentsAttendanceId
			, New_Source
			, New_College
			, New_University
			, New_Major
			, Plus_Emphasis
			' -- Select_Statement
		, 'New_StudentAttendanceBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_ExpectedGraduationDate) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- TITLE (Ext_Title)
-- --------------------------
	('dbo.New_TitleBase' -- Source_Table
		, 'Oa_Extract.Ext_Title' -- Destination_Table
		, 'New_TitleId UNIQUEIDENTIFIER
			, New_Title NVARCHAR(100)
			' -- Create_Fields
		, 'New_TitleId
			, New_Title
			' -- Insert_Fields
		, 'New_TitleId
			, New_Title
			' -- Select_Statement
		, 'New_TitleBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- University (Ext_University)
-- --------------------------
	('dbo.New_UniversityBase' -- Source_Table
		, 'Oa_Extract.Ext_University' -- Destination_Table
		, 'New_UniversityId UNIQUEIDENTIFIER
			, New_University NVARCHAR(100)
			, New_UniversityCode NVARCHAR(10)
			, Plus_UniversityAcronym NVARCHAR(100)
			' -- Create_Fields
		, 'New_UniversityId
			, New_University
			, New_UniversityCode
			, Plus_UniversityAcronym
			' -- Insert_Fields
		, 'New_UniversityId
			, New_University
			, New_UniversityCode
			, Plus_UniversityAcronym
			' -- Select_Statement
		, 'New_UniversityBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- USER (Ext_System_User)
-- --------------------------
	('dbo.SystemUserBase' -- Source_Table
		, 'Oa_Extract.Ext_System_User' -- Destination_Table
		, 'SystemUserId UNIQUEIDENTIFIER
			, FullName NVARCHAR(200)
			, FirstName NVARCHAR(64)
			, LastName NVARCHAR(64)
			, PersonalEmailAddress NVARCHAR(100)
			, Title NVARCHAR(128)
			, InternalEmailAddress NVARCHAR(100)
			, MobilePhone NVARCHAR(64)
			, DomainName NVARCHAR(1024)
			' -- Create_Fields
		, 'SystemUserId
			, FullName
			, FirstName
			, LastName
			, PersonalEmailAddress
			, Title
			, InternalEmailAddress
			, MobilePhone
			, DomainName
			' -- Insert_Fields
		, 'SystemUserId
			, FullName
			, FirstName
			, LastName
			, PersonalEmailAddress
			, Title
			, InternalEmailAddress
			, MobilePhone
			, DomainName
			' -- Select_Statement
		, 'SystemUserBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)	
	,	
-- --------------------------
-- STRING_MAP (Ext_String_Map)
-- --------------------------
	('dbo.StringMapBase' -- Source_Table
		, 'Oa_Extract.Ext_String_Map' -- Destination_Table
		, 'ObjectTypeCode INT
			, AttributeName NVARCHAR(100)
			, AttributeValue INT
			, LangId INT
			, OrganizationId UNIQUEIDENTIFIER
			, Value NVARCHAR(4000)
			, DisplayOrder INT
			, StringMapId UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'ObjectTypeCode
			, AttributeName
			, AttributeValue
			, LangId
			, OrganizationId
			, Value
			, DisplayOrder
			, StringMapId
			' -- Insert_Fields
		, 'ObjectTypeCode
			, AttributeName
			, AttributeValue
			, LangId
			, OrganizationId
			, Value
			, DisplayOrder
			, StringMapId
			' -- Select_Statement
		, 'dbo.StringMapBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- Entity (Ext_Entity)
-- --------------------------
	('dbo.Entity' -- Source_Table
		, 'Oa_Extract.Ext_Entity' -- Destination_Table
		, 'ObjectTypeCode INT
			, PhysicalName NVARCHAR(64)
			, EntityId UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'ObjectTypeCode
			, PhysicalName
			, EntityId
			' -- Insert_Fields
		, 'ObjectTypeCode
			, PhysicalName
			, EntityId
			' -- Select_Statement
		, 'Entity
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Plus_LegacyM11Base (Ext_Plus_LegacyM11Base)
-- --------------------------
	('dbo.Plus_LegacyM11Base' -- Source_Table
		, 'Oa_Extract.Ext_Plus_LegacyM11Base' -- Destination_Table
		, 'ActivityId UNIQUEIDENTIFIER
			, Plus_Source UNIQUEIDENTIFIER
			, Plus_M11ActivityType INT
			, Plus_M11MessageType INT
			' -- Create_Fields
		, 'ActivityId
			, Plus_Source
			, Plus_M11ActivityType
			, Plus_M11MessageType
			' -- Insert_Fields
		, 'ActivityId
			, Plus_Source
			, Plus_M11ActivityType
			, Plus_M11MessageType
			' -- Select_Statement
		, 'Plus_LegacyM11Base
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Batch (Ext_Batch)
-- --------------------------
	('dbo.New_BatchesBase' -- Source_Table
		, 'Oa_Extract.Ext_Batch' -- Destination_Table
		, 'New_BatchesId UNIQUEIDENTIFIER
			, New_BatchNumber NVARCHAR(100)
			, Lds_BatchType INT
			' -- Create_Fields
		, 'New_BatchesId
			, New_BatchNumber
			, Lds_BatchType
			' -- Insert_Fields
		, 'New_BatchesId
			, New_BatchNumber
			, Lds_BatchType
			' -- Select_Statement
		, 'New_BatchesBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- Gift_Hist (Ext_Gift_Hist)
-- --------------------------
	('dbo.New_GiftHistoryBase' -- Source_Table
		, 'Oa_Extract.Ext_Gift_Hist' -- Destination_Table
		, 'New_RelatedGift UNIQUEIDENTIFIER
			, Plus_Constituent UNIQUEIDENTIFIER
			, Plus_Organization UNIQUEIDENTIFIER
			, Plus_FundAccount UNIQUEIDENTIFIER
			, OwnerId UNIQUEIDENTIFIER
			, Plus_AccountingDate DATETIME
			, StatusCode INT
			, New_Amount MONEY
			, New_ReceiptDate DATETIME
			, New_TenderType INT
			, Plus_Kind INT
			, Plus_Transmitted BIT
			, Plus_Description NVARCHAR(4000)
			, Plus_ReceiptText NVARCHAR(4000)
			, New_Name NVARCHAR(100)
			, Plus_GiftAdjustmentNote NVARCHAR(4000)
			, New_GiftHistoryId UNIQUEIDENTIFIER
			, Plus_GiftNumber NVARCHAR(50)
			, Plus_PostDate DATETIME
			' -- Create_Fields
		, 'New_RelatedGift
			, Plus_Constituent
			, Plus_Organization
			, Plus_FundAccount
			, OwnerId
			, Plus_AccountingDate
			, StatusCode
			, New_Amount
			, New_ReceiptDate
			, New_TenderType
			, Plus_Kind
			, Plus_Transmitted
			, Plus_Description
			, Plus_ReceiptText
			, New_Name
			, Plus_GiftAdjustmentNote
			, New_GiftHistoryId
			, Plus_GiftNumber
			, Plus_PostDate
			' -- Insert_Fields
		, 'New_RelatedGift
			, Plus_Constituent
			, Plus_Organization
			, Plus_FundAccount
			, OwnerId
			, CASE WHEN DATENAME(dy,A.Plus_AccountingDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_AccountingDate)
					ELSE DATEADD(hh,-7,A.Plus_AccountingDate) END AS Plus_AccountingDate
			, StatusCode
			, New_Amount
			, CASE WHEN DATENAME(dy,A.New_ReceiptDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_ReceiptDate)
					ELSE DATEADD(hh,-7,A.New_ReceiptDate) END AS New_ReceiptDate
			, New_TenderType
			, Plus_Kind
			, Plus_Transmitted
			, CONVERT(NVARCHAR(4000),Plus_Description) AS Plus_Description
			, CONVERT(NVARCHAR(4000),Plus_ReceiptText) AS Plus_ReceiptText
			, New_Name
			, CONVERT(NVARCHAR(4000),Plus_GiftAdjustmentNote) AS Plus_GiftAdjustmentNote
			, New_GiftHistoryId
			, Plus_GiftNumber
			, CASE WHEN DATENAME(dy,A.Plus_PostDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PostDate)
					ELSE DATEADD(hh,-7,A.Plus_PostDate) END AS Plus_PostDate
			' -- Select_Statement
		, 'New_GiftHistoryBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_AccountingDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_ReceiptDate) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.Plus_PostDate) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Plus_RecurringGiftRules (Ext_Recurring_Gift_Rules)
-- --------------------------
	('dbo.Plus_RecurringGiftRulesBase' -- Source_Table
		, 'Oa_Extract.Ext_Recurring_Gift_Rules' -- Destination_Table
		, 'Plus_RecurringGiftRulesId UNIQUEIDENTIFIER
			, Plus_Constituent UNIQUEIDENTIFIER
			, Plus_FundAccount UNIQUEIDENTIFIER
			, Plus_InstitutionalHiearchy UNIQUEIDENTIFIER
			, Plus_CampaignAppeal UNIQUEIDENTIFIER
			, StatusCode INT
			, StateCode INT
			, Plus_Frequency INT
			, Plus_PaymentStart DATETIME
			, Plus_PaymentStop DATETIME
			, Plus_Amount MONEY
			, Plus_Group UNIQUEIDENTIFIER
			, Plus_Type INT
			, Plus_Organization UNIQUEIDENTIFIER
			, CreatedOn DATETIME
			' -- Create_Fields
		, 'Plus_RecurringGiftRulesId
			, Plus_Constituent
			, Plus_FundAccount
			, Plus_InstitutionalHiearchy
			, Plus_CampaignAppeal
			, StatusCode
			, StateCode
			, Plus_Frequency
			, Plus_PaymentStart
			, Plus_PaymentStop
			, Plus_Amount
			, Plus_Group
			, Plus_Type
			, Plus_Organization
			, CreatedOn
			' -- Insert_Fields
		, 'Plus_RecurringGiftRulesId
			, Plus_Constituent
			, Plus_FundAccount
			, Plus_InstitutionalHiearchy
			, Plus_CampaignAppeal
			, StatusCode
			, StateCode
			, Plus_Frequency
			, CASE WHEN DATENAME(dy,A.Plus_PaymentStart) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PaymentStart)
					ELSE DATEADD(hh,-7,A.Plus_PaymentStart) END AS Plus_PaymentStart
			, CASE WHEN DATENAME(dy,A.Plus_PaymentStop) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PaymentStop)
					ELSE DATEADD(hh,-7,A.Plus_PaymentStop) END AS Plus_PaymentStop 
			, Plus_Amount
			, Plus_Group
			, Plus_Type
			, Plus_Organization
			, CASE WHEN DATENAME(dy,A.CreatedOn) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.CreatedOn)
					ELSE DATEADD(hh,-7,A.CreatedOn) END AS CreatedOn
			' -- Select_Statement
		, 'Plus_RecurringGiftRulesBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_PaymentStart) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_PaymentStop) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.CreatedOn) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- CampaignResponseBase (Ext_Campaign_Response)
-- --------------------------
	('dbo.CampaignResponseBase' -- Source_Table
		, 'Oa_Extract.Ext_Campaign_Response' -- Destination_Table
		, 'ActivityId UNIQUEIDENTIFIER
			, Plus_CampaignAppeal UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'ActivityId
			, Plus_CampaignAppeal
			' -- Insert_Fields
		, 'ActivityId
			, Plus_CampaignAppeal
			' -- Select_Statement
		, 'CampaignResponseBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Plus_PayrollGroupBase (Ext_Payroll_Group)
-- --------------------------
	('dbo.Plus_PayrollGroupBase' -- Source_Table
		, 'Oa_Extract.Ext_Payroll_Group' -- Destination_Table
		, 'Plus_PayrollGroupId UNIQUEIDENTIFIER
			, Plus_Name NVARCHAR(100)
			, Plus_Code NVARCHAR(100)
			' -- Create_Fields
		, 'Plus_PayrollGroupId
			, Plus_Name
			, Plus_Code
			' -- Insert_Fields
		, 'Plus_PayrollGroupId
			, Plus_Name
			, Plus_Code
			' -- Select_Statement
		, 'Plus_PayrollGroupBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, ' ' -- Code_Block_1
		, ' ' -- Code_Block_2
		, ' ' -- Code_Block_3
		, ' ' -- Code_Block_4
		, ' ' -- Code_Block_5
		, ' ' -- Code_Block_6
		, ' ' -- Code_Block_7
		, ' ' -- Code_Block_8
		, ' ' -- Code_Block_9
		, ' ' -- Code_Block_10
		, ' ' -- Code_Block_11
		, ' ' -- Code_Block_12
		, ' ' -- Code_Block_13
		, ' ' -- Code_Block_14
		, ' ' -- Code_Block_15
		, ' ' -- Code_Block_16
		, ' ' -- Code_Block_17
		, ' ' -- Code_Block_18
		, ' ' -- Code_Block_19
		, ' ' -- Code_Block_20
		, 1
		, GETDATE()
		, NULL
	)	
	;



	