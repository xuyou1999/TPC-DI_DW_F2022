with table1 as(
select DA.SK_CustomerID, DA.SK_AccountID, CT.CT_NAME
from tpc_di_stage.dbo.CashTransaction CT
JOIN tpc_di_datawarehouse.dbo.DimAccount DA on CT.CT_CA_ID = DA.AccountID
where cast(CT.CT_DTS as date) >= DA.EffectiveDate and cast(CT.CT_DTS as date)<EndDate
)


select 
	t1.SK_CustomerID as SK_CustomerID,
	t1.SK_AccountID as SK_AccountID,
	DD.SK_DateID as SK_DateID,
	sum(CT_AMT) as Cash,
	cast(1 as decimal) as BatchID
from tpc_di_stage.dbo.CashTransaction CT
JOIN table1 t1 on CT.CT_NAME = t1.CT_NAME
JOIN tpc_di_datawarehouse.dbo.DimDate DD on DD.DateValue = cast(CT.CT_DTS as date)
group by CT.CT_CA_ID, t1.SK_CustomerID, t1.SK_AccountID, DD.SK_DateID