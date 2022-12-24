select 
	ActionType,
	cast(substring(ActionTS,1,10)+' '+substring(ActionTS,12,18) as datetime) as new_ActionTS,
	C_ID,
    C_TAX_ID,
    C_GNDR,
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
	end as MarketingNameplate
from tpc_di_stage.dbo.CustomerMgmt, tpc_di_stage.dbo.TaxRate as NationalTax, tpc_di_stage.dbo.TaxRate as LocalTax, tpc_di_stage.dbo.Prospect
where (ActionType = 'NEW'  or ActionType = 'UPDCUST' or ActionType = 'INACT')
	and CustomerMgmt.C_NAT_TX_ID = NationalTax.TX_ID and CustomerMgmt.C_LCL_TX_ID = LocalTax.TX_ID
	and upper(CustomerMgmt.C_F_NAME) = upper(Prospect.FirstName)
	and upper(CustomerMgmt.C_L_NAME) = upper(Prospect.LastName)
	and upper(CustomerMgmt.C_ADLINE1) = upper(Prospect.AddressLine1)
	and upper(CustomerMgmt.C_ADLINE2) = upper(Prospect.AddressLine2)
	and upper(CustomerMgmt.C_ZIPCODE) = upper(Prospect.PostalCode)
order by new_ActionTS;