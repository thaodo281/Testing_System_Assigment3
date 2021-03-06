DROP DATABASE if exists	Testing_System_Assigment3;
CREATE DATABASE			Testing_System_Assigment3;
USE						Testing_System_Assigment3;

DROP TABLE IF EXISTS Department;
CREATE TABLE			Department(
DepartmentID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DepartmentName			VARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE 			`Position`(
PositionID				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
PositionName			ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE 			`Account`(
AccountID				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Email					VARCHAR(50) NOT NULL,
Username				VARCHAR(50) NOT NULL,
Fullname				VARCHAR(100) NOT NULL,
DepartmentID			INT UNSIGNED NOT NULL,
PositionID				INT UNSIGNED NOT NULL,
CreateDate				DATETIME default NOW(),
FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE 			`Group`(
GroupID					INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
GroupName				VARCHAR(50) NOT NULL UNIQUE KEY,
CreatorID				INT UNSIGNED NOT NULL,
CreateDate				DATETIME DEFAULT NOW(),
FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE 			GroupAccount(
GroupID					INT UNSIGNED NOT NULL,
AccountID				INT UNSIGNED NOT NULL,
JoinDate				DATETIME DEFAULT NOW(),
FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
FOREIGN KEY(AccountID) REFERENCES`Account`(AccountID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE 			TypeQuestion(
TypeID					INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TypeName				ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE			CategoryQuestion(
CategoryID				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
CategoryName			VARCHAR(100)
);

DROP TABLE IF EXISTS Question;
CREATE TABLE			Question(
QuestionID				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Content					VARCHAR(200),
CategoryID				INT UNSIGNED NOT NULL,
TypeID					INT UNSIGNED NOT NULL,
CreatorID				INT UNSIGNED NOT NULL,
CreateDate				DATETIME DEFAULT NOW(),
FOREIGN KEY (CategoryID) references CategoryQuestion(CategoryID),
FOREIGN KEY (TypeID) references TypeQuestion(TypeID),
FOREIGN KEY (CreatorID) references `Account`(AccountID)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE 			Answer(
AnswerID				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Content					VARCHAR(100),
QuestionID				INT UNSIGNED,
isCorrect				ENUM('Y','N') NOT NULL, -- Y: Dung N: Sai
FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE 			Exam(
ExamID					INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`Code`					VARCHAR(100) NOT NULL,
Title					VARCHAR(100) NOT NULL,
CategoryID				INT UNSIGNED NOT NULL,
Duration				INT UNSIGNED NOT NULL,
CreatorID				INT UNSIGNED NOT NULL,
CreateDate				DATETIME DEFAULT NOW(),
FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE 			ExamQuestion(
ExamID					INT UNSIGNED NOT NULL,
QuestionID				INT UNSIGNED NOT NULL,
FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
PRIMARY KEY (ExamID,QuestionID)
);
-- --------------------------------INSERT DATA INTO TABLE------------------------
INSERT INTO Department (DepartmentName)
VALUES 
			('Nhan su'   ),
            ('Kinh Doanh'),
            ('Le Tan'    ),
            ('Ke Toan'   ),
            ('Ky Thuat'  );
SELECT * FROM Department;

INSERT INTO `Position` (PositionName)
VALUES	
			('Dev'         ),
            ('Test'        ),
            ('Scrum Master'),
            ('PM'          );
SELECT * FROM `Position`;            
INSERT INTO `Account` (Email, Username, Fullname, DepartmentID, PositionID, CreateDate)
VALUES	
			('abc1@gmail.com', 'abc1', 'abc1 nguyen', '1', '1', '2020-09-01'),
            ('abc2@gmail.com', 'abc2', 'abc2 tran', '2', '3', '2020-09-02'),
            ('abc3@gmail.com', 'abc3', 'abc3 dang', '5', '4', '2020-09-03'),
            ('abc4@gmail.com', 'abc4', 'abc4 nguyen', '3', '2', '2020-09-04'),
            ('abc5@gmail.com', 'abc5', 'abc5 vo', '4', '2', '2020-09-05');   
SELECT * FROM `Account`;           
            
INSERT INTO `Group` (GroupName, CreatorID, Createdate)
VALUES	
			('Hanh Chinh', '1', '2020-09-03'),
            ('Tai Chinh', '2', '2020-09-01'),
            ('Kinh Doanh', '3', '2020-09-02'),
            ('Marketing', '4', '2020-09-05'),
            ('Ky Thuat', '5', '2020-09-04');   
SELECT * FROM `Group`;   
         
INSERT INTO `GroupAccount` (GroupID, AccountID, JoinDate)
VALUES	
			(1, '3', '2020-09-03'),
            (2, '2', '2020-09-02'),
            (3, '1', '2020-09-05'),
            (4, '5', '2020-09-02'),
            (5, '4', '2020-09-04'); 
SELECT * FROM `GroupAccount`;   
         
INSERT INTO TypeQuestion (TypeName )
VALUES 
			('Essay' ),
			('Multiple-Choice' );
SELECT * FROM TypeQuestion;
            
INSERT INTO CategoryQuestion (CategoryName )
VALUES 
			('Rain'		),
			('Sea' 		),
			('Sunny' 	),
			('Cloudy'	),
			('Mountain'  );
SELECT * FROM CategoryQuestion;
            
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES		
			('Cau hoi ve Rain', '1', '1', '1','2020-09-10'),
			('Cau hoi ve Sea', '2', '2', '2','2020-09-10'),
			('Cau hoi ve Sunny', '3', '2', '3','2020-09-10'),
			('Cau hoi ve Cloudy', '4', '2', '4','2020-09-10'),
			('Cau hoi ve Mountain', '5', '1', '5','2020-09-10');
SELECT * FROM Question;            
            
INSERT INTO Answer ( Content, QuestionID, isCorrect)
VALUES	
			('Cau tra loi Rain', '1', 'Y'),
			('Cau tra loi Sea', '2', 'N'),
			('Cau tra loi Sunny' , '3', 'Y'),
			('Cau tra loi Cloudy', '4', 'Y'),
			('Cau tra loi Mountain', '5', 'N');
SELECT * FROM Answer;
            
INSERT INTO Exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES
			('TEST1' , 'Goi Rain', 1, 30, '5' ,'2020-09-01'),
			('TEST2' , 'Goi Sea' , 3, 45, '2' ,'2020-09-02'),
			('TEST3' , 'Goi Cloudy', 2, 60, '3' ,'2020-09-05'),
            ('TEST4' , 'Goi Sunny', 4, 30, '1' ,'2020-09-06'),
            ('TEST5' , 'Goi Moutain', 5, 45, '4' ,'2020-09-02');
SELECT * FROM Exam;  
          
INSERT INTO ExamQuestion(ExamID, QuestionID )
VALUES  
			(1, 1),
            (2, 3),
            (4, 1),
            (5, 2),
            (3, 5);
SELECT * FROM ExamQuestion;           
-- Th??m 10 record v??o m???i Table ---
-- INSERT INTO table_name (column1,column2,column3)
-- VALUES (value1,value2,value3);	
INSERT INTO  Department (DepartmentName)
VALUES 
						('Dich vu'   	),
						('Bao ve'		),
						('Lao cong'    	),
						('Khach hang'   ),
                        ('Phong ban 10' ),
						('Phong ban 11'	),
						('Phong ban 12' ),
						('Phong ban 13' ),
                        ('Phong ban 14' ),
						('Phong ban 15' );	
SELECT * FROM Department;

INSERT INTO `Account` (Email, 				Username,	 	Fullname, DepartmentID, PositionID,  CreateDate)
VALUES	
					  ('abc6@gmail.com',  	  'abc6',  'Duy nguyen',   		 '1',		 '1', '2020-09-01'),
					  ('abc7@gmail.com',  	  'abc7',  'Dao nguyen',   		 '3',		 '4', '2020-09-01'),
					  ('abc8@gmail.com',  	  'abc8',  'Mau nguyen',   		 '7',		 '3', '2020-09-01'),
                      ('abc9@gmail.com',  	  'abc9',  'Dang nguyen',   	 '9',		 '2', '2020-09-01'),
                      ('abc10@gmail.com',  	  'abc10',  'Anh nguyen',   	'10',		 '1', '2020-09-01'),
                      ('abc11@gmail.com',  	  'abc11',  'Tran nguyen',   	 '5',		 '4', '2020-09-01'),
                      ('abc12@gmail.com',  	  'abc12',  'Nguyen nguyen',   	'14',		 '2', '2020-09-01'),
                      ('abc13@gmail.com',  	  'abc13',  'Phat nguyen',   	'15',		 '3', '2020-09-01'),
                      ('abc14@gmail.com',  	  'abc14',  'Manh Le',   		'13',		 '1', '2020-09-01'),
                      ('abc15@gmail.com',  	  'abc15',  'Nhu Quynh',   		'11',		 '3', '2020-09-01');
SELECT * FROM `Account`; 

INSERT INTO `Group` (GroupName, 	CreatorID, 		Createdate)
VALUES	
					('Group 6', 		  '6', 		'2019-09-03'),
                    ('Group 7', 		  '7', 		'2020-09-04'),
                    ('Group 8', 		  '8', 		'2019-09-13'),
                    ('Group 9', 		  '9', 		'2021-09-23'),
                    ('Group 10', 		  '10', 	'2018-09-30'),
                    ('Group 11', 		  '11', 	'2019-12-12'),
                    ('Group 12', 		  '12', 	'2021-01-14'),
                    ('Group 13', 		  '13', 	'2020-09-10'),
                    ('Group 14', 		  '14', 	'2020-09-07'),
					('Group 15', 		  '15', 	'2020-09-05');
SELECT * FROM `Group`; 

INSERT INTO `GroupAccount` (GroupID, AccountID, JoinDate)
VALUES	
							(6, 		'10', 	'2020-09-03'),
							(7, 		'6', 	'2020-09-02'),
							(8, 		'8', 	'2020-09-05'),
							(9, 		'11', 	'2020-09-02'),
                            (10, 		'7', 	'2020-09-02'),
                            (11, 		'15', 	'2020-09-02'),
                            (12, 		'14', 	'2020-09-02'),
                            (13, 		'13', 	'2020-09-02'),
                            (14, 		'12', 	'2020-09-02'),
							(15, 		'9', 	'2020-09-04'); 
SELECT * FROM `GroupAccount`; 
 
INSERT INTO CategoryQuestion (CategoryName )
VALUES 
							 ('Ameda'		),
                             ('Sumida'		),
                             ('Nozomi'		),
                             ('Utsunomiya'	),
                             ('Hatachi'		),
                             ('Aichi'		),
                             ('Okinawa'		),
                             ('Sapporo'		),
                             ('Fukui'		),
                             ('Oyama'		);
SELECT * FROM CategoryQuestion;
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES		
			('Cau hoi ve Ameda', 		'10', 	'1', 	'10',	'2019-01-10'),
			('C??u h???i v??? Sumida', 		'8',	'2', 	'12',	'2021-02-11'),
			('C??u h???i v??? Nozomi', 		'9', 	'1',	 '13',	'2020-11-01'),
			('Cau hoi ve Utsunomiya', 	'11', 	'1', 	'4',	'2019-12-23'),
			('Cau hoi ve Hatachi', 		'15', 	'1', 	'15',	'2019-09-14'),
            ('Cau hoi ve Aichi', 		'6', 	'2', 	'11',	'2020-10-10'),
            ('Cau hoi ve Okinawa', 		'7', 	'2', 	'6',	'2021-09-19'),
            ('Cau hoi ve Sapporo', 		'14', 	'2', 	'8',	'2019-09-04'),
            ('Cau hoi ve Fukui', 		'13', 	'1', 	'9',	'2020-01-06'),
            ('Cau hoi ve Oyama', 		'12', 	'2', 	'5',	'2020-01-05');
SELECT * FROM Question; 

INSERT INTO Answer ( Content, 			QuestionID, 	isCorrect)
VALUES	
				   ('Cau tra loi Ameda', 	   '15', 		 'Y'),
                   ('Cau tra loi Sumida', 	    '9', 		 'N'),
                   ('Cau tra loi Nozomi', 	   '12', 		 'Y'),
                   ('Cau tra loi Utsunomiya',  '11', 		 'N'),
                   ('Cau tra loi Hatachi', 	   '10', 		 'N'),
                   ('Cau tra loi Aichi', 	   '11', 		 'Y'),
                   ('Cau tra loi Okinawa', 	    '9', 		 'Y'),
                   ('Cau tra loi Sapporo', 	    '8', 		 'Y'),
                   ('Cau tra loi Fukui', 	    '9', 		 'N'),
                   ('Cau tra loi Oyama', 	    '9', 		 'N');
SELECT * FROM Answer; 

INSERT INTO Exam (`Code`, 			  Title,    CategoryID,		Duration, CreatorID, 	CreateDate)
VALUES
				('TEST6', 		 'Goi Ameda', 			10,			  30, 	  '10' ,	'2019-09-01'),
                ('TEST7', 		'Goi Sumida', 			15, 		  45, 	  '15' ,	'2019-01-01'),
                ('TEST8', 		'Goi Nozomi', 			11, 		  55, 	  '11' ,	'2019-12-10'),
                ('TEST9',	'Goi Ustunomiya', 			12, 		  60, 	  '9' ,		'2020-09-13'),
                ('TEST10', 		 'Goi Aichi', 			13, 		 100, 	  '8' ,		'2019-09-14'),
                ('TEST11', 	   'Goi Okinawa', 			9, 		 	 120, 	  '6' ,		'2020-09-20'),
                ('TEST12', 	   'Goi Sapporo', 			6, 		 	  15, 	  '12' ,	'2020-09-03'),
                ('TEST13', 		 'Goi Fukui', 			8, 		 	  60, 	  '14' ,	'2020-09-05'),
                ('TEST14', 		 'Goi Oyama', 			7, 		 	  60, 	  '7' ,		'2020-09-06'),
                ('TEST15', 		  'Goi Rain', 			14, 		  45, 	  '13' ,	'2020-09-17');	
SELECT * FROM Exam;

INSERT INTO ExamQuestion(ExamID, QuestionID )
VALUES  
						(11	   ,		 1),
                        (10	   ,		 15),
                        (15	   ,		 9),
                        (14	   ,		 6),
                        (12	   ,		 7),
                        (13	   ,		 4),
                        (9	   ,		 8),
                        (8	   ,		 6),
                        (7	   ,		 12),
                        (6	   ,		 13);
SELECT * FROM ExamQuestion;
-- L???y ra t???t c??? ph??ng ban            
SELECT * FROM Department; 
 
-- L???y ra ID c???a ph??ng ban "Sale" Kinh Doanh
-- SELECT 	name  FROM 	table_name WHERE name LIKE ???D%??? , ???%U%??? , ???%Y???; ----
SELECT DepartmentID FROM Department WHERE DepartmentName LIKE '%Kinh Doanh%';

-- L???y ra th??ng tin account c?? fullname d??i nh???t
SELECT MAX(Fullname) 
FROM `Account`;

-- L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id =3 --
SELECT MAX(Fullname) 
FROM `Account` GROUP BY DepartmentID HAVING DepartmentID = '3';

-- L???y ra t??n group ???? tham gia tr?????c ng??y 20/12/2019
SELECT GroupName  
FROM `Group` WHERE CreateDate < '2019-12-20';

-- L???y ra ID c???a question c?? >= 4 c??u tr??? l???i --
SELECT QuestionID
FROM Answer GROUP BY QuestionID HAVING COUNT(QuestionID) >= 4;	

-- L???y ra c??c m?? ????? thi c?? th???i gian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019 --
SELECT `Code`
FROM Exam WHERE Duration >= '60' AND CreateDate < '2019-12-20';	

-- L???y ra 5 group ???????c t???o g???n ????y nh???t
SELECT GroupName
FROM `Group` 
ORDER BY ABS( DATEDIFF( CreateDate, NOW() ) ) 
LIMIT 5

-- ?????m s??? nh??n vi??n thu???c department c?? id = 2
SELECT COUNT(DepartmentID)
FROM `Account` WHERE DepartmentID = 2;

-- L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "a" v?? k???t th??c b???ng ch??? "o"
SELECT Fullname
FROM `Account` WHERE Fullname LIKE 'a%' AND Fullname LIKE '%o';

-- X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019
DELETE FROM Exam WHERE CreateDate < '2019-12-20';
SELECT * FROM Exam;  

-- X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i"
DELETE FROM Question WHERE Content LIKE 'C??u h???i%';
SELECT * FROM Question; 

-- Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v?? email th??nh loc.nguyenba@vti.com.vn
UPDATE `Account` 
SET Fullname='Nguy???n B?? L???c',Email='loc.nguyenba@vti.com.vn' WHERE AccountID = 5; 
SELECT * FROM `Account`;

-- update account c?? id = 5 s??? thu???c group c?? id = 4
UPDATE `GroupAccount` 
SET GroupID = 4 WHERE AccountID = 5;
SELECT * FROM `GroupAccount`;