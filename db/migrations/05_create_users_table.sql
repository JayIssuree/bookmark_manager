CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(60) UNIQUE,
    password VARCHAR(140)
);