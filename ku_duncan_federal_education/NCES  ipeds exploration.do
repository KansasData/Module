
use "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\NCES\ipeds_working.dta", clear

use "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\NCES\iv_panel.dta", clear

collapse (sum) total_students all_nonresident, by(fips_code)
gen share_inter = all_nonresident/total_student
gen county_dummy = 1
save temp.dta, replace

use "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\2. Working Data\county maps\us_counties.dta" 
gen fips_code = STATEFP + COUNTYFP
destring fips_code, replace
merge 1:1 fips_code using temp.dta
drop _merge

replace county_dummy = 0 if county_dummy == .
cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\2. Working Data\county maps"
/*
AK FIPS 02
HI FIPS 15
*/
spmap county_dummy using county_coordinates, id(_ID) title("Counties with a College or University in IPEDS Data Sample") 

tab STATEFP
drop if STATEFP == "02" | STATEFP == "15" | STATEFP == "78" | STATEFP == "72" | STATEFP == "60" | STATEFP == "66" | STATEFP == "69" 

spmap county_dummy using county_coordinates, id(_ID) title("Counties with a College or University in IPEDS Data Sample") 
spmap county_dummy using county_coordinates, id(_ID) title("Counties with a College or University in IPEDS Data Sample") legend(size(large))

replace share_inter = 0 if share_inter == .
spmap share_inter using county_coordinates, id(_ID) title("Counties with a College or University in IPEDS Data Sample")

spmap share_inter using county_coordinates, id(_ID) title("Counties with a College or University in IPEDS Data Sample") clmethod(custom) clbreaks(0(0.25)0.75) legstyle(1) legend(size(large) ring(1) position(3)) fcolor(Blues) osize(0.05 ..)