SELECT 
AgencyID,
DimDate.SK_DateID AS SK_RecordDateID,
DimDate.SK_DateID AS SK_UpdateDateID,
CAST(1 as decimal) AS BatchID,
CASE 
	WHEN EXISTS
	(
		SELECT * FROM tpc_di_datawarehouse.dbo.DimCustomer DimCustomer 
		WHERE DimCustomer.Status = 'ACTIVE'
		AND UPPER(DimCustomer.FirstName) = UPPER(Prospect.FirstName)
		AND UPPER(DimCustomer.LastName) = UPPER(Prospect.LastName)
		AND UPPER(DimCustomer.AddressLine1) = UPPER(Prospect.AddressLine1)
		AND UPPER(DimCustomer.AddressLine2) = UPPER(Prospect.AddressLine2)
		AND UPPER(DimCustomer.PostalCode) = UPPER(Prospect.PostalCode)
	) THEN 'True'
	ELSE 'False'
END AS IsCustomer,

LastName, 
FirstName, 
MiddleInitial, 
Gender, 
AddressLine1, 
AddressLine2, 
PostalCode, 
City,
State, 
Country, 
Phone, 
Income, 
numberCars, 
numberChildren, 
MaritalStatus, 
Age, 
CreditRating, 
OwnOrRentFlag, 
Employer, 
numberCreditCards, 
NetWorth,

CASE 
	WHEN NetWorth > 1000000 OR Income > 200000 THEN 'HighValue'
	WHEN NumberChildren > 3 OR NumberCreditCards > 5 THEN 'Expenses'
	WHEN Age > 45 THEN @tag+'Boomer'
	WHEN Income < 50000 OR CreditRating < 600 OR NetWorth < 100000 THEN 'MoneyAlert'
	WHEN NumberCars > 3 OR NumberCreditCards > 7 THEN 'Spender'
	WHEN Age < 25 AND NetWorth > 1000000 THEN 'Inherited'
END AS MarketingNameplate 

from tpc_di_stage.dbo.Prospect Prospect, tpc_di_stage.dbo.BatchDate
INNER JOIN tpc_di_datawarehouse.dbo.DimDate
ON (tpc_di_stage.dbo.BatchDate.BatchDate = tpc_di_datawarehouse.dbo.DimDate.DateValue)
