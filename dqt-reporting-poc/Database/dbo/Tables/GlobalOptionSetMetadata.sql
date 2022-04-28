CREATE TABLE [dbo].[GlobalOptionSetMetadata] (
    [OptionSetName]              NVARCHAR (50)  NOT NULL,
    [Option]                     INT            NOT NULL,
    [IsUserLocalizedLabel]       TINYINT        NOT NULL,
    [LocalizedLabelLanguageCode] SMALLINT       NOT NULL,
    [LocalizedLabel]             NVARCHAR (300) NOT NULL,
    [GlobalOptionSetName]        NVARCHAR (1)   NULL
);


GO

