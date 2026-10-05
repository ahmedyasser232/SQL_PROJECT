--First make Database Northwind Then Run Script To Generate Tables and Values
Create Database Northwind;
GO
--Use Database 
use Northwind ;
GO
--Task-1 DML
	--1.1 => use update clause to increase unitprice 10% when categoryid = 8  in products table
		update Products
		set unitprice = unitprice * 1.10
		where CategoryID = 8
		select UnitPrice from Products
	--1.2=> insert a  new value in shippers table in column companyname & phone without append shipperid becuase it's generative column 
		insert into Shippers(CompanyName , phone) values('FastTrack Delivery','(503) 555-1234');
			--retrive data to ensure data inserted
				SELECT CompanyName , phone from Shippers
	--1.3=>Remove The Value We Append In previos Query by using Safe Delete Query By Using Condition Where Clause 
		Delete From Shippers
		where CompanyName = 'FastTrack Delivery'
			--retrive data to ensure data Deleted
				SELECT CompanyName , phone from Shippers 
--Task-2 Scalar Functions & Filtering 
	--2.1=> Use Scalar Function in table Customers To Upper  to capatalize ContactName and alias it to 'Fullname' by using as & return phone as masked column by use  **** +  string function call  substring 
		select Upper(ContactName) as 'FullName' , + '****' +  SUBSTRING(phone,5, len(Phone)) as Phone from Customers
	--2.2=> Calculate Exact Number of days between  Orderdate and shippeddate  in [orders]table by using function Datediff and alias it 'ProcessingDays' & when Shipcountry = 'France' 
		select	orderdate, ShippedDate , DATEDIFF(DAY,orderdate,ShippedDate) AS ProcessingDays from Orders where ShipCountry = 'France'
	--2.3=> extract Firstname from Contactname in table [Customers]  By Using  substring function to define String and  start and end in this case equal charindex to find firstspace in contactname -1 to ensure the space explicit and alias this column 'FirstName'
		select SUBSTRING(contactname,1,CHARINDEX(' ',ContactName) -1)  as  'FirstName'  from Customers
--Task-3 Aggregations, GROUP BY, & HAVING 
	--3.1=> calculate totalnetrevenue  in table [orderdetails] alias the column 'TotalRevenue'  and group the result by 'productid'
		select  productid, sum(unitprice*quantity* (1-discount)) as TotalRevenue from [Order Details] group by productid
	--3.2=> First check  there any category didn't have any product if not using inner join and  Joining tables  [Categories]  with  [Products] to generate report showing categoryname and aggregate  exact count products available in each category alias it 'ProductCount' and grouped by  'CategoryName'
		 select CategoryName , count(ProductID) as ProductCount from Categories c 
		 join Products p on c.CategoryID = p.CategoryID
		 group by CategoryName
	--3.3=> retrive customerid from table orders , count all order in table then group by customerid to find totalorder per customer using having after that to know customers above  orders  > 15 
		select CustomerID , count(*) as total_count from Orders
		group by CustomerID
		having count(*)  > 15 
		
		



