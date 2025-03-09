
cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\Working Data"
use bea_county_gdp_panel.dta, clear

* Look at trends in gdp for selected industries in Kansas 

preserve 
collapse (sum) gdp_*, by(geoname2 year)
graph twoway (line gdp_1 year if geoname2 == "KS") (line gdp_2 year if geoname2 == "KS") (line gdp_3 year if geoname2 == "KS") (line gdp_22 year if geoname2 == "KS"), graphregion(color(white)) legend(order(1 "Food services" 2 "Administrative support" 3 "Arts and entertainment" 4 "Retail trade")) ylabel(, angle(horizontal) format(%12.0fc)) name(graph1, replace)
restore

preserve 
collapse (sum) gdp_*, by(geoname2 year)
graph twoway (line gdp_12 year if geoname2 == "KS") (line gdp_18 year if geoname2 == "KS") (line gdp_19 year if geoname2 == "KS") (line gdp_33 year if geoname2 == "KS"), graphregion(color(white)) legend(order(1 "Agriculture" 2 "Manufacturing" 3 "Natural Resources" 4 "Trade")) ylabel(, angle(horizontal) format(%12.0fc)) name(graph2, replace)
restore

graph combine graph1 graph2, ycommon graphregion(color(white))

preserve 
collapse (sum) gdp_*, by(geoname2 year)
graph twoway (line gdp_1 year if geoname2 == "KS") (line gdp_2 year if geoname2 == "KS") (line gdp_3 year if geoname2 == "KS") (line gdp_22 year if geoname2 == "KS"), graphregion(color(white)) legend(symy(10) symx(10) textw(22) forces size(vsmall) row(2) order(1 "Food services" 2 "Administrative support" 3 "Arts and entertainment" 4 "Retail trade")) ylabel(, angle(horizontal) format(%12.0fc)) name(graph1, replace)
restore

preserve 
collapse (sum) gdp_*, by(geoname2 year)
graph twoway (line gdp_12 year if geoname2 == "KS") (line gdp_18 year if geoname2 == "KS") (line gdp_19 year if geoname2 == "KS") (line gdp_33 year if geoname2 == "KS"), graphregion(color(white)) legend(symy(10) symx(10) textw(20) forces size(vsmall) row(2) order(1 "Agriculture" 2 "Manufacturing" 3 "Natural Resources" 4 "Trade")) ylabel(, angle(horizontal) format(%12.0fc)) name(graph2, replace)
restore

graph combine graph1 graph2, ycommon graphregion(color(white))

preserve 
collapse (sum) gdp_*, by(geoname2 year)
graph twoway (line gdp_1 year if geoname2 == "KS") (line gdp_2 year if geoname2 == "KS") (line gdp_3 year if geoname2 == "KS") (line gdp_22 year if geoname2 == "KS"), graphregion(color(white)) legend(symy(10) symx(10) textw(22) forces size(vsmall) row(2) order(1 "Food services" 2 "Administrative support" 3 "Arts and entertainment" 4 "Retail trade")) ylabel(, nogrid angle(horizontal) format(%12.0fc)) name(graph1, replace) xtitle("")
restore

preserve 
collapse (sum) gdp_*, by(geoname2 year)
graph twoway (line gdp_12 year if geoname2 == "KS") (line gdp_18 year if geoname2 == "KS") (line gdp_19 year if geoname2 == "KS") (line gdp_33 year if geoname2 == "KS"), graphregion(color(white)) legend(symy(10) symx(10) textw(20) forces size(vsmall) row(2) order(1 "Agriculture" 2 "Manufacturing" 3 "Natural Resources" 4 "Trade")) ylabel(, nolabels noticks nogrid angle(horizontal) format(%12.0fc)) name(graph2, replace) xtitle("")
restore

graph combine graph1 graph2, ycommon graphregion(color(white))

* Look at how variation in specific industries has changed across Kansas counties over time

preserve 
gen gdp_12_sd = gdp_12
collapse (mean) gdp_12 (sd) gdp_12_sd, by(geoname2 year)
graph twoway (line gdp_12 year if geoname2 == "KS") (line gdp_12_sd year if geoname2 == "KS"), graphregion(color(white)) legend(order(1 "Average Agriculture" 2 "SD Agriculture")) ylabel(, nogrid angle(horizontal) format(%12.0fc))
restore

* Mapping Agriculture Across Kansas Counties

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\Working Data\Tiger_2020_Counties"
*shp2dta using cb_2018_us_county_5m, database(us_counties) coordinates(county_coordinates)

use ks_counties.dta, clear
gen fips = STATEFP + COUNTYFP
destring fips, replace

merge 1:m fips using "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\Working Data\bea_county_gdp_panel.dta"
drop if _merge == 2
drop _merge

spmap gdp_12 if year == 2023 using county_coordinates, id(_ID) clmethod(custom) clbreaks(0(100000)500000) legstyle(1) legend(size(large) ring(1) position(3)) fcolor(Blues) osize(0.05 ..) title("Kansas agricultural GDP by county")

* Mapping Across All US Counties
cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\Working Data\county maps"
*shp2dta using cb_2018_us_county_5m, database(us_counties) coordinates(county_coordinates)

use us_counties.dta, clear
destring STATEFP COUNTYFP fips, replace
merge 1:m fips using "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BEA\Working Data\bea_county_gdp_panel.dta"
drop if _merge == 1 | _merge == 2
drop _merge

save bea_count_gdp_panel_shapedata.dta, replace

preserve 
keep if year == 2023
spmap gdp_1 using county_coordinates, id(_ID) fcolor(blue)
restore
