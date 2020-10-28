/*******************************************************************************
HCPPR COMBINED WAVE 1 & 2 
Analyses for: Change in strategy effectiveness overtime manuscript
Created by: Catherine Arsenault
Last updated: October 28, 2020
********************************************************************************/
use "$user/$data/final_MAY14.dta", clear
********************************************************************************
* DESCRIPTIVE RESULTS
********************************************************************************		
* Nb of studies per strategy and type
		table strat if tags
		table strat type if tags
			
* Nb of comparisons-specific outcomes per strategy and type
		table strat if tagc
		table strat type if tagc
			
* Nb of effect sizes per strategy and types
		table strat
		table strat type 
		
* Nb of effect sizes per strategy and types
		table strat TRAIN_INTER
		table strat type TRAIN_INTER
		table strat SUP_ONCE
		table strat type SUP

		table strat TRAIN_INTER if tags
		table strat type TRAIN_INTER if tags
		table strat SUP_ONCE if tags
		table strat type SUP_ONCE if tags
			
		table strat TRAIN_INTER if tagc
		table strat type TRAIN_INTER if tagc
		table strat SUP_ONCE if tagc
		table strat type SUP_ONCE if tagc
			
* Nb of effect sizes per study type
		table	type, c( min es_per_out	p25	es_per_out med es_per_ouT max es_per_out)
		table	type, c( min es_per_out	p25	es_per_out med es_per_out max es_per_out)
		
* Follow-up times 
		hist time if type!="1P", by(strat, ///
		legend(off) graphregion(color(white))) percent 
		hist time , by(strat, legend(off) graphregion(color(white)))  percent 
		
* Follow-up times by strategy type
		by strat, sort: tabstat time if type!="1P" , sta(mean  min max )

