select 
cast(substring(PTS,1,4)+'-'+substring(PTS,5,2)+'-'+substring(PTS,7,2)+' '+substring(PTS,10,2)+':'+substring(PTS,12,2)+':'+substring(PTS,14,2) as datetime) as MessageDateAndTime,
'DimCompany' as MessageSource,
'Alert' as MessageType,
'Invalid SPRating' as MessageText,
'CO_ID = '+CIK+', CO_SP_RATE = '+ SPrating as MessageData,
1 as BatchID
from tpc_di_stage.dbo.FINWIRE_CMP
where not (SPrating = 'AAA' 
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
			or SPrating = 'D' ) ;