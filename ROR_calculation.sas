/* 연구약물, 대조약물 찾기*/

data study_drug;
	set who.substance;
	/*연구에 맞는 약물성분 확인*/
	where substance_name contains "Pembrolizumab" or substance_name contains "pembrolizumab"
		  or substance_name contains "Ipilimumab" or substance_name contains "ipilimumab"
		  or substance_name contains"Dacarbazine" or substance_name contains "dacarbazine"
		  or substance_name contains "temozolomide" or substance_name contains "Temozolomide"
		  or substance_name contains "Carboplatin" or substance_name contains "carboplatin" 
		  or substance_name contains "Paclitaxel"
		  or substance_name contains "paclitaxel" or substance_name contains "pemetrexed"
		  or substance_name contains "Pemetrexed" or substance_name contains "gemcitabine"
		  or substance_name contains "Gemcitabine" or substance_name contains "nab-paclitaxel"
		  or substance_name contains "Nab-paclitaxel" or substance_name contains "Docetaxel"
		  or substance_name contains "docetaxel" or substance_name contains "Brentuximab"
		  or substance_name contains "brentuximab" or substance_name contains "vinflunine"
		  or substance_name contains "Vinflunine" or substance_name contains "Cetuximab"
		  or substance_name contains "cetuximab" or substance_name contains "fluorouracil"
		  or substance_name contains "Fluorouracil" or substance_name contains "Methotrexate"
		  or substance_name contains "methotrexate" or substance_name contains "Axitinib"
		  or substance_name contains "axitinib" or substance_name contains "Sunitinib"
		  or substance_name contains "sunitinib" or substance_name contains "Doxorubicin"
		  or substance_name contains "doxorubicin";
run;

proc sql;
	create table study_drug2 as
	select distinct *
	from who.ing
	where substance_id in (select distinct substance_id from study_drug);
quit;

proc sql;
	create table study_drug3 as
	select distinct *
	from who.pp
	where Pharmproduct_Id in (select distinct Pharmproduct_Id from study_drug2);
quit;

proc sql;
	create table study_drug4 as
	select distinct drug_name, Drug_record_number
	from who.mp
	where Medicinalprod_Id in (select distinct Medicinalprod_Id from study_drug3);
quit;
/*Pembrolizumab + Axitinib combination therapy =  154163 */
/*Pembrolizumab monotherapy = 083428*/


/* adjusted ROR_preprocessing*/
data drug;
	set main.drug;
	if basis in ("2","-") then delete; /*병용, 결측치 제거*/
	if drecno in ("999997", "999998", "999999") then delete; 
	/*999997 Investigational products
	   999998 Not identified in WHODD
	   999999 Not identified in WHODD*/
run;

proc sql;
	create table drug as
	select distinct *
	from drug
	where drecno in (select distinct Drug_record_number from study_drug4);
quit;

data drug;
	set drug;
	if drecno in ("154163","083428") then drug = 1;
	else drug = 0;
run;


data adr;
	set main.adr;

	if meddra_id = "0" then delete; /*이상반응명 결측치*/

	/*결과 숫자형*/
	if outcome = "-" then outcome = 0;
	outcome_num = outcome * 1;

	drop outcome;
run;

proc sql;
	create table drug_ae as
	select distinct a.*, b.*
	from drug as a inner join adr as b on a.umcreportid = b.umcreportid;
quit;

data link;
	set main.link;

	/*이상반응발현이 의심약물투여보다 빠른 경우 제거*/
	if TimeToOnsetMin in (" ", "-") then tto_min = .;
	else tto_min = TimeToOnsetMin;
	if TimeToOnsetMax in (" ", "-") then tto_max = .;
	else tto_max = TimeToOnsetMax;
	
	if tto_min =. and tto_max =. then tto = .;
	else if tto_min =. then tto = .;
	else if tto_max =. then tto = .;
	else if (tto_max + tto_min)/2 = int((tto_max + tto_min)/2) then tto = (tto_max + tto_min)/2;
	else tto = int((tto_max + tto_min)/2) +1;

	if tto ^= . and tto < 0 then delete;
	drop tto_min tto_max TimeToOnsetMin TimeToOnsetMax;


	if dechallenge1 in ("-", " ") then dechallenge1 = 5;/*5는 약물조치 결측치*/
	if dechallenge2 in ("-", " ") then dechallenge2 = 5;/*5는 약물조치에 대한 결과 결측치*/
	if rechallenge1 in ("-", " ") then rechallenge1 = 4;/*4는 재투여여부에 대한 결측치*/
	if rechallenge2 in ("-", " ") then rechallenge2 = 3;/*3은 재투여시 결과 결측치*/

	/*약물조치 숫자형*/
	dechallenge1_number = dechallenge1*1;
	/*약물조치에 대한 결과 숫자형*/
	dechallenge2_number = dechallenge2*1;
	/*재투여여부 숫자형*/
	rechallenge1_number = rechallenge1*1;
	/*재투여시 결과 숫자형 약물조치에 대한 결과 숫자형*/
	rechallenge2_number = rechallenge2*1;

	drop dechallenge1 dechallenge2 rechallenge1 rechallenge2;
