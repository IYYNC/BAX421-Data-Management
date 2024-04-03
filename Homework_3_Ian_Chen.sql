-- PRESTIGE CAR DATABSE
-- Question 1
-- Suppose the sales director wants to see the list of cars (make and model) bought on July 25, 2015. Write a SQL query to create this list.
SELECT 
    (SELECT MakeName 
     FROM make 
     WHERE MakeID = (SELECT MakeID 
                     FROM model 
                     WHERE ModelID = s.ModelID)) AS MakeName,
    (SELECT ModelName 
     FROM model 
     WHERE ModelID = s.ModelID) AS ModelName
FROM 
    stock s
WHERE 
    s.DateBought = '2015-07-25';
-- Question 2
-- The sales director now wants to see a list of all the cars (make and model) bought between July 15, 2018 and August 31, 2018. Write a SQL query to create this list.
SELECT DISTinCT
    (SELECT MakeName 
     FROM make 
     WHERE MakeID = (SELECT MakeID 
                     FROM model 
                     WHERE ModelID = s.ModelID)) AS MakeName,
    (SELECT ModelName 
     FROM model 
     WHERE ModelID = s.ModelID) AS ModelName
FROM 
    stock s
WHERE 
    s.DateBought BETWEEN '2018-07-15' AND '2018-08-31';
-- Question 3
-- The finance director is keen to ensure that cars do not stay on the firm’s books too long —it ties up expensive capital. So, the finance director wants a list of the makes and models and the number of days that each vehicle remained, unsold, on the lot until they were bought by a customer. Create this list. The director wants to see this list in such a way that the cars which remained on the lot the most longer appears on the top.
SELECT 
    (SELECT MakeName FROM make WHERE MakeID = 
        (SELECT MakeID FROM model WHERE ModelID = s.ModelID)
    ) AS MakeName,
    (SELECT ModelName FROM model WHERE ModelID = s.ModelID) AS ModelName,
    IFNULL(
        (SELECT DATEDIFF(Min(sl.SaleDate), s.DateBought)+1
         FROM salesdetails sd
         inNER JOin sales sl ON sd.SalesID = sl.SalesID
         WHERE sd.StockID = s.StockCode),
        DATEDIFF(CURDATE(), s.DateBought)+1
    ) AS DaysOnLot
FROM 
    stock s
ORDER BY 
    DaysOnLot DESC;
-- Question 4
-- Suppose the CFO wants to know the average daily purchase spend on cars over a six-MONTH period. Create this list. Choose the period from July 1, 2015 through December 31, 2015. 
SELECT ROUND(SUM(Cost)/(DATEDIFF('2015-12-31','2015-07-01')+1),0) AS AVG_DAILY_PURCHASE
FROM stock
WHERE DateBought BETWEEN '2015-07-01' AND '2015-12-31';
-- Question 5
-- As Prestige Cars has been selling cars for several years, the finance director wants to isolate the records for a specific year. in particular, the director wants to see a list of cars (make and model) sold in the year 2015. Create this list.
SELECT 
    mk.MakeName, 
    md.ModelName
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE 
    YEAR(s.SaleDate) = 2015
GROUP BY 
    mk.MakeName, md.ModelName;

-- Question 6
-- Now that the director has the sales list for 2015 from the previous part, he wants to compare the list of makes and models sold in both 2015 and in 2016. Create this list in an ordered fashion.
SELECT 
    mk.MakeName, 
    md.ModelName,
    YEAR(s.SaleDate) AS `YEAR`
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE 
    YEAR(s.SaleDate) in (2015,2016)
GROUP BY 
    mk.MakeName, md.ModelName, `YEAR`
ORDER BY `YEAR`;
-- Question 7
-- The CEO is convinced that some MONTHs are better for sales than others. She has asked for the sales for July 2015 to check out her hunch. List the vehicles (makes and models) sold during July 2015.
SELECT 
    mk.MakeName, 
    md.ModelName
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE 
    s.SaleDate BETWEEN '2015-07-01' AND '2015-07-31';
-- Question 8
-- The CEO was disappointed about the sales in July 2015 from the previous question. Now, she wants to see sales for the entire third quarter of 2015. Generate this list.
SELECT 
    mk.MakeName, 
    md.ModelName
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE 
    s.SaleDate BETWEEN '2015-07-01' AND '2015-09-30';
-- Question 9
-- The sales director wants to do an analysis of sales on a particular day of the week. So, you are asked to create a list of the vehicles sold on Fridays in the year 2016. Create this list.
SELECT DISTinCT
    mk.MakeName, 
    md.ModelName
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE 
    YEAR(s.SaleDate) = 2016
AND WEEKDAY(s.SaleDate) = 4;
-- Question 10
-- The sales director was pleased with your list of vehicles sold on Fridays from the previous question. He now wants to take a look at the sales for the 26th week of 2017. Create such a list.
SELECT DISTinCT
    mk.MakeName, 
    md.ModelName
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE 
    YEAR(s.SaleDate) = 2017
AND WEEK(s.SaleDate) = 26;
-- Question 11
-- The HR manager needs to see how sales vary across days of the week. He has explained that he needs to forecast staff requirements for busy days. He wants to see, overall, which were the weekdays where Prestige Cars made the most sales in 2015. Create this list.
SELECT
    WEEKDAY(s.SaleDate) AS WEEKDAY, SUM(sd.SalePrice) AS Total_Sales
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE 
    YEAR(s.SaleDate) = 2015
GROUP BY WEEKDAY
ORDER BY Total_Sales DESC;
-- Question 12
-- The HR manager liked the information you gave him in the previous question. However, the list in the previous question was a little too cryptic for him. He has requested that you display the weekday name instead of the weekday number. Regenerate the list from the previous question with this new request.
SELECT
    DAYNAME(s.SaleDate) AS WEEKDAY, SUM(sd.SalePrice) AS Total_Sales
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE 
    YEAR(s.SaleDate) = 2015
