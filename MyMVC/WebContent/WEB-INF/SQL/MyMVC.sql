show user;

select employee_id, first_name || ' ' || last_name AS ename,
       nvl( (salary + salary*commission_pct)*12 ,  salary*12) AS yearpay,
       case when substr(jubun,7,1) in ('1','3') then '남' else '여' end AS gender,
       extract(year from sysdate) - ( case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end + to_number(substr(jubun,1,2)) ) + 1 AS age        
from employees
order by 1;

SELECT * FROM tbl_product
;
delete FROM tbl_adproduct;

update tbl_adproduct(fk_prod
uctcode)
values('PF-105-001');

commit; 
select seq, fk_userid, name, subject  
            , readcount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
       from tbl_board
       where status = 1
       order by seq desc

delete from tbl_cart where cartno = 294;
select * from tbl_member;

delete from tbl_member where userno = 2011145556

      select previousseq, previoussubject
           , seq, fk_userid, name, subject, content, readCount, regDate
           , nextseq, nextsubject
      from 
      (
          select  lag(seq,1) over(order by seq desc) AS previousseq 
                , lag(subject,1) over(order by seq desc) AS previoussubject
                  
                 , seq, fk_userid, name, subject, content, readCount
                 , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate
          
                 , lead(seq,1) over(order by seq desc) AS nextseq 
                 , lead(subject,1) over(order by seq desc) AS nextsubject
          from tbl_board
          where status = 1
      ) V 
      where V.seq =6  



update tbl_product
set fk_kindcode = ?,
    enproductname = ?,
    krproductname = ?,
    productimg1 = ?,
    productimg2 = ?,
    price = ?,
    saleprice = ?,
    origin = ?,
    productdescshort = ?,
    manufacturedate = ?,
    expiredate = ?,
    productdesc1 = ?,
    productdesc2 = ?,
    ingredient = ?,
    precautions = ?
where productcode = ?

rollback;

insert into TBL_ADPRODUCT(fk_productcode) values ('13');

SELECT * FROM tbl_product;
select * from TBL_ADPRODUCT;
select * from tbl_product;
select * from tbl_category;
select * from tbl_option;


truncate table TBL_LOGINHISTORY;


YEG4i6ctlCET9LlMb7PPi5kdwurfLW3jzTKLWhV6LGs



commit;
delete from tbl_member
where name = '%김민성%';

RGeSdTNMw/jSEA9nfXgg0wugy+nsDN1uqdJE7Sd8JnQ=

update tbl_member set password = 'qwer' where email = 'RGeSdTNMw/jSEA9nfXgg0wugy+nsDN1uqdJE7Sd8JnQ=';

select * from tbl_member;

delete from tbl_member
where name = '김민성7';

commit;

delete from KOY_tbl_cart_test
where FK_USERID = '1' and FK_PNUM = 1;

rollback;
commit;

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

