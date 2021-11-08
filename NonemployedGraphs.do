clear all
loc ding "E:\Dropbox\Research\DataCodeTex\debound04\StataProgram"
loc dan "C:\Users\03638881\Dropbox\Ding's Proposal\Disability\data"
set maxvar 20000

grstyle init
grstyle set plain

adopath + "C:\Users\03638881\Dropbox\mobility\code"
*cd `ding'
cd "`dan'"

**********
**GRAPHS**
**********
**Same as OLF.do

********
**2004**
********

use sippl04puw1,clear
loc suv "ssuseq ssuid spanel swave srefmon rhcalmn"
loc fa "efnp rfnkids tfearn tftotinc tfprpinc"
keep `suv' tage eeducate esex rmesr edisabl `fa'
keep if tage>=25 & tage<=69
keep if rhcalmn==1
drop if edisabl!=1 & edisabl!=2
g disb=edisabl*(-1)+2
drop if rmesr==-1 
g nonemp=0
replace nonemp=1 if rmesr>5
g oecd_nonlabor=(tftotinc-tfearn)/(1+(efnp-1-rfnkids)*0.7+rfnkids*0.5)
egen inccat=cut(oecd_nonlabor), at(-5000,0.1,10,200,725,22000) icodes
g id=_n
expand 2
bys id: g t=_n
g y=disb
replace y=nonemp if t==2
tmbounds y, id(id) t(t) t0(1) t1(2) p(2) plevels(0.5 0.5) erates(.05 .10 .20 .30 .40) nk(50) lsr(inccat) lsrc(1) miv(tage) nc(5) im m(.5)

