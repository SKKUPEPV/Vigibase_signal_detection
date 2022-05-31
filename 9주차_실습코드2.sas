/*** 9���� sas �ǽ��ڵ� (22.04.23) ***/

/*���̺귯�� ����*/
libname a "C:\Users\Seohyun kim\Desktop\���п� ����\9���� �ǽ��ڷ�\������ �����ͼ�";
option compress=yes; 
*compress �ɼ�: sas �����ͼ� ���� ��, ������ ���� ũ��� �۾��ð��� �����ų �� ���� - �м� ���� �� �տ� �⺻������ ���ָ� ����;


/******************************/
/*      [����]  PROC SQL ����       */
/******************************/

/*���������: 2008�� �Կ� �ϼ��� ���� 7�� �̻��� ȯ���� �����ϰ��� ��*/
/*�ʿ亯��: ȯ���� ���νĺ���ȣ, �Կ��ϼ�*/

/*�� �Կ� �ϼ� �� �� ���ϱ�*/
/*��1)*/
proc sql;
create table hosp1_1 as
select person_id, sum(vscn) as sum_vscn
from a.t20_2008
order by person_id;
quit;

/*��2)*/
proc sql;
create table hosp1 as
select person_id, sum(vscn) as sum_vscn
from a.t20_2008
group by person_id
order by person_id;
quit;

/*�� �Կ��ϼ��� �� ���� 7�� �̻��� ȯ�ڷ� ����*/
data hosp2; set hosp1;
if sum_vscn >=7; run;
 
/*�� (�ѹ���) �Կ��ϼ� �� �� ��� + �Կ��ϼ� �� 7�� �̻��� ȯ�ڷ� ����*/
proc sql;
create table hosp3 as
select person_id, sum(vscn) as sum_vscn
from a.t20_2008
group by person_id
having sum_vscn>=7
order by person_id;
quit;

/*����(����)*/
data tmp; set hosp3;
if  sum_vscn<7; run;


/********************************/
/*     [1] ������ �� �ð迭 �׷���      */
/********************************/

/*** �ǽ� 1: 2010�� õ�� ������  ***/

/* 1) ���� ���� */
/* ���� ����: 2010�� ���� �ֺλ󺴿� õ�� �����ڵ尡 �ִ� ȯ�� ��*/
/* �ʿ亯��: ���νĺ��ڵ�, �ֺλ� (T20)*/

/* 1-1) õ�� ������ �ִ� ���� �������� */

/*��1 */
data asthma1_1; set a.t20_2010;
if main_sick in ("J45","J46") or sub_sick in ("J45","J46");
run;
/*69*/
/*���� �ϴ� �Ǽ� - ���� ����!*/

/*��2 */
data asthma1; set a.t20_2010;
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");
run;
/*2,534*/

/* 1-2) õ�� ������ �ִ� ȯ�� �� ���� */
proc sort data=asthma1 out=boonja nodupkey;
by person_id; run;
/*689*/

/* 2) �и� ���� */
/* �и� ����: 2010�⿡ �Ƿ����� �̿��� �� ȯ�ڼ�*/
/*�ʿ亯��: ��ü ȯ���� ���νĺ���ȣ (JK)*/

/* 2-2) �� ȯ�ڼ�  ���� */
proc sort data=a.jk_2010 out=boonmo nodupkey;
by person_id; run;
/*10,000*/


/*** �ǽ� 2: ȯ�� Ư���� 2010�� õ�� ������ ����  ***/

/* 1) ���ɱ��� ������*/
/*�߰� �ʿ亯��: ����, ���� (JK)*/

/* 1-1) �α����� Ư�� ���� ��������*/
data char1; set a.jk_2010 (keep=person_id sex age_group);
*���� �׷���;
if 0<= age_group <5 then agg=1;  /*<20 yrs*/
else if 5<= age_group <13 then agg=2;  /*20-59 yrs*/
else if 13<= age_group then agg=3;  /*60+ yrs*/
else agg=99;
drop age_group;
run;

/*Ư�� ���� Ȯ�� (+ �׷��� ����)*/
proc freq data=char1;
table sex agg; 
run;

/* 1-2) õ��ȯ�� �����ͼ�(boonja)�� ȯ�� Ư�� �����ͼ�(char1) ���� */
proc sql;
create table prev1 as
select a.*, b.sex, b.agg
from boonja as a left join char1 as b
on a.person_id=b.person_id;
quit;
/*689*/

