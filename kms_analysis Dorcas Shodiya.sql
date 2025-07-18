Select * from dbo.[copy kms]
--Case Senario 1----
---Question 1: Category with Highest sales---
select Top 1 
Product_Category, Sum(Sales)as Highest_Total_Sales
from dbo.[copy kms]
	group By Product_Category
order by Highest_Total_Sales desc
-------- Question 2: What are the Top 3 and Bottom 3 regions in terms of sales? -----
----Top 3---
select Top 3 
	Region, Sum(Sales) as Total_Sales
from dbo.[copy kms] 
Group by Region
order by Total_Sales desc
-----Bottom 3 -----
select Top 3 
	 Region, Sum(Sales) as Total_Sales 
	from dbo.[copy kms]
	group by Region
order by Total_Sales asc
-------Question 3: What were the total sales of appliances in Ontario?----
Select Region, Product_Sub_Category, Sum (Sales) as total_sales
	from dbo.[copy kms]
	where Region = 'Ontario' and Product_Sub_Category = 'Appliances'
	group by Region,Product_Sub_Category
---Question 4: Advise the management of KMS on what to do to increase the revenue from the bottom 10 Customers.---
	select Top 10 * from (
	select Region, Sales 
	from dbo.[copy kms]) as Sales_per_Region
order by Sales asc
--Question 5: KMS incurred the most shipping cost using which shipping method? 
select Top 1
	Ship_Mode, Sum (Shipping_Cost) as most_expensive_shipping_method
	from dbo.[copy kms]
	group by Ship_Mode
	order by most_expensive_shipping_method desc
	----Case Senario 2-----
---Question 6:  Who are the most valuable customers, and what products or services do they typically purchased?--
select 
	Customer_Name, Sum (Sales) as Total_Sales,Product_Category,Product_Name
	from dbo.[copy kms]
	group by Customer_Name,Product_Category,Product_Name
	order by Total_Sales desc
	---- Question 7: Which small business customer had the highest sales?-- 
select Top 1
	Customer_Name,Customer_Segment, Sum(Sales) as Small_business_customer_with_highest_sales
	from dbo.[copy kms] 
	where Customer_Segment='Small Business'
	group by Customer_Name,Customer_Segment
order by Small_business_customer_with_highest_sales desc
-----Question 8:Which Corporate Customer placed the most number of orders in 2009 – 2012?---
Select Top 1
 Customer_Name, Customer_Segment, Order_Date, COUNT[Order_ID] AS Number_Of_Order
 from dbo.[copy kms] 
 where Customer_Segment ='Corporate' AND Year(Order_Date) between 2009 and 2012
 group by Customer_Name,Customer_Segment,Order_Date 
 Order by Total_Order desc
 ---
 Select * from dbo.[copy kms]
----Question 9: Which consumer customer was the most profitable one?----
Select Top 1
Customer_Name, Customer_Segment,SUM (Profit) as Total_Profit
from dbo.[copy kms]
where Customer_Segment = 'Consumer'
group by Customer_Name,Customer_Segment
order by Total_Profit desc
----Question 10: Which customer returned items, and what segment do they belong to?---
Select 
	dbo.[copy kms].Customer_Name, 
	dbo.[copy kms].Customer_Segment, 
	dbo.[copy kms].Order_ID,
	dbo.Order_Status.Order_ID,
	dbo.Order_Status.Status,
from dbo.[copy kms]
Inner Join dbo.[copy kms]
on dbo.[copy kms].Order_ID = dbo.Order_Status.Order_ID
	
