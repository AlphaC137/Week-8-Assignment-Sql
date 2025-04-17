-- Drop database if it already exists (for clean setup)
DROP DATABASE IF EXISTS library_management;

-- Create database
CREATE DATABASE library_management;
USE library_management;

-- Create Members table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    membership_date DATE NOT NULL,
    membership_status ENUM('Active', 'Expired', 'Suspended') NOT NULL DEFAULT 'Active',
    date_of_birth DATE,
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Create Authors table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year INT,
    death_year INT,
    biography TEXT,
    CONSTRAINT chk_death_year CHECK (death_year IS NULL OR death_year > birth_year)
);

-- Create Publishers table
CREATE TABLE Publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(100)
);

-- Create Categories table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    parent_category_id INT,
    description TEXT,
    FOREIGN KEY (parent_category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

-- Create Books table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    publication_year INT,
    edition VARCHAR(20),
    language VARCHAR(50) DEFAULT 'English',
    pages INT,
    description TEXT,
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id) ON DELETE SET NULL
);

-- Create Book_Authors table
CREATE TABLE Book_Authors (
    book_id INT,
    author_id INT,
    role ENUM('Primary', 'Co-author', 'Editor', 'Translator') DEFAULT 'Primary',
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Create Book_Categories table
CREATE TABLE Book_Categories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

-- Create BookItems table
CREATE TABLE BookItems (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    barcode VARCHAR(50) UNIQUE NOT NULL,
    location VARCHAR(50) NOT NULL,
    acquisition_date DATE,
    status ENUM('Available', 'Loaned', 'Reserved', 'Lost', 'Under Repair') NOT NULL DEFAULT 'Available',
    condition_note TEXT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Create Loans table
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    fine_paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (item_id) REFERENCES BookItems(item_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    CONSTRAINT chk_dates CHECK (return_date IS NULL OR return_date >= loan_date)
);

-- Create Reservations table
CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    reservation_date DATETIME NOT NULL,
    expiry_date DATETIME NOT NULL,
    status ENUM('Pending', 'Fulfilled', 'Cancelled', 'Expired') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE,
    CONSTRAINT chk_reservation_dates CHECK (expiry_date > reservation_date)
);

-- Create Staff table
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    role ENUM('Librarian', 'Assistant', 'Admin', 'IT Support') NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    CONSTRAINT chk_staff_email CHECK (email LIKE '%@%.%')
);

-- Create FinePayments table
CREATE TABLE FinePayments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash', 'Credit Card', 'Debit Card', 'Online') NOT NULL,
    staff_id INT,
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE SET NULL
);

-- Insert Members
INSERT INTO Members (first_name, last_name, email, phone, address, membership_date, membership_status, date_of_birth)
VALUES 
('John', 'Smith', 'john.smith@email.com', '555-123-4567', '123 Main St, Anytown', '2023-01-15', 'Active', '1985-06-12'),
('Emily', 'Johnson', 'emily.j@email.com', '555-234-5678', '456 Oak Ave, Somecity', '2023-02-20', 'Active', '1992-09-25'),
('Michael', 'Williams', 'michael.w@email.com', '555-345-6789', '789 Pine Rd, Otherville', '2023-03-10', 'Active', '1978-11-30'),
('Sarah', 'Brown', 'sarah.b@email.com', '555-456-7890', '101 Elm St, Somewhere', '2023-01-05', 'Expired', '1990-04-18'),
('David', 'Jones', 'david.j@email.com', '555-567-8901', '202 Maple Dr, Nowhere', '2023-04-25', 'Active', '1982-07-22');

-- Insert Authors
INSERT INTO Authors (first_name, last_name, birth_year, death_year, biography)
VALUES 
('Jane', 'Austen', 1775, 1817, 'English novelist known for works of romantic fiction'),
('George', 'Orwell', 1903, 1950, 'English novelist, essayist, and critic'),
('J.K.', 'Rowling', 1965, NULL, 'British author best known for the Harry Potter series'),
('Ernest', 'Hemingway', 1899, 1961, 'American novelist and short story writer'),
('Agatha', 'Christie', 1890, 1976, 'English writer known for detective novels');

-- Insert Publishers
INSERT INTO Publishers (name, address, phone, email, website)
VALUES 
('Penguin Random House', '1745 Broadway, New York, NY', '212-782-9000', 'info@penguinrandomhouse.com', 'www.penguinrandomhouse.com'),
('HarperCollins', '195 Broadway, New York, NY', '212-207-7000', 'info@harpercollins.com', 'www.harpercollins.com'),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY', '212-698-7000', 'info@simonandschuster.com', 'www.simonandschuster.com'),
('Scholastic', '557 Broadway, New York, NY', '212-343-6100', 'info@scholastic.com', 'www.scholastic.com'),
('Oxford University Press', 'Great Clarendon St, Oxford, UK', '+44-1865-353535', 'info@oup.com', 'www.oup.com');

-- Insert Categories
INSERT INTO Categories (name, parent_category_id, description)
VALUES 
('Fiction', NULL, 'Literary works created from the imagination'),
('Non-Fiction', NULL, 'Based on facts, real events, and real people'),
('Science Fiction', 1, 'Fiction dealing with futuristic concepts like space travel, time travel, etc.'),
('Mystery', 1, 'Fiction dealing with solving a puzzle or crime'),
('Biography', 2, 'A detailed description of a person''s life'),
('History', 2, 'Study of past events'),
('Fantasy', 1, 'Fiction with supernatural elements'),
('Romance', 1, 'Fiction focusing on relationship and romantic love');

