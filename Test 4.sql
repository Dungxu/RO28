USE testing_system_assignment_1
;
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT *
FROM `account` a
INNER JOIN department d ON a.departmentID = d.departmentID
;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `account`
WHERE CreateDate < '2010/12/20'
;

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT p.PositionName,a.PositionID,a.fullname
FROM position p
INNER JOIN `account` a ON p.PositionID = a.PositionID
WHERE PositionName = 'developer'
;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.DepartmentID,d.DepartmentName,a.accountID
FROM department d 
INNER JOIN `account` a ON d.DepartmentID = a.DepartmentID
WHERE a.DepartmentID > 3
;

-- 	Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT q.QuestionID,q.Content,eq.QuestionID, count(q.Content) AS Cau_Hoi
FROM question q
INNER JOIN examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY eq.QuestionID
HAVING count(q.Content)
;
WITH `CTE_COUNT_Q` AS(
SELECT q.QuestionID, Q.Content, COUNT(q.QuestionID) AS SL
FROM question q
INNER JOIN examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY eq.QuestionID
)
SELECT *
FROM `CTE_COUNT_Q` 
WHERE SL = ( SELECT max(SL) FROM `CTE_COUNT_Q`)
;

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT cq.CategoryID,cq.CategoryName, COUNT(cq.CategoryID) AS SL
FROM categoryquestion cq
INNER JOIN question q ON cq.CategoryID = q.CategoryID
GROUP BY q.CategoryID
HAVING COUNT(q.CategoryID)
;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.CategoryID, e.CategoryID, COUNT(q.QuestionID) AS So_Luong
FROM question q
LEFT JOIN exam e ON  q.CategoryID = e.CategoryID
GROUP BY q.CategoryID
;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT q.QuestionID,q.Content,COUNT(a.questionID) AS So_cau_tra_loi
FROM   answer a
INNER JOIN examquestion eq ON a.QuestionID = eq.QuestionID
INNER JOIN question q ON a.questionID =q.questionID
GROUP BY a.QuestionID
HAVING COUNT( a.QuestionID) 
ORDER BY a.QuestionID DESC
LIMIT 1

;


WITH `CTE_COUNT_A` AS(
SELECT q.QuestionID,q.Content,COUNT(a.questionID) AS So_cau_tra_loi
FROM   answer a
INNER JOIN examquestion eq ON a.QuestionID = eq.QuestionID
INNER JOIN question q ON a.questionID =q.questionID
GROUP BY a.QuestionID
)
SELECT *
FROM `CTE_COUNT_A` 
WHERE So_cau_tra_loi = ( SELECT max(So_cau_tra_loi) FROM `CTE_COUNT_A`)
;

-- Question 9: Thống kê số lượng account trong mỗi group
SELECT a.accountID,ga.groupID,g.groupname,COUNT(a.AccountID) AS So_Account
FROM `Groupaccount` ga
INNER JOIN `account` a ON ga.accountID = a.accountID
INNER JOIN `group` g ON ga.groupID = g.groupID
GROUP BY a.accountID
;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT p.positionID,p.positionName, COUNT(p.positionID) AS SO_NGUOI
FROM  `account` a
INNER JOIN `position` p ON a.positionID = p.positionID
GROUP BY p.positionID
ORDER BY COUNT(p.positionID) ASC
LIMIT 1
;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT a.accountID,a.DepartmentID,a.PositionID,p.PositionName,COUNT(p.PositionName) AS So_Luong
FROM `account` a 
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN `Position` p ON a.PositionID = p.PositionID
GROUP BY p.PositionName
ORDER BY COUNT(p.PositionName)
;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT q.questionID,q.content,a.fullname,tq.typename AS Loai_Cau_Hoi, aw.content
FROM question q
INNER JOIN categoryquestion cq ON q.categoryID = cq.categoryID
INNER JOIN typequestion tq ON q.typeID = tq.typeID
INNER JOIN `account` a ON a.accountID = q.creatorID
INNER JOIN answer aw ON q.questionID = aw.questionID
ORDER BY q.questionID ASC
;

-- Question 14:Lấy ra group không có account nào
SELECT *
FROM `Group` g
LEFT JOIN Groupaccount ga ON g.groupID = ga.groupID
WHERE ga.accountID IS NULL
;

-- Question 16: Lấy ra question không có answer nào
SELECT *
FROM question q
LEFT JOIN answer aw ON q.questionID = aw.questionID
WHERE aw.answerID IS NULL
;

-- Question 17: a) Lấy các account thuộc nhóm thứ 1,b) Lấy các account thuộc nhóm thứ 2,c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.fullname
FROM `account` a
INNER JOIN groupaccount ga ON a.accountID = ga.accountID
WHERE ga.groupID =1
UNION 
SELECT a.fullname
FROM `account` a
INNER JOIN groupaccount ga ON a.accountID = ga.accountID
WHERE ga.groupID = 2
;

-- Question 18:a) Lấy các group có lớn hơn 5 thành viên,b) Lấy các group có nhỏ hơn 7 thành viên,c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.groupname
FROM `groupaccount` ga
INNER JOIN `group` g ON ga.groupID = g.groupID
INNER JOIN `account` a ON ga.accountID = a.accountID
WHERE a.accountID > 5
UNION 
SELECT g.groupname
FROM `groupaccount` ga
INNER JOIN `group` g ON ga.groupID = g.groupID
INNER JOIN `account` a ON ga.accountID = a.accountID
WHERE a.accountID < 7