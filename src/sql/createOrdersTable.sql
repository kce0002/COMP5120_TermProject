CREATE TABLE Orders (OrderID INT, CustomerID INT, EmployeeID INT, OrderDate DATE, ShippedDate DATE, ShipperID INT);

INSERT INTO Orders
VALUES (1, 1, 1, '2016-08-01', '2016-08-03', 1);
INSERT INTO Orders
VALUES (2, 1, 2, '2016-08-04', NULL, NULL);
INSERT INTO Orders
VALUES (3, 2, 1, '2016-08-01', '2016-08-04', 2);
INSERT INTO Orders
VALUES (4, 4, 2, '2016-08-04', '2016-08-04', 1);
INSERT INTO Orders
VALUES (5, 1, 1, '2016-08-04', '2016-08-05', 1);
INSERT INTO Orders
VALUES (6, 4, 2, '2016-08-04', '2016-08-05', 1);
INSERT INTO Orders
VALUES (7, 3, 1, '2016-08-04', '2016-08-04', 1);