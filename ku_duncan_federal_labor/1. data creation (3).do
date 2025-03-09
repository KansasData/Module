
cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data"

* In order to create a panel, we want to append each dataset
import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1990_all_county_high_level\allhlcn90.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1990.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1991_all_county_high_level\allhlcn91.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1991.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1992_all_county_high_level\allhlcn92.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1992.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1993_all_county_high_level\allhlcn93.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1993.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1994_all_county_high_level\allhlcn94.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1994.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1995_all_county_high_level\allhlcn95.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1995.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1996_all_county_high_level\allhlcn96.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1996.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1997_all_county_high_level\allhlcn97.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1997.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1998_all_county_high_level\allhlcn98.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1998.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\1999_all_county_high_level\allhlcn99.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp1999.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2000_all_county_high_level\allhlcn00.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2000.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2001_all_county_high_level\allhlcn01.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2001.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2002_all_county_high_level\allhlcn02.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2002.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2003_all_county_high_level\allhlcn03.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2003.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2004_all_county_high_level\allhlcn04.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2004.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2005_all_county_high_level\allhlcn05.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2005.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2006_all_county_high_level\allhlcn06.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2006.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2007_all_county_high_level\allhlcn07.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2007.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2008_all_county_high_level\allhlcn08.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2008.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2009_all_county_high_level\allhlcn09.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2009.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2010_all_county_high_level\allhlcn10.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2010.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2011_all_county_high_level\allhlcn11.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2011.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2012_all_county_high_level\allhlcn12.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2012.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2013_all_county_high_level\allhlcn13.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2013.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2014_all_county_high_level\allhlcn14.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2014.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2015_all_county_high_level\allhlcn15.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2015.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2016_all_county_high_level\allhlcn16.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2016.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2017_all_county_high_level\allhlcn17.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2017.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2018_all_county_high_level\allhlcn18.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2018.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2019_all_county_high_level\allhlcn19.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2019.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2020_all_county_high_level\allhlcn20.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2020.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2021_all_county_high_level\allhlcn21.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2021.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2022_all_county_high_level\allhlcn22.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2022.dta, replace

import excel "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\1. Data\2023_all_county_high_level\allhlcn23.xlsx", sheet("US_St_Cn_MSA") firstrow clear
save temp2023.dta, replace

* Check the variables as you append
use temp1990.dta, clear
append using temp1991.dta
append using temp1992.dta
append using temp1993.dta
append using temp1994.dta
append using temp1995.dta
append using temp1996.dta
append using temp1997.dta
append using temp1998.dta
append using temp1999.dta

append using temp2000.dta
append using temp2001.dta, force
append using temp2002.dta, force
append using temp2003.dta, force
append using temp2004.dta, force
append using temp2005.dta, force
append using temp2006.dta, force
append using temp2007.dta, force
append using temp2008.dta, force
append using temp2009.dta, force

append using temp2010.dta, force
append using temp2011.dta, force
append using temp2012.dta, force
append using temp2013.dta, force
append using temp2014.dta, force
append using temp2015.dta, force
append using temp2016.dta, force
append using temp2017.dta, force
append using temp2018.dta, force
append using temp2019.dta, force

append using temp2020.dta, force
append using temp2021.dta, force
append using temp2022.dta, force
append using temp2023.dta, force

destring Year, replace

tab Industry
tab Year if Industry == "10 Total, all industries"
tab Year if Industry == "Total, all industries"

replace Industry = "Total, all industries" if Industry == "10 Total, all industries"
replace Industry = "Goods-producing" if Industry == "101 Goods-producing"
replace Industry = "Natural resources and mining" if Industry == "1011 Natural resources and mining"
replace Industry = "Construction" if Industry == "1012 Construction"
replace Industry = "Manufacturing" if Industry == "1013 Manufacturing"
replace Industry = "Service-providing" if Industry == "102 Service-providing"
replace Industry = "Trade, transportation, and utilities" if Industry == "1021 Trade, transportation, and utilities"
replace Industry = "Information" if Industry == "1022 Information"
replace Industry = "Financial activities" if Industry == "1023 Financial activities"
replace Industry = "Professional and business services" if Industry == "1024 Professional and business services"
replace Industry = "Education and health services" if Industry == "1025 Education and health services"
replace Industry = "Leisure and hospitality" if Industry == "1026 Leisure and hospitality"
replace Industry = "Other services" if Industry == "1027 Other services"
replace Industry = "Unclassified" if Industry == "1029 Unclassified"

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\2. Working Data"

preserve 
keep if Year < 2003
save qcew_1990_2002.dta, replace
restore

preserve 
keep if Year >= 2003
save qcew_2003_2023.dta, replace
restore

save qcew_1990_2023.dta, replace