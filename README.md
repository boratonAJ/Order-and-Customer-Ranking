Please use the provided tables (Orders and Orders_rank) and write SQL queries to answer the questions below. There is no need to provide any results - the query you’d run is sufficient.

# Tables provided
## Orders
-	Createdat - timestamp of when the order was created
-	Orderid - The order number (primary key)
-	Restaurantstatus - Will reflect as null if the customer aborted the order. An order is seen as successful if the restaurant status is “restaurant_accepted”.
-	Paymentmethod
-	Subtotal
-	Customerid – unique ID given to a customer upon registration
-	Restaurantname
-	Customeraddressprovince
-	Restaurantacceptedat - time the order was accepted
-	Foodpreparedpromised - time the restaurant indicated the food would be ready
-	Podactual - time the order was delivered


# Orders_rank - 
contains a count of a customer’s successful orders - e.g. if an orderid has an order rank of 2 the order in question was the customer’s second successful order since their registration. Columns:

-	CustomerId 
-	OrderId (primary key)
-	Rank

### Questions:

1.	Return all restaurant accepted orders. As output, return all the columns in the Orders table

2.	Return the count of restaurant accepted orders and group them by date (hint: use the date portion of the ‘createdat’ timestamp)

3.	Return the unique number of customers with restaurant accepted orders, grouped first by date, then by province

4.	Return all customers who’ve ordered Nando’s in the week starting 21 October 2019. As output, return customerid and the number of Nando’s orders they’ve placed.

5.	Return all customers who ordered Nando’s as their first order. As output, return customerid, orderid, the date of the order, and restaurant name.

6.	Return all customers that have ordered Nando’s for two consecutive orders. As output, return their customers’ IDs and (for both orders) the order date, order id, and restaurant name


	

