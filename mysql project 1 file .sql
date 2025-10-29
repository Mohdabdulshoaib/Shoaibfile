SELECT * FROM customer;
SELECT * FROM customer LIMIT 10;
SELECT 
    SUM(CASE WHEN invoice_no IS NULL THEN 1 ELSE 0 END) AS null_invoice,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS null_payment,
    SUM(CASE WHEN invoice_date IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN shopping_mall IS NULL THEN 1 ELSE 0 END) AS null_mall
FROM customer;
UPDATE customer SET gender = 'Male' WHERE gender IN ('M','male','MALE');
UPDATE customer SET gender = 'Female' WHERE gender IN ('F','female','FEMALE');
ALTER TABLE customer_data ADD COLUMN revenue DECIMAL(10,2);


ALTER TABLE customer ADD COLUMN revenue DECIMAL(10,2);

UPDATE customer
SET revenue = quantity * price;
SELECT * FROM customer LIMIT 20;
SELECT gender, 
       SUM(quantity * price) AS total_revenue
FROM customer
GROUP BY gender;
SELECT gender, COUNT(customer_id) AS total_customers
FROM customer
GROUP BY gender;
SELECT 
    SUM(quantity)  AS total_products_sold
FROM customer
group by gender;
SELECT DISTINCT 
    gender,
    SUM(quantity)  AS total_products_sold
FROM customer group by gender;