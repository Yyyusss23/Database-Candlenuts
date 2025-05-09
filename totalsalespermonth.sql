SELECT 
    TO_CHAR(O.delivery_date, 'YYYY-MM') AS sale_month,
    SUM(PO.quantity * P.product_price) AS total_sales
FROM 
    Product_Order PO
JOIN 
    Orders O ON PO.order_id = O.order_id
JOIN 
    Product P ON PO.product_id = P.product_id
GROUP BY 
    TO_CHAR(O.delivery_date, 'YYYY-MM')
ORDER BY 
    sale_month;
