

SELECT 
    TO_CHAR(o.delivery_date, 'YYYY-MM') AS sales_month,
    p.product_name,
    SUM(po.quantity) AS total_quantity_sold\
FROM 
    Product_Order po
JOIN 
    Orders o ON po.order_id = o.order_id\
JOIN 
    Product p ON po.product_id = p.product_id\
GROUP BY 
    TO_CHAR(o.delivery_date, 'YYYY-MM'), p.product_name
ORDER BY 
    sales_month, total_quantity_sold DESC;

WITH MonthlySales AS (
    SELECT 
        TO_CHAR(o.delivery_date, 'YYYY-MM') AS sales_month,
        p.product_name,
        SUM(po.quantity) AS total_quantity_sold,
        RANK() OVER (PARTITION BY TO_CHAR(o.delivery_date, 'YYYY-MM') ORDER BY SUM(po.quantity) DESC) AS rank
    FROM 
        Product_Order po
    JOIN 
        Orders o ON po.order_id = o.order_id
    JOIN 
        Product p ON po.product_id = p.product_id
    GROUP BY 
        TO_CHAR(o.delivery_date, 'YYYY-MM'), p.product_name
)
SELECT 
    sales_month,
    product_name,
    total_quantity_sold
FROM 
    MonthlySales
WHERE 
    rank = 1
ORDER BY 
    sales_month;}
