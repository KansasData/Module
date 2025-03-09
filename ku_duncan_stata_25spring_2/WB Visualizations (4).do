**************STATA WORKSHOP**************
**************FEBRUARY 11/25**************
* List of indicator codes taken from World Bank
* NY.GDP.MKTP.CD NY.GDP.MKTP.KD.ZG NV.AGR.TOTL.KD.ZG NV.IND.MANF.KD.ZG NV.SRV.TOTL.KD.ZG SP.POP.TOTL SE.XPD.TOTL.GD.ZS SL.AGR.EMPL.ZS SL.SRV.EMPL.ZS
* Access the data dictionary here: https://data.worldbank.org/indicator?tab=all
******************************************
* Set working directory
* cd "C:\Users\Owner\OneDrive - University of Kansas\StataWorkshop"
cd "C:\Users\b696j432\OneDrive - University of Kansas\StataWorkshop"

* Install WB package if you haven't already
ssc install wbopendata

* Run the command below to import data
wbopendata, indicator(NY.GDP.MKTP.KN; NY.GDP.MKTP.KD.ZG; NV.AGR.TOTL.ZS; NV.IND.MANF.ZS; NV.SRV.TOTL.ZS; SP.POP.TOTL; SE.XPD.TOTL.GD.ZS; SL.AGR.EMPL.ZS; SL.SRV.EMPL.ZS; NV.IND.TOTL.ZS; SL.IND.EMPL.ZS) clear long

* Clean the data
tab countryname if regionname == "Aggregates"
drop if regionname == "Aggregates"

rename ny_gdp_mktp_kn gdp 
rename ny_gdp_mktp_kd_zg gdp_growth
rename nv_agr_totl_zs agriculture_per 
rename nv_ind_manf_zs manufacturing_per 
rename nv_srv_totl_zs services_per 
rename nv_ind_totl_zs industry_per 

rename sp_pop_totl population
rename se_xpd_totl_gd_zs edu_expense_per
rename sl_agr_empl_zs agriculture_employment
rename sl_srv_empl_zs services_employment
rename sl_ind_empl_zs industry_employment

* Save in .dta format
save wb_visualizations.dta, replace

*********************************************
**# Simple Graphing
*********************************************
use wb_visualizations.dta, clear

* Line graph review
line gdp_growth year if countryname == "United States"
line gdp_growth year if countryname == "United States", ytitle("GDP Growth") title("Growth of U.S. GDP Over Time") graphregion(color(white))

* Bar chart
graph bar (mean) population, over(regionname) graphregion(color(white))

** Y-axis format options
graph bar (mean) population, over(regionname) ylabel(, format(%12.0fc) angle(horizontal)) graphregion(color(white))
 
** X-axis format options (xsize, labsize, angle)
graph bar (mean) population, over(regionname, label(labsize(small))) ylabel(, format(%12.0fc) angle(horizontal)) xsize(10) graphregion(color(white))
graph bar (mean) population, over(regionname, label(angle(45) labsize(small))) ylabel(, notick nogrid angle(horizontal) format(%12.0fc)) bar(1, color(green)) intensity(*0.4) lintensity(*0.9) graphregion(color(white))

graph bar (mean) population, over(regionname, label(angle(45) labsize(small))) ylabel(, notick nogrid angle(horizontal) format(%12.0fc)) bar(1, color(green)) intensity(*0.4) lintensity(*0.9) graphregion(color(white))

** Don't forget titles! Try adding them yourself




*********************************************
**# Graph Twoway & Modifying Data Structure
*********************************************
* When modifying the data structure, you can choose to reload data, use preserve/restore, or create a new dataset
use wb_visualizations.dta, clear

* Twoway Scatter/lfit
** Start with a scatter
scatter agriculture_per agriculture_employment, xtitle("Agricultural Employment") ytitle("Agricultural Value Added (% of GDP)") graphregion(color(white)) ylabel(, angle(horizontal))

** Add a linear fit
twoway (scatter agriculture_per agriculture_employment) (lfit agriculture_per agriculture_employment, lwidth(thick)), xtitle("Agricultural Employment") ytitle("Agricultural Value Added (% of GDP)") legend(off) graphregion(color(white)) ylabel(, angle(horizontal)) 

