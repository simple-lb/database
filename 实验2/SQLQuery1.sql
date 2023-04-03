select sname from STUDENTS where grade = 2001 order by sid asc

select score, (score - 60) * 0.1 + 1 as jf from CHOICES where score >= 60

select * from TEACHERS

select cname from COURSES where hour = 48 or hour = 64

select cname from COURSES where cname like '%data%'

select distinct cid from COURSES

select avg(salary) from TEACHERS

select TEACHERS.tid , avg(score) as avgScore
from TEACHERS left join CHOICES on TEACHERS.tid = CHOICES.tid 
group by TEACHERS.tid
order by avgScore desc

select count (*) as num ,avg(score) as avgScore
from CHOICES join COURSES on CHOICES.cid=COURSES.cid
group by COURSES.cid

select sid from CHOICES
group by sid having count(*) >= 3

select cname, score from CHOICES join COURSES on CHOICES.cid = COURSES.cid where sid = '800009026'

select sid from CHOICES join COURSES on CHOICES.cid = COURSES.cid where cname = 'database' 

select count(*) from CHOICES group by cid

select cid from CHOICES group by cid having count(*) >= 2

select cid, sid from CHOICES where cid in 
(select cid from CHOICES where sid = '800009026')
order by cid asc

select * from STUDENTS join CHOICES on STUDENTS.sid = CHOICES.sid order by STUDENTS.sid asc

select sname, cname, score from 
STUDENTS left join CHOICES on STUDENTS.sid = CHOICES.sid
left join COURSES on CHOICES.cid = COURSES.cid
where STUDENTS.sid = '850955252'

select * from STUDENTS where grade in
(select grade from STUDENTS where sid = '850955252')

select * from STUDENTS where sid in
(select sid from CHOICES)

select cid from COURSES where cid not in (select cid from CHOICES)

select distinct sname from STUDENTS where sid in
(select sid from CHOICES where cid in
(select cid from COURSES where hour in
(select hour from COURSES where cname = 'C++')))

select top 1 * from CHOICES order by score desc

select cname from COURSES where hour in
(select hour from COURSES where cname = 'UML' or cname = 'C++')

select sname from STUDENTS where sid in
(select sid from CHOICES where cid = '10001')

select sname from STUDENTS where not exists
(select * from COURSES where not exists
(select * from CHOICES where sid = STUDENTS.sid and cid = COURSES.cid))

select sid from CHOICES where cid in
(select cid from COURSES where cname = 'Java')
union
select sid from CHOICES where cid in
(select cid from COURSES where cname = 'C++')

select sid from CHOICES where cid in
(select cid from COURSES where cname = 'Java')
intersect
select sid from CHOICES where cid in
(select cid from COURSES where cname = 'C++')

select sid from CHOICES where cid in
(select cid from COURSES where cname = 'C++')
except
select sid from CHOICES where cid in
(select cid from COURSES where cname = 'Java')






select score * 0.05 from CHOICES

select count(sid) as num from CHOICES where cid = '10028'
select count(sid) as num from CHOICES where cid = '10028' and score >= 60
select count(sid) as num from CHOICES where cid = '10028' and score < 60

select * from CHOICES where cid = '10001' order by score desc

select distinct score, cid from CHOICES where cid = '10001' order by score desc

select count(sid) as num, score from CHOICES group by score

select sid, count(cid) as 总选课数, avg(score) as 平均分, max(score) as 最高成绩, min(score) as 最低成绩
from CHOICES group by sid

select count(*) as 总记录, avg(score) as 平均分, max(score) as 最高分, min(score) as 最低分
from CHOICES where score < 60

select * from COURSES where hour <= all(select hour from COURSES)

create table S(
    NO CHAR(10) PRIMARY KEY,
	SID CHAR(20),
	SNAME CHAR(20)
);
create table T(
	NO CHAR(10) PRIMARY KEY,
	TID CHAR(20),
	TNAME CHAR(20)
);
insert into S values('1','0129871001','王小明');
insert into S values('2','0129871002','李兰');
insert into S values('3','0129871005',NULL);
insert into S values('4','0129871004','关红');
insert into T values('1','100189','王小明');
insert into T values('2','100180','李小');
insert into T values('3','100121',NULL);
insert into T values('4','100128',NULL);
select * from T;
select * from S;
select S.NO as Sno, T.NO as Tno from S, T where S.SNAME = T.TNAME;







