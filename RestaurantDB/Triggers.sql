CREATE TRIGGER Check_Duplicated_Meal
 ON Meals
 AFTER INSERT, UPDATE
 AS
 BEGIN
 IF EXISTS ( SELECT * FROM Meals m
 INNER JOIN inserted i
 ON i.MealName=m.MealName
 AND i.MealID <> m.MealID
 )
 BEGIN
 ROLLBACK
 RAISERROR ('Meal already exists', 16, 1);
 END
 END
GOCREATE TRIGGER Check_Doubled_Table_Booking
 ON Orders
 AFTER INSERT, UPDATE
 AS
 IF EXISTS ( SELECT * FROM Orders o
 INNER JOIN inserted i
 ON i.EatingTableID=o.EatingTableID
 INNER JOIN EatingTables t
 ON t.TableID=o.EatingTableID
 WHERE convert(date, i.DeliveryDate) >= convert(date,
 o.DeliveryDate)
 AND convert(date, i.DeliveryDate) <= convert(date,
 t.BookedUntil)
 )
 BEGIN
 ROLLBACK
 RAISERROR ('Table already booked', 16, 1);
 END
GO