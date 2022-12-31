--FactMarketHistory

Select DM.DM_CLOSE As ClosePrice,
	   DM.DM_HIGH As DayHigh,
	   DM.DM_LOW As DayLow,
	   DM.DM_VOL As Volume,
	   DS.SK_SecurityID,
	   DS.SK_CompanyID,
	   DD.SK_DateID
	   From tpc_di_stage.dbo.DailyMarket DM,tpc_di_datawarehouse.dbo.DimSecurity DS,tpc_di_datawarehouse.dbo.DimDate DD 
	   Where DM.DM_S_SYMB = DS.Symbol And
	   DM.DM_DATE Between DS.EffectiveDate And DS.EndDate And
	   DM.DM_DATE = DD.DateValue;

