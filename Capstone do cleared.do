***Capstone do file cleared***
**2022.11.28**
cd "E:\NYU Master\Semester 3\EDPLY-GE 2050 Capstone"
use "E:\NYU Master\Semester 3\EDPLY-GE 2050 Capstone\Original Dataset V2.dta" 

drop F2NSSTAT
drop F3ALLINC2011 F3DEBTEMP2011 F3DEBTALL2011 
drop F3TZSTEM1ATT
drop F3TZSTEM1ERN //suppressed

codebook BYSEX //179 skip, 648 nonrespondent
gen bysex_new = BYSEX
replace bysex_new = -1 if BYSEX <= 0 //827 changes made

codebook BYRACE //126 skip
gen byrace_new = BYRACE
replace byrace_new = -1 if BYRACE<= 0
replace byrace_new=1 if BYRACE==7
replace byrace_new=2 if BYRACE==2
replace byrace_new=3 if BYRACE==3
replace byrace_new=4 if BYRACE==4 | BYRACE==5
replace byrace_new=5 if BYRACE==6 | BYRACE==1
label define race -1 "Missing or skip" 1 "White, non-Hispanic" 2 "Asian, Hawaii/Pac. Islander, non-Hispanic" 3 "Black or African American, non-Hispanic" 4 "Hispanic" 5 "Others"
label value byrace_new race
tab byrace_new

codebook BYSTLANG //126 norespondent
gen bystlang_new = BYSTLANG
replace bystlang_new = -1 if BYSTLANG< 0
label variable bystlang_new "Whether English is student's native language-composite"
label value bystlang_new F10027_

codebook BYHOMLNG //385 missing, 126 skip
gen byhomlng_new = BYHOMLNG
replace byhomlng_new = -1 if BYHOMLNG<=0
label variable byhomlng_new "Student's native language-composite"
replace byhomlng_new=2 if BYHOMLNG==3| BYHOMLNG==4| BYHOMLNG==5| BYHOMLNG==6
label define stu_lang -1 "Missing" 1 "English" 2 "Others"
label value byhomlng_new stu_lang

codebook BYSTLNG2
replace BYSTLNG2=0 if BYSTLNG2==3|BYSTLNG2==0
replace BYSTLNG2=1 if BYSTLNG2==2|BYSTLNG2==4
label define stu_ENG 0 "not fluent" 1 "fluent"
label value BYSTLNG2 stu_ENG
tab BYSTLNG2

codebook BYPARACE //1953 missing 
gen byparace_new = BYPARACE
replace byparace_new = -1 if BYPARACE<=0
label variable byparace_new "Parent's race/ethnicity-composite"
replace byparace_new = 1 if BYPARACE == 7
replace byparace_new = 2 if BYPARACE == 2
replace byparace_new = 3 if BYPARACE == 3
replace byparace_new = 4 if BYPARACE == 4 | BYPARACE == 5
replace byparace_new = 5 if BYPARACE == 6 | BYPARACE == 1
label value byrace_new race

codebook BYPLANG
gen byplang_new = BYPLANG
replace byplang_new = -1 if BYPLANG<0
label variable byplang_new "Parent's English fluency"
replace byplang_new = -1 if BYPLANG == 3
replace byplang_new = 0 if BYPLANG == 0
replace byplang_new = 1 if BYPLANG == 1|BYPLANG == 2|BYPLANG == 4
label define language_fluency -1 "Missing or unknown" 0 "Not fluent" 1 "Fluent"
label value byplang_new language_fluency

codebook BYPARLNG //2193 missing
gen byparlng_new = BYPARLNG
replace byparlng_new = -1 if BYPARLNG<0
label variable byparlng_new "Parent's native language-composite"
label value byparlng_new F10028_
replace byparlng_new = 1 if BYPARLNG == 1
replace byparlng_new = 2 if BYPARLNG != 1 & BYPARLNG > 0
label value byparlng_new stu_lang

codebook BYPARED
gen bypared_new = BYPARED
label variable bypared_new "Parents' highest level of education"
replace bypared_new = -1 if BYPARED<=0
codebook bypared_new
replace bypared_new=1 if BYPARED==1 | BYPARED==2 
replace bypared_new=2 if BYPARED==3 | BYPARED==4 
replace bypared_new=3 if BYPARED==5 | BYPARED==6
replace bypared_new=4 if BYPARED==7 | BYPARED==8
label define parent_edulevel -1 "missing or skip" 1 "high school or below" 2 "attended 2-year college" 3 "attended 4-year college" 4 "Master's degree or higher" 
label value bypared_new parent_edulevel
tab bypared_new

