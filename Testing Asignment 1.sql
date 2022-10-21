-- Create Testingsystem Databese--
DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE  		Testing_System_Assignment_1;
USE 					Testing_System_Assignment_1;

-- 1.Create Table Department  --
DROP TABLE IF EXISTS         Department;
CREATE  TABLE IF NOT EXISTS  Department (
		Department_id 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Department_name		NVARCHAR(50) NOT NULL
);

-- 2.Creat Table Position  --
DROP TABLE IF EXISTS        `Position`;
CREATE 	TABLE IF NOT EXISTS `Position` (
		Position_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Position_name 	NVARCHAR(50) NOT NULL
);

-- 3.Create Table Account  --
DROP TABLE IF EXISTS `Account`;
CREATE TABLE IF NOT EXISTS		 `Account`(
		Account_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
        Email			NVARCHAR(50) NOT NULL UNIQUE,
        Username		VARCHAR(10) NOT NULL,
        Fullname  		NVARCHAR(30) NOT NULL,
        Department_id 	TINYINT UNSIGNED NOT NULL ,
        Position_id		TINYINT UNSIGNED NOT NULL ,
        Create_date 	DATETIME DEFAULT NOW(),
        FOREIGN KEY (Department_id) REFERENCES Department (Department_id),
        FOREIGN KEY (Position_id) REFERENCES `Position`(Position_id)
);

-- 4.Create Table `Group`  --
DROP TABLE IF EXISTS `Group`;
CREATE TABLE IF NOT EXISTS	 `Group` (
		Group_id 		TINYINT UNSIGNED  AUTO_INCREMENT PRIMARY KEY,  
		Group_name  	NVARCHAR(50) NOT NULL,
        Creator_id  	TINYINT NOT NULL, 
        Create_date		DATETIME DEFAULT NOW()
);  

-- 5.Create Table GroupAccount  --
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE IF NOT EXISTS		 GroupAccount (
		ID			TINYINT AUTO_INCREMENT PRIMARY KEY,
		Group_id    TINYINT UNSIGNED NOT NULL,
        Account_id  TINYINT UNSIGNED NOT NULL,
        Join_date   DATETIME DEFAULT NOW(),
        FOREIGN KEY (Group_id) REFERENCES `Group` (Group_id),
        FOREIGN KEY (Account_id) REFERENCES `Account`(Account_id)
);

-- 6.Create Table TypeQuestion  --
DROP TABLE IF EXISTS  TypeQuestion;
CREATE TABLE IF NOT EXISTS		  TypeQuestion (
		Type_id      TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Type_name    NVARCHAR(100) NOT NULL 
 );
 
 -- 7.Create Table CategoryQuestion  --
 DROP TABLE IF EXISTS         CategoryQuestion;
 CREATE TABLE IF NOT EXISTS   CategoryQuestion (
		Category_id   TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Category_name NVARCHAR(100) NOT NULL
);

-- 8.Create Table Question  --
DROP TABLE IF EXISTS        Question;
CREATE TABLE IF NOT EXISTS  Question (
		Question_id  TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Content 	 TEXT NOT NULL,
        Category_id  TINYINT UNSIGNED NOT NULL,
        Type_id      TINYINT UNSIGNED NOT NULL,
        Creator_id   TINYINT UNSIGNED NOT NULL,
        Create_date  DATETIME DEFAULT NOW(),
        FOREIGN KEY (Type_id ) REFERENCES TypeQuestion (Type_id),
        FOREIGN KEY (Category_id) REFERENCES CategoryQuestion (Category_id)
);

-- 9.Create Table Answer  --
DROP TABLE IF EXISTS         Answer;
CREATE TABLE IF NOT EXISTS   Answer (
		Answer_id      TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        Content       TEXT NOT NULL,
        Question_id   TINYINT UNSIGNED NOT NULL,
        isCorrect     ENUM('True', 'False') NOT NULL, 
        FOREIGN KEY (Question_id) REFERENCES Question (Question_id)
);

-- 10.Create Table Exam  --
DROP TABLE IF EXISTS         Exam;
CREATE TABLE IF NOT EXISTS   Exam (
		Exam_id      TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `Code`       INT UNSIGNED UNIQUE,
        Title     	 VARCHAR(500) NOT NULL,
		Category_id  TINYINT UNSIGNED NOT NULL,
        Duration     TINYINT UNSIGNED  NOT NULL,                                                           
		Creator_id   TINYINT UNSIGNED NOT NULL,
        Create_date  DATETIME DEFAULT NOW() NOT NULL,

        FOREIGN KEY (Category_id) REFERENCES CategoryQuestion (Category_id)
);

-- 11.Create Table ExamQuestion  --
DROP TABLE IF EXISTS         ExamQuestion;
CREATE TABLE IF NOT EXISTS   ExamQuestion (
		Exam_id     TINYINT UNSIGNED NOT NULL,
        Question_id TINYINT UNSIGNED NOT NULL,
        PRIMARY KEY (Exam_id, Question_id),
		FOREIGN KEY (Exam_id) REFERENCES Exam (Exam_id),
        FOREIGN KEY (Question_id) REFERENCES Question (Question_id)
);