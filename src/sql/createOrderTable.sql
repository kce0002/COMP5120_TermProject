CREATE TABLE Order (OrderID INT, CustomerID INT, EmployeeID INT, OrderDate DATE, ShippedDate DATE, ShipperID INT);

INSERT INTO Order
VALUES (1, 1, 1, STR_TO_DATE('08/01/2016', '%m/%d/%Y'), STR_TO_DATE('08/03/2016', '%m/%d/%Y'), 1);
INSERT INTO Order
VALUES (2, 1, 2, STR_TO_DATE('08/04/2016', '%m/%d/%Y'), NULL, NULL);
INSERT INTO Order
VALUES (3, 2, 1, STR_TO_DATE('08/01/2016', '%m/%d/%Y'), STR_TO_DATE('08/04/2016', '%m/%d/%Y'), 2);
INSERT INTO Order
VALUES (4, 4, 2, STR_TO_DATE('08/04/2016', '%m/%d/%Y'), STR_TO_DATE('08/04/2016', '%m/%d/%Y'), 1);
INSERT INTO Order
VALUES (5, 1, 1, STR_TO_DATE('08/04/2016', '%m/%d/%Y'), STR_TO_DATE('08/05/2016', '%m/%d/%Y'), 1);
INSERT INTO Order
VALUES (6, 4, 2, STR_TO_DATE('08/04/2016', '%m/%d/%Y'), STR_TO_DATE('08/05/2016', '%m/%d/%Y'), 1);
INSERT INTO Order
VALUES (7, 3, 1, STR_TO_DATE('08/04/2016', '%m/%d/%Y'), STR_TO_DATE('08/04/2016', '%m/%d/%Y'), 1);
