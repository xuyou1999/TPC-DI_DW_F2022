with table0 as (
select
DC.SK_CustomerID as SK_CustomerID,
DS.SK_SecurityID as SK_SecurityID,
DD.SK_DateID as SK_DateID_DatePlaced ,
null as SK_DateID_DateRemoved,
cast(1 as decimal) as BatchID,
WH.W_C_ID,
WH.W_S_SYMB
from (select * from tpc_di_stage.dbo.WatchHistory where W_ACTION = 'ACTV') WH
JOIN tpc_di_datawarehouse.dbo.DimCustomer DC on WH.W_C_ID = DC.CustomerID
JOIN tpc_di_datawarehouse.dbo.DimSecurity DS on WH.W_S_SYMB COLLATE French_CI_AS = DS.Symbol COLLATE French_CI_AS
JOIN tpc_di_datawarehouse.dbo.DimDate DD on cast(WH.W_DTS as date) = DD.DateValue
WHERE cast(WH.W_DTS as date)>= DC.EffectiveDate and cast(WH.W_DTS as date)< DC.EndDateand cast(WH.W_DTS as date)>= DS.EffectiveDate and cast(WH.W_DTS as date)< DS.EndDate)insert into tpc_di_datawarehouse.dbo.FactWatchesselect t0.SK_CustomerID as SK_CustomerID,
t0.SK_SecurityID as SK_SecurityID,
t0.SK_DateID_DatePlaced as SK_DateID_DatePlaced ,
DD.SK_DateID as SK_DateID_DateRemoved,
cast(1 as decimal) as BatchIDfrom table0 t0LEFT JOIN (select * from tpc_di_stage.dbo.WatchHistory where W_ACTION = 'CNCL') WH on WH.W_S_SYMB COLLATE French_CI_AS = t0.W_S_SYMB COLLATE French_CI_AS and WH.W_C_ID = t0.W_C_IDJOIN tpc_di_datawarehouse.dbo.DimDate DD on cast(WH.W_DTS as date) = DD.DateValue