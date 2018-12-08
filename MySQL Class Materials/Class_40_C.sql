CREATE EVENT SESSION [MyXEvent001] 
ON SERVER 
ADD EVENT sqlserver.sp_statement_completed(SET collect_statement=(1)
    ACTION(sqlserver.database_name,sqlserver.session_id,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'adventureworks')),
ADD EVENT sqlserver.sql_statement_completed(
    ACTION(sqlserver.database_name,sqlserver.session_id,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[database_name]=N'adventureworks'))
ADD TARGET package0.event_file(SET filename=N'C:\ExtendedEvents\MyxEvent1.xel',max_rollover_files=(1))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_MULTIPLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


