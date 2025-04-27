# Power Learn Project - Week 8 Assignment

This repository contains two separate projects as part of the **Power Learn Project** Week 8 Database assignment. Each project demonstrates different aspects of database and API development.

---

## Project 1: Complete Database Management System

### Objective
Design and implement a full-featured relational database using MySQL.

### Structure
- **Folder**: `Question 1/`
- **File**: `Library Management System Database.sql`

### Instructions
1. The `.sql` file contains:
   - `CREATE TABLE` statements for a Library Management System.
   - Sample data for testing.
2. To run:
   - Import the `.sql` file into your MySQL database.
   - Use any MySQL client or the command line.

---

## Project 2: Simple CRUD API Using MySQL + FastAPI

### Objective
Build a CRUD API using FastAPI and MySQL.

### Structure
- **Folder**: `Question 2/`
- **Main Files**:
  - `app/`: Contains the FastAPI application code.
  - `init_db.sql`: SQL script to initialize the database.
  - `requirements.txt`: Lists dependencies.

### Instructions
1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
2. Initialize the database using `init_db.sql`.
3. Run the FastAPI application:
   ```bash
   uvicorn app.main:app --reload
   ```
4. Access the API documentation at `http://127.0.0.1:8000/docs`.

---

## Notes
- These projects are **separate** and should be run independently.
- Both projects are part of the **Power Learn Project** Week 8 assignment and were created for educational purposes.