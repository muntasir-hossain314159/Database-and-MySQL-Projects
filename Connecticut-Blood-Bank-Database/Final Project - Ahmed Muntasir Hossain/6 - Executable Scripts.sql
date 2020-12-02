-- Organization: Connecticut Blood Bank 
-- Name: Ahmed Muntasir Hossain
-- Date: 30th of November, 2020
-- Database: blood_bank_db

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DDL Scripts (CREATE & ALTER)

CREATE DATABASE blood_bank_db; 
USE blood_bank_db;
SET SQL_SAFE_UPDATES = 0;
DROP TABLE IF EXISTS employees, branch, patient, patient_blood_bag, donor, donor_underlying_condition, donor_blood_bag, price, transfusion, blood_inventory, lab_equipments, incubators, storage_equipments, donation_equipments;
DROP VIEW IF EXISTS dbb;

CREATE TABLE employees (
						Employee_SSN			CHAR(9)			NOT NULL,			
						Employee_first_name		VARCHAR(50)		NOT NULL,
                        Employee_last_name		VARCHAR(50)		NOT NULL,
						Manager_SSN				CHAR(9), 							
                        Branch_ID				INT,								
																					
						PRIMARY KEY (Employee_SSN),
                        FOREIGN KEY (Manager_SSN) REFERENCES employees(Employee_SSN)
							ON UPDATE CASCADE
							ON DELETE CASCADE);
                        
CREATE TABLE branch (
					 ID							INT 			NOT NULL		  AUTO_INCREMENT,			
					 Street_address 		    VARCHAR(50)		NOT NULL,
                     City						VARCHAR(50)		NOT NULL,
                     State						VARCHAR(50)		NOT NULL,
                     Country					VARCHAR(50)		NOT NULL,
					 Zip_code					CHAR(5) 		NOT NULL		  UNIQUE,
					 Manager_SSN				CHAR(9), 												 
						
                     PRIMARY KEY (ID),										
                     FOREIGN KEY (Manager_SSN) REFERENCES employees(Manager_SSN)	
						 ON DELETE CASCADE
						 ON UPDATE CASCADE);
                     
ALTER TABLE employees ADD FOREIGN KEY(Branch_ID) REFERENCES branch(ID)
ON DELETE CASCADE
ON UPDATE CASCADE;  
                                    
CREATE TABLE patient (
					  ID							INT				NOT NULL		AUTO_INCREMENT,			
					  Patient_first_name			VARCHAR(50)		NOT NULL,
                      Patient_last_name				VARCHAR(50)		NOT NULL,		  
                      Blood_group					VARCHAR(3)		NOT NULL,								
																											
                      PRIMARY KEY (ID));

CREATE TABLE patient_blood_bag (
								Patient_ID					INT					NOT NULL,
                                Transfer_datetime 			DATETIME			NOT NULL,
								Branch_ID					INT					NOT NULL,
								Donor_blood_bag_ID			INT					NOT NULL,
                             
								PRIMARY KEY (Donor_blood_bag_ID),
                                CONSTRAINT Patient_blood_bag_info1
								FOREIGN KEY (Patient_ID) REFERENCES patient(ID)
									ON DELETE CASCADE
									ON UPDATE CASCADE,
								CONSTRAINT Patient_blood_bag_info2
                                FOREIGN KEY (Branch_ID) REFERENCES branch(ID)
									ON DELETE CASCADE
									ON UPDATE CASCADE);

CREATE TABLE donor (
					ID								INT				NOT NULL	AUTO_INCREMENT,				
					Donor_first_name				VARCHAR(50)		NOT NULL,										
                    Donor_last_name					VARCHAR(50)		NOT NULL,
                    Blood_group						VARCHAR(3)		NOT NULL,									 
                    
                    PRIMARY KEY (ID));
                    
CREATE TABLE donor_underlying_condition (
											Donor_ID						INT					NOT NULL,
											Stamp_Date 						DATETIME			NOT NULL,
                                            HIV_1							BOOL,													
											HIV_2							BOOL,													
											HTLV_I							BOOL, 
											HTLV_II							BOOL, 
											Hepatitis_C						BOOL,	
											Hepatitis_B						BOOL,
											West_Nile_Virus					BOOL,	 
											T_pallidum						BOOL,
											
                                            CHECK (	HIV_1 = 0 
													AND HTLV_I = 0							 
													AND HTLV_II = 0							 
													AND Hepatitis_C = 0							
													AND Hepatitis_B = 0						
													AND West_Nile_Virus = 0					
													AND T_pallidum= 0),
											PRIMARY KEY (Donor_ID, Stamp_Date),
											FOREIGN KEY (Donor_ID) REFERENCES donor(ID)
												ON DELETE CASCADE
												ON UPDATE CASCADE);
												
