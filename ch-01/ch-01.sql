-- list all tables --
SELECT * FROM sqlite_master where type='table'

-- check customers table --
SELECT * FROM Customers limit 5;

SELECT FirstName, LastName, Email FROM Customers order by LastName;

-- create table to store information --
CREATE table party ("CustomerID" int, "GuestCount", int);

-- print menu--
-- all items sorted by price low to high
SELECT * from Dishes;
SELECT Name, Price FROM Dishes order by Price ASC;

-- appetizers and beverages by type --
SELECT * FROM Dishes where "Type" = "Appetizer" OR "Type"="Beverage" ORDER BY "Type" DESC ;
-- SELECT COUNT(*), AVG(Price) as price , "Type" FROM Dishes GROUP BY "Type" ORDER BY price DESC;-- 

-- all items except beverages by type --
SELECT * FROM Dishes where "Type" != "Beverage" ORDER BY "Type" ;

-- sign a customer up for loyalty --
-- FN, LN, Email, Add, City, St, Phone, BD --
INSERT into Customers 
(FirstName, LastName, Email, Address, City, State, Phone, Birthday)
Values ("E","G", "e@g.com", "487. EG", "Istanbul", "IST","584-875-871", "1982-14-21");
SELECT * FROM Customers order by CustomerID DESC limit 1;

-- update customers personal information --
-- taylor jenkins --
select CustomerID, FirstName, LastName , Address FROM Customers where FirstName ="Taylor" and LastName= "Jenkins";

UPDATE Customers set
Address = "74 Pine St.",
City = "New York",
State = "NY"
WHERE CustomerID = "26";

SELECT * FROM Customers WHERE CustomerID = "26";

-- remove customer record --
SELECT * FROM Customers where FirstName ="Taylor" and LastName= "Jenkins";
DELETE FROM Customers where FirstName ="Taylor" and LastName= "Jenkins" and CustomerID  = "4";

-- log customer responses --
-- use email and address to find customer's id and enter party size into party table --
insert into party (customerID, GuestCount)
values
((select CustomerID from Customers where Email = "tjenkins@redt30design.com"), 5);

SELECT * FROM party;

-- look up reservations --
SELECT Customers.FirstName, Customers.LastName, Reservations.Date, Reservations.PartySize from Reservations 
join Customers on Customers.CustomerID=Reservations.CustomerID 
where Customers.LastName LIKE "Ste%";

-- take a reservation --
SELECT * FROM Customers WHERE Email = "smac@kinetecoinc.com";
INSERT into Customers 
(FirstName, LastName, Email, Phone)
values
("Sam", "McAdams", "smac@kinetecoinc.com", "555-5875-88-55");

SELECT * FROM Customers WHERE Email = "smac@kinetecoinc.com";

INSERT into Reservations 
(CustomerID, Date, PartySize)
values
((SELECT CustomerID FROM Customers WHERE Email = "smac@kinetecoinc.com"), (SELECT DATE('now')), 5);
SELECT * FROM Reservations order by Date DESC limit 5

-- take a delivery order --
SELECT * FROM Customers where FirstName="Loretta" AND LastName= "Hundey";

SELECT CustomerID FROM Customers where FirstName="Loretta" AND LastName= "Hundey";

INSERT into Orders (CustomerID, OrderDate) values ((SELECT CustomerID FROM Customers where FirstName="Loretta" AND LastName= "Hundey"), (SELECT DATE("now")));
SELECT * FROM Orders order by OrderDate DESC;
SELECT * FROM  Orders where CustomerID = (SELECT CustomerID FROM Customers where FirstName="Loretta" AND LastName= "Hundey") order by OrderDate DESC;

INSERT into OrdersDishes (OrderID, DishID)
values
("1001", (select DishID FROM Dishes where Name = "House Salad")),
("1001", (select DishID FROM Dishes where Name = "Mini Cheeseburgers")),
("1001", (select DishID FROM Dishes where Name = "Tropical Blue Smoothie"));
SELECT * FROM OrdersDishes order by OrderID DESC;

SELECT * from Dishes join OrdersDishes on Dishes.DishID = OrdersDishes.DishID where OrdersDishes.OrderID  = "1001";

SELECT sum(dishes.Price) FROM  Dishes join OrdersDishes on dishes.DishID=OrdersDishes.DishID where ordersdishes.OrderID = "1001";

-- track customers fav dishes --

SELECT * FROM Customers where FirstName = "Cleo" AND LastName="Goldwater";
SELECT CustomerID FROM Customers where FirstName = "Cleo" AND LastName="Goldwater";

SELECT DishID FROM Dishes where Name = "Quinoa Salmon Salad";

UPDATE Customers 
set FavoriteDish = (SELECT DishID FROM Dishes where Name = "Quinoa Salmon Salad") 
where CustomerID = (SELECT CustomerID FROM Customers where FirstName = "Cleo" AND LastName="Goldwater");

SELECT * FROM Customers where FirstName = "Cleo";

SELECT Customers.FirstName, Customers.LastName, Customers.FavoriteDish, Dishes.Name from Customers join Dishes on Customers.FavoriteDish = Dishes.DishID;
SELECT Customers.FirstName, Customers.LastName, Customers.FavoriteDish, Dishes.Name from Customers join Dishes on Customers.FavoriteDish = Dishes.DishID where FirstName = "Cleo";

-- prepare report for top 5 customers--
-- no orders, fn, ln, email, sorted by no orders --

SELECT COUNT(Orders.OrderID) as OrderCount, Customers.FirstName , Customers.LastName , customers.Email from Orders 
join Customers 
on orders.CustomerID  = Customers.CustomerID
GROUP BY orders.CustomerID 
ORDER BY OrderCount DESC 
limit 5;








