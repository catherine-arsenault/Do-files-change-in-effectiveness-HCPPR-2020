
global user "/Users/acatherine/Dropbox (Harvard University)"
global data "HQSS Commission/C. Working groups/3. Improvement/Report content complete/Commissioned Work/Alex Rowe/Decay/Data"
global graphs "HQSS Commission/C. Working groups/3. Improvement/Report content complete/Commissioned Work/Alex Rowe/Decay/Results/Graphs/FINAL GRAPHS"


import excel "$user/$graphs/estimates.xlsx", sheet("gps_train") firstrow clear
append using  "$user/$data/gpstrain.dta"



* GRP PROB SOLV + TRAIN /// THERE ARE ONLY ITS STUDIES
set more off
local counter = 0 

local colors "blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red red cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue  cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red emidblue cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb"

levelsof idnum , loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'
	
	di "`color'"
	levelsof out_id_gr if idnum==`x', loc(outcome1)
	
	foreach i of local outcome1 {
		local  grapha (connected es_time time if out_id_gr==`i' , sort msize(vsmall) mcolor("`color'") lcolor("`color'")) `grapha'
		}
	}	

		local graph1 (rarea lb_gpstrain_all ub_gpstrain_all time, fcolor(dimgray) lcolor(black) lpattern(shortdash_dot)) `graph1'
		local graph2 (line y_gpstrain_all time, lcolor(black) lpattern(shortdash_dot)) `graph2'
	
twoway `graph1' `graph2'  `grapha' ,  ylabel(-30(10)100, labsize(vsmall)) xlabel(0(2)36, labsize(vsmall)) ytitle(Effect size (percentage points), size(small)) xtitle(Time since intervention (months), size(small)) ///
		 legend(off) graphregion(color(white)) yline(0, lcolor(black) lpattern(dot))  

		 
graph export "$user/$graphs/Grp_prb_train_all.pdf", replace




* GRP PROB SOLV ALL STUDIES

local colors "blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red red cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue  cyan  mint sunflowerlime sandb yellow sienna sand khaki stone ltkhaki eggshell  maroon erose brown olive_teal chocolate ltbluishgray8 bluishgray ltbluishgray gold dkorange orange orange_red emidblue cranberry blue red black green pink lime khaki orange magenta  navy  brown sand eltblue ebblue magenta purple edkblue emidblue cyan  mint sunflowerlime sandb"


levelsof idnum if  strat==4 & type=="ITS", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'
	
	levelsof out_id_gr if idnum==`x', loc(outcome1)
	
	foreach i of local outcome1 {
		local grapha (connected es_time time if out_id_gr==`i' & strat==4, sort msize(vsmall) mcolor("`color'") lcolor("`color'")) `grapha'
	}
}	

	
levelsof idnum if  strat==4 & type=="2P", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'

	levelsof out_id_gr if idnum==`x', loc(outcome1)
	
	foreach i of local outcome1 {
		local graphb (connected es_time time if out_id_gr==`i' & strat==4, sort msize(vsmall) mcolor("`color'") lcolor("`color'")) `graphb'
	}
}

levelsof idnum if  strat==4 & type=="1P", loc(study1)

foreach x of local study1 {		
	local counter = `counter' + 1
	local color: word `counter' of `colors'
	
levelsof out_id_gr if idnum==`x' & strat==4 & type=="1P", loc(outcome1p)

	foreach i of local outcome1p {

	local graphc (scatter es_time time if out_id_gr==`i' & strat==4, sort msize(vsmall) mcolor("`color'")) `graphc'
		}
	}	
		local graph5 (rarea lb_gps_all ub_gps_all time, fcolor(dimgray)  lcolor(black) lpattern(shortdash_dot) ) `graph5'
		local graph6 (line y_gps_all time, lcolor(black) lpattern(shortdash_dot)  ) `graph6'
		
twoway `graph5' `graph6' `grapha' `graphb' `graphc' , ylabel(-20(10)100, labsize(vsmall)) xlabel(0(2)36, labsize(vsmall)) ytitle(Effect size (percentage points), size(small)) xtitle(Time in months since intervention, size(small)) ///
		 legend(off) graphregion(color(white)) yline(0, lcolor(black) lpattern(dot)) 

graph export "$user/$graphs/Grp_prob_all.pdf", replace

