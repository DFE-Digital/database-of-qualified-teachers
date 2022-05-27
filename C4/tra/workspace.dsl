workspace "Teacher-Regulation-Agency" "Model of the TRA software system" {

    model {
            # **********software system users**********
            
            # internal
            trauser = person "Teacher Regulation Agency" "A member of the TRA business teams (Teacher Qualifications Unit [TMU], Teacher Misconduct Unit [TMU])"
            dfesystemuser = person "DfE System User" "A software system user integrating DfE data and systems (e.g. Apply for Teacher Training Service)"
            
            # citizens etc.
            citizen = person "Citizen" "Anybody who neeeds to use the TRA's public Gov.Uk services"
            
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
            hesa = softwaresystem "Hesa" "HESA file integration" "sftp"
            capitatps = softwaresystem "Capita TPS" "Teacher Pensions file integration" "sftp"
            gias = softwaresystem "GIAS" "Get Information About Schools file integration" "sftp"
            gtc = softwaresystem "GTC" "Welsh General Teaching Council file integration" "sftp"
            
            
            # **********software system**********
            trasoftwareSystem = softwareSystem "TRA Software System" "A distibuted set of software containers that provide both internal and external facing services."{
                # containers
                findcont = container "Find-A-Lost-Trn Gov.Uk Web Application" "https://find-a-lost-trn.education.gov.uk/start" "Ruby on Rails" {
                    # find a lost trn users
                    qualifiedteacher -> this "https"
                    traineeteacher -> this "https"
                    citizen -> this "https"
                    
                    findrubyonrailsmonolith = component "find-a-lost-trn Monolith" "Find a lost TRN is a monolithic Rails app built with the GOVUK Design System and hosted on GOVUK PaaS." "Ruby 3.x,Node.js 16.x,Yarn 1.22.x,PostgreSQL 13.x,Redis 6.x"
                
                }
                
                qualifiedteachersapicont = container "Teacher Qualifications REST API" "qualified-teachers-api" ".Net API RESTful API for integrating with the Database of Qualified Teachers CRM" {
                    
                    # teacher qualifications api users
                    dfesystemuser -> this "https"
                    qualifiedteachersapi = component "qualified-teachers-api" "REST API providing data integration to TRA data sources" ".Net core 6.x, PostgreSQL 13.x,.Net core 6.x SDK"
                    
                }
                
                dqtcrmcont = container "DQT CRM" "Database of qualified teachers CRM" "MS Dynamics 365 SAAS" {
                    # teacher qualifications api users
                    trauser -> this "https"
                    
                    dqtcrm = component "CRM" "CRM instance providing customer relationship management and data store https://ent-dqt-prod.crm4.dynamics.com" "MS D365 SAAS"
                    msdataexportservice = component "MS Data Export Service" "D365 plugin data export service [End Of Life]" "MS D365 SAAS"
                    crmexportdatabase = component "CRM Data Copy" "Hot copy of CRM data" "SQLServer SQL instance, SSIS jobs"
                    sftpapp = component "SFTP Application" "SFTP File interface providing public end point for file import/export teacherservices-sftp.education.gov.uk" "Global scape SFTP"
                    ssisjobs = component "SSIS Job Suite" "SQLServer job schedule providing batch for file integration" "MS SQLServer SSIS"
                    consoleapps = component ".Net Console Integration App Suite" "A suite of .Net console applications implementing business logic for file integration" ".Net 4 (framework)"
                    sqlsvrmt16 = component "SQL Server Management Tools v16" "Client MS SQLServer management tools suite for querying databases" "MSSQL Svr Management Tools v2016 (Pre-Prod)"
                    sqlsvrmt18 = component "SQL Server Management Tools v18" "Client MS SQLServer management tools suite for querying databases" "MSSQL Svr Management Tools v2018 (Prod)"
                    aspwebapp = component "ASP.Net Web Application" "Web application serving https://teacherservices.education.gov.uk/" "ASP.net 4 application hosted on iis"
                    
                    
                    # crm component relationships
                    msdataexportservice -> dqtcrm "plugs in to"
                    msdataexportservice -> crmexportdatabase "exports data to"
                    ssisjobs -> consoleapps "invokes" 
                    consoleapps -> sftpapp "imports/exports files to/from"
                    consoleapps -> dqtcrm "reads/writes from/to"
                    sqlsvrmt16 -> dqtcrm "reads/writes from/to"
                    sqlsvrmt18 -> dqtcrm "reads/writes from/to"
                    aspwebapp -> dqtcrm "reads/writes from/to"
                    register -> qualifiedteachersapi "reads/writes from/to"
                    claim -> qualifiedteachersapi "reads/writes from/to"
                    cpd -> qualifiedteachersapi "reads/writes from/to"
                    hesa -> sftpapp "reads/writes from/to"
                    capitatps -> sftpapp "reads/writes from/to"
                    gias -> sftpapp "reads/writes from/to"
                    gtc -> sftpapp "reads/writes from/to"
                    aspwebapp -> dsi "authenticates with"
                    appropriatebody -> aspwebapp "uploads files to"
                }
                
                
                
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

    }    
    
    # **********views**********
    views {
        systemContext trasoftwareSystem "SystemContext" "Full Context" {
            include *
            autoLayout 
        }
        
        systemContext trasoftwareSystem "UserContext" "User Context" {
            include qualifiedteacher traineeteacher trauser dfesystemuser citizen ittprovider schoolemployer appropriatebody qtsequivelenceteacher noneschoolemployer
            autoLayout 
        }
        
        
        container trasoftwareSystem {
            
            include *
            autolayout 
        }
        
        component findcont "findview" {
            include *
            animation {
                
            }
            autoLayout
        }
        
        component qualifiedteachersapicont "qualapiview" {
            include *
            animation {
                
            }
            autoLayout
        }
        
        component dqtcrmcont "crmview" {
            include *
            animation {
               
            }
            autoLayout
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
            
        }
    }
    
}