create table kms_tbl_loginhistory
( fk_userno number(8)
, logindate date default sysdate not null
, clientip varchar2(20) not null
, constraint FK_kms_tbl_loginhistory foreign key(fk_userno) REFERENCES tbl_member(userno)
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



-- 검색이 (있는 or 없는) 총 회원수를 알아오기
select ceil( count(*) / '10' )
from tbl_member
where userid != 'admin'
and name like '%'||'홍승의'||'%'


SELECT userno, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, 
birthday, taste, point, registerday, pwdchangegap,
nvl(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap 
FROM 
(
select userno, name, email, mobile, postcode, address, detailaddress, extraaddress, gender 
     , birthday, taste, point
     , to_char(registerday, 'yyyy-mm-dd') AS registerday 
     , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap 
from tbl_member 
where status = 1 and email = 'user@gmail.com' and password = '18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5'
) M 
CROSS JOIN
(
select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap 
from KMS_TBL_LOGINHISTORY 
where fk_userno = ? 
) H
-----------------------------------------------
select userno, name, email, mobile, postcode, address, detailaddress, extraaddress
, gender, birthday, taste, point, registerday, lastpwdchangedate, status, idle
, trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap
, nvl(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap
from tbl_member
where status = 1 and email = 'RGeSdTNMw/jSEA9nfXgg0wugy+nsDN1uqdJE7Sd8JnQ=' and password = '18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5'

select * from tbl_member
where name = '김민성';








select * from KMS_TBL_LOGINHISTORY

String sql = "SELECT userno, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, \n"+
"birthday, taste, point, registerday, pwdchangegap,\n"+
"nvl(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap \n"+
"FROM \n"+
"(\n"+
"select userno, name, email, mobile, postcode, address, detailaddress, extraaddress, gender \n"+
"     , birthday, taste, point\n"+
"     , to_char(registerday, 'yyyy-mm-dd') AS registerday \n"+
"     , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap \n"+
"from tbl_member \n"+
"where status = 1 and email = 'user@gmail.com' and password = '18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5'\n"+
") M \n"+
"CROSS JOIN\n"+
"(\n"+
"select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap \n"+
"from tbl_loginhistory \n"+
"where fk_userid = ? \n"+
") H"

select * from tbl_member;

update tbl_member set idle = 1 
where email = 'alstjddl8@naver.com'

rollback;

select userno from tbl_member where email = 'RGeSdTNMw/jSEA9nfXgg0wugy+nsDN1uqdJE7Sd8JnQ=';

delete from tbl_member
where userid = 'hongse53';

commit;

select * from row_number

select snum, sname from tbl_spec order by snum asc;

-----------------------------------------------
select count(*)
from tbl_product
where fk_snum = 1;

select count(*)
from tbl_product
where fk_snum = ( select snum from tbl_spec where sname = 'HIT' );


select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point,
pinputdate from ( select row_number() over(order by pnum asc) AS RNO , 
pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point ,
to_char(pinputdate, 'yyyy-mm-dd') as pinputdate
from tbl_product P JOIN tbl_category C ON P.fk_cnum = C.cnum JOIN tbl_spec S ON P.fk_snum = S.snum 
where S.sname = 'HIT' ) V where RNO between 33 and 40;

String sql = "select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point,\n"+
"pinputdate from ( select row_number() over(order by pnum asc) AS RNO , \n"+
"pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point ,\n"+
"to_char(pinputdate, 'yyyy-mm-dd') as pinputdate\n"+
"from tbl_product P JOIN tbl_category C ON P.fk_cnum = C.cnum JOIN tbl_spec S ON P.fk_snum = S.snum \n"+
"where S.sname = 'HIT' ) V where RNO between 33 and 40";



SELECT cartno, fk_productcode, krproductname, productimg1, c.pprice, poqty
						 FROM TBL_PRODUCT P RIGHT JOIN tbl_cart c
						 ON p.productcode = c.fk_productcode
						 WHERE fk_userno = '2011132457'
                         

select *
rom tbl_product
order by pnum desc;

-- 채번하기
select seq_tbl_product_pnum.nextval
from dual;

select * from tbl_product
where pnum = 117
commit;

delete from tbl_product
where pnum = 119

select * from tbl_shipping_test where ship_seq = 4;
delete from tbl_shipping_test where ship_seq = 4;


create table tbl_purchase_reviews (review_seq number 
,fk_userid varchar2(20) not null -- 사용자ID 
,fk_pnum number(8) not null -- 제품번호(foreign key) 
,contents varchar2(4000) not null 
,writeDate date default sysdate
,constraint PK_purchase_reviews primary key(review_seq)
,constraint FK_purchase_reviews_userid foreign key(fk_userid) references tbl_member(userid) 
,constraint FK_purchase_reviews_pnum foreign key(fk_pnum) references tbl_product(pnum) );

create sequence seq_purchase_reviews start with 1 increment by 1 nomaxvalue nominvalue nocycle nocache;

select * from tbl_purchase_reviews order by review_seq desc;

select review_seq, name, fk_pnum, contents, to_char(writeDate, 'yyyy-mm-dd hh24:mi:ss') AS writeDate from tbl_purchase_reviews R join tbl_member M on R.fk_userid = M.userid where R.fk_pnum = 3 order by review_seq desc;


select * from TBL_MEMBER;

update tbl_member set password = '1234' where email = 'EkosdIU2YH31RZXPVhGtpL+CeLX4hdrhn+6o+6r/qgA=';

desc tbl_member;

create table tbl_product_like
(fk_userid varchar2(20) not null,
fk_pnum     number(8) not null,
constraint PK_tbl_product_like primary key(fk_userid, fk_pnum),
constraint PK_tbl_product_like_userid foreign key(fk_userid) references tbl_member(userid),
constraint PK_tbl_product_like_pnum foreign key(fk_pnum) references tbl_product(pnum)
);


create table tbl_product_dislike
(fk_userid varchar2(20) not null,
fk_pnum     number(8) not null,
constraint PK_tbl_product_dislike primary key(fk_userid, fk_pnum),
constraint PK_tbl_product_dislike_userid foreign key(fk_userid) references tbl_member(userid),
constraint PK_tbl_product_dislike_pnum foreign key(fk_pnum) references tbl_product(pnum)
);


select *
from tbl_product_like;

delete from tbl_product_dislike where fk_userid = 'kms' and fk_pnum =58;
insert into tbl_product_like(fk_userid, fk_pnum) values ('kms', 58);
commit;

select * from tbl_product_like;
select * from tbl_member;



delete from tbl_product_dislike where fk_userid = 'kms' and fk_pnum =58;
insert into tbl_product_dislike(fk_userid, fk_pnum) values ('kms', 58);
commit;



select count(*) from tbl_product_like
where fk_pnum = 58;                                                                                                 

select count(*) from tbl_product_dislike
where fk_pnum = 58;

select count(*) from tbl_product_like
where fk_pnum = 58; 



select (select count(*)
        from tbl_product_like
        where fk_pnum = 58
        ) as LIKECNT,
        (select count(*)
        from tbl_product_dislike
        where fk_pnum = 58
        ) as DISLIKECNT
from dual;







String sql = "select (select count(*)\n"+
"        from tbl_product_like\n"+
"        where fk_pnum = 58\n"+
"        ) as LIKECNT,\n"+
"        (select count(*)\n"+
"        from tbl_product_dislike\n"+
"        where fk_pnum = 58\n"+
"        ) as DISLIKECNT\n"+
"from dual";

select * from tbl_category

update tbl_category set encategoryname = ?,
                        krcategoryname = ?
                    where 
                    
                    
                    
select * from tbl_member;
                    
                    
                    
select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
     , birthyyyy, birthmm, birthdd, coin, point, registerday, pwdchangegap
     ,nvl( lastlogingap, trunc( months_between(sysdate, registerday) )) as lastlogingap
from
(
select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
     , substr(birthday,1,4) as birthyyyy, substr(birthday,6,2) as birthmm, substr(birthday,9) as birthdd
     , coin, point, to_char(registerday,'yyyy-mm-dd') as registerday
     , trunc( months_between(sysdate, lastpwdchangeddate) ) as pwdchangegap
from tbl_member
where status = 1 and userid = 'leess' and pwd = '18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5' 
) M 
cross join 
(
select trunc( months_between(sysdate, max(logindate)) ) as lastlogingap 
from tbl_loginhistory 
where fk_userid = 'leess'
) H;




    ------- **** 게시판(답변글쓰기가 없고, 파일첨부도 없는) 글쓰기 **** -------
desc tbl_member;

create table tbl_board
(seq         number                not null    -- 글번호
,fk_userid   varchar2(20)          not null    -- 사용자ID
,name        varchar2(20)          not null    -- 글쓴이 
,subject     Nvarchar2(200)        not null    -- 글제목
,content     Nvarchar2(2000)       not null    -- 글내용   -- clob (최대 4GB까지 허용) 
,pw          varchar2(20)          not null    -- 글암호
,readCount   number default 0      not null    -- 글조회수
,regDate     date default sysdate  not null    -- 글쓴시간
,status      number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,constraint PK_tbl_board_seq primary key(seq)
,constraint FK_tbl_board_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_board_status check( status in(0,1) )
);

create sequence boardSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_board
order by seq desc;

select * from tbl_member

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
       values(boardSeq.nextval, 'kms', '123', 'test', 'test', 'test', default, default, default) 

rollback

select * from tbl_product

SELECT * FROM   ALL_CONSTRAINTS
WHERE TABLE_NAME = tbl_product;

SELECT * FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'tbl_product';




update tbl_product
set price = 1000,
    saleprice = 1000,
    origin = 'test',
    productdescshort = 'test',
    manufacturedate = '2020-11-01',
    expiredate = '2020-11-01',
    productdesc1 = 'test',
    productdesc2 ='test',
    ingredient = 'test',
    precautions = 'test'
where productcode = 'PF-101-001';

rollback;

------------------------------------------------------------------------
   ----- **** 댓글 게시판 **** -----

/* 
  댓글쓰기(tblComment 테이블)를 성공하면 원게시물(tblBoard 테이블)에
  댓글의 갯수(1씩 증가)를 알려주는 컬럼 commentCount 을 추가하겠다. 
*/

drop table tbl_board purge;

create table tbl_board
(seq         number                not null    -- 글번호
,fk_userid   varchar2(20)          not null    -- 사용자ID
,name        varchar2(20)          not null    -- 글쓴이 
,subject     Nvarchar2(200)        not null    -- 글제목
,content     Nvarchar2(2000)       not null    -- 글내용   -- clob (최대 4GB까지 허용) 
,pw          varchar2(20)          not null    -- 글암호
,readCount   number default 0      not null    -- 글조회수
,regDate     date default sysdate  not null    -- 글쓴시간
,status      number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,commentCount number default 1 not null
,constraint PK_tbl_board_seq primary key(seq)
,constraint FK_tbl_board_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_board_status check( status in(0,1) )
);

drop sequence commentSeq;

----- **** 댓글 테이블 생성 **** -----
create table tbl_comment
(seq           number               not null   -- 댓글번호
,fk_userid     varchar2(20)         not null   -- 사용자ID
,name          varchar2(20)         not null   -- 성명
,content       varchar2(1000)       not null   -- 댓글내용
,regDate       date default sysdate not null   -- 작성일자
,parentSeq     number               not null   -- 원게시물 글번호
,status        number(1) default 1  not null   -- 글삭제여부
                                               -- 1 : 사용가능한 글,  0 : 삭제된 글
                                               -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_tbl_comment_seq primary key(seq)
,constraint FK_tbl_comment_userid foreign key(fk_userid)
                                    references tbl_member(userid)
,constraint FK_tbl_comment_parentSeq foreign key(parentSeq) 
                                      references tbl_board(seq) on delete cascade
,constraint CK_tbl_comment_status check( status in(1,0) ) 
);

create sequence commentSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_comment
order by seq desc;

-- 회원들이 게시판에 글쓰기를 하면 글작성 1건당 point를 100점 준다.
-- 회원들이 게시판에 댓글쓰기를 하면 글작성 1건당 point를 50점 준다.
-- but point 300점 초과 금지

-- tbl_member 테이블의 point 컬럼에 check 제약을 추가한다

alter table tbl_member
add constraint CK_tbl_member_point check(point between 0 and 300);

select *  from tbl_product;

update tbl_member set point = 0
where userid = 'kms';

commit

    select name, content, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
            from tbl_comment
            where status = 1 and parentSeq = 2
            
            
            
            
            
insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'kms', '김민성', '즐거운 하루', '늘 행복하게', '1234', default, default, default);


insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'admin', '관리자', '오늘도 즐거운 수업', '기분 좋은', '1234', default, default, default);


insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'kms', '김민성', '기분 좋은 날', '반갑습니다', '1234', default, default, default);


insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'kms', '김민성', '모두 즐거이 퇴근', '건강이 최고', '1234', default, default, default);

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'admin', '관리자', 'java가 재밌나요', '궁금합니다 java가 뭔지', '1234', default, default, default);

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'kms', '김민성', 'JAVA가 재밌나요', '궁금합니다 java가 뭔지', '1234', default, default, default);

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'admin', '관리자', 'jsp란 ?', '웹 페이지를 작성하려고 합니다', '1234', default, default, default);

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'kms', '김민성', 'KOREA VS JAPAN 축구 대결', '많은 시청 바랍니다', '1234', default, default, default);

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'kms', '김민성', '추가1', '추가1', '1234', default, default, default);

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'kms', '김민성', '추가2', '추가2', '1234', default, default, default);

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
values(boardSeq.nextval, 'kms', '김민성', '추가3', '추가3', '1234', default, default, default);

commit

select * from tbl_board
order by seq desc
----------------------------------------------------------------------
select seq, fk_userid, name, subject  
    , readcount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
    , commentCount
from tbl_board
where status = 1 and lower(subject) like '%'||'ja'||'%'
order by seq desc
----------------------------------------------------------------------
select subject 
from tbl_board
where status = 1 and lower(subject) like '%'||'ja'||'%'
order by seq desc;
-----------------------------------------------------------------------
select seq, fk_userid, name, subject, readCount, regDate, commentCount
from
(
select row_number() over(order by seq desc) as rno
        , seq, fk_userid, name, subject, readCount
        , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
        , commentCount
from tbl_board
where status = 1
and lower(name) like '%' || lower('김민성') || '%'
) v
where rno between 1 and 10

