USE blood_bank_db;
SET SQL_SAFE_UPDATES = 0;
DROP TABLE IF EXISTS employees, branch, patient, patient_blood_bag, donor, donor_blood_bag, price, transfusion, blood_inventory, lab_equipments, incubators, storage_equipments, donation_equipments;
 
CREATE TABLE employees (
						Employee_SSN			CHAR(9)			NOT NULL,			-- Employee_SSN is not NULL since it is a primary key. NOT NULL is mentioned to reinforce information	
						Employee_first_name		VARCHAR(50)		NOT NULL,
                        Employee_last_name		VARCHAR(50)		NOT NULL,
						Manager_SSN				CHAR(9),   							     	
						Manager_first_name		VARCHAR(50),						-- Manager may not exist, therefore it is set to NULL. Manager_SSN is set to NULL to follow branch. A default value can exist for name, however, it would not follow the convention for branch, which is null, for non-existent value. Default would cause the non-existent value to be the default value.
                        Manager_last_name 		VARCHAR(50),
                        Branch_ID				INT,								-- It can be null since the branch of an employee may be undecided.
                        
						PRIMARY KEY (Employee_SSN),
						FOREIGN KEY (Manager_SSN) REFERENCES employees(Employee_SSN)
						ON UPDATE CASCADE
                        ON DELETE CASCADE);

CREATE TABLE branch (
					 ID							INT 			NOT NULL		  AUTO_INCREMENT,			
					 Street_address 		    VARCHAR(50)		NOT NULL,
                     City						VARCHAR(50)		NOT NULL, 			
					 Zip_code					CHAR(5) 		NOT NULL		  UNIQUE,
					 Manager_SSN				CHAR(9), 												-- Initially, in branch a Manager might not be present/decided (NULL). Manager_SSN can be NULL since it is a foreign key. Removed Default value, as that requires Manager_SSN data to be present in referenced table, employee. 
						
                     PRIMARY KEY (ID),										
                     FOREIGN KEY (Manager_SSN) REFERENCES employees(Employee_SSN)	
                     ON DELETE CASCADE
					 ON UPDATE CASCADE);
                     
ALTER TABLE employees ADD FOREIGN KEY(Branch_ID) REFERENCES branch(ID)
ON DELETE CASCADE
ON UPDATE CASCADE; 
                                    
CREATE TABLE patient (
					  ID							INT				NOT NULL		AUTO_INCREMENT,			-- ID is a primary key and auto_increment. It is NOT NULL by default. Specified to reinforce information.
					  Patient_first_name			VARCHAR(50)		NOT NULL,
                      Patient_last_name				VARCHAR(50)		NOT NULL,		  
                      Blood_group					VARCHAR(3)		NOT NULL,								
                      Underlying_condition			VARCHAR(50)		DEFAULT 'No underlying condition.',		-- Default value set to input the statement if it is blank.
                                    
                      PRIMARY KEY (ID));

CREATE TABLE patient_blood_bag (
								Patient_ID					INT					NOT NULL,
                                Transfer_datetime 			DATETIME			NOT NULL,
								Branch_ID					INT					NOT NULL,
								Donor_blood_bag_ID			INT					NOT NULL,
												
                             
								PRIMARY KEY (Patient_ID, Transfer_datetime),
                                CONSTRAINT Patient_blood_bag_info1
								FOREIGN KEY (Patient_ID) REFERENCES patient(ID)
								ON DELETE CASCADE
								ON UPDATE CASCADE,
								CONSTRAINT Patient_blood_bag_info2
                                FOREIGN KEY (Branch_ID) REFERENCES branch(ID)
								ON DELETE CASCADE
								ON UPDATE CASCADE);

CREATE TABLE donor (
					ID								INT				NOT NULL	AUTO_INCREMENT,				-- ID is a primary key and auto_increment. It is NOT NULL by default. Specified to reinforce information.
					Donor_first_name				VARCHAR(50)		NOT NULL,										
                    Donor_last_name					VARCHAR(50)		NOT NULL,
                    Blood_group						VARCHAR(3)		NOT NULL,									 
                    Underlying_condition			VARCHAR(50)		DEFAULT 'No Underlying Condition.', 	-- Default value set to input the statement if the input is blank.

                    PRIMARY KEY (ID));

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
					Month_ID						INT				NOT NULL,		-- NOT NULL since all this information must be present.
                    Year_ID							INT				NOT NULL,		#  Month and Year ID could be a stamp (date), check possible options.
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
						  Transfusion_ID			INT		NOT NULL AUTO_INCREMENT,			-- All information is required for a transfusion.
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

