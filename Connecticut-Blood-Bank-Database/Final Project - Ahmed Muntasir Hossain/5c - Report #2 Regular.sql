-- Regular

-- 1.
SELECT Branch_ID, SUM(Branch_expense) AS COST -- Total expense over 3 months for each branch
			FROM price
			GROUP BY Branch_ID;
-- 2.
SELECT Donor_ID
FROM donor_underlying_condition
	WHERE HIV_1 = 1 
	OR HTLV_I = 1							 
	OR HTLV_II = 1							 
	OR Hepatitis_C = 1							
	OR Hepatitis_B = 1						
	OR West_Nile_Virus = 1					
	OR T_pallidum= 1;

-- 3. Avg unit price of each component over 3 months for each branch
SELECT Branch_ID, AVG(Unit_price_rb) AS Avg_unit_price_Rb, 
AVG(Unit_price_plas) AS Avg_unit_price_plas, AVG(Unit_price_plat) AS Avg_unit_price_plat
	FROM price
	GROUP BY Branch_ID;