-- 1. Get all customers and their addresses.
SELECT * 
FROM customers
JOIN addresses
	ON customers.id=addresses.customer_id;

-- 2. Get all orders and their line items (orders, quantity and product).
SELECT * 
FROM orders
JOIN line_items
	ON orders.id = line_items.order_id;

-- 3. Which warehouses have cheetos?
SELECT warehouse.warehouse
FROM warehouse
JOIN warehouse_product
	ON warehouse.id = warehouse_product.warehouse_id
JOIN products
	ON warehouse_product.product_id = products.id
WHERE products.description = 'cheetos';

-- 4. Which warehouses have diet pepsi?
SELECT warehouse.warehouse
FROM warehouse
JOIN warehouse_product
	ON warehouse.id = warehouse_product.warehouse_id
JOIN products
	ON warehouse_product.product_id = products.id
WHERE products.description = 'diet pepsi';

-- 5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT
	customers.id as customerId,
	customers.first_name,
	customers.last_name, 
	count(orders.id) as numOfOrders
FROM orders
JOIN addresses
	ON orders.address_id = addresses.id
JOIN customers
	ON addresses.customer_id = customers.id
GROUP BY customers.id;

-- 6. How many customers do we have?
SELECT 
	count(customers.id) as number_of_customers 
FROM customers;

-- 7. How many products do we carry?
SELECT 
	count(products.id) as number_of_products
FROM products;

-- 8. What is the total available on-hand quantity of diet pepsi?
SELECT 
	products.description,
	sum(line_items.quantity) as totalQuantity
FROM products
JOIN line_items
	ON products.id = line_items.product_id
WHERE products.description = 'diet pepsi'
GROUP BY products.description;

---- STRETCH ----

-- 9. How much was the total cost for each order?
SELECT 
	orders.id,
	sum(products.unit_price * line_items.quantity) as totalCost
FROM orders
JOIN line_items
	ON orders.id = line_items.order_id
JOIN products
	ON line_items.product_id = products.id
GROUP BY orders.id
ORDER BY orders.id;


-- 10. How much has each customer spent in total?
SELECT 
	addresses.customer_id,
	sum(products.unit_price * line_items.quantity) as totalCost
FROM addresses
JOIN orders
	ON addresses.id = orders.address_id
JOIN line_items
	ON orders.id = line_items.order_id
JOIN products
	ON line_items.product_id = products.id
GROUP BY addresses.customer_id;