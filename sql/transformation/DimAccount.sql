with table0 as (select
ActionType,
cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) as new_ActionTS,
C_ID,
CA_ID,
CA_B_ID,
CA_NAME,
CA_TAX_ST
-- SK_BrokerID
from tpc_di_stage.dbo.CustomerMgmt
-- left outer join tpc_di_datawarehouse.dbo.DimBroker on CustomerMgmt.CA_B_ID = DimBroker.BrokerID
where ActionType = 'NEW' or ActionType = 'ADDACCT' or ActionType = 'UPDACCT' or ActionType = 'CLOSEACCT'
order by C_ID, cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) offset 0 rows),

table1 as(
select distinct
CustomerMgmt.ActionType,
cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) as new_ActionTS,
CustomerMgmt.C_ID,
table0.CA_ID,
null as CA_B_ID,
null as CA_NAME,
null as CA_TAX_ST

from tpc_di_stage.dbo.CustomerMgmt
left outer join tpc_di_datawarehouse.dbo.DimCustomer
	on CustomerMgmt.C_ID = DimCustomer.CustomerID 
	and cast(cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) as date) < DimCustomer.EffectiveDate
left outer join table0
	on CustomerMgmt.C_ID = table0.C_ID and table0.new_ActionTS < cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime)
where CustomerMgmt.ActionType = 'UPDCUST' or CustomerMgmt.ActionType = 'INACT'
order by C_ID, cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) offset 0 rows),

table2 as(
select * from table0 
union
select * from table1),

table3 as(
select
*,
case when CA_B_ID is not null or count(CA_ID) over (partition by CA_ID) = 1 or max(CA_B_ID) over(partition by CA_ID) is null
	then ROW_NUMBER() over (order by C_ID, CA_ID, new_ActionTS)
end as relavantid_cabid,
case when CA_NAME is not null or count(CA_ID) over (partition by CA_ID) = 1 or max(CA_NAME) over(partition by CA_ID) is null
	then ROW_NUMBER() over (order by C_ID, CA_ID, new_ActionTS)
end as relavantid_caname,
case when CA_TAX_ST is not null or count(CA_ID) over (partition by CA_ID) = 1 or max(CA_TAX_ST) over(partition by CA_ID) is null
	then ROW_NUMBER() over (order by C_ID, CA_ID, new_ActionTS) 
end as relavantid_cataxst
from table2),

table4 as(
select *,
max(relavantid_cabid) over (order by C_ID, CA_ID, new_ActionTS) as grp_cabid,
max(relavantid_caname) over (order by C_ID, CA_ID, new_ActionTS) as grp_caname,
max(relavantid_cataxst) over (order by C_ID, CA_ID, new_ActionTS) as grp_cataxst
from table3
),

table5 as (
select
ActionType,
new_ActionTS,
C_ID,
CA_ID,
max(CA_B_ID) over (partition by grp_cabid order by new_ActionTS) as new_CA_B_ID,
max(CA_NAME) over (partition by grp_caname order by new_ActionTS) as new_CA_NAME,
max(CA_TAX_ST) over (partition by grp_cataxst order by new_ActionTS) as new_CA_TAX_ST
from table4),

table6 as(
select 
ROW_NUMBER() over(partition by C_ID,CA_ID order by new_ActionTS desc) as row_number,
ActionType,
new_ActionTS,
C_ID,
CA_ID,
new_CA_B_ID,
new_CA_NAME,
new_CA_TAX_ST,
SK_BrokerID,
SK_CustomerID,
case
	when ActionType = 'INACT' then 'INACTIVE' 
	when ActionType = 'CLOSEACCT' then 'INACTIVE'
	else 'ACTIVE'
end as Status,
1 as BatchID,
cast(new_ActionTS as date) as EffectiveDate
from table5
left outer join tpc_di_datawarehouse.dbo.DimBroker on table5.new_CA_B_ID = DimBroker.BrokerID
left outer join tpc_di_datawarehouse.dbo.DimCustomer 
	on table5.C_ID = DimCustomer.CustomerID and cast(table5.new_ActionTS as date) >= DimCustomer.EffectiveDate and cast(table5.new_ActionTS as date) < DimCustomer.EndDate)

select *,
lead(EffectiveDate,1,cast('9999-12-31' as date)) over (partition by C_ID, CA_ID order by new_ActionTS) as EndDate,
case when row_number = 1 then cast(1 as bit)
	else cast(0 as bit) end as IsCurrent
from table6
order by C_ID, CA_ID, new_ActionTS
;