--List all books with their authors' names.
select title,name
from books
inner join authors
on books.id=authors.id;


