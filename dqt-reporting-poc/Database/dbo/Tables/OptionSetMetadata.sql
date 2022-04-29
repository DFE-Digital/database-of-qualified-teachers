CREATE TABLE [dbo].[OptionSetMetadata] (
    [EntityName]                 NVARCHAR (50)  NOT NULL,
    [OptionSetName]              NVARCHAR (50)  NOT NULL,
    [Option]                     INT            NOT NULL,
    [IsUserLocalizedLabel]       TINYINT        NOT NULL,
    [LocalizedLabelLanguageCode] SMALLINT       NOT NULL,
    [LocalizedLabel]             NVARCHAR (100) NOT NULL
);


GO