/*1-3) ȯ�� Ư���� ������ ����*/
proc freq data=prev1;
tables sex agg/nopercent;
run;	


/*** �ǽ�3 : �ٳ⵵ ������ ���� �� �ð迭 �׷��� �׸���  ***/

/*2010-2012 (3����) ���� �б⺰ õ�� ������ ����*/

/* 1) 2010�� (1����) �б⺰ õ�� ������ ���ϱ�*/

/* 1-1) õ�� ���� ���� �������� */
data asthma2010; set a.t20_2010;
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");

*4�б� �׷���;
if substr(recu_fr_dt,5,2) in ("01","02","03") then quarter=1;
else if substr(recu_fr_dt,5,2) in ("04","05","06") then quarter=2;
else if substr(recu_fr_dt,5,2) in ("07","08","09") then quarter=3;
else quarter=4;

keep person_id main_sick sub_sick quarter;
run;

/* 1-2) �б⺰ ���� ȯ�� �ߺ����� */
proc sort data=asthma2010 out=cohort2010 nodupkey;
by person_id quarter; run;

/* 1-3) �б⺰ ȯ�ڼ� ����*/
proc freq data=cohort2010;
tables quarter; run;

/*2) ��ũ�� Ȱ���Ͽ� 2010-2012�Ⱓ õ�� �б⺰ ������ ���ϱ�*/

%macro aa;
%do year=2010 %to 2012;

/* 1-1) õ�� ���� ���� �������� */
data asthma&year.; set a.t20_&year.;
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");

if substr(recu_fr_dt,5,2) in ("01","02","03") then quarter=1;
else if substr(recu_fr_dt,5,2) in ("04","05","06") then quarter=2;
else if substr(recu_fr_dt,5,2) in ("07","08","09") then quarter=3;
else quarter=4;

keep person_id main_sick sub_sick quarter;
run;

/* 1-2) �б⺰ ���� ȯ�� �ߺ����� */
proc sort data=asthma&year. out=cohort&year. nodupkey;
by person_id quarter; run;

/* 1-3) �б⺰ ȯ�ڼ� ����*/
proc freq data=cohort&year.;
tables quarter; run;

%end;
%mend;
%aa;


/*********************************/
/*      [2] �߻��� (Incidence rate)      */
/*********************************/

/*** �ǽ� 4: 2010�� õ�� �߻��� �����ϱ�  ***/

/*�ʿ亯��: ���νĺ���ȣ, ��/�λ�*/
/*�ʿ� �����ͼ�: a.jk_2010, a.t20_2010, a.t20_2009, */

/* 1) �и�: 2010�� �Ƿ��� �̿��� �� õ��(��/�λ�)������ ���� 1��(2009��)�� ���� ��*/

/* 1-1) �и�: 2010�� �Ƿ��� �̿���*/
data bm1; set a.jk_2010 (keep=person_id);
run;

/* 1-2) õ�� ����ȯ��(2009�� õ�� ���� ȯ��) ����*/
/* i) 2009�� õ�� ���� ȯ�� ����*/
data prev; set a.t20_2009; 
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");
run;
/* ii) 2010�� �Ƿ��� �̿��� �� 2009�� õ�� ���� ȯ�� ����*/
proc sql;
create table bm as
select distinct *
from bm1 
where person_id not in (select person_id from prev);
quit;

/* 2) ����: 2010�� ���Ӱ� õ���� �߻� ȯ��*/

/* �ڵ� ��1*/
/* 2-1) �и� ȯ�ڿ� 2010�� ���� ���� ����  */
proc sql;
create table bj1 as
select distinct a.*, b.main_sick, b.sub_sick
from bm as a left join a.t20_2010 as b
on a.person_id=b.person_id;
quit;

/* 2-2) õ�� �߻� ȯ�ڸ� ��������  */
data bj2; set bj1; 
if substr(main_sick,1,3) in ("J45","J46") or substr(sub_sick,1,3) in ("J45","J46");
run;

/* 2-3) õ�� �߻� ȯ�� �� ���� */
proc sort data=bj2 out=bj3 nodupkey;
by person_id;
run;
/*374*/

/* cf. �ڵ� ��2 (�� ���� �ѹ���)*/
/* �и𿡼� 2010�� õ�� �߻��� �� ���� */
proc sql;
create table bj as
select distinct a.*
from bm as a left join a.t20_2010 as b
on a.person_id=b.person_id
where substr(b.main_sick,1,3) in ("J45","J46") 
		or substr(b.sub_sick,1,3) in ("J45","J46");
quit;
/*374*/
