USE [NewDB]
GO
/****** Object:  StoredProcedure [smartone].[p_customer_createUpdateFromAPI]    Script Date: 22/12/2022 8:09:17 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [smartone].[p_customer_createUpdateFromAPI]
(
	@pkey nvarchar(50)  = NULL,
	@Response nvarchar(max)  = NULL,
	@resultCode int = 0 OUTPUT,
	@errMsg nvarchar(4000) = '' OUTPUT)
AS
/*
DATE: 20220823
MODIFY BY : DECO
DESC : INIT



DECLARE @JSON NVARCHAR(MAX)
--SET @JSON = '{"AcctList":[{"acctNum":"85201234.00001","custId":"10-212TZ","custNum":"85201234","fullName":"Chan Tai Man","fullNameChi":"Chan Tai Man","subrOffDate":"2022-08-15","subrStatus":"TX","title":"Mr"},{"acctNum":"85201200.00001","custId":"10-212TY","custNum":"85201200","fullName":"Chan Siu Man","fullNameChi":"Chan Siu Man","subrOffDate":"","subrStatus":"PE","title":"Ms"}],"IRContent":"","SRContent":"","adjComplete":0,"adjOS":2,"billDay":"5","ccsExpiry":"2022-07-15","ccsReasonType":"Other","cfbComplete":3,"cfbOS":1,"contact30d":3,"contact7d":1,"contactCurr":0,"custID":"10-212UY","custNum":"8500120","custType":"LoginNow (Owner)","email":"xxxxxxxxxxxxxx","fullName":"xxxxxxxxxxxxxx","fullNameChi":"xxxxxxxxxxxxxx","hasDataRoam":"Y","hasIR":"N","hasInterimBill":"Y","hasSR":"N","idPend":0,"ld6mth":1,"ldBilled":2,"ldOver6mth":0,"loginNowID":12345,"loginNowStatus":"Y","loginNowUser":"","osBalance":0.2,"plan":"Z5GAA ","planAmt":458,"planDesc":"5G SIM Only Plan ","planDescChi":"5G SIM Only Plan ","resultCode":"0","resultMsg":"SUCCESS","retentionCycle":"2022-07-01","subrList":[{"custNo":"8500120","subrNo":"91234567 "},{"custNo":"8500120","subrNo":"91234568 "}],"subrNum":"91234567","subrStatus":"OK","telesalesOptin":"Y"}'
--SET @JSON = '{"AcctList":[{"acctNum":"85201234.00001","custId":"10-212TZ","custNum":"85201234","fullName":"Chan Tai Man","fullNameChi":"Chan Tai Man","subrOffDate":"2022-08-15","subrStatus":"TX","title":"Mr"},{"acctNum":"85201200.00001","custId":"10-212UY","custNum":"85201200","fullName":"Chan Siu Man","fullNameChi":"Chan Siu Man","subrOffDate":"","subrStatus":"PE","title":"Ms"}],"IRContent":"","SRContent":"","adjComplete":0,"adjOS":2,"billDay":"5","ccsExpiry":"2022-07-15","ccsReasonType":"Other","cfbComplete":3,"cfbOS":1,"contact30d":3,"contact7d":1,"contactCurr":0,"custID":"10-212UY","custNum":"8500120","custType":"LoginNow (Owner)","email":"xxxxxxxxxxxxxx","fullName":"xxxxxxxxxxxxxx","fullNameChi":"xxxxxxxxxxxxxx","hasDataRoam":"Y","hasIR":"N","hasInterimBill":"Y","hasSR":"N","idPend":0,"ld6mth":1,"ldBilled":2,"ldOver6mth":0,"loginNowID":12345,"loginNowStatus":"Y","loginNowUser":"","osBalance":0.2,"plan":"Z5GAA ","planAmt":458,"planDesc":"5G SIM Only Plan ","planDescChi":"5G SIM Only Plan ","resultCode":"0","resultMsg":"SUCCESS","retentionCycle":"2022-07-01","subrList":[{"custNo":"8500120","subrNo":"98672063"},{"custNo":"8500120","subrNo":"98672063"}],"subrNum":"98672063","subrStatus":"OK","telesalesOptin":"Y"}'
--SET @JSON = '{"AcctList":[{"acctNum":"85201234.00001","custId":"10-212TZ","custNum":"85201234","fullName":"Chan Tai Man","fullNameChi":"Chan Tai Man","subrOffDate":"2022-08-15","subrStatus":"TX","title":"Mr"},{"acctNum":"85201200.00001","custId":"10-212UY","custNum":"85201200","fullName":"Chan Siu Man","fullNameChi":"Chan Siu Man","subrOffDate":"","subrStatus":"PE","title":"Ms"}],"IRContent":"","SRContent":"","adjComplete":0,"adjOS":2,"billDay":"5","ccsExpiry":"2022-07-15","ccsReasonType":"Other","cfbComplete":3,"cfbOS":1,"contact30d":3,"contact7d":1,"contactCurr":0,"custID":"10-212UY","custNum":"8500120","custType":"LoginNow (Owner)","email":"xxxxxxxxxxxxxx","fullName":"xxxxxxxxxxxxxx","fullNameChi":"xxxxxxxxxxxxxx","hasDataRoam":"Y","hasIR":"N","hasInterimBill":"Y","hasSR":"N","idPend":0,"ld6mth":1,"ldBilled":2,"ldOver6mth":0,"loginNowID":12345,"loginNowStatus":"Y","loginNowUser":"","osBalance":0.2,"plan":"Z5GAA ","planAmt":458,"planDesc":"5G SIM Only Plan ","planDescChi":"5G SIM Only Plan ","resultCode":"0","resultMsg":"SUCCESS","retentionCycle":"2022-07-01","subrList":[{"custNo":"8500120","subrNo":"13434234"},{"custNo":"8500120","subrNo":"23434234"}],"subrNum":"33434234","subrStatus":"OK","telesalesOptin":"Y"}'
SET @JSON = '{"AcctList":[{"acctNum":"85201234.00001","custId":"10-212TZ","fullName":"Chan Tai Man","fullNameChi":"Chan Tai Man","subrOffDate":"2022-08-15","subrStatus":"TX","title":"Mr"},{"acctNum":"85201200.00001","custId":"10-212UY","fullName":"Chan Siu Man","fullNameChi":"Chan Siu Man","subrOffDate":"","subrStatus":"PE","title":"Ms"}],"IRContent":"","SRContent":"","adjComplete":0,"adjOS":2,"billDay":"5","ccsExpiry":"2022-07-15","ccsReasonType":"Other","cfbComplete":3,"cfbOS":1,"contact30d":3,"contact7d":1,"contactCurr":0,"custID":"10-212UY","custNum":"8500120","custType":"LoginNow (Owner)","email":"Name 04:48:21.293","fullName":"Name 04:48:21.293","fullNameChi":"Name 04:48:21.293","hasDataRoam":"Y","hasIR":"N","hasInterimBill":"Y","hasSR":"N","idPend":0,"ld6mth":1,"ldBilled":2,"ldOver6mth":0,"loginNowID":"98679999","loginNowStatus":"Y","loginNowUser":"","osBalance":0.2,"plan":"Z5GAA ","planAmt":458,"planDesc":"5G SIM Only Plan ","planDescChi":"5G SIM Only Plan ","resultCode":"0","resultMsg":"SUCCESS","retentionCycle":"2022-07-01","subrList":[{"custNo":"8500120","subrNo":"98679999"},{"custNo":"8500120","subrNo":"98679999"}],"subrNum":"98679999","subrStatus":"OK","telesalesOptin":"Y","userId":"gc_dev2"}'
	DECLARE @pkey NVARCHAR(50)
	DECLARE @Response nvarchar(max)
	DECLARE @resultCode int
	DECLARE @errMsg nvarchar(4000)

	SET @Response = @JSON
	SET @pkey = NULL
	EXEC [smartone].[p_customer_createUpdateFromAPI] @pkey,@Response,@resultCode OUTPUT,@errMsg OUTPUT
	SELECT @resultCode,@errMsg

	SELECT * FROM [ecca].[mdContactAccount] WHERE pkey = 'C22AA0003'
	--DELETE FROM [smartone].[mdCustomer]

	p_contactaccount_createContactAccount
	p_contactaccount_updateContactAccount
*/
BEGIN
BEGIN TRY
	SET NOCOUNT ON
	DECLARE @dbUser NVARCHAR(50) = SUSER_SNAME()
	SET @resultCode = 0
	DECLARE @pMethod NVARCHAR(10)
	DECLARE @pkey_response NVARCHAR(50)
	DECLARE @contactAccountType nvarchar(50)
	DECLARE @firstName nvarchar(50)
	DECLARE @lastName nvarchar(50)
	DECLARE @displayName nvarchar(100)
	DECLARE @chineseName nvarchar(100)
	DECLARE @phone1 nvarchar(50)
	DECLARE @phone2 nvarchar(50)
	DECLARE @phone3 nvarchar(50)
	DECLARE @email1 nvarchar(100)
	DECLARE @createUserCode nvarchar(50)
	DECLARE @latestUpdateUserCode nvarchar(50)
	DECLARE @subrList NVARCHAR(MAX)
	DECLARE @gender NVARCHAR(50)
	DECLARE @title NVARCHAR(50)
	DECLARE @salutation NVARCHAR(50)
	DECLARE @status NVARCHAR(50)
	DECLARE @loginNowID NVARCHAR(50)
	DECLARE @lockCounter INT
	DECLARE @pkey_original NVARCHAR(50)
	DECLARE @userId NVARCHAR(50)
	SET @userId = 'SYSTEM'


	DECLARE @TBL_Response_pkey TABLE
	(
		pkey NVARCHAR(50)
	)
	DECLARE @tbl_subrList TABLE
	(
		row_num INT,
		custNo NVARCHAR(50),
		subrNo NVARCHAR(50)
	)
	DECLARE @tbl_AcctList TABLE
	(
		acctNum NVARCHAR(40),
		custId NVARCHAR(40),
		custNum NVARCHAR(40),
		subrOffDate NVARCHAR(20),
		subrStatus NVARCHAR(4),
		title NVARCHAR(4)
	)
	--If pkey is equal null the means is new create account
	IF (UPPER(@pkey) = 'NULL' OR @pkey = '')
	BEGIN
		SET @pkey = NULL
	END
	
	--Insert phone no list to AccountList
	INSERT INTO @tbl_AcctList(acctNum,custId,custNum,subrOffDate,subrStatus,title)
	SELECT
		AcctList.acctNum,AcctList.custId,AcctList.custNum,AcctList.subrOffDate,AcctList.subrStatus,AcctList.title
	FROM OPENJSON (@Response)
	WITH ( AcctList NVARCHAR(max) AS JSON)
	AS Projects
	CROSS APPLY OPENJSON (Projects.AcctList)
	WITH (
		acctNum NVARCHAR(40),custId NVARCHAR(40),custNum NVARCHAR(40),
		subrOffDate NVARCHAR(20),subrStatus NVARCHAR(4),title NVARCHAR(4)
	) AS AcctList
	
	DECLARE @currentTime datetimeoffset = util.getlocaldate()
	--Record Log detail
	--Insert smartone response JSON raw data to table #TMP_DATA

	IF OBJECT_ID('tempdb..#TMP_DATA_CHECKING') IS NOT NULL DROP TABLE #TMP_DATA_CHECKING
	IF OBJECT_ID('tempdb..#TMP_DATA') IS NOT NULL DROP TABLE #TMP_DATA
	SELECT rData.* INTO #TMP_DATA FROM (
		SELECT  
			resultCode,
			resultMsg,
			fullName, fullNameChi, custType, billDay, osBalance, loginNowID, loginNowStatus, loginNowUser, custID, custNum, subrList, subrNum, 
            email, [plan], planDesc, planDescChi, planAmt, subrStatus, telesalesOptin, retentionCycle, hasDataRoam, hasIR, IRContent, hasSR, SRContent, 
            contactCurr, contactlst7d, contactlst30d, hasInterimBill, ccsExpiry, ccsReasonType, cfbOS, cfbComplete, adjOS, adjComplete, ldOver6mth, ld6mth, ldBilled, ldPend,userId
			FROM OPENJSON(@Response) 
		WITH (
			resultCode INT,
			resultMsg NVARCHAR(50),
			fullName  NVARCHAR(100),fullNameChi  NVARCHAR(100),custType  NVARCHAR(20),billDay   NVARCHAR(20),osBalance  NUMERIC(10,2) ,loginNowID  NVARCHAR(50),loginNowStatus NVARCHAR(3),
			loginNowUser NVARCHAR(50),custID   NVARCHAR(20),custNum   NVARCHAR(20),subrList  NVARCHAR(MAX),subrNum   NVARCHAR(20),email NVARCHAR(100),[plan] NVARCHAR(20),planDesc  NVARCHAR(2000),planDescChi  NVARCHAR(2000),
			planAmt   NVARCHAR(20),subrStatus  NVARCHAR(10),telesalesOptin NVARCHAR(3),retentionCycle NVARCHAR(20),
			hasDataRoam  NVARCHAR(3),hasIR   NVARCHAR(3),IRContent  NVARCHAR(500),hasSR   NVARCHAR(3),SRContent  NVARCHAR(500),contactCurr  INT,
			contactlst7d INT,contactlst30d INT,hasInterimBill NVARCHAR(3),ccsExpiry  NVARCHAR(20),ccsReasonType NVARCHAR(20),cfbOS  INT,cfbComplete INT,
			adjOS  INT,adjComplete INT,ldOver6mth INT,ld6mth  INT,ldBilled INT,ldPend  INT,userId NVARCHAR(50))) AS rData

	SET @userId = (SELECT Top 1 userId FROM #TMP_DATA)
	--if validate the data is normal
	IF (EXISTS(SELECT * FROM #TMP_DATA WHERE resultCode = 0 AND ISNUMERIC(subrNum) =1))
	BEGIN
		SET @loginNowID = (SELECT TOP 1 loginNowID FROM #TMP_DATA WHERE resultCode = 0 AND ISNUMERIC(subrNum) =1)

		INSERT INTO @tbl_subrList(row_num, custNo, subrNo)
		SELECT
			ROW_NUMBER() OVER (ORDER BY subrList.custNo ) row_num,
			RTRIM(subrList.custNo),
			RTRIM(subrList.subrNo)
		FROM OPENJSON (@Response)
		WITH ( subrList NVARCHAR(max) AS JSON)
		AS Projects
		CROSS APPLY OPENJSON (Projects.subrList)
		WITH (
			custNo NVARCHAR(100),
			subrNo NVARCHAR(100)
		) AS subrList

		--if pkey is not null than no need to verify the phone no/loginNowUserID checking
		IF (@pkey IS NOT NULL)
		BEGIN
			SET @pkey_original = (SELECT pkey FROM [smartone].mdCustomer WITH (NOLOCK) WHERE loginNowID = @loginNowID)
			--If loginNowID is equal or not inside mdCustomer
			IF (@pkey_original IS NULL OR @pkey_original = @pkey)
			BEGIN
				SET @pkey_response = @pkey
				SET @pMethod = 'UPD'
			END
			ELSE
			BEGIN
				--If loginNowID has found but pkey is not same with parameter pkey
				SET @pkey_response = @pkey_original
				PRINT 'If input parameter pkey is different with original pkey, after saved the customer detail record 
				will be reload by original pkey'
			END
		END
		ELSE
		BEGIN
			--Check Phone no is it existing in current contact account table
			;WITH cte1 AS
			(
				SELECT acc.* FROM [ecca].[mdContactAccount] acc WITH (NOLOCK)
				INNER JOIN @tbl_subrList c1 ON acc.phone1 = c1.subrNo AND acc.phone1 IS NOT NULL
			), cte2 AS
			(
				SELECT acc.* FROM [ecca].[mdContactAccount] acc WITH (NOLOCK)
				INNER JOIN @tbl_subrList c1 ON acc.phone2 = c1.subrNo AND acc.phone2 IS NOT NULL
			), cte3 AS
			(
				SELECT acc.* FROM [ecca].[mdContactAccount] acc WITH (NOLOCK)
				INNER JOIN @tbl_subrList c1 ON acc.phone3 = c1.subrNo AND acc.phone3 IS NOT NULL
			), cte4 AS
			(
				SELECT * FROM cte1
				UNION ALL 
				SELECT * FROM cte2
				UNION ALL 
				SELECT * FROM cte3
			)
			-- Phone no Comparison 
			SELECT * INTO #TMP_DATA_CHECKING FROM cte4

			SET @email1 = (SELECT TOP 1 UPPER(RTRIM(email)) AS email FROM #TMP_DATA)
			SET @displayName = (SELECT TOP 1 UPPER(REPLACE(RTRIM(fullName),' ','')) AS fullName FROM #TMP_DATA)
			IF (EXISTS(SELECT * FROM #TMP_DATA_CHECKING)) --if phone no has found
			BEGIN
				IF (EXISTS(SELECT * FROM #TMP_DATA_CHECKING c1
					INNER JOIN [smartone].mdCustomer c2 WITH (NOLOCK) ON c1.pkey = c2.pkey
					WHERE c2.workgroup != 'Birdie' AND c2.loginNowID = @loginNowID))
				BEGIN
					--Get the pkey
					SET @pkey_response = (SELECT TOP 1 pkey FROM [smartone].mdCustomer 
					WITH (NOLOCK) WHERE loginNowID = @loginNowID)
					SET @pMethod = 'UPD'
				END
				ELSE
				BEGIN
					IF (NOT EXISTS(SELECT * FROM #TMP_DATA_CHECKING c1
						INNER JOIN [smartone].mdCustomer c2 WITH (NOLOCK) ON c1.pkey = c2.pkey 
						WHERE c2.workgroup != 'Birdie'))
					BEGIN
						--anonymous contact detail
						SET @pkey_response = (SELECT TOP 1 c1.pkey FROM #TMP_DATA_CHECKING c1
							LEFT JOIN [smartone].mdCustomer c2 WITH (NOLOCK) ON c1.pkey = c2.pkey
							WHERE c2.pkey IS NULL AND c2.workgroup IS NULL)

						SET @pMethod = 'UPD'
					END
					ELSE
					BEGIN
						SET @pMethod = 'NEW'
					END
				END
			END
			ELSE
			BEGIN
				--if loginNowID
				IF (EXISTS(SELECT * FROM [smartone].[mdCustomer] WITH (NOLOCK) WHERE loginNowID = @loginNowID ))
				BEGIN
					SET @pkey_response = (SELECT TOP 1 pkey FROM [smartone].[mdCustomer] WITH (NOLOCK) WHERE loginNowID = @loginNowID)
					SET @pMethod = 'UPD'
				END
				ELSE
				BEGIN
					SET @pMethod = 'NEW'
				END
			END
		END

		--prepare the data for update/create
		SET @subrList = (SELECT * FROM @tbl_subrList FOR JSON AUTO);
		SELECT 
			@contactAccountType = custType,
			@firstName = fullName,
			@displayName = fullName,
			@chineseName = fullNameChi,
			@lastName = ''
		FROM #TMP_DATA

		SET @phone1 = (SELECT subrNo FROM @tbl_subrList WHERE row_num = 1)
		SET @phone2 = (SELECT subrNo FROM @tbl_subrList WHERE row_num = 2)
		SET @phone3 = (SELECT subrNo FROM @tbl_subrList WHERE row_num = 3)
		SET @status = 'Active'
		SET @title = (SELECT TOP 1 title FROM #TMP_DATA c1 INNER JOIN @tbl_AcctList c2 ON c1.custID = c2.custId)
		SET @salutation = @title
		SET @gender = (SELECT 
						CASE WHEN @title = 'Mr' THEN 'Male' ELSE 
						CASE WHEN @title = 'Ms' THEN 'Female'ELSE 'Unknown' END
					END)

		IF (@pMethod = 'UPD')
		BEGIN

			SET @lockCounter = (SELECT lockCounter FROM [ecca].[mdContactAccount] WITH (NOLOCK) WHERE pkey = @pkey_response) 
			PRINT 'UPDATE [mdContactAccount]'

			--Update Response
			INSERT INTO @TBL_Response_pkey(pkey)
			EXECUTE [ecca].[p_contactaccount_updateContactAccount]
				@pkey_response,
				@contactAccountType,@firstName,@lastName,@displayName,@chineseName,
				NULL,@gender,@salutation, @title,NULL,NULL,
				@phone1,@phone2,@phone3,
				NULL,NULL,NULL,
				NULL,NULL,NULL,
				NULL,'CUSTOMER',0,
				'Active',
				@lockCounter,@userId,@resultCode,@errMsg

			IF (@resultCode != 0)
			BEGIN
				--If error found return
				RETURN
			END
		END
		ELSE IF (@pMethod = 'NEW')
		BEGIN
			--Create new record		
			PRINT 'CREATE [mdContactAccount]'
			INSERT INTO @TBL_Response_pkey(pkey)
			EXECUTE [ecca].[p_contactaccount_createContactAccount]
				NULL,
				@contactAccountType,@firstName,@lastName,@displayName,@chineseName,
				NULL,@gender,@salutation, @title,NULL,NULL,
				@phone1,@phone2,@phone3,
				NULL,NULL,NULL,
				NULL,NULL,NULL,
				NULL,'CUSTOMER',0,
				'Active',@userId,@resultCode OUTPUT,@errMsg OUTPUT
			IF (@resultCode != 0)
			BEGIN
				--If error found return
				RETURN
			END
			SET @pkey_response = (SELECT pkey FROM @TBL_Response_pkey)
		END

		IF (EXISTS(SELECT * FROM [smartone].[mdCustomer] WITH (NOLOCK) WHERE pkey = @pkey_response))
		BEGIN
			PRINT 'UPDATE mdCustoemr'
			--Don't update smartone association key loginNowID 
			UPDATE [smartone].[mdCustomer] SET
				fullName = #TMP_DATA.fullName, 
				fullNameChi = #TMP_DATA.fullNameChi, 
				custType = #TMP_DATA.custType, 
				billDay = #TMP_DATA.billDay, 
				osBalance = #TMP_DATA.osBalance, 
				loginNowStatus = #TMP_DATA.loginNowStatus,
				loginNowUser = #TMP_DATA.loginNowUser, 
				custID = #TMP_DATA.custID, 
				custNum = #TMP_DATA.custNum, 
				--subrList = subrList, 
				subrNum = #TMP_DATA.subrNum 
				FROM #TMP_DATA WHERE [smartone].[mdCustomer].pkey = @pkey_response
		END
		ELSE
		BEGIN
			PRINT 'CREATE mdCustoemr'
			INSERT INTO [smartone].[mdCustomer] (pkey,workgroup, fullName, fullNameChi, custType, billDay, osBalance, loginNowID, loginNowStatus, loginNowUser, custID, custNum, subrList, subrNum, 
               email, [plan], planDesc, planDescChi, planAmt, subrStatus, telesalesOptin, retentionCycle, hasDataRoam, hasIR, IRContent, hasSR, SRContent, 
               contactCurr, contactlst7d, contactlst30d, hasInterimBill, ccsExpiry, ccsReasonType, cfbOS, cfbComplete, adjOS, adjComplete, ldOver6mth, ld6mth, ldBilled, 
               ldPend)
			SELECT @pkey_response,'WebChat', fullName, fullNameChi, custType, billDay, osBalance, loginNowID, loginNowStatus, loginNowUser, custID, custNum, @subrList, subrNum, 
               email, [plan], planDesc, planDescChi, planAmt, subrStatus, telesalesOptin, retentionCycle, hasDataRoam, hasIR, IRContent, hasSR, SRContent, 
               contactCurr, contactlst7d, contactlst30d, hasInterimBill, ccsExpiry, ccsReasonType, cfbOS, cfbComplete, adjOS, adjComplete, ldOver6mth, ld6mth, ldBilled, 
               ldPend
			   FROM #TMP_DATA
		END

		/*
		--Update Phone List
		IF (EXISTS(SELECT TOP 1 * FROM @tbl_subrList c1 
			LEFT JOIN [smartone].mdCustomerPhoneList c2 ON c2.pkey = @pkey_response AND c2.phone = c1.subrNo AND c2.workgroup = 'WebChat'
			WHERE c2.pkey IS NULL))
		BEGIN
			INSERT INTO [smartone].mdCustomerPhoneList(pkey,workgroup,phone)
			SELECT @pkey_response,'WebChat',c1.subrNo
			FROM @tbl_subrList c1 
			LEFT JOIN [smartone].mdCustomerPhoneList c2 ON c2.pkey = @pkey_response AND c2.phone = c1.subrNo AND c2.workgroup = 'WebChat'
			WHERE c2.pkey IS NULL
			GROUP BY c1.subrNo
		END
		DELETE FROM [smartone].mdCustomerPhoneList WHERE  pkey = @pkey_response AND workgroup = 'WebChat' AND phone NOT IN (SELECT subrNo FROM @tbl_subrList)
		*/
		DECLARE @ResponesJSON NVARCHAR(MAX)
		SET @ResponesJSON = ( SELECT * FROM [smartone].[mdCustomer] WITH (NOLOCK) WHERE pkey=@pkey_response FOR JSON AUTO)



		SELECT @ResponesJSON AS pkey
	END
	ELSE
	BEGIN
		SET @errMsg = 'Response result not record found.'
		SET @resultCode = -1
		RETURN
	END
END TRY
BEGIN CATCH
	SET @errMsg = ERROR_MESSAGE()
	SET @resultCode = -1
END CATCH
END
