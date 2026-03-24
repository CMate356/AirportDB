CREATE DATABASE dbAeroport
ON
PRIMARY ( NAME = Aeroport,
          FILENAME = 'D:\DB\Aeroport_1.mdf',
          SIZE = 10,
          MAXSIZE = 40,
          FILEGROWTH = 2)
LOG ON
( NAME = Aeroport_log,
  FILENAME = 'D:\DB\Aeroport_1.ldf',
  SIZE = 10,
  MAXSIZE = 20,
  FILEGROWTH = 2)
GO

USE dbAeroport
GO

CREATE TABLE tblPilot(
    ID_Pilot           char(8) PRIMARY KEY CLUSTERED,
    LastName     varchar(40) NOT NULL,
    FirstName  varchar(40) NOT NULL,
    Sex             char(1) CHECK (Sex IN ('M','F')) DEFAULT('M'),
    BirthDate     datetime
)
GO
CREATE TABLE tblPassenger(
	SSN_Passenger     char(8) PRIMARY KEY CLUSTERED,
    LastName     varchar(40) NOT NULL,
    FirstName  varchar(40) NOT NULL,
    Sex             char(1) CHECK (Sex IN ('M','F')) DEFAULT('M'),
    BirthDate     datetime
	)
GO
CREATE TABLE tblFlightAtt(
    ID_FlightAtt          char(8) PRIMARY KEY CLUSTERED,
    LastName     varchar(40) NOT NULL,
    FirstName  varchar(40) NOT NULL,
    Sex             char(1) CHECK (Sex IN ('M','F')) DEFAULT('M'),
    BirthDate     datetime
)
GO
CREATE TABLE tblAeroplane(
    ID_Aeroplane          char(8) PRIMARY KEY CLUSTERED,
    Type             char(10) CHECK (Type IN ('Private','Commercial')) DEFAULT('Commercial')
)
GO
CREATE TABLE tblFlight(
    ID_Flight        char(8) PRIMARY KEY CLUSTERED,
    ID_Aeroplane char(8) NOT NULL REFERENCES tblAeroplane(ID_Aeroplane)
		ON DELETE CASCADE ON UPDATE CASCADE,
    Date            date,
    Hour            time,
    Duration        varchar(5),
    Departure       varchar(40),
    Destination     varchar(40)
)
GO

CREATE TABLE tblServes(

	ID_FlightAtt char(8) NOT NULL REFERENCES tblFlightAtt(ID_FlightAtt)
		ON DELETE CASCADE ON UPDATE CASCADE,
	ID_Passenger char(8) NOT NULL REFERENCES tblPassenger(SSN_Passenger)
		ON DELETE CASCADE ON UPDATE CASCADE,
    Food varchar (30),
    Drink varchar (30),
    PRIMARY KEY (ID_FlightAtt, ID_Passenger)
	)

GO
CREATE TABLE tblWorksOn(

	ID_FlightAtt char(8) NOT NULL REFERENCES tblFlightAtt(ID_FlightAtt)
		ON DELETE CASCADE ON UPDATE CASCADE,
	ID_Flight char(8) NOT NULL REFERENCES tblFlight(ID_Flight)
		ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (ID_FlightAtt, ID_Flight)
	)

GO
CREATE TABLE tblFlies(
	ID_Pilot char(8) NOT NULL REFERENCES tblPilot(ID_Pilot)
		ON DELETE CASCADE ON UPDATE CASCADE,
	ID_Aeroplane char(8) NOT NULL REFERENCES tblAeroplane(ID_Aeroplane)
		ON DELETE CASCADE ON UPDATE CASCADE,
    LicenseType varchar (1) NOT NULL,
    PRIMARY KEY (ID_Pilot, ID_Aeroplane)
	)

GO
CREATE TABLE tblIsOn(
	ID_Passenger char(8) NOT NULL REFERENCES tblPassenger(SSN_Passenger)
		ON DELETE CASCADE ON UPDATE CASCADE,
	ID_Flight char(8) NOT NULL REFERENCES tblFlight(ID_Flight)
		ON DELETE CASCADE ON UPDATE CASCADE,
    Ticket varchar (10) NOT NULL,
    Seat_No  char(3),
    PRIMARY KEY (ID_Passenger, ID_Flight)
	)

GO
------
INSERT INTO tblPilot (ID_Pilot, LastName, FirstName, Sex, BirthDate) VALUES
('P00001','Popescu','Ion','M','1980-03-12'),
('P00002','Ionescu','Ana','F','1985-07-24'),
('P00003','Dumitrescu','Vlad','M','1978-11-02'),
('P00004','Marinescu','Elena','F','1982-05-18'),
('P00005','Georgescu','Mihai','M','1987-09-30');
GO


