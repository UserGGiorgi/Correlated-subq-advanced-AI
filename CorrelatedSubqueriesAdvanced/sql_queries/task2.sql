﻿SELECT 
    p.id AS id,
    pt.title AS title,
    
    -- Count of products sold with a discount more than 5%
    (SELECT COUNT(*)
     FROM order_details od1
     WHERE od1.product_id = p.id 
     AND od1.price_with_discount / od1.price < 0.95
    ) AS count_with_discount_5,

    -- Count of products sold without a discount or with a discount of 5% or less
    (SELECT COUNT(*)
     FROM order_details od2
     WHERE od2.product_id = p.id 
     AND od2.price_with_discount / od2.price >= 0.95
    ) AS count_without_discount_5,

    -- Calculate percentage difference between the two counts
    CAST((
        (SELECT COUNT(*)
         FROM order_details od3
         WHERE od3.product_id = p.id 
         AND od3.price_with_discount / od3.price < 0.95
        ) * 100.0 
        /
        NULLIF(
            (SELECT COUNT(*)
             FROM order_details od4
             WHERE od4.product_id = p.id 
             AND od4.price_with_discount / od4.price >= 0.95
            ), 0)
    ) - 100 AS REAL) AS difference

FROM 
    product p
JOIN 
    product_title pt ON pt.id = p.product_title_id
ORDER BY 
    p.id ASC;
