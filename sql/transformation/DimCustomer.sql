with table0 as(
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
    C_CTRY_CODE2,
    C_AREA_CODE2,
    C_LOCAL2,
    C_EXT2,
    C_CTRY_CODE3,
    C_AREA_CODE3,
    C_LOCAL3,
    C_EXT3,
    C_LCL_TX_ID,
    C_NAT_TX_ID,
    CA_ID,
    CA_TAX_ST,
    CA_B_ID,
    CA_NAME,
	1 as BatchID
from tpc_di_stage.dbo.CustomerMgmt 
where ActionType = 'NEW' or ActionType = 'UPDCUST'
order by C_ID, new_ActionTS offset 0 rows),

table1 as(
select *,
case when C_TAX_ID is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_TAX_ID) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_ctaxid,
case when C_GNDR is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_GNDR) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cgndr,
case when C_TIER is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_TIER) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_tier,
case when C_DOB is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_DOB) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cdob,
case when C_L_NAME is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_L_NAME) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_clname,
case when C_F_NAME is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_F_NAME) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cfname,
case when C_M_NAME is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_M_NAME) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cmname,
case when C_ADLINE1 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_ADLINE1) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cadline1,
case when C_ADLINE2 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_ADLINE2) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cadline2,
case when C_ZIPCODE is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_ZIPCODE) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_czipcode,
case when C_CITY is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_CITY) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_ccity,
case when C_STATE_PROV is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_STATE_PROV) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cstateprov,
case when C_CTRY is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_CTRY) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_ctry,
case when C_PRIM_EMAIL is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_PRIM_EMAIL) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cprimemail,
case when C_ALT_EMAIL is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_ALT_EMAIL) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_caltemail,
case when C_CTRY_CODE1 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_CTRY_CODE1) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cctrycode1,
case when C_AREA_CODE1 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_AREA_CODE1) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_careacode1,
case when C_LOCAL1 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_LOCAL1) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_clocal1,
case when C_EXT1 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_EXT1) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cext1,
case when C_CTRY_CODE2 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_CTRY_CODE2) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cctrycode2,
case when C_AREA_CODE2 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_AREA_CODE2) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_careacode2,
case when C_LOCAL2 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_LOCAL2) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_clocal2,
case when C_EXT2 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_EXT2) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cext2,
case when C_CTRY_CODE3 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_CTRY_CODE3) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cctrycode3,
case when C_AREA_CODE3 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_AREA_CODE3) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_careacode3,
case when C_LOCAL3 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_LOCAL3) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_clocal3,
case when C_EXT3 is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_EXT3) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cext3,
case when C_LCL_TX_ID is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_LCL_TX_ID) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_clcltxid,
case when C_NAT_TX_ID is not null or count(C_ID) over (partition by C_ID) = 1 or max(C_NAT_TX_ID) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cnattxid,
case when CA_ID is not null or count(C_ID) over (partition by C_ID) = 1 or max(CA_ID) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_caid,
case when CA_TAX_ST is not null or count(C_ID) over (partition by C_ID) = 1 or max(CA_TAX_ST) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cataxst,
case when CA_B_ID is not null or count(C_ID) over (partition by C_ID) = 1 or max(CA_B_ID) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_cabid,
case when CA_NAME is not null or count(C_ID) over (partition by C_ID) = 1 or max(CA_NAME) over(partition by C_ID) is null
	then ROW_NUMBER() over (order by C_ID, new_ActionTS) 
end as relavantid_caname
from table0
),

