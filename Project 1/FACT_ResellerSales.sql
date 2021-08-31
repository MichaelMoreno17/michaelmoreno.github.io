/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	   ProductKey AS [Product Key],
       OrderDateKey AS [Order Date Key],
      --   ,[DueDateKey]
      --   ,[ShipDateKey]
      ResellerKey AS [Reseller Key],
      EmployeeKey AS [Employee Key],
      PromotionKey AS [Promotion Key],
      --   ,[CurrencyKey]
      --   ,[SalesTerritoryKey]
      --   ,[SalesOrderNumber]
      --   ,[SalesOrderLineNumber]
      --   ,[RevisionNumber]
      --   ,[OrderQuantity]
	  -- Rounding units to the nearest hundreth decimal place
      ROUND(UnitPrice, 2, 0) AS [Unit Price],
      --   ,[ExtendedAmount]
      --   ,[UnitPriceDiscountPct]
      --   ,[DiscountAmount]
      ROUND(ProductStandardCost, 2, 0) AS [Product Standard Cost],
      ROUND(TotalProductCost, 2, 0) AS [Total Product Cost],
      ROUND(SalesAmount, 2, 0) AS [Sales Amount],
      ROUND(TaxAmt, 2, 0) AS [Tax Amt],
      ROUND(Freight, 2, 0) AS Freight
      --   ,[CarrierTrackingNumber]
      --   ,[CustomerPONumber]
      --   ,[OrderDate]
      --   ,[DueDate]
      --   ,[ShipDate]
  FROM 
	dbo.FactResellerSales