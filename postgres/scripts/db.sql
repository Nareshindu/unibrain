-- Create the database if it does not exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_database WHERE datname = 'transactions'
    ) THEN
        CREATE DATABASE transactions;
    END IF;
END $$;

-- Connect to the transactions database
\c transactions

-- Create the table if it does not exist
CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    amount INT,
    description VARCHAR(255)
);

-- Create the user if it does not exist
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_roles WHERE rolname = 'expense'
    ) THEN
        CREATE USER expense WITH PASSWORD 'ExpenseApp@1';
    END IF;
END $$;

-- Grant all privileges on the database and tables
GRANT ALL PRIVILEGES ON DATABASE transactions TO expense;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO expense;

-- Ensure privileges apply to future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO expense;
