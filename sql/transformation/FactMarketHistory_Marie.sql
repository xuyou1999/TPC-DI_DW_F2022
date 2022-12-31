--FactMarketHistory
with table1 as (
	select *
	from tpc_di_stage.dbo.FINWIRE_FIN FF
	where 
		(ISNUMERIC(FF.CoNameOrCIK) = 1)
	),
table2 as (
	select DimCompany.SK_CompanyID as SK_CompanyID, table1.PTS as PTS, table1.CoNameOrCIK as CoNameOrCIK, table1.EPS, table1.Quarter, table1.Year
	from table1, tpc_di_datawarehouse.dbo.DimCompany
	where 
		cast(table1.CoNameOrCIK as bigint)=DimCompany.CompanyID
		and (convert(date, stuff(stuff(stuff(REPLACE(table1.PTS,'-',''), 9, 0, ' '), 12, 0, ':'), 15, 0, ':')) >= cast(DimCompany.EffectiveDate as date)) 
		and (convert(date, stuff(stuff(stuff(REPLACE(table1.PTS,'-',''), 9, 0, ' '), 12, 0, ':'), 15, 0, ':')) < cast(DimCompany.EndDate as date))
	),
table3 as (
	select *
	from tpc_di_stage.dbo.FINWIRE_FIN FF
	where 
		(ISNUMERIC(FF.CoNameOrCIK) = 0)
	),
table4 as (
	select DimCompany.SK_CompanyID as SK_CompanyID, table3.PTS as PTS, table3.CoNameOrCIK as CoNameOrCIK, table3.EPS, table3.Quarter, table3.Year
	from table3, tpc_di_datawarehouse.dbo.DimCompany
	where 
		table3.CoNameOrCIK COLLATE French_CI_AS =DimCompany.Name COLLATE French_CI_AS
		and (convert(date, stuff(stuff(stuff(REPLACE(table3.PTS,'-',''), 9, 0, ' '), 12, 0, ':'), 15, 0, ':')) >= cast(DimCompany.EffectiveDate as date)) 
		and (convert(date, stuff(stuff(stuff(REPLACE(table3.PTS,'-',''), 9, 0, ' '), 12, 0, ':'), 15, 0, ':')) < cast(DimCompany.EndDate as date))
	),
table5 as(
select *
from table2
UNION
select *
from table4
)

Select DM.DM_CLOSE As ClosePrice,
	   DM.DM_HIGH As DayHigh,
	   DM.DM_LOW As DayLow,
	   DM.DM_VOL As Volume,
	   DS.SK_SecurityID,
	   DS.SK_CompanyID,
	   DD.SK_DateID,
	   MAX(DM.DM_HIGH) OVER(PARTITION BY DM_S_SYMB ORDER BY DM_DATE ROWS 
BETWEEN 364 PRECEDING AND CURRENT ROW) as FiftyTwoWeekHigh,
	   DD.DateValue as SK_FiftyTwoWeekHighDate,
	   MIN(DM.DM_LOW) OVER(PARTITION BY DM_S_SYMB ORDER BY DM_DATE ROWS 
BETWEEN 364 PRECEDING AND CURRENT ROW) as FiftyTwoWeekLow,
		DD.DateValue as SK_FiftyTwoWeekLowDate,
		SUM(cast(table5.EPS as bigint)) OVER(PARTITION BY table5.Quarter ORDER BY table5.Year ROWS 
BETWEEN 4 PRECEDING AND CURRENT ROW) as PERatio,
		((DS.Dividend/DM.DM_CLOSE) *100) as Yield,
		cast(1 as decimal) as BatchID

	   From tpc_di_stage.dbo.DailyMarket DM
	   JOIN tpc_di_datawarehouse.dbo.DimSecurity DS on DM.DM_S_SYMB COLLATE French_CI_AS = DS.Symbol COLLATE French_CI_AS
	   JOIN tpc_di_datawarehouse.dbo.DimDate DD on DM.DM_DATE = DD.DateValue
	   JOIN table5 on table5.SK_CompanyID = DS.SK_CompanyID
	   Where 
	   DM.DM_DATE Between DS.EffectiveDate And DS.EndDate
	   ;
