CREATE   FUNCTION [dbo].[fnGetOptionSetLabel]
(
	@EntityName NVARCHAR(64), --The Entity logical name that contains the Option Set field
	@OptionSetName NVARCHAR(64), --The logical name of the Option Set field
	@Option INT --The option value to retrieve	
)
RETURNS NVARCHAR(256)
AS
BEGIN

	return (select top 1 d.[LocalizedLabel]
			 from [dbo].[OptionSetMetadata] d with (nolock)
			where d.[EntityName] = @EntityName
			  and d.[OptionSetName] = @OptionSetName
			  and d.[Option] = @Option
			  and d.[LocalizedLabelLanguageCode] = 1033)

END

GO

