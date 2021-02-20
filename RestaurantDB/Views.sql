CREATE VIEW Table_Reservations_Monthly
AS
 SELECT COUNT(*) AS TotalMonthlyTableReservations
 FROM Orders
 WHERE OrderDate >= (GETDATE() - 30)
 AND EatingTableID IS NOT NULL
GOCREATE VIEW Show_Meal_Occurences_Weekly
AS
 SELECT m.MealName, COUNT(*) AS NumOfOccurencesInTheLastWeek
 FROM Meals as m
 JOIN OrderDetails AS od
 ON m.MealID = m.MealID
 JOIN Orders as o
 ON od.OrderID = o.OrderID
 WHERE OrderDate >= (GETDATE() - 7)
 GROUP BY m.MealName

 CREATE VIEW Show_Meal_Occurences_Monthly
AS
 SELECT m.MealName, COUNT(*) AS NumOfOccurencesInTheLastMonth
 FROM Meals as m
 JOIN OrderDetails AS od
 ON m.MealID = m.MealID
 JOIN Orders as o
 ON od.OrderID = o.OrderID
 WHERE OrderDate >= (GETDATE() - 30)
 GROUP BY m.MealName
GOCREATE VIEW Show_Orders_Stats_Weekly
AS
 SELECT SUM(TotalValue) AS LastWeekTotalValue,MAX(TotalValue) as
LastWeekHighestValue, Min(TotalValue) As LastWeekLowestValue
 FROM Orders
 WHERE OrderDate >= (GETDATE() - 7)
GO

CREATE VIEW Show_Orders_Stats_Monthly
AS
 SELECT SUM(TotalValue) AS LastMonthTotalValue,MAX(TotalValue) as 
 LastMonthHighestValue, Min(TotalValue) As LastMonthLowestValue
 FROM Orders
 WHERE OrderDate >= (GETDATE() - 30)
GO

CREATE VIEW Show_Most_Popular_Day_Weekly
AS
 SELECT DATENAME(WEEKDAY, OrderDate) as OrderDateWeek, COUNT(*) AS
 LastWeekMostPopularWeekday
 FROM Orders
 WHERE OrderDate >= (GETDATE() - 7)
 GROUP BY DATENAME(WEEKDAY, OrderDate)
GO

CREATE VIEW Show_Most_Popular_Day_Monthly
AS
 SELECT DATENAME(WEEKDAY, OrderDate) OrderDateMonth, COUNT(*) AS
 LastMonthMostPopularWeekday
 FROM Orders
 WHERE OrderDate >= (GETDATE() - 30)
 GROUP BY DATENAME(WEEKDAY, OrderDate)
GO