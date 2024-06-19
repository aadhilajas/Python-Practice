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

# Retrive all user
SELECT * FROM Users;

# To see specific column
SELECT UName, Email FROM Users;

# to see users from a specific city
SELECT * FROM Users WHERE Address LIKE '%Kochi%';

# To see rides with specific status
SELECT * FROM Rides WHERE Status = 'Completed';

# To see users orderd by there name
SELECT * FROM Users ORDER BY UName;

# To see rides sorted by fare in descending order
SELECT * FROM Rides ORDER BY Fare DESC;

# to see rides along with user and driver details
SELECT 
    R.RideID, R.PickupLocation, R.DropoffLocation, R.Fare,
    U.UName AS UserName, D.DName AS DriverName
FROM Rides R
JOIN Users U ON R.UserID = U.UserID
JOIN Drivers D ON R.DriverID = D.DriverID;

# To see feedback with user and driver details
SELECT 
    F.Rating, F.Comments,
    U.UName AS UserName, D.DName AS DriverName
FROM Feedback F
JOIN Users U ON F.UserID = U.UserID
JOIN Drivers D ON F.DriverID = D.DriverID;

# To see the number of rides a user has taken
SELECT UserID, COUNT(*) AS RideCount
FROM Rides
GROUP BY UserID;

# To see the total fare collected by each driver
SELECT DriverID, SUM(Fare) AS TotalFare
FROM Rides
GROUP BY DriverID;

# to see the driver who have collected more than 500 as fare
SELECT DriverID, SUM(Fare) AS TotalFare
FROM Rides
GROUP BY DriverID
HAVING SUM(Fare) > 500;

# To see average rating of each driver
SELECT DriverID, AVG(Rating) AS AverageRating
FROM Feedback
GROUP BY DriverID;

# To see details of rides along with paymeent statuss
SELECT 
    R.RideID, R.PickupLocation, R.DropoffLocation, R.Fare,
    P.PaymentMethod, P.PaymentStatus
FROM Rides R
JOIN Payments P ON R.RideID = P.RideID;

# CONCAT
SELECT CONCAT('Hello', ' ', 'World');

# UPPER / LOWER
SELECT UPPER('hello'); 
SELECT LOWER('WORLD'); 

# LENGTH
SELECT LENGTH('apple'); 
SELECT CHAR_LENGTH('banana'); 

# SUBSTRING
SELECT SUBSTRING('abcdef', 2, 3);

# TRIM(STR)
SELECT TRIM('  hello  ');

# ROUND(NUM,DECIMAL)
SELECT ROUND(3.14159, 2);

# ABS(NUM)
SELECT ABS(-10);

# SQRT(NUM)
SELECT SQRT(25);

# RAND(NUM)
SELECT RAND();

# NOW(), CURRENT_DATESTAMP()
SELECT NOW();

# DATE_FORMAT (DATE< FORMAT)
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d');

# DATEDIFF(DATE1, DATE2)
SELECT DATEDIFF('2023-01-01', '2022-01-01');

# COUNT()
SELECT COUNT(*) FROM Users;

# SUM()
SELECT SUM(Fare) FROM Rides;

# MIN()
SELECT MIN(YearOfManufacture) FROM Vehicles;

# CASE
SELECT
    UName,
    CASE 
        WHEN UserID = 1 THEN 'Admin'
        ELSE 'User'
    END AS UserType
FROM Users;

# COAESCE(VAL1, VAL2)
SELECT COALESCE(NULL, 'fallback', 'value');
