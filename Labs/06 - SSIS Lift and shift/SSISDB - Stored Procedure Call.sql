	DECLARE @return_value INT, @exe_id BIGINT, @err_msg NVARCHAR(150); 
	
	EXEC @return_value=[SSISDB].[catalog].[create_execution] 
	 @folder_name=N'<FOLDER name in SSIS Catalog>'
	,@project_name=N'<PROJECT name in SSIS Catalog>'
	,@package_name=N'<PACKAGE name>.dtsx',
	,@use32bitruntime=0
	,@runinscaleout=1
	,@useanyworker=1
	,@execution_id=@exe_id OUTPUT 
	
	
	EXEC[SSISDB].[catalog].[set_execution_parameter_value] 
	 @exe_id
	,@object_type=50
	,@parameter_name=N'SYNCHRONIZED'
	,@parameter_value=1 
	
	EXEC [SSISDB].[catalog].[start_execution] 
	 @execution_id=@exe_id
	,@retry_count=0 
	
	IF(SELECT [status] FROM [SSISDB].[catalog].[executions]
	WHERE execution_id=@exe_id)<>7 
	BEGIN 
	  SET @err_msg=N'Your package execution did not succeed for execution ID: ' + CAST(@exe_id AS NVARCHAR(20)) 
	  RAISERROR(@err_msg,15,1) 
	END
