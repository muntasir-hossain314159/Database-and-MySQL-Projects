-- QUERIES BEGIN HERE:

-- Answer 1.
SELECT e.Fname, e.Minit, e.Lname
FROM employee e
WHERE e.Salary > 27000;

-- Answer 2.
SELECT e.Fname, e.Lname, e.Address
FROM employee e
WHERE e.Ssn IN (SELECT T1.emloyees_without_daughter_Ssn
					FROM (SELECT e.Ssn AS emloyees_without_daughter_Ssn
								FROM  employee e
								WHERE e.Ssn NOT IN (SELECT e.Ssn
														FROM employee e JOIN dependent d
														ON e.Ssn = d.Essn
														WHERE d.Relationship = "Daughter")) AS T1 JOIN dependent d
					ON T1.emloyees_without_daughter_Ssn = d.Essn
					WHERE d.Relationship = "Son");

-- Answer 3.
SELECT CONCAT (e.Fname, ' ', e.Minit, ' ', e.Lname) AS Employee, CONCAT (s.Fname, ' ', s.Minit, ' ', s.Lname) AS Supervisor 
FROM employee e LEFT OUTER JOIN employee s
ON e.Super_ssn = s.ssn
ORDER BY e.Lname;

-- Answer 4.
SELECT project.Pname, SUM(works_on.Hours) AS Total_Hours
FROM project INNER JOIN works_on
ON project.Pnumber = works_on.Pno
WHERE project.Plocation = 'Houston'
GROUP BY project.Pnumber
HAVING COUNT(DISTINCT works_on.Essn) > 2;

-- Answer 5. 
SELECT e.Ssn ,e.Fname, e.Minit, e.Lname
FROM employee e 
WHERE e.Dno IN (SELECT e.Dno
					FROM employee e
					WHERE e.Salary = (SELECT MAX(e.Salary) FROM employee e));
               
-- Answer 6.
SELECT DISTINCT p.Pname, d.Dname
FROM project p JOIN department d 
ON p.Dnum = d.Dnumber
JOIN works_on w
ON p.Pnumber = w.Pno
WHERE w.Essn IN (SELECT d.Mgr_ssn
				 FROM department d) AND w.Hours >= 20;
                
-- Answer 7
SELECT d.Dname 
FROM department d JOIN employee e
ON d.Dnumber = e.Dno
JOIN dependent dp
ON dp.Essn = e.Ssn
GROUP BY d.Dnumber 
HAVING COUNT(dp.Essn) = (SELECT MAX(Total_Num_Dep_in_Dept)
						FROM
						(SELECT COUNT(dp.Essn) AS Total_Num_Dep_in_Dept
						FROM department d JOIN employee e
						ON d.Dnumber = e.Dno
						JOIN dependent dp
						ON dp.Essn = e.Ssn
						GROUP BY d.Dnumber) AS T1);

-- Answer 8.
SELECT dl.Dlocation
FROM dept_locations dl
WHERE dl.Dnumber IN	(SELECT dl.Dnumber
					 FROM dept_locations dl JOIN employee e
					 ON dl.Dnumber = e.Dno
					 JOIN works_on w
					 ON e.Ssn = w.Essn
					 GROUP BY dl.Dnumber
					 HAVING SUM(w.Hours) = (SELECT MIN(Hours_worked)
											FROM 
											(SELECT SUM(w.Hours) AS Hours_worked
											FROM dept_locations dl JOIN employee e
											ON dl.Dnumber = e.Dno
											JOIN works_on w
											ON e.Ssn = w.Essn
											GROUP BY dl.Dnumber) AS T1));
