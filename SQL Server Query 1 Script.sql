-- Create the table
CREATE TABLE #TableValues(ID INT, Data INT);

-- Populate the table
INSERT INTO #TableValues(ID, Data)
VALUES(1,100),(2,100),(3,NULL),
(4,NULL),(5,600),(6,NULL),
(7,500),(8,1000),(9,1300),
(10,1200),(11,NULL);