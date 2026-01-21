-- Data Transformation & Cleaning
-- Table: erp_csut_az12

INSERT INTO silver.erp_csut_az12 (
	cid,
	bdate,
	gen
)
SELECT 
	-- cid,
	CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
		 ELSE cid 
	END AS cid,
	CASE WHEN bdate > GETDATE() THEN NULL 
		ELSE bdate 
	END AS bdate,
	CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
		 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		 ELSE 'n/a'
	END AS gen
FROM bronze.erp_csut_az12;
