-- Створення бази даних та вибір її для використання

CREATE DATABASE BarberShop
go
USE BarberShop
go

-- Table Barbers

CREATE TABLE Barbers (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [FirstName] [nvarchar](15) NOT NULL,
	[LastName] [nvarchar](25) NOT NULL,
    [gender] [varchar](10) NOT NULL,
    [phone_number] [varchar](20) NOT NULL,
    [email] [varchar](255) NOT NULL,
    [birth_date] DATE NOT NULL,
    [hire_date] DATE NOT NULL,
    [position] VARCHAR(50) NOT NULL
);

-- Table Services

CREATE TABLE Services (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [service_name] [nvarchar](255) NOT NULL,
    [price] DECIMAL(10, 2) NOT NULL,
    [duration_minutes] INT NOT NULL
);

-- Table Clients

CREATE TABLE Clients (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [FirstName] [nvarchar](15) NOT NULL,
	[LastName] [nvarchar](25) NOT NULL,
    [phone_number] [varchar](20) NOT NULL,
    [email] [varchar](255)
);

-- Table BarberSchedule

CREATE TABLE BarberSchedule (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Id_Barber] INT,
    [available_date] DATE NOT NULL,
    [available_from] TIME NOT NULL,
    [available_to] TIME NOT NULL,
);

-- Table Feedback

CREATE TABLE Feedback (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Id_Client] INT,
    [Id_Barber] INT,
    rating CHAR(1) NOT NULL CHECK (rating IN ('A', 'B', 'C', 'D', 'E')),
    [feedback_text] TEXT,
    [feedback_date] DATETIME,
);

-- Table Appointments

CREATE TABLE Appointments (
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [Id_Client] INT,
    [Id_Barber] INT,
    [Id_Service] INT,
    [appointment_date] DATETIME NOT NULL,
    [total_price] DECIMAL(10, 2),
    [Id_Feedback] INT,
);

-- Inserting data into the Barbers table

INSERT INTO Barbers (FirstName, LastName, gender, phone_number, email, birth_date, hire_date, position)
VALUES 
('John', 'Smith', 'Male', '123-456-7890', 'john.smith@example.com', '1980-01-15', '2020-06-01', 'chief-barber'),
('Jane', 'Doe', 'Female', '123-555-7890', 'jane.doe@example.com', '1985-05-23', '2021-03-15', 'senior-barber'),
('Mike', 'Johnson', 'Male', '123-777-7890', 'mike.johnson@example.com', '1990-11-10', '2021-09-01', 'junior-barber');

-- Inserting data into the Services table

INSERT INTO Services (service_name, price, duration_minutes)
VALUES 
('Haircut', 25.00, 30),
('Shave', 15.00, 20),
('Beard Trim', 10.00, 15),
('Haircut and Shave', 35.00, 50);

-- Inserting data into the Clients table

INSERT INTO Clients (FirstName, LastName, phone_number, email)
VALUES 
('Alice', 'Brown', '123-888-7890', 'alice.brown@example.com'),
('Bob', 'Green', '123-999-7890', 'bob.green@example.com'),
('Charlie', 'Black', '123-111-7890', 'charlie.black@example.com');

-- Inserting data into the BarberSchedule table 

INSERT INTO BarberSchedule (Id_Barber, available_date, available_from, available_to)
VALUES 
(1, '2024-07-23', '09:00:00', '17:00:00'),
(2, '2024-07-23', '10:00:00', '18:00:00'),
(3, '2024-07-23', '11:00:00', '19:00:00');

-- Inserting data into the Feedback table

INSERT INTO Feedback (Id_Client, Id_Barber, rating, feedback_text, feedback_date)
VALUES 
(1, 1, 'A', 'Excellent service!', '2024-07-20 10:00:00'),
(2, 2, 'B', 'Good, but could be better.', '2024-07-21 11:00:00'),
(3, 3, 'C', 'Average experience.', '2024-07-22 12:00:00');

-- Inserting data into the Appointments table 

