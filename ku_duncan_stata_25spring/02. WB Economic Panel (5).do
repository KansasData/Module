

**************Productive Inputs

clear all
set more off
wbopendata, language(en - English) topics(3 - Economy & Growth)

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Stata Econ Club Workshop Files"

save temp.dta, replace

use temp.dta, clear
keep if indicatorname=="Gross savings (% of GNI)"
reshape long yr, i(countrycode) j(year)
rename yr gross_saving
save "saving.dta", replace

use temp.dta, clear
keep if indicatorname=="Services, value added (% of GDP)"
reshape long yr, i(countrycode) j(year)
rename yr services
save "services.dta", replace

use temp.dta, clear
keep if indicatorname=="Manufacturing, value added (% of GDP)"
reshape long yr, i(countrycode) j(year)
rename yr manufacturing
save "manufacturing.dta", replace

use temp.dta, clear
keep if indicatorname=="Gross capital formation (annual % growth)"
reshape long yr, i(countrycode) j(year)
rename yr capital_growth
save "capital_growth.dta", replace

use temp.dta, clear
keep if indicatorname=="Gross capital formation (constant 2010 US$)"
reshape long yr, i(countrycode) j(year)
rename yr capital
save "capital.dta", replace

use temp.dta, clear
keep if indicatorname=="Final consumption expenditure (annual % growth)"
reshape long yr, i(countrycode) j(year)
rename yr consumption_growth
save "consumption_growth.dta", replace

use temp.dta, clear
keep if indicatorname=="Final consumption expenditure (constant 2010 US$)"
reshape long yr, i(countrycode) j(year)
rename yr consumption
save "consumption.dta", replace

use temp.dta, clear
keep if indicatorname=="Total debt service (% of GNI)"
reshape long yr, i(countrycode) j(year)
rename yr debt_service
save "debt_service.dta", replace

use temp.dta, clear
keep if indicatorname=="Net ODA received per capita (current US$)"
reshape long yr, i(countrycode) j(year)
rename yr net_oda
save "net_oda.dta", replace

use temp.dta, clear
keep if indicatorname=="Foreign direct investment, net inflows (BoP, current US$)"
reshape long yr, i(countrycode) j(year)
rename yr fdi
save "fdi.dta", replace

use temp.dta, clear
keep if indicatorname=="GDP per capita (constant 2010 US$)"
reshape long yr, i(countrycode) j(year)
rename yr gdppc
save "gdppc.dta", replace

use temp.dta, clear
keep if indicatorname=="GDP per capita (constant 2010 US$)"
reshape long yr, i(countrycode) j(year)
rename yr gdppc
save "gdppc.dta", replace




use saving.dta, clear
merge 1:1 countrycode year using services.dta
drop _merge
merge 1:1 countrycode year using manufacturing.dta
drop _merge
merge 1:1 countrycode year using capital_growth.dta
drop _merge
merge 1:1 countrycode year using capital.dta
drop _merge
merge 1:1 countrycode year using consumption_growth.dta
drop _merge
merge 1:1 countrycode year using consumption.dta
drop _merge
merge 1:1 countrycode year using debt_service.dta
drop _merge
merge 1:1 countrycode year using net_oda.dta
drop _merge
merge 1:1 countrycode year using fdi.dta
drop _merge
merge 1:1 countrycode year using gdppc.dta
drop _merge


drop indicatorname indicatorcode lendingtype lendingtypename 

save "economic panel.dta", replace
export excel using "WB Economic Panel", firstrow(variables) nolabel replace


