
* Practice in Stata with the wbopendata API 
/* https://datahelpdesk.worldbank.org/knowledgebase/articles/889464-wbopendata-stata-module-to-access-world-bank-data
*/

clear all
set more off
wbopendata, language(en - English) topics(11 - Poverty)

cd "/Users/williamduncan/Dropbox/Econ PhD/9. GTA/ECON582/Weeks/Week 2"

save temp.dta

keep if indicatorcode=="SI.POV.RUGP"
reshape long yr, i(countrycode) j(year)
rename yr rural_poverty
save "rural poverty gap.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.SPR.PCAP"
reshape long yr, i(countrycode) j(year)
rename yr consumption
save "consumption.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.SPR.PCAP.ZG"
reshape long yr, i(countrycode) j(year)
rename yr consumption_growth
save "consumption growth.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.SPR.PC40"
reshape long yr, i(countrycode) j(year)
rename yr consumption40
save "consumption40.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.SPR.PC40.ZG"
reshape long yr, i(countrycode) j(year)
rename yr consumption_growth40
save "consumption growth40.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.DST.FRST.20"
reshape long yr, i(countrycode) j(year)
rename yr income20
save "income20.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.DST.02ND.20"
reshape long yr, i(countrycode) j(year)
rename yr income40
save "income40.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.DST.03RD.20"
reshape long yr, i(countrycode) j(year)
rename yr income60
save "income60.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.DST.04TH.20"
reshape long yr, i(countrycode) j(year)
rename yr income80
save "income80.dta", replace

use temp.dta, clear
keep if indicatorcode=="SI.DST.05TH.20"
reshape long yr, i(countrycode) j(year)
rename yr income100
save "income100.dta", replace

erase temp.dta

merge 1:1 countrycode year using income80.dta
drop _merge
merge 1:1 countrycode year using income60.dta
drop _merge
merge 1:1 countrycode year using income40.dta
drop _merge
merge 1:1 countrycode year using income20.dta
drop _merge
merge 1:1 countrycode year using "consumption growth.dta"
drop _merge
merge 1:1 countrycode year using consumption.dta
drop _merge
merge 1:1 countrycode year using "rural poverty gap.dta"

drop indicatorname indicatorcode lendingtype lendingtypename _merge

save "poverty panel.dta", replace
export excel using "WB poverty panel", firstrow(variables) nolabel  




