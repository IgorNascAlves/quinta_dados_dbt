-- CREATE DATABASE lakehouse_bronze;
CREATE DATABASE lakehouse_silver;
CREATE DATABASE lakehouse_gold;
USE lakehouse_bronze;

-- Criar a tabela raw_orders (Bronze)
CREATE TABLE IF NOT EXISTS raw_orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(10,2)
);

-- Inserir dados brutos
INSERT INTO raw_orders (order_id, customer_id, order_date, amount) VALUES
(1, 101, '2024-01-10', 200.00),
(2, 101, '2024-01-15', 150.00),
(3, 102, '2024-01-20', 300.00),
(4, 103, '2024-02-01', 0.00),           -- exemplo com valor zero
(5, 104, '2024-02-05', 500.00),
(6, 101, '2024-02-15', 180.00);

-- Criar a tabela raw_customers (opcional)
CREATE TABLE IF NOT EXISTS raw_customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  region VARCHAR(50)
);

-- Inserir clientes
INSERT INTO raw_customers (customer_id, customer_name, region) VALUES
(101, 'Alice', 'SP'),
(102, 'Bruno', 'RJ'),
(103, 'Carla', 'MG'),
(104, 'Diego', 'BA');
