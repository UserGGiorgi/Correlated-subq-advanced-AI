﻿SELECT  distinct p.name as name ,p.surname as surname,

(select ROUND(AVG(od2.price_with_discount * od2.product_amount), 2)
from order_details od2
join customer_order co2
on od2.customer_order_id=co2.id
where co.customer_id=co2.customer_id
) as avg_purchase,

(select SUM(od2.price_with_discount*od2.product_amount)
from order_details od2
join customer_order co2
on od2.customer_order_id=co2.id
where co.customer_id=co2.customer_id
) as sum_purchase


from person p
join customer c
on p.id=c.person_id
join customer_order co
on c.person_id=co.customer_id
join order_details od
on co.id=od.customer_order_id
where sum_purchase>70
ORDER BY sum_purchase ASC,surname ASC;

