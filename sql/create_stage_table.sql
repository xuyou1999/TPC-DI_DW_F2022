drop database if exists tpc_di_stage;
create database tpc_di_stage;
use tpc_di_stage;

drop table if exists BatchDate;
create table BatchDate (
    BatchDate date not null
);

drop table if exists CashTransaction;
create table CashTransaction (
    CT_CA_ID int not null,
    CT_DTS datetime not null,
    CT_AMT decimal(10,2) not null,
    CT_NAME varchar(100) not null
);

drop table if exists CustomerMgmt;
create table CustomerMgmt (
    ActionType varchar(9) check(ActionType in ('NEW', 'ADDACCT', 'UPDCUST', 'UPDACCT', 'CLOSEACCT', 'INACT')),
    ActionTS text,

    C_ID int not null,
    C_TAX_ID varchar(20),
    C_GNDR varchar(1),
    C_TIER int,
    C_DOB date,

    C_L_NAME varchar(25),
    C_F_NAME varchar(20),
    C_M_NAME varchar(1),

    C_ADLINE1 varchar(80),
    C_ADLINE2 varchar(80),
    C_ZIPCODE varchar(12),
    C_CITY varchar(25),
    C_STATE_PROV varchar(20),
    C_CTRY varchar(24),

    C_PRIM_EMAIL varchar(50),
    C_ALT_EMAIL varchar(50),
    C_CTRY_CODE1 varchar(3),
    C_AREA_CODE1 varchar(3),
    C_LOCAL1 varchar(10),
    C_EXT1 varchar(5),
    C_CTRY_CODE2 varchar(3),
    C_AREA_CODE2 varchar(3),
    C_LOCAL2 varchar(10),
    C_EXT2 varchar(5),
    C_CTRY_CODE3 varchar(3),
    C_AREA_CODE3 varchar(3),
    C_LOCAL3 varchar(10),
    C_EXT3 varchar(5),

    C_LCL_TX_ID varchar(4),
    C_NAT_TX_ID varchar(4),

    CA_ID int not null,
    CA_TAX_ST int,

    CA_B_ID int,
    CA_NAME varchar(50)
);

drop table if exists DailyMarket;
create table DailyMarket (
    DM_DATE date not null,
    DM_S_SYMB varchar(15) not null,
    DM_CLOSE decimal(8,2) not null,
    DM_HIGH decimal(8,2) not null,
    DM_LOW decimal(8,2) not null,
    DM_VOL int not null
);

drop table if exists Date;
create table Date (
    SK_DateID int not null,
    DateValue varchar(20) not null,
    DateDesc varchar(20) not null,
    CalendarYearID int not null,
    CalendarYearDesc varchar(20) not null,
    CalendarQtrID int not null,
    CalendarQtrDesc varchar(20) not null,
    CalendarMonthID int not null,
    CalendarMonthDesc varchar(20) not null,
    CalendarWeekID int not null,
    CalendarWeekDesc varchar(20) not null,
    DayOfWeekNum int not null,
    DayOfWeekDesc varchar(10) not null,
    FiscalYearID int not null,
    FiscalYearDesc varchar(20) not null,
    FiscalQtrID int not null,
    FiscalQtrDesc varchar(20) not null,
    HolidayFlag bit
);

drop table if exists FINWIRE_CMP;
create table FINWIRE_CMP (
    PTS varchar(15) not null,
    RecType varchar(3) not null,
    CompanyName varchar(60) not null,
    CIK varchar(10) not null,
    Status varchar(4) not null,
    IndustryID varchar(2) not null,
    SPrating varchar(4) not null,
    FoundingDate varchar(8),
    AddrLine1 varchar(80) not null,
    AddrLine2 varchar(80),
    PostalCode varchar(12) not null,
    City varchar(25) not null,
    StateProvince varchar(20) not null,
    Country varchar(24),
    CEOname varchar(46) not null,
    Description varchar(150) not null
);

drop table if exists FINWIRE_SEC;
create table FINWIRE_SEC (
    PTS varchar(15) not null,
    RecType varchar(3) not null,
    Symbol varchar(15) not null,
    IssueType varchar(6) not null,
    Status varchar(4) not null,
    Name varchar(70) not null,
    ExID varchar(6) not null,
    ShOut varchar(13) not null,
    FirstTradeDate varchar(8) not null,
    FirstTradeExchg varchar(8) not null,
    Dividend varchar(12) not null,
    CoNameOrCIK varchar(60) not null
);

