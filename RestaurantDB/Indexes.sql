CREATE INDEX Index_Customers
ON Customers (CustomerID);
GOCREATE INDEX Index_Eating_Tables
ON EatingTables (TableID, TableStatus, COVIDStatus)
GOCREATE INDEX Index_Meals
ON Meals (MealID, MealName, MealAvailability)
GOCREATE INDEX Index_Orders
ON Orders (OrderDate, TotalValue, DeliveryDate)
GO