table2 as(
select *, 
max(relavantid_ctaxid) over (order by C_ID, new_ActionTS) as grp_ctaxid,
max(relavantid_cgndr) over (order by C_ID, new_ActionTS) as grp_cgndr,
max(relavantid_tier) over (order by C_ID, new_ActionTS) as grp_tier,
max(relavantid_cdob) over (order by C_ID, new_ActionTS) as grp_cdob,
max(relavantid_clname) over (order by C_ID, new_ActionTS) as grp_clname,
max(relavantid_cfname) over (order by C_ID, new_ActionTS) as grp_cfname,
max(relavantid_cmname) over (order by C_ID, new_ActionTS) as grp_cmname,
max(relavantid_cadline1) over (order by C_ID, new_ActionTS) as grp_cadline1,
max(relavantid_cadline2) over (order by C_ID, new_ActionTS) as grp_cadline2,
max(relavantid_czipcode) over (order by C_ID, new_ActionTS) as grp_czipcode,
max(relavantid_ccity) over (order by C_ID, new_ActionTS) as grp_ccity,
max(relavantid_cstateprov) over (order by C_ID, new_ActionTS) as grp_cstateprov,
max(relavantid_ctry) over (order by C_ID, new_ActionTS) as grp_ctry,
max(relavantid_cprimemail) over (order by C_ID, new_ActionTS) as grp_cprimemail,
max(relavantid_caltemail) over (order by C_ID, new_ActionTS) as grp_caltemail,
max(relavantid_cctrycode1) over (order by C_ID, new_ActionTS) as grp_cctrycode1,
max(relavantid_careacode1) over (order by C_ID, new_ActionTS) as grp_careacode1,
max(relavantid_clocal1) over (order by C_ID, new_ActionTS) as grp_clocal1,
max(relavantid_cext1) over (order by C_ID, new_ActionTS) as grp_cext1,
max(relavantid_cctrycode2) over (order by C_ID, new_ActionTS) as grp_cctrycode2,
max(relavantid_careacode2) over (order by C_ID, new_ActionTS) as grp_careacode2,
max(relavantid_clocal2) over (order by C_ID, new_ActionTS) as grp_clocal2,
max(relavantid_cext2) over (order by C_ID, new_ActionTS) as grp_cext2,
max(relavantid_cctrycode3) over (order by C_ID, new_ActionTS) as grp_cctrycode3,
max(relavantid_careacode3) over (order by C_ID, new_ActionTS) as grp_careacode3,
max(relavantid_clocal3) over (order by C_ID, new_ActionTS) as grp_clocal3,
max(relavantid_cext3) over (order by C_ID, new_ActionTS) as grp_cext3,
max(relavantid_clcltxid) over (order by C_ID, new_ActionTS) as grp_clcltxid,
max(relavantid_cnattxid) over (order by C_ID, new_ActionTS) as grp_cnattxid,
max(relavantid_caid) over (order by C_ID, new_ActionTS) as grp_caid,
max(relavantid_cataxst) over (order by C_ID, new_ActionTS) as grp_cataxst,
max(relavantid_cabid) over (order by C_ID, new_ActionTS) as grp_cabid,
max(relavantid_caname) over (order by C_ID, new_ActionTS) as grp_caname
from table1),

table3 as(
select 
ActionType,
C_ID,
new_ActionTS,
BatchID,
max(C_TAX_ID) over (partition by grp_ctaxid order by new_ActionTS) as new_C_TAX_ID,
max(C_GNDR) over (partition by grp_cgndr order by new_ActionTS) as new_C_GNDR,
max(C_TIER) over (partition by grp_tier order by new_ActionTS) as new_C_TIER,
max(C_DOB) over (partition by grp_cdob order by new_ActionTS) as new_C_DOB,
max(C_L_NAME) over (partition by grp_clname order by new_ActionTS) as new_C_L_NAME,
max(C_F_NAME) over (partition by grp_cfname order by new_ActionTS) as new_C_F_NAME,
max(C_M_NAME) over (partition by grp_cmname order by new_ActionTS) as new_C_M_NAME,
max(C_ADLINE1) over (partition by grp_cadline1 order by new_ActionTS) as new_C_ADLINE1,
max(C_ADLINE2) over (partition by grp_cadline2 order by new_ActionTS) as new_C_ADLINE2,
max(C_ZIPCODE) over (partition by grp_czipcode order by new_ActionTS) as new_C_ZIPCODE,
max(C_CITY) over (partition by grp_ccity order by new_ActionTS) as new_C_CITY,
max(C_STATE_PROV) over (partition by grp_cstateprov order by new_ActionTS) as new_C_STATE_PROV,
max(C_CTRY) over (partition by grp_ctry order by new_ActionTS) as new_C_CTRY,
max(C_PRIM_EMAIL) over (partition by grp_cprimemail order by new_ActionTS) as new_C_PRIM_EMAIL,
max(C_ALT_EMAIL) over (partition by grp_caltemail order by new_ActionTS) as new_C_ALT_EMAIL,
max(C_CTRY_CODE1) over (partition by grp_cctrycode1 order by new_ActionTS) as new_C_CTRY_CODE1,
max(C_AREA_CODE1) over (partition by grp_careacode1 order by new_ActionTS) as new_C_AREA_CODE1,
max(C_LOCAL1) over (partition by grp_clocal1 order by new_ActionTS) as new_C_LOCAL1,
max(C_EXT1) over (partition by grp_cext1 order by new_ActionTS) as new_C_EXT1,
max(C_CTRY_CODE2) over (partition by grp_cctrycode2 order by new_ActionTS) as new_C_CTRY_CODE2,
max(C_AREA_CODE2) over (partition by grp_careacode2 order by new_ActionTS) as new_C_AREA_CODE2,
max(C_LOCAL2) over (partition by grp_clocal2 order by new_ActionTS) as new_C_LOCAL2,
max(C_EXT2) over (partition by grp_cext2 order by new_ActionTS) as new_C_EXT2,
max(C_CTRY_CODE3) over (partition by grp_cctrycode3 order by new_ActionTS) as new_C_CTRY_CODE3,
max(C_AREA_CODE3) over (partition by grp_careacode3 order by new_ActionTS) as new_C_AREA_CODE3,
max(C_LOCAL3) over (partition by grp_clocal3 order by new_ActionTS) as new_C_LOCAL3,
max(C_EXT3) over (partition by grp_cext3 order by new_ActionTS) as new_C_EXT3,
max(C_LCL_TX_ID) over (partition by grp_clcltxid order by new_ActionTS) as new_C_LCL_TX_ID,
max(C_NAT_TX_ID) over (partition by grp_cnattxid order by new_ActionTS) as new_C_NAT_TX_ID,
max(CA_ID) over (partition by grp_caid order by new_ActionTS) as new_CA_ID,
max(CA_TAX_ST) over (partition by grp_cataxst order by new_ActionTS) as new_CA_TAX_ST,
max(CA_B_ID) over (partition by grp_cabid order by new_ActionTS) as new_CA_B_ID,
max(CA_NAME) over (partition by grp_caname order by new_ActionTS) as new_CA_NAME
from table2),

