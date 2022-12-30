select 
	ROW_NUMBER() over(order by(select null)) as SK_CompanyID,
	CIK as CompanyID,
	ST_NAME as Status,
	CompanyName as Name,
	IN_NAME as Industry,
	case when SPrating = 'AAA' 
			or SPrating = 'AA'
			or SPrating = 'AA+'
			or SPrating = 'AA-' 
			or SPrating = 'A'
			or SPrating = 'A+' 
			or SPrating = 'A-' 
			or SPrating = 'BBB' 
			or SPrating = 'BBB+' 
			or SPrating = 'BBB-' 
			or SPrating = 'BB' 
			or SPrating = 'BB+' 
			or SPrating = 'BB-' 
			or SPrating = 'B' 
			or SPrating = 'B+' 
			or SPrating = 'B-' 
			or SPrating = 'CCC' 
			or SPrating = 'CCC+' 
			or SPrating = 'CCC-' 
			or SPrating = 'CC'
			or SPrating = 'C' 
			or SPrating = 'D' 
			then SPrating
		else null
	end
		as SPrating,
	cast((case
		when (SPrating = 'AAA' 
			or SPrating = 'AA'
			or SPrating = 'AA+'
			or SPrating = 'AA-' 
			or SPrating = 'A'
			or SPrating = 'A+' 
			or SPrating = 'A-' 
			or SPrating = 'BBB' 
			or SPrating = 'BBB+' 
			or SPrating = 'BBB-' 
			or SPrating = 'BB' 
			or SPrating = 'BB+' 
			or SPrating = 'BB-' 
			or SPrating = 'B' 
			or SPrating = 'B+' 
			or SPrating = 'B-' 
			or SPrating = 'CCC' 
			or SPrating = 'CCC+' 
			or SPrating = 'CCC-' 
			or SPrating = 'CC'
			or SPrating = 'C' 
			or SPrating = 'D') and (SPrating like 'A%' or SPrating like 'BBB%') then 0
		when (SPrating = 'AAA' 
			or SPrating = 'AA'
			or SPrating = 'AA+'
			or SPrating = 'AA-' 
			or SPrating = 'A'
			or SPrating = 'A+' 
			or SPrating = 'A-' 
			or SPrating = 'BBB' 
			or SPrating = 'BBB+' 
			or SPrating = 'BBB-' 
			or SPrating = 'BB' 
			or SPrating = 'BB+' 
			or SPrating = 'BB-' 
			or SPrating = 'B' 
			or SPrating = 'B+' 
			or SPrating = 'B-' 
			or SPrating = 'CCC' 
			or SPrating = 'CCC+' 
			or SPrating = 'CCC-' 
			or SPrating = 'CC'
			or SPrating = 'C' 
			or SPrating = 'D') and not (SPrating like 'A%' or SPrating like 'BBB%') then 1
		else null
	end) as bit) as isLowGrade,
	CEOname as CEO,
	AddrLine1 as AddressLine1,
	AddrLine2 as AddressLIne2,
	PostalCode as PostalCode,
	City as City,
	StateProvince as StateProv,
	Country as Country,
	Description as Description,
	cast(FoundingDate as date) as FoundingDate,
	cast((case when ST_NAME = 'Inactive' then 0
		else 1 end) as bit) as IsCurrent,
	1 as BatchID,
	cast(substring(PTS,1,8) as date) as EffectiveDate,
	(case when ST_NAME = 'Inactive' then (select BatchDate from tpc_di_stage.dbo.BatchDate)
		else cast('9999-12-31' as date) end) as EndDate
from tpc_di_stage.dbo.FINWIRE_CMP, tpc_di_stage.dbo.StatusType, tpc_di_stage.dbo.Industry
where FINWIRE_CMP.Status = StatusType.ST_ID
	and FINWIRE_CMP.IndustryID = Industry.IN_ID
order by CompanyID;