select * from tbl_product;

select subject
		from tbl_board
		where status = 1
		and lower(subject) like '%'|| lower('ja') ||'%'
		order by seq des
        c
        
        
        
select first_value(sum(totalprice)) over(), fk_userno
    from tbl_payment
    where (to_char(sysdate, 'yy-mm') = to_char(paymentdate, 'yy-mm'))
    group by fk_userno
    order by sum(totalprice)
    
    
    
    
    
    
select * from tbl_board;
    
    
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '셋번째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '넷째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '다섯번째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '여섯째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '일곱째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '여덣째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '아홉째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '열째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '열한번째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '열두번째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '열세번째 댓글', 6);
insert into tbl_comment(seq, fk_userid, name, content, parentseq)
values(commentSeq.nextVal, 'kms', '김민성', '열네번째 댓글', 6);

commit;

select * from tbl_comment;
------------------------------------------ 댓글 페이징 처리
select name, content, regDate
from
(
select row_number() over(order by seq desc) as rno
, name, content, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate  
from tbl_comment
where status = 1 and parentseq = 6
) v
where rno between 1 and 5;
------------------------------------------
select * from tbl_member;

select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
		     , birthyyyy, birthmm, birthdd, coin, point, registerday, pwdchangegap
		     , nvl( lastlogingap, trunc( months_between(sysdate, registerday) )) as lastlogingap
		from
		(
		select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
		     , substr(birthday,1,4) as birthyyyy, substr(birthday,6,2) as birthmm, substr(birthday,9) as birthdd
		     , coin, point, to_char(registerday,'yyyy-mm-dd') as registerday
		     , trunc( months_between(sysdate, lastpwdchangedate) ) as pwdchangegap
		from tbl_member
		where status = 1 and userid = #{userid} and pwd = #{pwd} 
		) M 
		cross join 
		(
		select trunc( months_between(sysdate, max(logindate)) ) as lastlogingap 
		from tbl_loginhistory 
		where fk_userid = #{userid} 
		) H;

