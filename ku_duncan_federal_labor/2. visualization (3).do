
cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\2. Working Data"
use qcew_1990_2002.dta, clear
append using qcew_2003_2023.dta

cd "C:\Users\w295d127\OneDrive - University of Kansas\CDL\Federal Agency Dataset Lectures\BLS\4. output"

* Employment and Establishments by Broad Industry
preserve
keep if AreaType == "Nation"
keep if Industry == "Total, all industries"

graph twoway (line AnnualAverageEstablishmentCou Year if Ownership == "Local Government") (line AnnualAverageEstablishmentCou Year if Ownership == "State Government") (line AnnualAverageEstablishmentCou Year if Ownership == "Federal Government"), graphregion(color(white)) legend(order(1 "Local" 2 "State" 3 "Federal"))
graph export establishments_government.png, replace
graph twoway (line AnnualAverageEstablishmentCou Year if Ownership == "Private") (line AnnualAverageEstablishmentCou Year if Ownership == "Total Covered"), graphregion(color(white)) legend(order(1 "Private" 2 "Total"))
graph export establishments_private.png, replace

gen AnnualAverageEmployment_000s = AnnualAverageEmployment/1000
graph twoway (line AnnualAverageEmployment_000s Year if Ownership == "Local Government") (line AnnualAverageEmployment_000s Year if Ownership == "State Government") (line AnnualAverageEmployment_000s Year if Ownership == "Federal Government"), graphregion(color(white)) legend(order(1 "Local" 2 "State" 3 "Federal"))
graph export employment_government.png, replace
graph twoway (line AnnualAverageEmployment_000s Year if Ownership == "Private") (line AnnualAverageEmployment_000s Year if Ownership == "Total Covered"), graphregion(color(white)) legend(order(1 "Private" 2 "Total"))
graph export employment_private.png, replace
restore

* Employment and Establishment by 4-digit SIC Code

* Nation
preserve 
keep if AreaType == "Nation"
graph twoway (line AnnualAverageEstablishmentCou Year if Industry == "Construction") (line AnnualAverageEstablishmentCou Year if Industry == "Education and health services") (line AnnualAverageEstablishmentCou Year if Industry == "Financial activities") (line AnnualAverageEstablishmentCou Year if Industry == "Goods-producing") (line AnnualAverageEstablishmentCou Year if Industry == "Information") (line AnnualAverageEstablishmentCou Year if Industry == "Leisure and hospitality") (line AnnualAverageEstablishmentCou Year if Industry == "Manufacturing") (line AnnualAverageEstablishmentCou Year if Industry == "Natural resources and mining") (line AnnualAverageEstablishmentCou Year if Industry == "Professional and business services") (line AnnualAverageEstablishmentCou Year if Industry == "Service-providing") (line AnnualAverageEstablishmentCou Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health services" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources and mining" 9 "Professional and business services" 10 "Service-providing" 11 "Trade, transportation, and utilities"))

graph twoway (line AnnualAverageEstablishmentCou Year if Industry == "Construction") (line AnnualAverageEstablishmentCou Year if Industry == "Education and health services") (line AnnualAverageEstablishmentCou Year if Industry == "Financial activities") (line AnnualAverageEstablishmentCou Year if Industry == "Goods-producing") (line AnnualAverageEstablishmentCou Year if Industry == "Information") (line AnnualAverageEstablishmentCou Year if Industry == "Leisure and hospitality") (line AnnualAverageEstablishmentCou Year if Industry == "Manufacturing") (line AnnualAverageEstablishmentCou Year if Industry == "Natural resources and mining") (line AnnualAverageEstablishmentCou Year if Industry == "Professional and business services") (line AnnualAverageEstablishmentCou Year if Industry == "Service-providing") (line AnnualAverageEstablishmentCou Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health services" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources and mining" 9 "Professional and business services" 10 "Service-providing" 11 "Trade, transportation, and utilities")) ytitle("")