GROUP BY WEEKDAY
ORDER BY Total_Sales DESC;
-- Questoin 13
-- The sales manager has had another of her ideas. You can tell by her smile as she walks over to you in the cafeteria while you were having lunch. Her idea, fortunately, is unlikely to spoil your meal. What she wants is the total and average sales for each day of the year since Prestige Cars started trading. Create this list for her.
SELECT
    DAYOFYEAR(s.SaleDate) AS Day_of_year, SUM(sd.SalePrice) AS Total_Sales, AVG(sd.SalePrice) AS Average_Sales
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
GROUP BY Day_of_year
ORDER BY Day_of_year;
-- Question 14
-- The CEO wants you to give her the total and average sales for each day of the MONTH for all sales, ever. Create this list for the CEO.
SELECT
    DAYOFMONTH(s.SaleDate) AS Day_of_MONTH, SUM(sd.SalePrice) AS Total_Sales, AVG(sd.SalePrice) AS Average_Sales
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
GROUP BY Day_of_MONTH
ORDER BY Day_of_MONTH;
-- Question 15
-- Just as you are about to leave for home, the CEO flags you down on your way out of the office and insists that she needs the number of vehicles sold per MONTH in 2018. Create this list showing the MONTH number, MONTH name, and the number of vehicles sold per MONTH.
SELECT 
    MONTH(s.SaleDate) AS MONTH_number, MONTHNAME(s.SaleDate) AS MONTH_name, count(*) AS Num_of_Vehicles_Sold
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE YEAR(s.SaleDate) = 2018
GROUP BY MONTH_number, MONTH_name
ORDER BY MONTH_number;
-- Question 16
-- The HR manager has emailed another request. He needs to calculate the final bonus of a salesperson who is leaving the company and consequently needs to see the accumulated sales made by this staff member for a 75 day period up to July 25, 2015. The salesperson sold Jaguars for Prestige Cars.
SELECT 
    SUM(sd.SalePrice) AS Accumulated_Sales
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE s.SaleDate <= '2015-07-25' 
AND s.SaleDate >= (DATE_SUB('2015-07-25',inTERVAL 74 DAY))
AND mk.MakeName = 'Jaguar';
-- Question 17
-- The CEO has a single list of all customers. However, there is a problem with the list. She doesn’t like the address split into many columns. She seeks your help. Recreate the customer list for the CEO with the address neatly formatted into one column with a dash (-) between the address and the PostCode. Since the list is for the CEO, you want the list to be as polished as possible. For instance, avoid NULLs in concatenated output.
SELECT 
    CustomerID, CustomerName,
    CONCAT_WS(' - ', CONCAT_WS(', ', Address1, Address2, Town, Country), PostCode) AS FullAddress,
    IsReseller, IsCreditRisk
FROM 
    customer
ORDER BY 
    CustomerID;
-- Question 18
-- The sales manager now wants a list of all the different make and model combinations that have ever been sold with the total sale price for each combination. However, this time, she wants the make and model output as a single column. She knows that this is an easy request for you, so she decides to hover near your desk. Write a query to create this list.
SELECT CONCAT_WS('-', mk.MakeName, md.ModelName) AS Vehicle, sum(sd.SalePrice) AS Total_Sale_Price  
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
GROUP BY Vehicle
ORDER BY Vehicle;
-- Question 19
-- The marketing director thinks that some text are too long. She wants you to show the make names as acronyms using the first three letters of each make in a catalog of products. Create a list. For your list, create a single column showing the model name with the acronym for the make name in the parentheses.
SELECT concat(md.ModelName,"(",LEFT(mk.MakeName,3),")") AS Vehicle
FROM model md
JOin make mk on (md.MakeID = mk.MakeID);
-- Question 20
-- The finance director wants you to show only the three characters at the right of the invoice number. Write a query to display this list.
SELECT RIGHT(invoiceNumber,3) AS invoice_num_short
from sales;
-- Question 21
-- in the Prestige Cars IT system, the fourth and fifth characters of the invoice number indicate the country where the vehicles were shipped. Knowing this, the sales director wants to extract only these characters from the invoice number field in order to analyze destination countries. Create such a list.
SELECT SUBSTR(invoiceNumber,4,2) as COUNTRY
from sales
GROUP BY COUNTRY;
-- Question 22
-- The sales director has requested a list of sales where the invoice was paid in Euros. Display this list.
SELECT *
FROM sales
WHERE LEFT(invoiceNumber,3) = "EUR";
-- Question 23
-- The sales director now wants to see all the cars shipped to France but made in Italy.
SELECT CONCAT_WS('-',mk.MakeName,md.ModelName) AS CARS
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
WHERE SUBSTR(invoiceNumber,4,2) = 'FR'
AND mk.MakeCountry = 'ITA'
GROUP BY CARS;
-- Question 24
-- The sales director wants a “quick list” of all vehicles sold and the destination country. Generate such a list.
SELECT CONCAT_WS('-',mk.MakeName,md.ModelName) AS CARS,
	   SUBSTR(invoiceNumber,4,2) AS Destination_Country
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
GROUP BY CARS,Destination_Country
ORDER BY Destination_Country, CARS;
-- Question 25
-- The sales director wants you to make some reports that you send directly from MySQL to appear looking slightly easier to read. She wants you to display the cost from the stock table with a thousands separator and two decimals. Create a report with this column in the requested format.
SELECT 
    FORMAT(Cost, 2) AS FormattedCost
FROM 
    stock;
-- Question 26
-- The sales director is rushing to a meeting with the CEO. in a rush she requests you to create a report showing the make, model, and the sale price. The sale price in the report should include thousands separators, two decimals, and a British pound symbol. Create this report.
SELECT mk.MakeName, md.ModelName, CONCAT("£", FORMAT(sd.SalePrice,2)) as SalePrice
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
ORDER BY mk.MakeName;
-- Question 27
-- The CEO wants the sale price that you displayed in the previous question (with thousands separators and two decimals) to be now in German style —that is with a period as the thousands separator and a comma as the decimal. Create such a list.
SELECT mk.MakeName, md.ModelName, CONCAT("£", FORMAT(sd.SalePrice,2,'de_DE')) as SalePriceSELECT 
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID
ORDER BY mk.MakeName;
-- Question 28
-- Suppose the CEO requests a report showing the invoice number and the sale date, but the sale date needs to be in a specific format —first the day, then the abbreviation for the MONTH, and finally the year in four figures —in this occurrence. Create this report.
SELECT 
    invoiceNumber,
    DATE_FORMAT(SaleDate, '%d %b %Y') AS FormattedSaleDate
FROM 
    sales
ORDER BY invoiceNumber;
-- Question 29
-- Suppose the CEO requests the report in the previous question showing the invoice number and the sale date, but this time the sale date needs to be in the ISO format. Create this report.
SELECT 
    invoiceNumber,
    DATE_FORMAT(SaleDate, '%Y-%m-%d') AS ISOSaleDate
FROM 
    sales
ORDER BY ISOSaleDate;

