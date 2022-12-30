select
cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) as MessageDateAndTime,
1 as BatchID,
'DimCustomer' as MessageSource,
'Alert' as MessageType,
'Invalid customer tier' as MessageText,
'C_ID = '+cast(C_ID as varchar)+', C_TIER = '+cast(C_TIER as varchar) as MessageData
from tpc_di_stage.dbo.CustomerMgmt 
where (ActionType = 'NEW' or ActionType = 'UPDCUST')
and not (C_TIER = 1 or C_TIER = 2 or C_TIER = 3)
union
select
cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) as MessageDateAndTime,
1 as BatchID,
'DimCustomer' as MessageSource,
'Alert' as MessageType,
'DOB out of range' as MessageText,
'C_ID = '+cast(C_ID as varchar)+', C_DOB = '+cast(C_DOB as varchar) as MessageData
from tpc_di_stage.dbo.CustomerMgmt, tpc_di_stage.dbo.BatchDate
where (ActionType = 'NEW' or ActionType = 'UPDCUST')
and (C_DOB < (dateadd(year,-100,(select * from tpc_di_stage.dbo.BatchDate as date)))
or C_DOB > (select * from tpc_di_stage.dbo.BatchDate as date))