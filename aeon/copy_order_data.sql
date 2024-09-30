SELECT DISTINCT dbo.Tracking.TransactionNumber
		, dbo.Transactions.Site
		, dbo.Transactions.Username
		, dbo.Transactions.TransactionDate
		, dbo.Transactions.DocumentType
		, dbo.Transactions.ItemTitle
		, dbo.Transactions.ItemSubTitle
		, dbo.Transactions.ItemVolume
		, dbo.Transactions.ItemIssue
		, dbo.Transactions.EADNumber
		, dbo.Transactions.ReferenceNumber
		, dbo.Transactions.CallNumber
		, dbo.Transactions.Location
		, dbo.Transactions.SubLocation
FROM dbo.Tracking
LEFT JOIN dbo.Queues on dbo.Tracking.ChangedTo = Queues.ID
JOIN dbo.Transactions on dbo.Tracking.TransactionNumber = dbo.Transactions.TransactionNumber
WHERE Queues.QueueName LIKE '%Copy%'
AND dbo.Transactions.Site = 'MSS'
AND dbo.Transactions.TransactionDate > '2014-07-01'
ORDER by dbo.Transactions.TransactionDate