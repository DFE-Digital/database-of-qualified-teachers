workspace "DQT" "DQT Deployment Architecture" {
    ## *************************************************************************************************************************************************************
    ## DO NOT STORE IN GIT HUB THIS HAS SENSITIVE NETWORK INFORMATION
    ## STORE HERE: https://drive.google.com/drive/folders/1UneNM3VZwtdEZFvB6uNPpVS2MELGZhE0?ths=true
    ## Last Update: 08/03/2022
    ## To install structurizr see: https://structurizr.com/help/getting-started
    ## docker run -it --rm -p 8080:8080 -v [PATH TO workspace.dsl]:/usr/local/structurizr structurizr/lite
    ## *******************************************************************
    ## ******************************************************************* PRODUCTION *******************************************************************************
    ##  NON - SENSITIVE

    model {
        
          testers  = group "Testers" {
            internaltesters = person "Internal Testers"
            pentesters = person "Penetration Testers"
        }

        dqt = softwaresystem "DQT" "Allows Teacher Regulation Agency to regulate teaching profession" "Collection of various technologies" {
            webApplication = container "Web Application" "Allows Teachers, Employers to access TRA services via portals" ".Net 4, SQL/SSIS"
            ssisstagedb = container "D365 Extract Database" "Stores D365 data extracts (schedule update hourly)" "sqlsrv-t1pr-dynamicscrmexports.database.windows.net" "SQLServer 12.0.2000.8"
            usrcontainer = container "users"
            
        }
        
       

        prod = deploymentEnvironment "Prod" {
            
            deploymentNode "Users" "" "" "" {
                            usrcontainer1 = containerInstance usrcontainer  
                        }

            deploymentNode "On Premise Network" "" "" "Microsoft Azure - Virtual Networks (Classic)" {
                expressroute = infrastructureNode "Express Route" "" "" "Microsoft Azure - ExpressRoute Circuits"
                 
            }
           
            deploymentNode "DfE Sign In" "" "" "Secure Access Web Site" {
                dfesign = infrastructureNode "Dfe Sign Web App" "" "" "Microsoft Azure - Web Environment"
                 
            }

            deploymentNode "Internet" "" "" "Microsoft Azure - Website Power" {
                internetconnection = infrastructureNode "Public Internet" "" "" "Microsoft Azure - Website Power"
                 
            }
           
            deploymentNode "GovPaas" "" "" "Amazon Web Services - CloudFront" {
                dqtapipostgres = infrastructureNode "DQT API DB" "" "" "Amazon Web Services - RDS PostgreSQL instance"
                dqtapi = infrastructureNode "DQT API .Net Application" "" "" "Amazon Web Services - EC2"
                findtrn = infrastructureNode "Find a lost TRN Service" "Ruby on Rails Web Application" " https://find-a-lost-trn.education.gov.uk" "Amazon Web Services - CloudFront"
                findtrndb = infrastructureNode "Find a lost TRN Database" "Postgres" "Local database" "Amazon Web Services - RDS PostgreSQL instance"
                 
            }

            deploymentNode "D365" "" "" "Microsoft Azure - Virtual Networks (Classic)" {
                dqtd365 = infrastructureNode "DQT Prod	​​https://ent-dqt-prod.crm4.dynamics.com/		O365 CRM ENT-DQT-PROD​" "DQT CRM SAAS" "" "Microsoft Azure - Cloud Services (Classic)"
                dataexportservice = infrastructureNode "Microsoft Azure - Azure Database Migration Services"
            }

            

            deploymentNode "Microsoft Azure DfE Tennancy" "Subscription T1" "" "Microsoft Azure - Virtual Networks" {
                
                greenzone = deploymentNode "Production Green Zone Vnet:  AD.HQ.DEPT" "" "" "Microsoft Azure - Azure Active Directory"{
                        baracudafw = infrastructureNode "Barracuda Firewall SHARED" "" "" "Microsoft Azure - Firewalls"
                        baracudafwruleset = infrastructureNode "Barracuda (NF) Firewall Rules" "" "" "Microsoft Azure - Web Application Firewall Policies(WAF)"
                            
                        greensubnet = deploymentNode "Subnet snet-t-t1pr-data " "" "" "Microsoft Azure - Virtual Networks"{
                                ssisrepbuilder = infrastructureNode "SQL Report Builder VMT1PR-DQT-SQL2 (AD admin account) " "Windows Server 2016" "" "Microsoft Azure - SSIS Lift And Shift IR"
                                powerBi = infrastructureNode "Power BI Reports​" "Collection of Power BI reports over CRM Export Database" "" "Microsoft Azure - Cloud Services (Classic)"
                                sqlsvrmt18 = infrastructureNode "SQL Server Management Tools v2018​" "Locally installed SQL Server MAnagement Tools 2018" "" "Microsoft Azure - Cloud Services (Classic)"
                                sqlsvrmt16 = infrastructureNode "SQL Server Management Tools​ v2016" "Locally installed SQL Server MAnagement Tools 2016" "" "Microsoft Azure - Cloud Services (Classic)"
                                deploymentNode "AzureSQL PAAS" "Azure SQL PAAS" "Shared PAAS (other DB's outside of DQT)" "Microsoft Azure - Azure SQL" {
                                extractdatabaseInstance = containerInstance ssisstagedb
                            }
                            
                        }
                        

                    }

                redzone = deploymentNode "Production Red Zone VNet" "VNet" "" "Microsoft Azure "{
                      
                        apploadbalancer = infrastructureNode "ALB (Application Load Balancer)" "SHARED Load Balancer" "" "Microsoft Azure - Load Balancers"
                        checkpointfw = infrastructureNode "Palo Alto Firewall" "Firewall" "" "Microsoft Azure - Firewalls"
                        checkpointfwuleset = infrastructureNode "Palo Alto Firewall Rules" "WAF Policies" "" "Microsoft Azure - Web Application Firewall Policies(WAF)"
                        waf = infrastructureNode "WAF Firewall" "Firewall" "" "Microsoft Azure - Firewalls"
                        wafwuleset = infrastructureNode "WAF Firewall Rules" "" "" "Microsoft Azure - Web Application Firewall Policies(WAF)"
                            
                        redsubnet1 = deploymentNode "Subnet: snet-??? [TBC]" "" "" "Microsoft Azure - Virtual Networks"{
                                #••••••••••Q: What is running on this server? 
                                dqtiiswebapp1 = infrastructureNode "Web Portal Server 1 (iis) VMT1PR-DQT-IIS1" "Windows Server 2016" "" "Microsoft Azure - VM Images (Classic)"
                                #••••••••••Q: What is running on this server? 
                                dqtiiswebapp2 = infrastructureNode "Web Portal Server 2 (iis) VMT1PR-DQT-IIS2" "Windows Server 2016" "" "Microsoft Azure - VM Images (Classic)"
                                dqtportalwebsite = infrastructureNode "DQT External Web Site" "https://teacherservices.education.gov.uk/" "Employer Access, Teacher Self Serve, Professional Recognition, Appropriate Bodies, ITT providers" "Microsoft Azure - Web Environment"

                                #••••••••••Q: What is running on this server? 
                                fileintegration = deploymentNode "File Integration" {
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
                                    
                                    
                            }
                                
                            }
                        redsubnet2 = deploymentNode "Subnet: snet-?? [TBC]" "" "" "Microsoft Azure - Virtual Networks"{
                                sftpserver = infrastructureNode "DQT SFTP Server VMT1PR-DQT-SFTP  Globalscape SFTP" "Globalscape EFT Server" "" "Microsoft Azure - VM Images (Classic)"
                                
                                
                            }
                            
                            
                        }
                        
                telemetry = deploymentNode "Telemetry" "" "" "Microsoft Azure Actvity Log Services Application Insights"{
                        crmtelemetry = infrastructureNode "CRM telemetry Application Insights" "" "" "Microsoft Azure - Application Insights"
                        webservicestelemetry = infrastructureNode "Web Service telemetry Application Insights" "" "" "Microsoft Azure - Application Insights"
                        integrationtelemetry = infrastructureNode "Integration telemetry ? Application Insights" "" "" "Microsoft Azure - Application Insights"
                            
                        }
                    
            }

            # Relationships

            expressroute -> baracudafw
            baracudafw -> ssisrepbuilder
            ssisrepbuilder -> baracudafw "Requests to SQL PAAS" "HTTPS ? [TBC]"
            baracudafw -> extractdatabaseInstance "Requests from SSIS Report Builder VMT1PR-DQT-SQL2" "HTTPS ? [TBC]"
            #firewall rules
            baracudafwruleset -> baracudafw "Controls access rules"
            checkpointfwuleset -> checkpointfw "Controls access rules"
            wafwuleset -> waf "Controls access rules"
            #expressroute -> elb 
            #elb -> webApplicationInstance "Forwards requests to" "https"
            usrcontainer1 -> expressroute "Uses corporate network"
            usrcontainer1 -> internetconnection "Uses"
            internetconnection -> dqtd365 "Uses internet" "https"
            # D365 data exports
            dataexportservice -> dqtd365 "Exports data"
            dataexportservice -> extractdatabaseInstance "Pushes data to service Public IP address whitelisted as a standard route in PAAS"

            powerBi -> extractdatabaseInstance "Reads From"
            sqlsvrmt18 -> extractdatabaseInstance "Read and Writes To"
            sqlsvrmt16 -> extractdatabaseInstance "Read and Writes To"
            ssisrepbuilder -> extractdatabaseInstance "Reads From"
            


            # Red Zone
            apploadbalancer -> checkpointfw
            checkpointfw -> waf
            waf -> dqtiiswebapp1
            waf -> dqtiiswebapp2
            dqtiiswebapp1 -> ssisscheduler
            dqtiiswebapp2 -> ssisscheduler
            ssisscheduler -> sftpserver
            
            dqtiiswebapp1 -> dqtd365
            dqtiiswebapp2 -> dqtd365
            ssisscheduler -> dqtd365
            # telemetry
            dqtiiswebapp1 -> webservicestelemetry
            dqtiiswebapp2 -> webservicestelemetry
            dqtiiswebapp1 -> dqtportalwebsite "Hosts"
            dqtiiswebapp2 -> dqtportalwebsite "Hosts"

            dqtd365 -> crmtelemetry
            ssisscheduler -> integrationtelemetry
            # External user connections
            usrcontainer1 -> internetconnection "None DfE Sign route: External users "
            usrcontainer1 -> internetconnection "DfE Sign route: External users"
            internetconnection -> dfesign "DfE Sign route"
            dfesign -> apploadbalancer "DfE Sign route https://teacherservices.education.gov.uk "
            internetconnection -> apploadbalancer "https://teacherservices.education.gov.uk "
            internetconnection -> sftpserver "Accessed via"
            # data provider
            usrcontainer1 -> internetconnection "Data Provider"
            internetconnection -> apploadbalancer "https://teacherservices.sftp.education.gov.uk "
            # hesa
            usrcontainer1 -> internetconnection "Hesa"
            internetconnection -> apploadbalancer "datacollection.hesa.ac.uk "
            # AWS
            dqtapi -> dqtapipostgres
            usrcontainer1 -> dqtapi "Internal service consumers via API key"
            dqtapi -> dqtd365 "Returns data from"
            findtrn -> dqtapi "Uses"
            findtrn -> findtrndb "Uses"
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
            autolayout lr

            animation {
                
                expressroute
                dqtd365
                baracudafw
                greensubnet
                greenzone
                redzone
                extractdatabaseInstance
                ssisrepbuilder
                telemetry
            }

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