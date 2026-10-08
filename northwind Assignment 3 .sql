use Northwind;
GO
--Task 1 Joins & Set Operations 
	--1.1 using left join with isnull to retrive customers who have never placed an order
		select c.customerid , c.companyname from Customers c 
		left join orders o on c.CustomerID = o.CustomerID
		where o.CustomerID  is null;
	--1.2 using set operation (union ) to return citylist as column from concat cities from customers table and cities from employees table and combine it together with out any duplicates
		select city as CityList from Customers
		union
		select city  from [dbo].[Employees]
	--1.3 use self join to return employee and manager and concat method to concat firstname + lastname , using reports to collumn to know who managers in this table.
		select   concat(e2.firstname,' ',e2.lastname) as EmployeeName , concat(e1.firstname,' ' ,e1.lastname)  as ManagerName  from Employees  e1 
		join  Employees e2  on e1.EmployeeID = e2.ReportsTo
--Task 2  SubQuries
	--2.1 retrive products with unitprice greater than avg of unitprice  by using subquries
		select  ProductID , ProductName , UnitPrice   from Products
		where UnitPrice > (select avg(unitprice) from Products)
	--2.2  using select subquries to retrun max(orderdate) as latestorderdate where customerid is equivelent in both table instead of joins
		select c.customerid ,c.companyname, (select max(orderdate)  from orders o where c.CustomerID = o.CustomerID )  as LatestOrderDate
		from Customers c;
--Task 3 CTES
	--3.1 use a cte to return Avg unitprice per categoryid , join three tables together to retrive final result 
		with CategoryAverages  as 
			(
			select  categoryid , avg(unitprice) as AvgCategoryPrice from Products
			group by CategoryID
			)
			select p.ProductName , c.CategoryName ,p.UnitPrice  ,ca.AvgCategoryPrice   from  CategoryAverages  ca 
			join Products p on  ca.categoryid = p.categoryid
			join Categories c on  ca.categoryid = c.categoryid
	--3.2 use a previous and append a new column in main query to retrive pricediffrence  from substract  p.UnitPrice -ca.AvgCategoryPrice
			with CategoryAverages  as 
			(
			select  categoryid , avg(unitprice) as AvgCategoryPrice from Products
			group by CategoryID
			)
			select p.ProductName , c.CategoryName ,p.UnitPrice  ,ca.AvgCategoryPrice , ( p.UnitPrice -ca.AvgCategoryPrice ) as  PriceDifference   from  CategoryAverages  ca 
			join Products p on  ca.categoryid = p.categoryid
			join Categories c on  ca.categoryid = c.categoryid

	 
