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


