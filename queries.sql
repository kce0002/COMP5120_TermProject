-- #1 -> Show the subject names of books supplied by 'supplier2'
SELECT CategoryName 
FROM Subject 
WHERE Subject.SubjectID IN 
    (SELECT SubjectID 
    FROM Book 
    WHERE Book.SupplierID IN 
        (SELECT SupplierID 
        FROM Supplier 
        WHERE Supplier.CompanyName = 'supplier2'));

-- #2 -> Show the name and price of the most expensive book supplied by 'supplier3'
SELECT Title, UnitPrice
FROM Book, Supplier
WHERE Book.SupplierID = Supplier.SupplierID AND Supplier.CompanyName = 'supplier3' AND UnitPrice = 
    (SELECT MAX(UnitPrice) 
    FROM Book, Supplier 
    WHERE Book.SupplierID = Supplier.SupplierID AND Supplier.CompanyName = 'supplier3');

-- #3 -> Show the unique names of all books ordered by 'lastname1' 'firstname1'
SELECT DISTINCT(Title) 
FROM Book
WHERE Book.BookID IN 
    (SELECT BookID 
    FROM OrderDetail
    WHERE OrderDetail.OrderID IN
        (SELECT OrderID 
        FROM Orders 
        WHERE Orders.CustomerID IN
            (SELECT CustomerID 
            FROM Customer
            WHERE Customer.LastName = 'lastname1' AND Customer.FirstName = 'firstname1')));

-- #4 -> Show the title of books which have more than 10 units in stock
SELECT Title
FROM Book 
WHERE Book.Quantity > 10;

-- #5 -> Show the total price 'lastname1' 'firstname1' has paid for the books
SELECT SUM(OrderDetail.Quantity * Book.UnitPrice) TotalPrice
FROM Book, OrderDetail, Orders, Customer
WHERE OrderDetail.BookID = Book.BookID 
    AND Orders.OrderID = OrderDetail.OrderID 
    AND Customer.CustomerID = Orders.CustomerID 
    AND Customer.FirstName = "firstname1" 
    AND Customer.LastName="lastname1";

-- #6 -> Show the names of the customers who have paid less than $80 in totals.
SELECT firstname, lastname 
from (SELECT Customer.FirstName AS firstname, Customer.LastName AS lastname, SUM(OrderDetail.Quantity * Book.UnitPrice) AS Total 
    FROM Book, OrderDetail, Orders, Customer
    WHERE OrderDetail.BookID = Book.BookID AND Orders.OrderID = OrderDetail.OrderID AND Customer.CustomerID = Orders.CustomerID 
    GROUP BY Customer.CustomerID HAVING Total < 80) AS tempTable;

-- #7 -> Show the names of books supplied by 'supplier2'
SELECT Title 
FROM Book 
WHERE Book.SupplierID IN 
    (SELECT SupplierID 
    FROM Supplier 
    WHERE Supplier.CompanyName = 'supplier2');

-- #8 -> Show the total price each customer paid and their names. List result in descending price.
SELECT firstname, lastname, Total 
from (SELECT Customer.FirstName AS firstname, Customer.LastName AS lastname, SUM(OrderDetail.Quantity * Book.UnitPrice) AS Total 
    FROM Book, OrderDetail, Orders, Customer
    WHERE OrderDetail.BookID = Book.BookID AND Orders.OrderID = OrderDetail.OrderID AND Customer.CustomerID = Orders.CustomerID 
    GROUP BY Customer.CustomerID) AS tempTable
    ORDER BY Total DESC;

-- #9 -> Show the names of all the books shipped on 08/04/2014 and their shippers' names.
SELECT Book.Title, Shipper.ShipperName 
FROM Book, Shipper, Orders, OrderDetail 
WHERE Book.BookID = OrderDetail.BookID 
    AND OrderDetail.OrderID = Orders.OrderID 
    AND Orders.ShipperID = Shipper.ShipperID 
    AND Orders.ShippedDate = "2014-08-04";

-- #10 -> Show the unique names of all the books 'lastname1','firstname1' and 'lastname4','firstname4' both ordered
SELECT DISTINCT (B1.Title)
FROM Book B1, Orders O1, OrderDetail D1, Customer C1
WHERE B1.BookID = D1.BookID 
    AND D1.OrderID = O1.OrderID 
    AND O1.CustomerID = C1.CustomerID 
    AND C1.FirstName='firstname1' 
    AND C1.LastName='lastname1' 
    AND B1.BookID in 
        (SELECT B2.bookID 
        FROM Book B2, Orders O2, OrderDetail D2, Customer C2
        WHERE B2.BookID = D2.BookID 
            AND D2.OrderID = O2.OrderID 
            AND O2.CustomerID = C2.CustomerID 
            AND C2.FirstName='firstname4' 
            AND C2.LastName='lastname4'); 

