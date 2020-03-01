--Q1

Select T.PostedDate, T.Description, T.Amount,
@OpeningBalance + SUM(T.Amount) OVER(
	Partition By T.TransactionID
	Order By T.PostedDate ASC
	Rows Between @FirstDate and CURRENT ROW) AS Balance

)
	
	Count(TransactionId) 
	OVER(
	Partition BY T.AccountId
	ROWS BETWEEN @FirstDate AND @LastDate) AS DisplayOrder
From Accounts.Transaction As T
Where T.PostedDate BETWEEN @FirstDate and @LastDate
Group BY T.TransactionID;




--Q2

Create Table Staging.Transaction
	StagedTransactionID Int NOT NULL Identity (1,1) Primary KEY,
	RoutingNumber Numeric(9,0) NOT NULL,
	AccountNumber NUMERIC(12,0) NOT NULL,
	PostedDate DATETIME2 NOT NULL,
	Amount NUMERIC(17,2) NON NULL AND Amount > 0,
	[Description] NVARCHAR(128);






--Q3

INSERT Accounts.Transaction(AccountId, PostedDate, Amount, [Description])

Select T.AccountNumber, T.PostedDate,T.Amount,T.[Description]
FROM Staging.Transaction as T
Where T.AccountNumber = Accounts.Account.AccountNumber 
AND T.RoutingNumber = Accounts.Bank.RoutingNumber;