libname a "C:\Users\user\Desktop\Vigibase_data\main_file";
libname b "C:\Users\user\Desktop\Vigibase_data";
libname c "C:\Users\user\Desktop\Vigibase_data\kymriah";

proc sql;
	create table aa as
	select distinct umcreportid, drecNo
	from a.drug
	where substr(drecNo,1,6) = "143859";
quit; 

proc sql;
	create table cc as
	select distinct a.*, b.MedDRA_Id
	from aa as a left join a.adr as b on a.umcreportid = b.umcreportid;
quit;

proc sql;
	create table dd as
	select distinct MedDRA_ID, count(distinct umcreportid) as a
	from cc
	group by meddra_id
	order by calculated a desc;
quit;

proc sql;
	create table aa_1 as
	select distinct umcreportid, drecNo
	from a.drug
	where substr(drecNo,1,6) = "080320";
quit; 

proc sql;
	create table cc_1 as
	select distinct a.*, b.MedDRA_Id
	from aa_1 as a left join a.adr as b on a.umcreportid = b.umcreportid;
quit;

proc sql;
	create table dd_1 as
	select distinct MedDRA_ID, count(distinct umcreportid) as a
	from cc_1
	group by meddra_id
	order by calculated a desc;
quit;

proc freq data=dd;
	table meddra_id;
run;

proc import out=c.dictionary
	datafile = 'C:\Users\user\Desktop\Vigibase_data\MedDRA_dictionary_ver24.0'
	DBMS = xlsx replace;
run;

proc sql;
	create table ee as
	select distinct a.*, b.pt_code, b.PT_ENGLISH_
	from dd as a left join c.dictionary as b on b.LLT_code = a.MedDRA_Id;
quit;

proc sql;
	create table ee_1 as
	select distinct pt_code, PT_ENGLISH_, sum(a) as temp
	from ee
	where pt_code ^=.
	group by pt_code
	order by calculated temp desc;
quit;
	