-- #11 -> Show the names of all the books 'lastname6', 'firstname6' was responsible for.
SELECT Book.Title 
FROM Book 
WHERE Book.BookID IN
    (SELECT OrderDetail.BookID 
    FROM OrderDetail 
    WHERE OrderDetail.OrderID IN 
        (SELECT Orders.OrderID 
        FROM Orders
        WHERE Orders.EmployeeID IN 
            (SELECT Employee.EmployeeID 
            FROM Employee 
            WHERE Employee.firstname='firstname6' AND Employee.lastname='lastname6')));

-- #12 -> Show the names of all the ordered books and their total quantities. List the result in ascending quantity.
SELECT Title, SUM(OrderDetail.Quantity) as Amount
FROM Book, OrderDetail 
WHERE Book.BookID = OrderDetail.BookID
GROUP BY Book.BookID 
ORDER BY Amount ASC;


-- #13 -> Show the names of the customers who ordered at least 2 books.
SELECT FirstName, LastName 
FROM 
    (SELECT Customer.FirstName, Customer.LastName, SUM(OrderDetail.Quantity) AS Amount
    FROM Orders, OrderDetail, Customer 
    WHERE Orders.OrderID = OrderDetail.OrderID AND Orders.CustomerID = Customer.CustomerID
    GROUP BY Customer.CustomerID) AS Tab 
WHERE Tab.Amount >= 2;


-- #14 -> Show the name of the customers who have ordered at least a book in *category3* or *category4* and the book names.
SELECT B.Title, C.FirstName, C.LastName 
FROM Book B, Customer C, OrderDetail D, Orders O, Subject S
WHERE (S.CategoryName = 'category3' OR S.CategoryName = 'category4')
    AND S.SubjectID = B.SubjectID 
    AND B.BookID = D.BookID 
    AND D.OrderID = O.OrderID 
    AND O.CustomerID = C.CustomerID;


-- #15 -> Show the name of the customer who has ordered at least one book written by *author1*.
SELECT DISTINCT c.FirstName, c.LastName 
FROM Book b, OrderDetail d, Orders o, Customer c 
WHERE b.Author = 'author1'
    AND b.BookID = d.BookID 
    AND d.OrderID = o.OrderID 
    AND o.CustomerID = c.CustomerID;


-- #16 -> Show the name and total sale (price of orders) of each employee.
SELECT e.FirstName, e.LastName, SUM(b.UnitPrice * d.Quantity) AS totalSale
FROM Book b, OrderDetail d, Employee e, Orders o 
WHERE e.EmployeeID = o.EmployeeID
    AND o.OrderID = d.OrderID 
    AND d.BookID = b.BookID 
GROUP BY e.EmployeeID;


-- #17 -> Show the book names and their respective quantities for open orders (the orders which have not been shipped) at midnight 08/04/2016.
SELECT b.Title, d.Quantity
FROM Book b, Orders o, OrderDetail d 
WHERE o.OrderID = d.OrderID 
    AND d.BookID = b.BookID 
    AND STR_TO_DATE(o.ShippedDate, '%Y-%m-%d') > '2016-8-4';


-- #18 -> Show the names of customers who have ordered more than 1 book and the corresponding quantities. List the result in the descending quantity.
SELECT *
FROM (
    SELECT c.FirstName, c.LastName, SUM(d.Quantity) totalBooks
    FROM OrderDetail d, Orders o, Customer c 
    WHERE d.OrderID = o.OrderID 
        AND o.CustomerID = c.CustomerID
    GROUP BY c.CustomerID) AS Tab 
WHERE totalBooks > 1
ORDER BY totalBooks DESC;


-- #19 -> Show the names of customers who have ordered more than 3 books and their respective telephone numbers.
SELECT FirstName, LastName, Phone
FROM (
    SELECT c.FirstName, c.LastName, c.Phone, SUM(d.Quantity) totalBooks 
    FROM OrderDetail d, Orders o, Customer c 
    WHERE d.OrderID = o.OrderID
        AND o.CustomerID = c.CustomerID 
    GROUP BY c.CustomerID) AS Tab 
WHERE totalBooks > 3;