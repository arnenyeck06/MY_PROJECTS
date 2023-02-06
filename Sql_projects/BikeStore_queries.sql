SELECT * FROM sales.orders ord;

-- 
select ord.order_id,
CONCAT(cus.first_name, ' ', cus.last_name) as full_name,cus.city, cus.state, ord.order_date
from sales.orders ord
join sales.customers cus 
on ord.customer_id = cus.customer_id;

-- sales value and total volume generated
select ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name) as full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
	sum(soi.quantity) as 'qty_sold',
	sum(soi.quantity * soi.list_price) as 'Total_rev'
from sales.orders ord
join sales.customers cus 
on ord.customer_id = cus.customer_id
join sales.order_items soi on ord.order_id = soi.order_id
group by ord.order_id,
	full_name,
    cus.city, 
    cus.state, 
    ord.order_date;
    
    use production;
    use sales;
    
    -- Names of the products that were purchased.
  SELECT ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name) AS full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
	SUM(soi.quantity) AS 'qty_sold',
	SUM(soi.quantity * soi.list_price) AS 'Total_rev',
    pro.product_name
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items soi
ON ord.order_id = soi.order_id
JOIN  production.products pro
ON soi.product_id = pro.product_id
group by ord.order_id,
	full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
    pro.product_name;
    
    -- lets add the category of product purchased
	SELECT ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name) AS full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
	SUM(soi.quantity) AS 'qty_sold',
	SUM(soi.quantity * soi.list_price) AS 'Total_rev',
    pro.product_name, 
    cat.category_name
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items soi
ON ord.order_id = soi.order_id
JOIN  production.products pro
ON soi.product_id = pro.product_id
JOIN production.categories cat 
ON pro.category_id = cat.category_id
group by ord.order_id,
	full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
    pro.product_name,
    cat.category_name;
    
-- store at which the purchases took place.

    -- lets add the category of product purchased
	SELECT ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name) AS full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
	SUM(soi.quantity) AS 'qty_sold',
	SUM(soi.quantity * soi.list_price) AS 'Total_rev',
    pro.product_name, 
    cat.category_name,
    sto.store_name
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items soi
ON ord.order_id = soi.order_id
JOIN  production.products pro
ON soi.product_id = pro.product_id
JOIN production.categories cat 
ON pro.category_id = cat.category_id
JOIN sales.stores sto 
ON ord.store_id = sto.store_id
group by ord.order_id,
	full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
    pro.product_name,
    cat.category_name,
    sto.store_name;
    
    -- let's add the sale's rep tha made the sale.
    -- ** Since the names are in separete fields, we use CONCAT
    
	SELECT ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name) AS full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
	SUM(soi.quantity) AS 'qty_sold',
	SUM(soi.quantity * soi.list_price) AS Total_rev,
    pro.product_name, 
    cat.category_name,
    sto.store_name,
    CONCAT(sta.first_name, ' ', sta.last_name) AS salesrep
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items soi
ON ord.order_id = soi.order_id
JOIN  production.products pro
ON soi.product_id = pro.product_id
JOIN production.categories cat 
ON pro.category_id = cat.category_id
JOIN sales.stores sto 
ON ord.store_id = sto.store_id
JOIN sales.staffs sta
ON ord.staff_id = sta.staff_id
group by ord.order_id,
	full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
    pro.product_name,
    cat.category_name,
    sto.store_name,
    salesrep;
    
     -- lets add the brand names 
     
         
	SELECT ord.order_id,
	CONCAT(cus.first_name, ' ', cus.last_name) AS full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
	SUM(soi.quantity) AS 'qty_sold',
	SUM(soi.quantity * soi.list_price) AS Total_rev,
    pro.product_name, 
    cat.category_name,
    sto.store_name,
    bra.brand_name,
    CONCAT(sta.first_name, ' ', sta.last_name) AS salesrep
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items soi
ON ord.order_id = soi.order_id
JOIN  production.products pro
ON soi.product_id = pro.product_id
JOIN production.categories cat 
ON pro.category_id = cat.category_id
JOIN sales.stores sto 
ON ord.store_id = sto.store_id
JOIN sales.staffs sta
ON ord.staff_id = sta.staff_id
Join production.brands bra
On pro.product_id = bra.brand_id
group by ord.order_id,
	full_name,
    cus.city, 
    cus.state, 
    ord.order_date,
    pro.product_name,
    cat.category_name,
    sto.store_name,
    bra.brand_name,
    salesrep;