--Q1.

Select C.CustomerID, Count(o.CustomerID) as OrderCount, min(O.OrderDate) as FirstOrderDate, max(O.OrderDate) as LastOrderDate,
IIF(O.OrderDate >= '1/1/2016', N'New Customer', 
IIF(Sum(O.OrderID) < 25, N'Few Orders', 
IIF(Sum(O.OrderID) between 25 and 100, N'Growing Customer', N'Large Customer' ))) AS CustomerStatus
From Sales.Customers as c 
	inner join Sales.Orders as O on O.CustomerID = C.CustomerID 
group by C.CustomerID, O.OrderDate;


--Q2
Declare @FirstOrderDate as Date = '2013-01-01';
Declare @LastOrderDate as Date = '2016-01-01';
Declare @PageSize as Int = 100;
Declare @Page as Int = 1;

Select O.OrderDate, Count(O.OrderID) As OrderCount, Count(C.CustomerID) as CustomerCount
From Sales.Customers as c 
	inner join Sales.Orders as O on O.CustomerID = C.CustomerID 
Where O.OrderDate Between @FirstOrderDate and @LastOrderDate 
Group by O.OrderDate
Order By O.OrderDate
OFFSET ((@Page-1) * @PageSize) ROWS
FETCH NEXT (@PageSize) ROWS ONLY;

--Q3
Select (YEAR(O.OrderDate)) as OrderYear, t.CustomerCategoryName, Count(c.CustomerID) as CustomerCount, Count(O.OrderID) as OrderCount, Sum(L.Quantity * L.UnitPrice) as Sales, AVG((L.Quantity * L.UnitPrice))/Count(c.CustomerID) as AverageSalesPerCustomer
From Sales.Customers as c 
	left join Sales.Orders as O on O.CustomerID = C.CustomerID 
	right join Sales.CustomerCategories as t on t.CustomerCategoryID = C.CustomerID
	left join Sales.OrderLines as L on L.OrderID = O.OrderID
Group by DATEPART(yyyy, O.OrderDate), CustomerCategoryName
Order By OrderYear, CustomerCategoryName




