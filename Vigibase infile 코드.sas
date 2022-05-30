libname main "Data storage\VigiBase Extract Case Level 2022 Mar 1\rawdata_main";
libname sub "Data storage\VigiBase Extract Case Level 2022 Mar 1\rawdata_sub";
libname who "Data storage\\VigiBase Extract Case Level 2022 Mar 1\rawdata_who";


/*Main-Demo*/
data main.demo;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\main_files_extract_mar_1_2022\demo.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat UMCReportId 11. ;
informat AgeGroup $1. ;
informat Gender $1. ;
informat DateDatabase $8. ;
informat Type $1. ;
informat Region $1. ;
informat FirstDateDatabase $8.;

format UMCReportId 11. ;
format AgeGroup $1. ;
format Gender $1. ;
format DateDatabase $8. ;
format Type $1. ;
format Region $1. ;
format FirstDateDatabase $8.;

input
 UMCReportId 1-11
 AgeGroup $ 12
 Gender $ 13
 DateDatabase $ 14-21
 Type $ 22
 Region $ 23
 FirstDateDatabase $ 24-31
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Main-Drug*/
data main.drug;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\main_files_extract_mar_1_2022\DRUG.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat UMCReportId 11. ;
informat Drug_Id 11. ;
informat MedicinalProd_Id 11.;
informat DrecNo $ 6.;
informat Seq1 $ 2.;
informat Seq2 $ 3.;
informat Route $ 2.;
informat Basis $ 1.;
informat Amount $ 5.;
informat AmountU $ 2.;
informat Frequency $ 2.;
informat FrequencyU $ 3.;

format UMCReportId 11. ;
format Drug_Id 11. ;
format MedicinalProd_Id 11.;
format DrecNo $ 6.;
format Seq1 $ 2.;
format Seq2 $ 3.;
format Route $ 2.;
format Basis $ 1.;
format Amount $ 5.;
format AmountU $ 2.;
format Frequency $ 2.;
format FrequencyU $ 3.;

input
UMCReportId 1-11
Drug_Id 12-22
MedicinalProd_Id 23-33
DrecNo $ 34-39
Seq1 $ 40-41
Seq2 $ 42-44
Route $ 45-46
Basis $ 47
Amount $ 48-52
AmountU $ 53-54
Frequency $ 55-56
FrequencyU $ 57-59
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Main-ADR*/
data main.adr;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\main_files_extract_mar_1_2022\ADR.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat UMCReportId 11. ;
informat Adr_Id 11. ;
informat MedDRA_Id 8.;
informat Outcome $ 1.;

format UMCReportId 11. ;
format Adr_Id 11. ;
format MedDRA_Id 8.;
format Outcome $ 1.;

input
UMCReportId 1-11
Adr_Id 12-22
MedDRA_Id 23-30
Outcome $ 31
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Main-OUT*/
data main.OUT;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\main_files_extract_mar_1_2022\OUT.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat UMCReportId 11. ;
informat Seriousness $2.;
informat Serious $1.;

format UMCReportId 11. ;
format Seriousness $2.;
format Serious $1.;

input
UMCReportId 1-11
Seriousness $12-13
Serious $14
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Main-SRCE*/
data main.SRCE;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\main_files_extract_mar_1_2022\SRCE.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat UMCReportId 11. ;
informat Type $2. ;

format UMCReportId 11. ;
format Type $2. ;

input
UMCReportId 1-11
Type $12-13
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Main-LINK*/
data main.LINK;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\main_files_extract_mar_1_2022\LINK.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Drug_Id 11. ;
informat Adr_Id 11. ;
informat Dechallenge1 $1.;
informat Dechallenge2 $1.;
informat Rechallenge1 $1.;
informat Rechallenge2 $1.;
informat TimeToOnsetMin $11.;
informat TimeToOnsetMax $11.;

format Drug_Id 11. ;
format Adr_Id 11. ;
format Dechallenge1 $1.;
format Dechallenge2 $1.;
format Rechallenge1 $1.;
format Rechallenge2 $1.;
format TimeToOnsetMin $11.;
format TimeToOnsetMax $11.;


input
Drug_Id 1-11
Adr_Id 12-22
Dechallenge1 $23
Dechallenge2 $24
Rechallenge1 $25
Rechallenge2 $26
TimeToOnsetMin $27-37
TimeToOnsetMax $38-48
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Main-IND*/
data main.ind;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\main_files_extract_mar_1_2022\IND.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Drug_Id 11. ;
informat Indication $ 255.;

