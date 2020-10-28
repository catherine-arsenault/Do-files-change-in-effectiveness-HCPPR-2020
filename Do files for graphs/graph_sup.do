
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "HQSS Commission/C. Working groups/3. Improvement/Report content complete/Commissioned Work/Alex Rowe/Decay/Data"
global graphs "HQSS Commission/C. Working groups/3. Improvement/Report content complete/Commissioned Work/Alex Rowe/Decay/Results/Graphs/FINAL GRAPHS"

import excel "$user/$graphs/estimates.xlsx", sheet("sup") firstrow clear

append using  "$user/$data/5strat.dta"

drop if time>35

* SUPERVISION ITS ONLY
set more off
local counter = 0 

local colors "blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red red cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue  cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red emidblue cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb"

levelsof idnum if  strat==2 & type=="ITS", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'
	
	di "`color'"
	levelsof out_id_gr if idnum==`x' & strat==2 & type=="ITS", loc(outcome1)
	
	foreach i of local outcome1 {
		local grapha (connected es_time time if out_id_gr==`i' & strat==2, sort msize(vsmall) mcolor("`color'") lcolor("`color'")) `grapha'
	}
}	

		local graph1 (rarea lb_sup_its ub_sup_its time, fcolor(dimgray)  lcolor(black) lpattern(shortdash_dot) ) `graph1'
		local graph2 (line y_sup_its time, lcolor(black) lpattern(shortdash_dot)  ) `graph2'
	
	
twoway `graph1' `graph2' `grapha' , ylabel(-20(10)80, labsize(vsmall)) xlabel(0(2)34, labsize(vsmall)) ytitle(Effect size (percentage points), size(small)) xtitle(Time since intervention (months), size(small)) ///
		legend(off) graphregion(color(white)) yline(0, lcolor(black) lpattern(dot)) 

graph export "$user/$graphs/superv_its.pdf", replace


* SUPERVISION ITS and 2P
local colors "blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red red cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue  cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red emidblue cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb"

levelsof idnum if  strat==2 & type=="ITS", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'
	
	levelsof out_id_gr if idnum==`x', loc(outcome1)
	
	foreach i of local outcome1 {
		local grapha (connected es_time time if out_id_gr==`i' & strat==2, sort msize(vsmall) mcolor("`color'") lcolor("`color'")) `grapha'
	}
}	
	
levelsof idnum if  strat==2 & type=="2P", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'

	levelsof out_id_gr if idnum==`x', loc(outcome1)
	
	foreach i of local outcome1 {
		local graphb (connected es_time time if out_id_gr==`i' & strat==2, sort msize(vsmall) mcolor("`color'") lcolor("`color'")) `graphb'
	}
}
	
		local graph3 (rarea lb_sup_2p ub_sup_2p time, fcolor(dimgray)  lcolor(black) lpattern(shortdash_dot) ) `graph3'
		local graph4 (line y_sup_2p time, lcolor(black) lpattern(shortdash_dot)  ) `graph4'
		
twoway `graph3' `graph4' `grapha' `graphb'  , ylabel(-30(10)100, labsize(vsmall)) xlabel(0(2)34, labsize(vsmall)) ytitle(Effect size (percentage points), size(small)) xtitle(Time in months since intervention, size(small)) ///
		 legend(off) graphregion(color(white)) yline(0, lcolor(black) lpattern(dot)) 

graph export "$user/$graphs/Superv_its_2p_extoct27.pdf", replace
	

* ALL STUDIES
local colors "blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red red cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue  cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red emidblue cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb"

levelsof idnum if  strat==2 & type=="ITS", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'
	
	levelsof out_id_gr if idnum==`x', loc(outcome1)
	
	foreach i of local outcome1 {
		local grapha (connected es_time time if out_id_gr==`i' & strat==2, sort msize(vsmall) mcolor("`color'") lcolor("`color'")) `grapha'
	}
}	

levelsof idnum if  strat==2 & type=="2P", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'

	levelsof out_id_gr if idnum==`x', loc(outcome1)
	
	foreach i of local outcome1 {
		local graphb (connected es_time time if out_id_gr==`i' & strat==2, sort msize(vsmall) mcolor("`color'") lcolor("`color'")) `graphb'
	}
}
levelsof idnum if  strat==2 & type=="1P", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'
	
levelsof out_id_gr if idnum==`x' & strat==2 & type=="1P", loc(outcome1p)

	foreach i of local outcome1p {

	local graphc (scatter es_time time if out_id_gr==`i' & strat==2, sort msize(vsmall) mcolor("`color'")) `graphc'
		}
	}	
		local graph5 (rarea lb_sup_all ub_sup_all time, fcolor(dimgray)  lcolor(black) lpattern(shortdash_dot) ) `graph5'
		local graph6 (line y_sup_all time, lcolor(black) lpattern(shortdash_dot)  ) `graph6'
		
twoway `graph5' `graph6' `grapha' `graphb' `graphc' , ylabel(-20(10)80, labsize(vsmall)) xlabel(0(2)34, labsize(vsmall)) ytitle(Effect size (percentage points), size(small)) xtitle(Time in months since intervention, size(small)) ///
		 legend(off) graphregion(color(white)) yline(0, lcolor(black) lpattern(dot)) 

graph export "$user/$graphs/Superv_alloct27.pdf", replace

