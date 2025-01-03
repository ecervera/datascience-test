*Master Thesis Inga Michalek* Master in International Economics
**************************************************************
**Main results
***************
*litigation from Graham Institute:  https://climate-laws.org/legislation_and_policies
*takes the value of 1, when the first case related to environmental laws was solved in a given year, indipendently of the result
*rule of law from world bank
*Sample excludes de US, and include all countries for which there has been at least a case with a resolutiuon: 23 countries, mostly HI and MI countries
**********************************
*Whole sample
 ssc install estout, replace
 ssc install medsem, replace
  estpost summarize price weight rep78 mpg   
 esttab, cells("count mean sd min max")*Import
*mac
clear all
import excel "/Users/inmamartinez/Dropbox/Master_theses/21742469_1_Master_thesis_Inga_Michalek/Data_Inga Michalek.xlsx", sheet("Tabelle1") firstrow
drop I J K L 


*uji*
import excel "C:\Users\martinei\Dropbox\Master_theses\21742469_1_Master_thesis_Inga_Michalek\Data_Inga Michalek.xlsx", sheet("Tabelle1") firstrow clear
drop I J K L 

* Renames
rename Year year
rename GDP gdp
rename Population population
rename RuleofLaw ruleoflaw
rename LitigationDummyNew litigation
rename FillingDateDummyNew fillingdate
rename TotalGHG ghg

* Country_ID numerical
egen id = group(country)

xtset id year
* Creation of Log-Values
gen lnghg = ln(ghg)
gen lngdp = ln(gdp)
gen lngdp2 = lngdp^2
gen lnpopulation = ln(population)
gen lnlaw = ln(ruleoflaw)
**************************
*Table 2* sum statistics*********
************************
sum lnghg lngdp lngdp2 lnpop lnlaw litigation
/*   Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
       lnghg |        928    18.48851     1.49546   14.41435   21.93966
       lngdp |        905    9.986052    .9750395   7.388111   11.70063
      lngdp2 |        905    100.6709     18.6502   54.58419   136.9048
lnpopulation |        928    16.52304    1.576204   12.85278   21.02533
       lnlaw |        640    4.183953     .470828   2.664199    4.60517
-------------+---------------------------------------------------------
  litigation |        928    .2176724     .412886          0          1
*/
*sum original variables
 estpost summarize gdp population ruleoflaw litigation fillingdate  
 esttab, cells("count mean sd min max")
 

********************** 
*Groups of countries*
**********************
*HI

gen HI=0

replace HI=1 if country=="BEL"
replace HI=1 if country=="AUS"
replace HI=1 if country=="CAN"
replace HI=1 if country=="CHE"
replace HI=1 if country=="DEU"
replace HI=1 if country=="ESP"
replace HI=1 if country=="EST"
replace HI=1 if country=="FIN"
replace HI=1 if country=="FRA"
replace HI=1 if country=="GBR"
replace HI=1 if country=="GRC"
replace HI=1 if country=="HRV"
replace HI=1 if country=="ITA"
replace HI=1 if country=="LTU"
replace HI=1 if country=="LUX"
replace HI=1 if country=="NLD"
replace HI=1 if country=="NOR"
replace HI=1 if country=="NZL"
replace HI=1 if country=="POL"
replace HI=1 if country=="PRT"
replace HI=1 if country=="SVK"
replace HI=1 if country=="SWE"
replace HI=1 if country=="ROU"

  *Import
sum lnghg lngdp lngdp2 lnpop lnlaw litigation if HI==1
 /* 
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
       lnghg |        667     18.6179     1.27205   15.95322   20.87187
       lngdp |        644    10.49497    .4640565   9.257596   11.70063
      lngdp2 |        644    110.3594    9.684836   85.70309   136.9048
lnpopulation |        667    16.26146    1.283457   12.85278   18.23322
       lnlaw |        460    4.411902    .2305409   2.664199    4.60517
-------------+---------------------------------------------------------
  litigation |        667    .2593703     .438618          0          1

*/
*MI
gen MI=0
replace MI=1 if country=="BGR"
replace MI=1 if country=="CRI"
replace MI=1 if country=="FJI"
replace MI=1 if country=="IND"
replace MI=1 if country=="KEN"
replace MI=1 if country=="PAK"
replace MI=1 if country=="NPL"
replace MI=1 if country=="PHL"
replace MI=1 if country=="UKR"

