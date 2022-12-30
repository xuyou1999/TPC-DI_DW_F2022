select 
'DimTrade' as MessageSource,
'Alert' as MessageType,
'Invalid trade commission' as MessageText,
'T_ID = '+ cast (DT.TradeID as varchar) +', T_COMM = '+cast ( DT.Commission as varchar) as MessageData,
1 as BatchID
from tpc_di_datawarehouse.dbo.DimTrade DT
where DT.Commission is not NULL and (DT.TradePrice*DT.Quantity) < DT.Commission ;

