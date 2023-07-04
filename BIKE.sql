create database bike
go
use bike
go
CREATE SCHEMA production;
go

CREATE SCHEMA sales;
go

-- create tables
CREATE TABLE production.categor (
	category_id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.brand (
	brand_id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.product (
	product_id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.customers (
	customer_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.stores (
	store_id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.staffs (
	staff_id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.orders (
	order_id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

select * from production.products;

select product_name,list_price
from production.products
where product_name like '%hawaii%';

select first_name,last_name,city
from sales.customers
order by
city,
first_name asc ;



select * from production.products

select product_name,list_price
from production.products
order by list_price desc;

select first_name , last_name,email,order_id,order_date,store_id
from sales.customers c , sales.orders o
where c.customer_id = o.customer_id;

select first_name,last_name,order_id,order_date,store_name
from sales.staffs,sales.orders,sales.stores
where sales.staffs.staff_id = sales.orders.staff_id and sales.orders.store_id = sales.stores.store_id;

select first_name,last_name,email,order_id,order_status,order_date
from sales.staffs,sales.orders
where sales.staffs.staff_id = sales.orders .staff_id;

select first_name,last_name,sales.customers.email,order_id,order_date,sales.orders.store_id,store_name
from sales.customers,sales.orders,sales.stores
where sales.customers.customer_id=sales.orders.order_id and sales.orders.store_id = sales.stores.store_id
order by store_name,
first_name;

select sales.customers.customer_id, first_name,last_name,email,order_id,order_date,store_id
from sales.customers left outer join sales.orders
on sales.customers.customer_id = sales.orders.customer_id
order by sales.customers.customer_id desc;

select * from sales.customers
order by customer_id desc;

select* from sales.orders
order by customer_id asc;

select first_name,last_name,email,order_id,order_date,store_id
from sales.customers inner join sales.orders
on sales.customers.customer_id = sales.orders.customer_id
order by first_name;

select first_name,last_name,sales.customers.email,order_id,order_date,sales.orders.store_id
from sales.customers left outer join sales.orders
on sales.customers.customer_id = sales.orders.customer_id
order by sales.customers.customer_id desc;

select  first_name+' '+last_name as 'full name',sales.orders.order_id,sales.order_items.product_id,product_name,store_name,sales.order_items.list_price,brand_name
from sales.customers,sales.orders,sales.order_items,production.products,sales.stores,production.brands
where sales.customers.customer_id = sales.orders.customer_id and sales.orders.order_id = sales.order_items.order_id and sales.order_items.product_id = production.products.product_id
;

select first_name+' '+last_name as'full name', brand_name
from sales.customers,sales.orders,sales.order_items,production.products,production.brands
where sales.customers.customer_id=sales.orders.order_id and sales.orders.order_id = sales.order_items.order_id and
sales.order_items.product_id = production.products.product_id and production.products.brand_id = production.brands.brand_id
order by first_name;


