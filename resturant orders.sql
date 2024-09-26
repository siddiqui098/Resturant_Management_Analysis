
#Aggregate functins#

-- average price of food?

select avg(price)
from resturant.menu_items;

-- find total orders?

select count(order_id)
from resturant.order_details;

-- most expensive dish and less expensive dish?
##expensive##
Ans 1

SELECT 
    item_name, price
FROM
    resturant.menu_items
ORDER BY price ASC
LIMIT 1;

Ans 2
SELECT 
    item_name, price
FROM
    resturant.menu_items
ORDER BY price desc
LIMIT 1;


--  Identify top-performing and underperforming menu items

SELECT 
    item_name,
    category,
    price,
    COUNT(item_id) AS total_orders,
    SUM(price) AS total_revenue
FROM
    menu_items
        JOIN
    order_details ON item_id = item_id
GROUP BY item_name , category , price
ORDER BY total_revenue ASC
LIMIT 5;

-- Analyze the profitability of different food categories.

SELECT 
    category,
    COUNT(item_id) AS total_orders,
    SUM(price) AS total_revenue
FROM
    menu_items
        JOIN
    order_details ON item_id
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 5;

-- which month have highest revenue
SELECT 
    FORMAT(order_date,
        'mm/dd/yyy',
        'mm/yyyy') AS order_month,
    SUM(price) AS total_revenue
FROM
    resturant.order_details
        JOIN
    resturant.menu_items ON item_id = item_id
GROUP BY order_month
ORDER BY total_revenue DESC;


-- what is the rush time of resturant.

SELECT 
    DATE_FORMAT(STR_TO_DATE(order_time, '%h:%i:%s %p'),
            '%h %p') AS order_hour_12hr,
    COUNT(order_id) AS total_orders
FROM
    resturant.order_details
GROUP BY order_hour_12hr
ORDER BY total_orders DESC;

-- Analyze the impact of pricing on order volume.

SELECT 
    price, COUNT(order_id) AS total_orders
FROM
    order_details
        JOIN
    resturant.menu_items ON item_id = item_id
GROUP BY price
ORDER BY total_orders DESC;

-- Analyze ordering patterns based on day of the week.

SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS day_of_week,
    COUNT(order_id) AS order_count
FROM
    order_details
WHERE
    STR_TO_DATE(order_date, '%d-%m-%Y') IS NOT NULL
GROUP BY day_of_week
ORDER BY FIELD(day_of_week,
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday');










