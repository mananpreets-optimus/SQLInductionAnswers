--61 RANK

select TOP(5) *,DENSE_RANK() OVER (ORDER BY SALARY desc) 
FROM employees;
--

--62 common table expression
WITH T(ID,TEAM_NAME,SALARY)
AS
(
SELECT employees.employee_id,EMPLOYEE_SLAB.TEAM_NAME,employees.salary from employees inner join EMPLOYEE_SLAB
ON EMPLOYEE_SLAB.EMPLOYEE_ID=employees.employee_id
)
SELECT * FROM T 
WHERE SALARY>5000;

--63 

select last_name,salary from employees group by last_name,salary with rollup; 
--
select last_name,salary from employees group by last_name,salary with cube; 

--64
select EMPLOYEE_NO from ABC WHERE EMPLOYEE_NO<3 INTERSECT select EMPLOYEE_NO from XYZ WHERE EMPLOYEE_NO<3 ; 
--
select EMPLOYEE_NO from ABC WHERE EMPLOYEE_NO<3 EXCEPT select EMPLOYEE_NO from XYZ WHERE EMPLOYEE_NO<3 ; 

--65 Corelated subqueries

SELECT MAX(salary) FROM employees
WHERE salary NOT IN (SELECT MAX(salary) FROM employees );

--66 Running aggregate

select *, (Select Sum(salary) from employees b where b.employee_id<a.employee_id) As Running_total
from employees a
order by employee_id;

--68 cluster index

CREATE CLUSTERED INDEX myIndex ON employees (employee_id);

--69 NON CLUSTERED INDEX

CREATE NONCLUSTERED INDEX myIndex ON employees (employee_id);

--70 Triggers

--create table employee_salary
create table employee_salary
(
emp_id int,
basic_salary int,
hra int,
da int,
gross_salary int
);

create Trigger trig_1
on dbo.employee_salary
for insert 
as

declare @empid int
declare @hra int
declare @da int
declare @bas_sal int
declare @gross_sal int

select @empid=i.emp_id from inserted i
select @bas_sal=i.basic_salary from inserted i
select @hra=i.hra from inserted i
select @da=i.da from inserted i
set @gross_sal=(@hra+@da+@bas_sal)*12

Update employee_salary
set gross_salary=@gross_sal

Go

--Insert values in employee_salary table
insert into employee_salary(emp_id,basic_salary,hra,da)
values(123,1234,234,345); 

--
SELECT * FROM employee_salary;


--71 cuscors
declare @emp_id int
declare @bas_sal int
declare @hra int
declare @da int
declare @gross_sal int
declare @cursor1 cursor
set @cursor1= cursor
FOR
select emp_id, basic_salary,hra,da 
from employee_salary
open @cursor1
Fetch next from @cursor1
into @emp_id,@bas_sal,@hra,@da
while @@FETCH_STATUS=0
Begin

set @gross_sal=(@bas_sal+@hra+@da)*12
Update employee_salary
set gross_salary=@gross_sal
where emp_id=@emp_id

Fetch next from @cursor1
end
close @cursor1
deallocate @cursor1

select * from employee_salary;

--73 Functions

CREATE FUNCTION YEAR_S()
returns date
begin
return ()
create table year_s
(yr varchar(50));
CREATE FUNCTION year_fn()
RETURNS varchar
BEGIN
 
RETURN(SELECT yr
        FROM dbo.year_s
               WHERE yr> 0 )
END

--74 PROCEDURE


CREATE PROCEDURE PROCE
(@INPUT INT
)
AS
BEGIN
select * from employees where employee_id=@INPUT
END

--75 PROCEDURE WITH EXCEPTION HANDLING


CREATE PROCEDURE NEW_ROC
(
@INPUT INT

)
AS
BEGIN TRY
     INSERT INTO employees(employee_id,first_name)
     VALUES(76, 'Abhijit')
END TRY
BEGIN CATCH
   SELECT 'There was an error while  Inserting records in DB '
END CATCH