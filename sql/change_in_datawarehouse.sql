use tpc_di_datawarehouse;
drop table if exists DimSecurity;
create table DimSecurity(
SK_SecurityID bigint Not NULL ,
Symbol CHAR(15) Not NULL ,
Issue CHAR(6) Not NULL ,
Status CHAR(10) Not NULL ,
Name CHAR(70) Not NULL ,
ExchangeID CHAR(6) Not NULL ,
SK_CompanyID bigint Not NULL ,
SharesOutstanding bigint Not NULL ,
FirstTrade varchar(8) Not NULL ,                 --change
FirstTradeOnExchange varchar(8) Not NULL,        --change
Dividend decimal(10,2) Not NULL ,
IsCurrent BIT Not NULL ,
BatchID decimal(5,0) Not NULL ,
EffectiveDate DATE Not NULL ,
EndDate DATE Not NULL 
);

drop table if exists DimTrade;
create table DimTrade (
TradeID bigint Not NULL ,
SK_BrokerID bigint ,
SK_CreateDateID date ,  --change
SK_CreateTimeID date  ,  --change
SK_CloseDateID time(7) ,  --change
SK_CloseTimeID time(7) ,  --change
Status CHAR(10) Not NULL ,
Type CHAR(12) Not NULL,
CashFlag BIT Not NULL ,
SK_SecurityID bigint Not NULL ,
SK_CompanyID bigint Not NULL ,
Quantity decimal(6,0) Not NULL ,
BidPrice decimal(8,2) Not NULL ,
SK_CustomerID bigint Not NULL,
SK_AccountID bigint Not NULL,
ExecutedBy CHAR(64) Not NULL ,
TradePrice decimal(8,2) ,
Fee decimal(10,2) ,
Commission decimal(10,2) ,
Tax decimal(10,2) ,
BatchID decimal(5,0) Not Null
);

drop table if exists Financial;
create table Financial (
SK_CompanyID bigint Not NULL ,
FI_YEAR decimal(4,0) Not NULL ,
FI_QTR decimal(1,0) Not NULL ,
FI_QTR_START_DATE varchar(8) Not NULL ,   --change
FI_REVENUE decimal(15,2) Not NULL ,
FI_NET_EARN decimal(15,2) Not NULL ,
FI_BASIC_EPS decimal(10,2) Not NULL ,
FI_DILUT_EPS decimal(10,2) Not NULL ,
FI_MARGIN decimal(10,2) Not NULL ,
FI_INVENTORY decimal(15,2) Not NULL ,
FI_ASSETS decimal(15,2) Not NULL ,
FI_LIABILITY decimal(15,2) Not NULL ,
FI_OUT_BASIC decimal(12,0) Not NULL ,
FI_OUT_DILUT decimal(12,0) Not NULL
);

drop table if exists FactHoldings;
create table FactHoldings (
TradeID bigint Not NULL ,
CurrentTradeID bigint Not Null ,
SK_CustomerID bigint Not NULL ,
SK_AccountID bigint Not NULL ,
SK_SecurityID bigint Not NULL ,
SK_CompanyID bigint Not NULL ,
SK_DateID time(7)  ,               --change
SK_TimeID time(7)  ,               --change
CurrentPrice decimal(8,2) check (CurrentPrice > 0) ,
CurrentHolding decimal(6,0) Not NULL ,
BatchID decimal(5,0) Not Null 
);


--select * from DimBroker;