sum lnghg lngdp lngdp2 lnpop lnlaw litigation if MI==1
/*

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
       lnghg |        232    18.38899    1.910758   14.41435   21.93966
       lngdp |        261    8.730336    .7406391   7.388111   11.24273
      lngdp2 |        261    76.76522    13.08562   54.58419   126.3991
lnpopulation |        261    17.19153    2.003558   13.49885   21.02533
       lnlaw |        180    3.601417    .4246115   2.664199   4.304065
-------------+---------------------------------------------------------
  litigation |        261    .1111111    .3148735          0          1

   

*/


 dtable lnghg lngdp lngdp2 lnpopulation lnlaw i.litigation i.fillingdate, by(HI) export(table1.html, replace)
 collect style putdocx, layout(autofitcontents)

collect export table2.docx, replace 

*****************
reg lnghg lngdp lngdp2 lnpopulation lnlaw litigation, robust
sum lnghg lngdp lngdp2 lnpopulation lnlaw litigation if e(sample)
bysort HI:sum lnghg lngdp lngdp2 lnpopulation lnlaw litigation if e(sample)

*Graph emissions by litigation cases*
kdensity lnghg if litigation==0, recast(scatter) msymbol(circle) mlabel()  addplot((kdensity lnghg if litigation==1))

************
*Table 3
************
* OLS Table 3, column (1)
reg lnghg lngdp lngdp2 lnpopulation lnlaw litigation, robust

*Testing of some assumptions
 * Assumption: Expected value of error terms = 0
predict pred_lngdp
predict pred_residuals, res
scatter pred_residuals pred_lngdp

* Assumtion: Homoscedasty
	* Test for Heteroscedasty
hettest				

* Correlation between Population and GDP
pwcorr lnpopulation lngdp, sig star(0.05)

pwcorr lnghg lngdp* lnpop litigation lnlaw, sig star(0.05)

* Asssumption
predict residuen, res
predict fitted

scatter fitted residuen

* Assumption (normal distribution residuals)
qnorm residuen

*1. Model with fixed effects-Whole sample- Table 3, column (2)
reg lnghg lngdp lngdp2 lnpop lnlaw litigation i.year i.id, robust

sum lnghg lngdp lngdp2 lnpop lnlaw litigation if e(sample)
  /*  Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
       lnghg |        639    18.49097    1.492107   14.53335   21.93966
       lngdp |        639    10.05512    .9398277   7.537145   11.70063
      lngdp2 |        639    101.9874    18.09363   56.80855   136.9048
lnpopulation |        639    16.54779    1.587678   12.93417   21.02533
       lnlaw |        639    4.183375    .4709692   2.664199    4.60517
-------------+---------------------------------------------------------
  litigation |        639    .3161189    .4653242          0          1

*/
cd "C:\Users\martinei\Dropbox\Master_theses\21742469_1_Master_thesis_Inga_Michalek\

*mac
cd "/Users/inmamartinez/Dropbox/Master_theses/21742469_1_Master_thesis_Inga_Michalek/"

**************
*TABLE 3 NEW
**************

reg lnghg lngdp lngdp2 lnpopulation lnlaw litigation , robust
outreg2 using Tabla3.xls, replace ctitle (OLS) drop   (i.year _cons)  stats(coef, tstat, blank)  addtext(Time FE, NO, Country FE, NO)

xtreg lnghg lngdp lngdp2 lnpopulation lnlaw litigation i.year, fe robust
outreg2 using Tabla3.xls, append ctitle (TW-FE)   drop (i.year _cons)  stats(coef, tstat, blank)  addtext(Time FE, YES, Country FE, YES)

reg lnghg lngdp lngdp2 lnpopulation lnlaw HI#c.litigation, robust
outreg2 using Tabla3.xls, append ctitle (OLS)  drop (i.year _cons) stats(coef, tstat, blank)  addtext(Time FE, NO, Country FE, NO)

xtreg lnghg lngdp lngdp2 lnpopulation lnlaw HI#c.litigation i.year, fe robust
outreg2 using Tabla3.xls, append ctitle (TW-FE)   drop (i.year _cons) stats(coef, tstat, blank)  addtext(Time FE, YES, Country FE, YES)

*xtreg lnghg lngdp lngdp2 lnpopulation lnlaw litigation i.year if HI==1, fe robust
*outreg2 using Tabla3.xls, append ctitle (TW-FE)   drop (i.year)  stats(coef, tstat,blank)  addtext(Time FE, YES, Country FE, YES)

*xtreg lnghg lngdp lngdp2 lnpopulation lnlaw litigation i.year if HI==0, fe robust
*outreg2 using Tabla3.xls, append ctitle (TW-FE)   drop (i.year _cons)  stats(coef, tstat, blank)  addtext(Time FE, YES, Country FE, YES)

****************************
*TABLE 4 whole sample:
*****************************

gen UMI=0
replace UMI=1 if gdp<12700

*(0) single factors and Interaction with rule of law:the interation is ns
*Not included in Table 4:
xtreg lnghg lngdp lngdp2 lnpop c.lnlaw##i.litigation  i.year  , fe robust