-- Question 30
-- The CEO, who is very happy with your work, now requests the report in the previous question to show the invoice number and the time at which the sale was made. The time needs to be in hh:mm:ss format showing AM or PM after it. Create this report.
SELECT s.invoiceNumber, DATE_FORMAT(s.SaleDate, '%h:%i:%s %p') AS Sale_Time
FROM sales s;
-- Question 31
-- Keeping track of costs is an essential part of any business. Suppose that the finance director of Prestige Cars Ltd. wants a report that flags any car ever bought where the parts cost was greater than the cost of repairs. in your report, the finance director wants you to flag such costs with an alert. Write a query to generate such a report.
SELECT 
    st.StockCode,
    st.ModelID,
    st.Cost,
    st.PartsCost,
    st.RepairsCost,
    mk.MakeName,
    md.ModelName,
    CASE
        WHEN PartsCost > RepairsCost THEN 'Alert: Parts cost greater than repairs cost'
        ELSE 'No alert'
    END AS CostAlertFlag
FROM 
    stock st
JOin 
    model md ON st.ModelID = md.ModelID
JOin 
    make mk ON md.MakeID = mk.MakeID;

-- Question 32
-- The sales director wants some customer feedback. She knows that the sales database has comments from clients in it. But she does not need —or want —to display all the text in the comments. All she wants is to display the first 25 characters and then use ellipses to indicate that the text has been shortened. Write an SQL query to display the comments in this format.
SELECT 
    StockCode,
    CONCAT(LEFT(BuyerComments, 25), '...') AS Shortened_Comments
FROM 
    stock
WHERE 
    BuyerComments IS NOT NULL;
-- Question 33
-- This time, the sales director wants you to look at the profit on each car sold and flag any sale where the profit figure is less than 10 percent of the purchase cost —while at the same time the repair cost is at least twice the parts cost! Flag such records with a cost alert such as “Warning!”. Other sales need to be flagged as “OK”. Write a SQL query to generate this report.
SELECT 
    s.SalesID,
    st.StockCode,
    st.Cost AS PurchaseCost,
    st.RepairsCost,
    st.PartsCost,
    (sd.SalePrice-st.Cost-st.RepairsCost-coalesce(st.PartsCost,0)-st.TransportinCost) AS Profit,
    CASE
        WHEN (sd.SalePrice-st.Cost-st.RepairsCost-coalesce(st.PartsCost,0)-st.TransportinCost) < (0.1 * st.Cost) AND st.RepairsCost >= (2 * st.PartsCost) THEN 'Warning!'
        ELSE 'OK'
    END AS CostAlertFlag
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
ORDER BY s.SalesID;

-- Question 34
-- The sales director looks at your previous result and becomes overjoyed thinking that SQL might be able to do much more! in addition to the cost alert displayed in the previous question, she wants to flag the costs as “Acceptable” if the net margin is greater than 10 percent, but less than 50 percent of the sale price. Otherwise, flag the cost as “OK”. Write an SQL query.
SELECT 
    s.SalesID,
    st.StockCode,
    st.Cost AS PurchaseCost,
    st.RepairsCost,
    st.PartsCost,
    (sd.SalePrice-st.Cost-st.RepairsCost-coalesce(st.PartsCost,0)-st.TransportinCost) AS Profit,
    CASE
        WHEN (sd.SalePrice-st.Cost-st.RepairsCost-coalesce(st.PartsCost,0)-st.TransportinCost) < (0.1 * st.Cost) AND st.RepairsCost >= (2 * st.PartsCost) THEN 'Warning!'
        WHEN (sd.SalePrice-st.Cost-st.RepairsCost-coalesce(st.PartsCost,0)-st.TransportinCost)/sd.SalePrice >0.1 AND (sd.SalePrice-st.Cost-st.RepairsCost-coalesce(st.PartsCost,0)-st.TransportinCost)/sd.SalePrice <0.5 THEN 'Acceptable'
        ELSE 'OK'
    END AS CostAlertFlag
FROM 
    sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
JOin 
    stock st ON sd.StockID = st.StockCode
ORDER BY s.SalesID;
-- Question 35
-- The finance director needs to manage exchange rate risk. So, he wants you to add each client’s currency area to the printout. Unfortunately, the database doesn’t have a field that holds the currency area. The currency areas that the director wants are “Eurozone” for countries in Europe, “Pound Sterling” for the United Kingdom, “Dollar” for the United States, and “Other” for all other regions. Write an SQL query to generate a report showing the country name and the corresponding currency region.
SELECT CountryName,
	   CASE WHEN CountryISO3 = "GBR" then "Pound Sterling"
			 WHEN SalesRegion = "EMEA" then "Eurozone"
			 WHEN CountryISO3 = "USA" then "Dollar"
			 ELSE "Other"
             END AS Currency
FROM country;
-- Question 36
-- The finance director is overjoyed that you solved his previous conundrum and were able to add currency areas to the output. So, now he wants to take this one step further and has asked you for a report that counts the makes of the car according to the geographical zone where they were built. Divide the countries in which the cars were built into three regions: European, American, and British. Create such a report using SQL.
SELECT Geo_Zone, COUNT(MakeName) AS Makes
FROM(SELECT CASE WHEN MakeCountry = "USA" then "American"
			WHEN MakeCountry = "GBR" then "British"
            ELSE "European" 
            END AS Geo_Zone
		, MakeCountry
		, MakeName
FROM make) t
GROUP BY Geo_Zone; 
-- Question 37
-- The sales director would like you to create a report that breaks down total sales values into a set of custom bandings by value (Under 5000, 5000-50000, 50001-100000, 100001-200000, Over 200000) and show how many vehicles have been sold in each category. Write an SQL query to create such a report.
SELECT CASE WHEN s.TotalSalePrice < 5000 THEN "Under 5000"
			WHEN s.TotalSalePrice BETWEEN 5000 AND 50000 THEN "5000-50000"
			WHEN s.TotalSalePrice BETWEEN 50001 AND 100000 THEN "50001-100000" 
			WHEN s.TotalSalePrice BETWEEN 100001 AND 200000 THEN "100001-200000"
			WHEN s.TotalSalePrice > 200000 THEN "Over 200000" ELSE "NA" 
            END AS Banding,
            COUNT(sd.SalesDetailsID) as Vehicles_Sold
FROM Sales s
JOin 
    salesdetails sd ON s.SalesID = sd.SalesID
GROUP BY Banding;            
-- Question 38
-- The sales director wants to make it clear in which season a vehicle is sold. The seasons are: Winter (Nov - Feb), Spring (Mar, Apr), Summer (May, Jun, Jul, Aug), and Autumn (Sept, Oct). Create a report showing the MONTH number, sale date, and the sale season.
SELECT SalesID, 
	   MONTH(SaleDate) as MONTHNumber,
       SaleDate,
		CASE WHEN MONTH(SaleDate) IN (11, 12, 1, 2) THEN "Winter"
			 WHEN MONTH(SaleDate) IN (3, 4) THEN "Spring"
             WHEN MONTH(SaleDate) IN (5, 6, 7, 8) THEN "Summer"
		     ELSE "Autumn" 
             END AS SaleSeason