CREATE TABLE donor_blood_bag (
							 Blood_bag_ID				INT 				NOT NULL		AUTO_INCREMENT,
							 Donor_ID					INT					NOT NULL,
                             Receival_datetime 			DATETIME			NOT NULL,
                             Branch_ID					INT					NOT NULL,
							 Red_blood_cell				BOOL				NOT NULL,
                             Platelets					BOOL				NOT NULL,
							 Plasma						BOOL				NOT NULL,		
                             
                             PRIMARY KEY (Blood_bag_ID),
                             FOREIGN KEY (Donor_ID) REFERENCES donor(ID)
								 ON DELETE CASCADE
								 ON UPDATE CASCADE,
                             FOREIGN KEY (Branch_ID) REFERENCES branch(ID)
								 ON DELETE CASCADE
								 ON UPDATE CASCADE);
                             
                             
ALTER TABLE patient_blood_bag ADD CONSTRAINT Donor_blood_bag_info1 FOREIGN KEY (Donor_blood_bag_ID) REFERENCES donor_blood_bag(Blood_bag_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;
                             
CREATE TABLE price (
					Month_ID						INT				NOT NULL,		
                    Year_ID							INT				NOT NULL,		
					Branch_ID						INT				NOT NULL,
                    Branch_expense					DOUBLE(8,2)		NULL,		
					Unit_price_rb					DOUBLE(8,2)		NOT NULL,		
                    Unit_price_plas					DOUBLE(8,2)		NOT NULL,		
                    Unit_price_plat					DOUBLE(8,2)		NOT NULL,	    
                                     
                    PRIMARY KEY (Month_ID,Year_ID, Branch_ID),
                    FOREIGN KEY (Branch_ID) REFERENCES branch(ID)
						ON DELETE CASCADE
						ON UPDATE CASCADE);
                    
                                    
CREATE TABLE transfusion (
						  Transfusion_ID			INT		NOT NULL AUTO_INCREMENT,			
                          Patient_ID				INT		NOT NULL,
                          Donor_blood_bag_ID		INT		NOT NULL  	UNIQUE,					
						  
                          PRIMARY KEY (Transfusion_ID),
                          FOREIGN KEY (Patient_ID) REFERENCES patient(ID)
							  ON DELETE CASCADE
							  ON UPDATE CASCADE,
                          FOREIGN KEY (Donor_blood_bag_ID) REFERENCES donor_blood_bag(Blood_bag_ID)
							  ON DELETE CASCADE
							  ON UPDATE CASCADE);
                          
CREATE TABLE blood_inventory (
								Donor_blood_bag_ID		    INT				NOT NULL,
								Stamp_DATETIME				DATETIME		NOT NULL,
								Blood_bag_status			VARCHAR(14) 	NOT NULL,	-- "IN STORAGE", "LABORATORY", "OUT OF STORAGE".	
																						
								PRIMARY KEY (Donor_blood_bag_ID, Stamp_DATETIME),
								FOREIGN KEY (Donor_blood_bag_ID) REFERENCES donor_blood_bag(Blood_bag_ID)
									ON DELETE CASCADE
									ON UPDATE CASCADE);
                        
CREATE TABLE lab_equipments (
							 Microscope						INT			NOT NULL,
                             Microscope_slide_Cover_slip	INT 		NOT NULL,
                             Balance						INT			NOT NULL,
                             Thermometer        			INT			NOT NULL,
                             Plasma_extractor				INT			NOT NULL,
                             Cyrofuge						INT			NOT NULL,
                             Centrifuge						INT			NOT NULL,
                             Funnel							INT			NOT NULL,
                             Wash_bottle					INT			NOT NULL,
                             Pipettes						INT			NOT NULL,
                             Dropper_bottle					INT			NOT NULL,
                             Test_tube_Racks				INT			NOT NULL,
                             PPE							INT			NOT NULL,
                             Branch_ID						INT 		NOT NULL,
                             
                             PRIMARY KEY (Branch_ID),
                             FOREIGN KEY (Branch_ID) REFERENCES branch(ID)
								 ON DELETE CASCADE
								 ON UPDATE CASCADE);
                             
CREATE TABLE incubators (
							Platelet_incubator		INT			NOT NULL,
							Water_bath				INT			NOT NULL,
							Incubator				INT			NOT NULL,
							Branch_ID			    INT 		NOT NULL,
							
							PRIMARY KEY (Branch_ID),
							FOREIGN KEY (Branch_ID) REFERENCES branch(ID)
								ON DELETE CASCADE
								ON UPDATE CASCADE);
                             
CREATE TABLE storage_equipments (
								 Branch_ID			    	INT 		NOT NULL,
								 Ultralow_freezer_plasma	INT 		NOT NULL,
                                 Temperature_controlled_box	INT 		NOT NULL,
                                 Blood_Refrigerator			INT 		NOT NULL,
                                 
								 PRIMARY KEY (Branch_ID),
								 FOREIGN KEY (Branch_ID) REFERENCES branch(ID)
									 ON DELETE CASCADE
									 ON UPDATE CASCADE);
									
CREATE TABLE donation_equipments (
								 Branch_ID			    		INT 		NOT NULL,
								 Blood_bags						INT			NOT NULL,
								 Blood_donation_chair			INT 		NOT NULL,
								 Blood_shaker					INT			NOT NULL,
								 Blood_bag_tube_sealer        	INT			NOT NULL,
								 Scissor_forceps				INT			NOT NULL,
								 Instrument_trays				INT			NOT NULL,
								 Spirit_swab_bowl				INT			NOT NULL,
								 Packing_label					INT			NOT NULL,
                                 
								 PRIMARY KEY (Branch_ID),
								 FOREIGN KEY (Branch_ID) REFERENCES branch(ID)
									 ON DELETE CASCADE
									 ON UPDATE CASCADE);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DML Scripts (INSERT & UPDATE)

INSERT INTO branch
VALUES
		(0, '10 Boston Post Rd', 'West Haven', 'CT', 'USA', '06516', null),
        (0, '11 Campbell Ave', 'New Haven', 'CT', 'USA', '06517', null),
        (0, '13 West Street', 'Middleford', 'CT', 'USA', '06518', null),
        (0, '05 Terrace Ave', 'Stratford', 'CT', 'USA', '06519', null),
        (0, '1 Forrest Road', 'New Town', 'CT', 'USA', '06520', null);
   
INSERT INTO employees 
VALUES 
		(456289123, 'Lady', 'Gaga', null, 1), 			-- Lady Gaga is the manager, so she does not have a supervisor/manager. She works in branch 1 
        (544791234, 'Alfred', 'Butler', null, 5),		-- Alfred Butler is the manager, so he does not have a supervisor/manager. He works in branch 5 
        (123456789, 'John', 'Doe', null, 5), 			-- John Doe has Alfred Butler as the manager and works in the same branch under Alfred Butler
        (234567891, 'Muntasir', 'Hossain', null, 1), 	-- Muntasir Hossain has Lady Gaga as the manager and works in the same branch under Lady Gaga
        (345678912, 'Micheal', 'Claw', null, 2), 		-- manager has not been decided for this branch so the employee does not have a manager, but the employee works in branch 2
        (456789123, 'Ricky', 'Gervais', null, 3),       -- manager has not been decided for this branch so the employee does not have a manager, but the employee works in branch 3
		(132456789, 'Michael', 'Front', null, 5), 		-- Micheal Front has Alfred Butler as the manager and works in the same branch under Alfred Butler
        (234566891, 'Albert', 'Einstein', null, null), 	-- manager or branch has not been decided for this new employee
        (345688912, 'Shawn', 'Mendez', null, 1); 		-- Shawn Mendez has Lady Gaga as the manager and works in the same branch under Lady Gaga
        
UPDATE employees
SET
Manager_SSN = 544791234
WHERE Employee_SSN = 123456789;

UPDATE employees
SET
Manager_SSN = 456289123
WHERE Employee_SSN = 234567891;

UPDATE employees
SET
Manager_SSN = 544791234
WHERE Employee_SSN = 132456789;

UPDATE employees
SET
Manager_SSN = 456289123
WHERE Employee_SSN = 345688912;
 
UPDATE branch 
SET
Manager_SSN = 456289123
WHERE ID = 1;

UPDATE branch 
SET
Manager_SSN = 544791234
WHERE ID = 5;

INSERT INTO patient
VALUES
		(0, 'Joan', 'Ark', 'AB+'), 			-- ID 1
        (0, 'Fred', 'Douglas', 'B+'),		-- ID 2
        (0, 'Conan', 'Fames', 'B-'),   		-- ID 3
        (0, 'Arthur', 'Doyal', 'O+'),		-- ID 4
        (0, 'John', 'Douglas', 'A-'), 		-- ID 5
        (0, 'Dean', 'Jean', 'A+');   		-- ID 6
        
INSERT INTO donor
VALUES
		(0, 'Joe', 'Roth', 'O+'), 				-- ID : 1
        (0, 'Ryan', 'Star', 'B-'),				-- ID : 2
        (0, 'Clara', 'Smith', 'B-'),			-- ID : 3 
        (0, 'Loe', 'Shark', 'O+'),				-- ID : 4
        (0, 'Bilbo', 'Baggins', 'O-'),			-- ID : 5
		(0, 'George', 'Holtz' , 'A-');			-- ID : 6
         
INSERT INTO donor_underlying_condition
VALUES
		(1, '2020-01-01', 0, 0, 0, 0, 0, 0, 0, 0), -- the date on which the donor declares their underlying condition is the date the profile of the donor is completed
        (2, '2020-01-29', 0, 0, 0, 0, 0, 0, 0, 0), -- the time between which the underlying condition of a donor is declared and blood is donated must be within 5 days (dates are inclusive)
        (3, '2020-01-01', 0, 0, 0, 0, 0, 0, 0, 0),
        (4, '2020-01-03', 0, 0, 0, 0, 0, 0, 0, 0),
        (4, '2020-02-27', 0, 0, 0, 0, 0, 0, 0, 0),
        (5, '2020-02-13', 0, 0, 0, 0, 0, 0, 0, 0);
        
INSERT INTO donor_blood_bag					-- account of the donors had been set up in a particular order (donor_ID). It does not mean that they will donate blood in the same order or same/ascending  date
VALUES
		(0, 1, '2020-01-01', 5, 1, 0, 0),
        (0, 3, '2020-01-05', 2, 0, 1, 0), -- same branch
        (0, 2, '2020-02-01', 2, 0, 0, 1), -- same branch
        (0, 5, '2020-02-16', 1, 0, 1, 0),
        (0, 4, '2020-02-28', 3, 0, 0, 1), -- same donor
        (0, 4, '2020-01-07', 4, 0, 0, 1); -- same donor but the attendant forgot to put the data in the database. The manager inputted this value afterwards so the date is not in order (edge case).
										  -- the receival date does not have to be in order. A person adds a blood bag afterwards which had not been recorded before (edge case).
INSERT INTO patient_blood_bag
VALUES
		(1, '2020-03-03', 5, 2),
        (2, '2020-02-28', 3, 1),
        (3, '2020-03-01', 4, 3),
        (4, '2020-02-29', 2, 5),  
		(5, '2020-03-02', 1, 4);  

INSERT INTO blood_inventory
VALUES 
		(1, '2020-01-01', 'IN STORAGE'),
        (1, '2020-01-03', 'LABORATORY'),
        (2, '2020-01-05', 'IN STORAGE'),
        (2, '2020-01-07', 'LABORATORY'),
        (3, '2020-02-01', 'IN STORAGE'),
        (3, '2020-02-08', 'LABORATORY'),
        (4, '2020-02-16', 'IN STORAGE'),
        (4, '2020-02-17', 'LABORATORY'),
        (5, '2020-02-28', 'IN STORAGE'),
        (5, '2020-03-01', 'LABORATORY'),
        (6, '2020-01-07', 'IN STORAGE'), -- Bag ID 6 is 'In Storage'. Status unchanged
        
        (1, '2020-02-28', 'OUT OF STORAGE'),
        (2, '2020-03-03', 'OUT OF STORAGE'),
        (3, '2020-03-01', 'OUT OF STORAGE'),
        (4, '2020-03-02', 'OUT OF STORAGE'),
        (5, '2020-02-29', 'OUT OF STORAGE');
        
INSERT INTO transfusion 
VALUES
		(0, 1, 2),
        (default, 2, 1),
        (null, 3, 3),
        (0, 4, 5),
        (0, 5, 4);
        
INSERT INTO price
VALUES
        (1, 2020, 1, 20.1, 3.4, 2.6, 3.2),
        (2, 2020, 1, 21.1, 3.3, 2.3, 3.1),
		(3, 2020, 1, 19.1, 3.1, 2.5, 3.0),

        
        (1, 2020, 2, 20.2, 3.1, 2.5, 3.1),
		(2, 2020, 2, 20.3, 3.0, 2.2, 2.9),
		(3, 2020, 2, 20.1, 3.2, 2.7, 2.8),
        
        (1, 2020, 3, 23.6, 3.5, 2.2, 3.7),
        (2, 2020, 3, 24.6, 3.7, 2.3, 3.2),
        (3, 2020, 3, 25.6, 3.6, 2.1, 3.3),
        
        (1, 2020, 4, 25.7, 3.3, 2.7, 3.5),
        (2, 2020, 4, 26.7, 3.1, 2.2, 3.1),
        (3, 2020, 4, 26.1, 3.2, 2.5, 3.4),
        
        (1, 2020, 5, 21.3, 3.0, 2.3, 3.6),
		(2, 2020, 5, 20.3, 3.1, 1.9, 2.6),
        (3, 2020, 5, 21.7, 3.4, 1.8, 2.5);
        
INSERT INTO lab_equipments
VALUES
	   (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
       (2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 2),
       (1, 2, 5, 1, 1, 1, 2, 1, 6, 1, 3, 1, 7, 3),
       (0, 1, 1, 1, 2, 3, 1, 4, 5, 1, 1, 6, 17, 4),
       (1, 2, 14, 1, 10, 9, 8, 7, 6, 5, 4, 1, 2, 5);
       
INSERT INTO incubators
VALUES
		(1, 1, 1, 1),
        (1, 12, 3, 2),
        (5, 1, 2, 3),
        (1, 5, 1, 4),
        (2, 1, 9, 5);
        
INSERT INTO storage_equipments
VALUES
		(1, 3, 25, 6),
        (2, 3, 5, 6),
        (4, 3, 2, 16),
        (3, 13, 5, 6),
        (5, 3, 15, 6);
						
INSERT INTO donation_equipments
VALUES
	   (1, 1, 1, 1, 1, 5, 6, 7, 8),
       (2, 3, 4, 5, 5, 2, 3, 5, 1),
       (3, 1, 5, 1, 1, 3, 5, 1, 2),
       (4, 1, 1, 1, 2, 2, 3, 4, 4),
       (5, 2, 14, 1, 3, 2, 4, 1, 5);
       
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
                
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
    
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GROUP BY type

-- 1.
SELECT Donor_ID, SUM(Plasma) AS SUM_PLASMA, SUM(Red_blood_cell) AS SUM_RED_BLOOD_CELLS, 
SUM(Platelets) AS SUM_PLATELETS -- It is possible to sum booleans
FROM donor_blood_bag 
GROUP BY Donor_ID;

-- 2.
SELECT de.Branch_ID, br.City, 
(SUM(Blood_bags)+SUM(Blood_donation_chair)+SUM(Blood_shaker)+
SUM(Blood_bag_tube_sealer)+SUM(Scissor_forceps)+SUM(Instrument_trays)+
SUM(Spirit_swab_bowl)+SUM(Packing_label)) AS Total_Donation_Equipments
FROM donation_equipments AS de JOIN branch AS br
ON de.Branch_ID = br.ID
GROUP BY de.Branch_ID, br.City
HAVING Total_Donation_Equipments > 20; 

-- 3.
SELECT de.Branch_ID, br.City, 
(SUM(Blood_bags)+SUM(Blood_donation_chair)+SUM(Blood_shaker)+
SUM(Blood_bag_tube_sealer)+SUM(Scissor_forceps)+SUM(Instrument_trays)+
SUM(Spirit_swab_bowl)+SUM(Packing_label)) AS Total_Donation_Equipments
FROM donation_equipments AS de JOIN branch AS br
ON de.Branch_ID = br.ID
GROUP BY de.Branch_ID, br.City
HAVING Total_Donation_Equipments = (SELECT MAX(Total_Donation_Equipments)
										FROM (SELECT (SUM(Blood_bags)+SUM(Blood_donation_chair)+
													  SUM(Blood_shaker)+SUM(Blood_bag_tube_sealer)+
                                                      SUM(Scissor_forceps)+SUM(Instrument_trays)+
                                                      SUM(Spirit_swab_bowl)+SUM(Packing_label)) 
                                                      AS Total_Donation_Equipments
												FROM donation_equipments AS de 
												GROUP BY de.Branch_ID) AS Temp_SUM);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------