-- Sub queries

-- 1.
SELECT AVG(Temp.SUM_expense) AS Average_expense_of_all_Branches_2_Months
FROM (SELECT SUM(price.Branch_expense) AS SUM_expense
				FROM price
                WHERE Year_ID = 2020 AND Month_ID >= 1 AND Month_ID <= 2
				GROUP BY Branch_ID) AS Temp;
                
-- 2.
SELECT d.ID, d.Donor_first_name, d.Donor_last_name, Blood_bag_ID
FROM donor d JOIN donor_blood_bag
ON d.ID = donor_blood_bag.Donor_ID
WHERE donor_blood_bag.Blood_bag_ID IN (SELECT dbb.Blood_bag_ID
										FROM donor_blood_bag as dbb
										WHERE dbb.Blood_bag_ID NOT IN (SELECT t.Donor_blood_bag_ID
																			FROM transfusion t));