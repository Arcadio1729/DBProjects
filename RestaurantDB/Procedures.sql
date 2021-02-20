
CREATE PROCEDURE Add_Product
    @ProductPrice money,
    @ProductName varchar(100),
    @UnitsOnStock int
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO Products
        (ProductPrice, ProductName, UnitsOnStock)
        VALUES (@ProductPrice, @ProductName, @UnitsOnStock)
    END
GO



CREATE PROCEDURE Add_Ingridient
    @ProductName varchar(100),
    @MealName varchar(100)
    AS
    BEGIN
		Declare @ProductID int
		Declare @MealID int
        SET NOCOUNT ON;
        DECLARE @ID_Konf AS int
        SET @ProductID = (
            SELECT ProductID
            FROM Products
            WHERE ProductName = @ProductName
        )
        SET @MealID = (
            SELECT MealID
            FROM Meals
            WHERE MealName = @MealName
        )
        INSERT INTO Ingridients
        (ProductID, MealID)
        VALUES (@ProductID, @MealID)
    END
GO

.

CREATE PROCEDURE Add_Meal
    @MealDate date,
    @MealName varchar(50),
    @MealAvailability varchar(1),
    @MealPrice money,
    @LastOccured date
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO Meals
        (MealDate, MealName, MealAvailability, MealPrice, LastOccured)
        VALUES (@MealDate, @MealName, @MealAvailability, @MealPrice, @LastOccured)
    END
GO


CREATE PROCEDURE Add_Eating_Table
    @TableStatus varchar(10),
    @BookedUntil datetime,
    @TableSize int,
    @TableType varchar(10),
    @COVIDStatus varchar(10)
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO EatingTables
        (TableStatus, BookedUntil, TableSize, TableType, COVIDStatus)
        VALUES (@TableStatus, @BookedUntil, @TableSize, @TableType, @COVIDStatus)
    END
GO



CREATE PROCEDURE Add_Customer
    @CustomerType varchar(10),
    @OrderID int,
    @DiscountID int,
    @CustomerAddress varchar(50)
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO Customers
        (CustomerType, OrderID, DiscountID, CustomerAddress)
        VALUES (@CustomerType, @OrderID, @DiscountID, @CustomerAddress)
    END
GO

Create Procedure GetDiscount
@CustomerID int,
@OrderID int
As
Begin
	--D1
	Update Orders
	Set DiscountID=1
	where
	(Select Count(DiscountID) from CustomerHistory
	where 
	CustomerID=@CustomerID and DiscountID=1)=10
	and
	OrderID=@OrderID

	
--D2
	Update Orders
	Set DiscountID=2
	where
	(Select Count(DiscountID) from CustomerHistory
	where 
	CustomerID=@CustomerID and DiscountID=2)=10
	and
	OrderID=@OrderID

	--D3
	Update Orders
	Set DiscountID=3
	where
	(Select Sum(DiscountID) from CustomerHistory
	where 
	CustomerID=@CustomerID and DiscountID=3)>=1000
	and
	OrderID=@OrderID

	--D4
	Update Orders
	Set DiscountID=4
	where
	(Select Sum(DiscountID) from CustomerHistory
	where 
	CustomerID=@CustomerID and DiscountID=4)>=5000
	and
	OrderID=@OrderID
End



CREATE PROCEDURE Add_Discount_Pattern
    @Amount int,
    @TotalValue money,
    @DiscountValue money,
    @MinimumOrderValue money
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO DiscountPatterns
        (Amount, TotalValue, DiscountValue, MinimumOrderValue)
        VALUES (@Amount, @TotalValue, @DiscountValue, @MinimumOrderValue)
    END
GO


CREATE PROCEDURE Add_Order
    @DeliveryDate date,
    @OrderType varchar(10),
    @TotalValue money,
    @CustomerID int,
    @EatingTableID int
    AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @OrderDate date
        SET @OrderDate = GETDATE()
        INSERT INTO Orders
        (OrderDate, DeliveryDate, OrderType, TotalValue, CustomerID, EatingTableID)
        VALUES (@OrderDate, @DeliveryDate, @OrderType, @TotalValue, @CustomerID, @EatingTableID)
    END
GO


CREATE PROCEDURE Add_Order_Details
    @Meal int,
    @OrderID int,
    @UnitPrice money,
    @Quantity int,
    DiscountID int
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO OrderDetails
        (OrderID, UnitPrice, Quantity, DiscountID)
        VALUES (@MealID, @OrderID, @UnitPrice, @Quantity, @DiscountID)
    END
GO

CREATE PROCEDURE Clean_Menu
	@DeliveryDate date,
	@OrderType varchar(10),
	@TotalValue money,
	@CustomerID int,
	@EatingTableID int
	AS
	BEGIN
    	SET NOCOUNT ON;
    	DELETE FROM Meals
   	 WHERE MealID % 5 = 0
	END
GO
