--Objective 1: explore the menu_items table

--1. the number of item on the menu
select count(*) as item_number
from menu_items mi;

--2. the least and most expensive item 
select item_name, price
from menu_items mi 
where price = (select max(price) from menu_items)
or price = (select min(price) from menu_items);

--3. number of Italian dishes. Most and least expensive Italian dish
select count(*) as Total_italian_dishes
from menu_items mi 
where category = 'Italian';

select item_name, price, category
from menu_items mi 
where category = 'Italian' and ( 
price = (select max(price) from menu_items where category = 'Italian')
or price = (select min(price) from menu_items where category = 'Italian'));

--4. how many dishes in each category? what is the average dish price within the each category?
select category, count(*) as dish_count, AVG(price) as average_price
from menu_items mi 
group by category;


--Objective 2:explore the order_details table

--1. What is the date range?
select MIN(order_date ) as start_day, MAX(order_date ) as end_day
from order_details od; 

--2. How many orders were made within the this date range? How many items were ordered within this date range?
select count(distinct order_id) as total_order 
from order_details od;

select count(*)
from order_details od;

--3. Which orders had the most number of items?

SELECT order_id, COUNT(*) AS item_count
FROM order_details
GROUP BY order_id
HAVING COUNT(*) = (
    SELECT MAX(item_count)
    FROM (
        SELECT COUNT(*) AS item_count
        FROM order_details
        GROUP BY order_id
    )
);


--4. How many orders had more than 12 items?
select order_id, count(*) as items_count
from order_details od 
group by order_id
having items_count > 12;

--Objective 3: analyze custom behavior
 
--1. Combine 2 tables into 1 table
select *
from order_details od
join menu_items mi
on od.item_id = mi.menu_item_id; 

--2. The least and most order items. What categories were they in?
select mi.category, count(od.item_id) as item_count
from order_details od
join menu_items mi
on od.item_id = mi.menu_item_id
group by mi.category 
order by item_count desc; --use asc for the least order item

--3. Top 5 orders that spent the most money 
with table1 as(
select od.order_id, od.item_id, mi.price 
from order_details od
join menu_items mi
on od.item_id = mi.menu_item_id )
select order_id, sum(price) as money_spent
from table1 
group by order_id 
order by money_spent  desc
limit 5;

--4. View the details of the highest spend order. What insights can u gather from the result?
select mi.category, count(od.item_id) as num_item 
from order_details od
join menu_items mi
on od.item_id = mi.menu_item_id 
where order_id = 440
group by mi.category;
--Insight: this person ordered a lot of Italian dishes compared to other. 

--5. View the details of the top 5 highest spent order. What insights can you gather from the result? 
select od.order_id, mi.category, count(od.item_id) as num_item 
from order_details od
join menu_items mi
on od.item_id = mi.menu_item_id 
where order_id in (440, 2075, 1957, 330, 2675)
group by od.order_id,  mi.category;

--insight: the top 5 highest spent orders purchased a lot of Italian dishes. Therefore, we should keep Italian dishes on the menu