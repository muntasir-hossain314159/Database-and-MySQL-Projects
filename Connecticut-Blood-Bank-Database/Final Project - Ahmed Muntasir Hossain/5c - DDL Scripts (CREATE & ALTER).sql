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