-----------------------------------------------
    ----- ******* 댓글 및 답변글 및 파일 첨부가 있는 게시판 ******* ----- 

drop table tbl_comment purge;
drop sequence commentSeq;
drop table tbl_board purge;
drop sequence boardSeq;

create table tbl_board
(seq         number                not null    -- 글번호
,fk_userid   varchar2(20)          not null    -- 사용자ID
,name        varchar2(20)          not null    -- 글쓴이 
,subject     Nvarchar2(200)        not null    -- 글제목
,content     Nvarchar2(2000)       not null    -- 글내용   -- clob (최대 4GB까지 허용) 
,pw          varchar2(20)          not null    -- 글암호
,readCount   number default 0      not null    -- 글조회수
,regDate     date default sysdate  not null    -- 글쓴시간
,status      number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,commentCount number(1) default 1 not null
,groupno        number                not null   -- 답변글쓰기에 있어서 그룹번호 
                                                 -- 원글(부모글)과 답변글은 동일한 groupno 를 가진다.
                                                 -- 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.

,fk_seq         number default 0      not null   -- fk_seq 컬럼은 절대로 foreign key가 아니다.!!!!!!
                                                 -- fk_seq 컬럼은 자신의 글(답변글)에 있어서 
                                                 -- 원글(부모글)이 누구인지에 대한 정보값이다.
                                                 -- 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
                                                 -- 원글(부모글)의 seq 컬럼의 값을 가지게 되며,
                                                 -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.

,depthno        number default 0       not null  -- 답변글쓰기에 있어서 답변글 이라면
                                                 -- 원글(부모글)의 depthno + 1 을 가지게 되며,
                                                 -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.

,fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)                                       
,orgFilename    varchar2(255)                    -- 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명 
,fileSize       number                           -- 파일크기  

