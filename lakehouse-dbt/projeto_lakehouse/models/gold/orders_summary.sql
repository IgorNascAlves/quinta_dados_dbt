SELECT
  customer_id,
  COUNT(order_id) AS total_orders,
  SUM(amount) AS total_amount
FROM {{ ref('stg_orders') }}
GROUP BY customer_id
