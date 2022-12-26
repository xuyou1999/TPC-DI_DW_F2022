drop database if exists tpc_di_datawarehouse;
create database tpc_di_datawarehouse;
use tpc_di_datawarehouse;

drop table if exists DimAccount;
create table DimAccount (

SK_AccountID bigint Not NULL ,
AccountID bigint Not NULL ,
SK_BrokerID bigint Not NULL ,
SK_CustomerID bigint Not NULL ,
Status CHAR(10) Not NULL ,
AccountDesc CHAR(50),
TaxStatus int check (TaxStatus in (0,1,2)),
IsCurrent BIT Not NULL ,
BatchID decimal(5,0) Not NULL ,
EffectiveDate DATE Not NULL ,
EndDate DATE Not NULL 
);

drop table if exists DimBroker;
create table DimBroker(
SK_BrokerID bigint Not NULL ,
BrokerID bigint Not NULL ,
ManagerID bigint ,
FirstName CHAR(50) Not NULL ,
LastName CHAR(50) Not NULL ,
MiddleInitial CHAR(1) ,
Branch CHAR(50) ,
Office CHAR(50) ,
Phone CHAR(14) ,
IsCurrent BIT Not NULL ,
BatchID decimal(5,0) Not NULL ,
EffectiveDate DATE Not NULL ,
EndDate DATE Not NULL 
);

drop table if exists DimCompany;
create table DimCompany (
SK_CompanyID bigint Not NULL ,
CompanyID bigint Not NULL ,
Status CHAR(10) Not NULL ,
Name CHAR(60) Not NULL ,
Industry CHAR(50) Not NULL,
SPrating CHAR(4) ,
isLowGrade BIT ,
CEO CHAR(100) Not NULL ,
AddressLine1 CHAR(80) ,
AddressLine2 CHAR(80) ,
PostalCode CHAR(12) Not NULL ,
City CHAR(25) Not NULL ,
StateProv CHAR(20) Not NULL ,
Country CHAR(24) ,
Description CHAR(150) Not NULL ,
FoundingDate DATE ,
IsCurrent BIT Not NULL ,
BatchID decimal(5,0) Not NULL ,
EffectiveDate DATE Not NULL ,
EndDate DATE Not NULL
);

drop table if exists DimCustomer;
create table DimCustomer (
SK_CustomerID bigint identity(1,1) Not NULL ,
CustomerID bigint Not NULL ,
TaxID CHAR(20) Not NULL ,
Status CHAR(10) Not NULL ,
LastName CHAR(30) Not NULL ,
FirstName CHAR(30) Not NULL ,
MiddleInitial CHAR(1) ,
Gender CHAR(1) ,
Tier decimal(1,0) ,
DOB DATE Not NULL,
AddressLine1 CHAR(80) Not NULL ,
AddressLine2 CHAR(80) ,
PostalCode CHAR(12) Not NULL ,
City CHAR(25) Not NULL ,
StateProv CHAR(20) Not NULL ,
Country CHAR(24) ,
Phone1 CHAR(30) ,
Phone2 CHAR(30) ,
Phone3 CHAR(30) ,
Email1 CHAR(50) ,
Email2 CHAR(50) ,
NationalTaxRateDesc CHAR(50) ,
NationalTaxRate decimal(6,5) ,
LocalTaxRateDesc CHAR(50) ,
LocalTaxRate decimal(6,5) ,
AgencyID CHAR(30) ,
CreditRating decimal(5,0) ,
NetWorth decimal(10,0) ,
MarketingNameplate CHAR(100) ,
IsCurrent BIT Not NULL ,
BatchID decimal(5,0) Not NULL ,
EffectiveDate DATE Not NULL ,
EndDate DATE Not NULL 
);

drop table if exists DimDate;
create table DimDate (
SK_DateID bigint Not NULL ,
DateValue DATE Not NULL ,
DateDesc CHAR(20) Not NULL ,
CalendarYearID decimal(4,0) Not NULL ,
CalendarYearDesc CHAR(20) Not NULL ,
CalendarQtrID decimal(5,0) Not NULL ,
CalendarQtrDesc CHAR(20) Not NULL,
CalendarMonthID decimal(6,0) Not NULL ,
CalendarMonthDesc CHAR(20) Not NULL ,
CalendarWeekID decimal(6,0) Not NULL ,
CalendarWeekDesc CHAR(20) Not NULL ,
DayOfWeekNum decimal(1,0) Not NULL ,
DayOfWeekDesc CHAR(10) Not NULL ,
FiscalYearID decimal(4,0) Not NULL ,
FiscalYearDesc CHAR(20) Not NULL ,
FiscalQtrID decimal(5,0) Not NULL ,
FiscalQtrDesc CHAR(20) Not NULL ,
HolidayFlag BIT 
);

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
FirstTrade DATE Not NULL ,
FirstTradeOnExchange DATE Not NULL,
Dividend decimal(10,2) Not NULL ,
IsCurrent BIT Not NULL ,
BatchID decimal(5,0) Not NULL ,
EffectiveDate DATE Not NULL ,
EndDate DATE Not NULL 
);

drop table if exists DimTime;
create table DimTime (
SK_TimeID bigint Not NULL ,
TimeValue TIME Not NULL ,
HourID decimal(2,0) Not NULL ,
HourDesc CHAR(20) Not NULL ,
MinuteID decimal(2,0) Not NULL ,
MinuteDesc CHAR(20) Not NULL ,
SecondID decimal(2,0) Not NULL ,
SecondDesc CHAR(20) Not NULL ,
MarketHoursFlag BIT ,
OfficeHoursFlag BIT 
);

