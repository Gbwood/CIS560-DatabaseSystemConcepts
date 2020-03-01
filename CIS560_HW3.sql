--HW3
--Graham Wood

--Q1

	Select (C.CustomerID), (C.CustomerName),
	SUM(IIF(DATEPART(yyyy, O.OrderDate) = 2014, (OL.Quantity*OL.UnitPrice), 0)) as [2014Sales],
	SUM(IIF(DATEPART(yyyy, O.OrderDate) = 2015, (OL.Quantity*OL.UnitPrice), 0)) as [2015Sales],
	Sum(OL.Quantity*OL.UnitPrice) as 'TotalSales'
	From Sales.Customers as C
	FULL join Sales.Orders as O on O.CustomerID = C.CustomerID
	FULL join Sales.OrderLines as OL on OL.OrderLineID = O.OrderID
	Where DATEPART(yyyy, O.OrderDate) = 2014 or DATEPART(yyyy, O.OrderDate) = 2015
	Group by C.CustomerID, C.CustomerName
	Order by (TotalSales) DESC, C.CustomerID;

--Q2
Select SI.SupplierID, S.SupplierName, 
Count(Distinct O.OrderID) as OrderCount,
SUM(IIF(O.OrderID IS NOT NULL, (OL.Quantity*OL.UnitPrice), 0)) as [Sales]
FROM Purchasing.Suppliers as S
LEFT JOIN Warehouse.StockItems as SI on S.SupplierID = SI.SupplierID
LEFT JOIN Sales.OrderLines as OL on OL.StockItemID = SI.StockItemID
LEFT JOIN Sales.Orders as O on O.OrderID = OL.OrderID
AND DATEPART(yyyy, O.OrderDate) = 2015
Group by SI.SupplierID, S.SupplierName
Order by Sales DESC, OrderCount DESC, S.SupplierName ASC;







--Q3
Select O.OrderID,O.OrderDate, O.CustomerID, SUM(OL.Quantity*OL.UnitPrice) as OrderTotal
From Sales.Orders as O
Inner join Sales.OrderLines as OL on OL.OrderID = O.OrderID
WHERE O.OrderDate between '1/1/2016' and '1/31/2016'
and O.CustomerID in
(
Select C.CustomerID
From Sales.CustomerCategories as CC
Inner join Sales.Customers as C on C.CustomerCategoryID = CC.CustomerCategoryID
Where CC.CustomerCategoryName = 'Computer Store'
)
Group by o.OrderID, o.OrderDate, O.CustomerID
Order By OrderTotal DESC, O.OrderID ASC