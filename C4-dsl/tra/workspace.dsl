workspace "Teacher-Regulation-Agency" "Model of the TRA software system" {

    ## *************************************************************************************************************************************************************
    ## To install structurizr see: https://structurizr.com/help/getting-started
    ## docker run -it --rm -p 8080:8080 -v [PATH TO workspace.dsl]:/usr/local/structurizr structurizr/lite
     ## suggested workflow 1. use https://structurizr.com/dsl to make changes and test, using local host is slower.
    ## *******************************************************************
    ##  NON - SENSITIVE

    model {3
            # **********software system users**********
            
            # internal
            trauser = person "Teacher Regulation Agency" "A member of the TRA business teams (Teacher Qualifications Unit [TMU], Teacher Misconduct Unit [TMU])"
            dfesystemuser = person "DfE System User" "A software system user integrating DfE data and systems (e.g. Apply for Teacher Training Service)"
            
            # citizens etc.
            citizen = person "Citizen" "Anybody who neeeds to use the TRA's public Gov.Uk services"
            nonukcitizen = person "Non Uk Citizen" "None UK citizen who neeeds to use the TRA's public Gov.Uk services"
            
            # known portal user types
            qualifiedteacher = person "Qualified Teacher" "Newly Qualified and Fully Qualified Teachers"
            traineeteacher = person "Trainee Teacher" "Trainee Teachers"
            ittprovider = person "Initial Teacher Training Provider" "Higher education institute initial teacher training providers"
            schoolemployer = person "Emlpoyer (School)" "Nurseries, Schools, Academies, Free schools, Independent schools and Colleges"
            appropriatebody = person "Appropriate Body" "Organisations responsible for the quality assurance process for early career teacher induction"
            qtsequivelenceteacher = person "None QTS Teacher" "Qualified teacher outside of England and Wales"
            noneschoolemployer = person "Employer (None School)" "Teacher supply agencies, local authorities and training providers"
            
            # other users
            
           
            # other systems (periphery)
            zendesk = softwaresystem "Zendesk Call Centre" "REST API providing integration to Zendesk to raise create/respond to tickets" "Zendesk SAAS"
            register = softwaresystem "Register For Initial Teacher Training Gov.Uk Service" "Service used to register for Teacher training" "Ruby"
            claim = softwaresystem "Claim For Teacher Payments Gov.Uk Service" "Service used to claim Teacher payments" "Ruby"
            cpd = softwaresystem "Continue Proffessional Development Gov.Uk Service" "Service used to for post qualification training" "Ruby"
            dsi = softwaresystem "DSI" "DfE Sign In IDAM" "https,Oauth"
            
            # legacy file integrations 
            
            capitatps = softwaresystem "Capita TPS" "Teacher Pensions file integration" "sftp"
            gias = softwaresystem "GIAS" "Get Information About Schools file integration" "sftp"
            gtc = softwaresystem "GTC" "Welsh General Teaching Council file integration" "sftp"
            
            
            # **********software system**********
            trasoftwareSystem = softwareSystem "TRA Software System" "A distibuted set of software containers that provide both internal and external facing services."{
                # containers
                qualifiedteachersapicont = container "Teacher Qualifications REST API" "qualified-teachers-api" ".Net API RESTful API for integrating with the Database of Qualified Teachers CRM" {
                    
                    # teacher qualifications api users
                    dfesystemuser -> this "https"
                    qualifiedteachersapi = component "qualified-teachers-api" "REST API providing data integration to TRA data sources" ".Net core 6.x, PostgreSQL 13.x,.Net core 6.x SDK"
                    
                }
                
                
                findcont = container "Find-A-Lost-Trn Gov.Uk Web Application" "https://find-a-lost-trn.education.gov.uk/start" "Ruby on Rails" {
                    # find a lost trn users
                    qualifiedteacher -> this "https"
                    traineeteacher -> this "https"
                    citizen -> this "https"
                    this -> qualifiedteachersapi "uses"
                    findrubyonrailsmonolith = component "find-a-lost-trn Monolith" "Find a lost TRN is a monolithic Rails app built with the GOVUK Design System and hosted on GOVUK PaaS." "Ruby 3.x,Node.js 16.x,Yarn 1.22.x,PostgreSQL 13.x,Redis 6.x"
                    findrubyonrailsmonolith -> qualifiedteachersapi "https"
                    findsidekiqworker = component "SideKiq Worker" "Sidekiq is a job scheduler. The worker instances pick up jobs from the Redis Cache"
                    findrediscache = component "Redis Cache" "Redis is a database & memory cache"
                    findpostgres = component "PostgreSQL" "PostgreSQL database for storing service data"
                    
                    findrubyonrailsmonolith -> findrediscache "Write Operations"
                    findsidekiqworker -> findrediscache "Reads and Delete Operations"
                    findrubyonrailsmonolith -> findpostgres "CRUD operations"
                    findsidekiqworker -> findpostgres "CRUD operations"
                }
                
                
                qualscont = container "Teacher Qualifications" "Replacement for Teacher Self Serve & Employer Portal" "Ruby on Rails" {
                    # Right to teach and Teacher self serve user base
                    qualifiedteacher -> this "https"
                    traineeteacher -> this "https"
                    citizen -> this "https"
                    this -> qualifiedteachersapi "uses"
                    rttrubyonrailsmonolith = component "Right To Teach" "Right to teach is a monolithic Rails app built with the GOVUK Design System and hosted on Azure.[TBC]" "Ruby 3.x,Node.js 16.x,Yarn 1.22.x,PostgreSQL 13.x,Redis 6.x"
                    rttrubyonrailsmonolith -> qualifiedteachersapi "https"
                    tqualsrubyonrailsmonolith = component "Teacher Qualifications" "Teacher Qualifications is a monolithic Rails app built with the GOVUK Design System and hosted on Azure.[TBC]" "Ruby 3.x,Node.js 16.x,Yarn 1.22.x,PostgreSQL 13.x,Redis 6.x"
                    tqualsrubyonrailsmonolith -> qualifiedteachersapi "https"
                }
                
                applyqtscont = container "Apply For QTS Gov.Uk Web Application" "https://apply-for-qts-in-england.education.gov.uk/eligibility/start" "Ruby on Rails" {
                    # find a lost trn users
                    nonukcitizen -> this "https"
                    this -> qualifiedteachersapi "uses"
                    applyqtsrubyonrailsmonolith = component "apply-for-qts Monolith" "Apply for QTS is a monolithic Rails app built with the GOVUK Design System and hosted on GOVUK PaaS." "Ruby 3.x,Node.js 16.x,Yarn 1.22.x,PostgreSQL 13.x,Redis 6.x"
                    applyqtsrubyonrailsmonolith -> qualifiedteachersapi "Post/Put/Get"
                    applysidekiqworker = component "SideKiq Worker" "Sidekiq is a job scheduler. The worker instances pick up jobs from the Redis Cache"
                    applyrediscache = component "Redis Cache" "Redis is a database & memory cache"
                    applyqtsrubyonrailsmonolith -> applyrediscache "Write Operations"
                    applysidekiqworker -> applyrediscache "Reads and Delete Operations"
                    applypostgres = component "PostgreSQL" "PostgreSQL database for storing service data"
                    applyqtsrubyonrailsmonolith -> applypostgres "CRUD operations"
                    applysidekiqworker -> applypostgres "CRUD operations"
                }
                
                d365cont = container "DQT CRM" "DQT D365 SAAS Service" "SAAS"{
                    dqtcrm = component "CRM" "CRM instance providing customer relationship management and data store https://ent-dqt-prod.crm4.dynamics.com" "MS D365 SAAS"
                    
                
                }
                
                dqtdevopscomponentscont = container "Azure DQT Dev Ops" "DQT Azure Dev Ops components" "Key vaults, Storage"{
                    keyvault = component "KeyVault" "Key Vault" "Azure Key Vault"
                    storageac = component "Storeage Account" "Storage Account" "Azure Storage Account"
                    
                
                }
                
                dqtcrmcompcont = container "DQT Components" "Database of qualified teachers components" "IAAS components" {
                    # teacher qualifications api users
                    trauser -> this "https"
                    
                    
                    msdataexportservice = component "MS Data Export Service" "D365 plugin data export service [End Of Life]" "MS D365 SAAS"
                    crmexportdatabase = component "CRM Data Copy" "Hot copy of CRM data" "SQLServer SQL instance, SSIS jobs"
                    sftpapp = component "SFTP Application" "SFTP File interface providing public end point for file import/export teacherservices-sftp.education.gov.uk" "Global scape SFTP"
                    ssisjobs = component "SSIS Job Suite" "SQLServer job schedule providing batch for file integration" "MS SQLServer SSIS"
                    consoleapps = component ".Net Console Integration App Suite" "A suite of .Net console applications implementing business logic for file integration" ".Net 4 (framework)"
                    sqlsvrmt16 = component "SQL Server Management Tools v16" "Client MS SQLServer management tools suite for querying databases" "MSSQL Svr Management Tools v2016 (Pre-Prod)"
                    sqlsvrmt18 = component "SQL Server Management Tools v18" "Client MS SQLServer management tools suite for querying databases" "MSSQL Svr Management Tools v2018 (Prod)"
                    aspwebapp = component "ASP.Net Web Application" "Web application serving https://teacherservices.education.gov.uk/" "ASP.net 4 application hosted on iis"
                    dsisync = component "SASyncService DSI -> DQT CRM Data Sync" "IIS hosted WCF component that syncs DSI user and org. data" ".Net 4"
                    
                    # crm component relationships
                    
                    dsi -> dsisync "pushes data to"
                    dsisync -> dqtcrm "pushes data to"
                
                    
                    msdataexportservice -> crmexportdatabase "exports data to"
                    ssisjobs -> consoleapps "invokes" 
                    consoleapps -> sftpapp "imports/exports files to/from"
                    
                    sqlsvrmt16 -> crmexportdatabase "reads from"
                    sqlsvrmt18 -> crmexportdatabase "reads from"
                    
                    register -> qualifiedteachersapi "uses"
                    claim -> qualifiedteachersapi "uses"
                    cpd -> qualifiedteachersapi "uses"
                    
                    
                    capitatps -> sftpapp "reads/writes from/to"
                    gias -> sftpapp "reads/writes from/to"
                    gtc -> sftpapp "reads/writes from/to"
                    aspwebapp -> dsi "authenticates with"
                    appropriatebody -> aspwebapp "uploads files to"
                }
                
                
                msdataexportservice -> dqtcrm "plugs in to"
                consoleapps -> dqtcrm "reads/writes from/to"
                aspwebapp -> dqtcrm "reads/writes from/to"
                qualifiedteachersapi -> dqtcrm "reads/writes from/to"
                keyvault -> qualifiedteachersapicont "stores secrets"
                keyvault -> findcont "stores secrets"
                keyvault -> applyqtscont "stores secrets"
                
                
            # **********system context user relationships**********
            trauser -> trasoftwareSystem "corporate network"
            qualifiedteacher -> trasoftwareSystem "https"
            traineeteacher -> trasoftwareSystem "https"
            ittprovider -> trasoftwareSystem "https/sftp"
            schoolemployer -> trasoftwareSystem "https"
            appropriatebody -> trasoftwareSystem "https"
            qtsequivelenceteacher -> trasoftwareSystem "https"
            dfesystemuser -> trasoftwareSystem "https"
            noneschoolemployer -> trasoftwareSystem "https"
           
            findrubyonrailsmonolith -> zendesk "reads/writes from/to"
            
            
        }
        
         deploymentEnvironment "Infrastructure High Level Deployment" {
            deploymentNode "GovPaas" "Gov.Uk Hosting Service managed by GDS (Government Digital Services)" "AWS, CloudFront" {
                deploymentNode "Find a Lost TRN Gov.Uk Digital Service" "" "Ruby on Rails" {
                    infrafindinstance = containerInstance findcont
                }
                deploymentNode "Apply For QTS TRN Gov.Uk Digital Service" "" "Ruby on Rails" {
                    infraapplyqtsinstance = containerInstance applyqtscont
                }
                deploymentNode "API Service" "" ".Net core" {
                    infraapiinstance = containerInstance qualifiedteachersapicont
                }
                
            }
            
            deploymentNode "Department For Education Azure Platform" "educationgovuk.onmicrosoft.com" "MS Azure T1" {
                deploymentNode "DQT Portal .Net4 Components" "" "IAAS VM's.Net 4, SQL,3rd Party Apps, SFTP, SSIS" {
                    infrat1dqtinstance = containerInstance dqtcrmcompcont
                }
            }
            
            deploymentNode "DfE Platform Identity" "platform.education.gov.uk" "MS Azure CIP" {
                deploymentNode "DQT CIP Components" "" "Key Vaults, Storage Accounts, Azure Service POCs" {
                    infradevopsinstance = containerInstance dqtdevopscomponentscont
                }
                
                
            }
            
            deploymentNode "Microsoft Cloud" "SAAS" "MS Dynamics365 CRM" {
                deploymentNode "DQT CRM" "" "Customer Relationship Management" {
                    d365instance = containerInstance d365cont
                }
                
                
            }
        }

    }    
    
    # **********views**********
    views {
        systemContext trasoftwareSystem "SystemContext" "Full Context" {
            include *
            autolayout
        }
        
        systemContext trasoftwareSystem "UserContext" "User Context" {
            include nonukcitizen qualifiedteacher traineeteacher trauser dfesystemuser citizen ittprovider schoolemployer appropriatebody qtsequivelenceteacher noneschoolemployer
             animation {
                
            }
            autolayout
        }
        
        
        container trasoftwareSystem {
            
            include *
            animation {
                
            }
            autolayout
        }
        
        component findcont "findview" {
            include *
            animation {
                
            }
            autolayout
            
        }
        
         component applyqtscont "applyview" {
            include *
            animation {
                
            }
            autolayout
            
        }
        component qualscont "qualsview" {
            include *
            animation {
                
            }
            autolayout
            
        }
        
        component qualifiedteachersapicont "qualapiview" {
            include *
            animation {
                
            }
            autolayout
        }
        
        component dqtcrmcompcont "crmview" {
            include *
            animation {
               
            }
         autolayout   
        }
        
        deployment trasoftwareSystem "Infrastructure High Level Deployment" "TRADeployment" {
            include *
            animation {
                
            }
            autolayout
        }
        
        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            element "Legacy" {
                background #08427b
                color #FF0000
            }
            
        }
    }
    
}333