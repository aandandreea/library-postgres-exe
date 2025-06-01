--List all books with their authors' names.
select title,name
from books
inner join authors
on books.id=authors.id;
--Find all members who joined in the year 2024.
select join_date,name
from members
where extract(year from join_date)=2024;


