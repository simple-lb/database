Use School
go

insert into STUDENTS values('700045678', 'LIMING', 'LX@cdemg.com', 1992)

select cid, count(cid) as cnt, max(score) as maxScore into COURSE1 from CHOICES group by cid 

create table COURSE2
(
	cid char(10),
	cnt int,
	maxScore int
);
insert into COURSE2 select cid, count(cid), max(score) from CHOICES group by cid

update STUDENTS set email = 'LM@qq.com' where sname = 'LiMing'

update TEACHERS set salary = salary * 2

update CHOICES set score = score + 10 where no = 
(select no from CHOICES, STUDENTS, COURSES 
where CHOICES.sid = STUDENTS.sid
and CHOICES.cid = COURSES.cid
and STUDENTS.sname = 'waqcj'
and COURSES.cname = 'C++')

delete from STUDENTS where sname = 'LiMing'

delete from CHOICES where cid =
(select cid from COURSES where cname = 'C')

delete from COURSES where hour > 80

create view t_view as
select * from TEACHERS where salary > 3000
with check option

select * from t_view where email = 'xibl@izd.edu'

insert into t_view values('199999998', 'abc', 'abc@def.com', 5000)

update t_view set salary = 6000 where tid = '200010493'

drop view t_view

exec sp_addlogin '张三', '123456', 'School'
exec sp_adduser '张三'

exec sp_dropuser '张三'
exec sp_droplogin '张三'

execute as user = '张三'
select SYSTEM_USER
select * from STUDENTS

revert select SYSTEM_USER
grant all privileges on STUDENTS to 张三
grant all privileges on CHOICES to 张三
grant all privileges on COURSES to 张三
grant all privileges on TEACHERS to 张三
execute as user = '张三'
select SYSTEM_USER
select * from STUDENTS

revert select SYSTEM_USER
print user
create view ch_view as
select * from CHOICES where cid = '10005'
select * from ch_view

grant insert on ch_view to 张三

grant all on ch_view(score) to 张三

execute as user = '张三'
select score from ch_view

revert select SYSTEM_USER
grant all on ch_view to 张三
execute as user = '张三'
select * from ch_view

update ch_view set score = 90 where no = '500127998'
select score from ch_view where no = '500127998'

revert select SYSTEM_USER
revoke select on ch_view from 张三
execute as user = '张三'
select * from ch_view