*(1)if rule of law is more efective after a litigation case has been decided
xtreg lnghg lngdp lngdp2 lnpop c.lnlaw#i.litigation  i.year  , fe robust 
outreg2 using Tabla4.xls, replace ctitle (TWFE) drop   (i.year o.* _cons)  stats(coef, tstat, blank)  

*(2)Group of countries using tresholds for GDP per capita

*low income<1,045; LMI<4,095, UMI<12,695,HI>12695

xtreg lnghg lngdp lngdp2 lnpop lnlaw UMI#c.litigation i.year , fe  robust
outreg2 using Tabla4.xls, append ctitle (UMI) drop   (i.year o.* _cons)  stats(coef, tstat, blank)  

*(3)  IV with gmm: using past filling date as instrument--

xi:xtivreg2 lnghg lngdp lngdp2 lnpop lnlaw i.year (litigation=l(-2/-1).fillingdate), fe gmm robust
outreg2 using Tabla4.xls, append ctitle (IV-GMM) e(idstat cdf rkf jp) drop  (_Iyear* o._*)  stats(coef, tstat, blank) 

*(4)
xi:xtivreg2 lnghg lngdp lngdp2 lnpop lnlaw i.year (litigation=l(-1).fillingdate), fe gmm robust
***********************************
*Robustness checks:
************************************

***************************************
*Robustness: (2) Exclusion of EIT-Table 
***************************************
* Robustness: Exclusion of EIT
gen EIT=1
replace EIT=0 if country=="BGR"
replace EIT=0 if country=="HRV"
replace EIT=0 if country=="EST"
replace EIT=0 if country=="LTU"
replace EIT=0 if country=="POL"
replace EIT=0 if country=="ROU"
replace EIT=0 if country=="SVK"
* Robustness: Only European countries
gen EU=1
replace EU=0 if country=="CAN"
replace EU=0 if country=="CRI"
replace EU=0 if country=="FJI"
replace EU=0 if country=="IND"
replace EU=0 if country=="KEN"
replace EU=0 if country=="NZL"
replace EU=0 if country=="PAK"
replace EU=0 if country=="PHL"
replace EU=0 if country=="AUS"
replace EU=0 if country=="NPL"
*******
*TABLE 5
********
*Robustness without EIT
**************************

xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation i.year if EIT==1,fe robust
outreg2 using Table5.xls, replace ctitle (EIT-FE) drop   (i.year o._ _cons)  stats(coef, tstat, blank)
*Robustness: Only European countries-Table 5
***********************

xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation i.year if EU==1,fe robust
outreg2 using Table5.xls, append ctitle (EU-FE) drop (i.year o._ _cons)  stats(coef, tstat, blank)  

*Robustness (4) separating climate alligned from not
***+++*+
gen ncl=0  
replace ncl=1 if country=="AUS"
replace ncl=1 if country=="BEL"
replace ncl=1 if country=="EST"
replace ncl=1 if country=="DEU"
replace ncl=1 if country=="GRC"
replace ncl=1 if country=="NZL"
replace ncl=1 if country=="NOR"
replace ncl=1 if country=="GBR"
replace ncl=1 if country=="CHE"
replace ncl=1 if country=="UKR"
replace ncl=1 if country=="PTR"
replace ncl=1 if country=="KEN"
replace ncl=1 if country=="FJI"

gen ncllitig=ncl*litigation
xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation ncllitig i.year,fe robust
outreg2 using Table5.rtf, append ctitle (EU-OLS)  drop (i.year o._ _cons)  stats(coef, tstat, blank)  



*Robustness (5) Kyoto countries:
  **************************
*Annex 1
gen kyoto=0
replace kyoto=1 if HI==1&year>=2008
xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation  kyoto i.year,fe robust
outreg2 using Table5.xls, append ctitle (Kyoto) drop (i.year o._ _cons)   stats(coef, tstat, blank)  

xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation#kyoto i.year,fe robust


********************************
*FIGURES 3-5
*******************************
*summary statistics
*summary statistics: Whole sample-Table 2 Panel A

summarize
*Figure 3: GHG emissions of middle-income countries
preserve
collapse (mean) lnghg, by (year)
graph twoway line lnghg year
restore

*summary statistics: High-income countries-Table 2 Panel B

summarize if HI==1
*Figure 4: GHG emissions of high-income countries
preserve
keep if HI==1
collapse (mean) lnghg, by (year)
graph twoway line lnghg year
restore

*summary statistics: Middle-income countries-Table 2 Panel C

summarize if MI==1
*Figure 5: GHG emissions of middle-income countries
preserve
keep if MI==1
collapse (mean) lnghg, by (year)
graph twoway line lnghg year
restore
********************************
*END

****************************
***********************************
*NOT INCLUDED YET IN REPLICATION R and JUPYTER*
***********************************

