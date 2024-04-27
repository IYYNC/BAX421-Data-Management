-- BAX-421 Homework 2 Yi Yin (Ian) Chen
-- COLONIAL DATABASE
#Question 1
-- List the trip name of each trip that has the season Late Spring.
select TripName, Season
from Trip
where Season = 'Late Spring'
ORDER BY TripName;
#Question 2
-- List the trip name of each trip that is in the state of Vermont (VT) or that has a maximum group size greater than 10.
select TripName
from Trip
where State = 'VT'
union
select TripName
from Trip
where MaxGrpSize >10
ORDER BY TripName;
-- OR
select TripName
from Trip
where State = 'VT' or MaxGrpSize > 10
ORDER BY TripName;
#Question 3
-- List the trip name of each trip that has the season Early Fall or Late Fall.
select TripName, Season
from Trip
where Season LIKE '%Fall'
order by Season;
#Question 4
--  How many trips are in the states of Vermont (VT) or Connecticut (CT)?
select count(*)
from Trip
where State ='VT' or State = 'CT';
#Question 5
-- List the name of each trip that does not start in New Hampshire (NH).
select TripName
from Trip
where not State = 'NH'
order by TripName;
#Question 6
-- List the name and start location for each trip that has the type Biking.
select TripName, StartLocation
from Trip
where Type = 'Biking'
Order by TripName;
#Question 7
-- List the name of each trip that has the type Hiking and that has a distance of greater than six miles. Sort the results by the name of the trip.
select TripName
from Trip
where type='Hiking'
and Distance > 6
ORDER BY TripName;
#Question 8
-- List the name of each trip that has the type Paddling or that is located in Vermont (VT).
select TripName
from Trip
where type = 'Paddling' or State = 'VT'
ORDER BY TripName;
#Question 9
-- How many trips have a type of Hiking or Biking?
select count(*)
from Trip
where Type = 'Hiking' or Type = 'Biking';
#Question 10
-- List the trip name and state for each trip that occurs during the Summer season. Sort the results by trip name within state.
select TripName, State
from Trip
where Season = 'Summer'
ORDER BY State,TripName;
#Question 11
-- List the trip name of each trip that has Miles Abrams as a guide.
select t.TripName
from Trip t
INNER JOIN TripGuides tg
ON t.TripID=tg.TripID
INNER JOIN Guide g
ON g.GuideNum=tg.GuideNum
where g.LastName = 'Abrams'
and g.FirstName = 'Miles';
#Question 12
-- List the trip name of each trip that has the type Biking and that has Rita Boyers as a guide.
select t.TripName
from Trip t
INNER JOIN TripGuides tg
ON t.TripID=tg.TripID
INNER JOIN Guide g
ON g.GuideNum=tg.GuideNum
where g.LastName = 'Boyers'
and g.FirstName = 'Rita'
and t.Type = 'Biking';
#Question 13
-- For each reservation that has a trip date of July 23, 2018, list the customer’s last name, the trip name, and the start location.
select c.LastName, t.TripName, t.StartLocation
FROM Customer c
INNER JOIN Reservation r 
ON c.CustomerNum = r.CustomerNum
INNER JOIN Trip t
ON r.TripID = t. TripID
WHERE r.TripDate = '2018-07-23';
#Question 14
-- How many reservations have a trip price that is greater than $50.00 but less than $100.00?
select count(*)
from Reservation
where TripPrice > 50 and TripPrice < 100;
#Question 15
-- For each reservation with a trip price of greater than $100.00, list the customer’s last name, the trip name, and the trip type.
select c.LastName, t.TripName, t.Type
FROM Customer c
INNER JOIN Reservation r 
ON c.CustomerNum = r.CustomerNum
INNER JOIN Trip t
ON r.TripID = t. TripID
where r.TripPrice > 100;
#Question 16
-- List the last name of each customer who has a reservation for a trip in Maine (ME).
select c.LastName
FROM Customer c
INNER JOIN Reservation r 
ON c.CustomerNum = r.CustomerNum
INNER JOIN Trip t
ON r.TripID = t. TripID
where t.State = 'ME';
#Question 17
-- How many trips originate in each state? Order the results by the state.
select State, count(*)
from Trip
GROUP BY State
ORDER BY State;
#Question 18
-- List the reservation ID, customer last name, and the trip name for all reservations where the number of persons included in the reservation is greater than four.
select r.ReservationID, c.LastName, t.TripName
FROM Customer c
INNER JOIN Reservation r 
ON c.CustomerNum = r.CustomerNum
INNER JOIN Trip t
ON r.TripID = t. TripID
where r.NumPersons > 4;
#Question 19
-- List the trip name, the guide’s first name, and the guide’s last name for all trips that originate in New Hampshire (NH). Sort the results by guide’s last name within trip name.
select t.TripName, g.FirstName, g.LastName
from Trip t
INNER JOIN TripGuides tg
on t.TripID = tg.TripID
INNER JOIN Guide g
on tg.GuideNum=g.GuideNum
where t.State = 'NH'
ORDER BY t.TripName, g.LastName;
#Question 20
-- List the reservation ID, customer number, customer last name, and customer first name for all trips that occur in July 2018.
select r.ReservationID, c.CustomerNum, c.LastName, c.FirstName
from Customer c
INNER JOIN Reservation r
ON c.CustomerNum = r.CustomerNum
where r.TripDate between '2018-07-01' and '2018-07-31';
#Question 21
-- Colonial Adventure Tours calculates the total price of a trip by adding the trip price plus other fees and multiplying the result by the number of persons included in the reservation. List the reservation ID, trip name, customer’s last name, customer’s first name, and total cost for all reservations where the number of persons is greater than four. Use the column name TotalCost for the calculated field.
select r.ReservationID, t.TripName, c.LastName, c.FirstName, (r.TripPrice+r.OtherFees)*r.NumPersons as `TotalCost`
from Reservation r
INNER JOIN Customer c
ON r.CustomerNum = c.CustomerNum
Inner Join Trip t
ON r.TripID=t.TripID
WHERE r.NumPersons > 4;
#Question 22
-- List all customers whose first name starts with L or S. Sort the results by FirstName.
select FirstName, LastName
from Customer
where FirstName LIKE 'L%' or FirstName LIKE 'S%'
ORDER BY FirstName;
#Question 23
-- List all the trip names whose prices are between $30 and $50.
select t.TripName
from Trip t
INNER JOIN Reservation r
ON t.TripID=r.TripID
where r.TripPrice between 30 and 50;
#Question 24
-- Write a query to determine how many trips have prices between $30 and $50. (Please note that this question is different from number 23 above.)
select count(*)
from Trip t
INNER JOIN Reservation r
ON t.TripID=r.TripID
where r.TripPrice between 30 and 50;
#Question 25
-- Display the trip ID, trip name, and reservation ID for all trips that do not yet have the reservations.
select t.TripID, t.TripName, r.ReservationID
from Trip t
LEFT OUTER JOIN Reservation r
on t.TripID = r.TripID
where r.ReservationID IS NULL;
#Question 26
-- List the trip information for each pair of trips that have the same start location.
select f.*, s.*
from Trip f
INNER JOIN Trip s
on f.StartLocation = s.StartLocation
where f.TripID > s.TripID;
#Question 27
-- List information for each customer that either lives in the state of New Jersey (NJ), or that currently has a reservation, or both.
select *
from Customer c
where State = 'NJ'
union
select c.*
from Customer c
INNER JOIN Reservation r
on c.CustomerNum = r.CustomerNum
ORDER BY CustomerNum;
#Question 28
-- Display all guides who are not currently assigned to any trips.
select g.GuideNum, g.LastName, g.FirstName
from Guide g
LEFT OUTER JOIN TripGuides tg
on g.GuideNum = tg.GuideNum
where tg.TripID IS NULL;
#Question 29
-- Display the guide information for each pair of guides that come from the same state.
select f.*, s.*
from Guide f
INNER JOIN Guide s
on f.State = s.State
where f.GuideNum < s.GuideNum;
#Question 30
-- Display the guide information for each pair of guides that come from the same city.
select f.*, s.*
from Guide f
INNER JOIN Guide s
on f.City = s.City
where f.GuideNum < s.GuideNum;
-- ENTERTAINMENT AGENCY DATABASE
#Question 1
-- List the names and phone numbers of all our agents, and list them in last name/first name order.
select AgtLastName, AgtFirstName, AgtPhoneNumber
from Agents
ORDER BY AgtLastName, AgtFirstName;
#Question 2
-- List all engagements and their associated start dates. Sort the records by date in descending order and by engagement in ascending order.
select EngagementNumber, StartDate
from Engagements
ORDER BY StartDate DESC, EngagementNumber ASC;
#Question 3
-- Show the agent name, date hired, and the date of each agent’s first six-month performance review.
select AgtFirstName, AgtLastName, DateHired, Date_add(DateHired, Interval 6 MONTH) as `FirstPerformanceReview`
from Agents;
#Question 4
-- Create a list of all engagements that occurred during October 2017.
select EngagementNumber
from Engagements
where StartDate <= '2017-10-31' AND EndDate >= '2017-10-01';
#Question 5
-- List any engagements in October 2017 that start between noon and 5 p.m.
select EngagementNumber
from Engagements
where StartDate <= '2017-10-31' AND EndDate >= '2017-10-01'
and StartTime between '12:00:00' and '17:00:00';
#Question 6
-- List all the engagements that start and end on the same day.
Select EngagementNumber
from Engagements
where StartDate = EndDate;
#Question 7
-- Display agents and the engagement dates they booked, sorted by booking start date.
Select a.AgentID, a.AgtFirstName, a.AgtLastName, e.StartDate, e.EndDate
from Agents a
INNER JOIN Engagements e
on a.AgentID = e.AgentID
ORDER BY e.StartDate;
#Question 8
-- List customers and the entertainers they booked.
select DISTINCT c.CustomerID, c.CustFirstName, c.CustLastName, et.EntertainerID, et.EntStageName
from Customers c
INNER JOIN Engagements e
on c.CustomerID = e.CustomerID
INNER JOIN Entertainers et
on e.EntertainerID = et.EntertainerID
ORDER BY CustomerID;
#Question 9
-- Find the agents and entertainers who live in the same postal code.
select a.AgtFirstName, a.AgtLastName, e.EntStageName, a.AgtZipCode, e.EntZipCode
from Agents a
INNER JOIN Entertainers e
on a.AgtZipCode = e.EntZipCode
ORDER BY a.AgtZipCode DESC;
#Question 10
-- Display an alphabetical list of entertainers (Stage name, phone numbers, and city) based in Bellevue, Redmond, or Woodinville.
Select EntStageName, EntPhoneNumber, EntCity
from Entertainers
where EntCity IN ('Bellevue', 'Redmond', 'Woodinville')
ORDER BY EntStageName;
#Question 11
-- Display all the engagements that run for four days.
select EngagementNumber,StartDate,EndDate
from Engagements
where DATEDIFF(EndDate, StartDate) = 3;
#Question 12
-- Display the entertainers, the start and end dates of their contracts, and the contract price.
select et.EntStageName, e.StartDate, e.EndDate, e.ContractPrice
from Entertainers et
INNER JOIN Engagements e
on et.EntertainerID = e.EntertainerID
ORDER BY EntStageName;
#Question 13
-- Display the entertainers, the start and end dates of their contracts, and the contract price.
select et.EntStageName, e.StartDate, e.EndDate, e.ContractPrice
from Entertainers et
INNER JOIN Engagements e
on et.EntertainerID = e.EntertainerID
ORDER BY EntStageName;
#Question 14
-- Display all the entertainers who played engagements for customers Berg or Hallmark.
select DISTINCT et.EntStageName, c.CustFirstName, c.CustLastName
from Customers c
INNER JOIN Engagements e
on c.CustomerID = e.CustomerID
INNER JOIN Entertainers et
on e.EntertainerID = et.EntertainerID
where c.CustLastName IN ('Berg','Hallmark')
ORDER BY EntStageName;
#Question 15
-- Display agents and the engagement dates they booked, sorted by booking start date.
Select a.AgentID, a.AgtFirstName, a.AgtLastName, e.StartDate, e.EndDate
from Agents a
INNER JOIN Engagements e
on a.AgentID = e.AgentID
ORDER BY e.StartDate;
#Question 16
-- List customers and the entertainers they booked.
select DISTINCT c.CustomerID, c.CustFirstName, c.CustLastName, et.EntertainerID, et.EntStageName
from Customers c
INNER JOIN Engagements e
on c.CustomerID = e.CustomerID
INNER JOIN Entertainers et
on e.EntertainerID = et.EntertainerID
ORDER BY CustomerID;
#Question 17
-- List the agents and entertainers who live in the same postal code.
select a.AgtFirstName, a.AgtLastName, e.EntStageName, a.AgtZipCode, e.EntZipCode
from Agents a
INNER JOIN Entertainers e
on a.AgtZipCode = e.EntZipCode
ORDER BY a.AgtZipCode DESC;
#Question 18
-- List entertainers who have never been booked.
select et.EntStageName
from Entertainers et
LEFT OUTER JOIN Engagements e
on et.EntertainerID = e.EntertainerID
where e.EngagementNumber IS NULL;
#Question 19
-- Display all musical styles and the customers who prefer those styles. Include also styles not preferred by customers.
select m.StyleName, c.CustFirstName, c.CustLastName
from Musical_Styles m
LEFT OUTER JOIN Musical_Preferences mp
on m.StyleID=mp.StyleID
LEFT OUTER JOIN Customers c
on c.CustomerID = mp.CustomerID;
#Question 20
-- Display agents who have never booked an entertainer.
select a.AgtFirstName, a.AgtLastName
from Agents a
LEFT OUTER JOIN Engagements e
on a.AgentID=e.AgentID
where e.EngagementNumber IS NULL;
#Question 21
-- List customers with no bookings.
select c.CustFirstName, c.CustLastName
from Customers c
LEFT OUTER JOIN Engagements e
on c.CustomerID = e.CustomerID
where e.EngagementNumber IS NULL;
#Question 22
-- List all entertainers and any engagements they have booked.
select et.EntStageName, e.EngagementNumber, e.StartDate, e.EndDate
from Entertainers et
LEFT OUTER JOIN Engagements e
on et.EntertainerID = e.EntertainerID
ORDER BY et.EntStageName;
#Question 23
-- Display a complete list of customers and entertainers.
select CustFirstName as `FirstName`, CustLastName as `LastName`, 'Customer' as `Type`
from Customers
union all
select EntStageName, Null, 'Entertainer' as `Type`
from Entertainers;
#Question 24
-- Display a list of customers who like contemporary music together with a list of entertainers who play contemporary music.
select c.CustFirstName as `FirstName`, c.CustLastName as `LastName`, 'Customer' as `Type`, ms.StyleName as `Style`
from Customers c
INNER JOIN Musical_Preferences m
on c.CustomerID=m.CustomerID
INNER JOIN Musical_Styles ms
on m.StyleID=ms.StyleID
where ms.StyleName = 'Contemporary'
union all
select e.EntStageName, Null, 'Entertainer' as `Type`, ms.StyleName
from Entertainers e
INNER JOIN Entertainer_Styles es
on e.EntertainerID = es.EntertainerID
INNER JOIN Musical_Styles ms
on es.StyleID=ms.StyleID
where ms.StyleName = 'Contemporary';
#Question 25
-- Display a combined list of agents and entertainers.
select AgtFirstName as `FirstName`, AgtLastName as `LastName`, 'Agent' as `Type`
from Agents
union all
select EntStageName, Null, 'Entertainer' as `Type`
from Entertainers;
-- ACCOUNTS PAYABLE DATABASE
#Question 1
-- Select all data from the Invoices table.
select *
from invoices;
#Question 2
select invoice_number, invoice_date, invoice_total
from invoices
ORDER BY invoice_total DESC;
#Question 3
-- Display all invoices from the month of June.
select *
from invoices
-- where month(invoice_date) = 6
where invoice_date like '%-06-%';
#Question 4
-- Write a query to show all vendors. Then sort the result set by last name and then first name, both in ascending sequence.
select *
from vendors
ORDER BY vendor_contact_last_name ASC, vendor_contact_first_name ASC;
#Question 5
-- Write a query that returns vendor’s last name and first name. Sort the result set by last name and then first name in ascending sequence. Return only the contacts whose last name begins with the letter A, B, C, E.
select vendor_contact_last_name, vendor_contact_first_name
from vendors
where vendor_contact_last_name like 'A%' 
or vendor_contact_last_name like 'B%'
or vendor_contact_last_name like 'C%'
or vendor_contact_last_name like 'E%'
ORDER BY vendor_contact_last_name ASC, vendor_contact_first_name ASC;
#Question 6
-- Display the invoice due date and the invoice amounts increased by 10%. Return only the rows with an invoice total that is greater than or equal to 500 and less than or equal to 1000. Sort the result set in descending sequence by the invoice due date.
select invoice_due_date, invoice_total*1.1 as `1.1_invoice_total`
from invoices
where invoice_total between 500 and 1000
ORDER BY invoice_due_date DESC;
#Question 7
-- Write a query that displays the invoice number, invoice total, payment credit total, and balance due. Return only invoices that have a balance due greater that is than $50. Sort the result set by balance due in descending sequence. Limit the result set to show only the results with the 5 largest balances.
select invoice_number, invoice_total, payment_total, credit_total, (invoice_total-payment_total-credit_total) as `balacne_due`
from invoices
where (invoice_total-payment_total-credit_total) > 50
ORDER BY (invoice_total-payment_total-credit_total) DESC
LIMIT 5;
#Question 8
-- Display the invoices which have balance due.
select invoice_id, invoice_number, invoice_total, payment_total, credit_total, (invoice_total-payment_total-credit_total) as `balacne_due`
from invoices
where  (invoice_total-payment_total-credit_total) <> 0;
#Question 9
-- Display the names of the vendors who have balance due.
select distinct(v.vendor_name)
from vendors v
inner join invoices i
on v.vendor_id = i.vendor_id
where (i.invoice_total-i.payment_total-i.credit_total) <> 0;
#Question 10
-- Write a query to display information about the vendors and the default account description for each vendor.
select v.*, a.account_description
from vendors v
left join general_ledger_accounts a
on v.default_account_number = a.account_number;
#Question 11
-- Write a query to display all invoices for each vendor. So for example, if a vendor has 2 invoices, then display all line item information for both invoices. Just an example to give you an idea.
select v.vendor_name, i.*,il.*
from  vendors v
join invoices i 
on v.vendor_id=i.vendor_id
join invoice_line_items il
on i.invoice_id=il.invoice_id;
#Question 12
-- Write a query to return one row for each vendor whose contact has the same last name as another vendor’s contact.
select f.*
from vendors f
inner join vendors s
on f.vendor_contact_last_name=s.vendor_contact_last_name
where f.vendor_id <> s.vendor_id;
#Question 13
-- Write a query to return one row for each account number that has never been used. Sort the result set by Account Number.
select gla.account_number
from general_ledger_accounts gla
left join invoice_line_items il
on gla.account_number=il.account_number
where il.invoice_id is null
order by gla.account_number;
#Question 14
-- Generate the result set containing the following columns:
-- Vendor Name Vendor State
-- If the vendor is in California, the value in the Vendor State column should be “CA”; otherwise, the value should be “Outside CA.” Sort the final result set by Vendor Name.
select vendor_name as `Vendor Name`, if(vendor_state='CA','CA','Outside CA') as `Vendor State`
from vendors
ORDER BY `Vendor Name`;
-- PRESTIGE CARS DATABASE
#Question 1
-- Display the country name and the sales region for the countries in the database.
select CountryName, SalesRegion
from country;
#Questio 2
-- Create a complete list of every vehicle purchased and the amount paid (cost) to purchase it.
select s.StockCode, m.ModelName, s.Cost
from stock s
join model m
on s.ModelID=m.ModelID
ORDER BY s.StockCode;
#Question 3
-- The CEO of Prestige Cars needs to obtain a list of the countries where the company’s customers can be found. Write a query to display such a list of country names (not ISO codes.)
select distinct(c.CountryName)
from country c
join customer ct
on c.CountryISO2=ct.Country;
#Question 4
-- The CEO firmly believes that effective cost control is vital for the company’s survival. She wants a list of all the cars that have ever been bought since Prestige Cars started trading. Write a query to display a list of the purchase cost for every make and model ever held in stock.
select mk.MakeName, m.ModelName, sum(s.Cost) as `TotalCost`
from make mk
join model m on mk.MakeID = m.MakeID
join stock s on m.ModelID = s.ModelID
Group by mk.MakeName, m.ModelName;
#Question 5
-- The CEO has requested a list of all vehicles sold along with the selling price and any discounts that have been applied. Write a query to generate such a list.
select st.StockCode, m.ModelName, s.SalePrice as `Selling Price`, if( s.LineItemDiscount is null, 0,s.LineItemDiscount) as `Discounts Applied`
from salesdetails s
join stock st on s.StockID=st.StockCode
join model m on st.ModelID=m.ModelID;
#Question 6
-- The IT director is convinced that the database needs some cleanup. He is certain that there are makes of vehicles stored in the Make table for which there are no corresponding models. Write a query to generate a list of such makes of vehicles with no corresponding models.
select m.MakeID, m.MakeName
from make m
left join model mm
on m.MakeID=mm.MakeID
where mm.ModelID is null;
#Question 7
-- The CEO has requested a quick list of staff so that she can produce an org chart for the next board meeting. There is a table named Staff in the database. Use this table to create a report of all staff members, their department, and their manager’s name.
select f.StaffID, f.StaffName, f.Department, s.StaffName as `Manager's Name`
from staff f 
left join staff s on f.ManagerID=s.StaffID;
#Question 8
-- The SalesCategory table in the database is a small table that contains the reference information that allows the sales manager to categorize each car sold according to the sale price. The sales manager wants to use the data in this table to display the specific sales category of each vehicle sold. Your result set should include the make, model, sale price, and the category description of each vehiccle sold. Write a query to generate such a list.
select m.MakeName, mm.ModelName,sd.SalePrice, 'Very Low' as `CategoryDescription`
from make m 
join model mm on m.MakeID = mm.MakeID
join stock s on s.ModelID = mm.ModelID
join salesdetails sd on s.StockCode=sd.StockID
where sd.SalePrice between 10000 and 25000
union all
select m.MakeName, mm.ModelName,sd.SalePrice, 'Low' as `CategoryDescription`
from make m 
join model mm on m.MakeID = mm.MakeID
join stock s on s.ModelID = mm.ModelID
join salesdetails sd on s.StockCode=sd.StockID
where sd.SalePrice between 25001 and 50000
union all
select m.MakeName, mm.ModelName,sd.SalePrice, 'Medium' as `CategoryDescription`
from make m 
join model mm on m.MakeID = mm.MakeID
join stock s on s.ModelID = mm.ModelID
join salesdetails sd on s.StockCode=sd.StockID
where sd.SalePrice between 50001 and 75000
union all
select m.MakeName, mm.ModelName,sd.SalePrice, 'High' as `CategoryDescription`
from make m 
join model mm on m.MakeID = mm.MakeID
join stock s on s.ModelID = mm.ModelID
join salesdetails sd on s.StockCode=sd.StockID
where sd.SalePrice between 75001 and 100000
union all
select m.MakeName, mm.ModelName,sd.SalePrice, 'Very High' as `CategoryDescription`
from make m 
join model mm on m.MakeID = mm.MakeID
join stock s on s.ModelID = mm.ModelID
join salesdetails sd on s.StockCode=sd.StockID
where sd.SalePrice between 100001 and 150000
union all
select m.MakeName, mm.ModelName,sd.SalePrice, 'Exceptional' as `CategoryDescription`
from make m 
join model mm on m.MakeID = mm.MakeID
join stock s on s.ModelID = mm.ModelID
join salesdetails sd on s.StockCode=sd.StockID
where sd.SalePrice between 150001 and 250000;
#Question 9
-- The CEO wants a list of all countries that Prestige Cars sells to, with a list of all makes that the company has ever stocked. When you ask for more details, she says that she also wants to see every make appear for every country because this allows her to galvanize the sales teams to sell every make in every country. Write a query to generate such a list.
select m.MakeName, c.CountryName
from make m cross join country c;
#Question 10
-- The finance director needs to know the makes and models the company has bought and stocked. Write a query to generate a list.
select Distinct m.MakeName, md.ModelName
from make m
join model md on m.MakeID=md.MakeID
join stock s on md.ModelID=s.ModelID;
#Question 11
-- The CEO wants a list of all models that Prestige Cars has ever sold and when they were sold. Write a query to create such a list.
select m.ModelName, s.SaleDate
from model m
join stock st on m.ModelID=st.ModelID
join salesdetails sd on st.StockCode = sd.StockID
join sales s on sd.SalesID=s.SalesID;
#Question 12
-- A new marketing director has just arrived at Prestige Cars. The first thing that she wants to know is how the color of cars varies by model purchased. She wants a report displaying all the models Prestige Cars has had in stock in red, green, or blue. Write a query to generate this list.
select m.ModelName, st.Color
from model m
join stock st on m.ModelID=st.ModelID
where st.Color in ('Red', 'Green', 'Blue')
GROUP BY m.ModelName, st.Color
ORDER BY m.ModelName;
#Question 13
-- The marketing director wants a list of all makes that were ever sold except Ferrari. Write a query to create this list.
select m.MakeName
from make m
join model md on m.makeid=md.makeid
join stock st on md.modelid=st.modelid
join salesdetails sd on st.stockcode=sd.stockid
where not m.MakeName = 'Ferrari'
group by m.MakeName
order by m.MakeName;
#Question 14
-- The marketing director wants a list of all makes that were ever sold except Porsche, Aston Martin, and Bentley. Write a query to create this list.
select m.MakeName
from make m
join model md on m.makeid=md.makeid
join stock st on md.modelid=st.modelid
join salesdetails sd on st.stockcode=sd.stockid
where m.MakeName not in ('Aston Martin', 'Porsche', 'Bentley')
group by m.MakeName
order by m.MakeName;
#Question 15
-- The finance director would like to get an idea of the higher-value cars that are in stock or have been sold; more specifically, he wants to see a list of all cars where the purchase price was over £50,000.00. Write a query to generate this list.
SELECT st.stockcode, mk.MakeName, md.ModelName, st.Cost AS Price
from stock st
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
WHERE st.Cost > 50000;
#Question 16
-- The CEO asked for a list of all makes of car that Prestige Cars has stocked where the parts cost is between £1,000 and £2,000. Write a query to generate this list.
SELECT mk.makename
from stock st
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
where st.partscost between 1000 and 2000
group by mk.makename
order by mk.makename;
#Question 17
-- Write a query to display the names of all make and models of the right-hand drive (RHD) models that Prestige Cars has sold.
SELECT mk.makename, md.modelname
from stock st
JOIN model md ON st.ModelID = md.ModelID
JOIN make mk ON md.MakeID = mk.MakeID
join salesdetails as sd on st.stockcode = sd.stockid
where st.IsRHD = 1
group by mk.makename,md.modelname;
#Question 18
-- Write a query to list all makes except Bentleys where the cars are red, green, or blue.
select distinct mk.makename
from stock st
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
where st.Color in ('Red','Green','Blue')
and mk.makename <> 'Bentely';
#Question 19
-- The finance director has requested a list of all red cars ever bought where their repair cost or the cost of spare parts exceeds £1,000.00. Write a query to create this list.
select st.StockCode,mk.makename,md.ModelName, st.Color, st.RepairsCost, st.PartsCost
from stock st
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
where st.Color = 'Red'
and (st.RepairsCost > 1000 or st.PartsCost > 1000);
#Question 20
-- The finance director says: “I want to see all red, green, and blue Rolls-Royce Phantoms - or failing that any vehicle where both the parts cost and the repair cost are over £5,500.00.” Write a query to create this list.
select mk.makename, md.modelname, st.repairscost, st.partscost
from stock st
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
where (mk.MakeName = 'Rolls Royce' and md.modelname = 'Phantom' and st.color in ('Red','Green', 'Blue'))
or (st.repairscost > 5500 and st.partscost > 5500);
#Question 21
-- Write a query to return the row containing the “Dark purple” vehicle. Note the case for the color. The correct query should return only one row. Hint: You can use the keyword BINARY (not the data type.)
select st.stockcode, mk.makename, md.modelname, st.color
from stock st
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
where binary st.color = 'Dark purple';
#Question 22
-- You have developed an excellent reputation as a data analyst at Prestige Cars. The receptionist comes to you with a request for help. She knows that Prestige Cars has a customer with Peter (or was that Pete?) somewhere in the name, and you need to find this person in the database. Create a list of all such names by using an SQL query.
Select CustomerName
from customer
where CustomerName like '%Pete%';
#Question 23
-- Write a query to return all makes of the cars with capital ”L” in the name of the marque. The correct query should not return models with lowercase ”l” anywhere in the name. For example, Alfa Romeo or Bentley should not be returned. The correct query should return three rows only.
select makename
from make
where makename like binary 'L%'
or makename like binary '%L%';
#Question 24
-- The finance director informs you that the invoice number field is structured in such a way that you can identify the country of sale from certain characters at a specific point in the field. He wants you to use this to isolate all sales made to French customers showing the model and the invoice number for each sale made. The correct query should return 68 rows.
-- Here is an example of the breakdown of the InvoiceNumber field. GBPGB001
-- Left three characters indicate the currency of sale, in this case GBP. Characters 4 and 5 indicate the destination country, in this case Great Britain. The last three characters provide a sequential invoice number.
-- So, the invoice number GBPGB001 tells you that this sale was made in pounds sterling to a client in the United Kingdom — and is invoice No 001.
select  distinct s.InvoiceNumber,mk.makename, md.modelname
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
where s.invoicenumber like '%FR%';
#Question 25
-- The marketing director has noticed that the corporate database is missing postalcodes (ZIP codes) for some clients. She has asked for a list of all customers without this vital piece of information. Write a query and create the list for the marketing director.
select customerid, customername,postcode
from customer
where postcode is null
order by customerid;
#Question 26
-- The finance director cannot find a spreadsheet that tells him what the exact cost of every car sold is, including the purchase cost along with any repairs, parts, and transport costs. This is called the cost of sales. Using an SQL query display the make name, model name, and the total cost of every car sold.
select st.stockcode,mk.makename,md.modelname,(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost) as `cost of sales`
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID;
#Question 27
-- The finance director is pleased with your cost analysis from question 26 above. He now wants you to calculate the net margin. Write a query to display the make name, model name, and the net margin.
select mk.makename,md.modelname,(sd.saleprice-(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost)) as `Net Margin`
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID;
#Question 28
-- The finance director is getting more and more excited at the thought that SQL can address every question he needs for his analysis. He now wants you to give him a list containing the ratio of cost to sales. Write an SQL query to provide this information to the finance director.
select st.stockcode,mk.makename,md.modelname,(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost)/sd.saleprice as `cost to sales`
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID;
#Question 29
-- Imagine that the sales director wants to test the improvement in margins if you increased the sale prices by 5 percent but kept costs the same. Using SQL, display the make name, the model name, and the improved sales margins.
select mk.makename,md.modelname,((1.05*sd.saleprice)-(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost)) as `Improved Sales Margins`
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID;
#Question 30
-- Write a SQL query to display the make names of the models which represent 50 most profitable sales in percentage terms. Arrange your list in descending order.
select mk.makename,md.modelname,((sd.saleprice-(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost))/sd.saleprice)*100 as `Net Margin percentage`
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
order by `Net Margin percentage` DESC
LIMIT 50;
#Question 31
-- The CEO of Prestige Cars Ltd. wants to know what the net profit is on sales. She particularly wants to see a list of sales for all vehicles making a profit of more than £5,000.00. Write a query to display this list. The correct query will return 178 rows.
select distinct s.SalesID
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
where ((sd.saleprice-(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost)))>5000;
#Question 32
-- It is late in the day, and you are thinking of heading home. Just as your eyes drift toward your lunch bag, in rushes the sales director with a request to list all car makes and models sold where the profit exceeds £5,000.00 and the car is red and the discount greater than or equal to £1,000.00 — or both the parts cost and the repairs cost are greater than £500.00. Write a query to generate this list. The correct query will return 63 rows.
select distinct mk.Makename,md.modelname
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
where (((sd.saleprice-(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost)))>5000 and st.color = 'RED' and sd.lineitemdiscount >= 1000)
or (st.repairscost > 500 and st.partscost > 500);
#Question 33
-- The finance director has tasked you to calculate the aggregate sales, cost, and gross profit for all vehicles sold. Write an SQL query to provide this summary.
select sum(sd.saleprice) as `Aggregate Sales`, sum(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost) as `Aggregate cost`, sum((sd.saleprice-(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost))) as `Aggregate Profit`
from sales s
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode;
#Question 34
-- The sales manager has emailed you with a request to calculate the aggregate cost for each model of car. Write an SQL query to provide this list to the sales manager.
select md.modelname, sum(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost) as `Aggregate cost`
from stock st
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
group by md.modelname;
#Question 35
-- The finance director wants you to dig deeper into the data and calculate the total purchase cost for every make and model of vehicle bought. Write an SQL query for generating this result.
select mk.makename,md.modelname, sum(st.cost) as `Total Purchase cost`
from stock st
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
group by mk.makename, md.modelname;
#Question 36
-- An essential business metric is the average cost of goods bought. The finance director would want to see the average purchase price of every make and model of car ever bought. Write an SQL query to generate this list.
select mk.makename,md.modelname, avg(st.cost) as `Average Purchase cost`
from stock st
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
group by mk.makename, md.modelname;
#Question 37
-- The CEO has stated categorically that any business must be able to see at a glance how many items have been sold per product category. In the case of Prestige Cars Ltd., visualizing (not using Tableau) the number of cars sold by make and model. Write an SQL query to generate this list.
select mk.makename,md.modelname,count(*) as `Number of cars sold`
from salesdetails sd
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
group by mk.makename, md.modelname;
#Question 38
-- The sales director asked for the number of different countries that Prestige Cars has ever sold vehicles to. Write an SQL query to answer this question.
select COUNT(DISTINCT c.Country) AS `NumberOfCountries`
from sales s
JOIN customer c ON s.CustomerID = c.CustomerID;
#Question 39
-- The sales manager wants you to identify the largest and smallest sale prices for each model of car sold. Write an SQL query to generate this list. The list should contain the model name, the top sale price, and the bottom sale price for each model.
select md.modelname, max(sd.saleprice) as `top sale price`, min(sd.saleprice) as `bottom sale price`
from salesdetails sd
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
group by md.modelname;
#Question 40
-- The sales director asks you ”How many red cars have been sold for each make of the car?” Write an SQL query to create a list in response to the question. The correct query should return 13 rows.
select mk.Makename, count(st.color) as `number of red cars sold`
from salesdetails sd
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
where st.color = 'Red'
group by mk.makename;
#Question 41
-- As part of the company’s worldwide sales drive, the sales director wants to focus Prestige Cars’ marketing energies on the countries where you are making the most sales. Show the data for countries where more than 50 cars have been sold. The correct query should return only 2 rows.
select c.countryname, count(*)
from country c 
join customer cc on c.CountryISO2=cc.Country
join sales s on cc.CustomerID = s.CustomerID
join salesdetails sd on s.salesid=sd.salesid
group by c.countryname
having count(*) > 50;
#Question 42
-- The sales director wants to know who are the clients who have not only bought at least three cars but where each of the three vehicles generated a profit of at least £5,000.00. Write an SQL query to generate a list of such customers and the number of cars sold to such customers. The correct query should return 27 rows.
select c.customername, count(*)
from customer c
join sales s on c.CustomerID = s.CustomerID
join salesdetails sd on s.salesid=sd.salesid
join stock st on sd.stockid=st.stockcode
where sd.saleprice-(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost)>=5000
group by c.customername
having count(*)>=3;
#Question 43
-- The CEO wants to see what drives the company’s bottom line. To this end, she wants to isolate the three most lucrative makes sold so that she can focus sales efforts around those brands. Write an SQL query to identify these three most lucrative makes.
select mk.Makename, sum((sd.saleprice-(st.cost+st.Repairscost+if(st.partscost is null,0,st.partscost)+st.Transportincost))) as `Total Profit`
from salesdetails sd
join stock st on sd.stockid=st.stockcode
join model md on st.modelID = md.ModelID
join make mk on md.MakeID=mk.MakeID
group by mk.makename
order by `Total Profit` Desc
LIMIT 3;

