-- =========================================================
-- CRICKET STATISTICS DATABASE
-- =========================================================

CREATE DATABASE CricketStatisticsDB;

USE CricketStatisticsDB;

-- TABLE CREATION

-- =========================================================
-- 1. TEAMS TABLE
-- =========================================================

CREATE TABLE Teams
(
    Team_ID INT PRIMARY KEY AUTO_INCREMENT,
    Team_Name VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(100) NOT NULL,
    Coach_Name VARCHAR(100),
    Captain_Name VARCHAR(100),
    Founded_Year INT,
    CHECK (Founded_Year >= 1800)
);


-- =========================================================
-- 2. PLAYERS TABLE
-- =========================================================

CREATE TABLE Players
(
    Player_ID INT PRIMARY KEY AUTO_INCREMENT,
    Player_Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Date_of_Birth DATE,
    Role VARCHAR(30) NOT NULL,
    Batting_Style VARCHAR(30),
    Bowling_Style VARCHAR(50),
    Team_ID INT,
    Debut_Year INT,

    FOREIGN KEY (Team_ID)
        REFERENCES Teams(Team_ID),

    CHECK (Gender IN ('Male','Female')),
    CHECK (Role IN ('Batsman','Bowler','All-Rounder','Wicket-Keeper'))
);


-- =========================================================
-- 3. VENUES TABLE
-- =========================================================

CREATE TABLE Venues
(
    Venue_ID INT PRIMARY KEY AUTO_INCREMENT,
    Venue_Name VARCHAR(150) NOT NULL UNIQUE,
    City VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    Capacity INT
);


-- =========================================================
-- 4. MATCHES TABLE
-- =========================================================

CREATE TABLE Matches
(
    Match_ID INT PRIMARY KEY AUTO_INCREMENT,
    Match_Date DATE NOT NULL,
    Match_Format VARCHAR(20) NOT NULL,
    Team1_ID INT NOT NULL,
    Team2_ID INT NOT NULL,
    Venue_ID INT,
    Winner_Team_ID INT,
    Player_of_Match INT,

    FOREIGN KEY (Team1_ID)
        REFERENCES Teams(Team_ID),

    FOREIGN KEY (Team2_ID)
        REFERENCES Teams(Team_ID),

    FOREIGN KEY (Venue_ID)
        REFERENCES Venues(Venue_ID),

    FOREIGN KEY (Winner_Team_ID)
        REFERENCES Teams(Team_ID),

    FOREIGN KEY (Player_of_Match)
        REFERENCES Players(Player_ID),

    CHECK (Team1_ID <> Team2_ID)
);


-- =========================================================
-- 5. BATTING STATISTICS TABLE
-- =========================================================

CREATE TABLE Batting_Statistics
(
    Batting_ID INT PRIMARY KEY AUTO_INCREMENT,
    Match_ID INT NOT NULL,
    Player_ID INT NOT NULL,
    Runs INT DEFAULT 0,
    Balls_Faced INT DEFAULT 0,
    Fours INT DEFAULT 0,
    Sixes INT DEFAULT 0,
    Strike_Rate DECIMAL(6,2),

    FOREIGN KEY (Match_ID)
        REFERENCES Matches(Match_ID),

    FOREIGN KEY (Player_ID)
        REFERENCES Players(Player_ID),

    CHECK (Runs >= 0),
    CHECK (Balls_Faced >= 0),
    CHECK (Fours >= 0),
    CHECK (Sixes >= 0)
);


-- =========================================================
-- 6. BOWLING STATISTICS TABLE
-- =========================================================

CREATE TABLE Bowling_Statistics
(
    Bowling_ID INT PRIMARY KEY AUTO_INCREMENT,
    Match_ID INT NOT NULL,
    Player_ID INT NOT NULL,
    Overs DECIMAL(4,1) DEFAULT 0,
    Runs_Conceded INT DEFAULT 0,
    Wickets INT DEFAULT 0,
    Economy DECIMAL(5,2),

    FOREIGN KEY (Match_ID)
        REFERENCES Matches(Match_ID),

    FOREIGN KEY (Player_ID)
        REFERENCES Players(Player_ID),

    CHECK (Overs >= 0),
    CHECK (Runs_Conceded >= 0),
    CHECK (Wickets >= 0)
);

-- ========================================
-- 7. AUDIT TABLE
-- ========================================

CREATE TABLE Player_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Player_ID INT,
    Player_Name VARCHAR(100),
    Action_Type VARCHAR(20),
    Action_Date DATETIME,
    Message VARCHAR(255)
);


-- RECORDS INSERTION

-- ========================================
-- Insert Teams
-- ========================================

INSERT INTO Teams
(Team_Name, Country, Coach_Name, Captain_Name, Founded_Year)
VALUES
('India','India','Gautam Gambhir','Rohit Sharma',1932),
('Australia','Australia','Andrew McDonald','Pat Cummins',1877),
('England','England','Brendon McCullum','Ben Stokes',1877),
('New Zealand','New Zealand','Gary Stead','Tom Latham',1930),
('South Africa','South Africa','Shukri Conrad','Temba Bavuma',1889),
('Pakistan','Pakistan','Jason Gillespie','Babar Azam',1952),
('Sri Lanka','Sri Lanka','Sanath Jayasuriya','Charith Asalanka',1982),
('Bangladesh','Bangladesh','Phil Simmons','Najmul Hossain',2000),
('Afghanistan','Afghanistan','Jonathan Trott','Hashmatullah Shahidi',2017),
('West Indies','West Indies','Daren Sammy','Shai Hope',1928);


-- ========================================
-- Insert Venues
-- ========================================

INSERT INTO Venues
(Venue_Name, City, Country, Capacity)
VALUES
('M. A. Chidambaram Stadium','Chennai','India',50000),
('Wankhede Stadium','Mumbai','India',33000),
('M. Chinnaswamy Stadium','Bangalore','India',40000),
('Eden Gardens','Kolkata','India',68000),
('Narendra Modi Stadium','Ahmedabad','India',132000),
('Rajiv Gandhi International Stadium','Hyderabad','India',39000),
('Arun Jaitley Stadium','Delhi','India',55000),
('Sydney Cricket Ground','Sydney','Australia',48000),
('Melbourne Cricket Ground','Melbourne','Australia',100000),
('Adelaide Oval','Adelaide','Australia',53000),
('Lord’s','London','England',30000),
('The Oval','London','England',27500),
('Old Trafford','Manchester','England',26000),
('Headingley','Leeds','England',18000),
('Trent Bridge','Nottingham','England',19000),
('Basin Reserve','Wellington','New Zealand',11600),
('Eden Park','Auckland','New Zealand',50000),
('Hagley Oval','Christchurch','New Zealand',18000),
('Newlands Cricket Ground','Cape Town','South Africa',25000),
('Wanderers Stadium','Johannesburg','South Africa',34000);


-- ========================================
-- Insert Players Records
-- ========================================

INSERT INTO Players
(Player_ID, Player_Name, Gender, Date_of_Birth, Role, Batting_Style, Bowling_Style, Team_ID, Debut_Year)
VALUES

(1,'M.S. Dhoni','Male','1981-07-07','Wicket-Keeper','Right-Hand','Right Arm Medium',1,2004),
(2,'Virat Kohli','Male','1988-11-05','Batsman','Right-Hand','Right Arm Medium',1,2008),
(3,'Rohit Sharma','Male','1987-04-30','Batsman','Right-Hand','Right Arm Off Spin',1,2007),
(4,'Ravindra Jadeja','Male','1988-12-06','All-Rounder','Left-Hand','Left Arm Spin',1,2009),
(5,'Jasprit Bumrah','Male','1993-12-06','Bowler','Right-Hand','Right Arm Fast',1,2016),
(6,'Ruturaj Gaikwad','Male','1997-01-31','Batsman','Right-Hand','Right Arm Off Spin',1,2021),
(7,'Shubman Gill','Male','1999-09-08','Batsman','Right-Hand','Right Arm Off Spin',1,2019),
(8,'KL Rahul','Male','1992-04-18','Wicket-Keeper','Right-Hand','Right Arm Medium',1,2014),
(9,'Hardik Pandya','Male','1993-10-11','All-Rounder','Right-Hand','Right Arm Fast',1,2016),
(10,'Ravichandran Ashwin','Male','1986-09-17','Bowler','Right-Hand','Right Arm Off Spin',1,2010),
(11,'Kuldeep Yadav','Male','1994-12-14','Bowler','Left-Hand','Left Arm Wrist Spin',1,2017),
(12,'Mohammed Shami','Male','1990-09-03','Bowler','Right-Hand','Right Arm Fast',1,2013),
(13,'Suryakumar Yadav','Male','1990-09-14','Batsman','Right-Hand','Right Arm Medium',1,2021),
(14,'Shreyas Iyer','Male','1994-12-06','Batsman','Right-Hand','Right Arm Off Spin',1,2017),
(15,'Yuvraj Singh','Male','1981-12-12','All-Rounder','Left-Hand','Left Arm Spin',1,2000),
(16,'Suresh Raina','Male','1986-11-27','Batsman','Left-Hand','Right Arm Off Spin',1,2005),
(17,'Gautam Gambhir','Male','1981-10-14','Batsman','Left-Hand','Right Arm Leg Spin',1,2003),
(18,'Zaheer Khan','Male','1978-10-07','Bowler','Left-Hand','Left Arm Fast',1,2000),
(19,'Virender Sehwag','Male','1978-10-20','Batsman','Right-Hand','Right Arm Off Spin',1,1999),
(20,'Anil Kumble','Male','1970-10-17','Bowler','Right-Hand','Right Arm Leg Spin',1,1990),

(21,'James Anderson','Male','1992-04-18','Batsman','Right-Hand','Right Arm Medium',2,2015),
(22,'Michael Clarke','Male','1994-08-22','Bowler','Right-Hand','Right Arm Fast',2,2017),
(23,'Daniel Smith','Male','1996-01-09','All-Rounder','Left-Hand','Off Spin',2,2019),
(24,'William Turner','Male','1993-06-13','Wicket-Keeper','Right-Hand','Leg Spin',2,2016),
(25,'Jack Wilson','Male','1998-10-29','Batsman','Left-Hand','Right Arm Medium',2,2021),
(26,'Oliver Brown','Male','1995-03-05','Bowler','Right-Hand','Left Arm Fast',2,2018),
(27,'George Taylor','Male','1991-12-17','All-Rounder','Right-Hand','Right Arm Fast',2,2013),
(28,'Henry Martin','Male','1997-07-08','Batsman','Right-Hand','Off Spin',2,2020),
(29,'Thomas White','Male','1994-02-21','Bowler','Left-Hand','Left Arm Fast',2,2017),
(30,'Harry Johnson','Male','1999-05-16','Wicket-Keeper','Right-Hand','Leg Spin',2,2022),
(31,'Charlie Evans','Male','1993-09-12','Batsman','Right-Hand','Right Arm Medium',2,2016),
(32,'Benjamin Hall','Male','1996-11-24','All-Rounder','Left-Hand','Off Spin',2,2019),
(33,'Alexander Green','Male','1992-01-31','Bowler','Right-Hand','Right Arm Fast',2,2014),
(34,'Edward Scott','Male','1998-06-07','Batsman','Left-Hand','Leg Spin',2,2021),
(35,'Samuel King','Male','1995-10-19','Bowler','Right-Hand','Right Arm Medium',2,2018),
(36,'Lucas Adams','Male','1997-04-25','All-Rounder','Right-Hand','Left Arm Fast',2,2020),
(37,'James Walker','Male','1994-12-11','Batsman','Right-Hand','Off Spin',2,2017),
(38,'Noah Harris','Male','1999-08-03','Wicket-Keeper','Left-Hand','Leg Spin',2,2022),
(39,'Ethan Lewis','Male','1993-03-27','Bowler','Right-Hand','Right Arm Fast',2,2016),
(40,'Jacob Young','Male','1996-09-15','Batsman','Left-Hand','Right Arm Medium',2,2019),

