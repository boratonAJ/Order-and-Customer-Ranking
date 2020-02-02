/***Question 1 
Return all restaurant accepted orders. As output, return all the columns in the Orders table
***/

select * FROM inventory_db.customer_orders_tb AS cust
JOIN inventory_db.customer_orders_rank_tb AS cust_rank
ON cust.orderid = cust_rank.orderid
where restaurantstatus = 'restaurant_accepted'; 

/***Question 2 
Return the count of restaurant accepted orders and group them by date (hint: use the date portion of the ‘createdat’ timestamp)
***/

select cust.restaurantstatus, Count(cust.restaurantstatus) AS TotalOrderStatus
FROM inventory_db.customer_orders_tb AS cust
JOIN inventory_db.customer_orders_rank_tb AS cust_rank
ON cust.orderid = cust_rank.orderid
where cust.restaurantstatus = 'restaurant_accepted' 
GROUP BY cust.createdat
Order BY Count(DISTINCT cust.orderid) DESC;

/***Question 3 
Return the unique number of customers with restaurant accepted orders, grouped first by date, then by province
***/

SELECT DISTINCT cust.createdat, cust.customerid, cust.restaurantstatus as restaurant_accepted_orders FROM inventory_db.customer_orders_tb AS cust
INNER JOIN inventory_db.customer_orders_rank_tb AS cust_rank
ON cust.orderid = cust_rank.orderid  -- Check whether orderid of customer = customer rank orderid
where cust.restaurantstatus = 'restaurant_accepted' 
-- Modify GROUP BY to use ROLLUP
GROUP BY cust.createdat, cust.customeraddressprovince
Order BY cust.customerid DESC;


/***Question 4 
Return all customers who’ve ordered Nando’s in the week starting 21 October 2019. 
As output, return customerid and the number of Nando’s orders they’ve placed.

***/
SELECT cust.customerid, cust_rank.rank_id as number_of_nando_orders
FROM inventory_db.customer_orders_tb AS cust
JOIN inventory_db.customer_orders_rank_tb AS cust_rank
ON cust.orderid = cust_rank.orderid
WHERE cust.restaurantname LIKE 'Nando%'
and  
cust.createdat BETWEEN '2019-10-21 12:00:00' AND '2019-10-28 23:30:00'
ORDER BY cust_rank.rank_id DESC;

SELECT cust.customerid, cust_rank.rank_id, cust.restaurantname, Count(cust.customerid) AS TotalNumberOfNandoPlaced
FROM inventory_db.customer_orders_tb AS cust
INNER JOIN inventory_db.customer_orders_rank_tb AS cust_rank
ON cust.orderid = cust_rank.orderid
WHERE cust.restaurantname LIKE 'Nando%' and  
cust.createdat BETWEEN '2019-10-21 12:00:00' AND '2019-10-21 23:30:00'
ORDER BY cust_rank.rank_id DESC;


/***Question 5 
Return all customers who ordered Nando’s as their first order. 
As output, return customerid, orderid, the date of the order, and restaurant name.

***/

SELECT cust.customerid, cust.orderid, cust.createdat, cust.restaurantname
FROM inventory_db.customer_orders_tb AS cust
JOIN inventory_db.customer_orders_rank_tb AS cust_rank
ON cust.orderid = cust_rank.orderid
WHERE cust.restaurantname LIKE 'Nando%'
and  
cust_rank.rank_id = 1
ORDER BY cust_rank.rank_id DESC;

/***Question 6 
Return all customers that have ordered Nando’s for two consecutive orders. 
As output, return their customers’ IDs and (for both orders) the order date, order id, and restaurant name
***/

SELECT cust.customerid, cust.orderid, cust.createdat, cust.restaurantname
FROM inventory_db.customer_orders_tb AS cust
JOIN inventory_db.customer_orders_rank_tb AS cust_rank
ON cust.orderid = cust_rank.orderid
WHERE cust.restaurantname LIKE 'Nando%'
and  
cust_rank.rank_id = 2
ORDER BY cust_rank.rank_id ASC;
    



