CREATE TABLE payments (
    id              INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id        INT NOT NULL REFERENCES orders(id),
    method          VARCHAR(30) NOT NULL CHECK (method IN ('card','upi','netbanking','wallet','cod')),
    status          VARCHAR(20) NOT NULL DEFAULT 'pending'
                        CHECK (status IN ('pending','completed','failed','refunded')),
    amount          NUMERIC(12, 2) NOT NULL,
    gateway_ref     VARCHAR(255),
    paid_at         TIMESTAMP,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);