from sales;
-- Question 39
-- The sales director has asked you to find all the sales for the top five bestselling makes. Write an SQL query to display such a list. Order by sale price descending. Write the query without using any window functions.
SELECT 
    m.MakeName, 
    s.SalesID, 
    sd.SalePrice
FROM 
    make m
INNER JOIN 
    model mo ON m.MakeID = mo.MakeID
INNER JOIN 
    stock st ON mo.ModelID = st.ModelID
INNER JOIN 
    salesdetails sd ON st.StockCode = sd.StockID
INNER JOIN 
    sales s ON sd.SalesID = s.SalesID
INNER JOIN (
        SELECT 
            mo.MakeID
        FROM 
            model mo
        INNER JOIN 
            stock st ON mo.ModelID = st.ModelID
        INNER JOIN 
            salesdetails sd ON st.StockCode = sd.StockID
        GROUP BY 
            mo.MakeID
        ORDER BY 
            SUM(sd.SalePrice) DESC
        LIMIT 5
    ) t ON m.MakeID=t.MakeID
ORDER BY 
    sd.SalePrice DESC;
SELECT * FROM Salesdetails;
-- Question 40
-- Suppose you are asked to show which colors sell the most. in addition, you also want to find the percentage of cars purchased by value for each color of vehicle. Write an SQL query to show this result set. Write the query without using any window functions.
SELECT 
    st.Color,
    COUNT(*) AS NumberOfCarsSold,
    SUM(sd.SalePrice) AS TotalSalesValue,
    (SUM(sd.SalePrice) / (SELECT SUM(SalePrice) FROM salesdetails)) * 100 AS PercentageOfTotalSales
FROM 
    salesdetails sd
INNER JOIN 
    stock st ON sd.StockID = st.StockCode
GROUP BY 
    st.Color
ORDER BY 
    NumberOfCarsSold DESC, TotalSalesValue DESC;

-- Question 41
-- The CEO requests a list of all the vehicle makes and models sold this year but not in the previous year. Write an SQL query to create this list. Write the query without using any window functions.
SELECT DISTINCT
    mk.MakeName,
    mo.ModelName
FROM 
    sales s
JOIN 
    salesdetails sd ON s.SalesID = sd.SalesID
JOIN 
    stock st ON sd.StockID = st.StockCode
JOIN 
    model mo ON st.ModelID = mo.ModelID
JOIN 
    make mk ON mo.MakeID = mk.MakeID
WHERE 
    YEAR(s.SaleDate) = 2018
    AND NOT EXISTS (
        SELECT 1
        FROM sales s2
        JOIN salesdetails sd2 ON s2.SalesID = sd2.SalesID
        JOIN stock st2 ON sd2.StockID = st2.StockCode
        WHERE YEAR(s2.SaleDate) = 2017
        AND st2.ModelID = st.ModelID
    )
ORDER BY 
    mk.MakeName, 
    mo.ModelName;


-- Question 42
-- The sales manager wants to see a list of all vehicles sold in 2017, with the percentage of sales each sale represents for the year as well as the deviation of sales from the average sales figure. Hint: To simplify writing this query, you can use a view named salesbycountry included in the database. You can use the view like the source table. Write the query without using any window functions.
-- Create a view to calculate total and average sales for 2017
SELECT 
    s.SaleDate,
    s.SalePrice,
    (s.SalePrice / total_sales.TotalSales) * 100 AS SalePercentage,
    s.SalePrice - average_sales.AverageSale AS DeviationFromAverage
FROM 
    salesbycountry s,
    (SELECT SUM(SalePrice) AS TotalSales FROM salesbycountry WHERE YEAR(SaleDate) = 2017) total_sales,
    (SELECT AVG(SalePrice) AS AverageSale FROM salesbycountry WHERE YEAR(SaleDate) = 2017) average_sales
WHERE 
    YEAR(s.SaleDate) = 2017
ORDER BY 
    s.SaleDate;


-- Question 43
-- Classifying product sales can be essential for an accurate understanding of which products sell best. At least that is what the CEO said WHEN she requested a report showing sales for 2017 ranked in order of importance by make. Write an SQL query to generate this report.
SELECT 
    mk.MakeName,
    SUM(sd.SalePrice) AS TotalSales
FROM 
    sales s
JOIN 
    salesdetails sd ON s.SalesID = sd.SalesID
JOIN 
    stock st ON sd.StockID = st.StockCode
JOIN 
    model mo ON st.ModelID = mo.ModelID
JOIN 
    make mk ON mo.MakeID = mk.MakeID
WHERE 
    YEAR(s.SaleDate) = 2017
GROUP BY 
    mk.MakeName
ORDER BY 
    TotalSales DESC;

-- Question 44
-- Buyer psychology is a peculiar thing. To better understand Prestige Cars’ clients, the sales director has decided that she wants to find the bestselling color for each make sold. Write an SQL query to create this list.
SELECT 
    MakeName,
    Color,
    TotalSold
FROM (
    SELECT 
        mk.MakeName,
        st.Color,
        COUNT(*) AS TotalSold,
        ROW_NUMBER() OVER (PARTITION BY mk.MakeName ORDER BY COUNT(*) DESC) AS rn
    FROM 
        make mk
    JOIN 
        model mo ON mk.MakeID = mo.MakeID
    JOIN 
        stock st ON mo.ModelID = st.ModelID
    JOIN 
        salesdetails sd ON st.StockCode = sd.StockID
    JOIN 
        sales s ON sd.SalesID = s.SalesID
    GROUP BY 
        mk.MakeName, st.Color
) AS ColorRanking
WHERE 
    rn = 1;


