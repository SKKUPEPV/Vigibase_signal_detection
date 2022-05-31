/*** 9주차 sas 실습코드 (22.04.23) ***/

/*라이브러리 생성*/
libname a "C:\Users\Seohyun kim\Desktop\대학원 수업\9주차 실습자료\수업용 데이터셋";
option compress=yes; 
*compress 옵션: sas 데이터셋 생성 시, 데이터 파일 크기와 작업시간을 단축시킬 수 있음 - 분석 시작 전 앞에 기본적으로 써주면 좋음;


/******************************/
/*      [복습]  PROC SQL 예제       */
/******************************/

/*연구대상자: 2008년 입원 일수의 합이 7일 이상인 환자인 포함하고자 함*/
/*필요변수: 환자의 개인식별번호, 입원일수*/

/*① 입원 일수 총 합 구하기*/
/*예1)*/
proc sql;
create table hosp1_1 as
select person_id, sum(vscn) as sum_vscn
from a.t20_2008
order by person_id;
quit;

/*예2)*/
proc sql;
create table hosp1 as
select person_id, sum(vscn) as sum_vscn
from a.t20_2008
group by person_id
order by person_id;
quit;

/*② 입원일수의 총 합이 7일 이상인 환자로 제한*/
data hosp2; set hosp1;
if sum_vscn >=7; run;
 
/*※ (한번에) 입원일수 총 합 계산 + 입원일수 합 7일 이상인 환자로 제한*/
proc sql;
create table hosp3 as
select person_id, sum(vscn) as sum_vscn
from a.t20_2008
group by person_id
having sum_vscn>=7
order by person_id;
quit;

/*검토(습관)*/
data tmp; set hosp3;
if  sum_vscn<7; run;


/********************************/
/*     [1] 유병률 및 시계열 그래프      */
/********************************/

/*** 실습 1: 2010년 천식 유병률  ***/

/* 1) 분자 산출 */
/* 분자 정의: 2010년 동안 주부상병에 천식 진단코드가 있는 환자 수*/
/* 필요변수: 개인식별코드, 주부상병 (T20)*/

/* 1-1) 천식 진단이 있는 명세서 가져오기 */

/*예1 */
data asthma1_1; set a.t20_2010;
if main_sick in ("J45","J46") or sub_sick in ("J45","J46");
run;
/*69*/
/*자주 하는 실수 - 절대 주의!*/

/*예2 */
data asthma1; set a.t20_2010;
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");
run;
/*2,534*/

/* 1-2) 천식 진단이 있는 환자 수 세기 */
proc sort data=asthma1 out=boonja nodupkey;
by person_id; run;
/*689*/

/* 2) 분모 산출 */
/* 분모 정의: 2010년에 의료기관을 이용한 총 환자수*/
/*필요변수: 전체 환자의 개인식별번호 (JK)*/

/* 2-2) 총 환자수  세기 */
proc sort data=a.jk_2010 out=boonmo nodupkey;
by person_id; run;
/*10,000*/


/*** 실습 2: 환자 특성별 2010년 천식 유병률 산출  ***/

/* 1) 연령군별 유병률*/
/*추가 필요변수: 성별, 연령 (JK)*/

/* 1-1) 인구학적 특성 정보 가져오기*/
data char1; set a.jk_2010 (keep=person_id sex age_group);
*연령 그룹핑;
if 0<= age_group <5 then agg=1;  /*<20 yrs*/
else if 5<= age_group <13 then agg=2;  /*20-59 yrs*/
else if 13<= age_group then agg=3;  /*60+ yrs*/
else agg=99;
drop age_group;
run;

/*특성 분포 확인 (+ 그룹핑 검토)*/
proc freq data=char1;
table sex agg; 
run;

/* 1-2) 천식환자 데이터셋(boonja)과 환자 특성 데이터셋(char1) 결합 */
proc sql;
create table prev1 as
select a.*, b.sex, b.agg
from boonja as a left join char1 as b
on a.person_id=b.person_id;
quit;
/*689*/