INSERT INTO Appointments (Id_Client, Id_Barber, Id_Service, appointment_date, total_price, Id_Feedback)
VALUES 
(1, 1, 1, '2024-07-20 09:00:00', 25.00, 1),
(2, 2, 2, '2024-07-21 10:00:00', 15.00, 2),
(3, 3, 3, '2024-07-22 11:00:00', 10.00, 3),
(1, 1, 4, '2024-07-23 09:30:00', 35.00, NULL);

-- Receiving information about all appointments along with client, barber and service data

SELECT
    Appointments.Id AS AppointmentId,
    Clients.FirstName AS ClientFirstName,
    Clients.LastName AS ClientLastName,
    Barbers.FirstName AS BarberFirstName,
    Barbers.LastName AS BarberLastName,
    Services.service_name AS ServiceName,
    Appointments.appointment_date,
    Appointments.total_price
FROM
    Appointments
JOIN
    Clients ON Appointments.Id_Client = Clients.Id
JOIN
    Barbers ON Appointments.Id_Barber = Barbers.Id
JOIN
    Services ON Appointments.Id_Service = Services.Id;

-- Getting customer feedback on barbers

SELECT
    Feedback.Id AS FeedbackId,
    Clients.FirstName AS ClientFirstName,
    Clients.LastName AS ClientLastName,
    Barbers.FirstName AS BarberFirstName,
    Barbers.LastName AS BarberLastName,
    Feedback.rating,
    Feedback.feedback_text,
    Feedback.feedback_date
FROM
    Feedback
JOIN
    Clients ON Feedback.Id_Client = Clients.Id
JOIN
    Barbers ON Feedback.Id_Barber = Barbers.Id;

-- Getting a barber's schedule

SELECT
    BarberSchedule.Id AS ScheduleId,
    Barbers.FirstName AS BarberFirstName,
    Barbers.LastName AS BarberLastName,
    BarberSchedule.available_date,
    BarberSchedule.available_from,
    BarberSchedule.available_to
FROM
    BarberSchedule
JOIN
    Barbers ON BarberSchedule.Id_Barber = Barbers.Id;

-- A non-clustered index on the email column to speed up the search for a barber by email in the Barbers table

CREATE NONCLUSTERED INDEX IDX_Barbers_Email ON Barbers(email);

-- A non-clustered index on the phone_number column to speed up customer search by phone number in the Clients table

CREATE NONCLUSTERED INDEX IDX_Clients_PhoneNumber ON Clients(phone_number);

-- A clustered index on the Id column in the BarberSchedule table

CREATE CLUSTERED INDEX IDX_BarberSchedule_Id ON BarberSchedule(Id);

-- A non-clustered index on the Id_Barber column to speed up queries that include a search by barber in the BarberSchedule table

CREATE NONCLUSTERED INDEX IDX_BarberSchedule_Id_Barber ON BarberSchedule(Id_Barber);

-- A clustered index on the Id column in the Feedback table

CREATE CLUSTERED INDEX IDX_Feedback_Id ON Feedback(Id);

-- A non-clustered index on the Id_Client column to speed up queries that include a customer search in the Feedback table

CREATE NONCLUSTERED INDEX IDX_Feedback_Id_Client ON Feedback(Id_Client);

-- A non-clustered index on the Id_Barber column to speed up queries that include a search by barber in the Feedback table

CREATE NONCLUSTERED INDEX IDX_Feedback_Id_Barber ON Feedback(Id_Barber);

-- A clustered index on the Id column in the Appointments table

CREATE CLUSTERED INDEX IDX_Appointments_Id ON Appointments(Id);

-- A non-clustered index on the Id_Client column to speed up queries that include a search by client in the Appointments table

CREATE NONCLUSTERED INDEX IDX_Appointments_Id_Client ON Appointments(Id_Client);

-- A non-clustered index on the Id_Client column to speed up queries that include a search by barber in the Appointments table

CREATE NONCLUSTERED INDEX IDX_Appointments_Id_Barber ON Appointments(Id_Barber);

-- A non-clustered index on the appointment_date column to speed up queries that include a search by appointment date in the Appointments table
CREATE NONCLUSTERED INDEX IDX_Appointments_Appointment_Date ON Appointments(appointment_date);