-- Question 45
-- Prestige Cars caters to a wide range of clients, and the sales director does not want to forget about the 80% that are outside the top 20% of customers. She wants you to take a closer look at the second quintile of customers —those making up the second 20% of sales. Her exact request is this “Find the sales details for the top three selling makes in the second 20% of sales.” Write an SQL query to create this result set.
WITH RankedMakes AS (
    SELECT
        mk.MakeName,
        SUM(sd.SalePrice) AS TotalSalesValue,
        NTILE(5) OVER (ORDER BY SUM(sd.SalePrice) DESC) AS Quintile
    FROM
        sales s
    INNER JOIN salesdetails sd ON s.SalesID = sd.SalesID
    INNER JOIN stock st ON sd.StockID = st.StockCode
    INNER JOIN model mo ON st.ModelID = mo.ModelID
    INNER JOIN make mk ON mo.MakeID = mk.MakeID
    GROUP BY
        mk.MakeName
),
TopMakes AS (
    SELECT
        MakeName,
        TotalSalesValue
    FROM
        RankedMakes
    WHERE
        Quintile = 2
    ORDER BY
        TotalSalesValue DESC
    LIMIT 3
),
SalesDetailsTopMakes AS (
    SELECT
        s.SaleDate,
        s.InvoiceNumber,
        mk.MakeName,
        mo.ModelName,
        sd.SalePrice
    FROM
        sales s
    INNER JOIN salesdetails sd ON s.SalesID = sd.SalesID
    INNER JOIN stock st ON sd.StockID = st.StockCode
    INNER JOIN model mo ON st.ModelID = mo.ModelID
    INNER JOIN make mk ON mo.MakeID = mk.MakeID
    WHERE
        mk.MakeName IN (SELECT MakeName FROM TopMakes)
)
SELECT * FROM SalesDetailsTopMakes;


-- Question 46
-- The CEO is interested in analyzing key metrics over time. Her latest request is that you obtain the total sales to each date and then display the running total of sales by value for each year. Write an SQL query to fulfill her request.
SELECT 
    YEAR(s.SaleDate) AS SaleYear, 
    s.SaleDate, 
    SUM(sd.SalePrice) AS DailySales,
    SUM(SUM(sd.SalePrice)) OVER (PARTITION BY YEAR(s.SaleDate) ORDER BY s.SaleDate) AS RunningTotal
FROM 
    sales s
JOIN 
    salesdetails sd ON s.SalesID = sd.SalesID
GROUP BY 
    SaleYear, 
    s.SaleDate
ORDER BY 
    SaleYear, 
    s.SaleDate;

-- Question 47
-- Sales at the company are increasing and senior management is convinced that effective analytics is a key factor of corporate success. The latest request to arrive in your inbox is for a report that shows both the first order and the last four sales for each customer. Write an SQL query to generate this result set.
select CustomerName,
        first_value(ModelName) over (partition by CustomerName order by SaleDate asc) first_order,        
        nth_value(ModelName,1) over (partition by CustomerName order by SaleDate desc) last_order1,
        nth_value(ModelName,2) over (partition by CustomerName order by SaleDate desc) last_order2,
        nth_value(ModelName,3) over (partition by CustomerName order by SaleDate desc) last_order3,
        nth_value(ModelName,4) over (partition by CustomerName order by SaleDate desc) last_order4
from salesbycountry
order by CustomerName;

-- Question 48
-- The sales manager is on a mission to find out if certain weekdays are better for sales than others. Write a query so that she can analyze sales for each day of the week (but not weekends) in 2017 where there was a sale.
SELECT CASE WHEN weekday(SaleDate) = 0 THEN "Monday"
			WHEN weekday(SaleDate) = 1 THEN "Tuesday"
			WHEN weekday(SaleDate) = 2 THEN "Wednesday"
			WHEN weekday(SaleDate) = 3 THEN "Thursday"
			WHEN weekday(SaleDate) = 4 THEN "Friday" ELSE null 
            END AS weekday, 
            sum(TotalSalePrice) as Sales
from sales
where year(SaleDate) = 2017 and weekday(SaleDate) not in (5,6)
group by 1 order by 2 desc;
-- COLONIAL DATABASE
-- Q1
SELECT r.ReservationID, r.TripID, r.TripDate
FROM reservation r
JOIN trip t ON r.TripID = t.TripID
WHERE t.State = 'ME';
SELECT r.ReservationID, r.TripID, r.TripDate
FROM reservation r
WHERE r.TripID IN (
    SELECT t.TripID
    FROM trip t
    WHERE t.State = 'ME'
);
SELECT r.ReservationID, r.TripID, r.TripDate
FROM reservation r, (
    SELECT t.TripID
    FROM trip t
    WHERE t.State = 'ME'
) AS subquery
WHERE r.TripID = subquery.TripID;

-- Q2
SELECT TripID, TripName
FROM trip AS t1
WHERE MaxGrpSize > (
    SELECT MAX(MaxGrpSize)
    FROM trip AS t2
    WHERE Type = 'Hiking'
);


-- Q3

SELECT t1.TripID, t1.TripName
FROM Trip t1
WHERE EXISTS (SELECT t2.TripID
				FROM Trip t2 
				WHERE t2.Type = "Biking" 
                AND t1.MaxGrpSize > t2.MaxGrpSize);
-- ENTERTAINMENT DATABASE
-- 1
SELECT Distinct EntStageName
FROM Entertainers
JOIN Engagements ON Entertainers.EntertainerID = Engagements.EntertainerID
JOIN Customers ON Engagements.CustomerID = Customers.CustomerID
WHERE Customers.CustLastName IN ('Berg', 'Hallmark');
SELECT e.EntertainerID, e.EntStageName
FROM ENTERTAINERS e
WHERE EXISTS (
    SELECT 1
    FROM ENGAGEMENTS eng
    JOIN CUSTOMERS c ON eng.CustomerID = c.CustomerID
    WHERE c.CustLastName IN ('Berg', 'Hallmark') AND e.EntertainerID = eng.EntertainerID
);


-- 2
SELECT AVG(Salary) AS AverageSalary
FROM Agents;

-- 3
SELECT EngagementNumber
FROM Engagements
WHERE ContractPrice >= (SELECT AVG(ContractPrice) FROM Engagements);

-- 4
SELECT COUNT(*) AS EntertainersInBellevue
FROM Entertainers
WHERE EntCity = 'Bellevue';
-- 5
SELECT *
FROM Engagements
WHERE StartDate = (
    SELECT MIN(StartDate)
    FROM Engagements
    WHERE StartDate BETWEEN '2017-10-01' AND '2017-10-31'
);
-- 6
SELECT Entertainers.EntertainerID, Entertainers.EntStageName, COUNT(Engagements.EngagementNumber) AS NumberOfEngagements
FROM Entertainers
LEFT JOIN Engagements ON Entertainers.EntertainerID = Engagements.EntertainerID
GROUP BY Entertainers.EntertainerID, Entertainers.EntStageName;
-- 7
SELECT DISTINCT Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID IN (
    SELECT Engagements.CustomerID
    FROM Engagements
    JOIN Entertainer_Styles ON Engagements.EntertainerID = Entertainer_Styles.EntertainerID
    JOIN Musical_Styles ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
    WHERE Musical_Styles.StyleName IN ('Country', 'Country Rock')
);
-- 8 
SELECT DISTINCT Customers.CustFirstName, Customers.CustLastName
FROM Customers
JOIN Engagements ON Customers.CustomerID = Engagements.CustomerID
JOIN Entertainer_Styles ON Engagements.EntertainerID = Entertainer_Styles.EntertainerID
JOIN Musical_Styles ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
WHERE Musical_Styles.StyleName IN ('Country', 'Country Rock');

