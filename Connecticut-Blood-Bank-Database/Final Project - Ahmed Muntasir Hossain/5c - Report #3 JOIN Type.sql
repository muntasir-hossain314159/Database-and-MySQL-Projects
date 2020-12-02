-- JOIN type

-- 1.
SELECT e.Employee_SSN, CONCAT(e.Employee_first_name, ' ', e.Employee_last_name) AS Employee,
m.Employee_SSN AS Manager_SSN, CONCAT(m.Employee_first_name, ' ' , m.Employee_last_name) AS Manager, 
b.ID AS Branch_ID, 
CONCAT(b.Street_address, ', ', b.City, ', ', b.State,' - ', b.Zip_code, ', ', b.Country) AS Branch_address
FROM employees AS e JOIN employees AS m
ON e.Manager_SSN = m.Employee_SSN
JOIN branch AS b 
ON e.Manager_SSN = b.Manager_SSN; 

-- 2.
SELECT e.Employee_SSN, CONCAT(e.Employee_first_name, ' ', e.Employee_last_name) AS Employee, 
m.Employee_SSN AS Manager_SSN, CONCAT(m.Employee_first_name, ' ' , m.Employee_last_name) AS Manager, 
b.ID AS Branch_ID, 
CONCAT(b.Street_address, ', ', b.City, ', ', b.State,' - ', b.Zip_code, ', ', b.Country) AS Branch_address
FROM employees AS e LEFT OUTER JOIN employees AS m
ON e.Manager_SSN = m.Employee_SSN
LEFT OUTER JOIN branch AS b 
ON e.Branch_ID = b.ID; 

-- 3.
CREATE VIEW dbb AS 
SELECT d.ID, d.Donor_first_name, d.Donor_last_name, db.Blood_bag_ID
FROM donor AS d LEFT OUTER JOIN donor_blood_bag as db
ON 	d.ID = db.Donor_ID;

-- SELECT * FROM dbb; 	-- To see the view, please remove the comment (--)

SELECT dbb.Donor_first_name, dbb.Donor_last_name, dbb.ID AS donor_ID, 
dbb.Blood_bag_ID, t.Donor_blood_bag_ID AS Transfusion_BB_ID, 
p.ID AS patient_ID, p.Patient_first_name, p.Patient_last_name
FROM dbb LEFT OUTER JOIN transfusion as t
ON dbb.Blood_bag_ID = t.Donor_blood_bag_ID
LEFT OUTER JOIN patient as p
ON t.Patient_ID = p.ID
UNION
SELECT dbb.Donor_first_name, dbb.Donor_last_name, dbb.ID AS donor_ID, dbb.Blood_bag_ID, 
t.Donor_blood_bag_ID AS Transfusion_BB_ID, p.ID AS patient_ID, p.Patient_first_name, p.Patient_last_name
FROM dbb RIGHT OUTER JOIN transfusion as t
ON dbb.Blood_bag_ID = t.Donor_blood_bag_ID
RIGHT OUTER JOIN patient as p
ON t.Patient_ID = p.ID;