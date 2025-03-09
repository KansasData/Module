

**ANOVA

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

******Import Data

import sasxport5 "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\CDC\BRFSS\Data\LLCP2017.XPT", novallabels clear

keep _state imonth numadult nummen numwomen marital children educa employ1 income2 weight2 height3 internet renthom1 sex blind decide diffwalk diffalon alcday5 avedrnk2 drnk3ge5 maxdrnks hivtst6 sxorient trnsgndr mscode _age80 _incomg  ssbsugr2 ssbfrut3 wtchsalt dradvise cncrage diabage2

gen days_with_alcohol = .
replace days_with_alcohol = (alcday5 - 100)*4 if alcday5 < 108
replace days_with_alcohol = (alcday5 - 200) if alcday5 > 108 & alcday5 < 231
replace days_with_alcohol = 0 if alcday5 == 888

* ANOVA Tests
anova days_with_alcohol sxorient if sxorient != 9
tabstat days_with_alcohol if sxorient != 9, by(sxorient)

anova days_with_alcohol income2 
anova days_with_alcohol income2 if income2 !=77 & income2 != 99
tabstat days_with_alcohol if income2 !=77 & income2 != 99, by(income2)

anova days_with_alcohol income2 sxorient if income2 !=77 & income2 != 99 & sxorient !=9