format Drug_Id 11. ;
format Indication $ 255.;

input
Drug_Id 1-11
Indication $ 12-266
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Main-FOLLOWUP*/
data main.followup;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\main_files_extract_mar_1_2022\FOLLOWUP.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat UMCReportId 11. ;
informat ReplacedUMCReportId 11.;

format UMCReportId 11. ;
format ReplacedUMCReportId 11.;

input
UMCReportId 1-11
ReplacedUMCReportId 12-22
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;






/*Subsidiary-Agegroup*/
data sub.AgeGroup_Lx;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\agegroup_lx.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $25. ;

format Code $1. ;
format Text $25. ;

input
 Code $ 1
 Text $ 2-26
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-Gender*/
data sub.Gender;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Gender_Lx.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $256.;

format Code $1. ;
format Text $256.;

input
Code $ 1
Text $ 2-257
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-Reporttype*/
data sub.Reporttype;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\ReportType_Lx.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $256.;

format Code $1. ;
format Text $256.;

input
Code $ 1
Text $ 2-257
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-Region*/
data sub.Region;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Region_Lx.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $50.;

format Code $1. ;
format Text $50.;

input
Code $ 1
Text $ 2-51
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-RouteOfAdm*/
data sub.RouteOfAdmr;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\RouteOfAdm_Lx.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $2. ;
informat Text $80.;

format Code $2. ;
format Text $80.;

input
Code $ 1-2
Text $ 3-82
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-RepBasis*/
data sub.RepBasis;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\RepBasis_Lx.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $50.;

format Code $1. ;
format Text $50.;

input
Code $ 1
Text $ 2-51
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;

/*Sub-SizeUnit*/
data sub.SizeUnit;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\SizeUnit_Lx.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $2. ;
informat Text $80. ;

format Code $2. ;
format Text $80. ;
input
 code $ 1-2
 Text $ 3-82
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-Frequency*/
data sub.Frequency;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Frequency_Lx.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $3. ;
informat Text $256. ;

format Code $3. ;
format Text $256. ;

input
 Code $ 1-3
 Text $ 4-259
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-Outcome*/
data sub.Outcome;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Outcome_Lx.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $256. ;

format Code $1. ;
format Text $256. ;

input
 Code $ 1
 Text $ 2-257
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-Seriousness*/
data sub.Seriousness;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Seriousness_Lx.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $2. ;
informat Text $256. ;

format Code $2. ;
format Text $256. ;

input
 Code $ 1-2
 Text $ 3-258
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;

/*Sub-Notifier*/
data sub.Notifier;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Notifier_Lx.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $2. ;
informat Text $256. ;

format Code $2. ;
format Text $256. ;

input
 Code $ 1-2
 Text $ 3-258
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-Dechallenge*/
data sub.Dechallenge;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Dechallenge_Lx.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $256. ;

format Code $1. ;
format Text $256. ;

input
 Code $ 1
 Text $ 2-257
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub-Dechallenge2*/
data sub.Dechallenge2;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Dechallenge2_Lx.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $256. ;

format Code $1. ;
format Text $256. ;

input
 Code $ 1
 Text $ 2-257
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/* Sub - Rechallenge */
data sub.Rechallenge_Lx;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Rechallenge_lx.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $80. ;

format Code $1. ;
format Text $80. ;

input
 Code $ 1
 Text $ 2-81
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/* Sub - Rechallenge2 */
data sub.Rechallenge2_Lx;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\Rechallenge2_lx.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Code $1. ;
informat Text $80. ;

format Code $1. ;
format Text $80. ;

input
 Code $ 1
 Text $ 2-81
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Sub - MedDRAversion*/
data sub.MedDRAversion_Lx;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\MedDRAversion.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat MedDRAVersion $10. ;

format MedDRAVersion $10. ;

input
 MedDRAVersion $ 1-10
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/* Sub - SUSPECTEDDUPLICATES */
data sub.Suspectedduplicates;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\SUSPECTEDDUPLICATES.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat UMC_ReportId $11. ;
informat Suspected_duplicate_ReportId $11. ;

format UMC_ReportId $11. ;
format Suspected_duplicate_ReportId $11. ;

input
 UMC_ReportId $ 1-11
 Suspected_duplicate_ReportId $ 12-22
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/* Sub - USCDERSAFETYREPORTID */
data sub.UscDersafetyReportID;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\subsidiary_files_extract_mar_1_2022\USCDERSAFETYREPORTID.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat UMC_ReportId $11. ;
informat Suspected_duplicate_ReportId $100. ;

