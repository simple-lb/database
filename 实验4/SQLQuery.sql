use school
--4.1(1)
drop table Stu_Union
create table Stu_Union(
sno char(5) not null unique,
sname char(8),
ssex char(5),
sage int,
sdept char(20),
constraint  P1  primary key(sno) );
insert into Stu_Union values ( '0001','Wang','ÄÐ',20,'CS');
select * from Stu_Union
update Stu_Union SET sno='2' where sdept='CS'
select * from Stu_Union

--4.1(2)
insert into Stu_Union values( '2','Li','ÄÐ',20,'CS')
select * from Stu_Union

--4.1(3)
update Stu_Union  set sno= null where sno='2'
select * from Stu_Union

--4.1(4)
select * from  Stu_Union
set xact_abort on
begin transaction T1
insert into Stu_Union values ( '0003','W','ÄÐ',50,'CS')
select * from  Stu_Union
insert into Stu_Union values ( '0003','W','ÄÐ',50,'CS')


select * from  Stu_Union

--4.1(5)
drop table Scholarship
create table Scholarship
(
    sid char(8),
	money int
)
insert into Scholarship values ('1',500);
insert into Scholarship values (null,600);
select * from Scholarship
alter table Scholarship add constraint P2 primary key(sid)
alter table Scholarship add constraint P3 foreign key(sid) 
   references Stu_Union(sname)

--4.2(1)
drop table Course
create table Course (
  cno char(5) not null unique,
  cname varchar(20) not null,
  cpoints int,
  constraint P4 primary key (cno));  
insert into Stu_Union values ( '10001','ÍõÇ¿','Å®',10,'AA')
insert Course values ('0001','computer',2);
insert Course values ('0002','database',3);
select * from Stu_Union
select * from Course


--4.2(2)
drop table sc
create table sc(
sno char(5) references Stu_Union (sno) on delete cascade,
cno char(5) references course(cno) on delete cascade,
grade int,
constraint p6 primary key (sno,cno)
);

insert into sc values ('10001','0001',2);
insert into sc values ('10001','0002',2);
select * from stu_union
select * from sc





--4.2(3)
insert into sc values('55','55',99)
select * from sc 


--4.2(4)
delete from Stu_Union where sno='10001'
select * from stu_union
select * from sc 

--4.2(5)
delete from Course where cno='0001'
select * from Course
select * from sc 

--4.2(6)
insert into Stu_Union values ( '0004','00','ÄÐ',20,'CS');
insert into Stu_Union values ( '0002','11','ÄÐ',20,'CS');
insert into Stu_Union values ( '0003','22','ÄÐ',20,'CS');
insert Course values ('0003','computer',2);
insert Course values ('0002','database',3);
select * from Stu_union
select * from course
drop table Stu_Card
create table Stu_Card(
       card_id char(14),
       stu_id char (5) references stu_union(sno) 
	   on delete cascade,
       remained_money decimal (10,2),
       constraint P7 primary key (card_id)
)
insert into  Stu_Card values ( '05212567','0002',100.25);
insert into  Stu_Card values ( '05212222','0003',200.50); 
select * from Stu_card;  



--4.2(7)
drop table ICBC_Card
create table ICBC_Card(
       bank_id char(20),
       stu_card_id char (14),
	   constraint P10 foreign key (stu_card_id) 
		references Stu_card(card_id) on delete cascade,
       restored_money decimal (10,2),
       constraint P8 Primary key (bank_id)
)
insert into  ICBC_Card values ( '9558844022312','05212567',15000.1);
insert into  ICBC_Card values ( '9558844023645','05212222',50000.3); 
select * from ICBC_Card; 



--4.2(8)
select * from Stu_card; 
select * from ICBC_Card;
delete from Stu_Union where sno = '0002'
select * from Stu_card; 
select * from ICBC_Card; 

--4.2(9)
Alter table ICBC_Card
   drop constraint P10;
Alter table ICBC_Card
   add constraint P9 foreign key (stu_card_id) 
   references Stu_card(card_id) on delete no action ; 
select * from stu_card;
select * from icbc_card;
Begin Transaction del
delete from stu_union where sno='0003';
Commit Transaction del 
select * from stu_union
select * from stu_card;
select * from icbc_card; 


--4.2(10)
create table listen_course (
    teacher_id char(5),tname varchar(20),course_id char(5)
    constraint P10 primary key(teacher_id)
)
create table teach_course(
    course_id char(5),cname varchar(30),teacher_id char(5)
    constraint P12 primary key(course_id)
    constraint P13 foreign key(teacher_id) 
    references listen_course(teacher_id)
) 
alter table listen_course
      add constraint P11 foreign key(course_id) 
      references teach_course(course_id); 


--4.3(1)
drop table sc
create table sc(
sno char(5) ,
cno char(5) ,
grade int);
insert into sc values ('0001','0001',2);
insert into sc values ('10001','0001',2);
insert into sc values ('10001','0002',2);
Sp_helptrigger sc
create trigger T5  on sc
for insert as update sc set grade=60
from sc,inserted  where sc.sno=inserted.sno 
	and sc.cno=inserted.sno and inserted.grade<60
select * from sc
insert into sc values('02','02',2)
select * from sc  

--4.3(2)
create trigger T2 on stu_union
for update as if update(Sno) begin
update sc set sc.sno=i.sno 
from sc,inserted i,deleted d
 where sc.sno=d.sno 
end 
select * from stu_union
select * from sc
update stu_union set sno = '999' where sno='0002' 
select * from stu_union
select * from sc    

--4.3(3)
create trigger T3 on stu_union 
for delete as
delete sc from sc,deleted d
where sc.sno=d.sno 
select * from stu_union
select * from sc   
delete from stu_union where sno='0001'
select * from stu_union
select * from sc   

--4.3(4)
Sp_helptrigger stu_union 
drop trigger T3
Sp_helptrigger stu_union 


--4.4(1)
alter table choices drop constraint FK_CHOICES_STUDENTS
alter table students drop constraint PK_STUDENTS

create clustered index SN on students(sname) 
create index GD on students(grade)


--4.4(2)
set statistics TIME on;
set statistics IO on;
set statistics profile on;
--A
select count(*) from choices where cid='10010'
--B
create index CID on choices(cid)
select count(*) from choices where cid='10010'



--4.4(3)A
select count(*) from choices where sid = '823069829'

--4.4(3)B
create index SID on choices(sid)
select count(*) from choices where sid = '823069829'

--4.4(3)C
drop index SID on choices;
alter table choices drop constraint PK_CHOICES;
create clustered index SID on choices(sid)
select count(*) from choices where sid = '823069829'