graph twoway (line AnnualAverageEstablishmentCou Year if Industry == "Construction") (line AnnualAverageEstablishmentCou Year if Industry == "Education and health services") (line AnnualAverageEstablishmentCou Year if Industry == "Financial activities") (line AnnualAverageEstablishmentCou Year if Industry == "Goods-producing") (line AnnualAverageEstablishmentCou Year if Industry == "Information") (line AnnualAverageEstablishmentCou Year if Industry == "Leisure and hospitality") (line AnnualAverageEstablishmentCou Year if Industry == "Manufacturing") (line AnnualAverageEstablishmentCou Year if Industry == "Natural resources and mining") (line AnnualAverageEstablishmentCou Year if Industry == "Professional and business services") (line AnnualAverageEstablishmentCou Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources and mining" 9 "Professional services" 10 "Transportation and utilities")) ytitle("") ylabel(0(500000)2000000, angle(horizontal))

graph twoway (line AnnualAverageEstablishmentCou Year if Industry == "Construction") (line AnnualAverageEstablishmentCou Year if Industry == "Education and health services") (line AnnualAverageEstablishmentCou Year if Industry == "Financial activities") (line AnnualAverageEstablishmentCou Year if Industry == "Goods-producing") (line AnnualAverageEstablishmentCou Year if Industry == "Information") (line AnnualAverageEstablishmentCou Year if Industry == "Leisure and hospitality") (line AnnualAverageEstablishmentCou Year if Industry == "Manufacturing") (line AnnualAverageEstablishmentCou Year if Industry == "Natural resources and mining") (line AnnualAverageEstablishmentCou Year if Industry == "Professional and business services") (line AnnualAverageEstablishmentCou Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources and mining" 9 "Professional services" 10 "Transportation and utilities")) ytitle("") ylabel(0(500000)2000000, angle(horizontal) format(%12.0fc))

graph twoway (line AnnualAverageEmployment Year if Industry == "Construction") (line AnnualAverageEmployment Year if Industry == "Education and health services") (line AnnualAverageEmployment Year if Industry == "Financial activities") (line AnnualAverageEmployment Year if Industry == "Goods-producing") (line AnnualAverageEmployment Year if Industry == "Information") (line AnnualAverageEmployment Year if Industry == "Leisure and hospitality") (line AnnualAverageEmployment Year if Industry == "Manufacturing") (line AnnualAverageEmployment Year if Industry == "Natural resources and mining") (line AnnualAverageEmployment Year if Industry == "Professional and business services") (line AnnualAverageEmployment Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources and mining" 9 "Professional services" 10 "Transportation and utilities")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))
restore

* Kansas
preserve 
keep if StName == "Kansas" & Area == "Kansas -- Statewide"
graph twoway (line AnnualAverageEstablishmentCou Year if Industry == "Construction") (line AnnualAverageEstablishmentCou Year if Industry == "Education and health services") (line AnnualAverageEstablishmentCou Year if Industry == "Financial activities") (line AnnualAverageEstablishmentCou Year if Industry == "Goods-producing") (line AnnualAverageEstablishmentCou Year if Industry == "Information") (line AnnualAverageEstablishmentCou Year if Industry == "Leisure and hospitality") (line AnnualAverageEstablishmentCou Year if Industry == "Manufacturing") (line AnnualAverageEstablishmentCou Year if Industry == "Natural resources and mining") (line AnnualAverageEstablishmentCou Year if Industry == "Professional and business services") (line AnnualAverageEstablishmentCou Year if Industry == "Service-providing") (line AnnualAverageEstablishmentCou Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources" 9 "Professional services" 10 "Service-providing" 11 "Transportation and utilities")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))
graph twoway (line AnnualAverageEstablishmentCou Year if Industry == "Construction") (line AnnualAverageEstablishmentCou Year if Industry == "Education and health services") (line AnnualAverageEstablishmentCou Year if Industry == "Financial activities") (line AnnualAverageEstablishmentCou Year if Industry == "Goods-producing") (line AnnualAverageEstablishmentCou Year if Industry == "Information") (line AnnualAverageEstablishmentCou Year if Industry == "Leisure and hospitality") (line AnnualAverageEstablishmentCou Year if Industry == "Manufacturing") (line AnnualAverageEstablishmentCou Year if Industry == "Natural resources and mining") (line AnnualAverageEstablishmentCou Year if Industry == "Professional and business services") (line AnnualAverageEstablishmentCou Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources" 9 "Professional services" 10 "Transportation and utilities")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))
restore

preserve 
keep if StName == "Kansas" & Area == "Kansas -- Statewide"
graph twoway (line AnnualAverageEmployment Year if Industry == "Construction") (line AnnualAverageEmployment Year if Industry == "Education and health services") (line AnnualAverageEmployment Year if Industry == "Financial activities") (line AnnualAverageEmployment Year if Industry == "Goods-producing") (line AnnualAverageEmployment Year if Industry == "Information") (line AnnualAverageEmployment Year if Industry == "Leisure and hospitality") (line AnnualAverageEmployment Year if Industry == "Manufacturing") (line AnnualAverageEmployment Year if Industry == "Natural resources and mining") (line AnnualAverageEmployment Year if Industry == "Professional and business services") (line AnnualAverageEmployment Year if Industry == "Service-providing") (line AnnualAverageEmployment Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources" 9 "Professional services" 10 "Service-providing" 11 "Transportation and utilities")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))
graph twoway (line AnnualAverageEmployment Year if Industry == "Construction") (line AnnualAverageEmployment Year if Industry == "Education and health services") (line AnnualAverageEmployment Year if Industry == "Financial activities") (line AnnualAverageEmployment Year if Industry == "Goods-producing") (line AnnualAverageEmployment Year if Industry == "Information") (line AnnualAverageEmployment Year if Industry == "Leisure and hospitality") (line AnnualAverageEmployment Year if Industry == "Manufacturing") (line AnnualAverageEmployment Year if Industry == "Natural resources and mining") (line AnnualAverageEmployment Year if Industry == "Professional and business services") (line AnnualAverageEmployment Year if Industry == "Trade, transportation, and utilities"), graphregion(color(white)) legend(order(1 "Construction" 2 "Education and health" 3 "Financial activities" 4 "Goods-producing" 5 "Information" 6 "Leisure and hospitality" 7 "Manufacturing" 8 "Natural resources" 9 "Professional services" 10 "Transportation and utilities")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))
restore

* Wages

* National View
preserve

keep if AreaType == "Nation"
keep if Industry == "Total, all industries"

graph twoway (line AnnualAveragePay Year if Ownership == "Local Government") (line AnnualAveragePay Year if Ownership == "State Government") (line AnnualAveragePay Year if Ownership == "Federal Government") (line AnnualAveragePay Year if Ownership == "Private"), graphregion(color(white)) legend(order(1 "Local" 2 "State" 3 "Federal" 4 "Private")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))
graph export salaries_over_time.png, replace
graph twoway (line AnnualAveragePay Year if Ownership == "Private") (line AnnualAveragePay Year if Ownership == "Total Covered"), graphregion(color(white)) legend(order(1 "Private" 2 "Total")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))

restore

* Kansas View
preserve

keep if StName == "Kansas" & Area == "Kansas -- Statewide"
keep if Industry == "Total, all industries"

graph twoway (line AnnualAveragePay Year if Ownership == "Local Government") (line AnnualAveragePay Year if Ownership == "State Government") (line AnnualAveragePay Year if Ownership == "Federal Government") (line AnnualAveragePay Year if Ownership == "Private"), graphregion(color(white)) legend(order(1 "Local" 2 "State" 3 "Federal" 4 "Private")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))
graph twoway (line AnnualAveragePay Year if Ownership == "Private") (line AnnualAveragePay Year if Ownership == "Total Covered"), graphregion(color(white)) legend(order(1 "Private" 2 "Total")) ytitle("") ylabel(, angle(horizontal) format(%12.0fc))

restore