INSERT INTO branch
VALUES
		(0, '10 Boston Post Rd', 'West Haven', '06516', null),
        (0, '11 Campbell Ave', 'New Haven', '06517', null),
        (0, '13 West Street', 'Middleford', '06518', null),
        (0, '05 Terrace Ave', 'Stratford', '06519', null),
        (0, '1 Forrest Road', 'New Town', '06520', null);
   
INSERT INTO employees 
VALUES 
		(456289123, 'Lady', 'Gaga', null, null, null, 1), 			-- Lady Gaga is the manager, so she does not have a supervisor/manager. She works in branch 1 
        (544791234, 'Alfred', 'Butler', null, null, null, 5),		-- Alfred Butler is the manager, so he does not have a supervisor/manager. He works in branch 5 
        (123456789, 'John', 'Doe',  544791234, 'Alfred', 'Butler', 5), -- John Doe has Alfred Butler as the manager and works in the same branch under Alfred Butler
        (234567891, 'Muntasir', 'Hossain', 456289123, 'Lady', 'Gaga', 1), -- Muntasir Hossain has Lady Gaga as the manager and works in the same branch under Lady Gaga
        (345678912, 'Micheal', 'Claw', null, null, null, 2), 		--  manager has not been decided for this branch so the employee does not have a manager, but the employee works in branch 2
        (456789123, 'Ricky', 'Gervais', null, null, null, 3),       --  manager has not been decided for this branch so the employee does not have a manager, but the employee works in branch 3
		(132456789, 'Michael', 'Front', 544791234, 'Alfred', 'Butler', 5), -- Micheal Front has Alfred Butler as the manager and works in the same branch under Alfred Butler
        (234566891, 'Albert', 'Einstein', null, null, null, null), 	-- manager or branch has not been decided for this new employee
        (345688912, 'Shawn', 'Mendez', 456289123, 'Lady', 'Gaga', 1); -- Shawn Mendez has Lady Gaga as the manager and works in the same branch under Lady Gaga
  
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
		(0, 'Joan', 'Ark', 'AB+', DEFAULT),
        (0, 'Fred', 'Douglas', 'B+', DEFAULT),
        (0, 'Conan', 'Fames', 'B-', DEFAULT),
        (0, 'Arthur', 'Doyal', 'O+', DEFAULT),
        (0, 'John', 'Douglas', 'AB+', DEFAULT);
INSERT INTO donor
VALUES
		(0, 'Joe', 'Roth', 'O+', 'Smokes'), 			-- ID : 1
        (0, 'Ryan', 'Star', 'AB+', 'Heart Defect'),		-- ID : 2
        (0, 'Clara', 'Smith', 'B-', DEFAULT),			-- ID : 3
        (0, 'Loe', 'Shark', 'A+', DEFAULT),				-- ID : 4
        (0, 'Bilbo', 'Baggins', 'O-', DEFAULT);			-- ID : 5
                
INSERT INTO donor_blood_bag					-- just because an account had been set up in a particular oder (donor_ID), it does not mean that they will donate blood in the same order or same/ascending  date
VALUES
		(0, 1, '2020-01-01', 5, 1, 0, 0),
        (0, 3, '2020-01-05', 2, 0, 1, 0), -- same branch
        (0, 2, '2020-02-01', 2, 0, 0, 1), -- same branch
        (0, 5, '2020-02-16', 1, 0, 1, 0),
        (0, 4, '2020-02-28', 3, 0, 0, 1), -- same donor
        (0, 4, '2020-01-07', 4, 0, 0, 1); -- same donor but the attendant forgot to put the data in the database. The manager inputted this value afterwards so the date is not in order. Edge case.
										  -- the receival date does not have to be in order. A person add a blood bag afterwards which had not been recorded before. Edge case.
INSERT INTO patient_blood_bag
VALUES
		(1, '2020-03-03', 5, 5),
        (2, '2020-02-28', 3, 3),
        (3, '2020-03-01', 4, 2),
        (4, '2020-02-01', 2, 1), -- same patient, different branch. Patient receives two blood bags 
		(4, '2020-03-02', 1, 4); -- same patient, different branch. Patient receives two blood bags 

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
        (6, '2020-01-07', 'IN STORAGE'), -- Bag ID 6 is still in storage
        
        (1, '2020-02-01', 'OUT OF STORAGE'),
        (2, '2020-03-01', 'OUT OF STORAGE'),
        (3, '2020-02-28', 'OUT OF STORAGE'),
        (4, '2020-03-02', 'OUT OF STORAGE'),
        (5, '2020-03-03', 'OUT OF STORAGE');
        
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
        (1, 2020, 2, 20.2, 3.1, 2.5, 3.1),
        (1, 2020, 3, 23.6, 3.5, 2.2, 3.7),
        (1, 2020, 4, 25.7, 3.3, 2.7, 3.5),
        (1, 2020, 5, 21.3, 3.0, 2.3, 3.6);

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
       