-- 9 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE Entertainers.EntertainerID IN (
    SELECT Engagements.EntertainerID
    FROM Engagements
    JOIN Customers ON Engagements.CustomerID = Customers.CustomerID
    WHERE Customers.CustLastName IN ('Berg', 'Hallmark')
);

-- 10
SELECT Distinct Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
JOIN Engagements ON Entertainers.EntertainerID = Engagements.EntertainerID
JOIN Customers ON Engagements.CustomerID = Customers.CustomerID
WHERE Customers.CustLastName IN ('Berg', 'Hallmark');

-- 11
SELECT AgentID, AgtFirstName, AgtLastName
FROM Agents
WHERE AgentID NOT IN (
    SELECT DISTINCT AgentID
    FROM Engagements
    WHERE AgentID IS NOT NULL
);
SELECT AgentID, AgtFirstName, AgtLastName
FROM Agents A
WHERE NOT EXISTS (
    SELECT 1
    FROM Engagements E
    WHERE A.AgentID = E.AgentID
);

-- 12
SELECT Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName
FROM Agents
LEFT JOIN Engagements ON Agents.AgentID = Engagements.AgentID
WHERE Engagements.AgentID IS NULL;

-- 13
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, LastBooking.MaxBookingDate
FROM Customers
LEFT JOIN (
    SELECT Engagements.CustomerID, MAX(Engagements.StartDate) AS MaxBookingDate
    FROM Engagements
    GROUP BY Engagements.CustomerID
) AS LastBooking ON Customers.CustomerID = LastBooking.CustomerID;

-- 14
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE Entertainers.EntertainerID IN (
    SELECT Engagements.EntertainerID
    FROM Engagements
    WHERE Engagements.CustomerID IN (
        SELECT Customers.CustomerID
        FROM Customers
        WHERE Customers.CustFirstName = 'Berg' OR Customers.CustLastName = 'Berg'
    )
);
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE EXISTS (
    SELECT 1
    FROM Engagements
    JOIN Customers ON Engagements.CustomerID = Customers.CustomerID
    WHERE Entertainers.EntertainerID = Engagements.EntertainerID 
      AND (Customers.CustFirstName = 'Berg' OR Customers.CustLastName = 'Berg')
);
-- 15
SELECT Distinct Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
JOIN Engagements ON Entertainers.EntertainerID = Engagements.EntertainerID
JOIN Customers ON Engagements.CustomerID = Customers.CustomerID
WHERE Customers.CustFirstName = 'Berg' OR Customers.CustLastName = 'Berg';

-- 16
SELECT EngagementNumber, ContractPrice
FROM Engagements
WHERE ContractPrice > (
    SELECT SUM(ContractPrice)
    FROM Engagements
    WHERE StartDate >= '2017-11-01' AND StartDate <= '2017-11-30'
);
-- 17
SELECT EngagementNumber, ContractPrice
FROM Engagements
WHERE StartDate = (
    SELECT MIN(StartDate)
    FROM Engagements
);
-- 18
SELECT SUM(ContractPrice) AS TotalValue
FROM Engagements
WHERE StartDate >= '2017-10-01' AND StartDate <= '2017-10-31';

-- 19
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
LEFT JOIN Engagements ON Customers.CustomerID = Engagements.CustomerID
WHERE Engagements.CustomerID IS NULL;

-- 20
SELECT CustomerID, CustFirstName, CustLastName
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Engagements
    WHERE CustomerID IS NOT NULL
);
SELECT CustomerID, CustFirstName, CustLastName
FROM Customers C
WHERE NOT EXISTS (
    SELECT 1
    FROM Engagements E
    WHERE C.CustomerID = E.CustomerID
);
-- 21
SELECT Entertainers.EntCity, COUNT(DISTINCT Entertainer_Styles.StyleID) AS NumberOfStyles
FROM Entertainers
JOIN Entertainer_Styles ON Entertainers.EntertainerID = Entertainer_Styles.EntertainerID
GROUP BY Entertainers.EntCity;
-- 22
SELECT Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName, SUM(Engagements.ContractPrice) AS TotalBusiness
FROM Agents
JOIN Engagements ON Agents.AgentID = Engagements.AgentID
WHERE Engagements.StartDate >= '2017-12-01' AND Engagements.StartDate <= '2017-12-31'
GROUP BY Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName
HAVING SUM(Engagements.ContractPrice) > 3000;

-- 23
SELECT E1.EntertainerID, COUNT(*) AS OverlappingBookings
FROM Engagements E1
JOIN Engagements E2 ON E1.EntertainerID = E2.EntertainerID AND E1.EngagementNumber != E2.EngagementNumber
WHERE (E1.StartDate < E2.EndDate AND E1.EndDate > E2.StartDate) OR 
      (E1.StartTime < E2.StopTime AND E1.StopTime > E2.StartTime)
GROUP BY E1.EntertainerID
HAVING COUNT(*) > 2;

-- 24
SELECT Agents.AgtFirstName, Agents.AgtLastName, SUM(Engagements.ContractPrice) AS TotalContractPrice, 
    SUM(Engagements.ContractPrice * CommissionRate) AS TotalCommission
FROM Agents
JOIN Engagements ON Agents.AgentID = Engagements.AgentID
GROUP BY Agents.AgtFirstName, Agents.AgtLastName
HAVING SUM(Engagements.ContractPrice * CommissionRate) > 1000;

-- 25
SELECT Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName
FROM Agents
WHERE NOT EXISTS (
    SELECT 1
    FROM Engagements
    JOIN Entertainer_Styles ON Engagements.EntertainerID = Entertainer_Styles.EntertainerID
    JOIN Musical_Styles ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
    WHERE Engagements.AgentID = Agents.AgentID
      AND Musical_Styles.StyleName IN ('Country', 'Country Rock')
);
-- 26
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE NOT EXISTS (
    SELECT 1
    FROM Engagements
    WHERE Entertainers.EntertainerID = Engagements.EntertainerID
      AND Engagements.StartDate BETWEEN DATE_SUB('2018-05-01', INTERVAL 90 DAY) AND '2018-05-01'
);

