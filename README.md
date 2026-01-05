# 📚 SQL Library Management System

This project demonstrates a **Library Management System** implemented using **SQL (PostgreSQL compatible)**. It focuses on performing real-world database operations such as inserting records, updating data, deleting records, joining multiple tables, aggregations, and analytical queries.

The queries simulate common library workflows like issuing books, returning books, tracking members, employees, branches, and calculating rental income.

---

## 🗂 Database Tables Used

* **books** – Stores book details such as ISBN, title, category, rental price, author, and publisher
* **members** – Contains library member information and registration dates
* **employees** – Stores employee and manager details
* **branch** – Holds branch and branch manager information
* **issued_status** – Tracks issued books
* **return_status** – Tracks returned books

---

## ✅ Key SQL Operations Covered

### 1️⃣ Insert Operations

* Add new books to the library
* Register new members

### 2️⃣ Update Operations

* Modify member address details

### 3️⃣ Delete Operations

* Remove issued records using `issued_id`

### 4️⃣ Filtering & Retrieval

* Fetch books by category
* Retrieve books issued by a specific employee
* List members registered in the last 180 days

### 5️⃣ Joins & Relationships

* Join issued and return tables to track pending returns
* Retrieve employees along with their branch managers

### 6️⃣ Aggregations & Grouping

* Count books issued per employee
* Calculate total rental income by category

### 7️⃣ Analytical Queries

* Identify books that are **issued but not returned**
* Find members who issued more than one book

### 8️⃣ Table Creation from Queries

* Create summary tables using `CREATE TABLE AS`
* Store book issue counts
* Create price-based book tables

---

## 📌 Sample Business Questions Answered

* Which books are currently not returned?
* How much rental income is generated per category?
* Which members are active recently?
* Which employees issued the most books?
* Which books are issued most frequently?

---

## 🛠 SQL Concepts Used

* `SELECT`, `INSERT`, `UPDATE`, `DELETE`
* `JOIN` (INNER JOIN, LEFT JOIN)
* `GROUP BY` and `HAVING`
* `DISTINCT`
* Date filtering using `INTERVAL`
* `CREATE TABLE AS`
* Aliases for readability

---

## 🎯 Learning Outcomes

* Strong understanding of **relational database design**
* Practical experience with **real-world SQL queries**
* Improved confidence in **joins and aggregations**
* Ability to translate **business requirements into SQL queries**

---

## 🚀 Use Case

This project is ideal for:

* SQL interviews
* Data Analyst / Data Scientist portfolios
* Learning PostgreSQL fundamentals
* Demonstrating CRUD and analytical SQL skills

---

## 📎 Notes

* Queries are compatible with **PostgreSQL**
* Each query is written in a clean and readable format
* Best executed one statement at a time in pgAdmin or psql

---

⭐ If you are a recruiter or reviewer, this project highlights practical SQL skills commonly used in production systems.