run;

proc sql;
	create table drug_ae1 as
	select distinct a.*, b.*
	from drug_ae as a inner join link as b on a.drug_id = b.drug_id AND a.adr_id = b.adr_id;
quit;

data drug_ae2;
	set drug_ae1;
	drop drug_id  medicinalprod_id adr_id seq1 -- frequencyU tto;
run;

proc sql;
	create table drug_ae3 as
	select distinct b.pt_code, a.*
	from drug_ae2 as a left join main.meddra_v24 as b on a.meddra_id = b.llt;
quit;

data drug_ae4;
	set drug_ae3;
	drop meddra_id;
run;

data duplicate;
	set sub.suspectedduplicates;
	duplicateid = Suspected_duplicate_ReportId*1;
run;	

/*Remove duplicated report*/
proc sql;
	create table base1 as
	select distinct *
	from main.demo
	where umcreportid not in (select distinct duplicateid from duplicate);
quit;

data base2;
	set base1;

	/*연령군 숫자변수*/
	agg = agegroup*1; 

	 /*성별 숫자변수*/
	if gender in ("-", "9") then sex = 0; /*0 = 성별 결측치*/
	else sex = gender*1; 

	/*보고서유형 숫자변수*/
	if type = "-" then report_type = 4; /*4 = 보고서유형 결측치*/
	else report_type = type*1;

	/*지역 숫자변수*/
	region_num = region*1; 

	/*보고서 보고년도수*/
	calendar_year = substr(firstdatedatabase,1,4)*1;

	drop agegroup -- firstdatedatabase;
run;

data srce;
	set main.srce;

	/*보고자 숫자변수*/
	if type = " " then notifier = 0;/*0 = 보고자 결측치*/
	else notifier = type*1;

run;

proc sql;
	create table bb.base3 as
	select distinct a.*, b.*
	from base2 as a left join srce as b on a.umcreportid = b.umcreportid;
quit;


proc freq data=main.out;
	table seriousness;
run;

data out;
	set main.out;

	/*중대한이상반응 숫자변수*/
	if serious = "N" then SAE = 0;
	else if serious = "Y" then SAE = 1;
    else SAE = 2; /*2는 결측치*/

	/*중대한이상반응종류 숫자변수*/
	if seriousness = "-" then seriousness_num = 0;
	else seriousness_num = seriousness*1;

	drop seriousness serious;
run;

proc sql;
	create table bb.base4 as
	select distinct a.*, b.*
	from bb.base3 as a left join out as b on a.umcreportid = b.umcreportid;
quit;

proc sql;
	create table bb.base5 as
	select distinct a.*, b.*
	from bb.base4 as a inner join drug_ae4 as b on a.umcreportid = b.umcreportid;
quit;

proc sql;
	create table target_ae_list as
	select distinct pt_code
	from bb.base5
	where drug = 1
	order by pt_code;
quit;

data target_ae_list;
	set target_ae_list;
	n+1;
run;

proc sql;
	create table bb.base6 as
	select distinct a.*, b.n
	from bb.base5 as a left join target_ae_list as b on a.pt_code = b.pt_code;
quit;

data bb.final;
	retain drecno drug pt_code;
	set bb.base6;

	/*결측치 처리*/
	if notifier =. then notifier = 0;
	if SAE =. then SAE=2;
	if seriousness_num =. then seriousness_num=0;

	drop umcreportid;
run;



/* adjusted ROR 산출 매크로*/
%macro ROR;

data target_ae_list;
	set target_ae_list;
	by n;
	if last.n then call symput('end',n);
run;

%do integer=1 %to &end.; 

data ROR_&integer.;
	set bb.final;
	if n = &integer. then target =1;
	else target = 0;
	ods output OddsRatios = or_&integer. ;

	proc logistic data=ROR_&integer. desc;
		class drug(ref='0');
		model target= drug agg sex report_type region_num calendar_year notifier SAE 
			      seriousness_num outcome_num dechallenge1_number dechallenge2_number
			      rechallenge1_number rechallenge2_number;/*노출 및 보정변수 추가*/
	run; 


data or_&integer.;
	set or_&integer.;
	if Effect ="drug                1 vs 0";
	n=&integer.;
run;

proc datasets nolist;
	delete ROR_&integer.;
quit;

%end;

data adjusted_or;
	set or_1-or_&end.;
run;

proc datasets nolist;
	delete or_1-or_&end.;
quit;

%mend;

%ROR;
