CREATE TABLE coupons (
    id              INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code            VARCHAR(50) NOT NULL UNIQUE,
    discount_type   VARCHAR(10) NOT NULL CHECK (discount_type IN ('percent', 'fixed')),
    discount_value  NUMERIC(10, 2) NOT NULL,
    min_order_value NUMERIC(12, 2),
    max_uses        INT,
    uses_count      INT NOT NULL DEFAULT 0,
    expires_at      TIMESTAMP,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);