/*1-3) 환자 특성별 유병률 산출*/
proc freq data=prev1;
tables sex agg/nopercent;
run;	


/*** 실습3 : 다년도 유병률 산출 및 시계열 그래프 그리기  ***/

/*2010-2012 (3개년) 동안 분기별 천식 유병률 산출*/

/* 1) 2010년 (1개년) 분기별 천식 유병률 구하기*/

/* 1-1) 천식 진단 명세서 가져오기 */
data asthma2010; set a.t20_2010;
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");

*4분기 그룹핑;
if substr(recu_fr_dt,5,2) in ("01","02","03") then quarter=1;
else if substr(recu_fr_dt,5,2) in ("04","05","06") then quarter=2;
else if substr(recu_fr_dt,5,2) in ("07","08","09") then quarter=3;
else quarter=4;

keep person_id main_sick sub_sick quarter;
run;

/* 1-2) 분기별 동일 환자 중복제거 */
proc sort data=asthma2010 out=cohort2010 nodupkey;
by person_id quarter; run;

/* 1-3) 분기별 환자수 세기*/
proc freq data=cohort2010;
tables quarter; run;

/*2) 매크로 활용하여 2010-2012년간 천식 분기별 유병률 구하기*/

%macro aa;
%do year=2010 %to 2012;

/* 1-1) 천식 진단 명세서 가져오기 */
data asthma&year.; set a.t20_&year.;
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");

if substr(recu_fr_dt,5,2) in ("01","02","03") then quarter=1;
else if substr(recu_fr_dt,5,2) in ("04","05","06") then quarter=2;
else if substr(recu_fr_dt,5,2) in ("07","08","09") then quarter=3;
else quarter=4;

keep person_id main_sick sub_sick quarter;
run;

/* 1-2) 분기별 동일 환자 중복제거 */
proc sort data=asthma&year. out=cohort&year. nodupkey;
by person_id quarter; run;

/* 1-3) 분기별 환자수 세기*/
proc freq data=cohort&year.;
tables quarter; run;

%end;
%mend;
%aa;


/*********************************/
/*      [2] 발생율 (Incidence rate)      */
/*********************************/

/*** 실습 4: 2010년 천식 발생률 산출하기  ***/

/*필요변수: 개인식별번호, 주/부상병*/
/*필요 데이터셋: a.jk_2010, a.t20_2010, a.t20_2009, */

/* 1) 분모: 2010년 의료기관 이용자 중 천식(주/부상병)진단이 이전 1년(2009년)에 없던 자*/

/* 1-1) 분모: 2010년 의료기관 이용자*/
data bm1; set a.jk_2010 (keep=person_id);
run;

/* 1-2) 천식 유병환자(2009년 천식 진단 환자) 제외*/
/* i) 2009년 천식 진단 환자 추출*/
data prev; set a.t20_2009; 
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");
run;
/* ii) 2010년 의료기관 이용자 중 2009년 천식 진단 환자 제외*/
proc sql;
create table bm as
select distinct *
from bm1 
where person_id not in (select person_id from prev);
quit;

/* 2) 분자: 2010년 새롭게 천식이 발생 환자*/

/* 코드 예1*/
/* 2-1) 분모 환자에 2010년 진단 명세서 연결  */
proc sql;
create table bj1 as
select distinct a.*, b.main_sick, b.sub_sick
from bm as a left join a.t20_2010 as b
on a.person_id=b.person_id;
quit;

/* 2-2) 천식 발생 환자만 데려오기  */
data bj2; set bj1; 
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");
run;

/* 2-3) 천식 발생 환자 수 세기 */
proc sort data=bj2 out=bj3 nodupkey;
by person_id;
run;
/*374*/

/* cf. 코드 예2 (위 과정 한번에)*/
/* 분모에서 2010년 천식 발생자 수 세기 */
proc sql;
create table bj as
select distinct a.*
from bm as a left join a.t20_2010 as b
on a.person_id=b.person_id
where substr(b.main_sick,1,3) in ("J45","J46") 
		or substr(b.sub_sick,1,3) in ("J45","J46");
quit;
/*374*/
