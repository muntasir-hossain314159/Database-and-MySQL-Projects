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