(41,'Liam Smith','Male','1994-05-12','Batsman','Right-Hand','Off Spin',3,2016),
(42,'Noah Williams','Male','1997-08-18','Bowler','Left-Hand','Left Arm Fast',3,2020),
(43,'Oliver Jones','Male','1993-02-24','All-Rounder','Right-Hand','Right Arm Medium',3,2015),
(44,'George Brown','Male','1996-11-06','Wicket-Keeper','Right-Hand','Leg Spin',3,2019),
(45,'Jack Davis','Male','1998-04-17','Batsman','Left-Hand','Off Spin',3,2021),
(46,'Charlie Miller','Male','1992-07-29','Bowler','Right-Hand','Right Arm Fast',3,2014),
(47,'Harry Wilson','Male','1995-01-13','All-Rounder','Right-Hand','Left Arm Fast',3,2018),
(48,'Thomas Moore','Male','1999-09-21','Batsman','Left-Hand','Right Arm Medium',3,2022),
(49,'James Taylor','Male','1994-06-15','Bowler','Right-Hand','Off Spin',3,2017),
(50,'William Anderson','Male','1997-12-02','Wicket-Keeper','Right-Hand','Leg Spin',3,2020),
(51,'Daniel Thomas','Male','1993-03-19','Batsman','Right-Hand','Right Arm Medium',3,2015),
(52,'Matthew Jackson','Male','1996-10-08','All-Rounder','Left-Hand','Off Spin',3,2019),
(53,'Henry White','Male','1992-05-27','Bowler','Right-Hand','Right Arm Fast',3,2014),
(54,'Samuel Harris','Male','1998-01-16','Batsman','Left-Hand','Leg Spin',3,2021),
(55,'Arthur Martin','Male','1995-08-11','Bowler','Right-Hand','Left Arm Fast',3,2018),
(56,'Oscar Thompson','Male','1997-04-03','All-Rounder','Right-Hand','Right Arm Medium',3,2020),
(57,'Leo Garcia','Male','1994-09-25','Batsman','Left-Hand','Off Spin',3,2017),
(58,'Freddie Martinez','Male','1999-02-14','Wicket-Keeper','Right-Hand','Leg Spin',3,2022),
(59,'Alfie Robinson','Male','1993-11-20','Bowler','Right-Hand','Right Arm Fast',3,2016),
(60,'Archie Clark','Male','1996-06-09','Batsman','Left-Hand','Right Arm Medium',3,2019),

(61,'Kane Williamson','Male','1993-08-17','Batsman','Right-Hand','Off Spin',4,2014),
(62,'Tom Mitchell','Male','1996-01-22','Bowler','Left-Hand','Left Arm Fast',4,2018),
(63,'James Carter','Male','1995-05-14','All-Rounder','Right-Hand','Right Arm Medium',4,2017),
(64,'Henry Cooper','Male','1998-10-05','Wicket-Keeper','Right-Hand','Leg Spin',4,2020),
(65,'Liam Foster','Male','1994-03-18','Batsman','Left-Hand','Off Spin',4,2016),
(66,'Noah Parker','Male','1997-07-26','Bowler','Right-Hand','Right Arm Fast',4,2019),
(67,'Lucas Mitchell','Male','1992-12-09','All-Rounder','Right-Hand','Left Arm Fast',4,2013),
(68,'Ethan Collins','Male','1999-04-21','Batsman','Left-Hand','Right Arm Medium',4,2022),
(69,'Mason Stewart','Male','1995-09-12','Bowler','Right-Hand','Off Spin',4,2018),
(70,'Logan Murray','Male','1993-06-30','Wicket-Keeper','Right-Hand','Leg Spin',4,2015),
(71,'Jack Robinson','Male','1996-02-15','Batsman','Right-Hand','Right Arm Medium',4,2019),
(72,'Oscar Richardson','Male','1998-11-03','All-Rounder','Left-Hand','Off Spin',4,2021),
(73,'Charlie Cox','Male','1994-05-27','Bowler','Right-Hand','Right Arm Fast',4,2017),
(74,'Archie Howard','Male','1997-09-18','Batsman','Left-Hand','Leg Spin',4,2020),
(75,'Leo Ward','Male','1992-04-11','Bowler','Right-Hand','Left Arm Fast',4,2014),
(76,'Finn Morgan','Male','1999-01-29','All-Rounder','Right-Hand','Right Arm Medium',4,2022),
(77,'Max Turner','Male','1995-07-16','Batsman','Left-Hand','Off Spin',4,2018),
(78,'Oscar Bell','Male','1993-10-24','Wicket-Keeper','Right-Hand','Leg Spin',4,2016),
(79,'Hugo Murphy','Male','1996-03-08','Bowler','Right-Hand','Right Arm Fast',4,2019),
(80,'Theo Bailey','Male','1998-08-20','Batsman','Left-Hand','Right Arm Medium',4,2021),

(81,'Temba Bavuma','Male','1992-02-17','Batsman','Right-Hand','Off Spin',5,2015),
(82,'Aiden Markram','Male','1994-06-23','All-Rounder','Right-Hand','Off Spin',5,2017),
(83,'Marco Jansen','Male','1996-04-11','Bowler','Left-Hand','Left Arm Fast',5,2019),
(84,'Quinton de Kock','Male','1993-12-04','Wicket-Keeper','Left-Hand','Leg Spin',5,2014),
(85,'David Miller','Male','1991-11-10','Batsman','Left-Hand','Right Arm Medium',5,2012),
(86,'Kagiso Rabada','Male','1995-05-25','Bowler','Right-Hand','Right Arm Fast',5,2014),
(87,'Keshav Maharaj','Male','1994-02-07','Bowler','Left-Hand','Left Arm Spin',5,2016),
(88,'Heinrich Klaasen','Male','1996-07-30','Wicket-Keeper','Right-Hand','Off Spin',5,2018),
(89,'Rassie van der Dussen','Male','1993-08-16','Batsman','Right-Hand','Right Arm Medium',5,2019),
(90,'Anrich Nortje','Male','1997-09-20','Bowler','Right-Hand','Right Arm Fast',5,2019),
(91,'Reeza Hendricks','Male','1992-06-14','Batsman','Right-Hand','Off Spin',5,2014),
(92,'Gerald Coetzee','Male','1999-10-02','Bowler','Right-Hand','Right Arm Fast',5,2023),
(93,'Wiaan Mulder','Male','1997-02-19','All-Rounder','Right-Hand','Right Arm Medium',5,2017),
(94,'Lungi Ngidi','Male','1995-03-29','Bowler','Right-Hand','Right Arm Fast',5,2017),
(95,'Tristan Stubbs','Male','2000-08-14','Batsman','Right-Hand','Off Spin',5,2022),
(96,'Tony de Zorzi','Male','1997-01-20','Batsman','Left-Hand','Right Arm Medium',5,2023),
(97,'Ryan Rickelton','Male','1996-07-11','Wicket-Keeper','Left-Hand','Off Spin',5,2021),
(98,'Bjorn Fortuin','Male','1994-10-27','Bowler','Left-Hand','Left Arm Spin',5,2019),
(99,'Keshav Pillay','Male','1998-05-06','All-Rounder','Right-Hand','Right Arm Medium',5,2022),
(100,'Nandre Burger','Male','1995-12-18','Bowler','Left-Hand','Left Arm Fast',5,2023),

(101,'Babar Azam','Male','1994-10-15','Batsman','Right-Hand','Off Spin',6,2015),
(102,'Mohammad Rizwan','Male','1992-06-01','Wicket-Keeper','Right-Hand','Off Spin',6,2015),
(103,'Shaheen Afridi','Male','2000-04-06','Bowler','Left-Hand','Left Arm Fast',6,2018),
(104,'Fakhar Zaman','Male','1990-04-10','Batsman','Left-Hand','Left Arm Spin',6,2017),
(105,'Shadab Khan','Male','1998-10-04','All-Rounder','Right-Hand','Leg Spin',6,2017),
(106,'Haris Rauf','Male','1993-11-07','Bowler','Right-Hand','Right Arm Fast',6,2020),
(107,'Imam-ul-Haq','Male','1995-12-12','Batsman','Left-Hand','Off Spin',6,2017),
(108,'Naseem Shah','Male','2003-02-15','Bowler','Right-Hand','Right Arm Fast',6,2019),
(109,'Iftikhar Ahmed','Male','1990-09-03','All-Rounder','Right-Hand','Off Spin',6,2015),
(110,'Salman Ali Agha','Male','1993-11-23','All-Rounder','Right-Hand','Off Spin',6,2021),
(111,'Usama Mir','Male','1995-12-23','Bowler','Right-Hand','Leg Spin',6,2023),
(112,'Abdullah Shafique','Male','1999-11-20','Batsman','Right-Hand','Off Spin',6,2021),
(113,'Saim Ayub','Male','2002-05-24','Batsman','Left-Hand','Left Arm Spin',6,2023),
(114,'Agha Salman','Male','1993-11-23','All-Rounder','Right-Hand','Off Spin',6,2022),
(115,'Hasan Ali','Male','1994-07-02','Bowler','Right-Hand','Right Arm Fast',6,2016),
(116,'Mohammad Nawaz','Male','1994-03-21','All-Rounder','Left-Hand','Left Arm Spin',6,2016),
(117,'Abrar Ahmed','Male','1998-09-16','Bowler','Right-Hand','Leg Spin',6,2022),
(118,'Usman Khan','Male','1995-05-18','Wicket-Keeper','Right-Hand','Off Spin',6,2024),
(119,'Mohammad Wasim','Male','1999-08-25','Bowler','Right-Hand','Right Arm Fast',6,2021),
(120,'Khushdil Shah','Male','1995-02-07','All-Rounder','Left-Hand','Left Arm Spin',6,2019),

(121,'Kusal Mendis','Male','1995-02-02','Wicket-Keeper','Right-Hand','Off Spin',7,2016),
(122,'Pathum Nissanka','Male','1998-05-18','Batsman','Right-Hand','Off Spin',7,2021),
(123,'Charith Asalanka','Male','1997-06-29','All-Rounder','Left-Hand','Right Arm Medium',7,2021),
(124,'Wanindu Hasaranga','Male','1997-07-29','All-Rounder','Right-Hand','Leg Spin',7,2017),
(125,'Maheesh Theekshana','Male','2000-08-01','Bowler','Right-Hand','Off Spin',7,2021),
(126,'Dushmantha Chameera','Male','1992-01-11','Bowler','Right-Hand','Right Arm Fast',7,2015),
(127,'Dhananjaya de Silva','Male','1991-09-06','All-Rounder','Right-Hand','Off Spin',7,2015),
(128,'Kamindu Mendis','Male','1998-09-30','All-Rounder','Left-Hand','Left Arm Spin',7,2022),
(129,'Dinesh Chandimal','Male','1989-11-18','Wicket-Keeper','Right-Hand','Off Spin',7,2010),
(130,'Avishka Fernando','Male','1998-04-05','Batsman','Right-Hand','Right Arm Medium',7,2016),
(131,'Niroshan Dickwella','Male','1993-06-23','Wicket-Keeper','Left-Hand','Off Spin',7,2014),
(132,'Dasun Shanaka','Male','1991-09-09','All-Rounder','Right-Hand','Right Arm Medium',7,2016),
(133,'Asitha Fernando','Male','1997-07-31','Bowler','Right-Hand','Right Arm Fast',7,2021),
(134,'Pramod Madushan','Male','1993-08-24','Bowler','Right-Hand','Right Arm Fast',7,2022),
(135,'Sadeera Samarawickrama','Male','1995-08-30','Wicket-Keeper','Right-Hand','Off Spin',7,2017),
(136,'Dunith Wellalage','Male','2003-01-09','All-Rounder','Left-Hand','Left Arm Spin',7,2022),
(137,'Jeffrey Vandersay','Male','1990-02-05','Bowler','Right-Hand','Leg Spin',7,2015),
(138,'Chamika Karunaratne','Male','1996-05-29','All-Rounder','Right-Hand','Right Arm Medium',7,2021),
(139,'Janith Liyanage','Male','1998-11-16','Batsman','Right-Hand','Right Arm Medium',7,2024),
(140,'Nuwan Thushara','Male','1994-08-06','Bowler','Right-Hand','Right Arm Fast',7,2022),

