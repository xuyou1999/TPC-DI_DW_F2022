select 
'DimTrade' as MessageSource,
'Alert' as MessageType,
'Invalid trade fee' as MessageText,
'T_ID = '+ cast(DT.TradeID as varchar) +', T_CHRG = '+ cast(DT.Fee as varchar) as MessageData,
1 as BatchID
from tpc_di_datawarehouse.dbo.DimTrade DT
where DT.Fee is not NULL and (DT.TradePrice*DT.Quantity) < DT.Fee ;

