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