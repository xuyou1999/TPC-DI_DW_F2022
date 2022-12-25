with table1 as(
select 
	ActionType,
	cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) as new_ActionTS,
	C_ID,
    C_TAX_ID,
	case 
		when upper(C_GNDR) = 'M' then 'M'
		when upper(C_GNDR) = 'F' then 'F'
		else 'U'
	end as C_GNDR,
    C_TIER,
	case when C_TIER is not null or count(C_ID) over (partition by C_ID) = 1 
		then ROW_NUMBER() over (order by C_ID, cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime)) 
	end as relavantid_tier,
	
    C_DOB,
    C_L_NAME,
    C_F_NAME,
    C_M_NAME,
    C_ADLINE1,
    C_ADLINE2,
    C_ZIPCODE,
    C_CITY,
    C_STATE_PROV,
    C_CTRY,
    C_PRIM_EMAIL,
    C_ALT_EMAIL,

    C_CTRY_CODE1,
    C_AREA_CODE1,
    C_LOCAL1,
    C_EXT1,
	case 
		when C_CTRY_CODE1 is not null 
			and C_AREA_CODE1 is not null
			and C_LOCAL1 is not null
			and C_EXT1 is null
			then '+'+C_CTRY_CODE1+'('+C_AREA_CODE1+')'+C_LOCAL1
		when C_CTRY_CODE1 is not null 
			and C_AREA_CODE1 is not null
			and C_LOCAL1 is not null
			and C_EXT1 is not null
			then '+'+C_CTRY_CODE1+'('+C_AREA_CODE1+')'+C_LOCAL1+C_EXT1
		when C_CTRY_CODE1 is null 
			and C_AREA_CODE1 is not null
			and C_LOCAL1 is not null
			and C_EXT1 is null
			then '('+C_AREA_CODE1+')'+C_LOCAL1
		when C_CTRY_CODE1 is null 
			and C_AREA_CODE1 is not null
			and C_LOCAL1 is not null
			and C_EXT1 is not null
			then '('+C_AREA_CODE1+')'+C_LOCAL1+C_EXT1
		when C_AREA_CODE1 is null
			and C_LOCAL1 is not null
			and C_EXT1 is null
			then C_LOCAL1
		when C_AREA_CODE1 is null
			and C_LOCAL1 is not null
			and C_EXT1 is not null
			then C_LOCAL1+C_EXT1
		else null
	end as Phone1,

    C_CTRY_CODE2,
    C_AREA_CODE2,
    C_LOCAL2,
    C_EXT2,
	case 
		when C_CTRY_CODE2 is not null 
			and C_AREA_CODE2 is not null
			and C_LOCAL2 is not null
			and C_EXT2 is null
			then '+'+C_CTRY_CODE2+'('+C_AREA_CODE2+')'+C_LOCAL2
		when C_CTRY_CODE2 is not null 
			and C_AREA_CODE2 is not null
			and C_LOCAL2 is not null
			and C_EXT2 is not null
			then '+'+C_CTRY_CODE2+'('+C_AREA_CODE2+')'+C_LOCAL2+C_EXT2
		when C_CTRY_CODE2 is null 
			and C_AREA_CODE2 is not null
			and C_LOCAL2 is not null
			and C_EXT2 is null
			then '('+C_AREA_CODE2+')'+C_LOCAL2
		when C_CTRY_CODE2 is null 
			and C_AREA_CODE2 is not null
			and C_LOCAL2 is not null
			and C_EXT2 is not null
			then '('+C_AREA_CODE2+')'+C_LOCAL2+C_EXT2
		when C_AREA_CODE2 is null
			and C_LOCAL2 is not null
			and C_EXT2 is null
			then C_LOCAL2
		when C_AREA_CODE2 is null
			and C_LOCAL2 is not null
			and C_EXT2 is not null
			then C_LOCAL2+C_EXT2
		else null
	end as Phone2,

    C_CTRY_CODE3,
    C_AREA_CODE3,
    C_LOCAL3,
    C_EXT3,
	case 
		when C_CTRY_CODE3 is not null 
			and C_AREA_CODE3 is not null
			and C_LOCAL3 is not null
			and C_EXT3 is null
			then '+'+C_CTRY_CODE3+'('+C_AREA_CODE3+')'+C_LOCAL3
		when C_CTRY_CODE3 is not null 
			and C_AREA_CODE3 is not null
			and C_LOCAL3 is not null
			and C_EXT3 is not null
			then '+'+C_CTRY_CODE3+'('+C_AREA_CODE3+')'+C_LOCAL3+C_EXT3
		when C_CTRY_CODE3 is null 
			and C_AREA_CODE3 is not null
			and C_LOCAL3 is not null
			and C_EXT3 is null
			then '('+C_AREA_CODE3+')'+C_LOCAL3
		when C_CTRY_CODE3 is null 
			and C_AREA_CODE3 is not null
			and C_LOCAL3 is not null
			and C_EXT3 is not null
			then '('+C_AREA_CODE3+')'+C_LOCAL3+C_EXT3
		when C_AREA_CODE3 is null
			and C_LOCAL3 is not null
			and C_EXT3 is null
			then C_LOCAL3
		when C_AREA_CODE3 is null
			and C_LOCAL3 is not null
			and C_EXT3 is not null
			then C_LOCAL3+C_EXT3
		else null
	end as Phone3,

    C_LCL_TX_ID,
	LocalTax.TX_NAME as LCL_TX_NAME,
	LocalTax.TX_RATE as LCL_TX_RATE,
    C_NAT_TX_ID,
	NationalTax.TX_NAME as NAT_TX_NAME,
	NationalTax.TX_RATE as NAT_TX_RATE,
    CA_ID,
    CA_TAX_ST,
    CA_B_ID,
    CA_NAME,
	AgencyID,
	CreditRating,
	NetWorth,
	case
		when NetWorth > 1000000 or Income > 200000 then 'HighValue'
		when NumberChildren > 3 or NumberCreditCards > 5 then 'Expenses'
		when Age > 45 then 'Boomer'
		when Income < 50000 or CreditRating < 600 or NetWorth < 100000 then 'MoneyAlert'
		when NumberCars > 3 or NumberCreditCards > 7 then 'Spender'
		when Age < 25 and NetWorth > 1000000 then 'Inherited'
	end as MarketingNameplate,
	'ACTIVE' as Status,
	cast(1 as bit) as IsCurrent,
	cast(substring(ActionTS,1,10) as date) as EffectiveDate,
	cast('9999-12-31' as date) as EndDate,
	1 as BatchID
from tpc_di_stage.dbo.CustomerMgmt 
left outer join tpc_di_stage.dbo.Prospect on upper(CustomerMgmt.C_F_NAME) = upper(Prospect.FirstName)
	and upper(CustomerMgmt.C_L_NAME) = upper(Prospect.LastName)
	and upper(CustomerMgmt.C_ADLINE1) = upper(Prospect.AddressLine1)
	and upper(CustomerMgmt.C_ADLINE2) = upper(Prospect.AddressLine2)
	and upper(CustomerMgmt.C_ZIPCODE) = upper(Prospect.PostalCode)
left outer join tpc_di_stage.dbo.TaxRate as NationalTax on CustomerMgmt.C_NAT_TX_ID = NationalTax.TX_ID
left outer join tpc_di_stage.dbo.TaxRate as LocalTax on CustomerMgmt.C_LCL_TX_ID = LocalTax.TX_ID
where ActionType = 'NEW' or ActionType = 'UPDCUST'
order by C_ID, new_ActionTS offset 0 rows),

table2 as(
select *, max(relavantid_tier) over (order by C_ID, new_ActionTS) as grp
from table1)

select *,
max(C_TIER) over (partition by grp order by new_ActionTS) as test
from table2