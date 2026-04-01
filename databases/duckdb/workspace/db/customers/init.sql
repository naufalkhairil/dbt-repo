-- Create example customers table with 10 records
CREATE TABLE IF NOT EXISTS customers (
    id INTEGER,
    name VARCHAR,
    email VARCHAR,
    city VARCHAR,
    created_at DATE
);

INSERT INTO customers VALUES
(1, 'Alice Johnson', 'alice@example.com', 'New York', '2024-01-15'),
(2, 'Bob Smith', 'bob@example.com', 'Los Angeles', '2024-02-20'),
(3, 'Carol White', 'carol@example.com', 'Chicago', '2024-03-10'),
(4, 'David Brown', 'david@example.com', 'Houston', '2024-04-05'),
(5, 'Eva Martinez', 'eva@example.com', 'Phoenix', '2024-05-12'),
(6, 'Frank Lee', 'frank@example.com', 'Philadelphia', '2024-06-18'),
(7, 'Grace Kim', 'grace@example.com', 'San Antonio', '2024-07-22'),
(8, 'Henry Wilson', 'henry@example.com', 'San Diego', '2024-08-30'),
(9, 'Ivy Chen', 'ivy@example.com', 'Dallas', '2024-09-14'),
(10, 'Jack Davis', 'jack@example.com', 'San Jose', '2024-10-01');

-- Verify the data
SELECT * FROM customers;
