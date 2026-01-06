--SQL PROJECT - LIBRARY MANAGEMENT SYSTEM

--Q.13 FIND THE MEBERS WHO HAVE OVERDUE BOOK AND NO. OF DAYS OVERDUES
SELECT 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    rs.return_date,
    COALESCE(rs.return_date, CURRENT_DATE) - ist.issued_date AS overdue_days
FROM issued_status AS ist
JOIN members AS m
    ON m.member_id = ist.issued_member_id
JOIN books AS bk
    ON bk.isbn = ist.issued_book_isbn
LEFT JOIN return_status AS rs
    ON rs.issued_id = ist.issued_id
WHERE COALESCE(rs.return_date, CURRENT_DATE) - ist.issued_date > 30;

/*
Q.14UPDATE BOOK STATUS WHEN RETURN
WRITE A QUERY TO UPDATE THE STATUS
*/
SELECT 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    rs.return_date,
    COALESCE(rs.return_date, CURRENT_DATE) - ist.issued_date AS overdue_days
FROM issued_status AS ist
JOIN members AS m
    ON m.member_id = ist.issued_member_id
JOIN books AS bk
    ON bk.isbn = ist.issued_book_isbn
LEFT JOIN return_status AS rs
    ON rs.issued_id = ist.issued_id
WHERE COALESCE(rs.return_date, CURRENT_DATE) - ist.issued_date > 30;

--STOR PROCEDURE


CREATE OR REPLACE PROCEDURE add_return_record(
    p_return_id   VARCHAR(10),
    p_issued_id   VARCHAR(10),
    p_book_quality VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_isbn       VARCHAR(50);
    v_book_name  VARCHAR(100);
BEGIN
    -- 1️⃣ Insert return record
    INSERT INTO return_status (
        return_id,
        issued_id,
        return_date,
        book_quality
    )
    VALUES (
        p_return_id,
        p_issued_id,
        CURRENT_DATE,
        p_book_quality
    );

    -- 2️⃣ Get book details from issued_status
    SELECT
        issued_book_isbn,
        issued_book_name
    INTO
        v_isbn,
        v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id;

    -- 3️⃣ Update book status to available
    UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;

    -- 4️⃣ Confirmation message
    RAISE NOTICE 'Thank you for returning the book: %', v_book_name;

END;
$$;

/*
Q.15 BRANCH PERFORMANCE REPORT
CREATE A QUERY THAT GENERATE A PERFORMANCE REPORT FOR EACH BRANCH, SHOWING THE NUMBER OF BOOKS ISSUED, 
THE NUMBER OF BOOKS RETURNED , AND THE TOTAL REVENUE GENERATED FROM BOOK RENTALS
*/

CREATE TABLE branch_reports
AS
SELECT 
    b.branch_id,
	b.manager_id,
	COUNT(ist.issued_id) as number_book_issued,
	COUNT(rs.return_id) as number_of_book_return,
	SUM(bk.rental_price) as total_revenue
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
JOIN
books as bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1,2

--
SELECT * FROM branch_reports
--

--Q.16 CTAS: CREATE A TABLE OF ACTIVE MEMBRS
/*USE THE CREATE TABLE AS  (CTAS) STATEMENT A NEW TABLE ACTIVE_MEMBERS CONTAINING MEMBERS WHO HAVE ISSUED AT
LEAST ONE BOOK IN THE LAST MONTH
*/

SELECT * FROM issued_status

SELECT *
FROM issued_status
WHERE issued_date >= CURRENT_DATE - INTERVAL '36 months';
--all are older than 6 month

/*Q.17 FIND EMPLOYEES WITH THE MOST BOOK ISSUED PROCESSED
WRITE A QUERY TO FIND THE TOP 3 EMPLOYEES WHI=O HAVE PROCESSED THE MOST BOOK ISSUES.
DISPLAY THE EMPLOYESS NAME,NUMBER OF BOOKS PROCESSED, AND THEIR BRANCH
*/

SELECT 
     e.emp_name,
	 b.*,
	 COUNT(ist.issued_id) as no_book_issued 
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
GROUP BY 1,2

/*Q.18 CREATE A PROCEDURE TO MANAGE THE STATUS OF BOOKS IN A LIBRARY SYSTEM.
DESCRIPTION: WRITE A STORED PROCEDURE
THAT UPDTES THE STATUS OF A BOOK IN THE LIBRARY BASED ON ITS ISSUANCE.
THE PROCEDURE SHOULD FINCTION AS FOLLOWS: 
THE STORE PROCEDURE SHOULD TAKE THE BOOK_IID AS AN INPUT PARAMETER.
THE PROCEDURE SHOULD FIRST CHECK IS THE BOOK IS AVAILABLE (STATUS = 'YES'). 
IS THE BOOK IS AVAILABLE IT SHOULD BE ISSUED AND THE STATUS IN THE BOOKS TAABLE  SHOULD BE UPDATED TO 'NO'. 
IF THE BOOK IS CURRENTLY NOT AVAILABLE (STATUS = 'NO'), THE PROCEDURE SHOULD
RETURN AN ERROR MESSAGE INDICATING THAT THE BOOK IS CURRENTLY NOT AVAILABLE
*/
CREATE OR REPLACE PROCEDURE issue_book(
    p_issued_id VARCHAR(10),
    p_issued_member_id VARCHAR(30),
    p_issued_book_isbn VARCHAR(30),
    p_issued_emp_id VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status VARCHAR(10);
BEGIN
    -- Check if the book is available
    SELECT status
    INTO v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN

        -- Insert issued record
        INSERT INTO issued_status (
            issued_id,
            issued_member_id,
            issued_date,
            issued_book_isbn,
            issued_emp_id
        )
        VALUES (
            p_issued_id,
            p_issued_member_id,
            CURRENT_DATE,
            p_issued_book_isbn,
            p_issued_emp_id
        );

        -- Update book status
        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

        RAISE NOTICE 'Book issued successfully. ISBN: %', p_issued_book_isbn;

    ELSE
        RAISE NOTICE 'Sorry, the requested book is unavailable. ISBN: %', p_issued_book_isbn;
    END IF;

END;
$$;


SELECT * FROM books;
--'978-0-553-29698-2' -- YES
--'978-0-375-41398-8' -- NO

SELECT * FROM issued_status


CALL issue_book('IS155','C108','978-0-553-29698-2','E104');


CALL issue_book('IS156','C108','978-0-375-41398-8','E104');







