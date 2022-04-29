CREATE FUNCTION [dbo].[fnGetStateValue]

(

       @EntityName NVARCHAR(64), --The Entity logical name that contains the Status field

       @Label NVARCHAR(256) --The state label to retrieve

)

RETURNS INT

AS

BEGIN

 

       return (select top 1 d.[State]

                       from [dbo].[StateMetadata] d with (nolock)

                     where d.[EntityName] = @EntityName

                        and d.[LocalizedLabel] = @Label

                        and d.[LocalizedLabelLanguageCode] = 1033)

END

GO

