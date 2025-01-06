CREATE DATABASE transactions;
\c transactions;

CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    amount INT NOT NULL,
    description VARCHAR(255)
);

DO
$do$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_catalog.pg_roles WHERE rolname = 'expense'
    ) THEN
        CREATE ROLE expense LOGIN PASSWORD 'ExpenseApp@1';
    END IF;
END
$do$;

GRANT ALL PRIVILEGES ON DATABASE transactions TO expense;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO expense;