codebook BY10FLP //1020 missing
gen by10flp_new = BY10FLP
replace by10flp_new = -1 if BY10FLP <= 0
label variable by10flp_new "Grade 10 percent free lunch-categorical"
replace by10flp_new = 1 if BY10FLP == 1 | BY10FLP == 7 | BY10FLP == 7 | BY10FLP == 7 | BY10FLP == 7
replace by10flp_new = 2 if BY10FLP == 6 | BY10FLP == 7
label define freelunch -1 "missing or skip" 1 "Lower than 50 percent" 2 "Higher than 50 percent"

codebook F2PS1GRT //126 missing *further dispose*
gen f2ps1grt_new = F2PS1GRT
replace f2ps1grt_new = -1 if F2PS1GRT < 0
label variable f2ps1grt_new "Offered scholarship/grant for first year at first postsec institution"
codebook F2PS1GRT
replace f2ps1grt_new = 1 if F2PS1GRT == 0
replace f2ps1grt_new = 2 if F2PS1GRT == 1
label define scholar -1 "Missing or Skipped" 1 "NO" 2 "YES" 
label value f2ps1grt_new scholar
tab f2ps1grt_new

codebook F3ATTAINMENT if F3ATTAINMENT <=0 //216 skip, 1126 nonrespondent
gen f3attainment_new = F3ATTAINMENT
replace f3attainment_new = -1 if F3ATTAINMENT<=0
label variable f3attainment_new "Highest level of education earned as of F3"
replace f3attainment_new=1 if F3ATTAINMENT==1 | F3ATTAINMENT==2
replace f3attainment_new=2 if F3ATTAINMENT==3 | F3ATTAINMENT==4
replace f3attainment_new=3 if F3ATTAINMENT==5
replace f3attainment_new=4 if F3ATTAINMENT==6 | F3ATTAINMENT==7
replace f3attainment_new=5 if F3ATTAINMENT==8 | F3ATTAINMENT==10
label define highest_educF3 -1 "Missing or skip" 1 "HS attendance" 2 "PS attendance" 3 "Associate Degree" 4 "Bachelor's Degree" 5 "Master's degree or higher"
label value f3attainment_new highest_educF3
tab f3attainment_new


sum F3ERN2011 if F3ERN2011 <= 0 //980 recorded zero. This variable is based on F3D20, F3D20 == 0 means do not have a job from 2006 to 2012 (F3B09=0)
tabstat F3ERN2011, stat(n mean range min max iqr sd skewness)


codebook F3TZGPALAST //709 missing, 1001 skip/NA, 434 nonrespondent, 434 nonrespondent

codebook F3A24A
gen f3a24a_new = F3A24A
replace f3a24a_new = -1 if F3A24A <=0
label variable f3a24a_new "Proportion of tuition/fees paid by grants/scholarships (1st term at 1st attended)"
replace f3a24a_new = 1 if F3A24A == 3
replace f3a24a_new = 2 if F3A24A == 2
replace f3a24a_new = 3 if F3A24A == 1
label define scholarship -1 "Missing or Skip" 1 "Less than half" 2 "Higher than 50%, Lower than 100%" 3 "100%"
label value f3a24a_new scholarship

codebook F3A24B
gen f3a24b_new = F3A24B
replace f3a24b_new = -1 if F3A24B <=0
label variable f3a24b_new "Proportion of other college expenses paid by grants/scholarships (1st term at 1st attended)"
replace f3a24b_new = 1 if F3A24B == 3
replace f3a24b_new = 2 if F3A24B == 2
replace f3a24b_new = 3 if F3A24B == 1
label value f3a24b_new scholarship

codebook BYINCOME
replace BYINCOME=1 if  BYINCOME==2| BYINCOME==3| BYINCOME==4| BYINCOME==5| BYINCOME==6| BYINCOME==7
replace BYINCOME=2 if  BYINCOME==8| BYINCOME==9| BYINCOME==10
replace BYINCOME=3 if  BYINCOME==11| BYINCOME==12| BYINCOME==13
label define family_income 1 "less than $25k" 2 "$25k-$75k" 3 "more than $75k"
label value BYINCOME family_income
tab BYINCOME

codebook F2PSEEXM
replace F2PSEEXM=1 if F2PSEEXM==1|F2PSEEXM==2|F2PSEEXM==3|F2PSEEXM==4
label define SAT 0 "No available evidence of entrance exam" 1 "took SAT/ACT"
label value F2PSEEXM SAT
tab F2PSEEXM