-- Table Appointments
CREATE NONCLUSTERED INDEX IDX_Appointments_Id_Client
ON Appointments(Id_Client)
INCLUDE (appointment_date, total_price, Id_Barber, Id_Service);

CREATE NONCLUSTERED INDEX IDX_Appointments_Id_Barber
ON Appointments(Id_Barber)
INCLUDE (appointment_date, total_price, Id_Client, Id_Service);

-- Table Clients
CREATE NONCLUSTERED INDEX IDX_Clients_Id
ON Clients(Id)
INCLUDE (FirstName, LastName);

-- Table Barbers
CREATE NONCLUSTERED INDEX IDX_Barbers_Id
ON Barbers(Id)
INCLUDE (FirstName, LastName);

-- Table Services
CREATE NONCLUSTERED INDEX IDX_Services_Id
ON Services(Id)
INCLUDE (service_name);

-- Index for queries with Id_Service and date range in the Appointments table

CREATE NONCLUSTERED INDEX IDX_Appointments_Id_Service_Date
ON Appointments(Id_Service, appointment_date)
INCLUDE (total_price, Id_Client, Id_Barber);

-- Index for efficient sorting or filtering by appointment_date in the Appointments table

CREATE NONCLUSTERED INDEX IDX_Appointments_Appointment_Date1
ON Appointments(appointment_date)
INCLUDE (Id_Client, Id_Barber, Id_Service, total_price);

-- Index for queries filtered by phone_number in the Clients table

CREATE NONCLUSTERED INDEX IDX_Clients_PhoneNumber1
ON Clients(phone_number)
INCLUDE (FirstName, LastName);

-- Index for effective email search in the Barbers table

CREATE NONCLUSTERED INDEX IDX_Barbers_Email1
ON Barbers(email)
INCLUDE (FirstName, LastName);

-- Index for effective queries by rating and Id_Client in the Feedback table

ALTER TABLE Feedback
ALTER COLUMN feedback_text NVARCHAR(MAX);

CREATE NONCLUSTERED INDEX IDX_Feedback_Rating_Client
ON Feedback(rating, Id_Client)
INCLUDE (feedback_text, feedback_date);

-- Index for efficient queries by service_name in the Services table

CREATE NONCLUSTERED INDEX IDX_Services_Service_Name
ON Services(service_name)
INCLUDE (price, duration_minutes);

-- Checking the use of indexes

SELECT *
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID('BarberShop');

-- Appointments table: The filtered IDX_Appointments_Recent_Date index is intended to optimise queries, 
-- that filter data by the most recent date. It includes records with appointment_date with a constant date of '2024-02-01'
-- and optimises the speed of accessing this data by reducing the index size and improving query performance.

CREATE NONCLUSTERED INDEX IDX_Appointments_Recent_Date
ON Appointments(appointment_date)
INCLUDE (Id_Client, Id_Barber, Id_Service, total_price)
WHERE appointment_date >= '2024-02-01';

-- Feedback table: the filtered index IDX_Feedback_Good_Ratings optimises queries that filter for records with 'good' and 'excellent' ratings.
-- It includes the Id_Client, feedback_text, and feedback_date columns, which improves the performance of queries for positive feedback.
CREATE NONCLUSTERED INDEX IDX_Feedback_Good_Ratings
ON Feedback(rating)
INCLUDE (Id_Client, feedback_text, feedback_date)
WHERE rating IN ('good', 'excellent');

-- The Clients table: the filtered IDX_Clients_With_Email index speeds up queries for customers with non-empty email addresses. 
-- It includes the FirstName and LastName columns, which improves email search performance.

CREATE NONCLUSTERED INDEX IDX_Clients_With_Email
ON Clients(email)
INCLUDE (FirstName, LastName)
WHERE email IS NOT NULL;

-- Running a plan without executing a query

SET SHOWPLAN_XML ON;

-- Query

SELECT * FROM Appointments WHERE appointment_date >= '2024-02-01';

-- Deactivating the plan

SET SHOWPLAN_XML OFF;