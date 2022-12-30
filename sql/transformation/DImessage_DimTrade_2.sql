select 
CURRENT_TIMESTAMP as MessageDateAndTime,
cast(1 as decimal) as BatchID,
'DimTrade' as MessageSource,
'Invalid trade fee' as MessageText,
'Alert' as MessageType,
'T_ID = '+ cast(DT.TradeID as varchar) +', T_CHRG = '+ cast(DT.Fee as varchar) as MessageData
from tpc_di_datawarehouse.dbo.DimTrade DT
where DT.Fee is not NULL and (DT.TradePrice*DT.Quantity) < DT.Fee ;

