-- Create the temp table
CREATE TABLE #Registrations(ID INT NOT NULL IDENTITY PRIMARY KEY,
	DateJoined DATE NOT NULL, DateLeft DATE NULL);

-- Variables
DECLARE @Rows INT = 10000, 
		@Years INT = 5, 
		@StartDate DATE = '2011-01-01'

-- Insert 10,000 rows with five years of possible dates
INSERT INTO #Registrations (DateJoined)
	SELECT TOP(@Rows) DATEADD(DAY,CAST(RAND(CHECKSUM(NEWID())) * @Years *
			365 as INT) ,@StartDate)
	FROM sys.objects a
		CROSS JOIN sys.objects b
		CROSS JOIN sys.objects c;

-- Give cancellation dates to 75% of the subscribers
UPDATE TOP(75) PERCENT #Registrations
	SET DateLeft = DATEADD(DAY,CAST(RAND(CHECKSUM(NEWID())) * @Years * 365
		as INT),DateJoined)