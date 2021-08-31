/*** FACT_SalesQuota Table***/
SELECT
       [SalesQuotaKey] AS [Sales Quota Key],
      [EmployeeKey] AS [Employee Key],
      [DateKey] AS [Date Key],
     --   ,[CalendarYear]
     --   ,[CalendarQuarter]
      ROUND([SalesAmountQuota], 2, 0) AS [Sales Amount Quota],
      [Date]
  FROM [dbo].[FactSalesQuota]