drop table if exists FINWIRE_FIN;
create table FINWIRE_FIN (
    PTS varchar(15) not null,
    RecType varchar(3) not null,
    Year varchar(4) not null,
    Quarter varchar(1) not null,
    QtrStartDate varchar(8) not null,
    PostingDate varchar(8) not null,
    Revenue varchar(17) not null,
    Earnings varchar(17) not null,
    EPS varchar(12) not null,
    DilutedEPS varchar(12) not null,
    Margin varchar(12) not null,
    Inventory varchar(17) not null,
    Assets varchar(17) not null,
    Liabilities varchar(17) not null,
    ShOut varchar(13) not null,
    DilutedShOut varchar(13) not null,
    CoNameOrCIK varchar(60) not null
);

drop table if exists HoldingHistory;
create table HoldingHistory (
    HH_H_T_ID int not null,
    HH_T_ID int not null,
    HH_BEFORE_QTY int not null,
    HH_AFTER_QTY int not null
);

drop table if exists HR;
create table HR (
    EmployeeID int not null,
    ManagerID int not null,
    EmployeeFirstName varchar(30) not null,
    EmployeeLastName varchar(30) not null,
    EmployeeMI varchar(1),
    EmployeeJobCode int,
    EmployeeBranch varchar(30),
    EmployeeOffice varchar(10),
    EmployeePhone varchar(14)
);

drop table if exists Industry;
create table Industry (
    IN_ID varchar(2) not null,
    IN_NAME varchar(50) not null,
    IN_SC_ID varchar(4) not null
);

drop table if exists Prospect;
create table Prospect (
    AgencyID varchar(30) not null,
    LastName varchar(30) not null,
    FirstName varchar(30) not null,
    MiddleInitial varchar(1),
    Gender varchar(1),
    AddressLine1 varchar(80),
    AddressLine2 varchar(80),
    PostalCode varchar(12),
    City varchar(25) not null,
    State varchar(20) not null,
    Country varchar(24),
    Phone varchar(30),
    Income int,
    NumberCars int,
    NumberChildren int,
    MaritalStatus varchar(1),
    Age int,
    CreditRating int,
    OwnOrRentFlag varchar(1),
    Employer varchar(30),
    NumberCreditCards int,
    NetWorth int
);

drop table if exists StatusType;
create table StatusType (
    ST_ID varchar(4) not null,
    ST_NAME varchar(10) not null
);

drop table if exists TaxRate;
create table TaxRate (
    TX_ID varchar(4) not null,
    TX_NAME varchar(50) not null,
    TX_RATE decimal(6,5) not null
);

drop table if exists Time;
create table Time (
    SK_TimeID int not null,
    TimeValue varchar(20) not null,
    HourID int not null,
    HourDesc varchar(20) not null,
    MinuteID int not null,
    MinuteDesc varchar(20) not null,
    SecondID int not null,
    SecondDesc varchar(20) not null,
    MarketHoursFlag bit,
    OfficeHoursFlag bit
);

drop table if exists TradeHistory;
create table TradeHistory (
    TH_T_ID int not null,
    TH_DTS datetime not null,
    TH_ST_ID varchar(4) not null
);

drop table if exists Trade;
create table Trade (
    T_ID int not null,
    T_DTS datetime not null,
    T_ST_ID varchar(4) not null,
    T_TT_ID varchar(3) not null,
    T_IS_CASH bit,
    T_S_SYMB varchar(15) not null,
    T_QTY int check(T_QTY>0),
    T_BID_PRICE int check(T_BID_PRICE>0),
    T_CA_ID int not null,
    T_EXEC_NAME varchar(49) not null,
    T_TRADE_PRICE decimal(8,2) check(T_TRADE_PRICE>0),
    T_CHRG decimal(10,2) check(T_CHRG>=0),
    T_COMM decimal(10,2) check(T_COMM>=0),
    T_TAX decimal(10,2) check(T_TAX>=0)
);

drop table if exists TradeType;
create table TradeType (
    TT_ID varchar(3) not null,
    TT_NAME varchar(12) not null,
    TT_IS_SELL int not null,
    TT_IS_MRKT int not null
);

drop table if exists WatchHistory;
create table WatchHistory (
    W_C_ID int not null,
    W_S_SYMB varchar(15) not null,
    W_DTS datetime not null,
    W_ACTION varchar(4) not null
);