gen f3gparecode = -1
replace f3gparecode = 1 if F3TZGPALAST >= 0 & F3TZGPALAST < 3
replace f3gparecode = 2 if F3TZGPALAST >= 3 & F3TZGPALAST <= 3.5
replace f3gparecode = 3 if F3TZGPALAST > 3.5
label variable f3gparecode "Recoded GPA at last known institution attended"
label define GPA -1 "Missing or skip" 1 "below 3.0" 2 "3.0-3.5" 3 "3.5-4.0" 
label value f3gparecode GPA
tab f3gparecode

codebook F3PSSELECT
gen f3psselect_new = F3PSSELECT
replace f3psselect_new = -1 if F3PSSELECT < 0
replace f3psselect_new = 1 if F3PSSELECT==2
replace f3psselect_new = 0 if F3PSSELECT==3|F3PSSELECT==4|F3PSSELECT==5|F3PSSELECT==6|F3PSSELECT==0
label define selectivity -1 "Missing or skip" 0 "Non-Selective" 1 "Selective"
label value f3psselect_new selectivity
tab f3psselect_new

codebook F3TZSTEM1CRED
gen stemmajor = F3TZSTEM1CRED
replace stemmajor = -1 if F3TZSTEM1CRED == -9 | F3TZSTEM1CRED == -8 | F3TZSTEM1CRED == -4 | F3TZSTEM1CRED == -3
replace stemmajor = 1 if F3TZSTEM1CRED == 0
replace stemmajor = 2 if F3TZSTEM1CRED == 1 | F3TZSTEM1CRED == 2
label define STEM -1 "Missing or Skipped" 1 "No PS Credentials in STEM Field" 2 "At Least 1 PS Credential in STEM Field"
label value stemmajor STEM

gen fulltimejob = F3B14A
replace fulltimejob = -1 if F3B14A == -9 | F3B14A == -8 | F3B14A == -7 | F3B14A == -4
replace fulltimejob = 1 if F3B14A == 1 | F3B14A == 2
label define fulljob -1 "Missing or Skipped" 0 "No Full-time Job" 1 "At least one Full-time job"
label value fulltimejob fulljob

gen parttimejob = F3B14B
replace parttimejob = -1 if F3B14B == -9 | F3B14B == -8 | F3B14B == -7 | F3B14B == -4
replace parttimejob = 1 if F3B14B == 1 
replace parttimejob = 2 if F3B14B == 2 | F3B14B == 3 | F3B14B == 4
label define partjob -1 "Missing or Skipped" 0 "No Part-time job" 1 "One Part-time job" 2 "Multiple Part-time job"
label value parttimejob partjob

gen std_math = BYTXMSTD
replace std_math = 0 if BYTXMSTD < 0


**Gen flag for missing values**
foreach var of varlist BYSEX BYRACE BYSTLANG BYSTLNG2 BYHOMLNG BYPARACE BYPLANG BYPARLNG BYPARED BY10FLP F2PS1GRT F3ATTAINMENT F3TZGPALAST F3A23 F3A24A F3A24B F3PSSELECT F3TZSTEM1CRED F3B14A F3B14B BYTXMSTD{
    gen flag_`var' = (`var' < 0 | `var'==.)
}


gen lg_income2011 = log10(F3ERN2011)

gen bysex_male = (BYSEX == 1)

gen byrace_asian = (byrace_new == 2)
gen byrace_african = (byrace_new == 3)
gen byrace_hisp = (byrace_new == 4)
gen byrace_others = (byrace_new == 5)

gen bystlang_native = (bystlang_new == 1)

gen byhomlng_eng = (byhomlng_new == 1)

//BYSTLNG2 binary already

gen byparace_asian = (byparace_new == 2)
gen byparace_african = (byparace_new == 3)
gen byparace_hisp = (byparace_new == 4)
gen byparace_others = (byparace_new == 5)

gen byplang_fluent = (byplang_new == 1)

gen byparlng_eng = (byparlng_new == 1)

gen bypared_2_year = (bypared_new == 2)
gen bypared_4_year = (bypared_new == 3)
gen bypared_ms = (bypared_new == 4)

gen by10flp_low50 = (by10flp_new == 1)

gen f2ps1grt_scholarship = (f2ps1grt_new == 2)

gen f3attainment_ps = (f3attainment_new == 2)
gen f3attainment_as = (f3attainment_new == 3)
gen f3attainment_ba = (f3attainment_new == 4)
gen f3attainment_ms = (f3attainment_new == 5)

gen f3a24a_50more = (f3a24a_new == 2)
gen f3a24a_100 = (f3a24a_new == 3)

gen f3a24b_50more = (f3a24b_new == 2)
gen f3a24b_100 = (f3a24b_new == 3)

//F2PSEEXM binary already

gen gpa_3_0 = (f3gparecode == 2)
gen gpa_3_5 = (f3gparecode == 3)

