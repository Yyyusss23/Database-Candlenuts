SELECT 
    P.product_id AS Product_ID,
    P.product_name AS Product_Name,
    SUM(PO.quantity * P.product_price) AS Total_Sales
FROM 
    Product P
JOIN 
    Product_Order PO ON P.product_id = PO.product_id
GROUP BY 
    P.product_id, P.product_name
ORDER BY 
    Total_Sales DESC;
