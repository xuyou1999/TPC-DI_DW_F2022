insert into dbo.DImessages

select 
CURRENT_TIMESTAMP as MessageDateAndTime,
cast(1 as decimal) as BatchID,
'DimTrade' as MessageSource,
'Invalid trade commission' as MessageText,
'Alert' as MessageType,
'T_ID = '+ cast (DT.TradeID as varchar) +', T_COMM = '+cast ( DT.Commission as varchar) as MessageData
from tpc_di_datawarehouse.dbo.DimTrade DT
where DT.Commission is not NULL and (DT.TradePrice*DT.Quantity) < DT.Commission ;

