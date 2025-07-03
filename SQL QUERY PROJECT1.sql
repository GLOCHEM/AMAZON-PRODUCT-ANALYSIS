
CREATE DATABASE KMS_db 



USE KMS_DB;
GO


SELECT * FROM [dbo].[KMS Sql Case study];


------1. Which product category had the highest sales?---------

SELECT TOP 1 [Product_Category], SUM([Sales]) AS Total_Sales
FROM [dbo].[KMS Sql Case study]
GROUP BY [Product_Category]
ORDER BY Total_Sales DESC;

The Product Category with the highest sales is Technology with Total sales of 5984248.50



--------2. What are the Top 3 and Bottom 3 regions in terms of sales?-----


-- Top 3 Regions
SELECT TOP 3 [Region], SUM([Sales]) AS Total_Sales
FROM [dbo].[KMS Sql Case study]
GROUP BY [Region]
ORDER BY Total_Sales DESC;


SELECT TOP 3 [Region], SUM([Sales]) AS Total_Sales
FROM [dbo].[KMS Sql Case study]
GROUP BY [Region]
ORDER BY Total_Sales ASC;


TOP 3 REGION IN TERM OF SALES ARE:
1. WEST			3597549.41
2. ONTARIO		3063212.60
3. PRARIE		2837304.60

BOTTOM 3 REGION IN TERM OF SALES ARE:
1. NUNAVUT		116376.47
2. NORTHWEST TERRITORIES		800847.35
3. YUKON		975867.39



------3. What were the total sales of appliances in Ontario?-------


SELECT SUM([Sales]) AS Total_Appliance_Sales
FROM [dbo].[KMS Sql Case study]
WHERE [Product_Category] = 'Appliances' AND [Region] = 'Ontario';

SELECT DISTINCT [Region]
FROM [dbo].[KMS Sql Case study];


SELECT DISTINCT [Product_Category]
FROM [dbo].[KMS Sql Case study];

ANSWER: FROM THE QEURIES ABOVE, THERE IS NULL APPLIANCES FOR ONTARIO
BUT IF YOU MEANT TOTAL TECHNOLOGY OR FURNITURE SALES IN ONTARIO
THE QUERIES BELLOW ANSWERS IT, WHICH ARE:
Total Technology sales Ontario 1026163.85
Total Furniture sales Ontario 1109617.50



SELECT SUM([Sales]) AS Total_Technology_Sales_Ontario
FROM [dbo].[KMS Sql Case study]
WHERE [Product_Category] = 'Technology' AND [Region] = 'Ontario';



SELECT SUM([Sales]) AS Total_Furniture_Sales_Ontario
FROM [dbo].[KMS Sql Case study]
WHERE [Product_Category] = 'Furniture' AND [Region] = 'Ontario';



------4. Advice for Bottom 10 Customers----------
Get the bottom 10 customers by total sales:

SELECT Order_id, customer_name, SUM(sales) AS total_sales
FROM [dbo].[KMS Sql Case study]
GROUP BY order_id, customer_name
ORDER BY total_sales ASC;


SELECT Order_id, customer_name, SUM(sales) AS total_sales
FROM [dbo].[KMS Sql Case study]
GROUP BY order_id, customer_name
ORDER BY total_sales ASC;


order_id				customer_name				total_sales
	25318					Ken Dana				3.20
	49925					Adam Hart				3.41	
	9635					Andy Reiter				3.42
	16711					Jeremy Farry			3.96
	44098					John Grady				5.06
	14117					Nathan Mautz			5.31
	52322					Joni Blumstein			5.70
	3808					Lynn Smith				6.13
	22819					Patrick Jones			6.77
	6						Ruben Dartt				6.93


 Recommendation:

 The management of KMS should do the following to increase the revenue from the bottom 
10 customers 

1. Introduce loyalty programs or targeted promotions
2. Offer bundle deals or discounts
3. Conduct surveys to understand their needs
4. Assign a sales rep to high-potential low-spenders


------5. Which shipping method incurred the most cost?------

SELECT TOP 1 [Ship_Mode], SUM([Shipping_Cost]) AS Total_Shipping_Cost
FROM [dbo].[KMS Sql Case study]
GROUP BY [Ship_Mode]
ORDER BY Total_Shipping_Cost DESC;

ANSWER: The shipping method that incurred the most cost is:
Delivery Truck 51971.94


------6. Most valuable customers and their typical products/services-----

SELECT TOP 10 [Order_ID], [Customer_Name], SUM([Sales]) AS Total_Sales
FROM [dbo].[KMS Sql Case study]
GROUP BY [Order_ID], [Customer_Name]
ORDER BY Total_Sales DESC;



 SELECT [Product_Category], COUNT(*) AS Purchase_Count
FROM [dbo].[KMS Sql Case study]
WHERE [Order_ID] IN ('29766', '3073', '30343', '1444', 
                     '14435', '55747', '3841', '37252', 
                     '45347', '59781')
GROUP BY [Product_Category]
ORDER BY Purchase_Count DESC;


