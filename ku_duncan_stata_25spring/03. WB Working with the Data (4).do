

**************STATA WORKSHOP**************
**************FEBRUARY 4/25***************
*List of indicator codes taken from World Bank
*NV.IND.MANF.KD NV.AGR.TOTL.ZS NE.TRD.GNFS.ZS NE.GDI.TOTL.ZS NE.GDI.STKB.CN NY.GNS.ICTR.ZS NY.GNP.PCAP.PP.KD NY.GDP.MKTP.KN NV.IND.MANF.ZS

wbopendata, indicator(NV.IND.MANF.KD; NV.AGR.TOTL.ZS; NE.TRD.GNFS.ZS; NE.GDI.TOTL.ZS; NE.GDI.STKB.CN; NY.GNS.ICTR.ZS; NY.GNP.PCAP.PP.KD; NY.GDP.MKTP.KN; NV.IND.MANF.ZS; NE.GDI.FTOT.ZS;NY.GNP.MKTP.KD.ZG) clear long 

tab countryname if regionname == "Aggregates"
drop if regionname == "Aggregates"

rename ne_gdi_stkb_cn inventory_change
rename nv_ind_manf_kd manufacturing
rename nv_ind_manf_zs manufacturing_per
rename nv_agr_totl_zs agriculture_per
rename ne_trd_gnfs_zs trade_per
rename ne_gdi_totl_zs capital_formation_per

rename ny_gns_ictr_zs gross_savings_per

rename ny_gnp_pcap_pp_kd gni_pc
rename ny_gdp_mktp_kn gdp 
rename ny_gnp_mktp_kd_zg gdp_growth
rename ne_gdi_ftot_zs gcf_growth

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Stata Econ Club Workshop Files"
save stata_workshop.dta, replace
export excel using "stata_workshop", firstrow(variables) replace

****Let's explore some patterns in the data

use stata_workshop.dta, clear
****Graphing

****lines
line gdp_growth year if countrycode=="USA"
line gdp_growth year if countrycode=="USA", ytitle("Percent GDP Growth")
line gdp_growth year if countrycode=="USA", ytitle("GDP Growth") title("Growth of USA GDP Over Time") graphregion(color(white))

graph twoway (line gdp_growth year if countrycode=="USA") (line gdp_growth year if countrycode=="DEU"), graphregion(color(white))
graph twoway (line gdp_growth year if countrycode=="USA") (line gdp_growth year if countrycode=="DEU"), graphregion(color(white)) legend(label(1 "USA") label(2 "DEU"))
graph twoway (line gdp_growth year if countrycode=="USA") (line gdp_growth year if countrycode=="DEU"), graphregion(color(white)) legend(label(1 "USA") label(2 "DEU")) ytitle("Percent GDP Growth")

****boxplots

graph box gdp_growth if region!="NA" & year==2018, over(region) graphregion(color(white)) ytitle("growth rate (%)")
graph box gdp_growth if region!="NA", over(region) graphregion(color(white)) ytitle("growth rate (%)")
graph box gdp_growth if region!="NA" & year>=2010, over(region) graphregion(color(white)) ytitle("growth rate (%)")

graph box gdp_growth if incomelevel!="NA" & year==2018, over(incomelevel) graphregion(color(white)) ytitle("growth rate (%)")
graph box gdp_growth if incomelevel!="NA", over(incomelevel) graphregion(color(white)) ytitle("growth rate (%)")
graph box gdp_growth if incomelevel!="NA" & year<=2010, over(incomelevel) graphregion(color(white)) ytitle("growth rate (%)")

****scatter plots
scatter capital_formation_per gross_savings_per if gross_savings_per>-100, graphregion(color(white)) 
scatter capital_formation_per gross_savings_per if gross_savings_per>-100, graphregion(color(white)) ytitle("Capital Formation (%GDP)") xtitle("Gross Savings (%GDP)")

****RD with time around 2009
gen index = 0
replace index=1 if year==2010
replace index=2 if year==2011
replace index=3 if year==2012
replace index=4 if year==2013
replace index=5 if year==2014
replace index=6 if year==2015
replace index=7 if year==2016
replace index=8 if year==2017 
replace index=9 if year==2018

replace index=-1 if year==2008
replace index=-2 if year==2007
replace index=-3 if year==2006
replace index=-4 if year==2005
replace index=-5 if year==2004
replace index=-6 if year==2003
replace index=-7 if year==2002
replace index=-8 if year==2001
replace index=-9 if year==2000

****DID 
gen treatment = 0
replace treatment = 1 if incomelevel=="HIC" | incomelevel=="UMC"
gen post = 0
replace post = 1 if year>=2009
gen ln_gdp = ln(gdp)

reg capital_formation_per treatment##post i.year ln_gdp, r

preserve 
collapse (mean) capital_formation_per, by(treatment year)
graph twoway (line capital_formation_per year if treatment == 0) (line capital_formation_per year if treatment == 1), graphregion(color(white)) legend(order(1 "LIC & LMC" 2 "UMC & HIC")) ytitle("capital formation (%GDP)")
restore

preserve 
collapse (mean) capital_formation_per, by(treatment year)
graph twoway (line capital_formation_per year if treatment == 0) (line capital_formation_per year if treatment == 1), graphregion(color(white)) legend(order(1 "LIC & LMC" 2 "UMC & HIC")) ytitle("capital formation (%GDP)") xline(2008)
restore

* Look only before the pre-period
preserve 
collapse (mean) capital_formation_per, by(treatment year)
graph twoway (line capital_formation_per year if treatment == 0 & year <= 2008) (line capital_formation_per year if treatment == 1 & year <= 2008), graphregion(color(white)) legend(order(1 "LIC & LMC" 2 "UMC & HIC")) ytitle("capital formation (%GDP)")
restore

reg capital_formation_per treatment##year ln_gdp if year <= 2008, cluster(countrycode)

