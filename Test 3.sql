USE testing_system_assignment_1;

-- Question 2: lấy ra tất cả các phòng ban
SELECT Department_name
FROM Department
;

-- Question 3: lấy ra id của phòng ban "Sale"
SELECT *
FROM Department
WHERE Department_name = 'Sale'
;

-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT *,LENGTH(Fullname)
FROM `account`
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `account`)
;

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3

SELECT *,LENGTH(Fullname)
FROM `account`
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `account`) AND Department_id= '3'
;

-- Question 6: Lấy ra tên group đã tham gia trướquestionc ngày 20/12/2019
SELECT *
FROM `group`
WHERE Create_date > '20/12/2019'
;

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT Question_id,COUNT(Content) AS tra_loi
FROM question
GROUP BY Question_id
HAVING COUNT( content) >= '2'
;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT`Code`,Duration
FROM Exam
WHERE Duration >= '60'
;

-- Lấy ra 5 group được tạo gần đây nhất
SELECT *
FROM `Group`
ORDER BY  GroupName,CreateDate ASC
LIMIT 5
;

-- Đếm số nhân viên thuộc department có id = 2
SELECT *,COUNT(DepartmentID) 
FROM department
WHERE DepartmentID = '2'
;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT *
FROM `account`
WHERE Fullname LIKE 'D%o'
;

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE
FROM Exam
WHERE CreateDate < '20/12/2019'
;

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
DELETE
FROM question
WHERE Content LIKE 'câu hỏi%'
;

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `account`
SET Fullname = "Nguyễn Bá Lộc", Email = 'loc.nguyenba@vti.com.vn'
WHERE AccountID = '5'
;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE `groupaccount`
SET GroupID = '4'
WHERE AccountID = '5'
;