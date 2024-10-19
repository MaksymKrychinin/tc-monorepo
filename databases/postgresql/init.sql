-- Create the 'users' table
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username VARCHAR(255) UNIQUE NOT NULL,
                       password_hash TEXT NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       role VARCHAR(50) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the 'roles' table
CREATE TABLE roles (
                       id SERIAL PRIMARY KEY,
                       role_name VARCHAR(50) UNIQUE NOT NULL
);

-- Insert default roles
INSERT INTO roles (role_name) VALUES ('User');
INSERT INTO roles (role_name) VALUES ('Manager');
INSERT INTO roles (role_name) VALUES ('Support');
INSERT INTO roles (role_name) VALUES ('Admin');
INSERT INTO roles (role_name) VALUES ('SuperAdmin');

-- Create the 'permissions' table
CREATE TABLE permissions (
                             id SERIAL PRIMARY KEY,
                             role_id INT REFERENCES roles(id),
                             permission VARCHAR(255) NOT NULL
);

-- Utility function to hash password (Assuming pgcrypto extension is enabled)
CREATE OR REPLACE FUNCTION hash_password(password TEXT) RETURNS TEXT AS $$
BEGIN
RETURN crypt(password, gen_salt('bf'));
END;
$$ LANGUAGE plpgsql;

-- Insert default SuperAdmin User
INSERT INTO users (username, password_hash, email, role) VALUES (
                                                                    'superadmin',
                                                                    hash_password('SuperAdminPassword'),  -- Replace 'SuperAdminPassword' with a strong password
                                                                    'superadmin@example.com',
                                                                    'SuperAdmin'
                                                                );

-- Example of assigning some permissions to the SuperAdmin role
INSERT INTO permissions (role_id, permission) SELECT id, 'auth:auth:create' FROM roles WHERE role_name = 'SuperAdmin';
INSERT INTO permissions (role_id, permission) SELECT id, 'auth:auth:read' FROM roles WHERE role_name = 'SuperAdmin';
INSERT INTO permissions (role_id, permission) SELECT id, 'company:profile:create' FROM roles WHERE role_name = 'SuperAdmin';
-- Add more permissions as needed...

-- Ensure to grant the SuperAdmin all necessary permissions as per the previous role-based permissions list.

-- Add more role-based permissions insertion as needed...