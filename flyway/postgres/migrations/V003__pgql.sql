CREATE TABLE products (
    id           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_id  INT NOT NULL REFERENCES categories(id),
    name         VARCHAR(255) NOT NULL,
    sku          VARCHAR(100) NOT NULL UNIQUE,
    price        NUMERIC(12, 2) NOT NULL,
    stock_qty    INT NOT NULL DEFAULT 0,
    description  TEXT,
    created_at   TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP NOT NULL DEFAULT NOW()
);
