
import delimited "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\Regional Accounts\CAGDP2\CAGDP2__ALL_AREAS_2001_2023.csv"

* GDP values are not numeric
destring v*, replace

* Do each variable individually
replace v9 = "." if v9 == "(D)"

* Streamline with a forloop
forvalues i = 9(1)31 {
replace v`i' = "." if v`i'=="(D)"
}

forvalues i = 9(1)31 {
replace v`i' = "." if v`i'=="(NA)"
}

destring v*, replace
sum *

split geoname, parse(", ")
count if geoname == ""
drop if geoname == ""
tab geoname2
/*
Buena Vista + Lexington
Colonial Heights + Petersburg
Fairfax City + Falls Church
Manassas + Manassas Park
Staunton + Waynesboro
*/

replace geoname1 = "Rockbridge, Buena Vista + Lexington" if geoname1 == "Rockbridge" & geoname2 == "Buena Vista + Lexington"
replace geoname2 = "VA" if geoname1 == "Rockbridge, Buena Vista + Lexington"

replace geoname1 = "Dinwiddie, Colonial Heights + Petersburg" if geoname1 == "Dinwiddie" & geoname2 == "Colonial Heights + Petersburg"
replace geoname2 = "VA" if geoname1 == "Dinwiddie, Colonial Heights + Petersburg"

replace geoname1 = "Fairfax, Fairfax City + Falls Church" if geoname1 == "Fairfax" & geoname2 == "Fairfax City + Falls Church"
replace geoname2 = "VA" if geoname1 == "Fairfax, Fairfax City + Falls Church"

replace geoname1 = "Prince William, Manassas + Manassas Park" if geoname1 == "Prince William" & geoname2 == "Manassas + Manassas Park"
replace geoname2 = "VA" if geoname1 == "Prince William, Manassas + Manassas Park"

replace geoname1 = "Augusta, Staunton + Waynesboro" if geoname1 == "Augusta" & geoname2 == "Staunton + Waynesboro"
replace geoname2 = "" if geoname1 == "Augusta, Staunton + Waynesboro"

replace geoname2 = "AK" if geoname2 == "AK*"
replace geoname2 = "CO" if geoname2 == "CO*"
replace geoname2 = "HI" if geoname2 == "HI*"
replace geoname2 = "SD" if geoname2 == "SD*"
replace geoname2 = "VA" if geoname2 == "VA*"

gen fips = substr(geofips, 2, 5)
drop fips

gen fips = substr(geofips, 3, 5)

destring fips region, replace

drop unit geofips geoname linecode tablename geoname3 industryclassification

reshape long region description v geoname1 geoname2, i(fips) j(year)

drop if region == .
drop if geoname2 == ""

sort description
egen industry_id = group(description)
* 34 categories

tab description
/*
       Accommodation and food services  |      gdp_1
   Administrative and support and was.. |      gdp_2
   Arts, entertainment, and recreation  |      gdp_3
           Durable goods manufacturing  |      gdp_4
                  Educational services  |      gdp_5
                 Finance and insurance  |      gdp_6
     Health care and social assistance  |      gdp_7
   Management of companies and enterp.. |      gdp_8
        Nondurable goods manufacturing  |      gdp_9
   Professional, scientific, and tech.. |      gdp_10
    Real estate and rental and leasing  |      gdp_11
  Agriculture, forestry, fishing and .. |      gdp_12
  Arts, entertainment, recreation, ac.. |      gdp_13
                          Construction  |      gdp_14
  Educational services, health care, .. |      gdp_15
  Finance, insurance, real estate, re.. |      gdp_16
                           Information  |      gdp_17
                         Manufacturing  |      gdp_18
  Mining, quarrying, and oil and gas .. |      gdp_19
  Other services (except government a.. |      gdp_20
    Professional and business services  |      gdp_21
                          Retail trade  |      gdp_22
        Transportation and warehousing  |      gdp_23
                             Utilities  |      gdp_24
                       Wholesale trade  |      gdp_25
                    Private industries  |      gdp_26
                    All industry total  |      gdp_27
 Government and government enterprises  |      gdp_28
         Manufacturing and information  |      gdp_29
          Natural resources and mining  |      gdp_30
  Private goods-producing industries 2/ |      gdp_31
Private services-providing industries.. |      gdp_32
                                 Trade  |      gdp_33
          Transportation and utilities  |      gdp_34
*/

