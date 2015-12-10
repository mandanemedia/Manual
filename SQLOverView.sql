-- SQL – Data Manipulation Language (DML)
-- List all the students who their last name are James.
select * 
from student
where lastname = 'James';
 
-- List all the students who their last name start with James.
select * 
from student
where lastname LIKE 'James%';
-- Character % means whatever that might come after without any length limitation, while, character _ instead means only a character. Additionally, like is a very inefficient command in the database.
 
-- List all the students that their last names are not entered.
select * 
from student
where lastname IS NULL;
 
-- List all the students who live in Toronto or Vancouver
select * 
from student 
where city ='toronto' or city ='vancouver';
-- Another way to write the above SQL command
select * 
from student 
where city IN ('toronto', 'vancouver');
 
-- List all the students, order them by their first names, and if first names are identical, then order them by last names.
select * 
from student 
order by firstname, lastname;
 
-- List the students’ ID in the takes table with no duplication in the student ID. (there might be a student that takes multiple courses)
select Distinct(studentID)
from take;
 
-- Aggregation functions
-- count(ID), sum(price), max(price), min(price), avg(price) are some of aggregation functions in the SQL.
-- List the total price of all products under category with ID 241.
select sum(price)
from product 
where productCategory = 241; 
 
-- List the average price of all products under category with ID 241.
select avg(price)
from product 
where productCategory = 241;
 
-- The aggregation function only returns one single value, if you want to combine aggregation with other fields to return multiple values, you need to use group by.
-- List the average price of each category.
select avg(price), productCategory 
from product 
group by productCategory;
 
-- List the average price of each category that the average price is higher than 100.
select avg(price) as avgPrice, productCategory 
from product 
group by productCategory
having avgPrice > 100;
 
-- Use Join in Relational Database
-- There are different kinds of joins in SQL, by default join is set to be inner join by most DataBase Management System (DBMS). An inner join only returns the records that found a match both of the tables involving in the inner join. As an illustration, if we have a person and contact tables, and there is a person that does not have a record in contact table, the inner join would not return that person.
select * 
from person
Inner Join contact On person.personID = contact.personID ;
 
-- The following figure illustrates all kinds of joins that could happen when joining two tables over each other.

-- List of students that take the course by the title of Database. (There are student, take and course tables.)
select * 
from (( student
Inner Join take On student.studentID = take.studentID )
Inner Join course On takes.courseID = course.courseID )
where course.courseTitle = ‘Database’;
-- Or could be written without brackets as follow
select * 
from student
Inner Join take On student.studentID = take.studentID
Inner Join course On takes.courseID = course.courseID 
where course.courseTitle = ‘Database’;
 
-- Insert, Update, and Delete
-- To create a new record in the student table:
Insert into student
(studentFirstName, studentLastName, studentAge)
values ('Danial','Javanmardi2', 21);
 
-- To update a record in the student table:
Update student
set studentEmail = 'info@mandanemedia.com', studentLastName = 'Javanmardi2'
where studentID = 11;
 
-- To delete a record in the student table:
Delete from student
where studentID = 11;
 
-- SQL – Data Definition Language (DDL)
Create student table
Create student
(studentID integer Primary Key,
studentFirstName varchar(30) NOT NULL,
studentLasttName varchar(30) NOT NULL,
age integer);
 
-- Change the attribute of student table
Alert table student
Add email varchar(150);
 
-- to delete a student table
Drop table student;
 
-- To delete all records in the student table
Truncate table student;

-- SQL – Data Control Language (DCL)
-- Giving permission to list records in the student table
Grant select 
On universityDatabase.student 
To danial;
 
-- Getting back the permission was give to list records in the student table
Revoke select 
On universityDatabase.student 
from danial;
 
-- Explicitly prevent a user from receiving special permission
Deny delete
On universityDatabase.student 
To webBrowser;

-- Indexing in Database
-- Create student table
Create student
(studentID integer Primary Key,
studentFirstName varchar(30) NOT NULL,
studentLasttName varchar(30) NOT NULL,
age integer);
 
-- Create clustered indexing on studentD
Create Clustered Index myfirstIndexing_name
On student (studentID ASC);
 
-- Create Non-clustered indexing on studentLastName
Create Nonclustered Index mySecondIndexing_name
On student (studentLasttName  ASC);
 
-- Store Procedure
Create Procedure avgPriceForEachProductCategory
select avg(price), productCategory 
from product 
group by productCategory
End;
 
-- Example from the 3rd form of normalization in this article.
-- Create a Store Procedure to list the total price as well as other attributes in the order table [ID, productID, quantity, unitPrice].
Create Procedure orderWithTotalPrice
select ID, productID, quantity, unitPrice, quantity*unitPrice as totalPrice 
from order
End;
 
-- Create a Store Procedure to list the students, their course, and the taken semester who got mark less than giveX for a particular course name.
Create Procedure studentwithMarkLessThanX
@givenX integer,
@sampleCourseName  varchar(30),
As
Begin
select studentID, studentFirstName, studentLastName, courseName, takenSemester
from student
inner join take on student.studentID = take.studentID
inner join course on takes.courseID = course.courseID
where take.mark &lt; @sampleX and course.courseName = @sampleCourseName
End;
 
-- The last simple step is how to call a Store Procedure:
call orderWithTotalPrice;
 
-- Nested SQL queries
-- There are times that you need multiple nested queries to get the list that you want.
List all employees who their salaries are bigger than the Jack’s salary.
select employeeName
from employee e1
where salary >
     ( select salary
from employee e2
       where employeeName = 'Jack' );
-- List all of the employees who their salaries are bigger than the salary of Jack, Steven, and Alex.
-- To simplify it, if we know the salary of each of them, we can write it as below.
select employeeName
from employee
where salary > All (6500, 60000, 75000);
-- And, how about if we do not aware their salaries. We need to revise the SQL commands to be a nested ones as below:
select e1.employeeName
from employee e1
where salary > All 
     ( select salary
from employee e2
       where e2.employeeName='Jack' or e2.employeeName='Steven' or e2.employeeName='Alex');
 
-- Increase the salaries of all of the employees by 20% who have worked in the company since 2012.
-- In this case, we need to break the question into smaller chunks, so list all the employees who have worked in the company since 2012. It is a simple select query as below.
select *
from employee
where employmentYear > 2011;
-- Also, we need to write query to update the salary of employee by 20%
update employee
set salary = salary*0.25;
-- Finally, we combine these two queries into a nested query as below:
update employee
set salary = salary * 0.25
where employeeID in 
( select employeeID 
  from employee e2
  where employmentYear > 2011 );
 
-- Copy all of the records from the employee to employee_backup table.
-- We have an employee table, and we create a new empty, identical table called employee_backup( with same structure).
insert into employee_backup
select * from employee
where employeeID in 
 		( select employeeID 
  from employee );

-- Difference between Any and All
-- The difference between Any(Some) and All in the nested query illustrated by example as below.
select employeeName
from employee
where salary > All (6500, 60000, 75000);
-- This equals to below statement:
select employeeName
from employee
where salary > 6500 and salary > 60000 and salary > 75000;
 
-- While for any instead of and we use or, as below.
select employeeName
from employee
where salary > Any (6500, 60000, 75000);
-- This equals to below statement:
select employeeName
from employee
where salary > 6500 or salary > 60000 or salary > 75000;
