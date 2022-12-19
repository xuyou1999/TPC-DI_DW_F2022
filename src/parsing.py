import pandas as pd
import os

def CMP(dfCMP, Lines):
    pts, rectype, cn, cik, status, iid, spr, fd, adl1, adl2, pc, city, sp, country, ceon, descr = [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []
    for i in Lines:
        pts.append(i[0:15])
        rectype.append(i[15:18])
        cn.append(i[18:78])
        cik.append(i[78:88])
        status.append(i[88:92])
        iid.append(i[92:94])
        spr.append(i[94:98])
        fd.append(i[98:106])
        adl1.append(i[106:186])
        adl2.append(i[186:266])
        pc.append(i[266:278])
        city.append(i[278:303])
        sp.append(i[303:323])
        country.append(i[323:347])
        ceon.append(i[347:393])
        descr.append(i[393:543])
    dic = {'PTS': pts, 'RecType' : rectype, 'CompanyName': cn, 'CIK': cik, 'Status': status, 'IndustryId': iid, 'SPrating': spr, 'FoundingDate' : fd, 'AddrLine1':adl1, "AddrLine2": adl2, 'PostalCode':pc, 'City':city, 'StateProvince':sp, 'Country':country, 'CEOname':ceon, 'Description':descr}
    dfCMP = pd.concat([dfCMP,pd.DataFrame(dic)], axis=0)
    return dfCMP

def SEC(dfSEC, Lines):
    pts, rt, symbol, it, status, name, eid, so, ftd, fte, div, cnocik = [], [], [], [], [], [],[], [], [], [], [], []
    for i in Lines:
        pts.append(i[0:15])
        rt.append(i[15:18])
        symbol.append(i[18:33])
        it.append(i[33:39])
        status.append(i[39:43])
        name.append(i[43:113])
        eid.append(i[113:119])
        so.append(i[119:132])
        ftd.append(i[132:140])
        fte.append(i[140:148])
        div.append(i[148:160])
        cnocik.append(i[160:220].replace("\n",'' ))
    dic = {'PTS':pts, 'RecType':rt, 'Symbol':symbol, 'IssueType':it, 'Status':status, 'Name':name, 'ExID': eid, 'ShOut':so, 'FirstTradeDate':ftd, "FirstTradeExchg":fte, 'Dividend':div, 'CoNameOrCIK':cnocik}
    dfSEC = pd.concat([dfSEC, pd.DataFrame(dic)], axis=0)
    return(dfSEC)

def FIN(dfFIN, Lines):
    pts, rt, year, quart, qsd, pdate, rev, earn, eps, deps, marg, inv, assets, liab, so, dso, cnocik = [], [], [],[], [], [],[], [], [],[], [], [],[], [], [],[],[]
    for i in Lines:
        pts.append(i[0:15])
        rt.append(i[15:18])
        year.append(i[18:22])
        quart.append(i[22:23])
        qsd.append(i[23:31])
        pdate.append(i[31:39])
        rev.append(i[39:56])
        earn.append(i[56:73])
        eps.append(i[73:85])
        deps.append(i[85:97])
        marg.append(i[97:109])
        inv.append(i[109:126])
        assets.append(i[126:143])
        liab.append(i[143:160])
        so.append(i[160:173])
        dso.append(i[173:186])
        cnocik.append(i[186:246].replace("\n",'' ))
    dic = {'PTS':pts, 'RecType':rt, 'Year':year, 'Quarter':quart, 'QrtStartDate': qsd, 'PosingDate':pdate, 'Revenue':rev, 'Earnings':earn, 'EPS':eps, 'DilutedEPS':deps, 'Margin':marg, 'Inventory':inv, 'Assets':assets, 'Liabilities':liab, 'ShOut':so, 'DilutedShOut':dso, 'CoNameOrCIK':cnocik}
    dfFIN = pd.concat([dfFIN, pd.DataFrame(dic)], axis=0)
    return(dfFIN)

def get_all_lines(filename, linesCMP, linesFIN, linesSEC):
    file1 = open(filename, 'r')
    Lines = file1.readlines()
    for line in Lines:
        if (len(line) == 544):
            linesCMP.append(line)
        elif ((len(line) == 221) or (len(line) == 171)):
            linesSEC.append(line)
        elif ((len(line) == 247) or (len(line) == 197)):
            linesFIN.append(line)
    return linesCMP, linesFIN, linesSEC

dfCMP = pd.DataFrame(columns=['PTS', 'RecType', 'CompanyName', 'CIK', 'Status', 'IndustryId', 'SPrating', 'FoundingDate', 'AddrLine1', "AddrLine2", 'PostalCode', 'City', 'StateProvince', 'Country', 'CEOname', 'Description'])
dfSEC = pd.DataFrame(columns=['PTS', 'RecType', 'Symbol', 'IssueType', 'Status', 'Name', 'ExID', 'ShOut', 'FirstTradeDate', "FirstTradeExchg", 'Dividend', 'CoNameOrCIK'])
dfFIN = pd.DataFrame(columns=['PTS', 'RecType', 'Year', 'Quarter', 'QrtStartDate', 'PosingDate', 'Revenue', 'Earnings', 'EPS', 'DilutedEPS', 'Margin', 'Inventory', 'Assets', 'Liabilities', 'ShOut', 'DilutedShOut', 'CoNameOrCIK'])

linesCMP = []
linesSEC = []
linesFIN = []


path = "../data/data-sf3/Batch1"
filenames = os.listdir(path)
good_filenames = [name for name in filenames if name.startswith("FINWIRE") and not name.endswith(".csv")]
print(len(good_filenames))
for file in good_filenames:
    linesCMP, linesFIN, linesSEC = get_all_lines(str(path)+"/"+ str(file), linesCMP, linesFIN, linesSEC)


print(len(linesCMP)+len(linesFIN)+len(linesSEC))

dfCMP = CMP(dfCMP, linesCMP)
dfSEC = SEC(dfSEC, linesSEC)
dfFIN = FIN(dfFIN, linesFIN)

print(len(dfCMP)+len(dfFIN)+len(dfSEC))

dfCMP.to_csv("CMP_records.csv", index=False)
dfSEC.to_csv("SEC_records.csv", index=False)
dfFIN.to_csv("FIN_records.csv", index=False)