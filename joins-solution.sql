## Tasks
1. Get all customers and their addresses.
  SELECT "customers", "addresses" FROM "customers"
  JOIN "addresses" ON "customers".id = "addresses".customer_id;
  
2. Get all orders and their line items (orders, quantity and product).
  SELECT "orders".id, "line_items".quantity, "products".description FROM "orders"
  JOIN "line_items" ON "orders".id = "line_items".id
  JOIN "products" ON "line_items".product_id = "products".id;

3. Which warehouses have cheetos?
  SELECT "products".description, "warehouse".warehouse FROM "products"
  JOIN "warehouse_product" ON "products".id = "warehouse_product".product_id
  JOIN "warehouse" ON "warehouse_product".warehouse_id = "warehouse".id
  WHERE "products".description = 'cheetos';
  
4. Which warehouses have diet pepsi?
  SELECT "products".description, "warehouse".warehouse FROM "products"
  JOIN "warehouse_product" ON "products".id = "warehouse_product".product_id
  JOIN "warehouse" ON "warehouse_product".warehouse_id = "warehouse".id
  WHERE "products".description = 'diet pepsi';

5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
  SELECT CONCAT(first_name,' ',last_name) AS name, COUNT("orders") FROM "customers"
  JOIN "addresses" ON "customers".id = "addresses".customer_id
  LEFT JOIN "orders" ON "addresses".id = "orders".address_id
  GROUP BY name;

6. How many customers do we have?
  SELECT COUNT(*) FROM "customers";
  
7. How many products do we carry?
  SELECT COUNT(*) FROM "products";
  
8. What is the total available on-hand quantity of diet pepsi?
  SELECT SUM("warehouse_product".on_hand), "products".description FROM "warehouse_product"
  JOIN "products" ON "warehouse_product".product_id = "products".id
  WHERE "products".description = 'diet pepsi'
  GROUP BY "products".description;

## Stretch
9. How much was the total cost for each order?
  SELECT "orders".id, SUM("products".unit_price * "line_items".quantity) FROM "orders"
  JOIN "line_items" ON "orders".id = "line_items".order_id
  JOIN "products" ON "line_items".product_id = "products".id
  GROUP BY "orders".id;

10. How much has each customer spent in total?
  SELECT CONCAT(first_name,' ',last_name) AS customer, SUM("products".unit_price * "line_items".quantity) FROM "customers"
  JOIN "addresses" ON "customers".id = "addresses".customer_id
  JOIN "orders" ON "addresses".id = "orders".address_id
  JOIN "line_items" ON "orders".id = "line_items".order_id
  JOIN "products" ON "line_items".product_id = "products".id
  GROUP BY customer;

11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