drop table if exists DimTrade;
create table DimTrade (
TradeID bigint Not NULL ,
SK_BrokerID bigint ,
SK_CreateDateID bigint Not NULL,
SK_CreateTimeID bigint Not NULL ,
SK_CloseDateID bigint ,
SK_CloseTimeID bigint ,
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

drop table if exists DImessages;
create table DImessages (
MessageDateAndTime DATETIME,
BatchID decimal(5,0) Not NULL ,
MessageSource CHAR(30) ,
MessageText CHAR(50) Not NULL ,
MessageType CHAR(12) Not NULL,
MessageData CHAR(100) 
);

drop table if exists FactCashBalances;
create table FactCashBalances (
SK_CustomerID bigint Not Null ,
SK_AccountID bigint Not Null ,
SK_DateID bigint Not Null ,
Cash decimal(15,2) Not Null ,
BatchID decimal(5,0) Not Null
);

drop table if exists FactHoldings;
create table FactHoldings (
TradeID bigint Not NULL ,
CurrentTradeID bigint Not Null ,
SK_CustomerID bigint Not NULL ,
SK_AccountID bigint Not NULL ,
SK_SecurityID bigint Not NULL ,
SK_CompanyID bigint Not NULL ,
SK_DateID bigint Not NULL ,
SK_TimeID bigint Not NULL ,
CurrentPrice decimal(8,2) check (CurrentPrice > 0) ,
CurrentHolding decimal(6,0) Not NULL ,
BatchID decimal(5,0) Not Null 
);

drop table if exists FactMarketHistory;
create table FactMarketHistory(
SK_SecurityID bigint Not Null ,
SK_CompanyID bigint Not Null ,
SK_DateID bigint Not Null,
PERatio decimal(10,2) ,
Yield decimal(5,2) Not Null ,
FiftyTwoWeekHigh decimal(8,2) Not Null ,
SK_FiftyTwoWeekHighDate bigint Not Null ,
FiftyTwoWeekLow decimal(8,2) Not Null ,
SK_FiftyTwoWeekLowDate bigint Not Null ,
ClosePrice decimal(8,2) Not Null ,
DayHigh decimal(8,2) Not Null ,
DayLow decimal(8,2) Not Null ,
Volume decimal(12,0) Not Null ,
BatchID decimal(5,0) Not Null 
);

drop table if exists FactWatches;
create table FactWatches(
SK_CustomerID bigint Not NULL ,
SK_SecurityID bigint Not NULL ,
SK_DateID_DatePlaced bigint Not NULL ,
SK_DateID_DateRemoved bigint ,
BatchID decimal(5,0) Not Null 
);

drop table if exists Industry;
create table Industry (
IN_ID CHAR(2) Not NULL,
IN_NAME CHAR(50) Not NULL ,
IN_SC_ID CHAR(4) Not NULL 
);

drop table if exists Financial;
create table Financial (
SK_CompanyID bigint Not NULL ,
FI_YEAR decimal(4,0) Not NULL ,
FI_QTR decimal(1,0) Not NULL ,
FI_QTR_START_DATE DATE Not NULL ,
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

drop table if exists Prospect;
create table Prospect (
AgencyID CHAR(30) Not NULL ,
SK_RecordDateID bigint Not NULL ,
SK_UpdateDateID bigint Not NULL,
BatchID decimal(5,0) Not Null ,
IsCustomer BIT Not NULL ,
LastName CHAR(30) Not NULL ,
FirstName CHAR(30) Not NULL ,
MiddleInitial CHAR(1) ,
Gender CHAR(1) ,
AddressLine1 CHAR(80) ,
AddressLine2 CHAR(80) ,
PostalCode CHAR(12) ,
City CHAR(25) Not NULL ,
State CHAR(20) Not NULL ,
Country CHAR(24) ,
Phone CHAR(30) ,
Income decimal(9,0) ,
NumberCars decimal(2,0) ,
NumberChildren decimal(2,0) ,
MaritalStatus CHAR(1),
Age decimal(3,0) ,
CreditRating decimal(4,0) ,
OwnOrRentFlag CHAR(1) ,
Employer CHAR(30),
NumberCreditCards decimal(2,0),
NetWorth decimal(12,0) ,
MarketingNameplate CHAR(100)
);

drop table if exists StatusType;
create table StatusType(
ST_ID CHAR(4) Not NULL,
ST_NAME CHAR(10) Not NULL 
);

drop table if exists TaxRate;
create table TaxRate (
TX_ID CHAR(4) Not NULL ,
TX_NAME CHAR(50) Not NULL ,
TX_RATE decimal(6,5) Not NULL ,
);

drop table if exists TradeType;
create table TradeType (
TT_ID CHAR(3) Not NULL,
TT_NAME CHAR(12) Not NULL ,
TT_IS_SELL decimal(1,0) Not NULL,
TT_IS_MRKT decimal(1,0) Not NULL ,
);

drop table if exists Audit;
create table Audit (
DataSet CHAR(20) Not Null,
BatchID decimal(5,0) ,
Date DATE ,
Attribute CHAR(50) Not Null ,
Value decimal(15,0) ,
DValue decimal(15,5)
);