format UMC_ReportId $11. ;
format Suspected_duplicate_ReportId $100. ;

input
 UMC_ReportId $ 1-11
 Suspected_duplicate_ReportId $ 12-111
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;








/*Who_ddx-Medicinal Product*/
data who.mp;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\MP.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Medicinalprod_Id $10. ;
informat MedID $35. ;
informat Drug_record_number $6. ;
informat Sequence_number_1 $2. ;
informat Sequence_number_2 $3. ;
informat Sequence_number_3 $10. ; 
informat Sequence_number_4 $10. ;
informat Generic $1. ;
informat Drug_name $1500. ;
informat Name_specifier $30. ;
informat Marketing_Authorization_Number $30. ;
informat Marketing_Authorization_date $8. ;
informat Marketing_Authorization_With $8. ;
informat Country $10. ;
informat Company $10. ;
informat Marketing_Authorization_Holder $10. ;
informat reference_code $10. ;
informat source_country $10. ;
informat Year_of_reference $3. ;
informat product_type $10. ;
informat product_group $10. ;
informat create_date $8. ;
informat date_changed $8. ;

format Medicinalprod_Id $10. ;
format MedID $35. ;
format Drug_record_number $6. ;
format Sequence_number_1 $2. ;
format Sequence_number_2 $3. ;
format Sequence_number_3 $10. ; 
format Sequence_number_4 $10. ;
format Generic $1. ;
format Drug_name $1500. ;
format Name_specifier $30. ;
format Marketing_Authorization_Number $30. ;
format Marketing_Authorization_date $8. ;
format Marketing_Authorization_With $8. ;
format Country $10. ;
format Company $10. ;
format Marketing_Authorization_Holder $10. ;
format reference_code $10. ;
format source_country $10. ;
format Year_of_reference $3. ;
format product_type $10. ;
format product_group $10. ;
format create_date $8. ;
format date_changed $8. ;

input
Medicinalprod_Id $ 1-10
MedID $ 11-45
Drug_record_number $ 46-51
Sequence_number_1 $ 52-53
Sequence_number_2 $ 54-56
Sequence_number_3 $ 57-66
Sequence_number_4 $ 67-76
Generic $ 77
Drug_name $ 78-1577
Name_specifier $ 1578-1607
Marketing_Authorization_Number $ 1608-1637
Marketing_Authorization_date $ 1638-1645
Marketing_Authorization_With $ 1646-1653
Country $ 1654-1663
Company $ 1664-1673
Marketing_Authorization_Holder $ 1674-1683
reference_code $ 1684-1693
source_country $ 1694-1703
Year_of_reference $ 1704-1706
product_type $ 1707-1716
product_group $ 1717-1726
create_date $ 1727-1734
date_changed $ 1735-1742
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-PharmaceuticalProduct*/
data who.PP;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\PP.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Pharmproduct_Id $10. ;
informat Pharmaceutical_form $10. ;
informat Route_of_administration $10. ;
informat Medicinalprod_Id $10. ;
informat Number_of_ingredients $2. ;
informat create_date $8. ;

format Pharmproduct_Id $10. ;
format  Pharmaceutical_form $10. ;
format Route_of_administration $10. ;
format Medicinalprod_Id $10. ;
format Number_of_ingredients $2. ;
format create_date $8. ;

input
Pharmproduct_Id $ 1-10
Pharmaceutical_form $ 11-20 
Route_of_administration $ 21-30
Medicinalprod_Id $ 31-40
Number_of_ingredients $ 41-42
create_date $  43-50
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-ThG*/
data who.ThG;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\ThG.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Therapgroup_Id $10. ;
informat ATC_code $10. ;
informat Create_date $8. ;
informat Official_ATC_code $1. ;
informat Medicinalprod_Id $10. ;

format Therapgroup_Id $10. ;
format ATC_code $10. ;
format Create_date $8. ;
format Official_ATC_code $1. ;
format Medicinalprod_Id $10. ;

input
Therapgroup_Id $ 1-10
ATC_code $ 11-20
Create_date $ 21-28
Official_ATC_code $ 29
Medicinalprod_Id $ 30-39
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-Ingredient*/
data who.ING;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\ING.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Ingredient_Id $10. ;
informat Create_date $8. ;
informat Substance_Id $10. ;
informat Quantity $15. ;
informat Quantity_2 $15. ;
informat Unit $10. ;
informat Pharmproduct_Id $10. ;
informat Medicinalprod_Id $10. ;

