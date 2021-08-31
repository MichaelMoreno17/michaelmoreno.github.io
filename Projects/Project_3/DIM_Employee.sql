/*** DIM_Employee Table ***/
SELECT
       EmployeeKey AS [Employee Key],
      --   ,[ParentEmployeeKey]
      --   ,[EmployeeNationalIDAlternateKey]
      --   ,[ParentEmployeeNationalIDAlternateKey]
      --   ,[SalesTerritoryKey]
      FirstName AS [First Name],
      LastName AS [Last Name],
	  -- Concatinate for full name
	  CONCAT(FirstName, ' ', LastName) AS [Full Name],
      --   ,[MiddleName]
      --   ,[NameStyle]
      Title,
	  -- Adding columns for time with company in years
      HireDate AS [Hire Date],
	  DATEDIFF(year ,HireDate, StartDate) AS [Time at Comp],
      --   ,[BirthDate]
      --   ,[LoginID]
      --   ,[EmailAddress]
      --   ,[Phone]
	  -- Adding case statements
      CASE MaritalStatus WHEN 'M' THEN 'Married' WHEN 'S' THEN 'Single' END AS [Marital Status],
      --   ,[EmergencyContactName]
      --   ,[EmergencyContactPhone]
      SalariedFlag AS [Salaried Flag],
      CASE Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender,
      --   ,[PayFrequency]
      ROUND(BaseRate, 2, 0) AS [Base Rate],
      VacationHours AS [Vacation Hours],
      SickLeaveHours AS [Sick Leave Hours],
      --   ,[CurrentFlag]
      --   ,[SalesPersonFlag]
      DepartmentName AS [Departetment Name],
      StartDate AS [Start Date],
      EndDate AS [End Date]
      --   ,[Status]
      --   ,[EmployeePhoto]
	 FROM 
		dbo.DimEmployee 