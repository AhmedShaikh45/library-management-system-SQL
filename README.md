# 📚 SQL Library Management System Project

This project demonstrates a **complete Library Management System** implemented using **PostgreSQL SQL & PL/pgSQL**. It covers real-world database operations, analytical queries, and stored procedures commonly asked in **SQL interviews, exams, and data roles**.

The project is divided into **SQL Queries (Q1–Q13)** and **Stored Procedures (Q14–Q15)**, each solving a practical business problem with clear explanations.

---

## 🗂 Database Tables Used

* **books** – Book details, availability status, rental price
* **members** – Library members and registration dates
* **employees** – Employees and managers
* **branch** – Branch and branch manager mapping
* **issued_status** – Issued book transactions
* **return_status** – Returned book transactions

---

## ❓ Questions, Queries & Explanations (Q1–Q18)

Each question below includes the **exact SQL query** so you can **directly copy and run it**, followed by a short explanation.

---

### Q1. Create a New Book Record

```sql
INSERT INTO books (isbn, book_title, category, rental_price, status, author, publisher)
VALUES ('1978-1-60129-456-2', 'TO KILL A MOCKINGBIRD', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B Lippincott & Co.');
```

**Explanation:** Inserts a new book into the library catalog.

---

### Q2. Update an Existing Member Address

```sql
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
```

**Explanation:** Updates address details for a specific member.

---

### Q3. Delete an Issued Record

```sql
DELETE FROM issued_status
WHERE issued_id = 'IS121';
```

**Explanation:** Deletes an issued transaction using its ID.

---

### Q4. Retrieve All Books Issued by a Specific Employee

```sql
SELECT *
FROM issued_status
WHERE issued_emp_id = 'E101';
```

**Explanation:** Fetches all books issued by employee E101.

---

### Q5. List Members Who Issued More Than One Book

```sql
SELECT issued_member_id, COUNT(issued_id) AS total_books
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(issued_id) > 1;
```

**Explanation:** Uses aggregation to identify active members.

---

### Q6. Create a Summary Table of Book Issue Counts

```sql
CREATE TABLE book_counts AS
SELECT b.isbn, b.book_title, COUNT(i.issued_id) AS no_issued
FROM books b
JOIN issued_status i ON i.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;
```

**Explanation:** Stores book popularity data in a new table.

---

### Q7. Retrieve All Books in a Specific Category

```sql
SELECT *
FROM books
WHERE category = 'Classic';
```

**Explanation:** Filters books by category.

---

### Q8. Find Total Rental Income by Each Category

```sql
SELECT b.category, SUM(b.rental_price) AS total_income
FROM books b
JOIN issued_status i ON i.issued_book_isbn = b.isbn
GROUP BY b.category;
```

**Explanation:** Calculates rental income per category.

---

### Q9. List Members Registered in the Last 180 Days

```sql
SELECT *
FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';
```

**Explanation:** Identifies recently registered members.

---

### Q10. Retrieve Employees with Their Branch Managers

```sql
SELECT e.emp_name, b.branch_id, m.emp_name AS manager_name
FROM employees e
JOIN branch b ON b.branch_id = e.branch_id
JOIN employees m ON m.emp_id = b.manager_id;
```

**Explanation:** Displays employee–manager hierarchy.

---

### Q11. Create a Table of Books with Rental Price Above $7

```sql
CREATE TABLE books_price_above_seven AS
SELECT *
FROM books
WHERE rental_price > 7;
```

**Explanation:** Creates a premium-books table.

---

### Q12. Retrieve Books That Are Not Returned

```sql
SELECT DISTINCT i.issued_book_name
FROM issued_status i
LEFT JOIN return_status r ON r.issued_id = i.issued_id
WHERE r.return_id IS NULL;
```

**Explanation:** Finds books still pending return.

---

### Q13. Find Members with Overdue Books (30-Day Rule)

```sql
SELECT i.issued_member_id, m.member_name, b.book_title,
       COALESCE(r.return_date, CURRENT_DATE) - i.issued_date AS overdue_days
FROM issued_status i
JOIN members m ON m.member_id = i.issued_member_id
JOIN books b ON b.isbn = i.issued_book_isbn
LEFT JOIN return_status r ON r.issued_id = i.issued_id
WHERE COALESCE(r.return_date, CURRENT_DATE) - i.issued_date > 30;
```

**Explanation:** Calculates overdue days for late returns.

---

### Q14. Stored Procedure – Add Return Record

```sql
CALL add_return_record('R101', 'IS121', 'Good');
```

**Explanation:** Automates book return and updates availability.

---

### Q15. Stored Procedure – Issue Book

```sql
CALL issue_book('IS130', 'C101', '1978-1-60129-456-2', 'E101');
```

**Explanation:** Issues a book only if it is available.

---

### Q16. Retrieve Issued Records from Last 6 Months

```sql
SELECT *
FROM issued_status
WHERE issued_date >= CURRENT_DATE - INTERVAL '6 months';
```

**Explanation:** Filters recent issue transactions.

---

### Q17. Retrieve Issued Books with Member & Return Details

```sql
SELECT *
FROM issued_status i
JOIN members m ON m.member_id = i.issued_member_id
JOIN books b ON b.isbn = i.issued_book_isbn
LEFT JOIN return_status r ON r.issued_id = i.issued_id;
```

**Explanation:** Full issued-book report with member and return data.

---

### Q18. Count Total Books Issued by Each Employee

```sql
SELECT issued_emp_id, COUNT(issued_id) AS total_issued
FROM issued_status
GROUP BY issued_emp_id;
```

**Explanation:** Measures employee activity.

---

⭐ This project reflects production-level SQL thinking and practical database design skills.