label var gdp_1 "Accommodation and food services"
label var gdp_2 "Administrative support"
label var gdp_3 "Arts, entertainment, and recreation"

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\Regional Accounts\CAGDP2"
save temp.dta, replace
forvalues i = 1(1)34 {
use temp.dta, clear
keep if industry_id == `i'
reshape long v, i(fips) j(time)
rename v gdp
sort fips time
bysort fips: gen year = _n + 2000
drop description
save temp_`i'.dta, replace
}

use temp_1.dta, clear
rename gdp gdp_1
drop industry_id
merge 1:1 fips year using temp_2.dta
rename gdp gdp_2
drop industry_id _merge
merge 1:1 fips year using temp_3.dta
rename gdp gdp_3
drop industry_id _merge
merge 1:1 fips year using temp_4.dta
rename gdp gdp_4
drop industry_id _merge
merge 1:1 fips year using temp_5.dta
rename gdp gdp_5
drop industry_id _merge
merge 1:1 fips year using temp_6.dta
rename gdp gdp_6
drop industry_id _merge
merge 1:1 fips year using temp_7.dta
rename gdp gdp_7
drop industry_id _merge
merge 1:1 fips year using temp_8.dta
rename gdp gdp_8
drop industry_id _merge
merge 1:1 fips year using temp_9.dta
rename gdp gdp_9
drop industry_id _merge
merge 1:1 fips year using temp_10.dta
rename gdp gdp_10
drop industry_id _merge
merge 1:1 fips year using temp_11.dta
rename gdp gdp_11
drop industry_id _merge
merge 1:1 fips year using temp_12.dta
rename gdp gdp_12
drop industry_id _merge
merge 1:1 fips year using temp_13.dta
rename gdp gdp_13
drop industry_id _merge
merge 1:1 fips year using temp_14.dta
rename gdp gdp_14
drop industry_id _merge
merge 1:1 fips year using temp_15.dta
rename gdp gdp_15
drop industry_id _merge
merge 1:1 fips year using temp_16.dta
rename gdp gdp_16
drop industry_id _merge
merge 1:1 fips year using temp_17.dta
rename gdp gdp_17
drop industry_id _merge
merge 1:1 fips year using temp_18.dta
rename gdp gdp_18
drop industry_id _merge
merge 1:1 fips year using temp_19.dta
rename gdp gdp_19
drop industry_id _merge
merge 1:1 fips year using temp_20.dta
rename gdp gdp_20
drop industry_id _merge
merge 1:1 fips year using temp_21.dta
rename gdp gdp_21
drop industry_id _merge
merge 1:1 fips year using temp_22.dta
rename gdp gdp_22
drop industry_id _merge
merge 1:1 fips year using temp_23.dta
rename gdp gdp_23
drop industry_id _merge
merge 1:1 fips year using temp_24.dta
rename gdp gdp_24
drop industry_id _merge
merge 1:1 fips year using temp_25.dta
rename gdp gdp_25
drop industry_id _merge
merge 1:1 fips year using temp_26.dta
rename gdp gdp_26
drop industry_id _merge
merge 1:1 fips year using temp_27.dta
rename gdp gdp_27
drop industry_id _merge
merge 1:1 fips year using temp_28.dta
rename gdp gdp_28
drop industry_id _merge
merge 1:1 fips year using temp_29.dta
rename gdp gdp_29
drop industry_id _merge
merge 1:1 fips year using temp_30.dta
rename gdp gdp_30
drop industry_id _merge
merge 1:1 fips year using temp_31.dta
rename gdp gdp_31
drop industry_id _merge
merge 1:1 fips year using temp_32.dta
rename gdp gdp_32
drop industry_id _merge
merge 1:1 fips year using temp_33.dta
rename gdp gdp_33
drop industry_id _merge
merge 1:1 fips year using temp_34.dta
rename gdp gdp_34
drop industry_id _merge

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\Working Data"
save bea_county_gdp_panel.dta, replace
