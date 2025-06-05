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
--Get the average number of books borrowed per member.------
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

