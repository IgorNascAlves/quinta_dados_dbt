SELECT
  order_id,
  customer_id,
  CAST(order_date AS DATE) AS order_date,
  amount
FROM {{ source('lakehouse', 'raw_orders') }}
WHERE amount > 0
