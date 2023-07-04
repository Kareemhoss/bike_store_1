select*from sales.customers;

select  first_name,last_name,sales.orders.order_id,order_date,sales.stores.store_id,store_name,brand_name,sales.order_items.list_price,sales.customers.email
from sales.customers,sales.orders,sales.stores,sales.order_items,production.products,production.brands
where sales.customers.customer_id=sales.orders.customer_id and sales.orders.store_id = sales.stores.store_id and sales.orders.order_id = sales.order_items.order_id
and sales.order_items.product_id = production.products.product_id and production.products.brand_id = production.brands.brand_id and sales.customers.email like '%yahoo.com%'
order by first_name;

select first_name,email
from sales.customers
where email like '%yahoo.com%'
order by first_name;

select*from production.products;

select
sum  (list_price) avg_product_price
from production.products;

	select max (list_price) max_price , min (list_price) min_price, avg (list_price) avg_price , SUM (list_price) sum_prices,
	count (*) product_no
	from production.products
	where category_id = 3;

	select 
	max (order_date) last_order , min (order_date) first_order, count (*) orders_count
	from sales.orders
	where customer_id=110
	;
	select category_name, count(*) count_orders,max(list_price) max_price,min(list_price) min_price,avg(list_price) avg_price
	from production.products join production.categories
	on production.products.category_id = production.categories.category_id
	group by category_name;

	select brand_name, count(*)'orders no',max(list_price)'max price',min(list_price) 'min price'
	from production.brands join production.products
	on production.brands.brand_id=production.products.brand_id
	group by brand_name
	having count(*) <10;

	select first_name, count (*)'orders no',max (order_date)'last order',min (order_date)'first order'
	from sales.orders join sales.customers
	on sales.orders.customer_id = sales.customers.customer_id
	group by first_name
	having count (*)>=4;

	select production.categories.category_name, count(*) count_orders,max(list_price) max_price,min(list_price) min_price,avg(list_price) avg_price
	from production.products join production.categories
	on production.products.category_id=production.categories.category_id
	group by production.categories.category_name
	;

	select store_name,count (*) orders
	from sales.stores s join sales.orders o
	on s.store_id=o.store_id
	group by store_name
	having count (*) > 400
	order by orders desc;
	
	select brand_name,count (*) orders
	from production.brands b join production.products p
	on b.brand_id = p.brand_id join sales.order_items oi
	on p.product_id = oi.product_id
	group by brand_name
	having count (*) > 1000
	order by count (*) desc
	;

	select top 10
	product_name,list_price
	from production.products
	order by list_price desc;

	select top 5 percent
	product_name,list_price
	from production.products
	order by list_price desc;

	select top 3 WITH TIES
	PRODUCT_NAME,
	LIST_PRICE
	FROM production.products
	ORDER BY list_price DESC;
create view sales.product_inf
as
	select product_name,brand_name,list_price
	from production.products p join production.brands b
	on p.brand_id =b.brand_id;

	select*from sales.product_inf;
	drop view sales.product_inf;


	create view sales.product_info
	as
	select product_id,product_name,list_price,brand_name,category_name
	from production.products p,production.brands b,production.categories c
	where p.brand_id=b.brand_id and p.category_id = c.category_id;

	select product_id,product_name,list_price from sales.product_info
	where list_price > 500;

	update production.products
	set list_price = 760
	where product_id = 2;
	
	alter view sales.product_info
	as select*from production.products;

	


	
