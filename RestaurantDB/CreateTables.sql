--Products
Create Table Products(
ProductID int not null primary key identity(1,1),
ProductPrice money not null,
ProductName varchar(100) not null,
UnitsOnStock int not null
)

--Ingridients
Create Table Ingridients(
ID int not null primary key identity(1,1),
MealID int not null,
ProductID int not null,
)

--Meals
Create Table Meals(
MealID int not null primary key identity(1,1),
MealDate date not null,
MealName varchar(50),
MealAvailability varchar(1) not null check (MealAvailability='Y' or MealAvailability='N'),
MealPrice money not null,
LastOccured date 
)

--Alter Ingridients Meal
Alter Table dbo.Ingridients
add constraint CK_Meal 
foreign key (MealID) references dbo.Meals(MealID)

--Alter Ingridients Product
Alter Table dbo.Ingridients
add constraint CK_Product 
foreign key (ProductID) references dbo.Products(ProductID)


--Orders
Create Table Orders(
OrderID int not null primary key identity(1,1),
OrderDate date not null,
TotalValue money not null,
OrderType varchar(10),
CustomerID int,
EatingTableID int
)

--EatingTables
Create Table EatingTables(
TableID int not null primary key identity(1,1),
TableStatus varchar(10) not null check(TableStatus='FREE' or TableStatus='OCCUPIED'),
BookedUntil datetime,
TableSize int not null,
TableType varchar(10),
COVIDStatus varchar(10) not null check(COVIDStatus='RED' or COVIDStatus='GREEN' or COVIDStatus='YELLOW')
)


--Discounts
Create Table Discounts(
DiscountID int not null primary key identity(1,1),
DiscountStatus varchar(10),
OrdersAmount int,
OrdersValue money,
DiscountDeadline date,
CustomerID int not null
)

--Alter Discounts Customer ID
Alter Table dbo.Discounts
add constraint CK_Customer 
foreign key (CustomerID) references dbo.Customers(CustomerID)


--Customers
Create Table Customers(
CustomerID int not null primary key identity(1,1),
CustomerType varchar(10) check(CustomerType='Person' or CustomerType='Company'),
OrderID int not null,
DiscountID int,
CustomerAddress varchar(50) 
)

--Alter Orders EatingTableID
Alter Table dbo.Orders
add constraint CK_EatingTable 
foreign key (EatingTableID) references dbo.EatingTables(TableID)

Alter Table dbo.Orders
add constraint CK_CustomerID 
foreign key (CustomerID) references dbo.Customers(CustomerID)

Create Table CustomerHistory(
ID int not null primary key identity(1,1),
CustomerID int not null foreign key references Customers(CustomerID),
OrderID int not null foreign key references Orders(OrderID)
)

Create Table DiscountPatterns(
ID int not null primary key identity(1,1),
Amount int not null,
TotalValue money,
DiscountValue money not null,
MinimumOrderValue money
)


Select * from dbo.Customers

Create Table OrderDetails(
ID int not null primary key identity(1,1),
OrderID int not null foreign key references Orders(OrderID),
MealID int not null foreign key references Meals(MealID),
UnitPrice money not null,
Quantity int not null,
DiscountID int
)

  Alter Table Customers 
  add CurrentDiscountAmount int

  Alter Table Orders 
  add DeliveryDate date

  Alter Table Customers
  add CurrentDiscountValue money