* Mean baseline effect sizes per strategy types
		forval i= 1/5 {
			su esbaseline if type!="1P" & strat==`i'	
		}
********************************************************************************	
* COMBINED REGRESSIONS: TABLE 1 A-E
********************************************************************************	
* TRAINING
*Training, ITS and 2P
	mixed es_time time esbaseline || idnum:  if strat==1  & type!="1P", ///
		  vce(cluster idnum) covariance(identity) 
	predict es1
	predict rs_train1, rstandard
	*Normality of residuals
	qnorm rs_train1,   graphregion(color(white))
	graph export "$user/$graphs/Residuals/qnorm_train_its_2p.pdf", replace	
	* Linearity assumption
	twoway (scatter rs_train1 es1), yline(0)
	graph export "$user/$graphs/Residuals/residuals_train_its_2p.pdf", replace	
	
	* Predictions for graphs
	margins, at(time=(0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30))
	
*Training, all studies
	mixed es_time time esbaseline || idnum:   if strat==1 , ///
	mle   vce(cluster idnum) covariance(identity)
	predict es2
	predict rs_train2, rstandard
	*Normality of residuals
	qnorm rs_train2,  graphregion(color(white))
	graph export "$user/$graphs/Residuals/qnorm_train_all.pdf", replace
	margins, at(time=(0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30))	
	
	* Training, all studies, restrict time to 27 months (>= 3 studies)
	mixed es_time time esbaseline || idnum:   if strat==1 & time<28 , ///
	mle   vce(cluster idnum) covariance(identity) 	
	predict rs_train3, rstandard
	qnorm rs_train3,   graphregion(color(white))
	
	* Training, ITS 2P, restrict time to 12 months (>=3 studies)
	mixed es_time time esbaseline || idnum:   if strat==1 & time<13 & type!="1P", ///
	mle   vce(cluster idnum)	covariance(identity) 
	predict rs_train4, rstandard
	qnorm rs_train4,   graphregion(color(white))
	
* SUPERVISION
	*  Supervision, only ITS
	mixed es_time time esbaseline  || idnum:  if strat==2 & type=="ITS" , ///
	mle   vce(cluster idnum) covariance(identity) 
	predict rs_sup1, rstandard
	qnorm rs_sup1,   graphregion(color(white))
	margins, at(time=(0 4 8 12 16 20 24 28 32 33))
	
	* Supervision, ITS and 2P
	mixed es_time time esbaseline  || idnum:  if strat==2 & type!="1P" , ///
	mle   vce(cluster idnum) covariance(identity) 
	predict rs_sup2, rstandard
	qnorm rs_sup2,   graphregion(color(white))
	margins, at(time=(0 4 8 12 16 20 24 28 32 33))
	
	* Supervision, all studies
	mixed es_time time esbaseline  || idnum:  if strat==2  , ///
	mle   vce(cluster idnum)  covariance(identity) 
	predict rs_sup3, rstandard
	qnorm rs_sup3,   graphregion(color(white))
	margins, at(time=(0 4 8 12 16 20 24 28 32 33))
	
	* Supervision, all studies, restrict time to 10 monts (>=3 studies)
	mixed es_time time esbaseline  || idnum:  if strat==2 & type!="1P" & time<11 ///
	, mle   vce(cluster idnum) covariance(identity) 
	predict rs_sup4, rstandard
	qnorm rs_sup4,   graphregion(color(white))
	
	*  Supervision, ITS and 2P, restrict time to 6 monts (>=3 studies)
	mixed es_time time esbaseline  || idnum:  if strat==2 & time<7 & type!="1P", ///
	mle   vce(cluster idnum)  covariance(identity) 
	predict rs_sup4, rstandard
	qnorm rs_sup4,   graphregion(color(white))
	
* TRAINING COMBINED WITH SUPERVISION
	*Train+Sup,  2P only
	mixed es_time time esbaseline  || idnum: if strat==3  & type!="1P", ///
	mle   vce(cluster idnum)  covariance(identity) 
	predict rs_tsup1, rstandard
	qnorm rs_tsup1,   graphregion(color(white))
	margins, at(time=(0 2 4 6 8 10 12 14 16))
	
	*Train+Sup, all studies
	mixed es_time time esbaseline  || idnum:  if strat==3  , ///
	mle   vce(cluster idnum) covariance(identity) 
	predict rs_tsup2, rstandard
	qnorm rs_tsup2,   graphregion(color(white))
	margins, at(time=(0 2 4 6 8 10 12 14 16))
	
	* Train+Sup, all studies, restrict time to 15 months (>=3 studies)
	mixed es_time time esbaseline  || idnum:  if strat==3 & time<16 , ///
	mle   vce(cluster idnum)   covariance(identity) 
	predict rs_tsup3, rstandard
	qnorm rs_tsup3,   graphregion(color(white))
	
	* Train+Sup, 2P only restrict time to 6 months (>=3 studies)
	mixed es_time time esbaseline  || idnum:  if strat==3 & time<7 & type!="1P", ///
	mle   vce(cluster idnum)   covariance(identity) 
	predict rs_tsup4, rstandard
	qnorm rs_tsup4,   graphregion(color(white))
	
* GROUP PROBLEM SOLVING
	* GPS, ITS only
	mixed es_time time esbaseline || idnum:  if strat==4 & type=="ITS", ///
	mle   vce(cluster idnum)  covariance(identity) 
	predict rs_gps1, rstandard
	qnorm rs_gps1,   graphregion(color(white))
	margins, at(time=(0 4 8 12 16 20 24 28 32 35))
	
	* GPS, all studies
	mixed es_time time esbaseline || idnum: if strat==4 , ///
	mle   vce(cluster idnum)  covariance(identity) 
	predict rs_gps2, rstandard
	qnorm rs_gps2,   graphregion(color(white))
	margins, at(time=(0 4 8 12 16 20 24 28 32 35))
	
	* GPS, all studies, restrict time to 29 months (>=3 studies)
	mixed es_time time esbaseline || idnum: if strat==4 & time<30, ///
	mle   vce(cluster idnum)  covariance(identity) 
	predict rs_gps3, rstandard
	qnorm rs_gps3,   graphregion(color(white))
	
	* GPS, ITS only, restrict time to 29 months (>=3 studies)
	mixed es_time time esbaseline || idnum: if strat==4 & time<30 & type!="1P", ///
	mle   vce(cluster idnum) covariance(identity)  
	predict rs_gps4, rstandard
	qnorm rs_gps4,   graphregion(color(white))
	
* GROUP PROBLEM SOLVING PLUS TRAINING		
	* GPS + Training, ITS + 2P 
	mixed es_time time esbaseline || idnum: if strat==5 , ///
	mle nolog vce(cluster idnum) covariance(identity) 
	predict rs_gpst1, rstandard
	qnorm rs_gpst1,   graphregion(color(white))
	margins, at(time=(0 2 4 6 8 10 12 14 16 18 20 22 24 ))	
	
	* GPS + Training, ITS + 2P, restrict time to 13 months (>=3 studies)
	mixed es_time time esbaseline || idnum: if strat==5 & time<13 , ///
	mle nolog vce(cluster idnum) covariance(identity) 	
	predict rs_gpst2, rstandard
	qnorm rs_gpst2,   graphregion(color(white))
********************************************************************************	
* TRAINING AND SUPERVISION STRATIFIED BY DOSE (ONE OFF OR ONGOING INTERVENTIONS)
********************************************************************************		
* TRAINING
	*One-time training, ITS and 2P	
	mixed es_time time esbaseline || idnum:  if strat==1 & TRAIN_INTER==0 & ///
	type!="1P", mle   vce(cluster idnum) covariance(identity) 
	predict rs_trains1, rstandard
	qnorm rs_trains1,   graphregion(color(white))
	
	*One-time training, all studies
	mixed es_time time esbaseline || idnum:  if strat==1 & TRAIN_INTER==0 , ///
	mle   vce(cluster idnum) covariance(identity) 		
	predict rs_trains2, rstandard
	qnorm rs_trains2,   graphregion(color(white))
	
	* Interrupted training,  2P only	
	mixed es_time time esbaseline || idnum:  if strat==1 & TRAIN_INTER==1 & ///
	type!="1P", mle   vce(cluster idnum) covariance(identity) 
	predict rs_trains3, rstandard
	qnorm rs_trains3,   graphregion(color(white))
	
	* Interrupted training,  all studies
	mixed es_time time esbaseline || idnum:  if strat==1 & TRAIN_INTER==1 , ///
	mle   vce(cluster idnum) covariance(identity)  	
	predict rs_trains4, rstandard
	qnorm rs_trains4,   graphregion(color(white))
	
* SUPERVISION	
	*One-time supervision, all studies
	mixed es_time time esbaseline  || idnum:  if strat==2 & SUP_ONCE==1, ///
	mle   vce(cluster idnum)  	covariance(identity) 
	predict rs_sups1, rstandard
	qnorm rs_sups1,   graphregion(color(white))
	
	*Ongoing supervision, ITS and 2P
	mixed es_time time esbaseline  || idnum:  if strat==2 & SUP_ONCE==0  & ///
	type!="1P", mle   vce(cluster idnum) covariance(identity) 
	predict rs_sups2, rstandard
	qnorm rs_sups2,   graphregion(color(white))
	
	*Ongoing supervision, all studies
	mixed es_time time esbaseline  || idnum:  if strat==2 & SUP_ONCE==0  , ///
	mle   vce(cluster idnum)  	covariance(identity) 	
	predict rs_sups3, rstandard
	qnorm rs_sups3,   graphregion(color(white))
	
* TRAINING AND SUPERSIVION
	* Train+Supervision once, all studies
	mixed es_time time esbaseline  || idnum: if strat==3  & SUP_ONCE==1, ///
	mle   vce(cluster idnum) 	covariance(identity) 
	predict rs_tsups1, rstandard
	qnorm rs_tsups1,   graphregion(color(white))
	
	* Train+Supervision ongoing, 2P only
	mixed es_time time esbaseline  || idnum: if strat==3  & SUP_ONCE==0  & ///
	type!="1P", mle   vce(cluster idnum) covariance(identity) 	
	predict rs_tsups2, rstandard
	qnorm rs_tsups2,   graphregion(color(white))
	
	* Train+Supervision ongoing, all studies	
	mixed es_time time esbaseline  || idnum: if strat==3  & SUP_ONCE==0  , ///
	mle   vce(cluster idnum) covariance(identity)  	
	predict rs_tsups3, rstandard
	qnorm rs_tsups3,   graphregion(color(white))
	


