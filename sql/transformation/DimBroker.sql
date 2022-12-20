select 
	ROW_NUMBER() over(order by(select null)) as SK_BrokerID, 
	EmployeeID as BrokerID, 
	HR.ManagerID as ManagerID,
	EmployeeFirstName as FirstName,
	EmployeeLastName as LastName,
	EmployeeMI as MiddleInitial,
	EmployeeBranch as Branch,
	EmployeeOffice as Office,
	EmployeePhone as Phone,
	cast(1 as bit) as IsCurrent,
	cast(1 as decimal) as BatchID, 
	(select min(DateValue) from tpc_di_datawarehouse.dbo.DimDate) as EffectiveDate,
	cast('9999-12-31' as date) as Enddate
from tpc_di_stage.dbo.HR, tpc_di_stage.dbo.BatchDate
where EmployeeJobCode = 314;