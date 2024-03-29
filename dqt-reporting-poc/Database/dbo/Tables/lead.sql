CREATE TABLE [dbo].[lead] (
    [Id]                                 UNIQUEIDENTIFIER NOT NULL,
    [SinkCreatedOn]                      DATETIME         NULL,
    [SinkModifiedOn]                     DATETIME         NULL,
    [statecode]                          INT              NULL,
    [statuscode]                         INT              NULL,
    [budgetstatus]                       INT              NULL,
    [address1_shippingmethodcode]        INT              NULL,
    [msdyn_leadscoretrend]               INT              NULL,
    [dfeta_title]                        INT              NULL,
    [initialcommunication]               INT              NULL,
    [address2_shippingmethodcode]        INT              NULL,
    [salesstage]                         INT              NULL,
    [address1_addresstypecode]           INT              NULL,
    [msdyn_leadgrade]                    INT              NULL,
    [preferredcontactmethodcode]         INT              NULL,
    [leadqualitycode]                    INT              NULL,
    [leadsourcecode]                     INT              NULL,
    [industrycode]                       INT              NULL,
    [salesstagecode]                     INT              NULL,
    [dfeta_gender]                       INT              NULL,
    [msdyn_salesassignmentresult]        INT              NULL,
    [purchasetimeframe]                  INT              NULL,
    [address2_addresstypecode]           INT              NULL,
    [prioritycode]                       INT              NULL,
    [dfeta_route]                        INT              NULL,
    [purchaseprocess]                    INT              NULL,
    [need]                               INT              NULL,
    [donotpostalmail]                    BIT              NULL,
    [dfeta_overwriteduplicatedetection]  BIT              NULL,
    [confirminterest]                    BIT              NULL,
    [donotbulkemail]                     BIT              NULL,
    [donotfax]                           BIT              NULL,
    [evaluatefit]                        BIT              NULL,
    [isautocreate]                       BIT              NULL,
    [donotemail]                         BIT              NULL,
    [followemail]                        BIT              NULL,
    [participatesinworkflow]             BIT              NULL,
    [dfeta_sendnotificationemail]        BIT              NULL,
    [decisionmaker]                      BIT              NULL,
    [isprivate]                          BIT              NULL,
    [merged]                             BIT              NULL,
    [donotphone]                         BIT              NULL,
    [donotsendmm]                        BIT              NULL,
    [msdyn_gdproptout]                   BIT              NULL,
    [dfeta_diversity]                    BIT              NULL,
    [dfeta_anonymised]                   BIT              NULL,
    [contactid]                          UNIQUEIDENTIFIER NULL,
    [contactid_entitytype]               NVARCHAR (128)   NULL,
    [accountid]                          UNIQUEIDENTIFIER NULL,
    [accountid_entitytype]               NVARCHAR (128)   NULL,
    [dfeta_countryid]                    UNIQUEIDENTIFIER NULL,
    [dfeta_countryid_entitytype]         NVARCHAR (128)   NULL,
    [qualifyingopportunityid]            UNIQUEIDENTIFIER NULL,
    [qualifyingopportunityid_entitytype] NVARCHAR (128)   NULL,
    [masterid]                           UNIQUEIDENTIFIER NULL,
    [masterid_entitytype]                NVARCHAR (128)   NULL,
    [parentcontactid]                    UNIQUEIDENTIFIER NULL,
    [parentcontactid_entitytype]         NVARCHAR (128)   NULL,
    [owningbusinessunit]                 UNIQUEIDENTIFIER NULL,
    [owningbusinessunit_entitytype]      NVARCHAR (128)   NULL,
    [modifiedonbehalfby]                 UNIQUEIDENTIFIER NULL,
    [modifiedonbehalfby_entitytype]      NVARCHAR (128)   NULL,
    [slaid]                              UNIQUEIDENTIFIER NULL,
    [slaid_entitytype]                   NVARCHAR (128)   NULL,
    [owningteam]                         UNIQUEIDENTIFIER NULL,
    [owningteam_entitytype]              NVARCHAR (128)   NULL,
    [parentaccountid]                    UNIQUEIDENTIFIER NULL,
    [parentaccountid_entitytype]         NVARCHAR (128)   NULL,
    [createdonbehalfby]                  UNIQUEIDENTIFIER NULL,
    [createdonbehalfby_entitytype]       NVARCHAR (128)   NULL,
    [relatedobjectid]                    UNIQUEIDENTIFIER NULL,
    [relatedobjectid_entitytype]         NVARCHAR (128)   NULL,
    [dfeta_disabilityid]                 UNIQUEIDENTIFIER NULL,
    [dfeta_disabilityid_entitytype]      NVARCHAR (128)   NULL,
    [owninguser]                         UNIQUEIDENTIFIER NULL,
    [owninguser_entitytype]              NVARCHAR (128)   NULL,
    [createdby]                          UNIQUEIDENTIFIER NULL,
    [createdby_entitytype]               NVARCHAR (128)   NULL,
    [modifiedby]                         UNIQUEIDENTIFIER NULL,
    [modifiedby_entitytype]              NVARCHAR (128)   NULL,
    [msdyn_predictivescoreid]            UNIQUEIDENTIFIER NULL,
    [msdyn_predictivescoreid_entitytype] NVARCHAR (128)   NULL,
    [dfeta_ethnicityid]                  UNIQUEIDENTIFIER NULL,
    [dfeta_ethnicityid_entitytype]       NVARCHAR (128)   NULL,
    [slainvokedid]                       UNIQUEIDENTIFIER NULL,
    [slainvokedid_entitytype]            NVARCHAR (128)   NULL,
    [msdyn_segmentid]                    UNIQUEIDENTIFIER NULL,
    [msdyn_segmentid_entitytype]         NVARCHAR (128)   NULL,
    [transactioncurrencyid]              UNIQUEIDENTIFIER NULL,
    [transactioncurrencyid_entitytype]   NVARCHAR (128)   NULL,
    [campaignid]                         UNIQUEIDENTIFIER NULL,
    [campaignid_entitytype]              NVARCHAR (128)   NULL,
    [dfeta_mrapplicationid]              UNIQUEIDENTIFIER NULL,
    [dfeta_mrapplicationid_entitytype]   NVARCHAR (128)   NULL,
    [originatingcaseid]                  UNIQUEIDENTIFIER NULL,
    [originatingcaseid_entitytype]       NVARCHAR (128)   NULL,
    [dfeta_nationalityid]                UNIQUEIDENTIFIER NULL,
    [dfeta_nationalityid_entitytype]     NVARCHAR (128)   NULL,
    [ownerid]                            UNIQUEIDENTIFIER NULL,
    [ownerid_entitytype]                 NVARCHAR (128)   NULL,
    [customerid]                         UNIQUEIDENTIFIER NULL,
    [customerid_entitytype]              NVARCHAR (128)   NULL,
    [budgetamount_base]                  DECIMAL (38, 4)  NULL,
    [revenue]                            DECIMAL (38, 2)  NULL,
    [revenue_base]                       DECIMAL (38, 4)  NULL,
    [budgetamount]                       DECIMAL (38, 2)  NULL,
    [estimatedamount_base]               DECIMAL (38, 4)  NULL,
    [estimatedamount]                    DECIMAL (38, 2)  NULL,
    [emailaddress3]                      NVARCHAR (100)   NULL,
    [emailaddress2]                      NVARCHAR (100)   NULL,
    [emailaddress1]                      NVARCHAR (100)   NULL,
    [dfeta_ethnicityidname]              NVARCHAR (250)   NULL,
    [address1_city]                      NVARCHAR (80)    NULL,
    [address1_line1]                     NVARCHAR (250)   NULL,
    [modifiedon]                         DATETIME         NULL,
    [dfeta_dateofbirth]                  DATETIME         NULL,
    [yomifirstname]                      NVARCHAR (150)   NULL,
    [address1_longitude]                 DECIMAL (38, 5)  NULL,
    [yomifullname]                       NVARCHAR (450)   NULL,
    [entityimage_timestamp]              BIGINT           NULL,
    [contactidname]                      NVARCHAR (100)   NULL,
    [dfeta_countryidname]                NVARCHAR (250)   NULL,
    [address2_county]                    NVARCHAR (50)    NULL,
    [transactioncurrencyidname]          NVARCHAR (100)   NULL,
    [entityimage_url]                    NVARCHAR (200)   NULL,
    [dfeta_mrapplicationidname]          NVARCHAR (250)   NULL,
    [accountidname]                      NVARCHAR (100)   NULL,
    [relatedobjectidname]                NVARCHAR (200)   NULL,
    [campaignidname]                     NVARCHAR (100)   NULL,
    [businesscardattributes]             NVARCHAR (4000)  NULL,
    [masterleadidyominame]               NVARCHAR (100)   NULL,
    [address2_stateorprovince]           NVARCHAR (50)    NULL,
    [mobilephone]                        NVARCHAR (20)    NULL,
    [address2_country]                   NVARCHAR (80)    NULL,
    [address2_line2]                     NVARCHAR (250)   NULL,
    [qualifyingopportunityidname]        NVARCHAR (100)   NULL,
    [owneridyominame]                    NVARCHAR (100)   NULL,
    [msdyn_predictivescoreidname]        NVARCHAR (128)   NULL,
    [lastname]                           NVARCHAR (50)    NULL,
    [estimatedclosedate]                 DATETIME         NULL,
    [contactidyominame]                  NVARCHAR (100)   NULL,
    [parentaccountidname]                NVARCHAR (100)   NULL,
    [address1_utcoffset]                 INT              NULL,
    [numberofemployees]                  INT              NULL,
    [address1_telephone1]                NVARCHAR (50)    NULL,
    [parentaccountidyominame]            NVARCHAR (100)   NULL,
    [exchangerate]                       DECIMAL (38, 10) NULL,
    [telephone3]                         NVARCHAR (50)    NULL,
    [address2_city]                      NVARCHAR (80)    NULL,
    [companyname]                        NVARCHAR (100)   NULL,
    [address2_latitude]                  DECIMAL (38, 5)  NULL,
    [createdon]                          DATETIME         NULL,
    [createdbyyominame]                  NVARCHAR (100)   NULL,
    [timespentbymeonemailandmeetings]    NVARCHAR (1250)  NULL,
    [address1_composite]                 NVARCHAR (MAX)   NULL,
    [customeridyominame]                 NVARCHAR (450)   NULL,
    [parentcontactidname]                NVARCHAR (100)   NULL,
    [msdyn_scorehistory]                 NVARCHAR (MAX)   NULL,
    [qualificationcomments]              NVARCHAR (MAX)   NULL,
    [address2_postalcode]                NVARCHAR (20)    NULL,
    [customeridtype]                     NVARCHAR (4000)  NULL,
    [msdyn_segmentidname]                NVARCHAR (100)   NULL,
    [lastusedincampaign]                 DATETIME         NULL,
    [onholdtime]                         INT              NULL,
    [teamsfollowed]                      INT              NULL,
    [address2_line3]                     NVARCHAR (250)   NULL,
    [description]                        NVARCHAR (MAX)   NULL,
    [address1_country]                   NVARCHAR (80)    NULL,
    [timezoneruleversionnumber]          INT              NULL,
    [address1_county]                    NVARCHAR (50)    NULL,
    [owningbusinessunitname]             NVARCHAR (160)   NULL,
    [pager]                              NVARCHAR (20)    NULL,
    [address2_postofficebox]             NVARCHAR (20)    NULL,
    [address2_telephone1]                NVARCHAR (50)    NULL,
    [address2_telephone2]                NVARCHAR (50)    NULL,
    [address2_telephone3]                NVARCHAR (50)    NULL,
    [telephone1]                         NVARCHAR (50)    NULL,
    [address1_addressid]                 UNIQUEIDENTIFIER NULL,
    [traversedpath]                      NVARCHAR (1250)  NULL,
    [estimatedvalue]                     DECIMAL (38, 2)  NULL,
    [createdonbehalfbyname]              NVARCHAR (100)   NULL,
    [firstname]                          NVARCHAR (50)    NULL,
    [websiteurl]                         NVARCHAR (200)   NULL,
    [address2_name]                      NVARCHAR (100)   NULL,
    [schedulefollowup_qualify]           DATETIME         NULL,
    [owneridtype]                        NVARCHAR (4000)  NULL,
    [entityimageid]                      UNIQUEIDENTIFIER NULL,
    [owneridname]                        NVARCHAR (100)   NULL,
    [modifiedonbehalfbyname]             NVARCHAR (100)   NULL,
    [overriddencreatedon]                DATETIME         NULL,
    [address2_composite]                 NVARCHAR (MAX)   NULL,
    [address1_stateorprovince]           NVARCHAR (50)    NULL,
    [address1_line3]                     NVARCHAR (250)   NULL,
    [processid]                          UNIQUEIDENTIFIER NULL,
    [jobtitle]                           NVARCHAR (100)   NULL,
    [address1_telephone2]                NVARCHAR (50)    NULL,
    [address1_telephone3]                NVARCHAR (50)    NULL,
    [address1_postofficebox]             NVARCHAR (20)    NULL,
    [createdonbehalfbyyominame]          NVARCHAR (100)   NULL,
    [parentcontactidyominame]            NVARCHAR (100)   NULL,
    [dfeta_ninumber]                     NVARCHAR (9)     NULL,
    [slainvokedidname]                   NVARCHAR (100)   NULL,
    [fax]                                NVARCHAR (50)    NULL,
    [dfeta_applicantid]                  NVARCHAR (100)   NULL,
    [yomimiddlename]                     NVARCHAR (150)   NULL,
    [sic]                                NVARCHAR (20)    NULL,
    [address2_utcoffset]                 INT              NULL,
    [address2_fax]                       NVARCHAR (50)    NULL,
    [dfeta_disabilityidname]             NVARCHAR (250)   NULL,
    [subject]                            NVARCHAR (300)   NULL,
    [address2_longitude]                 DECIMAL (38, 5)  NULL,
    [originatingcaseidname]              NVARCHAR (100)   NULL,
    [createdbyname]                      NVARCHAR (100)   NULL,
    [modifiedbyyominame]                 NVARCHAR (100)   NULL,
    [lastonholdtime]                     DATETIME         NULL,
    [schedulefollowup_prospect]          DATETIME         NULL,
    [address1_line2]                     NVARCHAR (250)   NULL,
    [dfeta_previoussurname]              NVARCHAR (50)    NULL,
    [address2_upszone]                   NVARCHAR (4)     NULL,
    [msdyn_scorereasons]                 NVARCHAR (MAX)   NULL,
    [dfeta_nationalityidname]            NVARCHAR (250)   NULL,
    [salutation]                         NVARCHAR (100)   NULL,
    [address1_postalcode]                NVARCHAR (20)    NULL,
    [stageid]                            UNIQUEIDENTIFIER NULL,
    [utcconversiontimezonecode]          INT              NULL,
    [leadid]                             UNIQUEIDENTIFIER NULL,
    [address2_addressid]                 UNIQUEIDENTIFIER NULL,
    [businesscard]                       NVARCHAR (MAX)   NULL,
    [customeridname]                     NVARCHAR (160)   NULL,
    [importsequencenumber]               INT              NULL,
    [masterleadidname]                   NVARCHAR (100)   NULL,
    [telephone2]                         NVARCHAR (50)    NULL,
    [yomilastname]                       NVARCHAR (150)   NULL,
    [versionnumber]                      BIGINT           NULL,
    [middlename]                         NVARCHAR (50)    NULL,
    [address1_name]                      NVARCHAR (100)   NULL,
    [address1_fax]                       NVARCHAR (50)    NULL,
    [address1_latitude]                  DECIMAL (38, 5)  NULL,
    [yomicompanyname]                    NVARCHAR (100)   NULL,
    [msdyn_leadscore]                    INT              NULL,
    [modifiedbyname]                     NVARCHAR (100)   NULL,
    [address2_line1]                     NVARCHAR (250)   NULL,
    [address1_upszone]                   NVARCHAR (4)     NULL,
    [accountidyominame]                  NVARCHAR (100)   NULL,
    [modifiedonbehalfbyyominame]         NVARCHAR (100)   NULL,
    [slaname]                            NVARCHAR (100)   NULL,
    [fullname]                           NVARCHAR (160)   NULL,
    CONSTRAINT [EPK[dbo]].[lead]]] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO

CREATE NONCLUSTERED INDEX [nci_wi_lead_9C0B4141554D4171C21B58EAD4333B96]
    ON [dbo].[lead]([leadid] ASC, [dfeta_route] ASC, [statuscode] ASC)
    INCLUDE([dfeta_applicantid]);


GO

