/*** DIM_Product Table ***/
SELECT 
  p.ProductKey, 
  p.ProductAlternateKey AS ProductItemCode,
  --   ,[ProductSubcategoryKey]
  --   ,[WeightUnitMeasureCode]
  --   ,[SizeUnitMeasureCode]
  p.EnglishProductName AS [English Product Name], 
  ps.EnglishProductSubcategoryName AS [Sub Category], 
  pc.EnglishProductCategoryName AS [Product Category],
  --   ,[SpanishProductName]
  --   ,[FrenchProductName]
  --   ,[StandardCost]
  --   ,[FinishedGoodsFlag]
  p.Color AS [Product Color],
  --   ,[SafetyStockLevel]
  --   ,[ReorderPoint]
  p.ListPrice AS [List Price], 
  p.Size AS [Product Size],
  --   ,[SizeRange]
  --   ,[Weight]
  --   ,[DaysToManufacture]
  --   ,[ProductLine]
  --   ,[DealerPrice]
  --   ,[Class]
  --   ,[Style] 
  p.ModelName AS [Model Name],
  --   ,[LargePhoto] 
  p.EnglishDescription AS [English Derscription],
  --   ,[FrenchDescription]
  --   ,[ChineseDescription]
  --   ,[ArabicDescription]
  --   ,[HebrewDescription]
  --   ,[ThaiDescription]
  --   ,[GermanDescription]
  --   ,[JapaneseDescription]
  --   ,[TurkishDescription]
  --   ,[StartDate]
  --   ,[EndDate]
  ISNULL(p.Status, 'Outdated') AS [Product Status] 
FROM 
  dbo.dimproduct AS p 
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
