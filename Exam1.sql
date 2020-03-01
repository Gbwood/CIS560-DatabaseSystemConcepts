--EXAM 1 CIS 560
--Q1

Select H.AccountHolderId, H.LastName, H.FirstName, SUM(IFF(A.AccountYpe = 'C', T.Amount, 0)) as CheckingBalance, 
	 SUM(IFF(A.AccountYpe = 'S', T.Amount, 0)) as SavingsBalance,
	 SUM(T.Amount) as TotalBalance
FROM Accounts.AccountHolder as H
Inner join Accounts.Account as A on A.AccountHolderId = H.AccountHolderId
Inner join Accounts.Transaction as T on T.AccountId = A.AccountId
WHERE SUM(T.Amount) >= 1000000
Group by H.AccountHolderId, H.LastName, H.FirstName
Order BY TotalBalance, H.AccountHolderId;


--Q2
Select A.AccountNumber, A.AccountType, 
	SUM(IFF(T.PostedDate >= '1/1/2019', T.Amount, 0)) as YtdActivity, 
	SUM(T.Amount) as CurrentBalance
From Accounts.Account as A
Inner Join Accounts.Transaction As T on T.AccountId = A.AccountID
Inner join Accounts.AccountHolder as H on H.AccountHolderId = A.AccountHolderId
Where H.Email = 'joh.doe@jmail.com'
group by A.AccountNumber, A.AccountType
Order By A.AccountType ASC, AccountNumber ASC;

--Q3
Declare @Date DATE = '1/1/2019'

Select A.AccountNumber, A.AccountType,
	(
		Select Sum(T.Amount)
		FROM Accounts.Transaction as T
		Where T.AccountID = A.AccountId
		AND T.PostedDate < @Date
	) as OpeningBalance,
	
	(
		Select Sum(T.Amount)
		FROM Accounts.Transaction as T
		Where T.AccountID = A.AccountId
		AND T.PostedDate >= @Date
	) as YtdActivity

From Accounts.Account as A
Left join Accounts.AccountHolder as H on H.AccountHolderId = A.AccountHolderId
Where H.Email = 'john.doe@jmail.com'
Group by A.AccountNumber, A.AccountType
Order By A.AccountType ASC, A.AccountNumber ASC;

--Q4
Select H.LastName, H.FirstName, H.Email
From Accounts.AccountHolder as H
Inner join Accounts.Bank As B on B.BankId = H.BankId
Where B.RoutingNumber = 123456789 AND
	 H.AccountHolderID IN 
	 (
		 Select A.AccountHolderID
		 from Accounts.Account As A
		 Where A.OpenedDate < '1/1/2015'
	 )
Group by H.LastName, H.FirstName, H.Email
Order by H.LastName ASC, H.FirstName ASC;






