CREATE TABLE reviews (
    id          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id  INT NOT NULL REFERENCES products(id),
    user_id     INT NOT NULL REFERENCES users(id),
    rating      SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title       VARCHAR(200),
    body        TEXT,
    verified    BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (product_id, user_id)
);
