 
CREATE PROCEDURE [dbo].[sp_DBMigration_Schema]
(
@pXML XML,
@pOutXML XML OUTPUT
)
AS
BEGIN
/*
------------------------------------------------------------------------
--GET COMPARE DETAIL WITH LINK SERVER
DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_COMPARE_WITH_LINKSRV</TYPE>
		<LinkSrv_Name>[LAPTOP-59TFIH31\SQLEXPRESS]</LinkSrv_Name>
		<LinkSrv_DB_Name>NewDB</LinkSrv_DB_Name>
		<Local_DB_Name>OldDB</Local_DB_Name>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML
------------------------------------------------------------------------
--GEN FOREGIN KEY 
DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_FOREGIN_KEY_SCRIPT</TYPE>
		<Local_DB_Name>HITRUST</Local_DB_Name>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML
------------------------------------------------------------------------
--GEN COLUMN UPDATE SCRIPT
DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_COLUMN_UPDATE_SCRIPT</TYPE>
		<OLD_DB_Name>DSBDB</OLD_DB_Name>
		<NEW_DB_Name>DSBDB_0606</NEW_DB_Name>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML


DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_COLUMN_UPDATE_SCRIPT</TYPE>
		<OLD_DB_Name>HITRUST</OLD_DB_Name>
		<NEW_DB_Name>HITRUST_0606</NEW_DB_Name>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML
------------------------------------------------------------------------
--GET COMPARE STORED PRCOEDURE
DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_COMPARE_STORED_PROCEDURE</TYPE>
		<OLD_DB_Name>HITRUST</OLD_DB_Name>
		<NEW_DB_Name>HITRUST_0606</NEW_DB_Name>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_COMPARE_STORED_PROCEDURE_LINKSRV</TYPE>
		<OLD_DB_Name>BPSS</OLD_DB_Name>
		<NEW_DB_Name>BPSS</NEW_DB_Name>
		<LinkSrv_Name>UATVUTDBCB01</LinkSrv_Name>
		<ExportPath>C:\Temp\20210322\BPSS</ExportPath>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_COMPARE_STORED_PROCEDURE</TYPE>
		<OLD_DB_Name>BCMDB</OLD_DB_Name>
		<NEW_DB_Name>BCMDB_0606</NEW_DB_Name>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_COMPARE_STORED_PROCEDURE</TYPE>
		<OLD_DB_Name>NewDB</OLD_DB_Name>
		<NEW_DB_Name>OldDB</NEW_DB_Name>
		<ExportPath>C:\temp\20221004</ExportPath>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

---------

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>EXECUTE_BATCH_SQL_FILE</TYPE>
		<ImportPath>D:\temp\2020Aug31\</ImportPath>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_PREMISSION</TYPE>
		<USER>MVBREADONLY</USER>
		<Local_DB_Name>HITRUST_20200901</Local_DB_Name>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>SEARCH_INCLUDE_COLUMN</TYPE>
		<SEARCH_COLUMN>ACNO</SEARCH_COLUMN>
		<Local_DB_Name>DSBDB</Local_DB_Name>
		<ExportPath>C:\temp\20200915_DSBDB</ExportPath>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML
--------------------------------------------------
	--''P'',''V'',''FN''
	DECLARE @pRtnXML XML
	EXEC [sp_DBMigration] '
	<ROOT>
			<TYPE>GEN_SOURCE_CODE</TYPE>
			<Local_DB_Name>DSBDB</Local_DB_Name> 
			<FuncType>P</FuncType>
			<ExportPath>C:\temp\20210308\a</ExportPath>
	</ROOT>',@pRtnXML OUTPUT
	SELECT @pRtnXML

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_SOURCE_CODE</TYPE>
		<Local_DB_Name>DSBDB</Local_DB_Name> 
		<FuncType>V</FuncType>
		<ExportPath>C:\temp\20210304\DSBDB\View</ExportPath>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GEN_SOURCE_CODE</TYPE>
		<Local_DB_Name>DSBDB</Local_DB_Name> 
		<FuncType>FN</FuncType>
		<ExportPath>C:\temp\20210304\DSBDB\Function</ExportPath>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

DECLARE @pRtnXML XML
EXEC [sp_DBMigration] '
<ROOT>
		<TYPE>GET_TABLE_CREATE_SCRIPT</TYPE>
		<ExportPath>C:\temp\20210304\BPSS\Tables</ExportPath>
		<SourceFile>C:\Temp\20210304\BPSS_DB.sql</SourceFile>
</ROOT>',@pRtnXML OUTPUT
SELECT @pRtnXML

	DROP TABLE db_temp
	CREATE TABLE db_temp
	(
	rData NVARCHAR(MAX)
	)

	--Copy & paste raw data to table
	-- SELECT rData FROM db_temp

    BULK INSERT db_temp
    FROM 'C:\Temp\20210304\BCMDB_DB.sql'  
	WITH (   
	FIRSTROW = 1,
     FieldTerminator = ',', RowTerminator= '\n', KEEPNULLS
    );  
	
	alter table db_temp add RowID BIGINT NOT NULL IDENTITY(1,1)

*/
  
exec sp_configure 'Ole Automation Procedures', 1
-- Configuration option 'Ole Automation Procedures' changed from 0 to 1. Run the RECONFIGURE statement to install.
 
reconfigure

	DECLARE @TYPE NVARCHAR(100)
	DECLARE @LinkSrv_DB_Name NVARCHAR(MAX)
	DECLARE @LinkSrv_Name NVARCHAR(MAX)
	DECLARE @Local_DB_Name NVARCHAR(MAX)
	DECLARE @OLD_DB_Name NVARCHAR(MAX)
	DECLARE @NEW_DB_Name NVARCHAR(MAX)
	DECLARE @sScript NVARCHAR(MAX)
	DECLARE @tbl_Name NVARCHAR(MAX)	
	DECLARE @sDBScript NVARCHAR(MAX)
	DECLARE @sExportPath NVARCHAR(MAX)
	DECLARE @sImportPath NVARCHAR(MAX)
	DECLARE @sSEARCH_COLUMN NVARCHAR(MAX)
	DECLARE @sUSER NVARCHAR(100)
	DECLARE @sFuncType NVARCHAR(3)
	DECLARE @sSourceFile NVARCHAR(300)

	SELECT 
		@TYPE			= T.C.value('TYPE[1]', 'NVARCHAR(100)'),
		@LinkSrv_DB_Name	= T.C.value('LinkSrv_DB_Name[1]', 'NVARCHAR(100)'),
		@LinkSrv_Name		= T.C.value('LinkSrv_Name[1]', 'NVARCHAR(100)'),
		@Local_DB_Name		= T.C.value('Local_DB_Name[1]', 'NVARCHAR(100)'),
		@OLD_DB_Name		= T.C.value('OLD_DB_Name[1]', 'NVARCHAR(100)'),
		@NEW_DB_Name		= T.C.value('NEW_DB_Name[1]', 'NVARCHAR(100)'),
		@sExportPath		= T.C.value('ExportPath[1]', 'NVARCHAR(200)'),
		@sImportPath		= T.C.value('ImportPath[1]', 'NVARCHAR(200)'),
		@sFuncType			= T.C.value('FuncType[1]', 'NVARCHAR(3)'),
		@sSourceFile		= T.C.value('SourceFile[1]', 'NVARCHAR(300)'),
		@sUSER				= T.C.value('USER[1]', 'NVARCHAR(200)'),
		@sSEARCH_COLUMN		= T.C.value('SEARCH_COLUMN[1]', 'NVARCHAR(200)')
		FROM @pXML.nodes('/ROOT') T(C)

	IF (@TYPE = 'GEN_COMPARE_WITH_LINKSRV')
	BEGIN
		SET @sDBScript =  @LinkSrv_Name +'.'+ @LinkSrv_DB_Name + '.dbo.'
	 
