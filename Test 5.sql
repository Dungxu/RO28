USE Testing_system_assignment_1;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale

DROP VIEW IF EXISTS v_department; 
CREATE VIEW v_department AS 
SELECT d.departmentname,a.fullname, COUNT(a.AccountID)
FROM department d
INNER JOIN `account` a ON d.departmentID = a.departmentID
WHERE d.departmentname = 'sale'
GROUP BY a.AccountID
;

SELECT *
FROM v_department
;
WITH v_department AS (
SELECT d.departmentname,a.fullname, COUNT(a.AccountID)
FROM department d
INNER JOIN `account` a ON d.departmentID = a.departmentID
WHERE d.departmentname = 'sale'
GROUP BY a.AccountID
)

SELECT *
FROM v_department
;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất

		DROP VIEW IF EXISTS V_Account;
	CREATE VIEW  V_Account  AS
		SELECT			a.Accountid, a.Email, a.Fullname, a.Departmentid , COUNT(Groupid)
		FROM			`Account` a 
		JOIN			GroupAccount ga  ON		a.Accountid = ga.Accountid
		GROUP BY		 a.Accountid  
		HAVING  		COUNT(Groupid) = ( SELECT		COUNT(Groupid)
											FROM		`Account` a 
											JOIN		GroupAccount ga  ON		a.Accountid = ga.Accountid
											GROUP BY	a.Accountid  
											ORDER BY  	COUNT(Groupid) DESC LIMIT 1);
											

SELECT *
FROM V_Account;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
	DROP VIEW IF EXISTS V_Question;
    CREATE VIEW  V_Question   AS
		SELECT  				*
		FROM            		Question
		WHERE 					LENGTH(Content) > 300 ;


	SELECT 	* 
	FROM 	V_Question;

	DELETE 	 
	FROM	V_Question;
    
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS  V_Department_nhan_vien;
CREATE VIEW	V_Department_nhan_vien AS	
	SELECT     	g.Groupid,g.Groupname, COUNT(ga.Accountid)
	FROM		`Group`  g 
	JOIN		GroupAccount ga 	ON   g.Groupid = ga.Groupid
	GROUP BY    g.Groupname
	HAVING  	COUNT(ga.Accountid) = (	SELECT 		COUNT(ga.Accountid)
											FROM		`Group` g 
											JOIN		GroupAccount ga 	ON   g.Groupid = ga.Groupid
											GROUP BY    g.Groupname 
											ORDER BY   	COUNT(ga.Accountid)  DESC 
											LIMIT 		1);

SELECT *
FROM V_Department_nhan_vien;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS v_Question ;
	CREATE  VIEW v_Question  AS
		SELECT   	q.Content, a.Fullname
		FROM     	`Account` a
		JOIN		Question q 	ON	q.Creatorid = a.Accountid
		WHERE		Fullname 	LIKE  'Nguyen%' 
		GROUP BY 	Accountid ;
        
SELECT *
FROM v_Question;