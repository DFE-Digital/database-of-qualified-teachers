CREATE TABLE [dbo].[StateMetadata] (
    [EntityName]                 NVARCHAR (50) NOT NULL,
    [State]                      TINYINT       NOT NULL,
    [IsUserLocalizedLabel]       TINYINT       NOT NULL,
    [LocalizedLabelLanguageCode] SMALLINT      NOT NULL,
    [LocalizedLabel]             NVARCHAR (50) NOT NULL
);


GO

