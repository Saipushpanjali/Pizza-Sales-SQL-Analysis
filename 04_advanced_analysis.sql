-- Calculate the percentage contribution of each pizza catgeory to total revenue.
select t.category,round(sum(o.quantity*p.price)/
(select sum(o.quantity*p.price) as revenue
from order_details o
join pizzas p
on o.pizza_id=p.pizza_id)*100,2) as percentage
from order_details o
join pizzas p
on o.pizza_id=p.pizza_id
join pizza_types t
on p.pizza_type_id=t.pizza_type_id
group by t.category





-- Analyze the cumulative revenue generated over time.
select order_date, round(sum(revenue) over (order by t.order_date),3) as cumulative_revenue
from
(select o.order_date,sum(d.quantity*p.price)  as revenue
from order_details d
join pizzas p
on d.pizza_id=p.pizza_id
join orders o
on o.order_id=d.order_id
group by o.order_date) as t




-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category,name,revenue,r as rnk
from
(select t.category,t.name,sum(o.quantity*p.price) as revenue,
rank() over ( partition by t.category order by sum(o.quantity*p.price) desc) as r
from order_details o
join pizzas p
on o.pizza_id=p.pizza_id
join pizza_types t
on t.pizza_type_id=p.pizza_type_id
group by t.category,t.name) as a
where r<=3