(141,'Najmul Hossain','Male','1998-08-20','Batsman','Left-Hand','Off Spin',8,2019),
(142,'Litton Das','Male','1994-10-13','Wicket-Keeper','Right-Hand','Off Spin',8,2015),
(143,'Shakib Hasan','Male','1987-03-24','All-Rounder','Left-Hand','Left Arm Spin',8,2006),
(144,'Mehidy Hasan','Male','1997-10-25','All-Rounder','Right-Hand','Off Spin',8,2016),
(145,'Mustafizur Rahman','Male','1995-09-06','Bowler','Left-Hand','Left Arm Fast',8,2015),
(146,'Taskin Ahmed','Male','1995-04-03','Bowler','Right-Hand','Right Arm Fast',8,2014),
(147,'Tanzid Hasan','Male','2000-12-01','Batsman','Left-Hand','Off Spin',8,2023),
(148,'Towhid Hridoy','Male','2000-12-10','Batsman','Right-Hand','Off Spin',8,2023),
(149,'Mahmudullah','Male','1986-02-04','All-Rounder','Right-Hand','Off Spin',8,2007),
(150,'Mushfiqur Rahim','Male','1987-05-09','Wicket-Keeper','Right-Hand','Off Spin',8,2005),
(151,'Tanzim Hasan','Male','2003-12-20','Bowler','Right-Hand','Right Arm Fast',8,2023),
(152,'Rishad Hossain','Male','2002-07-15','Bowler','Right-Hand','Leg Spin',8,2024),
(153,'Jaker Ali','Male','1998-02-22','Wicket-Keeper','Right-Hand','Off Spin',8,2024),
(154,'Soumya Sarkar','Male','1993-02-25','All-Rounder','Left-Hand','Right Arm Medium',8,2014),
(155,'Anamul Haque','Male','1992-12-16','Wicket-Keeper','Right-Hand','Off Spin',8,2012),
(156,'Afif Hossain','Male','1999-09-22','All-Rounder','Left-Hand','Right Arm Medium',8,2018),
(157,'Nasum Ahmed','Male','1993-12-05','Bowler','Left-Hand','Left Arm Spin',8,2021),
(158,'Shoriful Islam','Male','2001-06-03','Bowler','Left-Hand','Left Arm Fast',8,2021),
(159,'Hasan Mahmud','Male','1999-10-12','Bowler','Right-Hand','Right Arm Fast',8,2020),
(160,'Zakir Hasan','Male','1998-02-01','Batsman','Left-Hand','Off Spin',8,2023),

(161,'Rahmanullah Gurbaz','Male','2001-11-28','Wicket-Keeper','Right-Hand','Off Spin',9,2019),
(162,'Ibrahim Zadran','Male','2001-12-12','Batsman','Right-Hand','Off Spin',9,2019),
(163,'Rashid Khan','Male','1998-09-20','All-Rounder','Right-Hand','Leg Spin',9,2015),
(164,'Mohammad Nabi','Male','1985-01-01','All-Rounder','Right-Hand','Off Spin',9,2009),
(165,'Azmatullah Omarzai','Male','2000-03-24','All-Rounder','Right-Hand','Right Arm Medium',9,2021),
(166,'Fazalhaq Farooqi','Male','2000-09-22','Bowler','Left-Hand','Left Arm Fast',9,2021),
(167,'Mujeeb Ur Rahman','Male','2001-03-28','Bowler','Right-Hand','Off Spin',9,2017),
(168,'Najibullah Zadran','Male','1993-02-18','Wicket-Keeper','Left-Hand','Off Spin',9,2012),
(169,'Hashmatullah Shahidi','Male','1994-11-04','Batsman','Left-Hand','Off Spin',9,2013),
(170,'Gulbadin Naib','Male','1991-03-16','All-Rounder','Right-Hand','Right Arm Medium',9,2011),
(171,'Naveen-ul-Haq','Male','1999-09-23','Bowler','Right-Hand','Right Arm Medium',9,2016),
(172,'Noor Ahmad','Male','2005-01-03','Bowler','Left-Hand','Left Arm Spin',9,2022),
(173,'Karim Janat','Male','1998-08-11','All-Rounder','Right-Hand','Right Arm Medium',9,2016),
(174,'Ishmat Alam','Male','1997-04-15','Batsman','Right-Hand','Off Spin',9,2020),
(175,'Sediqullah Atal','Male','2001-09-12','Batsman','Left-Hand','Off Spin',9,2023),
(176,'Ikram Alikhil','Male','2000-11-03','Wicket-Keeper','Left-Hand','Off Spin',9,2019),
(177,'Qais Ahmad','Male','2000-08-15','Bowler','Right-Hand','Leg Spin',9,2017),
(178,'Afsar Zazai','Male','1993-03-05','Wicket-Keeper','Right-Hand','Off Spin',9,2014),
(179,'Sharafuddin Ashraf','Male','1995-05-17','All-Rounder','Left-Hand','Left Arm Spin',9,2016),
(180,'Darwish Rasooli','Male','1999-05-08','Batsman','Right-Hand','Off Spin',9,2018),

(181,'Chris Gayle','Male','1979-09-21','Batsman','Left-Hand','Right Arm Medium',10,1999),
(182,'Nicholas Pooran','Male','1995-10-02','Wicket-Keeper','Left-Hand','Off Spin',10,2016),
(183,'Shai Hope','Male','1993-11-10','Wicket-Keeper','Right-Hand','Off Spin',10,2016),
(184,'Roston Chase','Male','1992-03-22','All-Rounder','Right-Hand','Off Spin',10,2016),
(185,'Jason Holder','Male','1991-11-05','All-Rounder','Right-Hand','Right Arm Fast',10,2013),
(186,'Alzarri Joseph','Male','1996-11-20','Bowler','Right-Hand','Right Arm Fast',10,2016),
(187,'Brandon King','Male','1994-11-16','Batsman','Right-Hand','Off Spin',10,2019),
(188,'Evin Lewis','Male','1991-12-27','Batsman','Left-Hand','Right Arm Medium',10,2016),
(189,'Shimron Hetmyer','Male','1996-12-26','Batsman','Left-Hand','Right Arm Medium',10,2017),
(190,'Andre Russell','Male','1988-04-29','All-Rounder','Right-Hand','Right Arm Fast',10,2010),
(191,'Romario Shepherd','Male','1994-11-26','All-Rounder','Right-Hand','Right Arm Fast',10,2019),
(192,'Odean Smith','Male','1996-11-01','All-Rounder','Right-Hand','Right Arm Fast',10,2018),
(193,'Gudakesh Motie','Male','1995-06-29','Bowler','Left-Hand','Left Arm Spin',10,2016),
(194,'Obed McCoy','Male','1997-01-04','Bowler','Left-Hand','Left Arm Fast',10,2021),
(195,'Johnson Charles','Male','1989-01-14','Wicket-Keeper','Right-Hand','Off Spin',10,2012),
(196,'Keacy Carty','Male','1997-06-19','Batsman','Right-Hand','Off Spin',10,2022),
(197,'Justin Greaves','Male','1994-08-26','All-Rounder','Right-Hand','Right Arm Medium',10,2021),
(198,'Alick Athanaze','Male','1999-12-12','Batsman','Left-Hand','Off Spin',10,2023),
(199,'Sherfane Rutherford','Male','1998-08-15','All-Rounder','Left-Hand','Left Arm Medium',10,2018),
(200,'Hayden Walsh','Male','1992-04-23','Bowler','Right-Hand','Leg Spin',10,2019);

-- To Find Players Count

SELECT COUNT(*) AS Total_Players
FROM Players;


-- Check The Team Distribution

SELECT
    t.Team_Name,
    COUNT(p.Player_ID) AS Total_Players
FROM Teams t
LEFT JOIN Players p
    ON t.Team_ID = p.Team_ID
GROUP BY t.Team_ID, t.Team_Name
ORDER BY t.Team_ID;


-- ========================================
-- Insert Match Records
-- ========================================

INSERT INTO Matches
(Match_ID, Match_Date, Match_Format, Team1_ID, Team2_ID, Venue_ID, Winner_Team_ID, Player_of_Match)
VALUES
(1,'2024-01-12','ODI',1,2,1,1,2),
(2,'2024-01-15','T20',1,3,2,3,21),
(3,'2024-01-20','ODI',2,4,8,2,22),
(4,'2024-02-02','T20',3,5,11,5,82),
(5,'2024-02-10','ODI',4,6,16,4,61),
(6,'2024-02-18','T20',5,7,19,7,122),
(7,'2024-03-01','ODI',6,8,20,6,101),
(8,'2024-03-12','T20',7,9,1,7,124),
(9,'2024-03-20','ODI',8,10,4,8,143),
(10,'2024-04-05','T20',9,1,17,1,3),

(11,'2024-04-15','ODI',1,4,3,1,4),
(12,'2024-04-25','T20',2,5,9,5,85),
(13,'2024-05-03','ODI',3,6,12,3,43),
(14,'2024-05-15','T20',4,7,17,7,124),
(15,'2024-05-25','ODI',5,8,19,5,86),
(16,'2024-06-02','T20',6,9,20,9,163),
(17,'2024-06-10','ODI',7,10,2,7,122),
(18,'2024-06-20','T20',8,1,6,1,5),
(19,'2024-07-01','ODI',9,2,18,2,22),
(20,'2024-07-12','T20',10,3,13,10,182),

(21,'2024-07-20','ODI',1,5,5,1,2),
(22,'2024-08-02','T20',2,6,10,6,103),
(23,'2024-08-15','ODI',3,7,14,3,43),
(24,'2024-08-25','T20',4,8,16,8,142),
(25,'2024-09-05','ODI',5,9,19,5,86),
(26,'2024-09-15','T20',6,10,20,6,101),
(27,'2024-09-25','ODI',7,1,1,1,3),
(28,'2024-10-05','T20',8,2,4,2,102),
(29,'2024-10-15','ODI',9,3,17,3,43),
(30,'2024-10-25','T20',10,4,13,10,185),

(31,'2025-01-10','ODI',1,6,2,1,5),
(32,'2025-01-20','T20',2,7,8,7,124),
(33,'2025-02-01','ODI',3,8,11,3,41),
(34,'2025-02-12','T20',4,9,16,9,163),
(35,'2025-02-25','ODI',5,10,19,5,85),
(36,'2025-03-05','T20',6,1,20,1,2),
(37,'2025-03-15','ODI',7,2,3,7,122),
(38,'2025-03-25','T20',8,3,4,3,43),
(39,'2025-04-05','ODI',9,4,18,9,163),
(40,'2025-04-15','T20',10,5,13,10,182),

(41,'2025-05-01','ODI',1,7,1,1,3),
(42,'2025-05-12','T20',2,8,9,8,143),
(43,'2025-05-25','ODI',3,9,11,3,43),
(44,'2025-06-05','T20',4,10,17,4,61),
(45,'2025-06-15','ODI',5,1,19,5,86),
(46,'2025-06-25','T20',6,2,20,6,103),
(47,'2025-07-05','ODI',7,3,2,7,122),
(48,'2025-07-15','T20',8,4,16,8,143),
(49,'2025-08-01','ODI',9,5,18,9,163),
(50,'2025-08-15','T20',10,6,13,10,185);


-- To Find Total Matches Count

SELECT COUNT(*) AS Total_Matches
FROM Matches;


-- ========================================
-- Insert Battinng Statistics Records
-- ========================================

INSERT INTO Batting_Statistics
(Batting_ID, Match_ID, Player_ID, Runs, Balls_Faced, Fours, Sixes, Strike_Rate)
VALUES
(1,1,1,72,86,7,1,83.72),
(2,1,2,95,101,9,2,94.06),
(3,1,3,41,35,5,1,117.14),
(4,1,4,28,31,3,0,90.32),

(5,2,1,38,25,4,2,152.00),
(6,2,2,67,44,6,3,152.27),
(7,2,3,25,18,2,1,138.89),
(8,2,5,3,6,0,0,50.00),

(9,3,21,81,92,8,2,88.04),
(10,3,22,16,22,2,0,72.73),
(11,3,23,45,39,5,1,115.38),
(12,3,24,32,35,3,1,91.43),

(13,4,41,63,71,6,1,88.73),
(14,4,42,12,18,1,0,66.67),
(15,4,43,74,62,8,3,119.35),
(16,4,44,35,29,4,1,120.69),

(17,5,61,89,103,10,1,86.41),
(18,5,62,8,15,1,0,53.33),
(19,5,63,52,47,5,2,110.64),
(20,5,64,24,27,2,1,88.89),

(21,6,81,76,69,8,2,110.14),
(22,6,82,92,77,10,3,119.48),
(23,6,83,18,14,2,1,128.57),
(24,6,84,41,36,4,1,113.89),

(25,7,101,84,96,8,2,87.50),
(26,7,102,51,43,5,1,118.60),
(27,7,103,9,12,1,0,75.00),
(28,7,105,35,29,3,2,120.69),

(29,8,121,78,63,9,2,123.81),
(30,8,122,54,46,6,1,117.39),
(31,8,123,37,31,4,1,119.35),
(32,8,124,22,18,2,1,122.22),

(33,9,141,68,72,7,1,94.44),
(34,9,142,43,38,4,1,113.16),
(35,9,143,81,66,8,3,122.73),
(36,9,144,29,24,3,1,120.83),

