SELECT * FROM books

SELECT * FROM branch

SELECT * FROM issued_status

SELECT * FROM return_status


--QUESTIONS

--Q1. CREATE A NEW BOOK RECORD
 INSERT INTO books(isbn,book_title,category,rental_price,Status,author,publisher)
 VALUES
 ('1978-1-60129-456-2','TO KILL A MOCKINGBIRD','Classic',6.00,'yes','Harper Lee','J.B Lippincott & Co.');

SELECT * from books
--Q2. UPDATE A N EXISTING MEMBER ADDRESS FROM MEMBER TABLE

UPDATE members
SET member_address = '125- Main St'
WHERE member_id = 'C101';

SELECT * FROM members

--Q3.DELETE THE RECORS WHERE issued_id = IS107

DELETE FROM issued_status
WHERE  issued_id ='IS121'

SELECT * FROM issued_status

--Q4. RETRIEVE ALL BOOKS ISSUED BY A  EMPLOYEES ID='E101'

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'

--Q5.LIST MAMBER WHO HAVE ISSUED MORE THAN ONE BOOK -USE GROUP BY

SELECT 
   issued_emp_id,
   COUNT(issued_id) AS total_book_issued
FROM  issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) >1


--Q6.CREATE SUMMARY TABLE
CREATE TABLE bbok_counts
AS
SELECT 
    b.isbn,
	b.book_title,
	COUNT(ist.issued_id) AS no_issued
FROM books AS b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1,2


SELECT * FROM bbok_counts

--Q7.RETRIEVE ALL BOOK IN A SPECIFIC CATEGORY

SELECT * FROM books
WHERE category = 'Classic'

--Q8.FIND TOTAL RENTAL INCOM E BY EACH CATEGORY

SELECT 
   b.category,
   SUM(b.rental_price)
FROM books AS b
JOIN
issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1

--Q9.LIST MEMBERS WHO HAVE REGISTERED IN THE LAST 180 DAYS

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 DAYS'

INSERT INTO members (member_id, member_name, member_address, reg_date)
VALUES
('C118', 'sam', '145 Main st', '2024-06-01'),
('C119', 'adam', '123 Main st', '2024-05-01');


--Q10.LIST EMPLOYEES WIHTH BRANCH MANAGERS NAMES AND THEIR BRANCH

SELECT 
 e1.*,
 b.manager_id,
 e2.emp_name AS manager
FROM employees AS e1
JOIN 
branch AS b
ON b.branch_id = e1.branch_id
JOIN employees AS e2
ON b.manager_id = e2.emp_id

--Q11.CREATE A TABLE OF BOOKS WITH RENTAL PRICE ABOVE A CERTAIN THRESHOLD 7 USD:

CREATE TABLE books_price_greater_than_seven
AS
SELECT * FROM books
WHERE rental_price > 7


--Q12.RETIEVE THE BOOKS THAT ARE NOT RETURNED

SELECT DISTINCT ist.issued_book_name
FROM issued_status AS ist
LEFT JOIN return_status AS rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;

SELECT * FROM return_status

















































