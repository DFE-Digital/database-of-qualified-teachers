CREATE TABLE [dbo].[StatusMetadata] (
    [EntityName]                 NVARCHAR (50) NOT NULL,
    [State]                      TINYINT       NOT NULL,
    [Status]                     INT           NOT NULL,
    [IsUserLocalizedLabel]       TINYINT       NOT NULL,
    [LocalizedLabelLanguageCode] SMALLINT      NOT NULL,
    [LocalizedLabel]             NVARCHAR (50) NOT NULL
);


GO

