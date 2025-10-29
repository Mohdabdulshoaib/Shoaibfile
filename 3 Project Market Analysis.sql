select * from aisles;
select * from departments;
select * from order_products_train;
select * from orders;
select * from products;


-- Task 1 What are the top 10 aisles with the highest number of products?
select aisle_id, aisle, count(product_id) as product_count 
from products
join aisles using (aisle_id)
group by aisle_id , aisle
order by product_count desc limit 10;

-- Task 2 How many unique departments are there in the dataset?
select count(distinct department) as uniqe_departments from departments;

-- Task 3 What is the distribution of products across departments?
select department_id, department, count(product_id) as count_products
from products
join departments using (department_id)
group by department_id, department
order by count_products;

-- Task 4 What are the top 10 products with the highest reorder rates?
select p.product_name,
round(avg(op.reordered),2) as reorder_rate
from order_products_train as op
join products as p on op.product_id =p.product_id
group by p.product_name
order by reorder_rate desc limit 10;

-- Task 5 How many unique users have placed orders in the dataset?
select count(*) as total_orders from orders;

-- Task 6 What is the average number of days between orders for each user?
select user_id, avg(days_since_prior_order) as user_orders_intervel from orders 
where days_since_prior_order is not null
group by user_id;

-- Task 7 What are the peak hours of orders placement during the day?
select order_hour_of_day, count(*) as orders from orders
group by order_hour_of_day
order by orders;

-- Task 8 How does orders volume vary by day of the week?
select order_dow, count(*) as orders_count 
from orders
group by order_dow
order by order_dow;

-- Task 9 What are the top 10 most orders products?
select product_id,product_name, count(order_id) as times_orders_products
from order_products_train
join products using (product_id)
group by product_id,product_name
order by times_orders_products desc limit 10;

-- Task 10 How many users have placed orders in each department?
select d.department, count(distinct o.user_id) as num_users
from orders as o
join order_products_train as op on o.order_id = op.order_id
join products as p on op.product_id=p.product_id
join departments as d on p.department_id=d.department_id 
group by d.department
order by num_users desc;

-- Task 11 What is the average number of products per orders?
select avg(product_count) as avg_product_per_orders
from (
select order_id, count(product_id) as product_count
from order_products_train
group by order_id) order_count;


-- Task 12 What are the most reordered products in each department?


SELECT 
    op.reordered,
    d.department,         -- or d.department_name depending on your schema
    p.product_name
FROM 
    order_products_train AS op
JOIN 
    products AS p ON op.product_id = p.product_id
JOIN 
    departments AS d ON p.department_id = d.department_id
WHERE 
    op.reordered = 1;

-- Task 13 How many products have been reordered more than once?
select count(*) as product_recordered_more_then_once
from(
select product_id, sum(reordered) as total_reorder
from order_products_train
group by product_id)t
where total_reorder>1;

-- Task 14 What is the average number of products added to the cart per orders?
select avg(product_count) as avg_items_added_per_orders
from (
select order_id, count(*) as product_count
from orders
group by order_id) sub;

-- Task 15 how does the number of orders vary buy hour of day?
select order_hour_of_day,count(*) as orders_count
from orders	
group by order_hour_of_day
order by order_hour_of_day;

-- Task 16 What is the distribution of order sizes(number of products per order)?
select order_id,
count(*) as products_in_order
from order_products_train
group by order_id;

-- Task 17 What is the average reorder rate for products in each aisle?
select a.aisle,
round(avg(op.reordered),2) as avg_reorder_rate
from order_products_train as op
join products as p on op.product_id =p.product_id
join aisles as a on p.aisle_id = a.aisle_id
group by a.aisle
order by avg_reorder_rate desc;

-- Task 18 How does the average order size vary by day of the week?
select o.order_dow as day_of_week, round(avg(order_number.products_per_order),2) as avg_order_size
from orders as o
join (
select order_id,count(product_id) as products_per_order
from order_products_train
group by order_id
) as order_number
on o.order_id = order_number.order_id
group by o.order_dow
order by o.order_dow;

-- Task 19 What are the top 10 users with the highest of orders?
select user_id, 
count(order_id) as total_orders
from orders
group by user_id
order by total_orders desc	
limit 10;

-- Task 20 How many products belong to each aisle and deparment?
select d.department,a.aisle,
count(p.product_id) as product_count
from products as p
join aisles as a on p.aisle_id=a.aisle_id
join departments as d on p.department_id=d.department_id
group by d.department,a.aisle
order by d.department,a.aisle;

