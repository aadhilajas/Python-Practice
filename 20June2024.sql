CREATE DATABASE OLA;
USE OLA;

CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    UName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL
);

CREATE TABLE Vehicles (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleType VARCHAR(50) NOT NULL,
    RegistrationNumber VARCHAR(50) UNIQUE NOT NULL,
    Model VARCHAR(255) NOT NULL,
    Manufacturer VARCHAR(255) NOT NULL,
    YearOfManufacture INT,
    Capacity INT
);

CREATE TABLE Drivers (
    DriverID INT AUTO_INCREMENT PRIMARY KEY,
    DName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Address VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    LicenseNumber VARCHAR(50) UNIQUE NOT NULL,
    VehicleID INT,
    IsActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

CREATE TABLE Rides (
    RideID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    DriverID INT,
    VehicleID INT,
    PickupLocation VARCHAR(255) NOT NULL,
    DropoffLocation VARCHAR(255) NOT NULL,
    PickupTime TIMESTAMP,
    DropoffTime TIMESTAMP,
    Fare DECIMAL(10, 2),
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    RideID INT,
    UserID INT,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentStatus VARCHAR(50) NOT NULL,
    TransactionID VARCHAR(255) UNIQUE,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    RideID INT,
    UserID INT,
    DriverID INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comments TEXT,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

INSERT INTO Users (UName, Address, Email, PhoneNumber, PasswordHash) VALUES
('John Doe', 'Kochi, Kerala', 'john.doe@example.com', '+91 9876543210', 'hashed_password'),
('Jane Smith', 'Trivandrum, Kerala', 'jane.smith@example.com', '+91 8765432109', 'hashed_password'),
('David Thomas', 'Kozhikode, Kerala', 'david.thomas@example.com', '+91 7654321098', 'hashed_password'),
('Anna Jacob', 'Alappuzha, Kerala', 'anna.jacob@example.com', '+91 6543210987', 'hashed_password'),
('Michael George', 'Thrissur, Kerala', 'michael.george@example.com', '+91 5432109876', 'hashed_password');

INSERT INTO Vehicles (VehicleType, RegistrationNumber, Model, Manufacturer, YearOfManufacture, Capacity) VALUES
('Sedan', 'KL-01 AB 1234', 'Honda City', 'Honda', 2020, 5),
('SUV', 'KL-02 CD 5678', 'Toyota Fortuner', 'Toyota', 2019, 7),
('Hatchback', 'KL-03 EF 9012', 'Hyundai i20', 'Hyundai', 2021, 5),
('Scooter', 'KL-04 GH 3456', 'Honda Activa', 'Honda', 2020, 2),
('Luxury Sedan', 'KL-05 IJ 7890', 'Mercedes-Benz E-Class', 'Mercedes-Benz', 2022, 5);

INSERT INTO Drivers (DName, Email, Address, PhoneNumber, LicenseNumber, VehicleID) VALUES
('Thomas Mathew', 'thomas.mathew@example.com', 'Kochi, Kerala', '+91 9876543211', 'DL-202345', 1),
('Sara Joseph', 'sara.joseph@example.com', 'Trivandrum, Kerala', '+91 8765432108', 'DL-202346', 2),
('Rajesh Kumar', 'rajesh.kumar@example.com', 'Kozhikode, Kerala', '+91 7654321097', 'DL-202347', 3),
('Priya Nair', 'priya.nair@example.com', 'Alappuzha, Kerala', '+91 6543210986', 'DL-202348', 4),
('Arun Singh', 'arun.singh@example.com', 'Thrissur, Kerala', '+91 5432109875', 'DL-202349', 5);

INSERT INTO Rides (UserID, DriverID, VehicleID, PickupLocation, DropoffLocation, PickupTime, DropoffTime, Fare, Status) VALUES
(1, 1, 1, 'Ernakulam Junction', 'Fort Kochi', '2024-06-15 10:00:00', '2024-06-15 10:30:00', 250.00, 'Completed'),
(2, 2, 2, 'Trivandrum Central', 'Kovalam Beach', '2024-06-15 11:00:00', '2024-06-15 11:30:00', 500.00, 'Completed'),
(3, 3, 3, 'Kozhikode Railway Station', 'Beypore Beach', '2024-06-15 12:00:00', '2024-06-15 12:45:00', 300.00, 'Completed'),
(4, 4, 4, 'Alappuzha Boat Jetty', 'Marari Beach', '2024-06-15 13:00:00', '2024-06-15 13:30:00', 150.00, 'Completed'),
(5, 5, 5, 'Thrissur Railway Station', 'Guruvayoor Temple', '2024-06-15 14:00:00', '2024-06-15 14:45:00', 200.00, 'Completed');

INSERT INTO Payments (RideID, UserID, Amount, PaymentMethod, PaymentStatus, TransactionID) VALUES
(1, 1, 250.00, 'Credit Card', 'Paid', 'TXN123456789'),
(2, 2, 500.00, 'PayPal', 'Paid', 'TXN987654321'),
(3, 3, 300.00, 'Cash', 'Paid', 'TXN567890123'),
(4, 4, 150.00, 'Debit Card', 'Paid', 'TXN345678901'),
(5, 5, 200.00, 'UPI', 'Paid', 'TXN789012345');

INSERT INTO Feedback (RideID, UserID, DriverID, Rating, Comments) VALUES
(1, 1, 1, 4, 'Smooth ride, polite driver.'),
(2, 2, 2, 5, 'Excellent service, comfortable vehicle.'),
(3, 3, 3, 3, 'Driver arrived late, but ride was fine.'),
(4, 4, 4, 4, 'Good experience overall.'),
(5, 5, 5, 5, 'Highly recommended! Great service.');

-- Single Row Subquery 
-- Find the user who has taken the most expensive ride
SELECT UName 
FROM Users 
WHERE UserID = (SELECT UserID 
                FROM Rides 
                ORDER BY Fare DESC 
                LIMIT 1);

-- Find the driver with the earliest pickup time for any ride
SELECT DName 
FROM Drivers 
WHERE DriverID = (SELECT DriverID 
                  FROM Rides 
                  ORDER BY PickupTime ASC 
                  LIMIT 1);

-- Multi-Row Subquery 
-- Find users who have given a rating of 5
SELECT UName 
FROM Users 
WHERE UserID IN (SELECT UserID 
                 FROM Feedback 
                 WHERE Rating = 5);

-- Find drivers who have an active status
SELECT DName 
FROM Drivers 
WHERE DriverID IN (SELECT DriverID 
                   FROM Drivers 
                   WHERE IsActive = TRUE);

-- Correlated Subquery 
-- Find drivers who have driven more than 3 rides
SELECT DName 
FROM Drivers D 
WHERE (SELECT COUNT(*) 
       FROM Rides R 
       WHERE R.DriverID = D.DriverID) > 3;

-- Find users who have given at least one feedback with a rating of 5
SELECT UName 
FROM Users U 
WHERE EXISTS (SELECT 1 
              FROM Feedback F 
              WHERE F.UserID = U.UserID 
              AND F.Rating = 5);

-- Join with Subqueries 
-- Get details of all rides along with user and driver names
SELECT R.RideID, U.UName, D.DName, R.PickupLocation, R.DropoffLocation, R.Fare 
FROM Rides R
JOIN (SELECT UserID, UName FROM Users) U ON R.UserID = U.UserID
JOIN (SELECT DriverID, DName FROM Drivers) D ON R.DriverID = D.DriverID;

-- Get details of rides completed by users from 'Kochi, Kerala'
SELECT R.RideID, U.UName, D.DName, R.PickupLocation, R.DropoffLocation, R.Fare 
FROM Rides R
JOIN (SELECT UserID, UName, Address FROM Users WHERE Address LIKE 'Kochi, Kerala') U ON R.UserID = U.UserID
JOIN (SELECT DriverID, DName FROM Drivers) D ON R.DriverID = D.DriverID;

-- Join with Aggregate Functions
-- Find the total fare collected by each driver
SELECT D.DName, SUM(R.Fare) AS TotalFare 
FROM Drivers D
JOIN Rides R ON D.DriverID = R.DriverID
GROUP BY D.DName;

-- Find the average fare for rides completed by each driver
SELECT D.DName, AVG(R.Fare) AS AverageFare 
FROM Drivers D
JOIN Rides R ON D.DriverID = R.DriverID
GROUP BY D.DName;

-- Join with Date and Time Functions
-- Find the number of rides completed by each driver in the current month
SELECT D.DName, COUNT(R.RideID) AS RidesThisMonth
FROM Drivers D
JOIN Rides R ON D.DriverID = R.DriverID
WHERE MONTH(R.PickupTime) = MONTH(CURRENT_DATE) AND YEAR(R.PickupTime) = YEAR(CURRENT_DATE)
GROUP BY D.DName;

-- Find the total fare collected by each driver in the past week
SELECT D.DName, SUM(R.Fare) AS TotalFareLastWeek
FROM Drivers D
JOIN Rides R ON D.DriverID = R.DriverID
WHERE R.PickupTime >= DATE_SUB(CURRENT_DATE, INTERVAL 1 WEEK)
GROUP BY D.DName;


-- RANK()
-- Rank users by their highest payment amount
SELECT U.UName, P.Amount,
       RANK() OVER (ORDER BY P.Amount DESC) AS PaymentRank
FROM Users U
JOIN Payments P ON U.UserID = P.UserID;

-- DENSE_RANK()
-- Dense rank drivers by total fare collected
SELECT D.DName, SUM(R.Fare) AS TotalFare,
       DENSE_RANK() OVER (ORDER BY SUM(R.Fare) DESC) AS DenseRank
FROM Drivers D
JOIN Rides R ON D.DriverID = R.DriverID
GROUP BY D.DName;

-- ROW_NUMBER()
-- Assign a unique row number to each ride based on fare in descending order
SELECT R.RideID, R.UserID, R.DriverID, R.Fare,
       ROW_NUMBER() OVER (ORDER BY R.Fare DESC) AS RowNum
FROM Rides R;

-- CUME_DIST()
-- Calculate the cumulative distribution of fare values
SELECT R.RideID, R.UserID, R.DriverID, R.Fare,
       CUME_DIST() OVER (ORDER BY R.Fare) AS CumulativeDistribution
FROM Rides R;

-- LAG()
-- Calculate the fare difference with the previous ride based on pickup time
SELECT R.RideID, R.UserID, R.DriverID, R.Fare,
       LAG(R.Fare, 1) OVER (ORDER BY R.PickupTime) AS PreviousFare,
       (R.Fare - LAG(R.Fare, 1) OVER (ORDER BY R.PickupTime)) AS FareDifference
FROM Rides R;

-- LEAD()
-- Calculate the fare difference with the next ride based on pickup time
SELECT R.RideID, R.UserID, R.DriverID, R.Fare,
       LEAD(R.Fare, 1) OVER (ORDER BY R.PickupTime) AS NextFare,
       (LEAD(R.Fare, 1) OVER (ORDER BY R.PickupTime) - R.Fare) AS FareDifference
FROM Rides R;
