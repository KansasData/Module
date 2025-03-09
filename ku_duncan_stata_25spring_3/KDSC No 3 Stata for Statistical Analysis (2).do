**************STATA WORKSHOP**************
**************FEBRUARY 18/25**************

version 15

cd "C:\Users\Carlos Zambrana\OD\Work\KDSC_Stata_Workshops"

**** Stata comes with many example datasets preinstalled 
help dta_examples

**** Let's start with probably the most used example dataset: auto
sysuse auto, clear
	
**** Describe the dataset
describe 

**** Summarize the dataset
summarize *

summarize price, det

**** Tabulations

* tabulate
tab foreign

tab rep78 foreign 

* test independence
tab rep78 foreign, chi2

* use tabulate to generate dummies
tab rep78, gen(rep)

drop rep1-rep5
	
* table (pre version 16)
table rep78 foreign, c(mean price median weight max turn min mpg) 

gen hiturn = turn>40 // generate another dummy just for the next examples

table rep78 foreign hiturn, c(mean price median mpg)

table rep78 foreign hiturn, c(mean price median mpg) f(%9.0f) // can change the format of the results

**** Classical tests of hypothesis
ttest price, by(foreign) // can also test this with a regression: reg price foreign

**** Generating random variables
gen runif1 = runiform() // uniform from 0 to 1

gen runif2 = runiform(0,10) // uniform from 0 to 10 (continuous)

gen runif3 = runiformint(0,10) // uniform from 0 to 10 (integers)

gen rnorm1 = rnormal() // standard normal N(0,1)

gen rnorm2 = rnormal(5,3) // N(5,3)
gen rnorm3 = rnormal(5,3) // N(5,3)

set rng mt64
set seed 123456
gen rnorm5 = rnormal() // 
gen rnorm6 = rnormal() // For some WEIRD reason setting the seed in Stata 15 doesn't work for me


**************** Regression
reg price foreign

ereturn list // saved objects after a regression. Can access them
matrix define b = e(b)
matrix list b
display b[1,4]

reg price foreign mpg, vce(robust)

reg price i.foreign mpg i.turn, vce(robust)

**** Save estimates
reg price foreign mpg, vce(robust)
est save spec1

reg price i.foreign mpg i.turn, vce(robust)
est save spec2

est restore spec1
est replay

**** Test hypotheses about coefficients
reg price mpg i.turn

test (_b[mpg]=200) // test whether the coefficient for mpg is equal to 200

test (_b[mpg]=_b[33.turn]) // test whether the coefficient for mpg is equal to the coefficient of the dummy for turn=33

* Use suest to test hypotheses about coefficients from different regressions
fvset base 33 turn // use 33 as base level (omitted category)

reg price mpg i.turn if foreign==0
est store domestic
reg price mpg i.turn if foreign==1
est store foreign

suest domestic foreign

test ([domestic_mean = foreign_mean ]: mpg)

**** Predictions
reg price i.foreign mpg i.turn, vce(robust)

*Predicted Y
predict yhat, xb // usually (but not always) xb is not necessary because it is often the default

*Residuals
predict rhat, residuals

*Standard errors of individual predictions (in later versions of Stata)
predict sehat, stdp

**** Predictive Margins 
reg price c.mpg##i.foreign, vce(robust) // put "c." before continuous variables so they don't get treated as categorical when interacting

margins, dydx(mpg)

reg price c.mpg##c.mpg i.foreign, vce(robust) // Interact mpg with itself to include a quadratic term

margins, dydx(mpg) at(mpg=(10(10)40)) plot

margins foreign, dydx(mpg) // One more mile per gallon decreases the price of domestic cars by 687 and of foreign cars by 822.9

margins foreign, eyex(mpg) // Price Elasticities

* Contrasts: "help contrast" for more info
fvset base 33 turn // use 33 as base level (omitted category)
reg price c.mpg##i.turn, vce(robust)
margins turn
margins r.turn // differences from the reference (base) level
margins a.turn // differences from the next level 
margins ar.turn // differences from the previous level

**** Exporting your results: outreg2
ssc install outreg2
help outreg2

reg price mpg, vce(robust)
outreg2 using myfile.xls, excel replace ctitle("Baseline")

reg price mpg i.rep78 trunk , vce(robust)
outreg2 using myfile.xls, excel ctitle("Added some vars") append // note that I did not say "replace"

reg price mpg i.rep78 trunk weight length , vce(robust)
outreg2 using myfile.xls, excel ctitle("Added more vars") append

