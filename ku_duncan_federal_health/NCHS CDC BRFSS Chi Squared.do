

******Import Data

import sasxport5 "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\CDC\BRFSS\Data\LLCP2017.XPT", novallabels clear

keep _state imonth numadult nummen numwomen marital children educa employ1 income2 weight2 height3 internet renthom1 sex blind decide diffwalk diffalon alcday5 avedrnk2 drnk3ge5 maxdrnks hivtst6 sxorient trnsgndr mscode _age80 _incomg  ssbsugr2 ssbfrut3 wtchsalt dradvise

/* 
101 - 199 Times per day 6,766 12.59 17.44 
201 - 299 Times per week 8,340 15.51 19.57 
301 - 399 Times per month 13,177 24.51 23.84 
777 Don’t know/Not sure 307 0.57 0.60 
888 Never 25,102 46.70 38.44 
999 Refused 63 0.12 0.11 
BLANK Not asked or Missing 396,261 . .
*/

* Sugary soda or pop variable
gen ssbsugr2_temp = mod(ssbsugr2, 100)
replace ssbsugr2_temp = ssbsugr2_temp/7 if ssbsugr2>200 & ssbsugr2 < 300
replace ssbsugr2_temp = ssbsugr2_temp/30 if ssbsugr2>300 & ssbsugr2 < 400
replace ssbsugr2_temp = . if ssbsugr2>200 & ssbsugr2 == 777 | ssbsugr2 == 999
replace ssbsugr2_temp = 0 if ssbsugr2 == 888
gen ssbsugr2_count = round(ssbsugr2_temp, 1)
drop ssbsugr2_temp

gen ssbsugr2_cat = .
replace ssbsugr2_cat = 0 if ssbsugr2_count == 0
replace ssbsugr2_cat = 1 if ssbsugr2_count == 1
replace ssbsugr2_cat = 2 if ssbsugr2_count >= 2 & ssbsugr2_count < 100

* Sugary fruit drink variable 
gen ssbfrut3_temp = mod(ssbfrut3, 100)
replace ssbfrut3_temp = ssbfrut3_temp/7 if ssbfrut3>200 & ssbfrut3 < 300
replace ssbfrut3_temp = ssbfrut3_temp/30 if ssbfrut3>300 & ssbfrut3 < 400
replace ssbfrut3_temp = . if ssbfrut3>200 & ssbfrut3 == 777 | ssbfrut3 == 999
replace ssbfrut3_temp = 0 if ssbfrut3 == 888
gen ssbfrut3_count = round(ssbfrut3_temp, 1)
drop ssbfrut3_temp

gen ssbfrut3_cat = .
replace ssbfrut3_cat = 0 if ssbfrut3_count == 0
replace ssbfrut3_cat = 1 if ssbfrut3_count == 1
replace ssbfrut3_cat = 2 if ssbfrut3_count >= 2 & ssbfrut3_count < 100

gen income_cat = .
replace income_cat = 1 if income2>=1 & income2<=4
replace income_cat = 2 if income2>=5 & income2<=7
replace income_cat = 3 if income2==8

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\CDC\BRFSS\Working Data"
save data_2017.dta, replace


**Chi-squared test of association
use "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\CDC\BRFSS\Working Data\data_2017.dta", clear

/*
(a) State the null and alternative hypotheses.
(b) What is the expected count for the cell with NSAID use and Miscarriage?
(c) Find all expected counts and record them in the table below.
(d) What is the contribution to the chi-square statistic for the cell with NSAID use and Miscarriage?
(e) Find all six contributions and record them in the table below.
(f) What is the chi-square test statistic?
(g) What are the degrees of freedom for the test? _________ What is the p-value? _______
(h) Using a 5% significance level, what is the conclusion of the test? Be specific. If there is an association between having a miscarriage and using painkillers, describe how the two variables are related.
*/

******Tabulate 
tab income_cat ssbsugr2_cat
tab income_cat ssbsugr2_cat, chi2

tab income_cat ssbfrut3_cat 
tab income_cat ssbfrut3_cat, chi2