***************************////////////////////////////
*robustness(6) Adding EPS (Environmental Strngency index  for 18 countires available)->FOR THE FUTURE add the codes in R and ...Pyton
***************************/////////////////////////////
cd "/Users/inmamartinez/Dropbox/conf_abstracts_2024/INFERAC24_Litig/
use litigclean.dta, clear

rename country iso3
sort iso3 year
merge m:m iso3 year using "EPS_1990_2020_iso3.dta"
keep if _merge==3
* Country_ID numerical
drop id
egen id = group(country)

xtset id year

xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation eps i.year,fe robust
outreg2 using Table6.xls, replace ctitle (EIT-FE) drop   (i.year o._ _cons)  stats(coef, tstat, blank)

xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation eps_* i.year,fe robust
outreg2 using Table6.xls, append ctitle (EIT-FE) drop   (i.year o._ _cons)  stats(coef, tstat, blank)

*xtreg lnghg lngdp lngdp2 lnpop litigation##c.eps_* i.year,fe robust
*adding non linearities in the EPS
xtreg lnghg lngdp lngdp2 lnpop litigation c.lnlaw##c.eps_* i.year,fe robust
outreg2 using Table6.xls, append ctitle (EIT-FE) drop   (i.year o._ _cons)  stats(coef, tstat, blank)

xtreg lnghg lngdp lngdp2 lnpop lnlaw i.litigation##c.eps_* i.year,fe robust
outreg2 using Table6.xls, append ctitle (EIT-FE) drop   (i.year o._ _cons)  stats(coef, tstat, blank)
*adding non linearities in the EPS
*squared term for eps, non-sign (Not included in Table 6)
xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation c.eps##c.eps i.year,fe robust
*outreg2 using Table6.xls, append ctitle (EIT-FE) drop   (i.year o._ _cons)  stats(coef, tstat, blank)
***********************
*adding a dummy for EU membership
***********************
gen eu=0

replace eu=1 if (iso3=="BEL"|iso3=="DEU"|iso3=="FRA"|iso3=="ITA"|iso3=="NLD"|iso3=="PRT"|iso3=="ESP"|iso3=="GBR"|iso3=="GRC")

replace eu=1 if (iso3=="AUS"|iso3=="FIN"|iso3=="SWE")&year>=1994

replace eu=1 if (iso3=="CHE"|iso3=="POL"|iso3=="SVK")&year>=2003
************************Not included in table 6
xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation eps eu i.year,fe robust
*outreg2 using Table6.xls, append ctitle (EIT-FE) drop   (i.year o._ _cons)  stats(coef, tstat, blank)  

xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation##eu eps i.year,fe robust
*outreg2 using Table6.xls, append ctitle (EIT-FE) drop   (i.year o._ _cons)  stats(coef, tstat, blank)
*with iv weak significant if we do a 2-side test:
xi:xtivreg2 lnghg lngdp lngdp2 lnpop lnlaw eps i.year (litigation=l(-2/-1).fillingdate), fe gmm  robust

*one side test:
test _b[litigation]=0

local sign_litigation = sign(_b[litigation])  

display "H_0: coef<=0  p-value = " 1-normal(`sign_litigation'*sqrt(r(chi2)))
*H_0: coef<=0  p-value = .93274743

*We cannot reject the null that litigation has a negative and significant effect on GHG emissions!!

*for the whole period without rule of law:
xtreg lnghg lngdp lngdp2 lnpop litigation eu eps i.year,fe robust

xtregiv lnghg lngdp lngdp2 lnpop litigation eu eps ,fe 

xtreg lnghg lngdp lngdp2 lnpop lnlaw litigation##eu eps i.year,fe robust

/////////////////////////////////////////////////////////////////////


***********
*MEDIATION
************
*Whole sample THESE RESULTs ARE NOT INCLUDED IN THE PAPER

*Robustness:(1) Mediation Baron & Kenny; Sobel test-Figure 6 & Appendix 3
**simple mediation analysis. The model is specified such that the effect of fillingdate on lnghg is mediated by litigation. The direct effect of fillingdate variable MUST be included in the model, filling out the full mediation triangle. 

sem (lnghg<-litigation fillingdate  lngdp lngdp2 lnpop lnlaw) (litigation<-fillingdate),nocapslatent
outreg2 using Figure6.xls, replace ctitle (SEM)   stats(coef, tstat, blank)  addtext(Time FE, YES, Country FE, YES)


**Sobel Test result
medsem, indep(fillingdate) med(litigation) dep(lnghg) mcreps(500) rit rid
outreg2 using Figure6.xls, append ctitle (MED_SEM)   stats(coef, tstat, blank)  addtext(Time FE, YES, Country FE, YES)
****************


