1
declare @sum int
declare @i int
set @sum=0
set @i=1
while(@i<=100)
begin
	set @sum=@sum+@i
	set @i=@i+1
end
if @@ERROR = 0
print @sum
else
print 'error'

2
update STUDENTS set email = 'ddff@sina.com'
where sid = '876543210'
if @@ROWCOUNT = 0
print '警告！没有数据被更新'

3
if exists(select * from STUDENTS where sid = '800007595')
begin
	select score from CHOICES where sid = '800007595'
end
else
	print '查无此人'

4
declare @sum int
declare @i int
set @sum=0
set @i=1
while(@i<=100)
begin
	set @sum=@sum+@i
	set @i=@i+1
end
print @sum

5
select
	case
		when score >= 80 then '优秀'
		when score < 80 and score >= 60 then '及格'
		when score < 60 then '不及格'
	end
from CHOICES where sid = '800007595' and cid = '10044'

6create proc GetStInfo(@Sno char(5))as begin 	Declare @Cno char(5),@Grade int,@CInfo varchar(255);	Declare SCCursor Cursor for select Cno,Grade from 	SC  where Sno= @Sno;	open SCCursor;	Fetch Next from SCCursor into @Cno,@Grade;			while(@@Fetch_Status=0) begin		if (@Grade>80)begin			update sc set grade=80  where cno = @Cno			if(@@ROWCOUNT>0)				set @CInfo='update'		end		else if (@Grade<60) begin			update sc set grade=60  where cno = @Cno			if(@@ROWCOUNT>0)				set @CInfo='update'		end		else			set @CInfo ='no update'		Fetch Next from SCCursor into @Cno,@Grade;	end;  	close SCCursor;deallocate SCCursor;			if (@@ERROR>0)	set @CInfo='error'			print @CInfoend;select *from scexecute GetStInfo'10001'7alter proc GetEmail(@sid char(10))as begin 	Declare @cname char(30),@cid char(10),@Email varchar(255);	Declare SCCursor Cursor for select  CHOICES.cid ,cname from 	CHOICES join COURSES on CHOICES.cid=COURSES.cid where sid=@sid;	set @Email= (select top(1) email from STUDENTS where sid=@sid );	set @Email=UPPER(@Email);	print @Email;	open SCCursor;	Fetch Next from SCCursor into @cid,@cname;			while(@@Fetch_Status=0) begin		set @cname = substring(@cname,1,3)		print @cname;	Fetch Next from SCCursor into @cid,@cname;	end;  	close SCCursor;deallocate SCCursor;end;execute GetEmail '800007595'select *from CHOICES join  COURSES on CHOICES.cid=COURSES.cid where sid='800007595'8.8.1创建函数：create function AvgScore(@sid char(10))returns intasbegindeclare @avgscore intselect @avgscore = (select AVG(score) from CHOICES where sid =@sid)return @avgscoreend执行函数：print dbo.AvgScore('826310502');8.2创建函数：create function query(@sname char(30))returns tableasreturn (select COURSES.cname,CHOICES.scorefrom COURSES,CHOICESwhere CHOICES.sid = (select sid from STUDENTS where sname =@sname)and COURSES.cid = CHOICES .cid)执行函数：select * from query('kk');8.3创建函数：create function CourseQuery(@cname char(10))returns @NameAndScore table(sname char(30),score int)asbegininsert @NameAndScore select STUDENTS.sname,CHOICES.scorefrom STUDENTS,CHOICES,COURSESwhere COURSES.cname=@cnameand COURSES.cid=CHOICES.cid and CHOICES.sid=STUDENTS.sidreturnend执行函数：select * from CourseQuery('c');9declare @cname char(30)declare @score intdeclare printCnameAndScore cursorforselect COURSES.cname,CHOICES.scorefrom COURSES,CHOICESwhere CHOICES.sid = '800007595' and COURSES.cid = CHOICES.cidopen printCnameAndScorefetch next from printCnameAndScore into @cname,@scorewhile @@FETCH_STATUS = 0begin	print 'cname:'+@cname	print @score	fetch next from printCnameAndScore into @cname,@scoreendclose printCnameAndScoredeallocate printCnameAndScoreselect cid,score from choices where sid='800007595'order by score descdeclare @no intdeclare @score intdeclare @i intset @i = 1declare updateSecondScore cursorforselect no,scorefrom CHOICESwhere CHOICES.sid = '800007595'order by score desc;open updateSecondScorefetch next from updateSecondScore into @no,@scorewhile @@FETCH_STATUS = 0beginif @i = 2update CHOICES set score = 75 where no = @nofetch next from updateSecondScore into @no,@scoreset @i = @i + 1endclose updateSecondScoredeallocate updateSecondScorecreate table Test(no char(5),value char(10));insert into Testvalues('10001','abc'),('10002','abc'),('10003','def');select * from Testdeclare @no char(5)declare @value char(10)declare deleteValue cursorforselect * from Test;open deleteValuefetch next from deleteValue into @no,@valuewhile @@FETCH_STATUS = 0begin	if @no = '10002'		delete from Test where no = @no	fetch next from deleteValue into @no,@valueendclose deleteValuedeallocate deleteValue