-- 27
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE EntertainerID IN (
    SELECT EntertainerID
    FROM Entertainer_Styles
    WHERE StyleID IN (
        SELECT StyleID
        FROM Musical_Styles
        WHERE StyleName IN ('Jazz', 'Rhythm and Blues', 'Salsa')
    )
);
SELECT DISTINCT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
JOIN Entertainer_Styles ON Entertainers.EntertainerID = Entertainer_Styles.EntertainerID
JOIN Musical_Styles ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
WHERE Musical_Styles.StyleName IN ('Jazz', 'Rhythm and Blues', 'Salsa');

-- 28
SELECT DISTINCT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID IN (
    SELECT Engagements.CustomerID
    FROM Engagements
    WHERE Engagements.EntertainerID IN (
        SELECT Entertainers.EntertainerID
        FROM Entertainers
        WHERE Entertainers.EntStageName IN ('Carol Peacock Trio', 'Caroline Coie Cuartet', 'Jazz Persuasion')
    )
);
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE EXISTS (
    SELECT 1
    FROM Engagements
    JOIN Entertainers ON Engagements.EntertainerID = Entertainers.EntertainerID
    WHERE Customers.CustomerID = Engagements.CustomerID
      AND Entertainers.EntStageName IN ('Carol Peacock Trio', 'Caroline Coie Cuartet', 'Jazz Persuasion')
);
SELECT DISTINCT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
JOIN (
    SELECT Engagements.CustomerID
    FROM Engagements
    JOIN Entertainers ON Engagements.EntertainerID = Entertainers.EntertainerID
    WHERE Entertainers.EntStageName IN ('Carol Peacock Trio', 'Caroline Coie Cuartet', 'Jazz Persuasion')
) AS RelevantEngagements ON Customers.CustomerID = RelevantEngagements.CustomerID;

-- 29
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, 
       Entertainers.EntertainerID, Entertainers.EntStageName
FROM Customers
JOIN Musical_Preferences ON Customers.CustomerID = Musical_Preferences.CustomerID
JOIN Entertainer_Styles ON Musical_Preferences.StyleID = Entertainer_Styles.StyleID
JOIN Entertainers ON Entertainer_Styles.EntertainerID = Entertainers.EntertainerID
GROUP BY Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, 
         Entertainers.EntertainerID, Entertainers.EntStageName
HAVING COUNT(DISTINCT Musical_Preferences.StyleID) = 
     (SELECT COUNT(DISTINCT StyleID) FROM Musical_Preferences WHERE CustomerID = Customers.CustomerID);
     
 -- 30
 SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
JOIN Entertainer_Styles ON Entertainers.EntertainerID = Entertainer_Styles.EntertainerID
JOIN Musical_Styles ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
LEFT JOIN Entertainer_Members ON Entertainers.EntertainerID = Entertainer_Members.EntertainerID
WHERE Musical_Styles.StyleName = 'Jazz'
GROUP BY Entertainers.EntertainerID, Entertainers.EntStageName
HAVING COUNT(Entertainer_Members.MemberID) > 3;

-- 31
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, 
       CASE 
           WHEN Musical_Styles.StyleName IN ('50’s', '60’s', '70’s', '80’s') THEN 'Oldies'
           ELSE Musical_Styles.StyleName
       END AS PreferredStyle
FROM Customers
JOIN Musical_Preferences ON Customers.CustomerID = Musical_Preferences.CustomerID
JOIN Musical_Styles ON Musical_Preferences.StyleID = Musical_Styles.StyleID;

-- 32
SELECT *
FROM Engagements
WHERE StartDate BETWEEN '2017-10-01' AND '2017-10-31'
  AND StartTime >= '12:00:00' AND StartTime <= '17:00:00';

-- 33
SELECT 
    Entertainers.EntertainerID, 
    Entertainers.EntStageName, 
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM Engagements 
            WHERE Engagements.EntertainerID = Entertainers.EntertainerID 
              AND Engagements.StartDate = '2017-12-25'
        ) THEN 'Booked on Christmas'
        ELSE 'Not Booked on Christmas'
    END AS ChristmasBookingStatus
FROM Entertainers;

-- 34
select a.CustomerID, a.CustFirstName, a.CustLastName
from(select cst.CustomerID, cst.CustFirstName, cst.CustLastName, 
			case when ms.StyleName = "Jazz" then 1 else 0 end as Jazz,
			case when cst.CustomerID in (select mp2.CustomerID from Musical_Preferences mp2 join Musical_Styles ms2 on mp2.StyleID = ms2.StyleID where ms2.StyleName = 'Standards') then 1 else 0 end Standard
	from Customers cst
	join Musical_Preferences mp on (cst.CustomerID = mp.CustomerID)
	join Musical_Styles ms on (mp.StyleID = ms.StyleID)
	where ms.StyleName = "Jazz") a
where a.Jazz = 1 and a.Standard = 0;
-- 35
select cst.CustomerID, concat(cst.CustFirstName," " ,cst.CustLastName) CustName, ms.StyleName, agg.NumPreferences
from Customers cst
join Musical_Preferences mp on (cst.CustomerID = mp.CustomerID)
join Musical_Styles ms on (mp.StyleID = ms.StyleID)
join(select cst1.CustomerID, count(distinct mp1.StyleID) NumPreferences from Customers cst1 join Musical_Preferences mp1 on (cst1.CustomerID = mp1.CustomerID) group by 1) agg on (cst.CustomerID = agg.CustomerID);
-- 36
with BASE as
(select cst.CustomerID, concat(cst.CustFirstName," " ,cst.CustLastName) CustName, ms.StyleName, agg.NumPreferences
from Customers cst
join Musical_Preferences mp on (cst.CustomerID = mp.CustomerID)
join Musical_Styles ms on (mp.StyleID = ms.StyleID)
join(select cst1.CustomerID, count(distinct mp1.StyleID) NumPreferences from Customers cst1 join Musical_Preferences mp1 on (cst1.CustomerID = mp1.CustomerID) group by 1) agg on (cst.CustomerID = agg.CustomerID)
)
select *, sum(NumPreferences) over (order by CustName) as RunningTotal
from BASE
;
-- 37
SELECT 
    Customers.CustCity AS CustomerCity,
    CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName) AS Customer,
    COUNT(Musical_Preferences.StyleID) AS NumberOfPreferences,
    SUM(COUNT(Musical_Preferences.StyleID)) OVER (PARTITION BY Customers.CustCity ORDER BY Customers.CustCity, CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName)) AS RunningTotalPreferences
