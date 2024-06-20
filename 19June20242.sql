CREATE DATABASE amazon;
USE amazon;

# Table in Unnormalized form
CREATE TABLE Orders_UNF (
    OrderID INT,
    CustomerID INT,
    CustomerName VARCHAR(100),
    CustomerAddress VARCHAR(255),
    ProductID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10, 2),
    OrderDate DATE
);

# 1NF
-- A Table is in 1NF if:
-- > There are only single valued attributes (atomic values)
-- > No repeating groups
CREATE TABLE Orders_1NF (
    OrderID INT,
    CustomerID INT,
    CustomerName VARCHAR(100),
    CustomerAddress VARCHAR(255),
    ProductID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10, 2),
    OrderDate DATE,
    PRIMARY KEY (OrderID, ProductID)
);

# 2NF
# Table must be in 1NF.
-- > All non-key attributes (columns) must depend on the entire primary key.
-- > If a table has a composite primary key, each non-key attribute must depend on the entire composite key, not just on part of it.
-- > If any non-key attribute depends on only a part of a composite key, it violates 2NF and should be moved to a separate table along with the part of the key it depends on.
CREATE TABLE Customers_2NF (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerAddress VARCHAR(255)
);

CREATE TABLE Products_2NF (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers_2NF(CustomerID)
);

CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products_2NF(ProductID)
);

# 3NF
-- Table must be in 2NF.
-- > No transitive dependencies should exist.
-- > Every non-key attribute must depend on the primary key, and only the primary key.
-- > If a non-key attribute depends on another non-key attribute, it should be moved to a separate table along with the attribute it depends on.

# The tables are already in 3NF as all the non-key attributes depend only on the primary key
# and there are no transitive dependencies.

# BCNF
-- Every non-trivial functional dependency X → Y, X must be a superkey.
-- No non-trivial functional dependencies should exist between attributes that are not part of some candidate key.

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerAddress VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