INSERT INTO tblPassenger (SSN_Passenger, LastName, FirstName, Sex, BirthDate) VALUES
('PA00001','Popa','Dan','M','1995-04-10'),
('PA00002','Ionescu','Elena','F','1996-08-22'),
('PA00003','Dumitrescu','Ioana','F','1994-02-14'),
('PA00004','Marinescu','Vlad','M','1993-09-30'),
('PA00005','Georgescu','Ana','F','1992-12-11'),
('PA00006','Stan','Mihai','M','1997-05-05'),
('PA00007','Dobre','Radu','M','1998-01-21'),
('PA00008','Vasilescu','Maria','F','1995-11-17'),
('PA00009','Ionescu','Cristian','M','1996-03-03'),
('PA00010','Popescu','Dana','F','1997-07-07');
GO

INSERT INTO tblFlightAtt (ID_FlightAtt, LastName, FirstName, Sex, BirthDate) VALUES
('FA0001','Dumitrescu','Ioana','F','1993-02-14'),
('FA0002','Vasilescu','Mihai','M','1994-05-20'),
('FA0003','Popa','Elena','F','1992-08-08'),
('FA0004','Ionescu','Andrei','M','1991-12-12');
GO

INSERT INTO tblAeroplane (ID_Aeroplane, Type) VALUES
('A0001','Private'),
('A0002','Commercial'),
('A0003','Commercial');
GO

INSERT INTO tblFlies (ID_Pilot, ID_Aeroplane, LicenseType) VALUES
('P00001','A0001','A'),
('P00002','A0002','B'),
('P00003','A0003','C'),
('P00004','A0002','B'),
('P00005','A0003','C');
GO

INSERT INTO tblServes (ID_FlightAtt, ID_Passenger, Food, Drink) VALUES
('FA0001','PA00001','Sandwich','Water'),
('FA0001','PA00003','Salad','Juice'),
('FA0002','PA00002','Pasta','Water'),
('FA0002','PA00004','Burger','Soda'),
('FA0003','PA00005','Pizza','Juice'),
('FA0003','PA00006','Salad','Water'),
('FA0004','PA00007','Sandwich','Soda'),
('FA0004','PA00008','Pasta','Juice');
GO

INSERT INTO tblFlight 
(ID_Flight, ID_Aeroplane, Date, Hour, Duration, Departure, Destination)
VALUES
('F0001','A0001','2025-01-10','08:30','90','Bucharest','Paris'),
('F0002','A0002','2025-01-11','12:00','120','London','Rome'),
('F0003','A0003','2025-01-12','18:45','150','Berlin','Madrid');
GO

INSERT INTO tblIsOn (ID_Passenger, ID_Flight, Ticket, Seat_No) VALUES
('PA00001','F0002','T001','1A'),
('PA00002','F0001','T002','2B'),
('PA00003','F0003','T003','3C'),
('PA00004','F0002','T004','4A'),
('PA00005','F0001','T005','5B'),
('PA00006','F0003','T006','6C'),
('PA00007','F0002','T007','7A'),
('PA00008','F0001','T008','8B'),
('PA00009','F0003','T009','9C'),
('PA00010','F0002','T010','10A');
GO


INSERT INTO tblWorksOn (ID_FlightAtt, ID_Flight) VALUES
('FA0001','F0002'),
('FA0001','F0003'),
('FA0002','F0001'),
('FA0002','F0002'),
('FA0003','F0003'),
('FA0003','F0001'),
('FA0004','F0002'),
('FA0004','F0003');
GO

---
SELECT * FROM tblPilot;
GO
SELECT * FROM tblPassenger;
GO
SELECT * FROM tblFlightAtt;
GO
SELECT * FROM tblAeroplane;
GO
SELECT * FROM tblFlight;
GO
SELECT * FROM tblFlies;
GO
SELECT * FROM tblServes;
GO
SELECT * FROM tblWorksOn;
GO
SELECT * FROM tblIsOn;
GO
---
--passengers with the food and drink they were served, and by which flight attendant--
SELECT p.SSN_Passenger, p.LastName AS PassengerLast, p.FirstName AS PassengerFirst,
       s.Food, s.Drink, fa.LastName AS FA_LastName, fa.FirstName AS FA_FirstName
