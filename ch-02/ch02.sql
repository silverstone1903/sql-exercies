-- list all tables --
SELECT * FROM sqlite_master where type='table'

-- check tables --
select * from Books limit 5;
SELECT * from Loans limit 5;
SELECT * FROM  Patrons limit 5;

-- check book availablity --
SELECT * FROM Books where Title LIKE 'Dra%';

SELECT  COUNT(Title) FROM Books where Title ="Dracula"; 
SELECT COUNT(Books.Title) FROM Loans join Books on Loans.BookID = Books.BookID  WHERE books.Title ="Dracula" AND loans.ReturnedDate is NULL ;
SELECT * FROM Loans join Books on Loans.BookID = Books.BookID  WHERE books.Title ="Dracula" AND loans.ReturnedDate is NULL ;

SELECT 
(SELECT  COUNT(Title) FROM Books where Title ="Dracula")
-
(SELECT COUNT(Books.Title) FROM Loans join Books on Loans.BookID = Books.BookID  WHERE books.Title ="Dracula" AND loans.ReturnedDate is NULL) as AvaliableBooks;

-- add new books to lib --
INSERT into Books 
(Title, Author, Published, Barcode)
values
("Dracula", "Bram Stoker", "1897", "4819277482"),
("Gulliver's Travels", "Jonathan Swift", "1729", "4899254401");
SELECT * FROM Books order by BookID DESC limit 3;

-- check out books --
INSERT into Loans 
(BookID, PatronID, LoanDate, DueDate)
values
((select BookID FROM Books where Barcode = "2855934983"),
(SELECT PatronID FROM Patrons where Email = "jvaan@wisdompets.com"),
"2020-08-25",
"2020-09-08");
INSERT into Loans
(BookID, PatronID, LoanDate, DueDate)
values
((select BookID from Books where Barcode= "4043822646"),
(SELECT PatronID from Patrons where Email = "jvaan@wisdompets.com"),
"2020-08-25",
"2020-09-08"

SELECT * FROM Loans order by LoanDate DESC;
);


-- check for books due back --

SELECT Loans.DueDate, Books.Title, Patrons.Email, Patrons.FirstName FROM Loans 
join Books on Loans.BookID = Books.BookID 
join Patrons on loans.PatronID  = Patrons.PatronID 
where Loans.DueDate = "2020-07-13" and Loans.ReturnedDate is NULL ;



-- return books to the library --

UPDATE Loans set ReturnedDate = (SELECT DATE("now") )
where BookID = (SELECT BookID from Books where Barcode = "8730298424")
and ReturnedDate is NULL;

SELECT * FROM Loans order by ReturnedDate DESC limit 1;

-- encourage patrons to check out books --

SELECT COUNT(Loans.LoanID) as loancount, Patrons.FirstName, patrons.Email from Loans 
join Patrons Patrons on loans.PatronID = Patrons.PatronID 
GROUP BY loans.PatronID 
order by loancount ASC ;


-- find books to feature for an event --
-- create a list of books from the 1890's that are currently available --

select Title, Author, Published FROM Books where Published > 1889 and Published <1900
order by Title;

select Books.Title, Books.BookID, Books.Author, Books.Published 
FROM Books 
join Loans on books.BookID  = Loans.BookID 
where Books.Published > 1889 and Books.Published <1900
and loans.ReturnedDate is not NULL 
order by Books.Title;


-- book statistics --
-- how many books were published each year --
-- top 5 books --
SELECT Published, COUNT(DISTINCT (Title))  FROM  Books;

SELECT Published, COUNT(DISTINCT (Title))  FROM  Books
group by Published ;

SELECT Published, COUNT(DISTINCT (Title)) as PublishCount  FROM  Books
group by Published
order by PublishCount DESC ;

SELECT COUNT(Loans.LoanID) as loanCount, Books.Title FROM Loans 
join Books on loans.BookID = books.BookID 
GROUP BY books.Title 
order by loanCount DESC limit 5;

SELECT COUNT(Loans.LoanID) as loanCount, Books.Title FROM Loans 
join Books on loans.BookID = books.BookID 
GROUP BY books.Title 
order by loanCount DESC;

