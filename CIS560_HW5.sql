--1.
WITH SalesCTE (SalespersonPersonID, OrderYear, OrderMonth, Sales, PriorMonthSales) as  
	(
		Select O.SalespersonPersonID, DATEPART(yyyy, O.OrderDate) as [Year], DATEPART(MM, O.OrderDate) as [Month], SUM (OL.Quantity * OL.UnitPrice) as Sales,
		
		LAG(SUM(OL.Quantity * OL.UnitPrice),1) OVER (
		Partition By O.SalespersonPersonID
		Order BY  DATEPART(yyyy, O.OrderDate) ASC, DATEPART(MM, O.OrderDate) ASC)
		From Sales.Orders as O
			Inner join Sales.OrderLines as OL on OL.OrderID = O.OrderID
		Group by O.SalespersonPersonID, DATEPART(yyyy, O.OrderDate), DATEPART(MM, O.OrderDate)
	)
Select S.SalespersonPersonID, P.FullName, S.OrderYear as [Year], S.OrderMonth as [Month], S.Sales, S.PriorMonthSales,
	FORMAT((S.Sales-S.PriorMonthSales)/S.PriorMonthSales, N'P') As PercentGrowth,
	SUM(S.Sales) Over (
		Partition BY S.SalespersonPersonID , S.OrderYear
		ORDER BY S.OrderMonth ASC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS YtdTotal,



	Rank() OVER (
		Partition BY S.OrderYear, S.OrderMonth
		Order BY S.Sales DESC
	) as SalesPersonRankForMonth

From SalesCTE as S
Inner join Application.People as P on P.PersonID = S.SalespersonPersonID
Order By S.SalespersonPersonID, S.OrderYear, S.OrderMonth



--2.

Select CT.CityName, P.StateProvinceName, 'Customer' as RecordType
From Sales.Customers as C
	Inner Join [Application].Cities as CT on CT.CityID = C.PostalCityID 
	Inner JOIN Application.StateProvinces as P on P.StateProvinceID = CT.StateProvinceID

UNION

	Select CT.CityName, P.StateProvinceName, 'Supplier' as RecordType
From Purchasing.Suppliers as S
	Inner Join [Application].Cities as CT on CT.CityID = S.PostalCityID 
	Inner JOIN Application.StateProvinces as P on P.StateProvinceID = CT.StateProvinceID


