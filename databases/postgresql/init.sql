-- Create users table
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username VARCHAR(50) NOT NULL,
                       email VARCHAR(100) NOT NULL,
                       password VARCHAR(100) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into users table
INSERT INTO users (username, email, password) VALUES ('john_doe', 'john@example.com', 'password123');
INSERT INTO users (username, email, password) VALUES ('jane_doe', 'jane@example.com', 'password123');

-- Create companies table
CREATE TABLE companies (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           document JSONB,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into companies table
INSERT INTO companies (name, document) VALUES ('Company A', '{"docType": "pdf", "docName": "companyA.pdf"}');
INSERT INTO companies (name, document) VALUES ('Company B', '{"docType": "pdf", "docName": "companyB.pdf"}');

-- Create tickets table
CREATE TABLE tickets (
                         id SERIAL PRIMARY KEY,
                         user_id INT REFERENCES users(id),
                         company_id INT REFERENCES companies(id),
                         description TEXT NOT NULL,
                         status VARCHAR(50) NOT NULL,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into tickets table
INSERT INTO tickets (user_id, company_id, description, status) VALUES (1, 1, 'Issue with product', 'open');
INSERT INTO tickets (user_id, company_id, description, status) VALUES (2, 2, 'Billing issue', 'open');

-- Create payments table
CREATE TABLE payments (
                          id SERIAL PRIMARY KEY,
                          ticket_id INT REFERENCES tickets(id),
                          amount NUMERIC(10, 2) NOT NULL,
                          status VARCHAR(50) NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into payments table
INSERT INTO payments (ticket_id, amount, status) VALUES (1, 100.00, 'completed');
INSERT INTO payments (ticket_id, amount, status) VALUES (2, 50.00, 'pending');

-- Create statistics table
CREATE TABLE statistics (
                            id SERIAL PRIMARY KEY,
                            user_id INT REFERENCES users(id),
                            data JSONB,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into statistics table
INSERT INTO statistics (user_id, data) VALUES (1, '{"ticketsCreated": 5, "paymentsMade": 3}');
INSERT INTO statistics (user_id, data) VALUES (2, '{"ticketsCreated": 2, "paymentsMade": 1}');