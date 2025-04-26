# Library Management System Database

## Overview
This SQL script creates and populates a database for a Library Management System. The database is designed to manage various aspects of a library, including members, books, authors, publishers, loans, reservations, and staff. It also includes data integrity constraints and sample data for testing purposes.

## Power Learn Project
This project is part of the "Power Learn Project" assignment for Week 8 Database.

## Features
- **Members Management**: Tracks library members, their contact details, membership status, and other relevant information.
- **Books and Authors**: Manages books, their authors, categories, and publishers.
- **Loans and Reservations**: Handles book loans, due dates, fines, and reservations.
- **Staff Management**: Maintains staff details and their roles.
- **Fine Payments**: Records payments made for overdue fines.

## Prerequisites
- A MySQL database server installed and running.
- A MySQL client or any database management tool to execute the script.

## How to Run the Script
1. Open your MySQL client or database management tool.
2. Copy the contents of the `Library Management System Database.sql` file.
3. Paste the script into the SQL editor of your tool.
4. Execute the script.

Alternatively, you can run the script directly from the command line:
```bash
mysql -u <username> -p < database_name> < Library Management System Database.sql
```
Replace `<username>` with your MySQL username and `<database_name>` with the name of the database you want to create.

## What the Script Does
1. **Database Creation**:
   - Creates a new database named `library_management` and switches to it.

2. **Table Creation**:
   - Creates tables for members, authors, publishers, categories, books, book items, loans, reservations, staff, and fine payments.
   - Includes constraints like primary keys, foreign keys, and checks to ensure data integrity.

3. **Sample Data Insertion**:
   - Populates the tables with sample data for testing and demonstration purposes.

## Table Details
### Members
- Tracks library members and their details.
- Includes fields like `first_name`, `last_name`, `email`, `phone`, `address`, `membership_date`, `membership_status`, and `date_of_birth`.

### Authors
- Stores information about book authors.
- Includes fields like `first_name`, `last_name`, `birth_year`, `death_year`, and `biography`.

### Publishers
- Manages publisher details.
- Includes fields like `name`, `address`, `phone`, `email`, and `website`.

### Categories
- Organizes books into categories and subcategories.
- Includes fields like `name`, `parent_category_id`, and `description`.

### Books
- Stores book details.
- Includes fields like `isbn`, `title`, `publisher_id`, `publication_year`, `edition`, `language`, `pages`, and `description`.

### Book_Authors
- Links books to their authors.
- Includes fields like `book_id`, `author_id`, and `role`.

### Book_Categories
- Links books to their categories.
- Includes fields like `book_id` and `category_id`.

### BookItems
- Tracks individual copies of books.
- Includes fields like `barcode`, `location`, `acquisition_date`, `status`, and `condition_note`.

### Loans
- Manages book loans.
- Includes fields like `item_id`, `member_id`, `loan_date`, `due_date`, `return_date`, and `fine_amount`.

### Reservations
- Handles book reservations.
- Includes fields like `book_id`, `member_id`, `reservation_date`, `expiry_date`, and `status`.

### Staff
- Stores staff details.
- Includes fields like `first_name`, `last_name`, `email`, `phone`, `role`, `hire_date`, and `salary`.

### FinePayments
- Records payments for overdue fines.
- Includes fields like `loan_id`, `payment_date`, `amount`, `payment_method`, and `staff_id`.

## Notes
- The script includes constraints to ensure data integrity, such as foreign keys, unique constraints, and check constraints.
- Sample data is provided for testing purposes and can be modified as needed.

## Troubleshooting
- Ensure that the MySQL server is running before executing the script.
- Check for any syntax errors or missing privileges if the script fails to execute.
- Verify that the MySQL user has sufficient privileges to create databases and tables.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Contributors
- Sydwell Lebeloane