*** What if we want to specify a region?
twoway (scatter agriculture_per agriculture_employment if regionname == "Europe and Central Asia" ) (lfit agriculture_per agriculture_employment if regionname == "Europe and Central Asia", lwidth(thick)), xtitle("Agricultural Employment") ytitle("Agricultural Value Added (% of GDP)") title("Agricultural Employment and Value Add in Europe and Central Asia") legend(off) graphregion(color(white)) ylabel(, angle(horizontal)) xsize(8)

*** What if we want multiple regions in the same plot?
* ssc install sepscatter 
sepscatter agriculture_per agriculture_employment if year == 2023, separate(regionname) xtitle("Agricultural Employment") ytitle("Agricultural Value Added (% of GDP)") title("Agricultural Employment and Value Add by Region") graphregion(color(white)) ylabel(, angle(horizontal))

*********************************************
**# Twoway Line and Area
*********************************************

* Twoway line (With new way to trim data)
preserve
keep if countryname == "India"
keep if year >= 1960 & year <= 2023
twoway (line agriculture_per year, lcolor(green)) (line industry_per year, lcolor(blue)) (line services_per year, lcolor(orange)), ///
graphregion(color(white)) ///
ylabel(, angle(horizontal))
restore

** Add options (xlabel and legend)
preserve
keep if countryname == "India"
keep if year >= 1960 & year <= 2023
twoway (line agriculture_per year, lcolor(green)) (line industry_per year, lcolor(blue)) (line services_per year, lcolor(orange)), ///
	title("Sectoral Composition of the GDP in India, 1960-2023") ///
    ytitle("Percentage of GDP") ///
    xtitle("Year") ///
	xlabel(1960(5)2023) ///
    legend(order(1 "Agriculture" 2 "Industry" 3 "Services")) ///
	graphregion(color(white)) ///
	ylabel(, angle(horizontal))
restore 

** Twoway area
preserve
keep if countryname == "India"
keep if year >= 1960 & year <= 2023
twoway (area agriculture_per year, color(green%50)) (area industry_per year, color(blue%50)) (area services_per year, color(red%50)), ///
	title("Sectoral Composition of the GDP in India, 1960-2023") ///
    ytitle("Percentage of GDP") ///
    xtitle("Year") ///
	xlabel(1960(10)2023) ///
	ylabel(0(10)50) ///
    legend(order(1 "Agriculture" 2 "Industry" 3 "Services")) ///
	graphregion(color(white)) ///
	ylabel(, angle(horizontal))
restore 

** Stacked area
* ssc install stckar
preserve
keep if countryname == "India"
keep if year >= 1960 & year <= 2023
stckar agriculture_per services_per industry_per year, ///
	graphopt(title("Sectoral Composition of the GDP in India, 1960-2023") ///
    ytitle("Percentage of GDP") ///
    xtitle("Year") ///
	xlabel(1960(10)2023) ///
	ylabel(0(10)100, angle(horizontal)) ///
	legend(label(1 "Agriculture") label(2 "Industry") label(3 "Services")))
restore 


*********************************************
**# Visualizing Variance
*********************************************

* Global GDP growth variation
** One option
graph box gdp_growth if inrange(year, 2000, 2010), over(year) ytitle("GDP Growth") graphregion(color(white)) ylabel(, angle(horizontal))

graph box gdp_growth if inrange(year, 2000, 2010), over(year) ytitle("GDP Growth") yline(0) graphregion(color(white)) ylabel(, angle(horizontal))

** Another option
egen gdp_growth_max = max(gdp_growth), by(year)
egen gdp_growth_min = min(gdp_growth), by(year)
egen gdp_growth_mean = mean(gdp_growth), by(year)

preserve
keep if year >= 2000
twoway (rcap gdp_growth_max gdp_growth_min year, lcolor(blue)) ///
	(scatter gdp_growth_mean year, mcolor(red)), ///
	title("Global GDP Growth Variability Over Time") ///
	xtitle("Year") ///
	ytitle("GDP Growth (%)") ///
    legend(order(1 "High-Low Range" 2 "Global Average GDP Growth")) xsize(8) ///
	ylabel(, angle(horizontal)) ///
	graphregion(color(white))
restore

graph export gdp_growth_year.png, replace

* How would we do this by region or country?