FROM Customers
JOIN Musical_Preferences ON Customers.CustomerID = Musical_Preferences.CustomerID
GROUP BY Customers.CustCity, Customers.CustFirstName, Customers.CustLastName
ORDER BY Customers.CustCity, CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName);
-- 38
SELECT 
    ROW_NUMBER() OVER (ORDER BY CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName)) AS RowNum,
    Customers.CustomerID, 
    CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName) AS FullName, 
    Customers.CustState
FROM Customers
ORDER BY CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName);

-- 39
SELECT 
    ROW_NUMBER() OVER (PARTITION BY Customers.CustCity, Customers.CustState ORDER BY CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName)) AS RowNum,
    Customers.CustomerID, 
    CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName) AS FullName, 
    Customers.CustCity,
    Customers.CustState
FROM Customers
ORDER BY CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName);

-- 40
SELECT 
    Engagements.StartDate,
    CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName) AS CustomerName,
    Entertainers.EntStageName,
    ROW_NUMBER() OVER (ORDER BY Entertainers.EntStageName) AS EntertainerNumber,
    RANK() OVER (PARTITION BY Engagements.StartDate ORDER BY Engagements.StartDate, Entertainers.EntStageName) AS EngagementNumber
FROM Engagements
JOIN Customers ON Engagements.CustomerID = Customers.CustomerID
JOIN Entertainers ON Engagements.EntertainerID = Entertainers.EntertainerID
ORDER BY Engagements.StartDate, Entertainers.EntStageName;

-- 41
SELECT 
    Entertainers.EntertainerID,
    Entertainers.EntStageName,
    COUNT(Engagements.EntertainerID) AS NumberOfEngagements,
    NTILE(3) OVER (ORDER BY COUNT(Engagements.EntertainerID) DESC) AS EngagementBucket
FROM Entertainers
LEFT JOIN Engagements ON Entertainers.EntertainerID = Engagements.EntertainerID
GROUP BY Entertainers.EntertainerID, Entertainers.EntStageName
ORDER BY NumberOfEngagements DESC, Entertainers.EntStageName;
-- 42
SELECT 
    Agents.AgentID,
    Agents.AgtFirstName,
    Agents.AgtLastName,
    COALESCE(SUM(Engagements.ContractPrice), 0) AS TotalContractValue,
    RANK() OVER (ORDER BY COALESCE(SUM(Engagements.ContractPrice), 0) DESC) AS AgentRank
FROM Agents
LEFT JOIN Engagements ON Agents.AgentID = Engagements.AgentID
GROUP BY Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName
ORDER BY TotalContractValue DESC, Agents.AgtFirstName, Agents.AgtLastName;

-- 43
SELECT 
    Entertainers.EntStageName,
    CONCAT(Customers.CustFirstName, ' ', Customers.CustLastName) AS CustomerName,
    Engagements.StartDate,
    COUNT(Engagements.EntertainerID) OVER (PARTITION BY Entertainers.EntertainerID) AS TotalNumberOfEngagements
FROM Engagements
JOIN Entertainers ON Engagements.EntertainerID = Entertainers.EntertainerID
JOIN Customers ON Engagements.CustomerID = Customers.CustomerID
ORDER BY Entertainers.EntStageName, Engagements.StartDate;

-- 44
SELECT 
    Entertainers.EntStageName,
    CONCAT(Members.MbrFirstName, ' ', Members.MbrLastName) AS MemberName,
    ROW_NUMBER() OVER (PARTITION BY Entertainers.EntertainerID ORDER BY Members.MbrFirstName, Members.MbrLastName) AS MemberNumber
FROM Entertainers
JOIN Entertainer_Members ON Entertainers.EntertainerID = Entertainer_Members.EntertainerID
JOIN Members ON Entertainer_Members.MemberID = Members.MemberID
ORDER BY Entertainers.EntStageName, Members.MbrFirstName, Members.MbrLastName;

-- ACCOUNTS PAYABLE
select 
    COUNT(*) AS unpaid_invoice_count,
    SUM(invoice_total - payment_total - credit_total) AS total_amount_due
from invoices
where invoice_total > payment_total + credit_total;

select *
from vendors v
join invoices i on v.vendor_id = i.vendor_id
where v.vendor_state = 'CA';

select *
from invoices i
where i.vendor_id IN (
    select vendor_id 
    from vendors 
    where vendor_state = 'CA'
);

select *
from vendors v
LEFT join invoices i on v.vendor_id = i.vendor_id
where i.invoice_id is null;


select *
from vendors v
where v.vendor_id NOT IN (
    select distinct vendor_id 
    from invoices
);
select *
from vendors v
where NOT exists (
    select 1
    from invoices i
    where i.vendor_id = v.vendor_id
);


select *
from invoices
where (invoice_total - payment_total - credit_total) < (
    select AVG(invoice_total - payment_total - credit_total) 
    from invoices
);

select v.vendor_name, i.invoice_number, i.invoice_total
from invoices i
join vendors v on i.vendor_id = v.vendor_id
where i.invoice_total > (
    select MAX(invoice_total) 
    from invoices 
    where vendor_id = 34
);
select 
    v.vendor_name,
    i.invoice_number,
    i.invoice_total
from invoices i
join vendors v on i.vendor_id = v.vendor_id
where i.invoice_total > (
    select MAX_invoice_total 
    from (select MAX(invoice_total) AS MAX_invoice_total 
          from invoices 
          where vendor_id = 34) AS subquery
);

select v.vendor_name, i.invoice_number, i.invoice_total
from invoices i
join vendors v on i.vendor_id = v.vendor_id
where i.invoice_total < (
    select MAX(invoice_total) 
    from invoices 
    where vendor_id = 115
);
select v.vendor_name, i.invoice_number, i.invoice_total
from invoices i
join vendors v on i.vendor_id = v.vendor_id
join (
    select MAX(invoice_total) AS max_invoice_total
    from invoices 
    where vendor_id = 115
) AS subquery on i.invoice_total < subquery.max_invoice_total;

select (select vendor_name from vendors v where v.vendor_id = i.vendor_id) as vendor_name, i.invoice_date
from invoices i
where i.invoice_date = (select MAX(invoice_date)
						from invoices
						where vendor_id = i.vendor_id);
                        select v.vendor_name, i.invoice_date
from vendors v
join invoices i on v.vendor_id = i.vendor_id
left join invoices i2 on i.vendor_id = i2.vendor_id and i.invoice_date < i2.invoice_date
where i2.invoice_date is null;