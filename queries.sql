-- orders database
use orders;

-- show all data and count of rows
select * from Orders;
select @@ROWCOUNT;

-- get total price for each order
select Order_Number,
	sum(Product_Price * Quantity) as Total_Price
from Orders
group by Order_Number;

-- get the top 10 selling item
select Item_Name , total_quantity
from(
	select Item_Name ,
		sum(quantity) as total_quantity,
		DENSE_RANK() over(order by sum(quantity) desc) as rank
	from Orders
	group by Item_Name) as items_quantity
where rank between 1 and 10;

-- the quantity and the price for each item
select Item_Name,
	round(sum(product_price * quantity),2) as price,
	sum(quantity) as quantity
from Orders
group by Item_Name
order by price desc;

-- the count of orders for each year
select year(Order_Date) as year,
	count(Order_Number) as total_orders
from Orders
group by year(Order_Date)
order by year desc;

-- the count of orders for each month in the year
select year(Order_Date) as year,
	month(Order_Date) as month,
	count(Order_Number) as total_orders
from Orders
group by year(Order_Date) , month(Order_Date)
order by year desc, month;


