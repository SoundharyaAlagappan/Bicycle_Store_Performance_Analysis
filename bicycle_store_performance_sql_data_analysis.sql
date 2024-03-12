#creating a schema
create database sales;
use sales;
#creating a table
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(25) DEFAULT NULL,
  `zip_code` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) 

#implementing code to get desired table for analysis
select
sales.orders.order_id,
concat(sales.customers.first_name,' ',sales.customers.last_name) as'customer_name',
sales.customers.city,
sales.customers.state,
sales.orders.order_date,
sum(sales.order_items.quantity) as 'total_units',
sum(sales.order_items.quantity*sales.order_items.list_price)as 'revenue',
production.products.product_name, 
production.categories.category_name,
sales.stores.store_name,
concat(sales.staffs.first_name,' ',sales.staffs.last_name) as 'sales_rep'
from sales.orders 
join sales.customers 
on  sales.orders.customer_id=sales.customers.customer_id
join sales.order_items
on sales.orders.order_id = sales.order_items.order_id
join production.products
on sales.order_items.product_id= production.products.product_id
join production.categories
on production.products.category_id =production.categories.category_id
join sales.stores 
on sales.orders.store_id=sales.stores.store_id
join sales.staffs
on sales.orders.staff_id=sales.staffs.staff_id
group by
sales.orders.order_id,
concat(sales.customers.first_name,' ',sales.customers.last_name),
sales.customers.city,
sales.customers.state,
sales.orders.order_date,
production.products.product_name, 
production.categories.category_name,
sales.stores.store_name,
concat(sales.staffs.first_name,' ',sales.staffs.last_name);
