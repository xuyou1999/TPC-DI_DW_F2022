with table1 as (
	select *
	from tpc_di_stage.dbo.FINWIRE_SEC
	where 
		(ISNUMERIC(FINWIRE_SEC.CoNameOrCIK) = 1)
	),
table2 as (
	select DimCompany.SK_CompanyID as SK_CompanyID, table1.PTS as PTS, table1.CoNameOrCIK as CoNameOrCIK
	from table1, tpc_di_datawarehouse.dbo.DimCompany
	where 
		cast(table1.CoNameOrCIK as bigint)=DimCompany.CompanyID
		and (convert(date, stuff(stuff(stuff(REPLACE(table1.PTS,'-',''), 9, 0, ' '), 12, 0, ':'), 15, 0, ':')) >= cast(DimCompany.EffectiveDate as date)) 
		and (convert(date, stuff(stuff(stuff(REPLACE(table1.PTS,'-',''), 9, 0, ' '), 12, 0, ':'), 15, 0, ':')) < cast(DimCompany.EndDate as date))
	),
table3 as (
	select *
	from tpc_di_stage.dbo.FINWIRE_SEC
	where 
		(ISNUMERIC(FINWIRE_SEC.CoNameOrCIK) = 0)
	),
table4 as (
	select DimCompany.SK_CompanyID as SK_CompanyID, table3.PTS as PTS, table3.CoNameOrCIK as CoNameOrCIK
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

select
	ROW_NUMBER() over(order by(select null)) as SK_SecurityID,
	FINWIRE_SEC.Symbol as Symbol, 
	FINWIRE_SEC.IssueType as Issue,
	tpc_di_stage.dbo.StatusType.ST_NAME as Status,
	FINWIRE_SEC.Name as Name,
	FINWIRE_SEC.ExID as ExchangeID,
	table5.SK_CompanyID as SK_CompanyID,
	FINWIRE_SEC.ShOut as  SharesOutstanding, 
	FINWIRE_SEC.FirstTradeDate as  FirstTrade,
	FINWIRE_SEC.FirstTradeExchg as FirstTradeOnExchange,	FINWIRE_SEC.Dividend as Dividend,
	cast(1 as bit) as IsCurrent,
	cast(1 as decimal) as BatchID, 
	(convert(date, stuff(stuff(stuff(REPLACE(FINWIRE_SEC.PTS,'-',''), 9, 0, ' '), 12, 0, ':'), 15, 0, ':'))) as EffectiveDate,
	cast('9999-12-31' as date) as Enddate

from tpc_di_stage.dbo.FINWIRE_SEC
	INNER JOIN tpc_di_stage.dbo.StatusType on tpc_di_stage.dbo.FINWIRE_SEC.Status = tpc_di_stage.dbo.StatusType.ST_ID
	JOIN table5 on FINWIRE_SEC.PTS = table5.PTS 