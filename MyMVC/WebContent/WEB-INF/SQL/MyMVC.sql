show user;

create user mymvc_user identified by cclass;

grant connect, resource, create view, unlimited tablespace to mymvc_user;

show user;

create table tbl_main_image
(imgno           number not null
,imgfilename     varchar2(100) not null
,constraint PK_tbl_main_image primary key(imgno)
);

create sequence seq_main_image
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '미샤.png');  
insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '원더플레이스.png'); 
insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '레노보.png'); 
insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '동원.png'); 

commit;

select * 
from tbl_main_image
order by imgno asc;

drop table tbl_member;
drop table tbl_loginhistory;


create table tbl_member
(userid         varchar2(20) not null   
,pwd            varchar2(200) not null   --(SHA-256 암호화 대상)
,name           varchar2(30) not null  
,email          varchar2(200) not null   --(SHA-256 암호화/복호화 대상)
,mobile         varchar2(200)            --(SHA-256 암호화/복호화 대상)
,postcode       varchar2(5)
,address        varchar2(200)
,detailaddress  varchar2(200)
,extraaddress   varchar2(200)
,gender         varchar2(1)                -- 성별 남자:1 / 여자:2
,birthday       varchar2(10)
,coin           number default 0
,point          number default 0
,registerday    date default sysdate
,lastpwdchangeddate     date default sysdate
,status         number(1) default 1 not null         -- 회원탈퇴유무 1: 가입상태 / 0: 탈퇴
,idle           number(1) default 0 not null         -- 휴먼유무 1: 가입상태 / 0: 탈퇴
, constraint FK_tbl_member_userid primary key(userid)
, constraint UQ_tbl_member_email unique(email)
, constraint CK_tbl_member_gender check( gender in ('1', '2') )
, constraint CK_tbl_member_status check( status in (0, 1) )
, constraint CK_tbl_member_idle check( idle in (0, 1) )
)

select *
from tbl_member
where email = 'abc@abc.com';

delete from tbl_member;
commit;




create table tbl_loginhistory
( fk_userid varchar2(20) not null
, logindate date default sysdate not null
, clientip varchar2(20) not null
, constraint FK_tbl_loginhistory foreign key(fk_userid) REFERENCES tbl_member(userid)
);

select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender,
substr(birthday,1,4) as birthdayyyyy, substr(birthday,6,2) as birthdaymm, substr(birthday,9,2) as birthdaydd
, coin, point, to_char(registerday, 'yyyy-mm-dd') as registerday
, trunc(months_between(sysdate, lastpwdchangedate)) as pwdchangegap
from tbl_member
where status = 1 and userid = 'leess' and pwd = '';

update tbl_member set registerday = add_months(registerday, -4)
    , lastpwdchangeddate = add_months(lastpwdchangeddate, -4)
where userid = 'emojh';

select * from tbl_loginhistory;

update tbl_member set registerday = add_months(registerday, -13)
    , lastpwdchangeddate = add_months(lastpwdchangeddate, -13)
where userid = 'kangkc';

update tbl_loginhistory set logindate = add_months(logindate, -13)
where fk_userid = 'kangkc';

update tbl_member set registerday = add_months(registerday, -14)
    , lastpwdchangeddate = add_months(lastpwdchangeddate, -14)
where userid = 'yougs';

commit;

select max(logindate), trunc(months_between(sysdate, max(logindate))) as lastlogingap
from tbl_loginhistory
where fk_userid = 'leess';

--- 회원가입만하고서 로그인을 하지 않은 경우에는 tbl_loginhistory 테이블에 insert 되어진 정보가 없으므로 
--- 마지막으로 로그인한 날짜를 회원가입한 날짜로 보도록 한다.
select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthdayyyyy, birthdaymm
, birthdaydd, coin, point, registerday, pwdchangegap
, nvl(lastlogingap, trunc(months_between(sysdate, registerday))) as lastlogingap
from 
(select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender,
substr(birthday,1,4) as birthdayyyyy, substr(birthday,6,2) as birthdaymm, substr(birthday,9,2) as birthdaydd
, coin, point, to_char(registerday, 'yyyy-mm-dd') as registerday
, trunc(months_between(sysdate, lastpwdchangeddate)) as pwdchangegap
from tbl_member
where status = 1 and userid = 'yougs' and pwd = '18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5') M
cross join
(select trunc(months_between(sysdate, max(logindate))) as lastlogingap
from tbl_loginhistory
where fk_userid = 'yougs') H;

String sql = "select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthdayyyyy, birthdaymm\n"+
", birthdaydd, coin, point, registerday, pwdchangegap\n"+
", nvl(lastlogingap, trunc(months_between(sysdate, registerday))) as lastlogingap\n"+
"from \n"+
"(select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender,\n"+
"substr(birthday,1,4) as birthdayyyyy, substr(birthday,6,2) as birthdaymm, substr(birthday,9,2) as birthdaydd\n"+
", coin, point, to_char(registerday, 'yyyy-mm-dd') as registerday\n"+
", trunc(months_between(sysdate, lastpwdchangeddate)) as pwdchangegap\n"+
"from tbl_member\n"+
"where status = 1 and userid = 'yougs' and pwd = '18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5') M\n"+
"cross join\n"+
"(select trunc(months_between(sysdate, max(logindate))) as lastlogingap\n"+
"from tbl_loginhistory\n"+
"where fk_userid = 'yougs') H";