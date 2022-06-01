workspace "TRA" "TRA TQ Unit Deployment Architecture" {
    ## *************************************************************************************************************************************************************
    ## To install structurizr see: https://structurizr.com/help/getting-started
    ## docker run -it --rm -p 8080:8080 -v [PATH TO workspace.dsl]:/usr/local/structurizr structurizr/lite
    ## *******************************************************************
    ## ******************************************************************* PRODUCTION ENV VIEW *******************************************************************************
    ##  NON - SENSITIVE

    model {
        
          

        dqt = softwaresystem "DQT" "Allows Teacher Regulation Agency to regulate teaching profession" "Collection of various technologies" {
            webApplication = container "Web Application" "Allows Teachers, Employers to access TRA services via portals" ".Net 4, SQL/SSIS"
            ssisstagedb = container "D365 Extract Database" "Stores D365 data extracts (schedule update hourly)" "sqlsrv-t1pr-dynamicscrmexports.database.windows.net" "SQLServer 12.0.2000.8"
            usrcontainer = container "users"
            
        }
        
       

        prod = deploymentEnvironment "Prod" {
            
            deploymentNode "Users" "" "" "" {
                            #usrcontainer1 = containerInstance usrcontainer  
                            internaldfeusers = infrastructureNode "Internal DfE Users" "Services hosted within Corporate Network" "" ""
                            crmusers = infrastructureNode "D365 CRM Users" "DQT CRM (MS SAAS hosted on the internet)" " " "https"
                            legacyportalusers = infrastructureNode "DQT Portals https://teacherservices.education.gov.uk" "DQT Legacy Service Portals" "https" " "
                            dfeservices = infrastructureNode "DfE Service Integration (API)" "Register for ITT, CPD, Apply For Teacher Training" "REST API" "https"
                            externalfileintegrationusers = infrastructureNode "External Bodies (File Integration)" "SFTP" "" ""
                            digitalservicesusers = infrastructureNode "TRA Digital Services" "Find-a-lost-trn" "" "https"
                        }

            deploymentNode "On Premise Network" "" "" "Microsoft Azure - Virtual Networks (Classic)" {
                expressroute = infrastructureNode "Express Route" "" "" "Microsoft Azure - ExpressRoute Circuits"
                powerBi = infrastructureNode "Power BI Reports​" "Collection of Power BI reports over CRM Export Database" "" "Microsoft Azure - Cloud Services (Classic)"
                sqlsvrmt18 = infrastructureNode "SQL Server Management Tools v2018​" "Locally installed SQL Server MAnagement Tools 2018" "" "Microsoft Azure - Cloud Services (Classic)"
                sqlsvrmt16 = infrastructureNode "SQL Server Management Tools​ v2016" "Locally installed SQL Server MAnagement Tools 2016" "" "Microsoft Azure - Cloud Services (Classic)"
                 
            }
           
            deploymentNode "DfE Sign In" "" "" "Secure Access Web Site" {
                dfesign = infrastructureNode "Dfe Sign" "" "OrganisationIDAM" "Microsoft Azure - Web Environment"
                 
            }

            
           
            deploymentNode "GovPaas" "" "" "Amazon Web Services - CloudFront" {
                dqtapipostgres = infrastructureNode "DQT API DB" "" "" "Amazon Web Services - RDS PostgreSQL instance"
                dqtapi = infrastructureNode "Qualified Teachers API .Net Core ASP.Net Application" "" "" "Amazon Web Services - EC2"
                findtrn = infrastructureNode "Find a lost TRN Service" "Ruby on Rails Web Application" " https://find-a-lost-trn.education.gov.uk" "Amazon Web Services - CloudFront"
                findtrndb = infrastructureNode "Find a lost TRN Database" "Postgres" "Local database" "Amazon Web Services - RDS PostgreSQL instance"
                traroute53 = infrastructureNode "AWS Route53 education.gov.uk" "DNS Zone" "AWS Issued Cert" "Amazon Web Services - EC2"
                tracloudfront = infrastructureNode "Cloudfront" "" "" "Amazon Web Services - EC2"
                cdnroute = infrastructureNode "CDN Route" "[service-name]-cdn-production" "" "Amazon Web Services - EC2"
                
            }

            deploymentNode "D365" "" "" "Microsoft Azure - Virtual Networks (Classic)" {
                dqtd365 = infrastructureNode "DQT Prod	​​https://ent-dqt-prod.crm4.dynamics.com/		O365 CRM ENT-DQT-PROD​" "DQT CRM SAAS" "" "Microsoft Azure - Cloud Services (Classic)"
                dataexportservice = infrastructureNode "Microsoft Azure - Azure Database Migration Services"
            }

            
            deploymentNode "Microsoft Azure DfE Tennancy" "Subscription T1" "" "Microsoft Azure - Virtual Networks" {
                
                greenzone = deploymentNode "Production Green Zone Vnet:  AD.HQ.DEPT" "" "" "Microsoft Azure - Azure Active Directory"{
                    
                        crmtelemetry = infrastructureNode "CRM telemetry Application Insights" "" "" "Microsoft Azure - Application Insights"
                        webservicestelemetry = infrastructureNode "Web Service telemetry Application Insights" "" "" "Microsoft Azure - Application Insights"
                        integrationtelemetry = infrastructureNode "Integration telemetry Application Insights" "" "" "Microsoft Azure - Application Insights"
                        ssisrepbuilder = infrastructureNode "SQL Report Builder VMT1PR-DQT-SQL2" "Windows Server 2016, Subnet snet-t-t1pr-data" "" "Microsoft Azure - SSIS Lift And Shift IR"

                    }

                redzone = deploymentNode "Production Red Zone VNet" "VNet" "T1 Subscription" "Microsoft Azure "{
                        baracudafwruleset = infrastructureNode "Barracuda (NF) Firewall Rules" "" "" "Microsoft Azure - Web Application Firewall Policies(WAF)"
                        # apploadbalancer = infrastructureNode "ALB (Application Load Balancer)" "SHARED Load Balancer" "" "Microsoft Azure - Load Balancers"
                        checkpointfw1 = infrastructureNode "Palo Alto Firewall 1" "Firewall" "" "Microsoft Azure - Firewalls"
                        checkpointfw2 = infrastructureNode "Palo Alto Firewall 2" "Firewall" "" "Microsoft Azure - Firewalls"
                        checkpointfwuleset = infrastructureNode "Palo Alto Firewall Rules" "WAF Policies" "" "Microsoft Azure - Web Application Firewall Policies(WAF)"
                        waf1 = infrastructureNode "Baracuda WAF 1" "Firewall" "" "Microsoft Azure - Firewalls"
                        waf2 = infrastructureNode "Baracuda WAF 2" "Firewall" "" "Microsoft Azure - Firewalls"
                        wafwuleset = infrastructureNode "WAF Firewall Rules" "" "" "Microsoft Azure - Web Application Firewall Policies(WAF)"
                        azurepublicip = infrastructureNode "Azure Public IP" "40.68.254.32" "" "Microsoft Azure - Firewalls"
                        azureexternallb = infrastructureNode "Azure External Load Balancer" "Balances Palo Alto FW's" "" "Microsoft Azure - Firewalls"
                        azureinternallb = infrastructureNode "Azure Internal Load Balancer" "Balances Baracuda WAF's" "" "Microsoft Azure - Firewalls"

                        deploymentNode "AzureSQL PAAS" "Azure SQL PAAS" "Shared PAAS (other DB's outside of DQT)" "Microsoft Azure - Azure SQL" {
                                extractdatabaseInstance = containerInstance ssisstagedb
                            }

                         sftpserver = infrastructureNode "DQT SFTP Server VMT1PR-DQT-SFTP  Globalscape SFTP" "Globalscape EFT Server" "" "Microsoft Azure - VM Images (Classic)"
                       
                                #••••••••••Q: What is running on this server? 
                                dqtiiswebapp1 = infrastructureNode "Web Portal Server 1 (iis) DQT Portals" "Windows Server 2016, https://teacherservices.education.gov.uk/" "" "Microsoft Azure - VM Images (Classic)"
                                #••••••••••Q: What is running on this server? 
                                dqtiiswebapp2 = infrastructureNode "Web Portal Server 2 (iis) DQT Portals" "Windows Server 2016, https://teacherservices.education.gov.uk/" "" "Microsoft Azure - VM Images (Classic)"
                                #dqtportalwebsite = infrastructureNode "DQT External Web Site" "https://teacherservices.education.gov.uk/" "Employer Access, Teacher Self Serve, Professional Recognition, Appropriate Bodies, ITT providers" "Microsoft Azure - Web Environment"

                                #••••••••••Q: What is running on this server? 
                                #fileintegration = deploymentNode "File Integration" {
                                    ssisscheduler = deploymentNode "VMT1PR-DQT-SSIS SQL Server Integration Services (SSIS) for DQT interfaces" "Windows Server 2016" "" "Microsoft Azure - SSIS Lift And Shift IR"{

                                        ssisabimport = infrastructureNode "DQT AB Import" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssiscapitaexportamend = infrastructureNode "DQT Capita Export Amend" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssiscapitaexportnew = infrastructureNode "DQT Capita Export New" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssiscapitaimport = infrastructureNode "DQT Capita Import" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssiscontactdataretention = infrastructureNode "DQT Contact Data Retention" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisdatafileretention = infrastructureNode "DQT Data File Retention" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisdmsexportqts = infrastructureNode "DQT DMS Export QTS Data (DTTP?)" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisdmsexporttrn = infrastructureNode "DQT DMS Export TRN (DTTP?)" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisdmsimport = infrastructureNode "DQT DMS Import (DTTP?)" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisdoccheck = infrastructureNode "DQT Documents Check" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisdatagiasimport = infrastructureNode "DQT Edubase Import (GIAS)" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisdqtfilesvalidation = infrastructureNode "DQT Files Validation" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisgtcwalesimport = infrastructureNode "DQT GTC Wales Import" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssishesaimport = infrastructureNode "DQT HESA Import" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssishesaimportmulti = infrastructureNode "DQT HESA Import Multi" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisnpqimport = infrastructureNode "DQT NPQ Import" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssisprdataretention = infrastructureNode "DQT PR Data Retention" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssistpimport = infrastructureNode "DQT TP Import" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"
                                        ssiswebauditreport = infrastructureNode "DQT Web Audit Import" "SSIS scheduled job" "vmt1dvdqtmgsis" "Microsoft Azure - SSIS Lift And Shift IR"

                                        consoleintegrationapp = infrastructureNode ".Net console application (shared)" "Capgemini.DfE.Evolved.Integration.Application.exe " "Shared integration component" "Microsoft Azure - Dev Console"
                                        consoleintegrationappcontactdata = infrastructureNode ".Net console application (contact data)" "Capgemini.DfE.Evolved.Integration.ContactDataRetention.exe " "Integration component" "Microsoft Azure - Dev Console"
                                        consoleintegrationdataretention = infrastructureNode ".Net console application (data retention)" "Capgemini.DfE.Evolved.Integration.DataRetention.exe" "Integration component" "Microsoft Azure - Dev Console"
                                        consoleintegrationhesa = infrastructureNode ".Net console application (Hesa)" "Capgemini.DfE.Evolved.Integration.Hesa.ReadXml.exe" "Integration component" "Microsoft Azure - Dev Console"
                                        consoleintegrationprddata = infrastructureNode ".Net console application (PRD data retention" "Capgemini.DfE.Evolved.Integration.PRDataRetention.exe" "Integration component" "Microsoft Azure - Dev Console"

                                        mscrmsdk  = infrastructureNode "Microsoft.Xrm.Sdk" "Microsoft DSK" "installed on VMT1PR-DQT-SSIS" "Microsoft Azure - Toolbox"


                                    }
                                    
                                    
                            
                                
                            #}
                        
                               
                                
                                
                           
                            
                            
                        }
                        
              
                    
            }

            # TBC on this section
            expressroute -> waf1
            expressroute -> waf2
            waf1 -> ssisrepbuilder
            waf2 -> ssisrepbuilder
            waf1 -> extractdatabaseInstance "Requests from SSIS Report Builder VMT1PR-DQT-SQL2" "HTTPS ? [TBC]"
            waf2 -> extractdatabaseInstance "Requests from SSIS Report Builder VMT1PR-DQT-SQL2" "HTTPS ? [TBC]"
            #firewall rules
            baracudafwruleset -> waf1 "Controls access rules"
            baracudafwruleset -> waf2 "Controls access rules"
            checkpointfwuleset -> checkpointfw1 "Controls access rules"
            checkpointfwuleset -> checkpointfw2 "Controls access rules"
            wafwuleset -> waf1 "Controls access rules"
            wafwuleset -> waf2 "Controls access rules"
            #expressroute -> elb 
            #elb -> webApplicationInstance "Forwards requests to" "https"
            #usrcontainer1 -> expressroute "Uses corporate network"
           
            # D365 data exports
            dataexportservice -> dqtd365 "Exports data"
            dataexportservice -> extractdatabaseInstance "Pushes data to service Public IP address whitelisted as a standard route in PAAS"

            powerBi -> extractdatabaseInstance "Reads From"
            sqlsvrmt18 -> extractdatabaseInstance "Read and Writes To"
            sqlsvrmt16 -> extractdatabaseInstance "Read and Writes To"
            ssisrepbuilder -> extractdatabaseInstance "Reads From"
            


            # Red Zone
            azurepublicip -> azureexternallb "Front end pool"
            azureexternallb -> checkpointfw1 "Back end pool"
            azureexternallb -> checkpointfw2 "Back end pool"
            checkpointfw1 -> azureinternallb "NAT Rules"
            checkpointfw2 -> azureinternallb "NAT Rules"
            azureinternallb -> waf1 "Balances WAF's"
            azureinternallb -> waf2 "Balances WAF's"
            waf1 -> dqtiiswebapp1 "Balances Application"
            waf1 -> dqtiiswebapp2 "Balances Application"
            waf2 -> dqtiiswebapp1 "Balances Application"
            waf2 -> dqtiiswebapp2 "Balances Application"
            
            dqtiiswebapp1 -> ssisscheduler
            dqtiiswebapp2 -> ssisscheduler
            ssisscheduler -> sftpserver
            
            dqtiiswebapp1 -> dqtd365
            dqtiiswebapp2 -> dqtd365
            ssisscheduler -> dqtd365
            # telemetry
            dqtiiswebapp1 -> webservicestelemetry
            dqtiiswebapp2 -> webservicestelemetry
            

            dqtd365 -> crmtelemetry
            ssisscheduler -> integrationtelemetry
            # External user connections
           
            dfesign -> azurepublicip "DfE Sign route https://teacherservices.education.gov.uk "

            dfeservices -> traroute53 "DfE Service Integrations via API"
            digitalservicesusers -> traroute53 "Citizens using TRA digital services"
            legacyportalusers -> dfesign "DQT legacy portal users (redirect from https://teacherservices.education.gov.uk)"
            dfesign -> azurepublicip "DfE Sign"
            externalfileintegrationusers -> azurepublicip "External Bodies (legacy file integration)"
            crmusers -> dqtd365 "DQT D3565 CRM Users"
            internaldfeusers -> expressroute "Internal traffic to Azure Services"
           
            waf1 -> sftpserver "sftp traffic"
            waf2 -> sftpserver "sftp traffic"
           
            


            # AWS
           
            dqtapi -> dqtapipostgres
            dqtapi -> dqtd365 "Returns data from"
            findtrn -> dqtapi "Uses"
            findtrn -> findtrndb "Uses"
            traroute53 -> tracloudfront "CNAME record"
            tracloudfront -> cdnroute
            cdnroute -> dqtapi
            cdnroute -> findtrn

            # File integration
            ssisabimport -> consoleintegrationapp "Calls .exe "
            ssiscapitaexportamend -> consoleintegrationapp "Calls .exe "
            ssiscapitaexportnew -> consoleintegrationapp "Calls .exe "
            ssiscapitaimport -> consoleintegrationapp "Calls .exe "
            ssiscontactdataretention -> consoleintegrationappcontactdata "Calls .exe "
            ssisdatafileretention -> consoleintegrationapp "Calls .exe "
            ssisdmsexportqts -> consoleintegrationapp "Calls .exe "
            ssisdmsexporttrn -> consoleintegrationapp "Calls .exe "
            ssisdmsimport -> consoleintegrationapp "Calls .exe "
            ssisdoccheck -> consoleintegrationapp "Calls .exe "
            ssisdatagiasimport -> consoleintegrationapp "Calls .exe "
            ssisdqtfilesvalidation -> consoleintegrationapp "Calls .exe "
            ssisgtcwalesimport -> consoleintegrationapp "Calls .exe "
            ssishesaimport -> consoleintegrationhesa "Calls .exe "
            ssishesaimportmulti -> consoleintegrationapp "Calls .exe "
            ssisnpqimport -> consoleintegrationapp "Calls .exe "
            ssisprdataretention -> consoleintegrationprddata "Calls .exe "
            ssistpimport -> consoleintegrationapp "Calls .exe "
            ssiswebauditreport -> consoleintegrationapp "Calls .exe "
            consoleintegrationapp -> mscrmsdk "references"
            mscrmsdk -> dqtd365 "CRUD data operations on CRM"

            consoleintegrationappcontactdata -> mscrmsdk
            consoleintegrationdataretention -> mscrmsdk
            consoleintegrationhesa -> mscrmsdk
            consoleintegrationprddata -> mscrmsdk

            consoleintegrationappcontactdata -> sftpserver
            consoleintegrationdataretention -> sftpserver
            consoleintegrationhesa -> sftpserver
            consoleintegrationprddata -> sftpserver
                                         
        }
    }
         
    views {
        deployment dqt "Prod" {
            include *
            autoLayout tb

            #animation {
                
            #    expressroute
            #    dqtd365
             #   greenzone
            #    redzone
            #    extractdatabaseInstance
            #    ssisrepbuilder
                
            #}

        }


        styles {
            element "Element" {
                shape roundedbox
                background #ffffff
            }
            
            element "D365 Extract DB" {
                shape cylinder
            }
            element "Infrastructure Node" {
                shape roundedbox
            }
        }

        themes https://static.structurizr.com/themes/microsoft-azure-2021.01.26/theme.json
        themes https://static.structurizr.com/themes/amazon-web-services-2020.04.30/theme.json


    }
}