FROM tblPassenger p
JOIN tblServes s ON p.SSN_Passenger = s.ID_Passenger
JOIN tblFlightAtt fa ON s.ID_FlightAtt = fa.ID_FlightAtt
ORDER BY fa.LastName, p.LastName;

--flight attendants and the flights they work on--
SELECT fa.ID_FlightAtt,
       fa.LastName,
       fa.FirstName,
       w.ID_Flight
FROM tblFlightAtt fa
JOIN tblWorksOn w 
     ON fa.ID_FlightAtt = w.ID_FlightAtt
ORDER BY fa.LastName, w.ID_Flight;

--commercial aeroplanes with pilots who are licensed to fly them--
SELECT a.ID_Aeroplane, a.Type, pi.ID_Pilot, pi.LastName, f.LicenseType
FROM tblAeroplane a
JOIN tblFlies f ON a.ID_Aeroplane = f.ID_Aeroplane
JOIN tblPilot pi ON f.ID_Pilot = pi.ID_Pilot
WHERE a.Type = 'Commercial'
ORDER BY pi.LastName, f.LicenseType;

--passengers per flight attendant for flights with more than 1 passenger--
SELECT fa.ID_FlightAtt, fa.LastName AS FA_LastName, COUNT(s.ID_Passenger) AS NumPassengers
FROM tblFlightAtt fa
JOIN tblServes s ON fa.ID_FlightAtt = s.ID_FlightAtt
GROUP BY fa.ID_FlightAtt, fa.LastName
HAVING COUNT(s.ID_Passenger) > 1
ORDER BY NumPassengers DESC;

--number of times flight attendants worked togheter--
SELECT w1.ID_FlightAtt AS FA1,
       w2.ID_FlightAtt AS FA2,
       COUNT(*) AS TimesTogether
FROM tblWorksOn w1
JOIN tblWorksOn w2
     ON w1.ID_Flight = w2.ID_Flight
    AND w1.ID_FlightAtt < w2.ID_FlightAtt
GROUP BY w1.ID_FlightAtt, w2.ID_FlightAtt
ORDER BY TimesTogether DESC;


--youngest passenger on each aeroplane--
SELECT f.ID_Aeroplane,
       a.Type,
       MAX(p.BirthDate) AS YoungestBirthDate
FROM tblIsOn i
JOIN tblPassenger p 
     ON i.ID_Passenger = p.SSN_Passenger
JOIN tblFlight f
     ON i.ID_Flight = f.ID_Flight
JOIN tblAeroplane a
     ON f.ID_Aeroplane = a.ID_Aeroplane
GROUP BY f.ID_Aeroplane, a.Type
ORDER BY YoungestBirthDate DESC;


--license types used by only one pilot--
SELECT LicenseType,
       COUNT(DISTINCT ID_Pilot) AS NumPilots
FROM tblFlies
GROUP BY LicenseType
HAVING COUNT(DISTINCT ID_Pilot) = 1;


--passengers served by each flight attendant per aeroplane--
SELECT fa.ID_FlightAtt,
       fa.LastName AS FA_LastName,
       f.ID_Aeroplane,
       COUNT(DISTINCT s.ID_Passenger) AS NumPassengers
FROM tblFlightAtt fa
JOIN tblServes s 
     ON fa.ID_FlightAtt = s.ID_FlightAtt
JOIN tblWorksOn w 
     ON fa.ID_FlightAtt = w.ID_FlightAtt
JOIN tblFlight f
     ON w.ID_Flight = f.ID_Flight
GROUP BY fa.ID_FlightAtt, fa.LastName, f.ID_Aeroplane
ORDER BY NumPassengers DESC, fa.LastName;

--aeroplanes with all pilots licensed to fly them--
SELECT a.ID_Aeroplane, a.Type, pi.LastName AS PilotLast, f.LicenseType
FROM tblAeroplane a
JOIN tblFlies f ON a.ID_Aeroplane = f.ID_Aeroplane
JOIN tblPilot pi ON f.ID_Pilot = pi.ID_Pilot
WHERE f.LicenseType IN ('A','B','C')
ORDER BY a.Type, pi.LastName;

--passengers and the total number of different flight attendants they were served by--
SELECT p.SSN_Passenger,
       p.LastName,
       p.FirstName,
       COUNT(DISTINCT s.ID_FlightAtt) AS NumFlightAttendants
FROM tblPassenger p
JOIN tblServes s 
     ON p.SSN_Passenger = s.ID_Passenger
GROUP BY p.SSN_Passenger, p.LastName, p.FirstName
ORDER BY NumFlightAttendants DESC, p.LastName;