,constraint PK_tbl_board_seq primary key(seq)
,constraint FK_tbl_board_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_board_status check( status in(0,1) )
);

create sequence boardSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create table tbl_comment
(seq           number               not null   -- 댓글번호
,fk_userid     varchar2(20)         not null   -- 사용자ID
,name          varchar2(20)         not null   -- 성명
,content       varchar2(1000)       not null   -- 댓글내용
,regDate       date default sysdate not null   -- 작성일자
,parentSeq     number               not null   -- 원게시물 글번호
,status        number(1) default 1  not null   -- 글삭제여부
                                               -- 1 : 사용가능한 글,  0 : 삭제된 글
                                               -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_tbl_comment_seq primary key(seq)
,constraint FK_tbl_comment_userid foreign key(fk_userid)
                                    references tbl_member(userid)
,constraint FK_tbl_comment_parentSeq foreign key(parentSeq) 
                                      references tbl_board(seq) on delete cascade
,constraint CK_tbl_comment_status check( status in(1,0) ) 
);

create sequence commentSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
        
desc tbl_board;

delete from tbl_board;
commit;


begin
    for i in 1..100 loop
        insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status, groupno)
        values(boardSeq.nextval, 'leess', '이순신', '이순신 입니다'||i, '안녕하세요? 이순신'|| i ||' 입니다.', '1234', default, default, default, i);
    end loop;
end;

        
begin
    for i in 101..200 loop
        insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status, groupno)
        values(boardSeq.nextval, 'kms', '김민성', '김민성 입니다'||i, '안녕하세요? 김민성'|| i ||' 입니다.', '1234', default, default, default, i);
    end loop;
end;     

select *
from tbl_board
order by seq desc;

---- ***** 답변글쓰기는 일반회원은 불가하고 직원(관리자)들만 답변글쓰기가 가능하도록 한다 ***** -----
select *
from tbl_member

-- tbl_member 테이블에 gradelevel이라는 칼럼을 추가하겠다
alter table tbl_member
add gradelevel number default 1;

-- *** 직원(관리자)들에게는 gradelevel 값을 10으로 부여하겠다. gradelevel 컬럼의 값이 10인 직원들만 답변글쓰기가 가능하다. *** --
update tbl_member set gradelevel = 10
where userid in ('admin', 'kms');

commit;

--- *** 글번호 197에 대한 답변글쓰기를 한다라면 아래와 같이 insert를 해야 한다 *** ---
select *
from tbl_board where seq = 197;

insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status, groupno, fk_seq, depthno)
values (boardSeq.nextval, 'admin', '관리자', '글번호 197에 대한 답변글입니다.', '답변내용 입니다. 행복하세요', '1234', default, default, default, 197, 197, 1);

commit;


----- *** 답변글이 있을시 글목록 보여주기 *** -----
select *
from tbl_board
order by seq desc;

select seq, fk_userid, name, subject, readCount, regDate, commentCount,
        groupno, fk_seq, depthno
from
(
select rownum as rno,
        seq, fk_userid, name, subject, readCount, regDate, commentCount,
        groupno, fk_seq, depthno
from 
(
select 
       seq, fk_userid, name, subject, readCount, 
       to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate,
       commentCount, 
       groupno, fk_seq, depthno
from tbl_board
where status = 1 
start with fk_seq = 0
connect by prior seq = fk_seq
order siblings by groupno desc, seq asc
) V 
) T
where rno between 1 and 10;


select * from tbl_loginhistory 
delete from tbl_member where name = '김민성'
commit
delete from tbl_loginhistory where fk_userno = '2011232971'


-- tbl_member 테이블에 존재하는 제약조건 조회하기 -- 
select * 
from user_constraints
where table_name = 'TBL_MEMBER';

alter table tbl_member
drop constraint CK_TBL_MEMBER_POINT;


select * from tbl_board;