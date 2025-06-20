--List all books with their authors' names.
select title,name
from books
inner join authors
on books.id=authors.id;
--Find all members who joined in the year 2024.
select join_date,name
from members
where extract(year from join_date)=2024;
--Display all books currently available for borrowing.
select title,book_id
from books
left join loans 
on books.id=loans.book_id
where return_date is not null;
--Get a list of members who have borrowed more than 3 books.
select member_id
from loans
inner join members 
on members.id=loans.member_id
group by member_id
having COUNT(member_id)>3;
--Find the most borrowed book.
SELECT book_id
FROM loans
GROUP BY book_id
ORDER BY count(book_id) DESC
LIMIT 1;
--List overdue loans (loaned more than 30 days ago and not yet returned).
select loan_date
from loans 
where loan_date<now()-interval'30 days'and return_date is null;
--Get the average number of books borrowed per member.
select avg(count_books),member_id
from 
(select count(book_id) as count_books
 from loans
 group by member_id
)sub;
--Find the top 3 most active members by total borrow count.
 select count(book_id) as count_books
 from loans
 group by member_id
order by count_books desc;
--Get the list of authors whose books have never been borrowed.
select * 
from authors a
where not exists (
select 1
from books b
join loans l
on b.id=l.book_id
where b.author_id=a.id
);
--List all movies and their combined sales in millions of dollars
select title, (domestic_sales + international_sales)/1000000 as combined_sales_millions
from movies
inner join boxoffice
On movies.id = boxoffice.movie_id;
--List all movies and their ratings in percent
select title,rating*10 as rating_percent
from movies
join boxoffice
on movies.id = boxoffice.movie_id;
--List all movies that were released on even number years
select title, year
from movies
where year%2 = 0;
--Find the longest time that an employee has been at the studio
select name,max(years_employed)
from employees;
--For each role, find the average number of years employed by employees in that role
select name,role,avg(years_employed)
from employees
group by role;
--Find the total number of employee years worked in each building 
select sum(years_employed) as total,building
from employees
group by building;
--Find the number of Artists in the studio (without a HAVING clause) 
select name,count(role)
from employees
where role="Artist";
--Find the number of Employees of each role in the studio
select count(role),role
from employees
group by role;
--Find the total number of years employed by all Engineers
select sum(years_employed)
from employees
where role="Engineer"
--Find the number of movies each director has directed 
select count(id),director
from boxoffice b
inner join movies m
on b.movie_id=m.id
group by director;
--Find the total domestic and international sales that can be attributed to each director
select sum(domestic_sales + international_sales),director
from boxoffice b
inner join movies m
on b.movie_id=m.id
group by director;
--Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)
insert into movies values ("4","Toy Story 4","John Lasseter","1999","90");
--The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
update movies
set director="John Lasseter"
where title="A Bug's Life";
--Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.
alter table movies
add Aspect_ratio float;
--Add another column named Language with a TEXT data type and set as default language english.
alter table movies
add Language text
default english;

