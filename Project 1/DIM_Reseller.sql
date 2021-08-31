/*** DIM_Reseller Table ***/
SELECT 
  ResellerKey AS [Reseller Key], 
  --       ,GeographyKey
  --       ,[ResellerAlternateKey]
  --       ,[Phone]
  BusinessType AS [Business Type], 
  ResellerName AS [Reseller Name], 
  --       ,[NumberEmployees]
  --       ,[OrderFrequency]
  -- Changing Month Number to Month Name
  DATENAME(
    month, 
    DATEADD(month, OrderMonth, -1)
  ) AS [Order Month], 
  --       ,[FirstOrderYear]
  --       ,[LastOrderYear]
  ProductLine AS [Product Line], 
  --       ,[AddressLine1]
  --       ,[AddressLine2]
  AnnualSales AS [Annual Sales], 
  --       ,[BankName]
  --       ,[MinPaymentType]
  MinPaymentAmount AS [Min Payment Amount], 
  AnnualRevenue AS [Annual Revenue], 
  --       ,[YearOpened]
  g.city AS City -- Joined cities from Geography table
FROM 
  dbo.DimReseller AS r 
  LEFT JOIN dbo.DimGeography AS g ON g.GeographyKey = r.GeographyKey 
ORDER BY 
  [Reseller Key]