table4 as (
select 
ActionType,
C_ID,
ROW_NUMBER() over(partition by C_ID order by new_ActionTS desc) as row_number,
new_ActionTS,
new_C_TAX_ID,
new_C_GNDR,
new_C_TIER,
new_C_DOB,
new_C_L_NAME,
new_C_F_NAME,
new_C_M_NAME,
new_C_ADLINE1,
new_C_ADLINE2,
new_C_ZIPCODE,
new_C_CITY,
new_C_STATE_PROV,
new_C_CTRY,
new_C_PRIM_EMAIL,
new_C_ALT_EMAIL,
case 
	when new_C_CTRY_CODE1 is not null 
		and new_C_AREA_CODE1 is not null
		and new_C_LOCAL1 is not null
		and new_C_EXT1 is null
		then '+'+new_C_CTRY_CODE1+'('+new_C_AREA_CODE1+')'+new_C_LOCAL1
	when new_C_CTRY_CODE1 is not null 
		and new_C_AREA_CODE1 is not null
		and new_C_LOCAL1 is not null
		and new_C_EXT1 is not null
		then '+'+new_C_CTRY_CODE1+'('+new_C_AREA_CODE1+')'+new_C_LOCAL1+new_C_EXT1
	when new_C_CTRY_CODE1 is null 
		and new_C_AREA_CODE1 is not null
		and new_C_LOCAL1 is not null
		and new_C_EXT1 is null
		then '('+new_C_AREA_CODE1+')'+new_C_LOCAL1
	when new_C_CTRY_CODE1 is null 
		and new_C_AREA_CODE1 is not null
		and new_C_LOCAL1 is not null
		and new_C_EXT1 is not null
		then '('+new_C_AREA_CODE1+')'+new_C_LOCAL1+new_C_EXT1
	when new_C_AREA_CODE1 is null
		and new_C_LOCAL1 is not null
		and new_C_EXT1 is null
		then new_C_LOCAL1
	when new_C_AREA_CODE1 is null
		and new_C_LOCAL1 is not null
		and new_C_EXT1 is not null
		then new_C_LOCAL1+new_C_EXT1
	else null
end as Phone1,

case 
	when new_C_CTRY_CODE2 is not null 
		and new_C_AREA_CODE2 is not null
		and new_C_LOCAL2 is not null
		and new_C_EXT2 is null
		then '+'+new_C_CTRY_CODE2+'('+new_C_AREA_CODE2+')'+new_C_LOCAL2
	when new_C_CTRY_CODE2 is not null 
		and new_C_AREA_CODE2 is not null
		and new_C_LOCAL2 is not null
		and new_C_EXT2 is not null
		then '+'+new_C_CTRY_CODE2+'('+new_C_AREA_CODE2+')'+new_C_LOCAL2+new_C_EXT2
	when new_C_CTRY_CODE2 is null 
		and new_C_AREA_CODE2 is not null
		and new_C_LOCAL2 is not null
		and new_C_EXT2 is null
		then '('+new_C_AREA_CODE2+')'+new_C_LOCAL2
	when new_C_CTRY_CODE2 is null 
		and new_C_AREA_CODE2 is not null
		and new_C_LOCAL2 is not null
		and new_C_EXT2 is not null
		then '('+new_C_AREA_CODE2+')'+new_C_LOCAL2+new_C_EXT2
	when new_C_AREA_CODE2 is null
		and new_C_LOCAL2 is not null
		and new_C_EXT2 is null
		then new_C_LOCAL2
	when new_C_AREA_CODE2 is null
		and new_C_LOCAL2 is not null
		and new_C_EXT2 is not null
		then new_C_LOCAL2+new_C_EXT2
	else null
end as Phone2,

case 
	when new_C_CTRY_CODE3 is not null 
		and new_C_AREA_CODE3 is not null
		and new_C_LOCAL3 is not null
		and new_C_EXT3 is null
		then '+'+new_C_CTRY_CODE3+'('+new_C_AREA_CODE3+')'+new_C_LOCAL3
	when new_C_CTRY_CODE3 is not null 
		and new_C_AREA_CODE3 is not null
		and new_C_LOCAL3 is not null
		and new_C_EXT3 is not null
		then '+'+new_C_CTRY_CODE3+'('+new_C_AREA_CODE3+')'+new_C_LOCAL3+new_C_EXT3
	when new_C_CTRY_CODE3 is null 
		and new_C_AREA_CODE3 is not null
		and new_C_LOCAL3 is not null
		and new_C_EXT3 is null
		then '('+new_C_AREA_CODE3+')'+new_C_LOCAL3
	when new_C_CTRY_CODE3 is null 
		and new_C_AREA_CODE3 is not null
		and new_C_LOCAL3 is not null
		and new_C_EXT3 is not null
		then '('+new_C_AREA_CODE3+')'+new_C_LOCAL3+new_C_EXT3
	when new_C_AREA_CODE3 is null
		and new_C_LOCAL3 is not null
		and new_C_EXT3 is null
		then new_C_LOCAL3
	when new_C_AREA_CODE3 is null
		and new_C_LOCAL3 is not null
		and new_C_EXT3 is not null
		then new_C_LOCAL3+new_C_EXT3
	else null
end as Phone3,
new_C_LCL_TX_ID,
new_C_NAT_TX_ID,
new_CA_ID,
new_CA_TAX_ST,
new_CA_B_ID,
new_CA_NAME,
LocalTax.TX_NAME as new_LCL_TX_NAME,
LocalTax.TX_RATE as new_LCL_TX_RATE,
NationalTax.TX_NAME as new_NAT_TX_NAME,
NationalTax.TX_RATE as new_NAT_TX_RATE,
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
case
	when ActionType = 'INACT' then 'INACTIVE' 
	else 'ACTIVE'
end as Status,
cast(new_ActionTS as date) as EffectiveDate
from table3
left outer join tpc_di_stage.dbo.Prospect on upper(table3.new_C_F_NAME) = upper(Prospect.FirstName)
	and upper(table3.new_C_L_NAME) = upper(Prospect.LastName)
	and upper(table3.new_C_ADLINE1) = upper(Prospect.AddressLine1)
	and upper(table3.new_C_ADLINE2) = upper(Prospect.AddressLine2)
	and upper(table3.new_C_ZIPCODE) = upper(Prospect.PostalCode)
left outer join tpc_di_stage.dbo.TaxRate as NationalTax on table3.new_C_NAT_TX_ID = NationalTax.TX_ID
left outer join tpc_di_stage.dbo.TaxRate as LocalTax on table3.new_C_LCL_TX_ID = LocalTax.TX_ID
order by C_ID, new_ActionTS offset 0 rows
)

select *,
lead(EffectiveDate,1,cast('9999-12-31' as date)) over (partition by C_ID order by new_ActionTS) as EndDate,
case when row_number = 1 then cast(1 as bit)
	else cast(0 as bit) end as IsCurrent
from table4
order by new_ActionTS;