gen f2ps1grt_yes = (f2ps1grt_new == 2)

gen f3psselect_selective = (f3psselect_new == 1)

gen stemmajor_stem = (stemmajor == 2)

gen fulltimejob_yes = (fulltimejob == 1)

gen parttimejob_one = (parttimejob == 1)
gen parttimejob_multi = (parttimejob == 2)

drop if F3ERN2011 <= 0

save Data22_11_28.dta, replace

**Regression**
**flag_BYSTLANG, bystlang_native removed due to multicollinearity (high VIF)**

**Baseline: Dep: 2011 income; Ind: income 2001, degree earned**
reg lg_income2011 i.BYINCOME flag_F3ATTAINMENT f3attainment_ps f3attainment_as f3attainment_ba f3attainment_ms

**Baseline. Reg between 2011 income, and 2001 income, students linguistic characteristics**
reg lg_income2011 i.BYINCOME flag_BYSEX bysex_male flag_BYRACE byrace_asian byrace_african byrace_hisp byrace_others i.BYSTLNG2 flag_F3ATTAINMENT f3attainment_ps f3attainment_as f3attainment_ba f3attainment_ms, robust

**Baseline. Dep: 2011 income; Ind: 2001 income, parental education and linguistic characteristics, free lunch categroical, degree earned**
reg lg_income2011 i.BYINCOME flag_BYPARACE byparace_asian byparace_african byparace_hisp byparace_others flag_BYPLANG byplang_fluent flag_BYPARED bypared_2_year bypared_4_year bypared_ms flag_BY10FLP by10flp_low50 flag_F3ATTAINMENT f3attainment_ps f3attainment_as f3attainment_ba f3attainment_ms, robust

**Baseline. Dep: 2011 income; Ind: 2001 income, students linguistic characteristics, parental education and linguistic characteristics **
reg lg_income2011 i.BYINCOME flag_BYSEX bysex_male flag_BYRACE byrace_asian byrace_african byrace_hisp byrace_others i.BYSTLNG2 flag_BYPARACE byparace_asian byparace_african byparace_hisp byparace_others flag_BYPLANG byplang_fluent flag_BYPARED bypared_2_year bypared_4_year bypared_ms flag_BY10FLP by10flp_low50 flag_F3ATTAINMENT f3attainment_ps f3attainment_as f3attainment_ba f3attainment_ms, robust

**Final Model**
reg lg_income2011 i.BYINCOME flag_BYSEX bysex_male flag_BYRACE byrace_asian byrace_african byrace_hisp byrace_others i.BYSTLNG2 flag_BYPARACE byparace_asian byparace_african byparace_hisp byparace_others flag_BYPLANG byplang_fluent flag_BYPARED bypared_2_year bypared_4_year bypared_ms flag_F3ATTAINMENT f3attainment_ps f3attainment_as f3attainment_ba f3attainment_ms flag_BY10FLP by10flp_low50 flag_F2PS1GRT f2ps1grt_scholarship flag_F3A24A f3a24a_50more f3a24a_100 flag_F3A24B f3a24b_50more f3a24b_100 i.F2PSEEXM flag_F3TZGPALAST gpa_3_0 gpa_3_5 flag_F3PSSELECT f3psselect_selective flag_F3TZSTEM1CRED stemmajor_stem flag_F3B14A fulltimejob_yes flag_F3B14B parttimejob_one parttimejob_multi flag_BYTXMSTD std_math, robust

gen male_bachelor = bysex_male * f3attainment_ba
gen male_ms = bysex_male * f3attainment_ms

reg lg_income2011 i.BYINCOME flag_BYSEX bysex_male flag_BYRACE byrace_asian byrace_african byrace_hisp byrace_others i.BYSTLNG2 flag_BYPARACE byparace_asian byparace_african byparace_hisp byparace_others flag_BYPLANG byplang_fluent flag_BYPARED bypared_2_year bypared_4_year bypared_ms flag_F3ATTAINMENT f3attainment_ps f3attainment_as f3attainment_ba f3attainment_ms flag_BY10FLP by10flp_low50 flag_F2PS1GRT f2ps1grt_scholarship flag_F3A24A f3a24a_50more f3a24a_100 flag_F3A24B f3a24b_50more f3a24b_100 i.F2PSEEXM flag_F3TZGPALAST gpa_3_0 gpa_3_5 flag_F3PSSELECT f3psselect_selective flag_F3TZSTEM1CRED stemmajor_stem flag_F3B14A fulltimejob_yes flag_F3B14B parttimejob_one parttimejob_multi flag_BYTXMSTD std_math male_bachelor male_ms, robust