(37,10,161,91,74,10,3,122.97),
(38,10,162,46,52,4,1,88.46),
(39,10,163,34,21,3,2,161.90),
(40,10,164,27,23,2,1,117.39),

(41,11,1,105,112,11,2,93.75),
(42,11,2,76,88,7,1,86.36),
(43,11,4,33,35,3,1,94.29),
(44,11,7,52,47,5,2,110.64),

(45,12,21,64,55,6,2,116.36),
(46,12,22,27,31,3,0,87.10),
(47,12,25,73,59,8,2,123.73),
(48,12,26,14,17,1,0,82.35),

(49,13,41,88,91,9,2,96.70),
(50,13,43,39,28,4,2,139.29),
(51,13,45,61,54,7,1,112.96),
(52,13,46,19,23,2,0,82.61),

(53,14,61,55,48,6,1,114.58),
(54,14,63,79,68,8,3,116.18),
(55,14,64,31,26,3,1,119.23),
(56,14,65,42,37,4,1,113.51),

(57,15,85,97,105,9,3,92.38),
(58,15,86,11,18,1,0,61.11),
(59,15,88,46,39,5,1,117.95),
(60,15,89,63,58,6,2,108.62),

(61,16,101,71,62,7,2,114.52),
(62,16,103,18,16,2,1,112.50),
(63,16,105,43,34,4,2,126.47),
(64,16,107,59,51,6,1,115.69),

(65,17,121,94,82,10,2,114.63),
(66,17,122,36,31,4,0,116.13),
(67,17,124,47,39,5,2,120.51),
(68,17,125,12,14,1,0,85.71),

(69,18,142,72,64,8,1,112.50),
(70,18,143,58,47,6,2,123.40),
(71,18,145,14,12,1,1,116.67),
(72,18,146,6,9,0,0,66.67),

(73,19,163,83,71,8,4,116.90),
(74,19,164,49,43,5,1,113.95),
(75,19,165,62,51,6,2,121.57),
(76,19,166,8,11,1,0,72.73),

(77,20,181,92,76,9,5,121.05),
(78,20,182,68,49,7,3,138.78),
(79,20,183,44,39,4,1,112.82),
(80,20,184,35,28,3,2,125.00),

(81,21,1,63,72,6,1,87.50),
(82,21,2,88,94,8,2,93.62),
(83,21,3,47,41,5,1,114.63),
(84,21,5,21,19,2,1,110.53),

(85,22,22,74,67,8,2,110.45),
(86,22,23,36,31,4,1,116.13),
(87,22,25,58,44,6,2,131.82),
(88,22,27,29,25,3,1,116.00),

(89,23,41,91,96,9,2,94.79),
(90,23,43,67,53,7,2,126.42),
(91,23,45,34,29,3,1,117.24),
(92,23,47,42,35,4,1,120.00),

(93,24,61,76,82,7,2,92.68),
(94,24,63,51,43,5,1,118.60),
(95,24,64,38,31,4,1,122.58),
(96,24,65,27,24,3,0,112.50),

(97,25,85,82,91,8,2,90.11),
(98,25,88,54,47,6,1,114.89),
(99,25,89,71,64,7,2,110.94),
(100,25,90,17,19,2,0,89.47),

(101,26,101,96,89,10,2,107.87),
(102,26,102,42,37,4,1,113.51),
(103,26,103,12,14,1,0,85.71),
(104,26,105,57,44,5,3,129.55),

(105,27,121,85,73,9,3,116.44),
(106,27,122,67,59,7,1,113.56),
(107,27,123,43,36,4,1,119.44),
(108,27,124,31,25,3,1,124.00),

(109,28,142,81,74,8,2,109.46),
(110,28,143,45,38,5,1,118.42),
(111,28,144,39,32,4,1,121.88),
(112,28,145,8,10,1,0,80.00),

(113,29,163,77,65,8,3,118.46),
(114,29,165,58,51,6,2,113.73),
(115,29,167,19,17,2,0,111.76),
(116,29,169,64,59,5,1,108.47),

(117,30,182,86,67,8,4,128.36),
(118,30,183,51,45,5,1,113.33),
(119,30,185,63,52,6,3,121.15),
(120,30,187,42,36,4,1,116.67),

(121,31,1,118,124,12,3,95.16),
(122,31,2,69,81,6,1,85.19),
(123,31,4,31,29,3,1,106.90),
(124,31,7,57,48,6,2,118.75),

(125,32,21,83,79,8,2,105.06),
(126,32,25,49,42,5,1,116.67),
(127,32,27,67,55,7,2,121.82),
(128,32,30,32,28,3,1,114.29),

(129,33,41,74,81,7,1,91.36),
(130,33,43,93,72,10,3,129.17),
(131,33,44,28,24,3,1,116.67),
(132,33,45,46,39,5,1,117.95),

(133,34,61,68,73,6,2,93.15),
(134,34,63,84,67,9,2,125.37),
(135,34,64,35,31,4,1,112.90),
(136,34,66,23,21,2,1,109.52),

(137,35,85,105,112,11,2,93.75),
(138,35,88,39,35,4,1,111.43),
(139,35,89,72,61,7,2,118.03),
(140,35,91,27,29,3,0,93.10),

(141,36,101,82,76,8,3,107.89),
(142,36,102,63,51,6,2,123.53),
(143,36,105,41,32,4,1,128.13),
(144,36,107,18,16,2,0,112.50),

(145,37,121,73,68,7,2,107.35),
(146,37,122,91,87,9,2,104.60),
(147,37,124,36,29,4,1,124.14),
(148,37,126,11,13,1,0,84.62),

(149,38,142,65,53,6,2,122.64),
(150,38,143,78,62,8,3,125.81),
(151,38,144,44,35,4,1,125.71),
(152,38,146,17,14,2,0,121.43),

(153,39,163,101,86,11,4,117.44),
(154,39,165,55,44,6,2,125.00),
(155,39,169,37,35,3,1,105.71),
(156,39,170,26,24,2,1,108.33),

(157,40,181,79,68,7,4,116.18),
(158,40,182,61,48,6,3,127.08),
(159,40,184,48,39,5,1,123.08),
(160,40,185,34,25,3,2,136.00),

(161,41,1,86,94,8,2,91.49),
(162,41,3,52,45,5,2,115.56),
(163,41,5,7,11,1,0,63.64),
(164,41,7,44,39,4,1,112.82),

(165,42,22,91,76,10,3,119.74),
(166,42,25,46,41,5,1,112.20),
(167,42,27,53,44,5,2,120.45),
(168,42,30,18,15,2,0,120.00),

(169,43,41,102,109,11,2,93.58),
(170,43,43,48,41,5,1,117.07),
(171,43,45,57,49,6,2,116.33),
(172,43,47,33,29,3,1,113.79),

(173,44,61,95,101,9,3,94.06),
(174,44,63,43,37,4,2,116.22),
(175,44,64,29,25,3,1,116.00),
(176,44,65,51,44,5,1,115.91),

(177,45,85,88,97,8,2,90.72),
(178,45,89,59,53,6,1,111.32),
(179,45,91,41,36,4,1,113.89),
(180,45,93,34,28,3,1,121.43),

(181,46,101,73,69,7,2,105.80),
(182,46,102,58,47,6,1,123.40),
(183,46,105,65,51,6,3,127.45),
(184,46,107,27,24,3,0,112.50),

(185,47,121,97,88,10,3,110.23),
(186,47,122,62,57,6,1,108.77),
(187,47,124,48,37,5,2,129.73),
(188,47,126,14,16,1,0,87.50),

(189,48,142,73,65,7,2,112.31),
(190,48,143,66,54,7,2,122.22),
(191,48,144,38,31,4,1,122.58),
(192,48,145,9,12,1,0,75.00),

(193,49,163,88,75,9,3,117.33),
(194,49,165,61,53,6,2,115.09),
(195,49,169,45,42,4,1,107.14),
(196,49,170,32,28,3,1,114.29),

(197,50,181,104,89,12,4,116.85),
(198,50,182,72,55,7,4,130.91),
(199,50,185,58,43,6,2,134.88),
(200,50,187,39,31,4,1,125.81);

-- To Find Batting Statistics

SELECT COUNT(*) AS Total_Batting_Records
FROM Batting_Statistics;


-- ========================================
-- Insert Bowling Statistics Records
-- ========================================

INSERT INTO Bowling_Statistics
(Bowling_ID, Match_ID, Player_ID, Overs, Runs_Conceded, Wickets, Economy)
VALUES
(1,1,5,10.0,48,3,4.80),
(2,1,6,8.0,52,2,6.50),
(3,1,10,6.0,31,1,5.17),
(4,1,11,4.0,29,1,7.25),

(5,2,5,4.0,28,2,7.00),
(6,2,9,4.0,35,1,8.75),
(7,2,10,3.0,22,1,7.33),
(8,2,12,4.0,31,2,7.75),

(9,3,22,10.0,51,3,5.10),
(10,3,23,7.0,42,2,6.00),
(11,3,26,10.0,59,2,5.90),
(12,3,29,8.0,47,1,5.88),

(13,4,42,10.0,55,3,5.50),
(14,4,43,8.0,48,2,6.00),
(15,4,46,7.0,39,2,5.57),
(16,4,49,5.0,36,1,7.20),

(17,5,62,10.0,46,4,4.60),
(18,5,63,8.0,53,2,6.63),
(19,5,66,10.0,61,3,6.10),
(20,5,69,6.0,38,1,6.33),

(21,6,86,10.0,52,3,5.20),
(22,6,87,10.0,45,2,4.50),
(23,6,90,8.0,61,2,7.63),
(24,6,92,6.0,39,1,6.50),

(25,7,103,10.0,44,4,4.40),
(26,7,106,9.0,57,3,6.33),
(27,7,108,8.0,49,2,6.13),
(28,7,115,5.0,35,1,7.00),

(29,8,125,10.0,48,3,4.80),
(30,8,126,8.0,56,2,7.00),
(31,8,133,7.0,42,2,6.00),
(32,8,137,6.0,38,1,6.33),

(33,9,145,10.0,51,3,5.10),
(34,9,146,8.0,62,2,7.75),
(35,9,157,10.0,47,3,4.70),
(36,9,158,6.0,43,1,7.17),

(37,10,166,10.0,54,4,5.40),
(38,10,167,8.0,41,2,5.13),
(39,10,171,6.0,37,1,6.17),
(40,10,177,6.0,44,2,7.33),

(41,11,5,10.0,43,4,4.30),
(42,11,6,8.0,49,2,6.13),
(43,11,11,10.0,55,2,5.50),
(44,11,13,5.0,34,1,6.80),

(45,12,22,10.0,47,3,4.70),
(46,12,26,8.0,51,2,6.38),
(47,12,29,7.0,43,1,6.14),
(48,12,32,6.0,39,2,6.50),

(49,13,42,10.0,50,3,5.00),
(50,13,46,8.0,44,2,5.50),
(51,13,49,10.0,58,3,5.80),
(52,13,53,5.0,32,1,6.40),

(53,14,62,10.0,49,3,4.90),
(54,14,63,8.0,57,2,7.13),
(55,14,66,7.0,46,2,6.57),
(56,14,69,6.0,41,1,6.83),

(57,15,86,10.0,42,4,4.20),
(58,15,87,10.0,51,2,5.10),
(59,15,90,8.0,55,2,6.88),
(60,15,94,6.0,38,1,6.33),

(61,16,103,10.0,39,4,3.90),
(62,16,106,8.0,52,2,6.50),
(63,16,108,8.0,48,3,6.00),
(64,16,116,6.0,35,1,5.83),

(65,17,125,10.0,46,3,4.60),
(66,17,126,8.0,53,2,6.63),
(67,17,133,7.0,40,2,5.71),
(68,17,137,6.0,45,1,7.50),

(69,18,145,10.0,48,3,4.80),
(70,18,146,8.0,55,2,6.88),
(71,18,157,10.0,43,4,4.30),
(72,18,158,6.0,39,1,6.50),

(73,19,166,10.0,47,4,4.70),
(74,19,167,8.0,52,2,6.50),
(75,19,171,7.0,44,2,6.29),
(76,19,177,6.0,41,1,6.83),

(77,20,186,10.0,58,3,5.80),
(78,20,190,8.0,62,2,7.75),
(79,20,193,10.0,45,3,4.50),
(80,20,194,6.0,39,1,6.50),

