CREATE VIEW gold.dim_customers AS
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name,
ci.cst_lastname AS last_name,
la.cntry AS country,
ci.cst_marital_status AS marital_status,
CASE 
	WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the Master for the Gender Info
	ELSE COALESCE(ca.gen, 'n/a')
END AS gender,
ca.bdate AS birthdate,
ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
	LEFT JOIN silver.erp_csut_az12 ca ON ca.cid = ci.cst_key
	LEFT JOIN silver.erp_lock_a101 la ON la.cid = ci.cst_key;
