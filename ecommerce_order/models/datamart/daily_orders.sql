SELECT 
    DATE(order_purchase_timestamp) date,
    order_status,
    product_category_name,
    SUM(price) total_price,
    COUNT(1) total_orders
FROM {{ source("staging", "order_details") }}
group by 1,2,3