DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
  -- tag_id INT
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  tag_id INT REFERENCES tags(id) ON DELETE CASCADE,
  merchant_id INT REFERENCES merchants(id) ON DELETE CASCADE,
  amount NUMERIC
  -- time TIMESTAMP
);