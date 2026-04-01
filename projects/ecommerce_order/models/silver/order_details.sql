SELECT 
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    p.product_category_name,
    i.price 
FROM {{ source("public", "df_Orders") }} o
LEFT JOIN {{ source("public", "df_Customers") }} c
ON o.customer_id = c.customer_id
LEFT JOIN {{ source("public", "df_OrderItems") }} i
ON o.order_id = i.order_id 
LEFT JOIN {{ source("public", "df_Products") }} p
ON i.product_id = p.product_id 