Answer: The Most valuable customers and their typical products/services are;
29766, 3073, 30343, 1444, 
14435, 55747, 3841, 37252, 
45347, 59781


Products					Purchase_Count
Technology						13
Office Supplies					11
Furniture						8


-----7. Which small business customer had the highest sales?------

SELECT TOP 1 [Order_ID], [Customer_Name], SUM([Sales]) AS Total_Sales
FROM [dbo].[KMS Sql Case study]
WHERE [Customer_Segment] = 'Small Business'
GROUP BY [Order_ID], [Customer_Name]
ORDER BY Total_Sales DESC;

Answer: The small business customer thatbhad the highest sales is;
Denis Kane with order_Id 14435 and total sales of 38399.35


----8. Which Corporate Customer placed the most number of orders in 2009 – 2012?------- 

SELECT Top 5 order_id, customer_name, COUNT(order_id) AS total_orders
FROM [dbo].[KMS Sql Case study]
WHERE Customer_segment = 'Corporate'
  AND order_date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY order_id, customer_name
ORDER BY total_orders DESC;

Answer: Corporate customer with most orders from (2009–2012) are:
Justin Knight, Laurel Elliston, Giulietta Weimer, Julia Barnett and Kristen Hastings
with 6, 6, 5, 5, 5 total orders respectfully.


-------9. Which consumer customer was the most profitable one?-------

SELECT Top 1 order_id, customer_name, SUM(profit) AS total_profit
FROM [dbo].[KMS Sql Case study]
WHERE customer_segment = 'Consumer'
GROUP BY order_id, customer_name
ORDER BY total_profit DESC;

Answer: The most profitable consumer customer is:
Emily Phan with order_id 29766and total profits of 28844.39



 ------10. Which customer returned items, and what segment do they belong to? ......

------I ran this query to confirm if the order status or returned status is included in the KMS dataset I imported-----
SELECT * FROM [dbo].[KMS Sql Case study]

The results was no, so I imported the order status independently
then, joined with the query below


SELECT o.[Order_ID], o.[Customer_Name], o.[customer_Segment]
FROM [dbo].[KMS Sql Case study] o
JOIN [dbo].[order_status] r
    ON CAST(o.[Order_ID] AS VARCHAR) = CAST(r.[Order_ID] AS VARCHAR);



	SELECT DISTINCT o.[Order_ID], o.[Customer_Name], o.[Customer_Segment]
FROM [dbo].[KMS Sql Case study] o
JOIN [dbo].[Order_Status] r
    ON CAST(o.[Order_ID] AS VARCHAR) = CAST(r.[Order_ID] AS VARCHAR);

	-----Count How Many Returns Each Customer Made---------

	SELECT 
    o.[Order_ID], 
    o.[Customer_Name], 
    o.[Customer_Segment], 
    o.[Product_Category], 
    o.[Sales], 
    o.[Profit]
FROM [dbo].[KMS Sql Case study] o
JOIN [dbo].[Order_Status] r
    ON CAST(o.[Order_ID] AS VARCHAR) = CAST(r.[Order_ID] AS VARCHAR);



SELECT DISTINCT 
    o.[Customer_Name], 
    o.[Customer_Segment]
FROM [dbo].[KMS Sql Case study] o
JOIN [dbo].[Order_status] r
    ON CAST(o.[Order_ID] AS VARCHAR) = CAST(r.[Order_ID] AS VARCHAR);



	SELECT 
    o.[Customer_Name], 
    o.[Customer_Segment], 
    COUNT(*) AS Total_Returns
FROM [dbo].[KMS Sql Case study] o
JOIN [dbo].[Order_Status] r
    ON CAST(o.[Order_ID] AS VARCHAR) = CAST(r.[Order_ID] AS VARCHAR)
GROUP BY o.[Customer_Name], o.[Customer_Segment]
ORDER BY Total_Returns DESC;

-----TOP 10 CUSTOMERS THAT RETURNED ITEMS AND THE SEGMENT THEY BELONG ARE:
Customer_Name			Customer_Segment			Total_Returns
Darren Budd				Consumer						10
Erin Creighton			Corporate						10
Olvera Toch				Home Office						8
Erica Smith				Small Business					7
Brad Thomas				Home Office						7
Helen Wasserman			Home Office						7
Fred Harton				Home Office						6
Dianna Vittorini		Corporate						6
Aleksandra Gannaway		Corporate						6
Charles Sheldon			Corporate						6



-------11. If the delivery truck is the most economical but the slowest shipping method and 
Express Air is the fastest but the most expensive one, do you think the company 
appropriately spent shipping costs based on the Order Priority? Explain your answer-----------



------Was shipping cost appropriately spent based on Order Priority?---------

I need to analyze the shipping mode vs. order priority:


SELECT order_priority, ship_mode, COUNT(*) AS orders_count, SUM(shipping_cost) AS total_shipping_cost
FROM [dbo].[KMS Sql Case study]
GROUP BY order_priority, ship_mode
ORDER BY order_priority, ship_mode;

I think:
1. High priority orders should use "Express Air"
2. Low priority orders should use "Delivery Truck"









