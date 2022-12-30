with table0 as(
	select distinct DS.SK_SecurityID, DS.SK_CompanyID, T.T_ID
	from tpc_di_stage.dbo.Trade T
	JOIN tpc_di_datawarehouse.dbo.DimSecurity DS on T.T_S_SYMB COLLATE French_CI_AS = DS.Symbol COLLATE French_CI_AS
	JOIN tpc_di_stage.dbo.TradeHistory TH on TH.TH_T_ID = T.T_ID
	where TH.TH_DTS >= DS.EffectiveDate and TH.TH_DTS< DS.EndDate

),
table1 as (
	select distinct DA.SK_AccountID, DA.SK_CustomerID, DA.SK_BrokerID, T.T_ID
	from tpc_di_stage.dbo.Trade T
	JOIN tpc_di_datawarehouse.dbo.DimAccount DA on T.T_CA_ID = DA.AccountID
	JOIN tpc_di_stage.dbo.TradeHistory TH on TH.TH_T_ID = T.T_ID
	where TH.TH_DTS >= DA.EffectiveDate and TH.TH_DTS< DA.EndDate
	)

select 
	T.T_ID as TradeID,
	t1.SK_BrokerID as SK_BrokerID, 
	ST.ST_NAME as Status, 
	TT.TT_NAME as Type,
	T.T_IS_CASH as CashFlag,
	t0.SK_SecurityID as SK_SecurityID,
	t0.SK_CompanyID as SK_CompanyID,
	T.T_QTY as Quantity,
	T.T_BID_PRICE as  BidPrice, 
	t1.SK_CustomerID as SK_CustomerID, 
	t1.SK_AccountID as SK_AccountID, 
	T.T_EXEC_NAME as ExecutedBy, 
	T.T_TRADE_PRICE as TradePrice,
	T.T_CHRG as Fee, 
	T.T_COMM as Commission , 
	T.T_TAX as Tax, 
	cast(1 as decimal) as BatchID,
	CASE 
		WHEN TH.TH_ST_ID = 'SBMT' AND T.T_TT_ID IN ( 'TMB', 'TMS' ) OR 
			TH.TH_ST_ID = 'PNDG' THEN cast(TH.TH_DTS as date)
		ELSE NULL
	END AS SK_CreateDateID, 
	CASE 
		WHEN TH.TH_ST_ID = 'SBMT' AND T.T_TT_ID IN ( 'TMB', 'TMS' ) OR 
			TH.TH_ST_ID = 'PNDG' THEN cast(TH.TH_DTS as date)
		ELSE NULL
	END AS SK_CreateTimeID, 
	CASE 
		WHEN TH.TH_ST_ID = 'CMPT' or TH.TH_ST_ID = 'CNCL' THEN cast(TH.TH_DTS as time(7))
		ELSE NULL
	END AS SK_CloseDateID, 
	CASE 
		WHEN TH.TH_ST_ID = 'CMPT' or TH.TH_ST_ID = 'CNCL' THEN cast( TH.TH_DTS as time(7))
		ELSE NULL
	END AS SK_CloseTimeID
from tpc_di_stage.dbo.Trade T
	LEFT JOIN tpc_di_stage.dbo.StatusType ST on  ST.ST_ID = T.T_ST_ID
	JOIN table0 t0 on t0.T_ID = T.T_ID
	JOIN table1 t1 on t1.T_ID = T.T_ID
	JOIN tpc_di_stage.dbo.TradeType TT on TT.TT_ID = T.T_TT_ID
	JOIN tpc_di_stage.dbo.TradeHistory TH on TH.TH_T_ID = T.T_ID
