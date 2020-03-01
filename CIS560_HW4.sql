--Q1
Select P.SupplierID, P.SupplierName, P.PostalPostalCode
from Purchasing.Suppliers as P 
Inner join Purchasing.SupplierCategories as S on S.SupplierCategoryID = P.SupplierCategoryID
Where S.SupplierCategoryName = 'Novelty Goods Supplier' AND
P.SupplierID not in 
			(Select SI.SupplierID
			from Warehouse.StockItems as SI
		)
Order by P.SupplierName ASC;

--Q2
Select O.OrderID, O.OrderDate, SUM(OL.Quantity * OL.UnitPrice) as OrderTotal, --DateDiff(DAY,
(
	Select DateDiff(DAY,
		(
			Select TOP(1) O2.OrderDate
			FROM Sales.Orders as O2
			Where O2.CustomerID = O.CustomerID and O2.OrderID < O.OrderID
			Order BY O2.OrderID DESC
		), O.OrderDate) AS DaysSincePreviousOrder
)
from Sales.Orders as O
inner join Sales.OrderLines as OL on OL.OrderID = O.OrderID
Where O.CustomerID = 90
Group by O.OrderID, O.OrderDate, O.CustomerID
Order By O.OrderID ASC;



--Q3
Select Customers.CustomerID, Customers.CustomerName, Orders.OrderCount, Orders.Sales
From (	
		Select C.CustomerID, C.CustomerName
		FROM Sales.Customers as C
		Group by C.CustomerID, C.CustomerName
	) as Customers
	Inner Join
	(
		Select O.customerID, COUNT(Distinct O.OrderID) as OrderCount, SUM(OL.Quantity * OL.UnitPrice) as Sales
		From Sales.Orders as O
		Inner join Sales.OrderLines as OL on OL.OrderID = O.OrderID
		Where DATEPART(yyyy, O.OrderDate) = 2015
		Group by O.CustomerID
	) Orders on Orders.CustomerID = Customers.CustomerID
Group by Customers.CustomerID, Customers.CustomerName, OrderCount, Sales
Order by Sales DESC, Customers.CustomerID;


 --Q4
With Customers AS (
		Select C.CustomerID, C.CustomerName, COUNT(Distinct O.OrderID) as OrderCount, SUM(OL.Quantity * OL.UnitPrice) as Sales
		From Sales.Customers as C
		Inner join Sales.Orders as O on O.CustomerID = C.CustomerID
		Inner join Sales.OrderLines as OL on OL.OrderID = O.OrderID
		Where DATEPART(yyyy, O.OrderDate) = 2015
		Group by C.CustomerID, C.CustomerName
		
)
Select C.CustomerID, C.CustomerName, C.OrderCount as OrderCount, C.Sales
From Customers C
Order by Sales DESC, C.CustomerID;