SELECT * FROM blood_inventory;
SELECT * FROM branch;
SELECT * FROM donation_equipments;
SELECT * FROM donor;
SELECT * FROM donor_blood_bag;
SELECT * FROM employees;
SELECT * FROM incubators;
SELECT * FROM lab_equipments;
SELECT * FROM patient;
SELECT * FROM patient_blood_bag;
SELECT * FROM price;
SELECT * FROM storage_equipments;
SELECT * FROM transfusion;

-- -------------------------------------------------------------------------------------------------------------------------------
/*
SELECT Employee_SSN, Employee_first_name
FROM employees
WHERE Employee_first_name IN ('John', 'Muntasir');

UPDATE employees
SET 
Manager_SSN = '123456789',
Manager_first_name = 'John',
Manager_last_name = 'Doe'
WHERE Employee_SSN = '234567891';

UPDATE branch
SET Manager_SSN = '123456789'
WHERE Street_address = '10 Boston Post Rd';
*/

-- Information (PLEASE IGNORE):   
-- City_location is not null since the donor must go to a particular branch. This model assumes that a particualr branch is set up initially with null values for Patient_ID and Donor_ID.
#  there might not be a manager (NULL) in employee table*/
#  branch(city) == patient(City_location)*/ 
#  If the quantity in storage is less than the required amount, do not allow user to input patient data*/
#  If patient is not in the same city as the blood bank, do not allow user to input patient data*/
#  Should be able to compare the quantity of bags of a particular blood group required by a patient with the quantity in storage*/
#  The city in patient must match with the branches available in CT*/
#  Qty_rb*unitP_rb + Qty_plat*unitP_plat + Qty_plas*unitP_plas = price of blood bags for patient*/ -- The equation is still in progress. Select columns from another price table and multiply with Qty values in patient table
-- This database assumes that all branches are created in the database after atleast one patient has gone to that branch
-- first patient then branch then employee or first employee, then patient, then branch
#  Check how to create a table for profit as mentioned by Professor Theokritoff

# UPDATE: This database allows the following order: Employees/Branch, Branch/Employees, Donor/Patient, Patient/Donor, transfusion/price, price/transfusion.
  -- City_location must be not null since the patient must go to a particular branch. This model assumes that a particualr branch is set up initially with null values for Patient_ID and Donor_ID.
# Use the date to trigger a sum of the price values of all the patients. The date should be used by the Month and Year ID (in the Price table) to trigger a sum each month.
                                    
#  Patient must be in the same city as the blood bank, to allow user to input patient (City_location) data. This database assumes that the patient would go to the hospital nearest to their location. Therefore, the patient must be in the same location as the blood bank.
-- Stamp is not NULL since it is a primary key. NOT NULL is mentioned to reinforce information.                          
-- City is not NULL since it is a primary key. NOT NULL is mentioned to reinforce information.	
-- INSERT INTO branch (City, Stamp) VALUES ('West Haven', '2020-09-13');

-- Branch ID is 9 characters. It can be null since the branch of an employee may be undecided.
-- Updated daily to give the current status of the blood banks.
#  Quanitity should automatically update with quanitity supplied by donor to a particular branch. Should use the Receival date from donor and stamp from branch to update values. Could use switch statement to decide appropriate field to be updated for Qty_Blood_Group of donor.
#  Should be able to compare the quantity of bags of a particular blood group required by a patient with the quantity in Branch#  Patient should not be able to retrieve quanitity if it is more than the quanity in the respective branch          
#  Should be able to compare the quantity of bags of a particular blood group required by a patient with the quantity in Branch
#  Patient should not be able to retrieve quanitity if it is more than the quanity in the respective branch
# Price = Qty * unit price from Price().
#  Sum the value of patient (Price) for a month and subtract blood storage price, lab cost, and price of bag, for profit each month.
/*
UPDATE employees
SET Employee_SSN = '012345678'
WHERE Employee_SSN = '123456789'; 
*/