-- Retrieve the total number of orders placed.
select count(*) as orders
from orders









-- Calculate the total revenue generated from pizza sales.

select round(sum(o.quantity*p.price),3) as revenue
from order_details o
join pizzas p
on o.pizza_id=p.pizza_id

-- Identify the highest-priced pizza.

select t.name,p.price as highest_price
from pizzas p
join pizza_types t
on t.pizza_type_id=p.pizza_type_id
order by p.price desc
limit 1


-- Identify the most common pizza size ordered.
select p.size,count(*)
from order_details o
join pizzas p
on o.pizza_id=p.pizza_id
group by p.size
order by count(*) desc
limit 1







-- List the top 5 most ordered pizza types along with their quantities.

select t.name,count(*) as total_order
from pizzas p
join order_details o
on o.pizza_id=p.pizza_id
join pizza_types t
on p.pizza_type_id=t.pizza_type_id
group by t.name
order by total_order desc
limit 5