preserve
loc out1 " "
loc out2 " "
loc out3 " "
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		g lb11_`k'`l'_0 = e(lb11_`k'`l') 
		g ub11_`k'`l'_0 = e(ub11_`k'`l')
		loc out1 "`out1' lb11_`k'`l'_ ub11_`k'`l'_ "
	}
}
loc mij "21 31 41 51 22 32 42 52 24 34 44 54 25 35 45 55 26 36 46 56 28 38 48 58"
loc mij "`mij' 121 131 141 151 122 132 142 152 124 134 144 154 125 135 145 155 126 136 146 156 128 138 148 158"
loc mij "`mij' 221 231 241 251 222 232 242 252 224 234 244 254 225 235 245 255 226 236 246 256 228 238 248 258"
foreach m in `mij' {
	loc out2 "`out2' lb`m'_ ub`m'_"
	loc out3 "`out3' lb`m' ub`m'"
	forval k=1/`K' {
		forval l=1/`K' {
			qui g lb`m'_`k'`l'_5 = e(lb`m'_`k'`l'_5) 
			qui g ub`m'_`k'`l'_5 = e(ub`m'_`k'`l'_5) 
			qui g lb`m'_`k'`l'_10 = e(lb`m'_`k'`l'_10) 
			qui g ub`m'_`k'`l'_10 = e(ub`m'_`k'`l'_10)  
			qui g lb`m'_`k'`l'_20 = e(lb`m'_`k'`l'_20) 
			qui g ub`m'_`k'`l'_20 = e(ub`m'_`k'`l'_20) 
			qui g lb`m'_`k'`l'_30 = e(lb`m'_`k'`l'_30) 
			qui g ub`m'_`k'`l'_30 = e(ub`m'_`k'`l'_30) 
			qui g lb`m'_`k'`l'_40 = e(lb`m'_`k'`l'_40) 
			qui g ub`m'_`k'`l'_40 = e(ub`m'_`k'`l'_40) 
			loc out1 "`out1' lb`m'_`k'`l'_ ub`m'_`k'`l'_"
		}
	}
}
loc mij "22i 32i 42i 52i 24i 34i 44i 54i 26i 36i 46i 56i 28i 38i 48i 58i"
loc mij "`mij' 122i 132i 142i 152i 124i 134i 144i 154i 126i 136i 146i 156i 128i 138i 148i 158i"
loc mij "`mij' 222i 232i 242i 252i 224i 234i 244i 254i 226i 236i 246i 256i 228i 238i 248i 258i"
foreach mm in `mij' {
	if ("`mm'" == "22i") loc m = 2299
	if ("`mm'" == "32i") loc m = 3299
	if ("`mm'" == "42i") loc m = 4299
	if ("`mm'" == "52i") loc m = 5299
	if ("`mm'" == "24i") loc m = 2499
	if ("`mm'" == "34i") loc m = 3499
	if ("`mm'" == "44i") loc m = 4499
	if ("`mm'" == "54i") loc m = 5499
	if ("`mm'" == "26i") loc m = 2699
	if ("`mm'" == "36i") loc m = 3699
	if ("`mm'" == "46i") loc m = 4699
	if ("`mm'" == "56i") loc m = 5699
	if ("`mm'" == "28i") loc m = 2899
	if ("`mm'" == "38i") loc m = 3899
	if ("`mm'" == "48i") loc m = 4899
	if ("`mm'" == "58i") loc m = 5899
	if ("`mm'" == "122i") loc m = 12299
	if ("`mm'" == "132i") loc m = 13299
	if ("`mm'" == "142i") loc m = 14299
	if ("`mm'" == "152i") loc m = 15299
	if ("`mm'" == "124i") loc m = 12499
	if ("`mm'" == "134i") loc m = 13499
	if ("`mm'" == "144i") loc m = 14499
	if ("`mm'" == "154i") loc m = 15499
	if ("`mm'" == "126i") loc m = 12699
	if ("`mm'" == "136i") loc m = 13699
	if ("`mm'" == "146i") loc m = 14699
	if ("`mm'" == "156i") loc m = 15699
	if ("`mm'" == "128i") loc m = 12899
	if ("`mm'" == "138i") loc m = 13899
	if ("`mm'" == "148i") loc m = 14899
	if ("`mm'" == "158i") loc m = 15899
	if ("`mm'" == "222i") loc m = 22299
	if ("`mm'" == "232i") loc m = 23299
	if ("`mm'" == "242i") loc m = 24299
	if ("`mm'" == "252i") loc m = 25299
	if ("`mm'" == "224i") loc m = 22499
	if ("`mm'" == "234i") loc m = 23499
	if ("`mm'" == "244i") loc m = 24499
	if ("`mm'" == "254i") loc m = 25499
	if ("`mm'" == "226i") loc m = 22699
	if ("`mm'" == "236i") loc m = 23699
	if ("`mm'" == "246i") loc m = 24699
	if ("`mm'" == "256i") loc m = 25699
	if ("`mm'" == "228i") loc m = 22899
	if ("`mm'" == "238i") loc m = 23899
	if ("`mm'" == "248i") loc m = 24899
	if ("`mm'" == "258i") loc m = 25899	
	loc out2 "`out2' lb`m'_ ub`m'_"
	loc out3 "`out3' lb`m' ub`m'"
	forval k=1/`K' {
		forval l=1/`K' {
			qui g lb`m'_`k'`l'_5 = e(lb`mm'_`k'`l'_5) 
			qui g ub`m'_`k'`l'_5 = e(ub`mm'_`k'`l'_5) 
			qui g lb`m'_`k'`l'_10 = e(lb`mm'_`k'`l'_10) 
			qui g ub`m'_`k'`l'_10 = e(ub`mm'_`k'`l'_10) 
			qui g lb`m'_`k'`l'_20 = e(lb`mm'_`k'`l'_20) 
			qui g ub`m'_`k'`l'_20 = e(ub`mm'_`k'`l'_20) 
			qui g lb`m'_`k'`l'_30 = e(lb`mm'_`k'`l'_30) 
			qui g ub`m'_`k'`l'_30 = e(ub`mm'_`k'`l'_30) 
			qui g lb`m'_`k'`l'_40 = e(lb`mm'_`k'`l'_40) 
			qui g ub`m'_`k'`l'_40 = e(ub`mm'_`k'`l'_40)  
			loc out1 "`out1' lb`m'_`k'`l'_ ub`m'_`k'`l'_"
		}
	}
}
keep lb* ub*
keep if _n==1
save tmp, replace
g i=1
reshape long "`out1'", i(i) j(me)
rensfix _
drop i
loc mij "21 31 41 51 22 32 42 52 2299 3299 4299 5299 24 34 44 54 2499 3499 4499 5499 25 35 45 55 26 36 46 56 2699 3699 4699 5699 28 38 48 58 2899 3899 4899 5899"
loc mij "`mij' 121 131 141 151 122 132 142 152 12299 13299 14299 15299 124 134 144 154 12499 13499 14499 15499 125 135 145 155 126 136 146 156 12699 13699 14699 15699" 
loc mij "`mij' 128 138 148 158 12899 13899 14899 15899"
loc mij "`mij' 221 231 241 251 222 232 242 252 22299 23299 24299 25299 224 234 244 254 22499 23499 24499 25499 225 235 245 255 226 236 246 256 22699 23699 24699 25699" 
loc mij "`mij' 228 238 248 258 22899 23899 24899 25899"
foreach m in `mij' {
	forval k=1/`K' {
		forval l=1/`K' {
			qui replace lb`m'_`k'`l' = lb11_`k'`l' if me==0 
			qui replace ub`m'_`k'`l' = ub11_`k'`l' if me==0
		}
	}
}
drop lb11* ub11*
di "`out2'"
reshape long "`out2'", i(me) j(kl)
rensfix _
reshape long lb ub, i(me kl) j(mij)
order lb ub
sort mij kl me
reshape wide lb ub, i(me kl) j(mij)
reshape wide "`out3'", i(me) j(kl)
sort me
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		lab var lb21`k'`l' "No Assumption"
		lab var lb2299`k'`l' "Independence + Level Set"
		lab var lb2499`k'`l' "Independence + Level Set + Monotonicity"
		lab var lb12299`k'`l' "Orthogonality + Indep + Level Set"
		lab var lb12499`k'`l' "Orthogonality + Indep + Level Set + Monotonicity"
	}
}		
format * %3.2f
format me %2.0f
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		loc kk=`k'-1
		loc ll=`l'-1
		tw (connected lb21`k'`l' ub21`k'`l' me, clpattern(solid solid) lcolor(red red) ms(i i) mlabp(6 6 6 6) mlabel(lb21`k'`l' ub21`k'`l') mlabs(tiny tiny tiny tiny) mlabc(red red)) ///
			(connected lb2299`k'`l' ub2299`k'`l' me, clpattern(dash dash) lcolor(blue blue) ms(i i) mlabp(6 6 6 6) mlabel(lb2299`k'`l' ub2299`k'`l') mlabs(tiny tiny tiny tiny) mlabc(blue blue)) ///
			(connected lb12299`k'`l' ub12299`k'`l' me, clpattern(shortdash_dot shortdash_dot) lcolor(ltblue ltblue) ms(i i) mlabp(6 6 6 6) mlabel(lb12299`k'`l' ub12299`k'`l') mlabs(tiny tiny tiny tiny) mlabc(ltblue ltblue)) ///
			(connected lb2499`k'`l' ub2499`k'`l' me, clpattern(longdash_dot longdash_dot) lcolor(dkgreen dkgreen) ms(i i) mlabp(6 6 6 6) mlabel(lb2499`k'`l' ub2499`k'`l') mlabs(tiny tiny tiny tiny) mlabc(dkgreen dkgreen)) ///
			(connected lb12499`k'`l' ub12499`k'`l' me, clpattern(shortdash shortdash) lcolor(midgreen midgreen) ms(i i) mlabp(6 6 6 6) mlabel(lb12499`k'`l' ub12499`k'`l') mlabs(tiny tiny tiny tiny) mlabc(midgreen midgreen)), ///
			title("Bounds Under Misclassification:", si(*.8)) subtitle("With and Without Additional Assumptions", si(*.6)) xtitle("Maximum Allowed Degree of Misclassification", si(*.6)) ///
			ytitle("P*(`kk'`ll')") yline(0 1, lc(gs0 gs0)) saving(nonemp_04_`k'`l', replace) xlab(0 5 10 20 30 40, labs(*.75)) leg(size(vsmall) order(1 3 5 7 9) r(5) rowg(*.1)) ylab(0(.2)1, labs(*.75)) /// 
			graphregion(fcolor(white)) plotregion(fcolor(white)) graphregion(ifcolor(white)) plotregion(ifcolor(white)) graphregion(ilcolor(white)) plotregion(ilcolor(white)) plotregion(margin(b+2))	
	
	}
}
restore 


********
**2008**
********

use sippl08puw4,clear
keep ssuseq ssuid spanel swave srefmon rhcalmn tage eeducate esex rmesr edisabl efnp rfnkids tfearn tftotinc tfprpinc
keep if tage>=25 & tage<=69
keep if rhcalmn==8
drop if edisabl!=1 & edisabl!=2
g disb=edisabl*(-1)+2
drop if rmesr==-1 
g nonemp=0
replace nonemp=1 if rmesr>5
g oecd_nonlabor=(tftotinc-tfearn)/(1+(efnp-1-rfnkids)*0.7+rfnkids*0.5)
egen inccat=cut(oecd_nonlabor), at(-5000,0.1,10,200,725,30000) icodes
g id=_n
expand 2
bys id: g t=_n
g y=disb
replace y=nonemp if t==2
tmbounds y, id(id) t(t) t0(1) t1(2) p(2) plevels(0.5 0.5) erates(.05 .10 .20 .30 .40) nk(50) lsr(inccat) lsrc(1) miv(tage) nc(5) im m(.5)

preserve
loc out1 " "
loc out2 " "
loc out3 " "
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		g lb11_`k'`l'_0 = e(lb11_`k'`l') 
		g ub11_`k'`l'_0 = e(ub11_`k'`l')
		loc out1 "`out1' lb11_`k'`l'_ ub11_`k'`l'_ "
	}
}
loc mij "21 31 41 51 22 32 42 52 24 34 44 54 25 35 45 55 26 36 46 56 28 38 48 58"
loc mij "`mij' 121 131 141 151 122 132 142 152 124 134 144 154 125 135 145 155 126 136 146 156 128 138 148 158"
loc mij "`mij' 221 231 241 251 222 232 242 252 224 234 244 254 225 235 245 255 226 236 246 256 228 238 248 258"
foreach m in `mij' {
	loc out2 "`out2' lb`m'_ ub`m'_"
	loc out3 "`out3' lb`m' ub`m'"
	forval k=1/`K' {
		forval l=1/`K' {
			qui g lb`m'_`k'`l'_5 = e(lb`m'_`k'`l'_5) 
			qui g ub`m'_`k'`l'_5 = e(ub`m'_`k'`l'_5) 
			qui g lb`m'_`k'`l'_10 = e(lb`m'_`k'`l'_10) 
			qui g ub`m'_`k'`l'_10 = e(ub`m'_`k'`l'_10)  
			qui g lb`m'_`k'`l'_20 = e(lb`m'_`k'`l'_20) 
			qui g ub`m'_`k'`l'_20 = e(ub`m'_`k'`l'_20) 
			qui g lb`m'_`k'`l'_30 = e(lb`m'_`k'`l'_30) 
			qui g ub`m'_`k'`l'_30 = e(ub`m'_`k'`l'_30) 
			qui g lb`m'_`k'`l'_40 = e(lb`m'_`k'`l'_40) 
			qui g ub`m'_`k'`l'_40 = e(ub`m'_`k'`l'_40) 
			loc out1 "`out1' lb`m'_`k'`l'_ ub`m'_`k'`l'_"
		}
	}
}
loc mij "22i 32i 42i 52i 24i 34i 44i 54i 26i 36i 46i 56i 28i 38i 48i 58i"
loc mij "`mij' 122i 132i 142i 152i 124i 134i 144i 154i 126i 136i 146i 156i 128i 138i 148i 158i"
loc mij "`mij' 222i 232i 242i 252i 224i 234i 244i 254i 226i 236i 246i 256i 228i 238i 248i 258i"
foreach mm in `mij' {
	if ("`mm'" == "22i") loc m = 2299
	if ("`mm'" == "32i") loc m = 3299
	if ("`mm'" == "42i") loc m = 4299
	if ("`mm'" == "52i") loc m = 5299
	if ("`mm'" == "24i") loc m = 2499
	if ("`mm'" == "34i") loc m = 3499
	if ("`mm'" == "44i") loc m = 4499
	if ("`mm'" == "54i") loc m = 5499
	if ("`mm'" == "26i") loc m = 2699
	if ("`mm'" == "36i") loc m = 3699
	if ("`mm'" == "46i") loc m = 4699
	if ("`mm'" == "56i") loc m = 5699
	if ("`mm'" == "28i") loc m = 2899
	if ("`mm'" == "38i") loc m = 3899
	if ("`mm'" == "48i") loc m = 4899
	if ("`mm'" == "58i") loc m = 5899
	if ("`mm'" == "122i") loc m = 12299
	if ("`mm'" == "132i") loc m = 13299
	if ("`mm'" == "142i") loc m = 14299
	if ("`mm'" == "152i") loc m = 15299
	if ("`mm'" == "124i") loc m = 12499
	if ("`mm'" == "134i") loc m = 13499
	if ("`mm'" == "144i") loc m = 14499
	if ("`mm'" == "154i") loc m = 15499
	if ("`mm'" == "126i") loc m = 12699
	if ("`mm'" == "136i") loc m = 13699
	if ("`mm'" == "146i") loc m = 14699
	if ("`mm'" == "156i") loc m = 15699
	if ("`mm'" == "128i") loc m = 12899
	if ("`mm'" == "138i") loc m = 13899
	if ("`mm'" == "148i") loc m = 14899
	if ("`mm'" == "158i") loc m = 15899
	if ("`mm'" == "222i") loc m = 22299
	if ("`mm'" == "232i") loc m = 23299
	if ("`mm'" == "242i") loc m = 24299
	if ("`mm'" == "252i") loc m = 25299
	if ("`mm'" == "224i") loc m = 22499
	if ("`mm'" == "234i") loc m = 23499
	if ("`mm'" == "244i") loc m = 24499
	if ("`mm'" == "254i") loc m = 25499
	if ("`mm'" == "226i") loc m = 22699
	if ("`mm'" == "236i") loc m = 23699
	if ("`mm'" == "246i") loc m = 24699
	if ("`mm'" == "256i") loc m = 25699
	if ("`mm'" == "228i") loc m = 22899
	if ("`mm'" == "238i") loc m = 23899
	if ("`mm'" == "248i") loc m = 24899
	if ("`mm'" == "258i") loc m = 25899	
	loc out2 "`out2' lb`m'_ ub`m'_"
	loc out3 "`out3' lb`m' ub`m'"
	forval k=1/`K' {
		forval l=1/`K' {
			qui g lb`m'_`k'`l'_5 = e(lb`mm'_`k'`l'_5) 
			qui g ub`m'_`k'`l'_5 = e(ub`mm'_`k'`l'_5) 
			qui g lb`m'_`k'`l'_10 = e(lb`mm'_`k'`l'_10) 
			qui g ub`m'_`k'`l'_10 = e(ub`mm'_`k'`l'_10) 
			qui g lb`m'_`k'`l'_20 = e(lb`mm'_`k'`l'_20) 
			qui g ub`m'_`k'`l'_20 = e(ub`mm'_`k'`l'_20) 
			qui g lb`m'_`k'`l'_30 = e(lb`mm'_`k'`l'_30) 
			qui g ub`m'_`k'`l'_30 = e(ub`mm'_`k'`l'_30) 
			qui g lb`m'_`k'`l'_40 = e(lb`mm'_`k'`l'_40) 
			qui g ub`m'_`k'`l'_40 = e(ub`mm'_`k'`l'_40)  
			loc out1 "`out1' lb`m'_`k'`l'_ ub`m'_`k'`l'_"
		}
	}
}
keep lb* ub*
keep if _n==1
save tmp, replace
g i=1
reshape long "`out1'", i(i) j(me)
rensfix _
drop i
loc mij "21 31 41 51 22 32 42 52 2299 3299 4299 5299 24 34 44 54 2499 3499 4499 5499 25 35 45 55 26 36 46 56 2699 3699 4699 5699 28 38 48 58 2899 3899 4899 5899"
loc mij "`mij' 121 131 141 151 122 132 142 152 12299 13299 14299 15299 124 134 144 154 12499 13499 14499 15499 125 135 145 155 126 136 146 156 12699 13699 14699 15699" 
loc mij "`mij' 128 138 148 158 12899 13899 14899 15899"
loc mij "`mij' 221 231 241 251 222 232 242 252 22299 23299 24299 25299 224 234 244 254 22499 23499 24499 25499 225 235 245 255 226 236 246 256 22699 23699 24699 25699" 
loc mij "`mij' 228 238 248 258 22899 23899 24899 25899"
foreach m in `mij' {
	forval k=1/`K' {
		forval l=1/`K' {
			qui replace lb`m'_`k'`l' = lb11_`k'`l' if me==0 
			qui replace ub`m'_`k'`l' = ub11_`k'`l' if me==0
		}
	}
}
drop lb11* ub11*
di "`out2'"
reshape long "`out2'", i(me) j(kl)
rensfix _
reshape long lb ub, i(me kl) j(mij)
order lb ub
sort mij kl me
reshape wide lb ub, i(me kl) j(mij)
reshape wide "`out3'", i(me) j(kl)
sort me
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		lab var lb21`k'`l' "No Assumption"
		lab var lb2299`k'`l' "Independence + Level Set"
		lab var lb2499`k'`l' "Independence + Level Set + Monotonicity"
		lab var lb12299`k'`l' "Orthogonality + Indep + Level Set"
		lab var lb12499`k'`l' "Orthogonality + Indep + Level Set + Monotonicity"
	}
}		
format * %3.2f
format me %2.0f
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		loc kk=`k'-1
		loc ll=`l'-1
		tw (connected lb21`k'`l' ub21`k'`l' me, clpattern(solid solid) lcolor(red red) ms(i i) mlabp(6 6 6 6) mlabel(lb21`k'`l' ub21`k'`l') mlabs(tiny tiny tiny tiny) mlabc(red red)) ///
			(connected lb2299`k'`l' ub2299`k'`l' me, clpattern(dash dash) lcolor(blue blue) ms(i i) mlabp(6 6 6 6) mlabel(lb2299`k'`l' ub2299`k'`l') mlabs(tiny tiny tiny tiny) mlabc(blue blue)) ///
			(connected lb12299`k'`l' ub12299`k'`l' me, clpattern(shortdash_dot shortdash_dot) lcolor(ltblue ltblue) ms(i i) mlabp(6 6 6 6) mlabel(lb12299`k'`l' ub12299`k'`l') mlabs(tiny tiny tiny tiny) mlabc(ltblue ltblue)) ///
			(connected lb2499`k'`l' ub2499`k'`l' me, clpattern(longdash_dot longdash_dot) lcolor(dkgreen dkgreen) ms(i i) mlabp(6 6 6 6) mlabel(lb2499`k'`l' ub2499`k'`l') mlabs(tiny tiny tiny tiny) mlabc(dkgreen dkgreen)) ///
			(connected lb12499`k'`l' ub12499`k'`l' me, clpattern(shortdash shortdash) lcolor(midgreen midgreen) ms(i i) mlabp(6 6 6 6) mlabel(lb12499`k'`l' ub12499`k'`l') mlabs(tiny tiny tiny tiny) mlabc(midgreen midgreen)), ///
			title("Bounds Under Misclassification:", si(*.8)) subtitle("With and Without Additional Assumptions", si(*.6)) xtitle("Maximum Allowed Degree of Misclassification", si(*.6)) ///
			ytitle("P*(`kk'`ll')") yline(0 1, lc(gs0 gs0)) saving(nonemp_08_`k'`l', replace) xlab(0 5 10 20 30 40, labs(*.75)) leg(size(vsmall) order(1 3 5 7 9) r(5) rowg(*.1)) ylab(0(.2)1, labs(*.75)) /// 
			graphregion(fcolor(white)) plotregion(fcolor(white)) graphregion(ifcolor(white)) plotregion(ifcolor(white)) graphregion(ilcolor(white)) plotregion(ilcolor(white)) plotregion(margin(b+2))	
	
	}
}
restore 


********
**2014**
********

use pu2014w1,clear
keep ssuid spanel swave monthcode tage esex rmesr edisabl rfpersons RFRELU18 tftotinc tpearn
keep if tage>=25 & tage<=69
keep if monthcode==10
drop if edisabl!=1 & edisabl!=2
g disb=edisabl*(-1)+2
drop if rmesr==-1 
g nonemp=0
replace nonemp=1 if rmesr>5
bys ssuid: egen tfearn=total(tpearn)
replace RFRELU18=0 if RFRELU18==.
g oecd_nonlabor=(tftotinc-tfearn)/(1+(rfpersons-1-RFRELU18)*0.7+RFRELU18*0.5)
egen inccat=cut(oecd_nonlabor), at(-60000,0.1,10,200,725,42000) icodes
g id=_n
expand 2
bys id: g t=_n
g y=disb
replace y=nonemp if t==2
tmbounds y, id(id) t(t) t0(1) t1(2) p(2) plevels(0.5 0.5) erates(.05 .10 .20 .30 .40) nk(50) lsr(inccat) lsrc(1) miv(tage) nc(5) im m(.5)

preserve
loc out1 " "
loc out2 " "
loc out3 " "
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		g lb11_`k'`l'_0 = e(lb11_`k'`l') 
		g ub11_`k'`l'_0 = e(ub11_`k'`l')
		loc out1 "`out1' lb11_`k'`l'_ ub11_`k'`l'_ "
	}
}
loc mij "21 31 41 51 22 32 42 52 24 34 44 54 25 35 45 55 26 36 46 56 28 38 48 58"
loc mij "`mij' 121 131 141 151 122 132 142 152 124 134 144 154 125 135 145 155 126 136 146 156 128 138 148 158"
loc mij "`mij' 221 231 241 251 222 232 242 252 224 234 244 254 225 235 245 255 226 236 246 256 228 238 248 258"
foreach m in `mij' {
	loc out2 "`out2' lb`m'_ ub`m'_"
	loc out3 "`out3' lb`m' ub`m'"
	forval k=1/`K' {
		forval l=1/`K' {
			qui g lb`m'_`k'`l'_5 = e(lb`m'_`k'`l'_5) 
			qui g ub`m'_`k'`l'_5 = e(ub`m'_`k'`l'_5) 
			qui g lb`m'_`k'`l'_10 = e(lb`m'_`k'`l'_10) 
			qui g ub`m'_`k'`l'_10 = e(ub`m'_`k'`l'_10)  
			qui g lb`m'_`k'`l'_20 = e(lb`m'_`k'`l'_20) 
			qui g ub`m'_`k'`l'_20 = e(ub`m'_`k'`l'_20) 
			qui g lb`m'_`k'`l'_30 = e(lb`m'_`k'`l'_30) 
			qui g ub`m'_`k'`l'_30 = e(ub`m'_`k'`l'_30) 
			qui g lb`m'_`k'`l'_40 = e(lb`m'_`k'`l'_40) 
			qui g ub`m'_`k'`l'_40 = e(ub`m'_`k'`l'_40) 
			loc out1 "`out1' lb`m'_`k'`l'_ ub`m'_`k'`l'_"
		}
	}
}
loc mij "22i 32i 42i 52i 24i 34i 44i 54i 26i 36i 46i 56i 28i 38i 48i 58i"
loc mij "`mij' 122i 132i 142i 152i 124i 134i 144i 154i 126i 136i 146i 156i 128i 138i 148i 158i"
loc mij "`mij' 222i 232i 242i 252i 224i 234i 244i 254i 226i 236i 246i 256i 228i 238i 248i 258i"
foreach mm in `mij' {
	if ("`mm'" == "22i") loc m = 2299
	if ("`mm'" == "32i") loc m = 3299
	if ("`mm'" == "42i") loc m = 4299
	if ("`mm'" == "52i") loc m = 5299
	if ("`mm'" == "24i") loc m = 2499
	if ("`mm'" == "34i") loc m = 3499
	if ("`mm'" == "44i") loc m = 4499
	if ("`mm'" == "54i") loc m = 5499
	if ("`mm'" == "26i") loc m = 2699
	if ("`mm'" == "36i") loc m = 3699
	if ("`mm'" == "46i") loc m = 4699
	if ("`mm'" == "56i") loc m = 5699
	if ("`mm'" == "28i") loc m = 2899
	if ("`mm'" == "38i") loc m = 3899
	if ("`mm'" == "48i") loc m = 4899
	if ("`mm'" == "58i") loc m = 5899
	if ("`mm'" == "122i") loc m = 12299
	if ("`mm'" == "132i") loc m = 13299
	if ("`mm'" == "142i") loc m = 14299
	if ("`mm'" == "152i") loc m = 15299
	if ("`mm'" == "124i") loc m = 12499
	if ("`mm'" == "134i") loc m = 13499
	if ("`mm'" == "144i") loc m = 14499
	if ("`mm'" == "154i") loc m = 15499
	if ("`mm'" == "126i") loc m = 12699
	if ("`mm'" == "136i") loc m = 13699
	if ("`mm'" == "146i") loc m = 14699
	if ("`mm'" == "156i") loc m = 15699
	if ("`mm'" == "128i") loc m = 12899
	if ("`mm'" == "138i") loc m = 13899
	if ("`mm'" == "148i") loc m = 14899
	if ("`mm'" == "158i") loc m = 15899
	if ("`mm'" == "222i") loc m = 22299
	if ("`mm'" == "232i") loc m = 23299
	if ("`mm'" == "242i") loc m = 24299
	if ("`mm'" == "252i") loc m = 25299
	if ("`mm'" == "224i") loc m = 22499
	if ("`mm'" == "234i") loc m = 23499
	if ("`mm'" == "244i") loc m = 24499
	if ("`mm'" == "254i") loc m = 25499
	if ("`mm'" == "226i") loc m = 22699
	if ("`mm'" == "236i") loc m = 23699
	if ("`mm'" == "246i") loc m = 24699
	if ("`mm'" == "256i") loc m = 25699
	if ("`mm'" == "228i") loc m = 22899
	if ("`mm'" == "238i") loc m = 23899
	if ("`mm'" == "248i") loc m = 24899
	if ("`mm'" == "258i") loc m = 25899	
	loc out2 "`out2' lb`m'_ ub`m'_"
	loc out3 "`out3' lb`m' ub`m'"
	forval k=1/`K' {
		forval l=1/`K' {
			qui g lb`m'_`k'`l'_5 = e(lb`mm'_`k'`l'_5) 
			qui g ub`m'_`k'`l'_5 = e(ub`mm'_`k'`l'_5) 
			qui g lb`m'_`k'`l'_10 = e(lb`mm'_`k'`l'_10) 
			qui g ub`m'_`k'`l'_10 = e(ub`mm'_`k'`l'_10) 
			qui g lb`m'_`k'`l'_20 = e(lb`mm'_`k'`l'_20) 
			qui g ub`m'_`k'`l'_20 = e(ub`mm'_`k'`l'_20) 
			qui g lb`m'_`k'`l'_30 = e(lb`mm'_`k'`l'_30) 
			qui g ub`m'_`k'`l'_30 = e(ub`mm'_`k'`l'_30) 
			qui g lb`m'_`k'`l'_40 = e(lb`mm'_`k'`l'_40) 
			qui g ub`m'_`k'`l'_40 = e(ub`mm'_`k'`l'_40)  
			loc out1 "`out1' lb`m'_`k'`l'_ ub`m'_`k'`l'_"
		}
	}
}
keep lb* ub*
keep if _n==1
save tmp, replace
g i=1
reshape long "`out1'", i(i) j(me)
rensfix _
drop i
loc mij "21 31 41 51 22 32 42 52 2299 3299 4299 5299 24 34 44 54 2499 3499 4499 5499 25 35 45 55 26 36 46 56 2699 3699 4699 5699 28 38 48 58 2899 3899 4899 5899"
loc mij "`mij' 121 131 141 151 122 132 142 152 12299 13299 14299 15299 124 134 144 154 12499 13499 14499 15499 125 135 145 155 126 136 146 156 12699 13699 14699 15699" 
loc mij "`mij' 128 138 148 158 12899 13899 14899 15899"
loc mij "`mij' 221 231 241 251 222 232 242 252 22299 23299 24299 25299 224 234 244 254 22499 23499 24499 25499 225 235 245 255 226 236 246 256 22699 23699 24699 25699" 
loc mij "`mij' 228 238 248 258 22899 23899 24899 25899"
foreach m in `mij' {
	forval k=1/`K' {
		forval l=1/`K' {
			qui replace lb`m'_`k'`l' = lb11_`k'`l' if me==0 
			qui replace ub`m'_`k'`l' = ub11_`k'`l' if me==0
		}
	}
}
drop lb11* ub11*
di "`out2'"
reshape long "`out2'", i(me) j(kl)
rensfix _
reshape long lb ub, i(me kl) j(mij)
order lb ub
sort mij kl me
reshape wide lb ub, i(me kl) j(mij)
reshape wide "`out3'", i(me) j(kl)
sort me
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		lab var lb21`k'`l' "No Assumption"
		lab var lb2299`k'`l' "Independence + Level Set"
		lab var lb2499`k'`l' "Independence + Level Set + Monotonicity"
		lab var lb12299`k'`l' "Orthogonality + Indep + Level Set"
		lab var lb12499`k'`l' "Orthogonality + Indep + Level Set + Monotonicity"
	}
}		
format * %3.2f
format me %2.0f
loc K=2
forval k=1/`K' {
	forval l=1/`K' {
		loc kk=`k'-1
		loc ll=`l'-1
		tw (connected lb21`k'`l' ub21`k'`l' me, clpattern(solid solid) lcolor(red red) ms(i i) mlabp(6 6 6 6) mlabel(lb21`k'`l' ub21`k'`l') mlabs(tiny tiny tiny tiny) mlabc(red red)) ///
			(connected lb2299`k'`l' ub2299`k'`l' me, clpattern(dash dash) lcolor(blue blue) ms(i i) mlabp(6 6 6 6) mlabel(lb2299`k'`l' ub2299`k'`l') mlabs(tiny tiny tiny tiny) mlabc(blue blue)) ///
			(connected lb12299`k'`l' ub12299`k'`l' me, clpattern(shortdash_dot shortdash_dot) lcolor(ltblue ltblue) ms(i i) mlabp(6 6 6 6) mlabel(lb12299`k'`l' ub12299`k'`l') mlabs(tiny tiny tiny tiny) mlabc(ltblue ltblue)) ///
			(connected lb2499`k'`l' ub2499`k'`l' me, clpattern(longdash_dot longdash_dot) lcolor(dkgreen dkgreen) ms(i i) mlabp(6 6 6 6) mlabel(lb2499`k'`l' ub2499`k'`l') mlabs(tiny tiny tiny tiny) mlabc(dkgreen dkgreen)) ///
			(connected lb12499`k'`l' ub12499`k'`l' me, clpattern(shortdash shortdash) lcolor(midgreen midgreen) ms(i i) mlabp(6 6 6 6) mlabel(lb12499`k'`l' ub12499`k'`l') mlabs(tiny tiny tiny tiny) mlabc(midgreen midgreen)), ///
			title("Bounds Under Misclassification:", si(*.8)) subtitle("With and Without Additional Assumptions", si(*.6)) xtitle("Maximum Allowed Degree of Misclassification", si(*.6)) ///
			ytitle("P*(`kk'`ll')") yline(0 1, lc(gs0 gs0)) saving(nonemp_14_`k'`l', replace) xlab(0 5 10 20 30 40, labs(*.75)) leg(size(vsmall) order(1 3 5 7 9) r(5) rowg(*.1)) ylab(0(.2)1, labs(*.75)) /// 
			graphregion(fcolor(white)) plotregion(fcolor(white)) graphregion(ifcolor(white)) plotregion(ifcolor(white)) graphregion(ilcolor(white)) plotregion(ilcolor(white)) plotregion(margin(b+2))	
	
	}
}
restore 

/*
Estimators:
21	AE
31	UE
41	AE+uni
51	UE+uni
22	AE-LSR
32	UE-LSR
42	AE-LSR-uni
52	UE-LSR-uni
24	AE-MIV-LSR
34	UE-MIV-LSR
44	AE-MIV-LSR-uni
54	UE-MIV-LSR-uni
25	AE-SHAPE
35	UE-SHAPE
45	AE-SHAPE-uni
55	UE-SHAPE-uni
26	AE-SHAPE-LSR
36	UE-SHAPE-LSR
46	AE-SHAPE-LSR-uni
56	UE-SHAPE-LSR-uni
28	AE-SHAPE-MIV-LSR
38	UE-SHAPE-MIV-LSR
48	AE-SHAPE-MIV-LSR-uni
58	UE-SHAPE-MIV-LSR-uni

New estimators not in JBES:

Add "1" in front for adding assumption of "Temporal Independence"
122	AE-LSR-TI
132	UE-LSR-TI
142	AE-LSR-TI-uni
152	UE-LSR-TI-uni
124	AE-MIV-LSR-TI
134	UE-MIV-LSR-TI
144	AE-MIV-LSR-TI-uni
154	UE-MIV-LSR-TI-uni
125	AE-SHAPE-TI
135	UE-SHAPE-TI
145	AE-SHAPE-TI-uni
155	UE-SHAPE-TI-uni
126	AE-SHAPE-LSR-TI
136	UE-SHAPE-LSR-TI
146	AE-SHAPE-LSR-TI-uni
156	UE-SHAPE-LSR-TI-uni
128	AE-SHAPE-MIV-LSR-TI
138	UE-SHAPE-MIV-LSR-TI
148	AE-SHAPE-MIV-LSR-TI-uni
158	UE-SHAPE-MIV-LSR-TI-uni

Add "2" in front for adding assumption of "Temporal Invariance"
222	AE-LSR-TIV
232	UE-LSR-TIV
242	AE-LSR-TIV-uni
252	UE-LSR-TIV-uni
224	AE-MIV-LSR-TIV
234	UE-MIV-LSR-TIV
244	AE-MIV-LSR-TIV-uni
254	UE-MIV-LSR-TIV-uni
225	AE-SHAPE-TIV
235	UE-SHAPE-TIV
245	AE-SHAPE-TIV-uni
255	UE-SHAPE-TIV-uni
226	AE-SHAPE-LSR-TIV
236	UE-SHAPE-LSR-TIV
246	AE-SHAPE-LSR-TIV-uni
256	UE-SHAPE-LSR-TIV-uni
228	AE-SHAPE-MIV-LSR-TIV
238	UE-SHAPE-MIV-LSR-TIV
248	AE-SHAPE-MIV-LSR-TIV-uni
258	UE-SHAPE-MIV-LSR-TIV-uni

*/

