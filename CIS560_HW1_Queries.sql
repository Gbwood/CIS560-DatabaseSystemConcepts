/*Q2.*/
Select S.OrderID, S.CustomerID, S.SalespersonPersonID
From Sales.Orders as S
Where S.OrderDate = 'January 15, 2015';

/*Q3*/
Select S.OrderID, S.CustomerID, S.SalespersonPersonID, OrderDate
From Sales.Orders as S
Where S.CustomerID = 50 and S.OrderDate Between 'January 1, 2015' and 'January 31, 2015'; 
