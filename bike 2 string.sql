select*from OrderItem;

select productid, productname,quantity,product.UnitPrice
from orderitem join Product
on OrderItem.Id=Product.Id
order by ProductName;

select productname,max(quantity) sales
from product join OrderItem
on OrderItem.Id=Product.Id
group by ProductName
having max(quantity)>50
order by sales desc

;

select*from Orders;

select YEAR(OrderDate)year,count(*) 'count of orders',sum(totalamount) sales,
case
when sum(TotalAmount)>300000 then 'we did it'
else 'dont'
end
from Orders
group by YEAR(OrderDate);

select DATEFROMPARTS(day,month,year);

select*from sales.orders;

select order_id,customer_id,order_date,
dateadd(day,3,order_date) stimated_shabed_date
from sales.orders
order by stimated_shabed_date;

--string function
 select charindex('sql','i really like sql and i wont to master it');

 select len('kareem hossam     ') lengh;



 SELECT
    product_name,
    LEN(product_name) product_name_length,
	case 
	when LEN(product_name) >35 then 'too long' 
	else 'good' 
	end as char_length
FROM
    production.products
	where case 
	when LEN(product_name) >35 then 'too long' 
	else 'good' 
	end = 'too long'
	
ORDER BY
    LEN(product_name) DESC;
	begin
	update sales.customers
	set
	phone = replace(phone,'(916)','(917)')
	where phone is not null;

	select phone from sales.customers
	where phone  like '(917)%';
	
	select 
	SUBSTRING(email,charindex('@',email)+1,len(email)-charindex('@',email))domain,
	count(email) count
	
	from sales.customers
	
	group by SUBSTRING(email,charindex('@',email)+1,len(email)-charindex('@',email)) ;
