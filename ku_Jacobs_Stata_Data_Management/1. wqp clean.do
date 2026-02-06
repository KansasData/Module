***** Data Management Workshop 1/29/26

* Set Working Directory
cd "Y:\2026 Projects\Workshops\Data Management"

* Import Data (Add code even if you use the dropdown menu to import data)
import delimited "Y:\2026 Projects\Workshops\Data Management\Data\biologicalresult.csv", clear

save "Working Data\wqp_clean.dta", replace
******************************************************************
* Coosing Variables
******************************************************************
/*
Consider:
1) what data do we need?
2) what data is available?

We want the sample location, time, test characteristic, test result, characteristic regulatory limit, and  any releavant identifiers about the sample methods, and 
*/

* Drop option
drop activitydepthheightmeasuremeasur activityrelativedepthname activityendtimetimezonecode activityendtimetime activityenddate 

* Keep may be more useful with many variables
* there may be inconsistencies in the data, but at this stage, we just want to identify what variables we want to work with.

keep organizationidentifier activitylocationlatitudemeasure activitylocationlongitudemeasure activityidentifier activitytypecode activitymedianame activitystartdate monitoringlocationidentifier samplecollectionmethodmethodiden resultdetectionconditiontext characteristicname resultmeasurevalue resultmeasuremeasureunitcode measurequalifiercode resultvaluetypename resultanalyticalmethodmethodiden resultanalyticalmethodmethodname detectionquantitationlimittypena detectionquantitationlimitmeasur v139

*****************************************************************
* Modifying data
*****************************************************************

split activitystartdate, gen(date) p("-")
rename date1 year
rename date2 month
rename date3 day

destring year, replace
destring month, replace
destring day, replace

describe resultmeasurevalue
destring resultmeasurevalue, replace

/*
drop if strpos(resultmeasurevalue, "<")
drop if strpos(resultmeasurevalue, "Clear")
drop if strpos(resultmeasurevalue, "N/A")
drop if strpos(resultmeasurevalue, "Ë5.0")
drop if strpos(resultmeasurevalue, "`")
drop if strpos(resultmeasurevalue, "U")
*/

destring resultmeasurevalue, gen(result_num) force

drop if result_num == .

save "Working Data\wqp_clean.dta", replace

*****************************************************************
* Naming and Labeling Variables
*****************************************************************

use "Working Data\wqp_clean.dta", clear

label var organizationidentifier "Organization Identifier"
label var activityidentifier "Activity Identifier" 
label var activitytypecode "Activity Type Code"
label var activitymedianame "Activity Media Name" 
label var activitystartdate "Activity Start Date"
label var monitoringlocationidentifier "Monitoring Location Identifier"
label var activitylocationlatitudemeasure "Activity Location Latitude Measure"
label var activitylocationlongitudemeasure "Activity Location Longitude Measure"
label var samplecollectionmethodmethodiden "Sample Collection Method" 
label var resultdetectionconditiontext "Result Detection Condition Text"
label var characteristicname "Characteristic Name"
label var result_num "Result Measure Value"
label var resultmeasuremeasureunitcode "Result Measure Unit Code"
label var measurequalifiercode "Measure Qualifer Code" 
label var resultvaluetypename "Result Value Type Name"
label var resultanalyticalmethodmethodiden "Result Analytical Method"
label var resultanalyticalmethodmethodname "Result Analytical Method Name"
label var detectionquantitationlimittypena "Detection Quantitation Limit Type"
label var detectionquantitationlimitmeasur "Detection Quantitation Limit Measure"
label var v139 "Detection Quantitation Limit Measure Unit Code"
label var year "Year"
label var month "Month"
label var day "Day"

rename organizationidentifier organization
rename activityidentifier activity
rename activitytypecode code
rename activitymedianame name
rename activitystartdate date
rename monitoringlocationidentifier location
rename activitylocationlatitudemeasure latitude
rename activitylocationlongitudemeasure longitude
rename samplecollectionmethodmethodiden method
rename resultdetectionconditiontext result_str
rename characteristicname characteristic
rename resultmeasuremeasureunitcode units
rename measurequalifiercode measure_qualifier
rename resultvaluetypename result_type
rename resultanalyticalmethodmethodiden analytical_method
rename resultanalyticalmethodmethodname analytical_method_name
rename detectionquantitationlimittypena limit_type_name
rename detectionquantitationlimitmeasur limit_measure
rename v139 limit_units

save "Working Data\wqp_clean.dta", replace

*****************************************************************
* Reshaping Data
*****************************************************************

use "Working Data\wqp_clean.dta", clear

** Create the panel
keep location latitude longitude
duplicates drop location, force
expand 5
sort location
bysort location: egen year = seq(), from(2020) to(2025)
expand 12
sort location year 
bysort location year: egen month = seq(), from(1) to(12)
save kdhe_locations_panel.dta, replace


** Select the characteristics of interest
use "Working Data\wqp_clean.dta", clear
tab characteristic

preserve 
keep if characteristic == "pH"
collapse (mean) result_num, by(location year month)
rename result_num ph
destring year, replace
destring month, replace
save ph_temp.dta, replace
restore

preserve 
keep if characteristic == "Turbidity"
collapse (mean) result_num, by(location year month)
rename result_num turbidity
destring year, replace
destring month, replace
save turbidity_temp.dta, replace
restore

preserve 
keep if characteristic == "Alkalinity, total"
collapse (mean) result_num, by(location year month)
rename result_num alkalinity
destring year, replace
destring month, replace
save alkalinity_temp.dta, replace
restore

preserve 
keep if characteristic == "Temperature, water"
collapse (mean) result_num, by(location year month)
rename result_num temperature
destring year, replace
destring month, replace
save temperature_temp.dta, replace
restore

preserve 
keep if characteristic == "Escherichia coli"
collapse (mean) result_num, by(location year month)
rename result_num ecoli
destring year, replace
destring month, replace
save ecoli_temp.dta, replace
restore

** Merge Data
use kdhe_locations_panel.dta, clear
merge 1:1 location year month using ph_temp
drop if _merge == 2
drop _merge 

merge 1:1 location year month using turbidity_temp
drop if _merge == 2
drop _merge 

merge 1:1 location year month using alkalinity_temp
drop if _merge == 2
drop _merge 

merge 1:1 location year month using temperature_temp
drop if _merge == 2
drop _merge 

merge 1:1 location year month using ecoli_temp
drop if _merge == 2
drop _merge 

save "Working Data\wqp_panel.dta", replace 


** Remove temp files
erase ph_temp.dta
erase turbidity_temp.dta
erase alkalinity_temp.dta
erase temperature_temp.dta
erase ecoli_temp.dta

******************************************************************
* Adding Geographies
******************************************************************
use "Working Data\wqp_panel.dta", clear
keep if latitude != .

shp2dta using "Data\Tiger_2020_Boundaries\Tiger_2020_Boundaries.shp", data("Working Data\county_data") coord("Working Data\county_coords") replace

*ssc install geoinpoly
geoinpoly latitude longitude using "Working Data\county_coords.dta"
merge m:1 _ID using "Working Data\county_data.dta", keepusing(NAMELSAD)
drop if _merge == 2
drop _merge
rename NAMELSAD county

**********************************************************















