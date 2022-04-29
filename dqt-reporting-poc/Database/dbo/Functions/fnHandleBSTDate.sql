

--Create Function to return Global Option Set Labels

CREATE FUNCTION [dbo].[fnHandleBSTDate]
(
	@UTCDate DateTime --The logical name of the Global Option Set	
)
RETURNS DateTime
AS
BEGIN

	RETURN DATEADD(MINUTE, DATEPART(tz, @UTCDate AT TIME ZONE 'GMT Standard Time'), @UTCDate)

END

GO

