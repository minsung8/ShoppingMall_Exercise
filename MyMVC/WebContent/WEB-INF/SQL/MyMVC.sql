show user;

SELECT * FROM tabs;
select * from KOY_tbl_cart_test;

delete from KOY_tbl_cart_test
where FK_USERID = '1' and FK_PNUM = 1;

rollback;

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

select * from
tbl_member;

--- 오라클에서 프로시저를 사용하여 회원을 대량으로 입력(insert)하겠습니다. ---
select * 
from user_constraints
where table_name = 'TBL_MEMBER';

alter table tbl_member
drop constraint UQ_TBL_MEMBER_EMAIL;  -- 이메일을 대량으로 넣기 위해서 어쩔수 없이 email 에 대한 unique 제약을 없애도록 한다. 

select * 
from user_constraints
where table_name = 'TBL_MEMBER';

select *
from user_indexes
where table_name = 'TBL_MEMBER';

drop index UQ_TBL_MEMBER_EMAIL;

select *
from user_indexes
where table_name = 'TBL_MEMBER';

delete from tbl_member 
where name like '홍승의%' or name like '아이유%';

commit;

select * from tbl_member;

create or replace procedure pcd_member_insert 
(p_userid  IN  varchar2
,p_name    IN  varchar2
,p_gender  IN  char)
is
begin
     for i in 1..100 loop
         insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday) 
         values(p_userid||i, '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', p_name||i, 'oWufVBEfzY5HkYGPcH5CMfjKjxtCUTP5bDlgKIAJOug=' , 'c5TbkMv3Bk7viPixbC8fwA==', '15864', '경기 군포시 오금로 15-17', '102동 9004호', ' (금정동)', p_gender, '1991-01-27');
     end loop;
end pcd_member_insert;
-- Procedure PCD_MEMBER_INSERT이(가) 컴파일되었습니다.


exec pcd_member_insert('hongse','홍승의','1');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
commit;

exec pcd_member_insert('iyou','아이유','2');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
commit;


select * 
from tbl_member;


select userid, name, email, gender 
from tbl_member 
where userid != 'admin'
order by registerday desc;

-- == 페이징 처리를 위한 SQL문 작성하기 == --
select rownum, userid, name, email, gender
from tbl_member
where userid != 'admin'
and rownum between 1 and 3

-- 1 page
select rno, userid, name, email, gender
from 
(
    select rownum as rno, userid, name, email, gender
    from 
    (
        select userid, name, email, gender
        from tbl_member
        where userid != 'admin'
        and name like '%'||'승의'||'%'
        order by registerday desc
    ) V 
) T
where T.rno between 1 and 3;

-- 2 page
select rno, userid, name, email, gender
from 
(
    select rownum as rno, userid, name, email, gender
    from 
    (
        select userid, name, email, gender
        from tbl_member
        where userid != 'admin'
        order by registerday desc
    ) V 
) T
where T.rno between 4 and 6;
/*
    currentShowPageNo = 2
    sizePerPage = 3
    
    currentShowPageNo * sizePerPage - (sizePerPage - 1) ==> 4
    currentShowPageNo * sizePerPage ==> 6
*/









String sql = "select rno, userid, name, email, gender\n"+
"from \n"+
"(\n"+
"    select rownum as rno, userid, name, email, gender\n"+
"    from \n"+
"    (\n"+
"        select userid, name, email, gender\n"+
"        from tbl_member\n"+
"        where userid != 'admin'\n"+
"        and name like '%'||'승의'||'%'\n"+
"        order by registerday desc\n"+
"    ) V \n"+
") T\n"+
"where T.rno between 1 and 3";