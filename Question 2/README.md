# Task Manager API

A complete CRUD API for task management, built with FastAPI and MySQL.

## Features

- User management (create, read, update, delete)
- Task management with user assignments
- Category management for task organization
- Full validation and error handling
- Pagination support

## Requirements

- Python 3.8+
- MySQL

## Setup Instructions

1. Set up your MySQL database:

```bash
mysql -u root -p < init_db.sql
```

2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Update database connection in `database.py` with your MySQL credentials.

4. Run the application:

```bash
uvicorn app.main:app --reload
```

5. Access the API documentation at: http://localhost:8000/docs

## API Endpoints

### Users

- `POST /users/` - Create a new user
- `GET /users/` - List all users
- `GET /users/{user_id}` - Get a specific user
- `PUT /users/{user_id}` - Update a user
- `DELETE /users/{user_id}` - Delete a user

### Categories

- `POST /categories/` - Create a new category
- `GET /categories/` - List all categories
- `GET /categories/{category_id}` - Get a specific category
- `PUT /categories/{category_id}` - Update a category
- `DELETE /categories/{category_id}` - Delete a category

### Tasks

- `POST /tasks/` - Create a new task
- `GET /tasks/` - List all tasks
- `GET /tasks/{task_id}` - Get a specific task
- `GET /users/{user_id}/tasks/` - Get all tasks for a specific user
- `PUT /tasks/{task_id}` - Update a task
- `DELETE /tasks/{task_id}` - Delete a task