(81,21,5,10.0,50,3,5.00),
(82,21,6,8.0,47,2,5.88),
(83,21,10,6.0,36,2,6.00),
(84,21,12,5.0,32,1,6.40),

(85,22,22,10.0,54,3,5.40),
(86,22,26,8.0,46,2,5.75),
(87,22,29,7.0,43,2,6.14),
(88,22,32,5.0,37,1,7.40),

(89,23,42,10.0,52,3,5.20),
(90,23,43,8.0,49,2,6.13),
(91,23,46,7.0,41,2,5.86),
(92,23,49,6.0,45,1,7.50),

(93,24,62,10.0,44,4,4.40),
(94,24,63,8.0,58,2,7.25),
(95,24,66,7.0,47,2,6.71),
(96,24,69,5.0,33,1,6.60),

(97,25,86,10.0,49,3,4.90),
(98,25,90,8.0,57,2,7.13),
(99,25,94,10.0,51,3,5.10),
(100,25,98,6.0,38,1,6.33),

(101,26,103,10.0,42,4,4.20),
(102,26,106,8.0,55,2,6.88),
(103,26,108,8.0,49,3,6.13),
(104,26,115,6.0,41,1,6.83),

(105,27,125,10.0,47,3,4.70),
(106,27,126,8.0,54,2,6.75),
(107,27,133,7.0,43,2,6.14),
(108,27,137,6.0,37,1,6.17),

(109,28,145,10.0,51,3,5.10),
(110,28,146,8.0,58,2,7.25),
(111,28,157,10.0,46,3,4.60),
(112,28,158,6.0,40,1,6.67),

(113,29,166,10.0,45,4,4.50),
(114,29,167,8.0,49,2,6.13),
(115,29,171,7.0,42,2,6.00),
(116,29,177,6.0,39,1,6.50),

(117,30,186,10.0,55,3,5.50),
(118,30,190,8.0,60,2,7.50),
(119,30,193,10.0,48,3,4.80),
(120,30,194,6.0,42,1,7.00),

(121,31,5,10.0,46,4,4.60),
(122,31,6,8.0,54,2,6.75),
(123,31,10,7.0,39,2,5.57),
(124,31,13,5.0,31,1,6.20),

(125,32,22,10.0,49,3,4.90),
(126,32,26,8.0,56,2,7.00),
(127,32,29,7.0,44,2,6.29),
(128,32,32,6.0,37,1,6.17),

(129,33,42,10.0,53,3,5.30),
(130,33,46,8.0,47,2,5.88),
(131,33,49,10.0,61,3,6.10),
(132,33,53,5.0,34,1,6.80),

(133,34,62,10.0,48,4,4.80),
(134,34,63,8.0,59,2,7.38),
(135,34,66,7.0,45,2,6.43),
(136,34,69,6.0,40,1,6.67),

(137,35,86,10.0,44,4,4.40),
(138,35,87,10.0,52,2,5.20),
(139,35,90,8.0,56,2,7.00),
(140,35,94,6.0,37,1,6.17),

(141,36,103,10.0,41,4,4.10),
(142,36,106,8.0,57,2,7.13),
(143,36,108,8.0,46,3,5.75),
(144,36,116,6.0,35,1,5.83),

(145,37,125,10.0,50,3,4.80),
(146,37,126,8.0,55,2,6.88),
(147,37,133,7.0,42,2,6.00),
(148,37,137,6.0,38,1,6.33),

(149,38,145,10.0,47,3,4.70),
(150,38,146,8.0,61,2,7.63),
(151,38,157,10.0,44,4,4.40),
(152,38,158,6.0,41,1,6.83),

(153,39,166,10.0,52,4,5.20),
(154,39,167,8.0,48,2,6.00),
(155,39,171,7.0,43,2,6.14),
(156,39,177,6.0,40,1,6.67),

(157,40,186,10.0,59,3,5.90),
(158,40,190,8.0,64,2,8.00),
(159,40,193,10.0,47,3,4.70),
(160,40,194,6.0,38,1,6.33),

(161,41,5,10.0,45,4,4.50),
(162,41,6,8.0,51,2,6.38),
(163,41,11,10.0,57,2,5.70),
(164,41,12,5.0,34,1,6.80),

(165,42,22,10.0,46,3,4.60),
(166,42,26,8.0,53,2,6.63),
(167,42,29,7.0,41,2,5.86),
(168,42,32,6.0,36,1,6.00),

(169,43,42,10.0,49,4,4.90),
(170,43,43,8.0,54,2,6.75),
(171,43,46,7.0,40,2,5.71),
(172,43,49,6.0,43,1,7.17),

(173,44,62,10.0,47,4,4.70),
(174,44,63,8.0,61,2,7.63),
(175,44,66,7.0,44,2,6.29),
(176,44,69,6.0,39,1,6.50),

(177,45,86,10.0,43,4,4.30),
(178,45,90,8.0,55,2,6.88),
(179,45,94,10.0,49,3,4.90),
(180,45,98,6.0,37,1,6.17),

(181,46,103,10.0,40,4,4.00),
(182,46,106,8.0,58,2,7.25),
(183,46,108,8.0,47,3,5.88),
(184,46,115,6.0,33,1,5.50),

(185,47,125,10.0,45,4,4.50),
(186,47,126,8.0,52,2,6.50),
(187,47,133,7.0,41,2,5.86),
(188,47,137,6.0,39,1,6.50),

(189,48,145,10.0,50,3,5.00),
(190,48,146,8.0,57,2,7.13),
(191,48,157,10.0,42,4,4.20),
(192,48,158,6.0,36,1,6.00),

(193,49,166,10.0,46,4,4.60),
(194,49,167,8.0,51,2,6.38),
(195,49,171,7.0,43,2,6.14),
(196,49,177,6.0,38,1,6.33),

(197,50,186,10.0,56,3,5.60),
(198,50,190,8.0,63,2,7.88),
(199,50,193,10.0,44,4,4.40),
(200,50,194,6.0,40,1,6.67);

-- To Find Bowling Statistics

SELECT COUNT(*) AS Total_Bowling_Records
FROM Bowling_Statistics;


-- ========================================
-- Display All Player
-- ========================================

SELECT *
FROM Players;



-- ========================================
-- STORED PROCEDURES 
-- ========================================

-- SP #1 — SP_AddRecord

-- Purpose: Add a new player with validation and transaction handling.

DELIMITER //

