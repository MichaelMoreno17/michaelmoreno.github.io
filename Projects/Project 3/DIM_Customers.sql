/*** DIM_Customers Table ***/
SELECT 
  c.CustomerKey AS [Customer Key],
  --   ,[GeographyKey]
  --   ,[CustomerAlternateKey]
  --   ,[Title] 
  --Combinding First, Middle, and Last Name
  c.FirstName AS [First Name],
  --   ,[MiddleName]
  c.LastName AS [First Name], 
  CONCAT(
    COALESCE(FirstName + ' ', ''), 
    COALESCE(MiddleName + ' ', ''), 
    COALESCE(LastName, '')
  ) AS [Full Name], 
  --   ,[NameStyle]
  --   ,[BirthDate]
  --   ,[MaritalStatus]
  --   ,[Suffix]
  --Change Gender to be more descriptive 
  CASE Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, 
  c.EmailAddress AS [Email Address],
  --   ,[YearlyIncome]
  --   ,[TotalChildren]
  --   ,[NumberChildrenAtHome]
  --   ,[EnglishEducation]
  --   ,[SpanishEducation]
  --   ,[FrenchEducation]
  --   ,[EnglishOccupation]
  --   ,[SpanishOccupation]
  --   ,[FrenchOccupation]
  --   ,[HouseOwnerFlag]
  --   ,[NumberCarsOwned]
  --   ,[AddressLine1]
  --   ,[AddressLine2]
  --   ,[Phone] 
  c.DateFirstPurchase AS DateFP,
  --   ,[CommuteDistance]
  g.city AS [Customer City] -- Joined in city from dbo.dimgeography
FROM 
  dbo.dimcustomer AS c
  LEFT JOIN dbo.dimgeography AS g ON g.GeographyKey = c.GeographyKey
ORDER BY
  [Customer Key]