format Ingredient_Id $10. ;
format Create_date $8. ;
format Substance_Id $10. ;
format Quantity $15. ;
format Quantity_2 $15. ;
format Unit $10. ;
format Pharmproduct_Id $10. ;
format Medicinalprod_Id $10. ;

input
Ingredient_Id $ 1-10 
Create_date $ 11-18
Substance_Id $ 19-28
Quantity $ 29-43
Quantity_2 $ 44-58
Unit $ 59-68
Pharmproduct_Id $ 69-78
Medicinalprod_Id $ 79-88
;

if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-Reference*/
data who.SRCE;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\SRCE.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Reference_code $10. ;
informat Reference $80. ;
informat Country_code $10. ;

format Reference_code $10. ;
format Reference $80. ;
format Country_code $10. ;

input
Reference_code $ 1-10 
Reference $ 11-90
Country_code $ 91-100 
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-Organization*/
data who.Organization;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\ORG.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Organization_Id $10.;
informat Name $80.;
informat Country_code $10.;

format Organization_Id $10.;
format Name $80.;
format Country_code $10.;

input
Organization_Id $ 1-10
Name $ 11-90
Country_code $ 91-100
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-Country*/
data who.Country;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\CCODE.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Country_code $10.;
informat Country_name $80.;

format Country_code $10.;
format Country_name $80.;

input
Country_code $ 1- 10
Country_name $ 11-90
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-ATC*/
data who.atc;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\atc.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat ATC_code $10. ;
informat Level $1. ;
informat Text $110. ;

format ATC_code $10. ;
format Level $1. ;
format Text $110. ;

input
 ATC_code $ 1-10
 Level $ 11
 Text $ 12-121
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;



/*Who_ddx-Substance*/
data who.substance;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\SUN.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Substance_Id $10. ;
informat CAS_number $10.;
informat Language_code $10.;
informat Substance_name $250.;
informat Year_of_Reference $3.;
informat Reference_code $10.;

format Substance_Id $10. ;
format CAS_number $10.;
format Language_code $10.;
format Substance_name $250.;
format Year_of_Reference $3.;
format Reference_code $10.;

input
Substance_Id $ 1-10
CAS_number $ 11-20
Language_code $ 21-30
Substance_name $ 31-280
Year_of_Reference $ 281-283
Reference_code $ 284-293
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;

/*Who_ddx-Pharmaceutical Form*/
data who.Pharmaceutical_Form;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\PF.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Pharmform_Id $10.;
informat Text $80.;

format Pharmform_Id $10.;
format Text $80.;

input
Pharmform_Id $ 1-10
Text $ 11-90
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-Strength*/
data who.Strength;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\STR.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Strength_Id $10.;
informat Text $500.;

format Strength_Id $10.;
format Text $80.;

input
Strength_Id $ 1-10
Text $ 11-510
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*WHO-PRG*/
data who.PRG;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\PRG.txt'
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Productgroup_Id $10. ;
informat Productgroup_name $60.;
informat Date_recorded 8.;

format Productgroup_Id $10. ;
format Productgroup_name $60.;
format Date_recorded 8.;

input
Productgroup_Id 1-10 
Productgroup_name $11-70
Date_recorded 71-78;
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;


/*Who_ddx-UnitX*/
data who.UnitX;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\Unit-X.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Unit_Id $10.;
informat Text $40.;

format Unit_Id $10.;
format Text $80.;

input
Pharmform_Id $ 1-10
Text $ 11-50
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;



/* who_ddx - Unit */
data who.unit;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\UNIT.txt' 
   MISSOVER DSD lrecl=32767 firstobs=1;

informat Unit_Id $10. ;
informat Text $40. ;

format Unit_Id $10. ;
format Text $40. ;

input
 Unit_Id $ 1-10
 Text $ 11-50
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;

/*Who_ddx-UnitL*/
data who.UnitL;
%let _EFIERR_ = 0; 
infile 'D:\연구\인공지능\VigiBase Extract Case Level 2022 Mar 1\who_ddx_mar_1_2022\Unit-L.txt'
MISSOVER DSD lrecl=32767 firstobs=1;

informat Unit_Id $10.;
informat Text $100.;

format Unit_Id $10.;
format Text $100.;

input
Pharmform_Id $ 1-10
Text $ 11-110
;
if _ERROR_ then call symputx('_EFIERR_',1); /* set ERROR detection macro variable */
run;

