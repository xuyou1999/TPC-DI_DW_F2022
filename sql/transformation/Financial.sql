WITH table0 AS 
(
	SELECT 
	CAST ( 
		CONCAT ( 
			SUBSTRING( PTS, 0, 5 ), '-', 
			SUBSTRING( PTS, 5, 2 ) , '-', 
			SUBSTRING( PTS, 7, 2 )
		) AS DATE
	) AS PTS, 
	CASE 
		WHEN ISNUMERIC( CoNameOrCIK ) = 1 
		THEN CAST( CoNameOrCIK AS INT ) 
		ELSE NULL 
	END AS CIK,
	CASE 
		WHEN ISNUMERIC( CoNameOrCIK ) = 0 
		THEN CoNameOrCIK 
		ELSE NULL 
	END AS CoName, 
	Year AS FI_YEAR, 
	Quarter AS FI_QTR, 
	QtrStartDate AS FI_QTR_START_DATE, 
	Revenue AS FI_REVENUE, 
	Earnings AS FI_NET_EARN, 
	EPS AS FI_BASIC_EPS, 
	DilutedEPS AS FI_DILUT_EPS, 
	Margin AS FI_MARGIN, 
	Inventory AS FI_INVENTORY, 
	Assets AS FI_ASSETS, 
	Liabilities AS FI_LIABILITY, 
	ShOut AS FI_OUT_BASIC, 
	DilutedShOut AS FI_OUT_DILUT
	FROM tpc_di_stage.dbo.FINWIRE_FIN
)



SELECT DC.SK_CompanyID AS SK_CompanyID, 
FI_YEAR, 
FI_QTR, 
FI_QTR_START_DATE, 
FI_REVENUE, 
FI_NET_EARN, 
FI_BASIC_EPS, 
FI_DILUT_EPS, 
FI_MARGIN, 
FI_INVENTORY, 
FI_ASSETS, 
FI_LIABILITY, 
FI_OUT_BASIC, 
FI_OUT_DILUT
FROM table0
INNER JOIN tpc_di_datawarehouse.dbo.DimCompany DC 
ON (table0.CIK = DC.CompanyID OR table0.CoName = DC.Name)
WHERE (DC.EffectiveDate <= table0.PTS)
AND (table0.PTS < DC.EndDate)
AND (DC.IsCurrent = 1)