SET @sScript = '
IF OBJECT_ID(''tempdb..#tmp_SourceName'') IS NOT NULL DROP TABLE #tmp_SourceName
IF OBJECT_ID(''tempdb..#tmp_TargetName'') IS NOT NULL DROP TABLE #tmp_TargetName
IF OBJECT_ID(''tempdb..#tmp_SourceNameResult'') IS NOT NULL DROP TABLE #tmp_SourceNameResult
IF OBJECT_ID(''tempdb..#tmp_TargetNameResult'') IS NOT NULL DROP TABLE #tmp_TargetNameResult

SELECT sch.name + ''.'' + t.name AS TableName,sch.name AS schema_name ,c.* INTO #tmp_SourceName FROM
'+ @Local_DB_Name +'.sys.columns c INNER JOIN 
'+ @Local_DB_Name +'.sys.tables t ON c.object_id = t.object_id INNER JOIN 
'+ @Local_DB_Name +'.sys.types ty ON c.system_type_id = ty.system_type_id INNER JOIN
'+ @Local_DB_Name +'.sys.schemas sch ON sch.schema_id = t.schema_id 
WHERE t.name IS NOT NULL AND ty.name NOT IN ( ''sysname'',''dtproperties'') AND t.name NOT IN ( ''sysname'',''dtproperties'',''sysdiagrams'')
	
SELECT sch.name + ''.'' +t.name AS TableName,sch.name AS schema_name ,c.* INTO #tmp_TargetName FROM
'+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.columns c INNER JOIN 
'+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.tables t ON c.object_id = t.object_id INNER JOIN 
'+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.types ty ON c.system_type_id = ty.system_type_id INNER JOIN
'+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.schemas sch ON sch.schema_id = t.schema_id
WHERE t.name IS NOT NULL AND ty.name NOT IN ( ''sysname'',''dtproperties'') AND t.name NOT IN ( ''sysname'',''dtproperties'',''sysdiagrams'')

SELECT ''COLUMN DIFF''
SELECT c1.max_length AS OLD_Length1,c2.max_length AS NEW_Length2,c1.user_type_id AS OLD_ColType1,c2.user_type_id AS NEW_ColType2,* FROM #tmp_SourceName c1 INNER JOIN #tmp_TargetName c2 ON c1.name = c2.name AND c1.TableName = c2.TableName 
WHERE c1.max_length !=  c2.max_length  OR c1.user_type_id != c2.user_type_id



SELECT c2.* FROM #tmp_SourceName c1 LEFT JOIN #tmp_TargetName c2 ON c1.TableName = c2.TableName  AND c1.name = c2.name 
WHERE c1.name IS NULL  

SELECT ''TABLE NOT IN SOURCE''
SELECT c1.* FROM #tmp_TargetName c1 WHERE c1.TableName NOT IN (SELECT c2.TableName FROM #tmp_SourceName c2)

SELECT o.NAME,i.rowcnt FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.sysindexes AS i INNER JOIN '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.sysobjects AS o ON i.id = o.id 
WHERE i.indid < 2 AND o.NAME IN 
(
SELECT c1.TableName FROM #tmp_SourceName c1 INNER JOIN #tmp_TargetName c2 ON c1.name = c2.name AND c1.TableName = c2.TableName 
WHERE c1.max_length !=  c2.max_length  OR c1.user_type_id != c2.user_type_id
) ORDER BY i.rowcnt


SELECT ''COLUMN NOT INSIDE''
	 
SELECT c1.TableName ,''ALTER TABLE '' + c1.TableName + '' ADD '' + c1.name + '' '' + c3.name +
(CASE WHEN c3.system_type_id = 40 OR c3.system_type_id = 52 OR c3.system_type_id = 56 OR c3.system_type_id = 61 OR c3.system_type_id = 104 THEN
	''''
ELSE
	CASE WHEN c3.system_type_id = 106 THEN
		''('' + CONVERT(NVARCHAR,c1.precision)  +'','' + CONVERT(NVARCHAR,c1.scale)  +'')''
	ELSE
		CASE WHEN c3.system_type_id = 167 OR c3.system_type_id = 175 THEN
			''('' + CONVERT(NVARCHAR,c1.max_length)    +'')''
		ELSE
			CASE WHEN c3.system_type_id = 231 OR c3.system_type_id = 239 THEN	
				''('' + CONVERT(NVARCHAR,c1.max_length/2)    +'')''
			ELSE
				''''
			END
		END
	END
END)
AS rScript,c1.*
INTO #tmp_SourceNameResult
FROM #tmp_SourceName c1 
LEFT JOIN #tmp_TargetName c2 ON c1.TableName = c2.TableName  AND c1.name = c2.name
INNER JOIN sys.types c3 ON c3.system_type_id = c1.system_type_id
WHERE c2.name IS NULL   

SELECT TableName,name FROM #tmp_SourceNameResult GROUP BY TableName,name



SELECT ''GEN CLONE SCRIPT(INCLUDE IDENTITY)''
SELECT  ''
	SET IDENTITY_INSERT '' + name + '' ON
	INSERT INTO '' + name + ''('' + 
	SUBSTRING((SELECT  '','' + COLUMN_NAME FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME=name AND COLUMN_NAME NOT IN (''msrepl_tran_version'') FOR XML PATH('''')),2,10000)  +'')	SELECT '' + 
	SUBSTRING((SELECT  '','' + COLUMN_NAME FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME=name AND COLUMN_NAME NOT IN (''msrepl_tran_version'') FOR XML PATH('''')),2,10000)  +'' FROM '+@sDBScript +''' + name 
	+ '' 
	SET IDENTITY_INSERT '' + name + '' OFF''
	FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.objects WHERE type IN (''U'') AND name IN (SELECT o.name FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.objects o inner join '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.columns c on o.object_id = c.object_id WHERE c.is_identity = 1)

SELECT ''GEN CLONE SCRIPT(NOT INCLUDE IDENTITY)''
SELECT  ''INSERT INTO '' + name + '' SELECT * FROM '+@sDBScript +''' + name FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.objects WHERE type IN (''U'') AND name NOT IN (SELECT o.name FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.objects o inner join '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.columns c on o.object_id = c.object_id WHERE c.is_identity = 1)

SELECT ''GEN CLONE SCRIPT(NOT INCLUDE IDENTITY)''
SELECT  ''INSERT INTO '' + name + '' SELECT * FROM '+@sDBScript +''' + name FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.objects WHERE type IN (''U'') AND name NOT IN (SELECT o.name FROM '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.objects o inner join '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.columns c on o.object_id = c.object_id WHERE c.is_identity = 1)
AND name IN 
(SELECT o.NAME FROM '
+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.sysindexes AS i INNER JOIN '+ @LinkSrv_Name +'.'+ @LinkSrv_DB_Name +'.sys.sysobjects AS o ON i.id = o.id INNER JOIN '
+ @Local_DB_Name +'.sys.sysobjects AS o2 ON o.NAME = o2.NAME
INNER JOIN '+ @Local_DB_Name +'.sys.sysindexes AS i2 ON i2.id = o2.id 
WHERE i.indid < 2 AND i.rowcnt != i2.rowcnt AND i2.indid < 2 AND i2.rowcnt = 0)'

		PRINT @sScript
		EXEC sp_executesql @sScript
	END
	IF (@TYPE = 'SEARCH_INCLUDE_COLUMN')
	BEGIN
		SET @sDBScript =  @LinkSrv_Name +'.'+ @LinkSrv_DB_Name + '.dbo.'
	 
		SET @sScript = '
		DECLARE @sExportPath NVARCHAR(MAX)
		DECLARE @sSource_New NVARCHAR(MAX)
		DECLARE @OLE_New INT
		DECLARE @FileID_New INT
		DECLARE @File_Path_New NVARCHAR(MAX)
		DECLARE @New_tmp_file TABLE
		(
			RowID INT IDENTITY(1,1),
			rData NVARCHAR(MAX)
		)
		DECLARE @New_tmp_file_order TABLE
		(
			RowID INT,
			rData NVARCHAR(MAX)
		)
		DECLARE @tmp_Result TABLE
		(
			rTableName NVARCHAR(MAX),
			rData NVARCHAR(MAX)
		)
		DECLARE @rName NVARCHAR(100)
		DECLARE @var NVARCHAR(100)

		SET @var = '''+ @sSEARCH_COLUMN +'''
		
		SET @sExportPath = '''+ @sExportPath +'''

		IF OBJECT_ID(''tempdb..#tmp_SourceName'') IS NOT NULL DROP TABLE #tmp_SourceName
		IF OBJECT_ID(''tempdb..#tmp_Column'') IS NOT NULL DROP TABLE #tmp_Column

		SELECT sch.name + ''.'' + t.name AS TableName,
		sch.name AS schema_name ,c.* INTO #tmp_SourceName FROM
		'+ @Local_DB_Name +'.sys.columns c INNER JOIN 
		'+ @Local_DB_Name +'.sys.tables t ON c.object_id = t.object_id INNER JOIN 
		'+ @Local_DB_Name +'.sys.types ty ON c.system_type_id = ty.system_type_id INNER JOIN
		'+ @Local_DB_Name +'.sys.schemas sch ON sch.schema_id = t.schema_id
		WHERE t.name IS NOT NULL AND ty.name NOT IN ( ''sysname'',''dtproperties'') AND t.name NOT IN ( ''sysname'',''dtproperties'',''sysdiagrams'')
	
		SELECT c1.* INTO #tmp_Column FROM (
		SELECT 
			CASE 
			 WHEN o1.type = ''P''  THEN ''Stored Procedure''  
			 WHEN o1.type = ''V''  THEN ''View''  
			 WHEN o1.type = ''FN'' THEN ''Function''  ELSE ''Unknown''  
			 END AS ''ObjectType'', 
			sch.name + ''.'' + o1.name as ''ObjectName''
		FROM '+ @Local_DB_Name +'.dbo.syscomments c1 JOIN '+ @Local_DB_Name +'.sys.objects o1 ON c1.id = o1.[object_id]  
		INNER JOIN '+ @Local_DB_Name +'.sys.schemas sch ON sch.schema_id = o1.schema_id
		WHERE text LIKE ''%'' + @var + ''%''  AND o1.type IN (''V'',''P'',''FN'') AND 
			(o1.name NOT LIKE ''%2015%'' AND o1.name NOT LIKE ''%2016%'' AND o1.name NOT LIKE ''%2017%'' AND o1.name NOT LIKE ''%2018%'' 
			AND o1.name NOT LIKE ''%2019%'' AND o1.name NOT LIKE ''%2020%''AND o1.name NOT LIKE ''%2014%'' AND o1.name NOT LIKE ''%2013%''
			AND o1.name NOT LIKE ''%2012%'' AND o1.name NOT LIKE ''%2011%'' AND o1.name NOT LIKE ''%2010%'' AND o1.name NOT LIKE ''%2009%'')
		UNION  
		SELECT 
		''Table'' as ''ObjectType'',   
		 sch.name + ''.'' +o1.name as ''ObjectName''
		FROM '+ @Local_DB_Name +'.sys.objects o1  
		 join '+ @Local_DB_Name +'.sys.columns sc  
		  on o1.object_id = sc.column_id  
		  INNER JOIN '+ @Local_DB_Name +'.sys.schemas sch ON sch.schema_id = o1.schema_id
		WHERE o1.type = ''U''  
		 and sc.name = @var  AND 
			(o1.name NOT LIKE ''%2015%'' AND o1.name NOT LIKE ''%2016%'' AND o1.name NOT LIKE ''%2017%'' AND o1.name NOT LIKE ''%2018%'' 
			AND o1.name NOT LIKE ''%2019%'' AND o1.name NOT LIKE ''%2020%''AND o1.name NOT LIKE ''%2014%'' AND o1.name NOT LIKE ''%2013%''
			AND o1.name NOT LIKE ''%2012%'' AND o1.name NOT LIKE ''%2011%'' AND o1.name NOT LIKE ''%2010%'' AND o1.name NOT LIKE ''%2009%'')
		UNION
		SELECT ''Table'' as ''Object Type'',sch.name + ''.'' + t.name as ''Object Name''
		FROM '+ @Local_DB_Name +'.sys.columns c
			JOIN '+ @Local_DB_Name +'.sys.tables t ON c.object_id = t.object_id
			INNER JOIN '+ @Local_DB_Name +'.sys.schemas sch ON sch.schema_id = t.schema_id
		WHERE c.name LIKE ''%'' + @var + ''%'' AND 
			(t.name NOT LIKE ''%2015%'' AND t.name NOT LIKE ''%2016%'' AND t.name NOT LIKE ''%2017%'' AND t.name NOT LIKE ''%2018%'' 
			AND t.name NOT LIKE ''%2019%'' AND t.name NOT LIKE ''%2020%''AND t.name NOT LIKE ''%2014%'' AND t.name NOT LIKE ''%2013%''
			AND t.name NOT LIKE ''%2012%'' AND t.name NOT LIKE ''%2011%'' AND t.name NOT LIKE ''%2010%'' AND t.name NOT LIKE ''%2009%'')) c1 
		
		SELECT * FROM #tmp_Column
		
		DECLARE CUR_tmp_file CURSOR LOCAL FOR
			SELECT ObjectName FROM #tmp_Column WHERE ObjectType IN  (''Stored Procedure'',''Function'',''View'') AND ObjectType IS NOT NULL

		OPEN CUR_tmp_file
		FETCH NEXT FROM CUR_tmp_file INTO @rName
		WHILE( @@FETCH_STATUS = 0)
		BEGIN
			DELETE FROM @New_tmp_file
			DELETE FROM @New_tmp_file_order
			SET @sSource_New = ''''

			INSERT INTO @New_tmp_file(rData)
			EXEC master.dbo.sp_GenSPSourceCode '''+ @Local_DB_Name +''',@rName

			INSERT INTO @New_tmp_file_order(RowID,rData)
			SELECT row_number() OVER (ORDER BY RowID),rData FROM @New_tmp_file

			UPDATE @New_tmp_file_order SET rData = ''LINE NO:'' + CONVERT(NVARCHAR,RowID) + '' -- '' + rData

			SELECT @sSource_New = COALESCE(@sSource_New + '''', '''') + rData FROM @New_tmp_file_order WHERE rData LIKE ''%''+ @var +''%'' ORDER BY RowID

			SET @File_Path_New = @sExportPath + ''\'' + @rName + ''_SEARCH_COLUMN.txt''
			SET @OLE_New = 0
			SET @FileID_New = 0

			EXECUTE sp_OACreate ''Scripting.FileSystemObject'', @OLE_New OUT
			EXECUTE sp_OAMethod @OLE_New, ''OpenTextFile'', @FileID_New OUT, @File_Path_New, 8, 1
			EXECUTE sp_OAMethod @FileID_New, ''WriteLine'', Null, @sSource_New
			EXECUTE sp_OAMethod @FileID_New, ''Close'', Null, Null
			EXECUTE sp_OADestroy @FileID_New

			INSERT INTO @tmp_Result(rTableName,rData) VALUES (@rName,@sSource_New)

			FETCH NEXT FROM CUR_tmp_file INTO @rName
		END
		CLOSE CUR_tmp_file
		DEALLOCATE CUR_tmp_file

		SELECT * FROM @tmp_Result

		SELECT t.name AS TableName,sch.name AS schema_name ,c.name, c.max_length,c.*  FROM
			'+ @Local_DB_Name +'.sys.columns c INNER JOIN 
			'+ @Local_DB_Name +'.sys.tables t ON c.object_id = t.object_id INNER JOIN 
			'+ @Local_DB_Name +'.sys.types ty ON c.system_type_id = ty.system_type_id
			INNER JOIN '+ @Local_DB_Name +'.sys.schemas sch ON sch.schema_id = t.schema_id

			WHERE t.name IS NOT NULL AND ty.name NOT IN ( ''sysname'',''dtproperties'') AND t.name NOT IN ( ''sysname'',''dtproperties'',''sysdiagrams'')
		AND t.name IN (
			SELECT ObjectName FROM #tmp_Column WHERE ObjectType = ''Table'' AND ObjectType IS NOT NULL)
			AND c.name LIKE ''%''+ @var +''%''
		'		
		
		PRINT @sScript
		EXEC sp_executesql @sScript
	END
	IF (@TYPE = 'GEN_FOREGIN_KEY_SCRIPT')
	BEGIN
		SET @sScript = '
				select ''ALTER TABLE '' + SCHEMA_NAME(t.schema_id) + ''.'' + t.name + ''  NOCHECK CONSTRAINT '' + f.name  AS DISABLE_FOREGIN_KEY,
			''ALTER TABLE '' + t.name + ''  WITH CHECK CHECK CONSTRAINT '' + f.name AS ENABLE_FOREGIN_KEY
				from 
					'+  @Local_DB_Name +'.sys.foreign_key_columns as fk
				inner join 
					'+  @Local_DB_Name +'.sys.tables as t on fk.parent_object_id = t.object_id
				inner join 
					'+  @Local_DB_Name +'.sys.columns as c on fk.parent_object_id = c.object_id and fk.parent_column_id = c.column_id
				INNER JOIN 
					'+  @Local_DB_Name +'.sys.foreign_keys as f on f.parent_object_id = fk.parent_object_id
				GROUP BY 
				f.name,	
			t.name  '
		
		PRINT @sScript
		EXEC sp_executesql @sScript
	END
	IF (@TYPE = 'GEN_COMPARE_STORED_PROCEDURE')
	BEGIN


SET @sScript = '

DECLARE @sSource_Old NVARCHAR(MAX)
DECLARE @sSource_New NVARCHAR(MAX)
DECLARE @OLE_Old INT
DECLARE @FileID_Old INT
DECLARE @File_Path_Old NVARCHAR(MAX)
DECLARE @OLE_New INT
DECLARE @FileID_New INT
DECLARE @File_Path_New NVARCHAR(MAX)

DECLARE @Diff_tmp_file TABLE
(
	RowID INT IDENTITY(1,1),
	rSPName NVARCHAR(MAX),
	rData NVARCHAR(MAX)
)

DECLARE @Add_tmp_file TABLE
(
	RowID INT IDENTITY(1,1),
	rSPName NVARCHAR(MAX),
	rData NVARCHAR(MAX)
)

DECLARE @New_tmp_file TABLE
(
	RowID INT IDENTITY(1,1),
	rData NVARCHAR(MAX)
)

DECLARE @Old_tmp_file TABLE
(
	RowID INT IDENTITY(1,1),
	rData NVARCHAR(MAX)
)
DECLARE @rName NVARCHAR(100)
DECLARE @sExportPath NVARCHAR(MAX)

SET @sExportPath = '''+ @sExportPath +'''

IF OBJECT_ID(''tempdb..#tmp_SourceName'') IS NOT NULL DROP TABLE #tmp_SourceName
IF OBJECT_ID(''tempdb..#tmp_TargetName'') IS NOT NULL DROP TABLE #tmp_TargetName

SELECT 
(sch.name + ''.'' + c1.name) AS name
INTO #tmp_SourceName FROM
'+ @NEW_DB_Name +'.sys.objects c1
INNER JOIN '+ @NEW_DB_Name +'.sys.schemas sch ON sch.schema_id = c1.schema_id
WHERE c1.type IN (''P'',''V'',''FN'')  AND c1.is_ms_shipped=0 AND 
	(c1.name NOT LIKE ''%2015%'' AND c1.name NOT LIKE ''%2016%'' AND c1.name NOT LIKE ''%2017%'' AND c1.name NOT LIKE ''%2018%'' 
	AND c1.name NOT LIKE ''%2019%'' AND c1.name NOT LIKE ''%2020%''AND c1.name NOT LIKE ''%2014%'' AND c1.name NOT LIKE ''%2013%''
	AND c1.name NOT LIKE ''%2012%'' AND c1.name NOT LIKE ''%2011%'' AND c1.name NOT LIKE ''%2010%'' AND c1.name NOT LIKE ''%2009%'')
	AND c1.name NOT IN (''sp_alterdiagram'',''sp_creatediagram'',''sp_dropdiagram'',''sp_helpdiagrams'',''sp_renamediagram'',''sp_upgraddiagrams'')
	
SELECT 
(sch.name + ''.'' + c1.name) AS name
INTO #tmp_TargetName FROM
'+ @OLD_DB_Name +'.sys.objects c1 
INNER JOIN '+ @OLD_DB_Name +'.sys.schemas sch ON sch.schema_id = c1.schema_id
WHERE c1.type IN (''P'',''V'',''FN'') AND c1.is_ms_shipped=0
		
SELECT ''STORED PROCEDURE DIFF''
		
DECLARE CUR_tmp_file CURSOR LOCAL FOR
	SELECT c1.name FROM #tmp_SourceName c1 
	INNER JOIN #tmp_TargetName c2 ON c1.name = c2.name 

OPEN CUR_tmp_file
FETCH NEXT FROM CUR_tmp_file INTO @rName
WHILE( @@FETCH_STATUS = 0)
BEGIN
	DELETE FROM @New_tmp_file
	DELETE FROM @Old_tmp_file


	PRINT ''1''

	PRINT @rName

	INSERT INTO @New_tmp_file(rData)
	EXEC '+ @NEW_DB_Name +'.dbo.sp_GenSPSourceCode '''+ @NEW_DB_Name +''',@rName

	INSERT INTO @Old_tmp_file(rData)
	EXEC '+ @OLD_DB_Name +'.dbo.sp_GenSPSourceCode '''+ @OLD_DB_Name +''',@rName
			 
	DECLARE @sOld NVARCHAR(MAX)
	DECLARE @sNew NVARCHAR(MAX)


	PRINT ''2''
	DELETE FROM  @New_tmp_file WHERE RowID < (SELECT MIN(RowID) FROM @New_tmp_file WHERE rData LIKE ''%CREATE%'' )
	DELETE FROM  @Old_tmp_file WHERE RowID < (SELECT MIN(RowID) FROM @Old_tmp_file WHERE rData LIKE ''%CREATE%'' )

	SELECT @sOld = COALESCE(@sOld + '''', '''') + rData FROM @Old_tmp_file ORDER BY RowID
	SELECT @sNew = COALESCE(@sNew + '''', '''') + rData FROM @New_tmp_file ORDER BY RowID

	SET @sOld = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@sOld,CHAR(10),''''),CHAR(13),''''),CHAR(32),''''),CHAR(91),''''),CHAR(93),'''')
	SET @sNew = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@sNew,CHAR(10),''''),CHAR(13),''''),CHAR(32),''''),CHAR(91),''''),CHAR(93),'''')
			
	SET @sOld = (SELECT SUBSTRING(@sOld,CHARINDEX(@rName,@sOld,1),LEN(@sOld)))
	SET @sNew = (SELECT SUBSTRING(@sNew,CHARINDEX(@rName,@sNew,1),LEN(@sNew)))

	PRINT ''3''
	IF (@sOld != @sNew)
	BEGIN
		SET @sOld = REPLACE(REPLACE(@sOld,''CREATEPROCEDUREdbo.'',''''),''CREATEPROCEDURE'','''')
		SET @sNew = REPLACE(REPLACE(@sNew,''CREATEPROCEDUREdbo.'',''''),''CREATEPROCEDURE'','''')
		IF (@sOld != @sNew)
		BEGIN			
			SET @sSource_Old = ''''
			SET @sSource_New = ''''

			SELECT @sSource_Old = COALESCE(@sSource_Old + '''', '''') + rData FROM @Old_tmp_file ORDER BY RowID
			SELECT @sSource_New = COALESCE(@sSource_New + '''', '''') + rData FROM @New_tmp_file ORDER BY RowID

			SET @File_Path_Old = @sExportPath + ''\'' + @rName + ''_OLD''
			SET @File_Path_New = @sExportPath + ''\'' + @rName + ''_NEW''

			PRINT ''4''
			EXECUTE sp_OACreate ''Scripting.FileSystemObject'', @OLE_Old OUT
			EXECUTE sp_OAMethod @OLE_Old, ''OpenTextFile'', @FileID_Old OUT, @File_Path_Old, 8, 1
			EXECUTE sp_OAMethod @FileID_Old, ''WriteLine'', Null, @sSource_Old
			EXECUTE sp_OAMethod @FileID_Old, ''Close'', Null, Null
			EXECUTE sp_OADestroy @FileID_Old
			PRINT ''5''
			EXECUTE sp_OACreate ''Scripting.FileSystemObject'', @OLE_New OUT
			EXECUTE sp_OAMethod @OLE_New, ''OpenTextFile'', @FileID_New OUT, @File_Path_New, 8, 1
			EXECUTE sp_OAMethod @FileID_New, ''WriteLine'', Null, @sSource_New
			EXECUTE sp_OAMethod @FileID_New, ''Close'', Null, Null
			EXECUTE sp_OADestroy @FileID_New

			INSERT INTO @Diff_tmp_file (rSPName,rData)
			SELECT @rName, rData FROM @New_tmp_file ORDER BY RowID
				
			INSERT INTO @Diff_tmp_file (rSPName,rData) VALUES (@rName,''GO'')
			INSERT INTO @Add_tmp_file (rSPName,rData) VALUES (@rName,'' '')
		END
	END
	DELETE FROM @New_tmp_file
	DELETE FROM @Old_tmp_file

	FETCH NEXT FROM CUR_tmp_file INTO @rName
END
CLOSE CUR_tmp_file
DEALLOCATE CUR_tmp_file

SELECT * FROM @Diff_tmp_file ORDER BY RowID
SELECT rSPName FROM @Diff_tmp_file GROUP BY rSPName


DECLARE CUR_Add_tmp_file CURSOR LOCAL FOR
	SELECT c1.name FROM #tmp_SourceName c1 WHERE LTRIM(RTRIM(c1.name)) NOT IN (SELECT LTRIM(RTRIM(c2.name)) FROM #tmp_TargetName c2)

OPEN CUR_Add_tmp_file
FETCH NEXT FROM CUR_Add_tmp_file INTO @rName
WHILE( @@FETCH_STATUS = 0)
BEGIN 
	DELETE FROM @New_tmp_file

	INSERT INTO @New_tmp_file(rData)
	EXEC '+ @NEW_DB_Name +'.dbo.sp_GenSPSourceCode '''+ @NEW_DB_Name +''',@rName
	INSERT INTO @Add_tmp_file (rSPName,rData)
	SELECT @rName, rData FROM @New_tmp_file ORDER BY RowID

	INSERT INTO @Add_tmp_file (rSPName,rData) VALUES (@rName,''GO'')
	INSERT INTO @Add_tmp_file (rSPName,rData) VALUES (@rName,'' '')
 
	FETCH NEXT FROM CUR_Add_tmp_file INTO @rName
END
CLOSE CUR_Add_tmp_file
DEALLOCATE CUR_Add_tmp_file

SELECT * FROM @Add_tmp_file ORDER BY RowID
SELECT c1.name FROM #tmp_SourceName c1 WHERE c1.name NOT IN (SELECT c2.name FROM #tmp_TargetName c2)'
		
		PRINT @sScript
		EXEC sp_executesql @sScript
	END

	IF (@TYPE = 'GET_TABLE_CREATE_SCRIPT')
	BEGIN
		SET @sScript = '
			DROP TABLE db_temp
			CREATE TABLE db_temp
			(
			rData NVARCHAR(MAX)
			)

			--Copy & paste raw data to table
			-- SELECT rData FROM db_temp

			BULK INSERT db_temp
			FROM '''+ @sSourceFile +'''  
			WITH (   
			FIRSTROW = 1,
			 FieldTerminator = '','', RowTerminator= ''\n'', KEEPNULLS
			);  
	 
			alter table db_temp add RowID BIGINT NOT NULL IDENTITY(1,1)
		'
		
		PRINT @sScript
		EXEC sp_executesql @sScript

		SET @sScript = '


		DECLARE @TableName  NVARCHAR(100)
		DECLARE @StartRow	INT
		DECLARE @EndRow		INT
		DECLARE @sSource NVARCHAR(MAX) 
		DECLARE @OLE INT
		DECLARE @FileID INT
		DECLARE @File_Path NVARCHAR(MAX) 
		DECLARE @sExportPath NVARCHAR(MAX)
		DECLARE @isExists INT

		SET @sExportPath = '''+ @sExportPath +'''

		IF OBJECT_ID(''tempdb..#tmp_db_temp'') IS NOT NULL DROP TABLE #tmp_db_temp
		SELECT  *,
		REPLACE(SUBSTRING(rData, CHARINDEX(''[dbo]'',rData) + 7, CHARINDEX('']('',rData) - (CHARINDEX(''[dbo]'',rData) +7)),'']('','''+ '' +''') AS TableName,
		RowID AS StartRow,
		ISNULL((SELECT MIN(RowID) - 1 FROM db_temp c2 WHERE rData LIKE ''%CREATE TABLE%'' AND c2.RowID > c1.RowID),(SELECT COUNT(*) FROM db_temp)) AS EndRow
		INTO #tmp_db_temp
		FROM db_temp c1 WHERE rData LIKE ''%CREATE TABLE%'' AND 
				(rData NOT LIKE ''%2015%'' AND rData NOT LIKE ''%2016%'' AND rData NOT LIKE ''%2017%'' AND rData NOT LIKE ''%2018%''
				AND rData NOT LIKE ''%2019%'' AND rData NOT LIKE ''%2020%'' AND rData NOT LIKE ''%2014%'' AND rData NOT LIKE ''%2013%''
				AND rData NOT LIKE ''%2012%'' AND rData NOT LIKE ''%2011%'' AND rData NOT LIKE ''%2010%'' AND rData NOT LIKE ''%2009%'')
 
 		DECLARE CUR_tmp_file CURSOR LOCAL FOR
			SELECT TableName,StartRow,EndRow FROM #tmp_db_temp 

		OPEN CUR_tmp_file
		FETCH NEXT FROM CUR_tmp_file INTO @TableName,@StartRow,@EndRow
		WHILE( @@FETCH_STATUS = 0)
		BEGIN 
			SET @sSource = '''' 
			SELECT @sSource = COALESCE(@sSource + '''', '''') + rData + CHAR(13) +CHAR(10) FROM db_temp c1 WHERE RowID BETWEEN @StartRow AND @EndRow ORDER BY RowID

			SET @OLE = 0
			SET @FileID = 0
			
			SET @File_Path = @sExportPath + ''\'' + @TableName + ''.sql''

			DECLARE @Command CHAR(1000)
			SET @Command = ''DIR "''+ @File_Path +''" /B''

			EXEC @isExists = XP_CMDSHELL @Command, NO_OUTPUT
			IF (@isExists = 1)
			BEGIN
				EXECUTE sp_OACreate ''Scripting.FileSystemObject'', @OLE OUT
				EXECUTE sp_OAMethod @OLE, ''OpenTextFile'', @FileID OUT, @File_Path, 8, 1
				EXECUTE sp_OAMethod @FileID, ''WriteLine'', Null, @sSource
				EXECUTE sp_OAMethod @FileID, ''Close'', Null, Null
				EXECUTE sp_OADestroy @FileID
			END
			FETCH NEXT FROM CUR_tmp_file INTO @TableName,@StartRow,@EndRow
		END
		CLOSE CUR_tmp_file
		DEALLOCATE CUR_tmp_file
		'

		PRINT @sScript
		EXEC sp_executesql @sScript
	END

	--''P'',''V'',''FN''

	IF (@TYPE = 'GEN_SOURCE_CODE')
	BEGIN
		SET @sScript = '
		SET NOCOUNT ON;
		DECLARE @rName NVARCHAR(200)
		DECLARE @OLE INT
		DECLARE @FileID INT
		DECLARE @File_Path NVARCHAR(MAX)
		DECLARE @sExportPath NVARCHAR(MAX)
		DECLARE @sSource NVARCHAR(MAX)
		DECLARE @isExists INT

		SET @sExportPath = '''+ @sExportPath +'''

		DECLARE @tmp_file TABLE
		(
			RowID INT IDENTITY(1,1),
			rData NVARCHAR(MAX)
		)

		IF OBJECT_ID(''tempdb..#tmp_SourceName'') IS NOT NULL DROP TABLE #tmp_SourceName

		SELECT * INTO #tmp_SourceName FROM ' + @Local_DB_Name +'.sys.objects WHERE type IN ('''+ @sFuncType +''')  AND is_ms_shipped=0 AND 
			(name NOT LIKE ''%2015%'' AND name NOT LIKE ''%2016%'' AND name NOT LIKE ''%2017%'' AND name NOT LIKE ''%2018%'' 
			AND name NOT LIKE ''%2019%'' AND name NOT LIKE ''%2020%''AND name NOT LIKE ''%2014%'' AND name NOT LIKE ''%2013%''
			AND name NOT LIKE ''%2012%'' AND name NOT LIKE ''%2011%'' AND name NOT LIKE ''%2010%'' AND name NOT LIKE ''%2009%'')
			AND name NOT IN (''sp_alterdiagram'',''sp_creatediagram'',''sp_dropdiagram'',''sp_helpdiagrams'',''sp_renamediagram'',''sp_upgraddiagrams'')
		ORDER BY name

		SELECT ''SOURCE CODE GENERATE''
		
		DECLARE CUR_tmp_file CURSOR LOCAL FOR
			SELECT name FROM #tmp_SourceName 

		OPEN CUR_tmp_file
		FETCH NEXT FROM CUR_tmp_file INTO @rName
		WHILE( @@FETCH_STATUS = 0)
		BEGIN
			DELETE FROM @tmp_file
			WAITFOR DELAY ''00:00:00:10''

			INSERT INTO @tmp_file(rData)
			EXEC master.dbo.sp_GenSPSourceCode '''+ @Local_DB_Name +''',@rName

			SET @sSource = ''''
			SELECT @sSource = COALESCE(@sSource + '''', '''') + rData FROM @tmp_file ORDER BY RowID

			SET @OLE = 0
			SET @FileID = 0
			
			SET @File_Path = @sExportPath + ''\'' + @rName  + ''.sql''
			
			DECLARE @Command CHAR(1000)
			SET @Command = ''DIR "''+ @File_Path +''" /B''

			EXEC @isExists = XP_CMDSHELL @Command, NO_OUTPUT
			IF (@isExists = 1)
			BEGIN
				
				EXECUTE sp_OACreate ''Scripting.FileSystemObject'', @OLE OUT
				EXECUTE sp_OAMethod @OLE, ''OpenTextFile'', @FileID OUT, @File_Path, 8, 1
				EXECUTE sp_OAMethod @FileID, ''WriteLine'', Null, @sSource
				EXECUTE sp_OAMethod @FileID, ''Close'', Null, Null
				EXECUTE sp_OADestroy @FileID
			END
			

			FETCH NEXT FROM CUR_tmp_file INTO @rName
		END
		CLOSE CUR_tmp_file
		DEALLOCATE CUR_tmp_file


		SELECT * FROM #tmp_SourceName

		'

		
		PRINT @sScript
		EXEC sp_executesql @sScript
	END
	IF (@TYPE = 'GEN_COMPARE_STORED_PROCEDURE_LINKSRV')
	BEGIN
		SET @sScript = '
		SET NOCOUNT ON;
		DECLARE @sSource_Old NVARCHAR(MAX)
		DECLARE @sSource_New NVARCHAR(MAX)
		DECLARE @OLE_Old INT
		DECLARE @FileID_Old INT
		DECLARE @File_Path_Old NVARCHAR(MAX)
		DECLARE @OLE_New INT
		DECLARE @FileID_New INT
		DECLARE @File_Path_New NVARCHAR(MAX)

		DECLARE @Diff_tmp_file TABLE
		(
			RowID INT IDENTITY(1,1),
			rSPName NVARCHAR(MAX),
			rData NVARCHAR(MAX)
		)

		DECLARE @Add_tmp_file TABLE
		(
			RowID INT IDENTITY(1,1),
			rSPName NVARCHAR(MAX),
			rData NVARCHAR(MAX)
		)

		DECLARE @New_tmp_file TABLE
		(
			RowID INT IDENTITY(1,1),
			rData NVARCHAR(MAX)
		)

		DECLARE @Old_tmp_file TABLE
		(
			RowID INT IDENTITY(1,1),
			rData NVARCHAR(MAX)
		)
		DECLARE @rName NVARCHAR(100)
		DECLARE @sExportPath NVARCHAR(MAX)

		SET @sExportPath = '''+ @sExportPath +'''

		IF OBJECT_ID(''tempdb..#tmp_SourceName'') IS NOT NULL DROP TABLE #tmp_SourceName
		IF OBJECT_ID(''tempdb..#tmp_TargetName'') IS NOT NULL DROP TABLE #tmp_TargetName
		
		SELECT * INTO #tmp_SourceName FROM
		'+ @LinkSrv_Name + '.' + @NEW_DB_Name +'.sys.objects WHERE type IN (''P'',''V'',''FN'')  AND is_ms_shipped=0 AND 
			(name NOT LIKE ''%2015%'' AND name NOT LIKE ''%2016%'' AND name NOT LIKE ''%2017%'' AND name NOT LIKE ''%2018%'' 
			AND name NOT LIKE ''%2019%'' AND name NOT LIKE ''%2020%''AND name NOT LIKE ''%2014%'' AND name NOT LIKE ''%2013%''
			AND name NOT LIKE ''%2012%'' AND name NOT LIKE ''%2011%'' AND name NOT LIKE ''%2010%'' AND name NOT LIKE ''%2009%'')
			AND name NOT IN (''sp_alterdiagram'',''sp_creatediagram'',''sp_dropdiagram'',''sp_helpdiagrams'',''sp_renamediagram'',''sp_upgraddiagrams'')
	
		SELECT * INTO #tmp_TargetName FROM
		'+ @OLD_DB_Name +'.sys.objects WHERE type IN (''P'',''V'',''FN'') AND is_ms_shipped=0
		
		SELECT ''STORED PROCEDURE DIFF''
		
		DECLARE CUR_tmp_file CURSOR LOCAL FOR
			SELECT c1.name FROM #tmp_SourceName c1 INNER JOIN #tmp_TargetName c2 ON c1.name = c2.name

		OPEN CUR_tmp_file
		FETCH NEXT FROM CUR_tmp_file INTO @rName
		WHILE( @@FETCH_STATUS = 0)
		BEGIN
			DELETE FROM @New_tmp_file
			DELETE FROM @Old_tmp_file

			INSERT INTO @New_tmp_file(rData)
			EXEC ['+ @LinkSrv_Name +'].master.dbo.sp_GenSPSourceCode '''+ @NEW_DB_Name +''',@rName

			INSERT INTO @Old_tmp_file(rData)
			EXEC master.dbo.sp_GenSPSourceCode '''+ @OLD_DB_Name +''',@rName
			 
			DECLARE @sOld NVARCHAR(MAX)
			DECLARE @sNew NVARCHAR(MAX)

			DELETE FROM  @New_tmp_file WHERE RowID < (SELECT MIN(RowID) FROM @New_tmp_file WHERE rData LIKE ''%CREATE%'' )
			DELETE FROM  @Old_tmp_file WHERE RowID < (SELECT MIN(RowID) FROM @Old_tmp_file WHERE rData LIKE ''%CREATE%'' )

			SELECT @sOld = COALESCE(@sOld + '''', '''') + rData FROM @Old_tmp_file ORDER BY RowID
			SELECT @sNew = COALESCE(@sNew + '''', '''') + rData FROM @New_tmp_file ORDER BY RowID

			SET @sOld = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@sOld,CHAR(10),''''),CHAR(13),''''),CHAR(32),''''),CHAR(91),''''),CHAR(93),'''')
			SET @sNew = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@sNew,CHAR(10),''''),CHAR(13),''''),CHAR(32),''''),CHAR(91),''''),CHAR(93),'''')
			
			SET @sOld = (SELECT SUBSTRING(@sOld,CHARINDEX(@rName,@sOld,1),LEN(@sOld)))
			SET @sNew = (SELECT SUBSTRING(@sNew,CHARINDEX(@rName,@sNew,1),LEN(@sNew)))

			IF (@sOld != @sNew)
			BEGIN
				SET @sOld = REPLACE(@sOld,''dbo.'','''')
				SET @sNew = REPLACE(@sNew,''dbo.'','''')

				SET @sOld = REPLACE(REPLACE(@sOld,''['',''''),'']'','''')
				SET @sNew = REPLACE(REPLACE(@sNew,''['',''''),'']'','''')
				SET @sOld = REPLACE(REPLACE(@sOld,''CREATEPROCEDUREdbo.'',''''),''CREATEPROCEDURE'','''')
				SET @sNew = REPLACE(REPLACE(@sNew,''CREATEPROCEDUREdbo.'',''''),''CREATEPROCEDURE'','''')
				IF (@sOld != @sNew)
				BEGIN			
					SET @sSource_Old = ''''
					SET @sSource_New = ''''

					SELECT @sSource_Old = COALESCE(@sSource_Old + '''', '''') + rData FROM @Old_tmp_file ORDER BY RowID
					SELECT @sSource_New = COALESCE(@sSource_New + '''', '''') + rData FROM @New_tmp_file ORDER BY RowID

					SET @File_Path_Old = @sExportPath + ''\'' + @rName + ''_OLD''
					SET @File_Path_New = @sExportPath + ''\'' + @rName + ''_NEW''

					SET @OLE_Old = 0
					SET @OLE_New = 0
					SET @FileID_Old = 0
					SET @FileID_New = 0

					
					EXECUTE sp_OACreate ''Scripting.FileSystemObject'', @OLE_Old OUT
					EXECUTE sp_OAMethod @OLE_Old, ''OpenTextFile'', @FileID_Old OUT, @File_Path_Old, 8, 1
					EXECUTE sp_OAMethod @FileID_Old, ''WriteLine'', Null, @sSource_Old
					EXECUTE sp_OAMethod @FileID_Old, ''Close'', Null, Null
					EXECUTE sp_OADestroy @FileID_Old

					EXECUTE sp_OACreate ''Scripting.FileSystemObject'', @OLE_New OUT
					EXECUTE sp_OAMethod @OLE_New, ''OpenTextFile'', @FileID_New OUT, @File_Path_New, 8, 1
					EXECUTE sp_OAMethod @FileID_New, ''WriteLine'', Null, @sSource_New
					EXECUTE sp_OAMethod @FileID_New, ''Close'', Null, Null
					EXECUTE sp_OADestroy @FileID_New
 
					INSERT INTO @Diff_tmp_file (rSPName,rData)
					SELECT @rName, rData FROM @New_tmp_file ORDER BY RowID
				
					INSERT INTO @Diff_tmp_file (rSPName,rData) VALUES (@rName,''GO'')
					INSERT INTO @Add_tmp_file (rSPName,rData) VALUES (@rName,'' '')
				END
			END

			DELETE FROM @New_tmp_file
			DELETE FROM @Old_tmp_file

			FETCH NEXT FROM CUR_tmp_file INTO @rName
		END
		CLOSE CUR_tmp_file
		DEALLOCATE CUR_tmp_file

		SELECT * FROM @Diff_tmp_file ORDER BY RowID
		SELECT rSPName FROM @Diff_tmp_file GROUP BY rSPName


		DECLARE CUR_Add_tmp_file CURSOR LOCAL FOR
			SELECT c1.name FROM #tmp_SourceName c1 WHERE LTRIM(RTRIM(c1.name)) NOT IN (SELECT LTRIM(RTRIM(c2.name)) FROM #tmp_TargetName c2)

		OPEN CUR_Add_tmp_file
		FETCH NEXT FROM CUR_Add_tmp_file INTO @rName
		WHILE( @@FETCH_STATUS = 0)
		BEGIN 
			DELETE FROM @New_tmp_file

			INSERT INTO @New_tmp_file(rData)
			EXEC '+ @LinkSrv_Name +'.master.dbo.sp_GenSPSourceCode '''+ @NEW_DB_Name +''',@rName
			INSERT INTO @Add_tmp_file (rSPName,rData)
			SELECT @rName, rData FROM @New_tmp_file ORDER BY RowID

			INSERT INTO @Add_tmp_file (rSPName,rData) VALUES (@rName,''GO'')
			INSERT INTO @Add_tmp_file (rSPName,rData) VALUES (@rName,'' '')
 
			FETCH NEXT FROM CUR_Add_tmp_file INTO @rName
		END
		CLOSE CUR_Add_tmp_file
		DEALLOCATE CUR_Add_tmp_file

		SELECT * FROM @Add_tmp_file ORDER BY RowID
		SELECT c1.name FROM #tmp_SourceName c1 WHERE c1.name NOT IN (SELECT c2.name FROM #tmp_TargetName c2)'
		
		PRINT @sScript
		EXEC sp_executesql @sScript
	END
	IF (@TYPE = 'EXECUTE_BATCH_SQL_FILE')
	BEGIN
		SET @sScript = '
			  DECLARE @BackupDirectory SYSNAME = '''+ @sImportPath +'''
			  DECLARE @pFilePath NVARCHAR(MAX)

			  SET @pFilePath =  '''+ @sImportPath +''' 

				DECLARE @sqlCommand VARCHAR(1000)
				DECLARE @JobName NVARCHAR(1000)

				DECLARE @tbl_Job TABLE
				(
					rData NVARCHAR(MAX)
				)
			  IF OBJECT_ID(''tempdb..#DirTree'') IS NOT NULL
				DROP TABLE #DirTree

			  CREATE TABLE #DirTree (
				Id int identity(1,1),
				SubDirectory nvarchar(255),
				Depth smallint,
				FileFlag bit,
				ParentDirectoryID int
			   )

			   INSERT INTO #DirTree (SubDirectory, Depth, FileFlag)
			   EXEC master..xp_dirtree @BackupDirectory, 10, 1

			   UPDATE #DirTree
			   SET ParentDirectoryID = (
				SELECT MAX(Id) FROM #DirTree d2
				WHERE Depth = d.Depth - 1 AND d2.Id < d.Id
			   )
			   FROM #DirTree d

			  DECLARE 
				@ID INT,
				@BackupFile VARCHAR(MAX),
				@Depth TINYINT,
				@FileFlag BIT,
				@ParentDirectoryID INT,
				@wkSubParentDirectoryID INT,
				@wkSubDirectory VARCHAR(MAX)

			  DECLARE @BackupFiles TABLE
			  (
				FileNamePath VARCHAR(MAX),
				TransLogFlag BIT,
				BackupFile VARCHAR(MAX),    
				DatabaseName VARCHAR(MAX)
			  )

			  DECLARE FileCursor CURSOR LOCAL FORWARD_ONLY FOR
			  SELECT * FROM #DirTree WHERE FileFlag = 1

			  OPEN FileCursor
			  FETCH NEXT FROM FileCursor INTO 
				@ID,
				@BackupFile,
				@Depth,
				@FileFlag,
				@ParentDirectoryID  

			  SET @wkSubParentDirectoryID = @ParentDirectoryID

			  WHILE @@FETCH_STATUS = 0
			  BEGIN
				--loop to generate path in reverse, starting with backup file then prefixing subfolders in a loop
				WHILE @wkSubParentDirectoryID IS NOT NULL
				BEGIN
				  SELECT @wkSubDirectory = SubDirectory, @wkSubParentDirectoryID = ParentDirectoryID 
				  FROM #DirTree 
				  WHERE ID = @wkSubParentDirectoryID

				  SELECT @BackupFile = @wkSubDirectory + ''\'' + @BackupFile
				END

				--no more subfolders in loop so now prefix the root backup folder
				SELECT @BackupFile = @BackupFile

				--put backupfile into a table and then later work out which ones are log and full backups  
				INSERT INTO @BackupFiles (FileNamePath) VALUES(@BackupFile)

				DELETE FROM @tbl_Job
				SET @sqlCommand = ''sqlcmd -i '' + @pFilePath + @BackupFile

				PRINT @sqlCommand
				INSERT INTO @tbl_Job(rData)
				EXEC master..xp_cmdshell @sqlCommand

				 IF (EXISTS(SELECT * FROM @tbl_Job WHERE rData LIKE ''%already exists%''))
				 BEGIN
					SET @JobName = (SELECT  SUBSTRING(rData,CHARINDEX('''''''',rData,0) + 1 ,LEN(rData) - (CHARINDEX('''''''',REVERSE(rData),0) + CHARINDEX('''''''',rData,0)))   FROM @tbl_Job WHERE rData LIKE ''%already exists%'')
					SELECT @JobName,@sqlCommand
			--		EXEC sp_delete_job @job_name =@JobName
			--		EXEC master..xp_cmdshell @sqlCommand
				 END
	
				FETCH NEXT FROM FileCursor INTO 
				  @ID,
				  @BackupFile,
				  @Depth,
				  @FileFlag,
				  @ParentDirectoryID 

				SET @wkSubParentDirectoryID = @ParentDirectoryID      
			  END

			  CLOSE FileCursor
			  DEALLOCATE FileCursor'

		PRINT @sScript
		EXEC sp_executesql @sScript

	END
	IF (@TYPE = 'GEN_COLUMN_UPDATE_SCRIPT')
	BEGIN
		SET @sScript = '

		IF OBJECT_ID(''tempdb..#tmp_SourceName'') IS NOT NULL DROP TABLE #tmp_SourceName
		IF OBJECT_ID(''tempdb..#tmp_TargetName'') IS NOT NULL DROP TABLE #tmp_TargetName

		SELECT t.name AS TableName ,c.* INTO #tmp_SourceName FROM
		'+ @NEW_DB_Name +'.sys.columns c INNER JOIN 
		'+ @NEW_DB_Name +'.sys.tables t ON c.object_id = t.object_id INNER JOIN 
		'+ @NEW_DB_Name +'.sys.types ty ON c.system_type_id = ty.system_type_id
		WHERE t.name IS NOT NULL AND ty.name NOT IN ( ''sysname'',''dtproperties'') AND t.name NOT IN ( ''sysname'',''dtproperties'',''sysdiagrams'')
	
		SELECT t.name AS TableName ,c.* INTO #tmp_TargetName FROM
		'+ @OLD_DB_Name +'.sys.columns c INNER JOIN 
		'+ @OLD_DB_Name +'.sys.tables t ON c.object_id = t.object_id INNER JOIN 
		'+ @OLD_DB_Name +'.sys.types ty ON c.system_type_id = ty.system_type_id
		WHERE t.name IS NOT NULL AND ty.name NOT IN ( ''sysname'',''dtproperties'') AND t.name NOT IN ( ''sysname'',''dtproperties'',''sysdiagrams'')
		
		SELECT ''COLUMN DIFF''
		SELECT c1.TableName,c1.name ,c1.system_type_id AS New_Column_Type,c1.max_length AS New_Column_length,
		c2.system_type_id AS Old_Column_Type,c2.max_length AS Old_Column_length ,type1.name,type2.DATA_TYPE,type2.CHARACTER_MAXIMUM_LENGTH,

		''ALTER TABLE '' + c1.TableName + '' ALTER COLUMN ''+ c1.name + '' ''  +   (CASE WHEN NUMERIC_PRECISION IS NOT NULL  THEN
			DATA_TYPE  + ''('' + CONVERT(NVARCHAR(MAX),NUMERIC_PRECISION) + '','' + CONVERT(NVARCHAR(MAX),ISNULL(NUMERIC_SCALE,0)) + '')''
				ELSE
					CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN
						DATA_TYPE + ''('' + CONVERT(NVARCHAR(MAX),CHARACTER_MAXIMUM_LENGTH) + '')''
					ELSE
						DATA_TYPE  
					END
				END
			)

		FROM #tmp_SourceName c1 
			INNER JOIN #tmp_TargetName c2 ON c1.name = c2.name AND c1.TableName = c2.TableName 
			INNER JOIN sys.types type1 ON c1.system_type_id = type1.system_type_id
			LEFT JOIN '+ @NEW_DB_Name +'.INFORMATION_SCHEMA.COLUMNS type2 ON type2.TABLE_NAME = c1.TableName AND type2.COLUMN_NAME = c1.name
		WHERE c1.max_length !=  c2.max_length  OR c1.user_type_id != c2.user_type_id

		SELECT ''COLUMN NOT INSIDE''
		SELECT  c1.TableName,c1.name ,c1.system_type_id AS New_Column_Type,c1.max_length AS New_Column_length,
		c2.system_type_id AS Old_Column_Type,c2.max_length AS Old_Column_length ,
		''ALTER TABLE '' + c1.TableName + '' ADD '' + c1.name + '' '' +  (CASE WHEN NUMERIC_PRECISION IS NOT NULL  THEN
			DATA_TYPE  + ''('' + CONVERT(NVARCHAR(MAX),NUMERIC_PRECISION) + '','' + CONVERT(NVARCHAR(MAX),ISNULL(NUMERIC_SCALE,0)) + '')''
				ELSE
					CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN
						DATA_TYPE + ''('' + CONVERT(NVARCHAR(MAX),CHARACTER_MAXIMUM_LENGTH) + '')''
					ELSE
						DATA_TYPE  
					END
				END
			)
		FROM #tmp_SourceName c1 
		LEFT JOIN #tmp_TargetName c2 ON c1.TableName = c2.TableName AND c1.name = c2.name 
		INNER JOIN sys.types type1 ON c1.system_type_id = type1.system_type_id
		LEFT JOIN '+ @NEW_DB_Name +'.INFORMATION_SCHEMA.COLUMNS type2 ON type2.TABLE_NAME = c1.TableName AND type2.COLUMN_NAME = c1.name
			WHERE c2.name IS NULL AND c1.TableName IN (SELECT c3.TableName FROM #tmp_TargetName c3)
		GROUP BY c1.TableName,c1.name ,c1.system_type_id,c1.max_length,c2.system_type_id,c2.max_length,NUMERIC_PRECISION,NUMERIC_SCALE,CHARACTER_MAXIMUM_LENGTH,DATA_TYPE

		SELECT ''TABLE NOT IN SOURCE''
		SELECT c1.* FROM #tmp_TargetName c1 WHERE c1.TableName NOT IN (SELECT c2.TableName FROM #tmp_SourceName c2)

		SELECT  ''ALTER INDEX ''+ i.[name] +'' ON ''+ t.[name] +''  DISABLE'' AS DisableIndex,
				''ALTER INDEX ''+ i.[name] +'' ON ''+ t.[name] +''  REBUILD'' AS EnableIndex,
				t.object_id, 
			i.[name] as index_name,
			substring(column_names, 1, len(column_names)-1) as [columns],
			schema_name(t.schema_id) + ''.'' + t.[name] as table_view
		FROM '+ @OLD_DB_Name +'.sys.objects t
		INNER JOIN '+ @OLD_DB_Name +'.sys.indexes i
			on t.object_id = i.object_id
		CROSS APPLY (SELECT col.[name] + '', ''
						FROM '+ @OLD_DB_Name +'.sys.index_columns ic
							INNER JOIN '+ @OLD_DB_Name +'.sys.columns col
								ON ic.object_id = col.object_id
								AND ic.column_id = col.column_id
						WHERE ic.object_id = t.object_id
							AND ic.index_id = i.index_id
								ORDER BY key_ordinal
								FOR XML PATH('''')) D (column_names)
		WHERE t.is_ms_shipped <> 1 AND i.is_unique = 0 AND t.[type] = ''U''
		AND EXISTS (SELECT * FROM #tmp_TargetName c1 WHERE c1.object_id = t.object_id )
		AND index_id > 0
		'
		PRINT @sScript
		EXEC sp_executesql @sScript
	END
	IF (@TYPE = 'GEN_PREMISSION')
	BEGIN
		select name as username,
			   create_date,
			   modify_date,
			   type_desc as type,
			   authentication_type_desc as authentication_type
		from sys.database_principals
		where type not in ('A', 'G', 'R', 'X')
			  and sid is not null
			  and name != 'guest'
		order by username;

		SET @sScript  = '
		SELECT '''+ @Local_DB_Name +''' AS DBName,
		  (
			dp.state_desc + '' '' +
			dp.permission_name collate latin1_general_cs_as + 
			'' ON '' + ''['' + s.name + '']'' + ''.'' + ''['' + o.name + '']'' +
			'' TO '' + ''['' + dpr.name + '']''
		  ) AS GRANT_STMT
		FROM  '+ @Local_DB_Name +'.sys.database_permissions AS dp
		  INNER JOIN '+ @Local_DB_Name +'.sys.objects AS o ON dp.major_id=o.object_id
		  INNER JOIN '+ @Local_DB_Name +'.sys.schemas AS s ON o.schema_id = s.schema_id
		  INNER JOIN '+ @Local_DB_Name +'.sys.database_principals AS dpr ON dp.grantee_principal_id=dpr.principal_id
		WHERE 1=1 AND dpr.name IN ('''+ @sUSER +''') ORDER BY dpr.name'
		
		PRINT @sScript
		EXEC sp_executesql @sScript
	END
END

 
