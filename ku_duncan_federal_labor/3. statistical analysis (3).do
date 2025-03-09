
cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\2. Working Data"
use qcew_1990_2002.dta, clear
append using qcew_2003_2023.dta

* Examine wages across Kansas counties
keep if StName == "Kansas"
drop if Area == "Kansas -- Statewide"
drop if Industry == "Total, all industries"
drop if Area == "Unknown Or Undefined, Kansas"

destring Cnty, replace
rename Cnty county_fips

preserve 
keep if Year == 2023
keep if Industry == "Professional and business services"
save kansas_data_county_professional_services.dta, replace
restore

save kansas_data_county_level.dta, replace

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\4. output"
preserve 
collapse (sd) AnnualAveragePay, by(Year)
graph twoway (line AnnualAveragePay Year), graphregion(color(white))
restore

reg AnnualAveragePay Year, r
reg AnnualAveragePay Year, cluster(county_fips)
graph twoway (scatter AnnualAveragePay Year), graphregion(color(white))
graph twoway (scatter AnnualAveragePay Year) (lfit AnnualAveragePay Year), graphregion(color(white))

* Create map
cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\Kansasshapefiles"
use kansas_county_sub.dta, clear
destring STATEFP COUNTYFP, replace
keep STATEFP COUNTYFP NAME id
rename COUNTYFP county_fips
*rename id _ID

merge m:1 county_fips using "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\2. Working Data\kansas_data_county_professional_services.dta"
drop _merge

spmap AnnualAveragePay using kansas_coordinates, id(id) fcolor(Blues)