reg price mpg i.rep78 trunk weight length turn i.foreign, vce(robust)
outreg2 using myfile.xls, excel ctitle("Added all the vars") append

outreg2 using myfile.xls, label ///
ctitle("A more complicated example") excel drop(i.foreign) dec(3) ///
title("Outreg2 example") stats(coef tstat) append // note that I asked for t-statistics instead of standard errors

*Can also use saved estimates and do one outreg at the end
reg price mpg, vce(robust)
est save spec1, replace

reg price mpg i.rep78 trunk , vce(robust)
est save spec2, replace

reg price mpg i.rep78 trunk weight length , vce(robust)
est save spec3, replace

reg price mpg i.rep78 trunk weight length turn i.foreign, vce(robust)
est save spec4, replace

outreg2 [spec1 spec2 spec3 spec4] using myfile.xls, label ///
ctitle("A more complicated example") excel dec(3) ///
title("Outreg2 example") stats(coef se) replace 

**************** Panel Data
webuse nlswork, clear

**** xtset	
xtset idcode year
		
**** Issues with with gaps
gen L1ln_wage = L.ln_wage
gen L2ln_wage = L2.ln_wage
gen Dln_wage = D.ln_wage

**** Summarize the data
xtdescribe

xttab occ_code // overall tabulates person-years; between tabulates persons. 1020 people have worked in OCC 1. 9077 ever having either.

xttab race // can use it to check if the value of a variable is fixed for each person (100 within %)

******** Fixed-effects regression
xtreg ln_wage union age i.race collgrad i.occ_code ttl_exp tenure i.year, fe vce(robust)
xtreg ln_wage union L.ln_wage age i.race collgrad i.occ_code ttl_exp tenure i.year, fe vce(robust)

**** Exporting your results
reg ln_wage union i.year, vce(robust)
outreg2 using myfile2.xls, excel ctitle("Baseline - OLS") addtext(State FE, No, Year FE, Yes) label replace 

xtreg ln_wage union i.year , fe vce(robust)
outreg2 using myfile2.xls, excel ctitle("Baseline - FE") addtext(State FE, YES, Year FE, YES) label

xtreg ln_wage union i.year , fe vce(robust)
outreg2 using myfile2.xls, excel ctitle("Baseline - FE") addtext(State FE, YES, Year FE, YES) label

xtreg ln_wage union age msp c_city i.occ_code ttl_exp tenure wks_work i.year , fe vce(robust)
outreg2 using myfile2.xls, excel ctitle("Full") addtext(State FE, YES, Year FE, YES) label

**************** Difference-in-Differences
webuse hospdd, clear
xtset hospital

*Estimate the average treatment effect of a new admissions procedure on the satisfaction of patients subject to the new procedure
xtdidregress (satis)(procedure), group(hospital) time(month) vce(robust)

*Cluster by ID
xtdidregress (satis)(procedure), group(hospital) time(month) vce(cluster hospital)

**************** Instrumental Variables
*Let's create our own data
clear // clear dataset
set obs 1000 // set the number of observations to 1000
gen z = rnormal(5,3) // this is our IV
gen conf = rnormal(12,3) // variable confounding variation of x1; it is unobserved
gen x1 = 2 + 3*z + 5*conf + rnormal() // x1 depends on z and conf
gen x2 = rnormal(2,4) // x2 purely independent variable
gen y = 10 + 3*x1 + 5*x2 + 2*conf + rnormal() // y depends on x1 and conf but not on z (only through x)


reg y x1 x2 // coef on x1 biased 
outreg2 using myfile3.xls, excel ctitle("OLS") replace

reg y x1 x2 z // coef on x1 still biased
outreg2 using myfile3.xls, excel ctitle("OLS") 

reg y x1 x2 conf // of course, if we had the confounding variable, we wouldn't need IV
outreg2 using myfile3.xls, excel ctitle("OLS") 

ivregress 2sls y x2 (x1 = z) // IV regresion (2-stage least squares)
outreg2 using myfile3.xls, excel ctitle("2SLS") 

ivregress2 2sls y x2 (x1 = z), first // want to see the first stage?

ssc install ivregress2
ivregress2 2sls y x2 (x1 = z), first // want to export the first stage?

est restore first
outreg2 using myfile3.xls, excel cttop(2SLS - first) 
est restore second
outreg2 using myfile3.xls, excel cttop(2SLS - second) 