-- Insert Books
INSERT INTO Books (isbn, title, publisher_id, publication_year, edition, language, pages, description)
VALUES 
('9780141439518', 'Pride and Prejudice', 1, 1813, 'Revised', 'English', 432, 'A romantic novel of manners'),
('9780451524935', '1984', 1, 1949, 'Standard', 'English', 328, 'A dystopian social science fiction novel'),
('9780590353427', 'Harry Potter and the Sorcerer''s Stone', 4, 1997, 'First', 'English', 309, 'First book in the Harry Potter series'),
('9780684801223', 'The Old Man and the Sea', 3, 1952, 'Standard', 'English', 127, 'A short novel about an aging Cuban fisherman'),
('9780062073488', 'Murder on the Orient Express', 2, 1934, 'Reprint', 'English', 256, 'A detective novel featuring Hercule Poirot');

-- Insert Book_Authors
INSERT INTO Book_Authors (book_id, author_id, role)
VALUES 
(1, 1, 'Primary'),
(2, 2, 'Primary'),
(3, 3, 'Primary'),
(4, 4, 'Primary'),
(5, 5, 'Primary');

-- Insert Book_Categories
INSERT INTO Book_Categories (book_id, category_id)
VALUES 
(1, 1), -- Pride and Prejudice - Fiction
(1, 8), -- Pride and Prejudice - Romance
(2, 1), -- 1984 - Fiction
(2, 3), -- 1984 - Science Fiction
(3, 1), -- Harry Potter - Fiction
(3, 7), -- Harry Potter - Fantasy
(4, 1), -- The Old Man and the Sea - Fiction
(5, 1), -- Murder on the Orient Express - Fiction
(5, 4); -- Murder on the Orient Express - Mystery

-- Insert BookItems (multiple copies of some books)
INSERT INTO BookItems (book_id, barcode, location, acquisition_date, status, condition_note)
VALUES 
(1, 'LIB-B001-001', 'Floor 1, Section A, Shelf 3', '2023-01-10', 'Available', 'Good condition'),
(1, 'LIB-B001-002', 'Floor 1, Section A, Shelf 3', '2023-01-10', 'Loaned', 'Slight wear on cover'),
(2, 'LIB-B002-001', 'Floor 1, Section B, Shelf 2', '2023-01-15', 'Available', 'New'),
(3, 'LIB-B003-001', 'Floor 2, Section C, Shelf 1', '2023-02-01', 'Reserved', 'Good condition'),
(3, 'LIB-B003-002', 'Floor 2, Section C, Shelf 1', '2023-02-01', 'Loaned', 'Excellent condition'),
(3, 'LIB-B003-003', 'Floor 2, Section C, Shelf 1', '2023-02-01', 'Lost', 'Unknown'),
(4, 'LIB-B004-001', 'Floor 1, Section D, Shelf 4', '2023-02-10', 'Available', 'Pages slightly yellowed'),
(5, 'LIB-B005-001', 'Floor 1, Section B, Shelf 5', '2023-03-05', 'Under Repair', 'Damaged spine');

-- Insert Staff
INSERT INTO Staff (first_name, last_name, email, phone, role, hire_date, salary)
VALUES
('Robert', 'Anderson', 'robert.a@library.com', '555-901-2345', 'Librarian', '2020-06-15', 52000.00),
('Lisa', 'Taylor', 'lisa.t@library.com', '555-123-7890', 'Assistant', '2021-03-10', 38000.00),
('James', 'Wilson', 'james.w@library.com', '555-456-1230', 'Admin', '2019-11-22', 48000.00),
('Patricia', 'Martinez', 'patricia.m@library.com', '555-789-4560', 'IT Support', '2022-01-17', 46000.00);

-- Insert Loans
INSERT INTO Loans (item_id, member_id, loan_date, due_date, return_date, fine_amount)
VALUES
(2, 1, '2023-04-01', '2023-04-15', NULL, 0.00),
(5, 2, '2023-04-05', '2023-04-19', NULL, 0.00),
(7, 3, '2023-03-20', '2023-04-03', '2023-04-02', 0.00),
(1, 4, '2023-03-15', '2023-03-29', '2023-04-05', 3.50),
(3, 5, '2023-04-10', '2023-04-24', NULL, 0.00);

-- Insert Reservations
INSERT INTO Reservations (book_id, member_id, reservation_date, expiry_date, status)
VALUES
(3, 1, '2023-04-08 10:15:00', '2023-04-15 10:15:00', 'Pending'),
(5, 3, '2023-04-07 14:30:00', '2023-04-14 14:30:00', 'Fulfilled'),
(2, 4, '2023-03-25 11:45:00', '2023-04-01 11:45:00', 'Expired'),
(1, 2, '2023-04-10 16:20:00', '2023-04-17 16:20:00', 'Pending');

-- Insert FinePayments
INSERT INTO FinePayments (loan_id, payment_date, amount, payment_method, staff_id)
VALUES
(4, '2023-04-05 15:30:00', 3.50, 'Cash', 2);
