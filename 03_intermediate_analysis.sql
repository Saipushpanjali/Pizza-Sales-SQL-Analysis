-- Join the necessary tables to find the total quantity of each pizza category ordered.
select t.category,sum(o.quantity) as total
from order_details o
join pizzas p
on o.pizza_id=p.pizza_id
join pizza_types t
on p.pizza_type_id=t.pizza_type_id
group by t.category
order by total






-- Determine the distribution of orders by hour of the day.

select hour(order_time),count(order_id)
from orders 
group by hour(order_time);







-- Join relevant tables to find the category-wise distribution of pizzas.
select category,count(pizza_type_id)
from pizza_types
group by category









-- the overall average number of pizzas ordered per day
select avg(quantity)
from
(select order_date,sum(d.quantity) as quantity
from orders o
join order_details d
on o.order_id=d.order_id
group by o.order_date) as t







-- Determine the top 3 most ordered pizza types based on revenue.
select t.name,round(sum(o.quantity*p.price),3) as revenue
from order_details o
join pizzas p
on o.pizza_id=p.pizza_id
join pizza_types t
on t.pizza_type_id=p.pizza_type_id
group by t.name
order by revenue desc
limit 3