CREATE PROCEDURE SP_AddRecord(
    IN p_Player_ID INT,
    IN p_Player_Name VARCHAR(100),
    IN p_Team_ID INT,
    IN p_Role VARCHAR(50),
    IN p_Batting_Style VARCHAR(50),
    IN p_Bowling_Style VARCHAR(50),
    IN p_Date_of_Birth DATE,
    IN p_Debut_Year INT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred. Transaction rolled back.' AS Message;
    END;

    START TRANSACTION;

    -- Validate player ID
    IF EXISTS (
        SELECT 1
        FROM Players
        WHERE Player_ID = p_Player_ID
    ) THEN

        ROLLBACK;
        SELECT 'Player ID already exists.' AS Message;

    -- Validate player name
    ELSEIF p_Player_Name IS NULL OR TRIM(p_Player_Name) = '' THEN

        ROLLBACK;
        SELECT 'Player name cannot be empty.' AS Message;

    -- Validate team
    ELSEIF NOT EXISTS (
        SELECT 1
        FROM Teams
        WHERE Team_ID = p_Team_ID
    ) THEN

        ROLLBACK;
        SELECT 'Invalid Team ID.' AS Message;

    ELSE

        INSERT INTO Players (
            Player_ID,
            Player_Name,
            Team_ID,
            Role,
            Batting_Style,
            Bowling_Style,
            Date_of_Birth,
            Debut_Year
        )
        VALUES (
            p_Player_ID,
            p_Player_Name,
            p_Team_ID,
            p_Role,
            p_Batting_Style,
            p_Bowling_Style,
            p_Date_of_Birth,
            p_Debut_Year
        );

        COMMIT;

        SELECT 'Player added successfully.' AS Message;

    END IF;

END //

DELIMITER ;

-- CALL FUCNTION 
CALL SP_AddRecord(
    201,
    'Test Player',
    1,
    'Batsman',
    'Right Hand',
    'Right Arm',
    '2000-01-01',
    2020
);



-- SP #2 — SP_UpdateRecord

-- Purpose: Update an existing player's details using UPDATE, IF...ELSE, CASE, and exception handling.

DELIMITER //

CREATE PROCEDURE SP_UpdateRecord(
    IN p_Player_ID INT,
    IN p_New_Team_ID INT,
    IN p_New_Role VARCHAR(50)
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred. Transaction rolled back.' AS Message;
    END;

    START TRANSACTION;

    -- Check whether player exists
    IF NOT EXISTS (
        SELECT 1
        FROM Players
        WHERE Player_ID = p_Player_ID
    ) THEN

        ROLLBACK;
        SELECT 'Player not found.' AS Message;

    -- Check whether team exists
    ELSEIF NOT EXISTS (
        SELECT 1
        FROM Teams
        WHERE Team_ID = p_New_Team_ID
    ) THEN

        ROLLBACK;
        SELECT 'Invalid Team ID.' AS Message;

    ELSE

        UPDATE Players
        SET
            Team_ID = p_New_Team_ID,
            Role = CASE
                WHEN p_New_Role = 'Batsman' THEN 'Batsman'
                WHEN p_New_Role = 'Bowler' THEN 'Bowler'
                WHEN p_New_Role = 'All-Rounder' THEN 'All-Rounder'
                WHEN p_New_Role = 'Wicket-Keeper' THEN 'Wicket-Keeper'
                ELSE Role
            END
        WHERE Player_ID = p_Player_ID;

        COMMIT;

        SELECT 'Player updated successfully.' AS Message;

    END IF;

END //

DELIMITER ;

-- CALL FUNCTION
CALL SP_UpdateRecord(
    101,
    2,
    'All-Rounder'
);



-- SP #3 — SP_DeleteRecord

-- Purpose: Delete a player record using DELETE and transaction handling.

DELIMITER //

CREATE PROCEDURE SP_DeleteRecord(
    IN p_Player_ID INT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred. Transaction rolled back.' AS Message;
    END;

    START TRANSACTION;

    -- Check whether player exists
    IF NOT EXISTS (
        SELECT 1
        FROM Players
        WHERE Player_ID = p_Player_ID
    ) THEN

        ROLLBACK;
        SELECT 'Player not found.' AS Message;

    ELSE

        -- Delete related statistics first
        DELETE FROM Batting_Statistics
        WHERE Player_ID = p_Player_ID;

        DELETE FROM Bowling_Statistics
        WHERE Player_ID = p_Player_ID;

        -- Delete player
        DELETE FROM Players
        WHERE Player_ID = p_Player_ID;

        COMMIT;

        SELECT 'Player and related statistics deleted successfully.' AS Message;

    END IF;

END //

DELIMITER ;

-- CALL FUNCTION
CALL SP_DeleteRecord(201);

 
-- SP #4 — SP_SearchRecords

-- Purpose: Search players using SELECT, WHERE, LIKE, and ORDER BY.

DELIMITER //

CREATE PROCEDURE SP_SearchRecords(
    IN p_Player_Name VARCHAR(100),
    IN p_Role VARCHAR(50)
)
BEGIN

    SELECT
        p.Player_ID,
        p.Player_Name,
        t.Team_Name,
        p.Role,
        p.Batting_Style,
        p.Bowling_Style,
        p.Date_of_Birth,
        p.Debut_Year
    FROM Players p
    INNER JOIN Teams t
        ON p.Team_ID = t.Team_ID
    WHERE
        (p_Player_Name IS NULL
         OR p.Player_Name LIKE CONCAT('%', p_Player_Name, '%'))
        AND
        (p_Role IS NULL
         OR p.Role = p_Role)
    ORDER BY p.Player_Name ASC;

END //

DELIMITER ;



-- SP #5 — SP_DetailedReport

-- Purpose: Generate a detailed player performance report using JOIN and ORDER BY.

DROP PROCEDURE IF EXISTS SP_DetailedReport;

DELIMITER //

CREATE PROCEDURE SP_DetailedReport()
BEGIN

    SELECT
        p.Player_ID,
        p.Player_Name,
        t.Team_Name,
        p.Role,
        p.Batting_Style,
        p.Bowling_Style,
        COALESCE(b.Runs, 0) AS Runs,
        COALESCE(b.Balls_Faced, 0) AS Balls_Faced,
        COALESCE(b.Fours, 0) AS Fours,
        COALESCE(b.Sixes, 0) AS Sixes,
        COALESCE(w.Overs, 0) AS Overs,
        COALESCE(w.Runs_Conceded, 0) AS Runs_Conceded,
        COALESCE(w.Wickets, 0) AS Wickets
    FROM Players p
    INNER JOIN Teams t
        ON p.Team_ID = t.Team_ID
    LEFT JOIN Batting_Statistics b
        ON p.Player_ID = b.Player_ID
    LEFT JOIN Bowling_Statistics w
        ON p.Player_ID = w.Player_ID
    ORDER BY
        Runs DESC,
        Wickets DESC;

END //

DELIMITER ;

-- CALL FUNCTION 
CALL SP_DetailedReport();



-- SP #6 — SP_SummaryReport

-- Purpose: Generate a team-wise summary using COUNT(), SUM(), AVG(), MIN(), MAX(), GROUP BY, and HAVING.

DROP PROCEDURE IF EXISTS SP_SummaryReport;

DELIMITER //

CREATE PROCEDURE SP_SummaryReport(
    IN p_Min_Total_Runs INT
)
BEGIN

    SELECT
        t.Team_ID,
        t.Team_Name,
        COUNT(DISTINCT p.Player_ID) AS Total_Players,
        COALESCE(SUM(b.Runs), 0) AS Total_Runs,
        COALESCE(AVG(b.Runs), 0) AS Average_Runs,
        COALESCE(MIN(b.Runs), 0) AS Minimum_Runs,
        COALESCE(MAX(b.Runs), 0) AS Maximum_Runs
    FROM Teams t
    INNER JOIN Players p
        ON t.Team_ID = p.Team_ID
    LEFT JOIN Batting_Statistics b
        ON p.Player_ID = b.Player_ID
    GROUP BY
        t.Team_ID,
        t.Team_Name
    HAVING
        COALESCE(SUM(b.Runs), 0) >= p_Min_Total_Runs
    ORDER BY
        Total_Runs DESC;

END //

DELIMITER ;

-- CALL FUNCTON
CALL SP_SummaryReport(100);



-- SP #7 — SP_MonthlyOrYearlyReport

-- Purpose: Generate a monthly match report for a selected year using date functions, GROUP BY, and ORDER BY.

DELIMITER //

CREATE PROCEDURE SP_MonthlyOrYearlyReport(
    IN p_Year INT
)
BEGIN

    SELECT
        YEAR(Match_Date) AS Match_Year,
        MONTH(Match_Date) AS Match_Month,
        MONTHNAME(Match_Date) AS Month_Name,
        COUNT(*) AS Total_Matches
    FROM Matches
    WHERE YEAR(Match_Date) = p_Year
    GROUP BY
        YEAR(Match_Date),
        MONTH(Match_Date),
        MONTHNAME(Match_Date)
    ORDER BY
        Match_Month ASC;

END //

DELIMITER ;

-- CALL FUCNTION 
CALL SP_MonthlyOrYearlyReport(2025);



-- SP #8 — SP_TopNAnalysis

-- Purpose: Perform Top-N player analysis using CTE, ROW_NUMBER(), RANK(), DENSE_RANK(), PARTITION BY, LEAD(), LAG(), FIRST_VALUE(), and LAST_VALUE().

DROP PROCEDURE IF EXISTS SP_TopNAnalysis;

DELIMITER //

CREATE PROCEDURE SP_TopNAnalysis(
    IN p_TopN INT
)
BEGIN

    WITH PlayerPerformance AS
    (
        SELECT
            p.Player_ID,
            p.Player_Name,
            p.Team_ID,
            t.Team_Name,
            COALESCE(b.Runs, 0) AS Runs
        FROM Players p
        INNER JOIN Teams t
            ON p.Team_ID = t.Team_ID
        LEFT JOIN Batting_Statistics b
            ON p.Player_ID = b.Player_ID
    ),

    RankedPlayers AS
    (
        SELECT
            Player_ID,
            Player_Name,
            Team_ID,
            Team_Name,
            Runs,

            ROW_NUMBER() OVER (
                PARTITION BY Team_ID
                ORDER BY Runs DESC
            ) AS Row_Number_Rank,

            RANK() OVER (
                PARTITION BY Team_ID
                ORDER BY Runs DESC
            ) AS Player_Rank,

            DENSE_RANK() OVER (
                PARTITION BY Team_ID
                ORDER BY Runs DESC
            ) AS Dense_Rank_Value,

            LAG(Runs) OVER (
                PARTITION BY Team_ID
                ORDER BY Runs DESC
            ) AS Previous_Runs,

            LEAD(Runs) OVER (
                PARTITION BY Team_ID
                ORDER BY Runs DESC
            ) AS Next_Runs,

            FIRST_VALUE(Runs) OVER (
                PARTITION BY Team_ID
                ORDER BY Runs DESC
            ) AS Highest_Team_Runs,

            LAST_VALUE(Runs) OVER (
                PARTITION BY Team_ID
                ORDER BY Runs DESC
                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) AS Lowest_Team_Runs

        FROM PlayerPerformance
    )

    SELECT
        Player_ID,
        Player_Name,
        Team_Name,
        Runs,
        Row_Number_Rank,
        Player_Rank,
        Dense_Rank_Value,
        Previous_Runs,
        Next_Runs,
        Highest_Team_Runs,
        Lowest_Team_Runs
    FROM RankedPlayers
    WHERE Row_Number_Rank <= p_TopN
    ORDER BY
        Team_Name ASC,
        Runs DESC;

END //

DELIMITER ;

-- CALL FUNCTION
CALL SP_TopNAnalysis(5);



-- SP #9 — SP_CategoryWiseAnalysis

-- Purpose: Analyze player performance category-wise using GROUP BY, HAVING, and aggregate functions.

DROP PROCEDURE IF EXISTS SP_CategoryWiseAnalysis;

DELIMITER //

CREATE PROCEDURE SP_CategoryWiseAnalysis(
    IN p_Min_Players INT
)
BEGIN

    SELECT
        p.Role AS Category,
        COUNT(DISTINCT p.Player_ID) AS Total_Players,
        COALESCE(SUM(b.Runs), 0) AS Total_Runs,
        COALESCE(AVG(b.Runs), 0) AS Average_Runs,
        COALESCE(MIN(b.Runs), 0) AS Minimum_Runs,
        COALESCE(MAX(b.Runs), 0) AS Maximum_Runs
    FROM Players p
    LEFT JOIN Batting_Statistics b
        ON p.Player_ID = b.Player_ID
    GROUP BY
        p.Role
    HAVING
        COUNT(DISTINCT p.Player_ID) >= p_Min_Players
    ORDER BY
        Total_Runs DESC;

END //

DELIMITER ;  

-- CALL FUCNTION
CALL SP_CategoryWiseAnalysis(1);


-- SP #10 — SP_BusinessValidation

-- Purpose: Perform business validation using IF...ELSE, CASE, transactions, and exception handling.

DELIMITER //

CREATE PROCEDURE SP_BusinessValidation(
    IN p_Player_ID INT,
    IN p_New_Team_ID INT
)
BEGIN

    DECLARE v_Role VARCHAR(50);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred. Transaction rolled back.' AS Message;
    END;

    START TRANSACTION;

    -- Validate player
    IF NOT EXISTS (
        SELECT 1
        FROM Players
        WHERE Player_ID = p_Player_ID
    ) THEN

        ROLLBACK;
        SELECT 'Player does not exist.' AS Message;

    -- Validate team
    ELSEIF NOT EXISTS (
        SELECT 1
        FROM Teams
        WHERE Team_ID = p_New_Team_ID
    ) THEN

        ROLLBACK;
        SELECT 'Invalid Team ID.' AS Message;

    ELSE

        SELECT Role
        INTO v_Role
        FROM Players
        WHERE Player_ID = p_Player_ID;

        UPDATE Players
        SET Team_ID = p_New_Team_ID
        WHERE Player_ID = p_Player_ID;

        COMMIT;

        SELECT
            p.Player_ID,
            p.Player_Name,
            t.Team_Name,
            p.Role,
            CASE
                WHEN v_Role = 'Batsman' THEN 'Batting Specialist'
                WHEN v_Role = 'Bowler' THEN 'Bowling Specialist'
                WHEN v_Role = 'All-Rounder' THEN 'All-Round Performance Player'
                WHEN v_Role = 'Wicket-Keeper' THEN 'Wicket-Keeping Specialist'
                ELSE 'Other Player'
            END AS Player_Category,
            'Business validation successful.' AS Message
        FROM Players p
        INNER JOIN Teams t
            ON p.Team_ID = t.Team_ID
        WHERE p.Player_ID = p_Player_ID;

    END IF;

END //

DELIMITER ;

-- CALL FUNCTION
CALL SP_BusinessValidation(101, 2);



-- SP- #11- SP_GroupBy_Having

DROP PROCEDURE IF EXISTS SP_GroupBy_Having;

DELIMITER //

CREATE PROCEDURE SP_GroupBy_Having()
BEGIN

    SELECT
        t.Team_Name,
        COUNT(p.Player_ID) AS Player_Count,
        AVG(YEAR(CURDATE()) - YEAR(p.Date_of_Birth)) AS Average_Age
    FROM Teams t
    INNER JOIN Players p
        ON t.Team_ID = p.Team_ID
    GROUP BY t.Team_ID, t.Team_Name
    HAVING COUNT(p.Player_ID) >= 10
    ORDER BY Player_Count DESC;

END //

DELIMITER ;

-- CALL FUNCTION
CALL SP_GroupBy_Having();



-- SP #12- SP_Join_Analysis

DROP PROCEDURE IF EXISTS SP_Join_Analysis;

DELIMITER //

CREATE PROCEDURE SP_Join_Analysis()
BEGIN

    SELECT
        p.Player_ID,
        p.Player_Name,
        t.Team_Name,
        COUNT(b.Batting_ID) AS Batting_Records,
        COUNT(bs.Bowling_ID) AS Bowling_Records
    FROM Players p
    INNER JOIN Teams t
        ON p.Team_ID = t.Team_ID
    LEFT JOIN Batting_Statistics b
        ON p.Player_ID = b.Player_ID
    LEFT JOIN Bowling_Statistics bs
        ON p.Player_ID = bs.Player_ID
    GROUP BY
        p.Player_ID,
        p.Player_Name,
        t.Team_Name
    ORDER BY p.Player_ID;

END //

DELIMITER ;

-- CALL FUNCTION
CALL SP_Join_Analysis();



-- SP #13- SP_CTE_Analysis

DROP PROCEDURE IF EXISTS SP_CTE_Analysis;

DELIMITER //

CREATE PROCEDURE SP_CTE_Analysis()
BEGIN

    WITH PlayerRuns AS
    (
        SELECT
            p.Player_ID,
            p.Player_Name,
            SUM(b.Runs) AS Total_Runs
        FROM Players p
        INNER JOIN Batting_Statistics b
            ON p.Player_ID = b.Player_ID
        GROUP BY
            p.Player_ID,
            p.Player_Name
    )

    SELECT
        Player_ID,
        Player_Name,
        Total_Runs
    FROM PlayerRuns
    ORDER BY Total_Runs DESC;

END //

DELIMITER ;

-- CALL FUCNTION
CALL SP_CTE_Analysis();



-- SP #14- SP_Date_Function_Analysis

DROP PROCEDURE IF EXISTS SP_Date_Function_Analysis;

DELIMITER //

CREATE PROCEDURE SP_Date_Function_Analysis(
    IN p_Year INT
)
BEGIN

    SELECT
        YEAR(Match_Date) AS Match_Year,
        MONTH(Match_Date) AS Match_Month,
        MONTHNAME(Match_Date) AS Month_Name,
        COUNT(Match_ID) AS Total_Matches
    FROM Matches
    WHERE YEAR(Match_Date) = p_Year
    GROUP BY
        YEAR(Match_Date),
        MONTH(Match_Date),
        MONTHNAME(Match_Date)
    ORDER BY
        Match_Month;

END //

DELIMITER ;

-- CALL FUNCTION
CALL SP_Date_Function_Analysis(2025);



-- SP #15- SP_Case_Category_Analysis

DROP PROCEDURE IF EXISTS SP_Case_Category_Analysis;

DELIMITER //

CREATE PROCEDURE SP_Case_Category_Analysis()
BEGIN

    SELECT
        Player_ID,
        Player_Name,
        Role,
        CASE
            WHEN Role = 'Batsman' THEN 'Batting Specialist'
            WHEN Role = 'Bowler' THEN 'Bowling Specialist'
            WHEN Role = 'All-Rounder' THEN 'All-Rounder'
            WHEN Role = 'Wicket-Keeper' THEN 'Wicket-Keeper'
            ELSE 'Other'
        END AS Player_Category
    FROM Players
    ORDER BY Player_Category, Player_Name;

END //

DELIMITER ;

-- CALL FUNCTION
CALL SP_Case_Category_Analysis();



-- SP #16-  SP_Distinct_Analysis

DROP PROCEDURE IF EXISTS SP_Distinct_Analysis;

DELIMITER //

CREATE PROCEDURE SP_Distinct_Analysis()
BEGIN

    SELECT DISTINCT
        Role,
        Batting_Style,
        Bowling_Style
    FROM Players
    WHERE Role IS NOT NULL
    ORDER BY Role, Batting_Style, Bowling_Style;

END //

DELIMITER ;

-- CALL FUNCTTION
CALL SP_Distinct_Analysis();


-- SP #17- SP_TransactionManagement
DROP PROCEDURE IF EXISTS SP_TransactionManagement;

DELIMITER //

CREATE PROCEDURE SP_TransactionManagement(
    IN p_Player_ID1 INT,
    IN p_Team_ID1 INT,
    IN p_Player_ID2 INT,
    IN p_Team_ID2 INT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred. Transaction rolled back.' AS Message;
    END;

    START TRANSACTION;

    -- First update
    UPDATE Players
    SET Team_ID = p_Team_ID1
    WHERE Player_ID = p_Player_ID1;

    -- Create SAVEPOINT
    SAVEPOINT Player_Update;

    -- Second update
    UPDATE Players
    SET Team_ID = p_Team_ID2
    WHERE Player_ID = p_Player_ID2;

    -- Rollback only the second update
    ROLLBACK TO Player_Update;

    -- Commit the first update
    COMMIT;

    SELECT 'Transaction completed successfully. First update committed.' AS Message;

END //

DELIMITER ;

-- CALL FUNCTTION
CALL SP_TransactionManagement(101, 2, 102, 3);

-- Check the result
SELECT Player_ID, Player_Name, Team_ID
FROM Players
WHERE Player_ID IN (101, 102);




-- SP #18-  SP_TransactionErrorHandling
DROP PROCEDURE IF EXISTS SP_TransactionErrorHandling;

DELIMITER //

CREATE PROCEDURE SP_TransactionErrorHandling(
    IN p_Player_ID INT,
    IN p_Team_ID INT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred. Transaction rolled back.' AS Message;
    END;

    START TRANSACTION;

    UPDATE Players
    SET Team_ID = p_Team_ID
    WHERE Player_ID = p_Player_ID;

    COMMIT;

    SELECT 'Transaction completed successfully.' AS Message;

END //

DELIMITER ;

-- CALL FUNCTTION
CALL SP_TransactionErrorHandling(101, 2);

CALL SP_TransactionErrorHandling(101, 9999);

-- Check the player
SELECT Player_ID, Player_Name, Team_ID
FROM Players
WHERE Player_ID = 101;


-- ========================================
-- FUNCTONS - USER DEFINED FUNCTON
-- ========================================

-- Function #1 — Total Runs of a Player

-- Purpose: Return the total runs scored by a particular player.

DELIMITER //

CREATE FUNCTION FN_TotalRuns(
    p_Player_ID INT
)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE v_Total_Runs INT;

    SELECT COALESCE(SUM(Runs_Scored), 0)
    INTO v_Total_Runs
    FROM Batting_Statistics
    WHERE Player_ID = p_Player_ID;

    RETURN v_Total_Runs;

END //

DELIMITER ;

-- Total Runs
SELECT FN_TotalRuns(101);



-- Function #2 — FN_TotalWickets

-- Purpose: Return the total wickets taken by a particular player.

DELIMITER //

CREATE FUNCTION FN_TotalWickets(
    p_Player_ID INT
)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE v_Total_Wickets INT;

    SELECT COALESCE(SUM(Wickets), 0)
    INTO v_Total_Wickets
    FROM Bowling_Statistics
    WHERE Player_ID = p_Player_ID;

    RETURN v_Total_Wickets;

END //

DELIMITER ;

-- Total Wickets
SELECT FN_TotalWickets(101);



-- Function #3 — FN_AverageRuns

-- Purpose: Return the average runs scored by a particular player.

DROP FUNCTION IF EXISTS FN_AverageRuns;

DELIMITER //

CREATE FUNCTION FN_AverageRuns(p_Player_ID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_Average_Runs DECIMAL(10,2);

    SELECT COALESCE(AVG(Runs), 0)
    INTO v_Average_Runs
    FROM Batting_Statistics
    WHERE Player_ID = p_Player_ID;

    RETURN v_Average_Runs;
END //

DELIMITER ;


-- Average Runs
SELECT FN_AverageRuns(1);




-- Function #4 — FN_PlayerRunsCategory

-- Purpose: Return a performance category based on the player's total runs.

DELIMITER //

CREATE FUNCTION FN_PlayerRunsCategory(
    p_Player_ID INT
)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN

    DECLARE v_Total_Runs INT;

    SELECT COALESCE(SUM(Runs_Scored), 0)
    INTO v_Total_Runs
    FROM Batting_Statistics
    WHERE Player_ID = p_Player_ID;

    RETURN CASE
        WHEN v_Total_Runs >= 1000 THEN 'Excellent'
        WHEN v_Total_Runs >= 500 THEN 'Good'
        WHEN v_Total_Runs >= 200 THEN 'Average'
        ELSE 'Needs Improvement'
    END;

END //

DELIMITER ;

-- Player Runs Category
SELECT FN_PlayerRunsCategory(101);



-- Function #5 — FN_PlayerBattingStyle 

-- Purpose: Return the batting style of a particular player.

DELIMITER //

CREATE FUNCTION FN_PlayerBattingStyle(
    p_Player_ID INT
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN

    DECLARE v_Batting_Style VARCHAR(50);

    SELECT Batting_Style
    INTO v_Batting_Style
    FROM Players
    WHERE Player_ID = p_Player_ID;

    RETURN COALESCE(v_Batting_Style, 'Unknown');

END //

DELIMITER ;

-- Player Batting Style
SELECT FN_PlayerBattingStyle(101);



-- Function #6 — FN_PlayerRole

-- Purpose: Return the role of a particular player.

DELIMITER //


CREATE FUNCTION FN_PlayerRole(
    p_Player_ID INT
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN

    DECLARE v_Role VARCHAR(50);

    SELECT Role
    INTO v_Role
    FROM Players
    WHERE Player_ID = p_Player_ID;

    RETURN COALESCE(v_Role, 'Unknown');

END //

DELIMITER ;

-- Player Role
SELECT FN_PlayerRole(101);



-- Function #7 — FN_TotalMatches

-- Purpose: Return the total number of matches played by a particular year.

DELIMITER //

CREATE FUNCTION FN_TotalMatchesByYear(
    p_Year INT
)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE v_Total_Matches INT;

    SELECT COUNT(*)
    INTO v_Total_Matches
    FROM Matches
    WHERE YEAR(Match_Date) = p_Year;

    RETURN v_Total_Matches;

END //

DELIMITER ;

-- Total Matches by Year
SELECT FN_TotalMatchesByYear(2025);




-- Function #8 — FN_PlayerDebutYear

-- Purpose: Return the debut year of a particular player.

DELIMITER //

CREATE FUNCTION FN_PlayerDebutYear(
    p_Player_ID INT
)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE v_Debut_Year INT;

    SELECT Debut_Year
    INTO v_Debut_Year
    FROM Players
    WHERE Player_ID = p_Player_ID;

    RETURN COALESCE(v_Debut_Year, 0);

END //

DELIMITER ;

-- Player Debut Year
SELECT FN_PlayerDebutYear(101);




-- Function #9 — FN_PlayerName

-- Purpose: Return the name of a particular player.

DELIMITER //

CREATE FUNCTION FN_PlayerName(
    p_Player_ID INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN

    DECLARE v_Player_Name VARCHAR(100);

    SELECT Player_Name
    INTO v_Player_Name
    FROM Players
    WHERE Player_ID = p_Player_ID;

    RETURN COALESCE(v_Player_Name, 'Unknown');

END //

DELIMITER ;

-- Player Name
SELECT FN_PlayerName(101);




-- Function #10 — FN_PlayerBowlingStyle

-- Purpose: Return the bowling style of a particular player.

DELIMITER //

CREATE FUNCTION FN_PlayerBowlingStyle(
    p_Player_ID INT
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN

    DECLARE v_Bowling_Style VARCHAR(50);

    SELECT Bowling_Style
    INTO v_Bowling_Style
    FROM Players
    WHERE Player_ID = p_Player_ID;

    RETURN COALESCE(v_Bowling_Style, 'Unknown');

END //

DELIMITER ;

-- Player Bowling Style
SELECT FN_PlayerBowlingStyle(101);


SELECT
    FN_PlayerName(101) AS Player_Name,
    FN_TotalRuns(101) AS Total_Runs,
    FN_TotalWickets(101) AS Total_Wickets,
    FN_AverageRuns(101) AS Average_Runs,
    FN_PlayerRole(101) AS Player_Role,
    FN_PlayerBattingStyle(101) AS Batting_Style,
    FN_PlayerBowlingStyle(101) AS Bowling_Style,
    FN_PlayerDebutYear(101) AS Debut_Year;


SHOW CREATE FUNCTION FN_TotalRuns;
SHOW CREATE FUNCTION FN_AverageRuns;


-- ========================================
-- VIEWS
-- ========================================

--  View #1: VW_PlayerDetails

-- Purpose: Create a reusable view combining player and team information.

CREATE VIEW VW_PlayerDetails AS
SELECT
    p.Player_ID,
    p.Player_Name,
    t.Team_Name,
    p.Role,
    p.Batting_Style,
    p.Bowling_Style,
    p.Date_of_Birth,
    p.Debut_Year
FROM Players p
INNER JOIN Teams t
    ON p.Team_ID = t.Team_ID;
    
-- View VW_PlayerDetails
SELECT * FROM VW_PlayerDetails;
    
    

-- View #2 — VW_PlayerBattingPerformance

DROP VIEW IF EXISTS VW_PlayerBattingPerformance;

CREATE VIEW VW_PlayerBattingPerformance AS
SELECT
    p.Player_ID,
    p.Player_Name,
    t.Team_Name,
    p.Role,
    b.Runs,
    b.Balls_Faced,
    b.Fours,
    b.Sixes
FROM Players p
INNER JOIN Teams t
    ON p.Team_ID = t.Team_ID
INNER JOIN Batting_Statistics b
    ON p.Player_ID = b.Player_ID;
    
    
-- 2. Check Player Batting Performance
SELECT *
FROM VW_PlayerBattingPerformance;
    
    
    
-- View #3 — VW_PlayerBowlingPerformance
CREATE VIEW VW_PlayerBowlingPerformance AS
SELECT
    p.Player_ID,
    p.Player_Name,
    t.Team_Name,
    p.Role,
    w.Overs,
    w.Runs_Conceded,
    w.Wickets
FROM Players p
INNER JOIN Teams t
    ON p.Team_ID = t.Team_ID
INNER JOIN Bowling_Statistics w
    ON p.Player_ID = w.Player_ID;
    
-- 3. Check Player Bowling Performance
SELECT *
FROM VW_PlayerBowlingPerformance;

    
    
-- View #4 — VW_TopRunScorers
DROP VIEW IF EXISTS VW_TopRunScorers;

CREATE VIEW VW_TopRunScorers AS
SELECT
    p.Player_ID,
    p.Player_Name,
    t.Team_Name,
    b.Runs,
    b.Balls_Faced,
    b.Fours,
    b.Sixes
FROM Players p
INNER JOIN Teams t
    ON p.Team_ID = t.Team_ID
INNER JOIN Batting_Statistics b
    ON p.Player_ID = b.Player_ID
WHERE b.Runs >= 50
ORDER BY b.Runs DESC;

-- 4. Check Top Run Scorers
SELECT *
FROM VW_TopRunScorers;




-- View #5 — VW_TeamPerformance
DROP VIEW IF EXISTS VW_TeamPerformance;

CREATE VIEW VW_TeamPerformance AS
SELECT
    t.Team_ID,
    t.Team_Name,
    COUNT(DISTINCT p.Player_ID) AS Total_Players,
    COALESCE(SUM(b.Runs), 0) AS Total_Runs,
    COALESCE(AVG(b.Runs), 0) AS Average_Runs
FROM Teams t
LEFT JOIN Players p
    ON t.Team_ID = p.Team_ID
LEFT JOIN Batting_Statistics b
    ON p.Player_ID = b.Player_ID
GROUP BY
    t.Team_ID,
    t.Team_Name;

-- 5. Check Team Performance
SELECT *
FROM VW_TeamPerformance;

    
    
-- View #6 — VW_TeamBowlingPerformance

CREATE VIEW VW_TeamBowlingPerformance AS
SELECT
    t.Team_ID,
    t.Team_Name,
    COUNT(DISTINCT p.Player_ID) AS Total_Players,
    COALESCE(SUM(w.Wickets), 0) AS Total_Wickets,
    COALESCE(SUM(w.Runs_Conceded), 0) AS Total_Runs_Conceded,
    COALESCE(AVG(w.Wickets), 0) AS Average_Wickets
FROM Teams t
LEFT JOIN Players p
    ON t.Team_ID = p.Team_ID
LEFT JOIN Bowling_Statistics w
    ON p.Player_ID = w.Player_ID
GROUP BY
    t.Team_ID,
    t.Team_Name;
    
-- 6. Check Team Bowling Performance
SELECT *
FROM VW_TeamBowlingPerformance;


    
    
-- View #7 — VW_PlayerCompletePerformance
DROP VIEW IF EXISTS VW_PlayerCompletePerformance;

CREATE VIEW VW_PlayerCompletePerformance AS
SELECT
    p.Player_ID,
    p.Player_Name,
    t.Team_Name,
    p.Role,
    p.Batting_Style,
    p.Bowling_Style,
    COALESCE(b.Runs, 0) AS Runs,
    COALESCE(b.Balls_Faced, 0) AS Balls_Faced,
    COALESCE(b.Fours, 0) AS Fours,
    COALESCE(b.Sixes, 0) AS Sixes,
    COALESCE(w.Overs, 0) AS Overs,
    COALESCE(w.Runs_Conceded, 0) AS Runs_Conceded,
    COALESCE(w.Wickets, 0) AS Wickets
FROM Players p
INNER JOIN Teams t
    ON p.Team_ID = t.Team_ID
LEFT JOIN Batting_Statistics b
    ON p.Player_ID = b.Player_ID
LEFT JOIN Bowling_Statistics w
    ON p.Player_ID = w.Player_ID;    
    
-- 7. Check Complete Player Performance
SELECT *
FROM VW_PlayerCompletePerformance;


    
-- View #8 — VW_MatchDetails
DROP VIEW IF EXISTS VW_MatchDetails;

CREATE VIEW VW_MatchDetails AS
SELECT
    m.Match_ID,
    m.Match_Date,
    m.Match_Format,
    m.Winner_Team_ID,
    m.Player_of_Match,
    v.Venue_Name
FROM Matches m
INNER JOIN Venues v
    ON m.Venue_ID = v.Venue_ID;
    
 -- 8. Check Match Details
SELECT *
FROM VW_MatchDetails;

   
    
-- View #9 — VW_MatchVenueSummary
DROP VIEW IF EXISTS VW_MatchTypeSummary;

CREATE VIEW VW_MatchTypeSummary AS
SELECT
    Match_Format,
    COUNT(*) AS Total_Matches
FROM Matches
GROUP BY Match_Format
ORDER BY Total_Matches DESC;

-- 9. Check Match Venue Summary
SELECT *
FROM VW_MatchVenueSummary;

    
    
-- View #10 — VW_MatchTypeSummary
DROP VIEW IF EXISTS VW_MatchTypeSummary;

CREATE VIEW VW_MatchTypeSummary AS
SELECT
    Match_Format,
    COUNT(*) AS Total_Matches
FROM Matches
GROUP BY Match_Format
ORDER BY Total_Matches DESC;


-- 10. Check Match Type Summary
SELECT *
FROM VW_MatchTypeSummary;




-- ========================================
-- TRIGGERS
-- ========================================

-- TRIGGERS (BEFORE)
-- Trigger 1: Prevent Negative Batting Statistics

-- This trigger will automatically validate batting statistics before inserting a record. If runs, balls, fours, or sixes contain a negative value, the insert will be rejected.

-- 1. BEFORE INSERT — Player Validation
DROP TRIGGER IF EXISTS TRG_ValidatePlayerInsert;

DELIMITER //

CREATE TRIGGER TRG_ValidatePlayerInsert
BEFORE INSERT ON Players
FOR EACH ROW
BEGIN
    IF NEW.Player_Name IS NULL OR TRIM(NEW.Player_Name) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Player name cannot be empty';

    ELSEIF NEW.Debut_Year > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Debut year cannot be in the future';
    END IF;
END //

DELIMITER ;

SELECT * FROM Players WHERE Player_ID = 201;


-- 2. BEFORE UPDATE — Batting Validation
DROP TRIGGER IF EXISTS TRG_ValidateBattingUpdate;

DELIMITER //

CREATE TRIGGER TRG_ValidateBattingUpdate
BEFORE UPDATE ON Batting_Statistics
FOR EACH ROW
BEGIN
    IF NEW.Runs < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Runs scored cannot be negative';

    ELSEIF NEW.Balls_Faced < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Balls faced cannot be negative';

    ELSEIF NEW.Fours < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Fours cannot be negative';

    ELSEIF NEW.Sixes < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sixes cannot be negative';
    END IF;
END //

DELIMITER ;


SELECT Batting_ID, Runs, Balls_Faced, Fours, Sixes
FROM Batting_Statistics
WHERE Batting_ID = 1;

UPDATE Batting_Statistics
SET Runs = 100
WHERE Batting_ID = 1;



-- 3. BEFORE DELETE — Player Validation
DROP TRIGGER IF EXISTS TRG_ValidatePlayerDelete;

DELIMITER //

CREATE TRIGGER TRG_ValidatePlayerDelete
BEFORE DELETE ON Players
FOR EACH ROW
BEGIN
    IF OLD.Player_ID IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid player ID';
    END IF;
END //

DELIMITER ;

SELECT * FROM Players
WHERE Player_ID = 101;

DELETE FROM Players
WHERE Player_ID = 101;


-- TRIGGERS (AFTER)

-- 4. AFTER INSERT — Player Audit
DROP TRIGGER IF EXISTS TRG_AfterPlayerInsert;

DELIMITER //

CREATE TRIGGER TRG_AfterPlayerInsert
AFTER INSERT ON Players
FOR EACH ROW
BEGIN
    INSERT INTO Player_Audit
    (
        Player_ID,
        Player_Name,
        Action_Type,
        Action_Date,
        Message
    )
    VALUES
    (
        NEW.Player_ID,
        NEW.Player_Name,
        'INSERT',
        NOW(),
        'Player successfully inserted'
    );
END //

DELIMITER ;


INSERT INTO Players
(
    Player_Name,
    Gender,
    Date_of_Birth,
    Role,
    Batting_Style,
    Bowling_Style,
    Team_ID,
    Debut_Year
)
VALUES
(
    'Vaibhav Sooriyavanshi',
    'Male',
    '2010-03-10',
    'Batsman',
    'Left Hand',
    'Left Arm',
    1,
    2025
);

SELECT *
FROM Players
WHERE Player_Name = 'Vaibhav Sooriyavanshi';

SELECT *
FROM Player_Audit
ORDER BY Audit_ID DESC
LIMIT 1;


DROP TRIGGER IF EXISTS TRG_AfterPlayerUpdate;

DELIMITER //

CREATE TRIGGER TRG_AfterPlayerUpdate
AFTER UPDATE ON Players
FOR EACH ROW
BEGIN
    INSERT INTO Player_Audit
    (
        Player_ID,
        Player_Name,
        Action_Type,
        Action_Date,
        Message
    )
    VALUES
    (
        NEW.Player_ID,
        NEW.Player_Name,
        'UPDATE',
        NOW(),
        'Player successfully updated'
    );
END //

DELIMITER ;

-- Perform Update

UPDATE Players
SET Role = 'All-Rounder'
WHERE Player_ID = 201;

-- Check The Audit

SELECT *
FROM Player_Audit
ORDER BY Audit_ID DESC
LIMIT 1;

-- View the updated player

SELECT *
FROM Players
WHERE Player_ID = 201;


-- 6. AFTER DELETE — Player Audit

DROP TRIGGER IF EXISTS TRG_AfterPlayerDelete;

DELIMITER //

CREATE TRIGGER TRG_AfterPlayerDelete
AFTER DELETE ON Players
FOR EACH ROW
BEGIN
    INSERT INTO Player_Audit
    (
        Player_ID,
        Player_Name,
        Action_Type,
        Action_Date,
        Message
    )
    VALUES
    (
        OLD.Player_ID,
        OLD.Player_Name,
        'DELETE',
        NOW(),
        'Player successfully deleted'
    );
END //

DELIMITER ;


-- After deleting a player
DELETE FROM Players
WHERE Player_ID = 201;


-- Check the audit:
SELECT *
FROM Player_Audit
ORDER BY Audit_ID DESC
LIMIT 1;

-- To see the complete Player_Audit table
SELECT *
FROM Player_Audit;



-- ========================================
-- INDEXES
-- ========================================

-- 1. Index on Player Name

CREATE INDEX IDX_Player_Name
ON Players(Player_Name);


-- 2. Index on Team ID

CREATE INDEX IDX_Player_Team_ID
ON Players(Team_ID);


-- 3. Index on Match Date

CREATE INDEX IDX_Match_Date
ON Matches(Match_Date);



-- 4. Index on Team Name
CREATE INDEX IDX_Team_Name
ON Teams(Team_Name);



-- 5. Index on Venue Name
CREATE INDEX IDX_Venue_Name
ON Venues(Venue_Name);



-- 6. Index on Batting Player ID
CREATE INDEX IDX_Batting_Player_ID
ON Batting_Statistics(Player_ID);



-- 7. Index on Bowling Player ID
CREATE INDEX IDX_Bowling_Player_ID
ON Bowling_Statistics(Player_ID);



-- View indexes on Players
SHOW INDEX FROM Players;


-- View index on Matches
SHOW INDEX FROM Matches;


-- Views index on Teams
SHOW INDEX FROM Teams;


-- View index on Venues
SHOW INDEX FROM Venues;


-- View index on Batting_Statistics
SHOW INDEX FROM Batting_Statistics;


-- View index on Bowling 
SHOW INDEX FROM Bowling_Statistics;



SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE,
    SEQ_IN_INDEX
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'CricketStatisticsDB'
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;


SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE,
    SEQ_IN_INDEX
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'CricketStatisticsDB'
  AND INDEX_NAME LIKE 'IDX_%'
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;


    
    

-- ========================================
-- TO DISPLAY ALL TABLES
-- ========================================


-- 1. Teams
SELECT * FROM Teams;


-- 2. Venues
SELECT * FROM Venues;


-- 3. Players
SELECT * FROM Players;


-- 4. Matches
SELECT * FROM Matches;


-- 5. Batting Statistics
SELECT * FROM Batting_Statistics;


-- 6. Bowling Statistics
SELECT * FROM Bowling_Statistics;


-- 7. Player Audit
SELECT * FROM Player_Audit; 


-- ========================================
-- TO SHOW ALL DETAILS 
-- ========================================

-- VERIFY ALL TABLES
SHOW TABLES;


-- VERIFY ALL 10 STORE PROCEDURES
SHOW PROCEDURE STATUS
WHERE Db = DATABASE();


-- VERIFY ALL 10 FUNCTIONS
SHOW FUNCTION STATUS
WHERE Db = DATABASE();


-- VERIFY ALL 20 VIEWS
SHOW FULL TABLES
WHERE Table_type = 'VIEW';


-- VERIFY ALL 6 TRIGGERS
SHOW TRIGGERS;


-- ========================================
-- FINAL DATA-COUNT VERIFICATION
-- ========================================
SELECT 'Teams' AS Table_Name, COUNT(*) AS Record_Count FROM Teams
UNION ALL
SELECT 'Venues', COUNT(*) FROM Venues
UNION ALL
SELECT 'Players', COUNT(*) FROM Players
UNION ALL
SELECT 'Matches', COUNT(*) FROM Matches
UNION ALL
SELECT 'Batting_Statistics', COUNT(*) FROM Batting_Statistics
UNION ALL
SELECT 'Bowling_Statistics', COUNT(*) FROM Bowling_Statistics;


-- FINAL PROJECT CONCEPT VERIFICATION
SELECT
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = DATABASE()
ORDER BY TABLE_TYPE, TABLE_NAME;




