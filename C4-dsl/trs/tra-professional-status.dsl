/*
 * TRA professional Status Proposal
*/
workspace "TRA-Professional-Status" "Encapsulates DfE TRA Professional Status (Digital Transformation of the DQT)" {

    model {
        group "External Digital Users" {
            teachingProfessional = person "Teaching Professional" "A person employed or training to be a teacher in an educational establishment in England" "externalDigitalUser"
            memberOfPublic = person "Member of Public" "A member of the public / citizen" "externalDigitalUser"
        }
        group "Employers" {
            employerOfTeacher = person "Educational Establishment" "A person acting as an employer on behalf of an educational establishment in England" "employerOfTeacher"
        }
        group "External Organisations" {
            ewc = person "EWC" "A person acting on behalf of The Education Workforce Council (Of Wales)" "teachingCouncils"
            gtcs = person "GTCS" "A person acting on behalf of The General Teaching Council Of Scotland" "teachingCouncils"
            gtcni = person "GTCNI" "A person acting on behalf of The General Teaching Council Of Scotland" "teachingCouncils"
            providers = person "ITT Providers" "A person acting on behalf of ITT (intial teacher training) provider companies" "teachingCouncils"
            hesa = person "HESA" "Higher Education Statistics Agency" "teachingCouncils"
        }
        group "DfE Services with dependencies"{
            cpd = softwaresystem "CPD" "DfE CPD Services including Early Careers Framework and National Professional Qualifications" "TS Digital Service"
            registerForITT = softwaresystem "Register For ITT" "Register manages initial teacher training and sends award QTS notifications" "TS Digital Service"
            gias = softwaresystem "Get Information About Schools" "DfE Get Information About Schools digital service" "Existing System"
            teacherMisconduct = softwaresystem "Teacher Misconduct Case Management System" "Manages TRA (only) misconduct cases" "TS Digital Service"{
                tmuD365 = container "TMU D365" "Provides all of the casework functionality for administering TRA misconduct, TRA sanctions and TRA prohibitions" "MS Dynamics 365" "Database"
            }
            tpsCapita = softwaresystem "TPS Service (Capita)" "Teacher Pensions Service (external) source of workforce data" "Existing System"
            referSeriousMisconduct = softwaresystem "Refer Serious Misconduct" "Allows anybody to raise a serious teacher miscondicut referal" "TS Digital Service"
            claimTeacherPAyments = softwaresystem "Claim Teacher Payments" "Allows Teachers to claim payments" "TS Digital Service"
        }

        group "DfE Corporate Services"{
            email = softwaresystem "E-mail System" "The internal Microsoft Exchange e-mail system." "Existing System"
            dfeSharepoint = softwaresystem "DfE Secure Sharepoint" "Allows sensitive files to be stored" "Existing System"
            dfeSFTP = softwaresystem "DfE SFTP Fileshare" "Allows secure file transfer" "Existing System"
        }
        group "Legacy Systems" {
            dqtD365 = softwaresystem "DQT CRM" "Databse of qualified teachers, legacy system being decommissioned D365" "Deprocated"
        }
        group "Identity Management" {
            teachingIdentity = softwaresystem "Teaching Identity" "DfE Teacher Services Identity single sign authorisation system, providing citizen and API access and data integration to DfE teacher services" "Authentication"
            dfeSign = softwaresystem "DFE Sign" "DfE sign in, provides organisational single sign authorisation system" "Authentication"
        }
        group "Teaching Regulation Agency (DfE)" {
                supportStaff = person "TRA Support Staff" "TRA support staff within DfE" "traPolicylUser"
                traPolicyPerson = person "TRA Policy Staff" "TRA policy staff" "traPolicylUser"
                
                   
                
                teachingRegulationSystem = softwaresystem "Teaching Regulation System" "Allows teachingProfessionals to view information about their bank accounts, and make payments." {

                    group "TRS Professional Status" {
                        qualificationsAPI = container "Qualified Teachers API" "Provides TRA qualifications QTS, EYTS, MQ and TRA Sanction information via JSON/HTTPS API" ".Net7 ASP Application" {
                            trsETLComponent = component "ETL" "Component to extract, transform and load various data resources needed by TRS" ".Net Classes" "Component"
                            trnGenAPI = component "TRN Gen API" "Component to handle TRN generation" ".Net Classes" "Component"
                            crmHandler = component "CRM" "Component to handle D365 interactions" ".Net Classes" "Component"
                           
                            giaHandler = component "GIA" "Component to handle Get An Identity interactions (web hooks etc)" ".Net Classes" "Component"
                            securityHandler = component "Security" "Component to handle Security (api keys etc" ".Net Classes" "Component"
                            loggingHandler = component "Logging" "Component to handle Logging" ".Net Classes" "Component"
                            
                            apiEndPoints = component "API Versions" "Component API endpoints (V1/V2/V3..)" ".Net Classes" "Component"
                        }
                        trsDatabase = container "TRS Database" "Stores teaching regulation information, access logs, etc." "PostgreSQL (TBC) Database" "Database" {
                                professionalStatusSchema = component "Professional Status" "A database schema holding a record of professional status, linking the regulated status's for a teacher including Qualifications, Inductions, Sanctions & Prohibitions " "Relational DB Schema" "Database"
                        }
                        trsStaffPages = container "TRS Staff Pages" "Delivers TRA staff access to maintain the Professional Status of a teacher" ".Net7 ASP Application or Rails (TBC)" "Spring MVC Rest Controller"
                        trsStorage = container "TRS Storage" "Storage Container" "Azure" "Database" {
                                trsBlob = component "TRS Blob Storage" "Storage account for TRS unstructured data" "Unstructured data storage service" "Database"
                        }
                        viewMyQualificationsApp = container "Access My Teaching Qualifications" "Provides a public facing service for teachers to view their TRA regulated qualifications (QTS, MQ, Induction also other quals e.g. NPQ's)" "Ruby On Rails Application" "TRA Digital Service"
                        checkTeachingQualificationsApp = container "Check Teaching Qualifications" "Provides an web application for employers of Teachers to check their right to teach in England" "" "TRA Digital Service"
                        applyForQTSApp = container "Apply For QTS" "Provides a public facing service for non UK teachers to apply for equivelence award of QTS so they can teach in England" "Ruby On Rails Application" "TRA Digital Service"
                    }

                    group "DBS Checking" {
                        prohibitionAPI = container "DBS API" "Provides FUll DBS barred check via a JSON/HTTPS API" ".Net7 ASP Application" 
                        dbsDatabase = container "DBS Databse" "Provides a copy of DBS data to enable checks satisfying the statutory obligation on DfE to do so" "PostgreSQL 14.x.x +" "Database"{
                            fullDBSSchema = component "DBS Copy" "A database schema holding full dbs list a.k.a 'Barred List' " "Relational DB Schema" "Database"
                        }
                         dbsQuickCheckApp = container "DBS Web Application" "Provides a public facing DBS check, to fulfill DfE statutory obligation on behalf of Home Office" ".Net7 ASP Application or Rails (TBC)" "TRA Digital Service"{    
                            dbscheckPages = component "DBS Web Pages" "Delivers internet facing Gov.Uk digital service to check anyone against DBS barred list" ".Net7 ASP Application or Rails (TBC)" "Spring MVC Rest Controller"
                            dbsStaffPages = component "DBS Staff Pages" "Delivers TRA staff access to maintain the barred list, uploading files etc." ".Net7 ASP Application or Rails (TBC)" "Spring MVC Rest Controller"
                        }
                    }

                    group "TRS Utilities" {
                        trnGeneratorApp = container "TRN Generator App" "Generates TRN's (Teacher Reference Numberd" ".Net7 console application"
                        findALostTRNApp = container "Find A Lost TRN" "Provides a public facing service for anybody to find a lost TRN (Teacher Reference Number)" "Ruby On Rails Application" "TRA Digital Service"
                    }
                        
                    }
            /*
                 * Environments: showing the main deployment containers and software systems to support Prohibition, Qualifications and Induction
            
                deploymentEnvironment "Prohibition" {
                    deploymentNode "Teacher Regulation System" "" ".Net API, PostgreSQL, Ruby On Rails Web Application" {
                        deploymentNode "TRS Database" "" "PostgreSQL Databse Instance" {
                            prohibitionDataInstance = containerInstance trsDatabase
                        }
                        deploymentNode "Docker Container - Web Server" "" "Docker" {
                            
                                prohibitionWebApplicationInstance = containerInstance dbsQuickCheckApp
                                prohibitionAPIApplicationInstance = containerInstance prohibitionAPI
                            
                        }
                        deploymentNode "Non TRA Prohibition Data" "" "DBS, GTCNI, GTCS, EWC" "" {
                        deploymentNode "MS Sharepoint" "" "" "" {
                            softwareSystemInstance dfeSharepoint
                            softwareSystemInstance email
                        }
                    }
                    deploymentNode "Check Teaching Qualifications" "" "Provides an web application for employers of Teachers to check their right to teach in England" "" {
                       
                            checkTeachingQualsApplicationInstance = containerInstance checkTeachingQualificationsApp
                        }
                        
                    }
                    deploymentNode "TRA TMU" "" "Teacher Misconduct Case Management" "" {
                        deploymentNode "TMS D365" "" "" "" {
                            softwareSystemInstance teacherMisconduct
                        }
                    }

                }
                */
            

        # relationships between people and software systems
        teachingProfessional -> teachingRegulationSystem "Views account balances, and makes payments using"
        teachingProfessional -> supportStaff "Asks questions to" "Telephone"
        supportStaff -> teacherMisconduct "Uses"
        ewc -> email "Sends secure email to" "Secure email software (TBC)"
        gtcni -> email "Sends secure email to" "Secure email software (TBC)"
        gtcs -> email "Sends secure email to" "Secure email software (TBC)"
        traPolicyPerson -> email "Processes GTCNI, GTCS, EWC prohibition notifications" "Secure Emails"
        traPolicyPerson -> email "Processes DBS daily updates" "Secure Emails"
        traPolicyPerson -> email "Processes DBS weekly updates (Teacher only records)" "Secure Emails"
        traPolicyPerson -> dbsStaffPages "Manually adds (EWC,GTCS,GTCNI) prohibition notification data" "Staff Support Pages"
        traPolicyPerson -> dbsStaffPages "Uploads DBS updates" "Staff Support Pages"
        ewc -> dbsQuickCheckApp "Uses Web Application to 'quick check' DBS" "HTPPS"
        gtcni -> dbsQuickCheckApp "Uses Web Application to 'quick check' DBS" "HTPPS"
        gtcs -> dbsQuickCheckApp "Uses Web Application to 'quick check' DBS" "HTPPS"
        employerOfTeacher -> dbsQuickCheckApp "Uses Web Application to 'quick check' DBS" "HTPPS"
        memberOfPublic -> dbsQuickCheckApp "Uses Web Application to 'quick check' DBS" "HTPPS"
        teachingProfessional -> checkTeachingQualificationsApp "Uses Web Application to view qualifications and certificates" "HTTPS"
        teachingProfessional -> registerForITT "Uses Web Application to register for ITT" "HTTPS"
        teachingProfessional -> applyForQTSApp "Uses Web Application to apply for QTS equivelence award"
        teachingProfessional -> findALostTRNApp "Uses Web Application to find a TRN to access other services"
        teachingProfessional -> claimTeacherPAyments "Uses Web Application to claim teaching bursary payments"
        employerOfTeacher -> cpd "Manages Induction" "REST/HTTPS"
        tpsCapita -> dfeSFTP "Put workforce data files" "SFTP"
        hesa -> registerForITT "Notifies" "REST/HTTPS"
        memberOfPublic -> referSeriousMisconduct "Uses Web Application to refer teacher misconduct" "HTTPS"
        employerOfTeacher -> referSeriousMisconduct "Uses Web Application to refer teacher misconduct" "HTTPS"
        claimTeacherPAyments -> qualificationsAPI "Uses" "REST/HTTPS"
        referSeriousMisconduct -> teacherMisconduct "Uses" "REST/HTTPS"
        teachingProfessional -> cpd "Uses Web Application to register for NPQ / Early Years" "HTTPS"
        providers -> registerForITT "Uses Web Application to update DfE of training outcomes" "HTTPS"
        providers -> cpd "Uses Web Application to update DfE of training outcomes" "HTTPS"
        traPolicyPerson -> trsStaffPages
        supportStaff -> trsStaffPages

        # relationships to/from containers
        tmuD365 -> prohibitionAPI "Fires events to" "REST/HTTPS"
        prohibitionAPI -> tmuD365 "Checks case status" "REST/HTTPS"
        prohibitionAPI -> trsDatabase "Performs CRUD operations on" "REST/HTTPS"
        qualificationsAPI -> trsDatabase "Performs CRUD operations on" "REST/HTTPS"
        dbsQuickCheckApp -> prohibitionAPI "Checks DBS data" "REST/HTTPS"
        qualificationsAPI -> gias "Gets establishment data related to the teaching professional"
        applyForQTSApp  -> qualificationsAPI "Uses"
        findALostTRNApp -> qualificationsAPI "Uses"
        viewMyQualificationsApp -> qualificationsAPI "Uses"
        checkTeachingQualificationsApp -> qualificationsAPI "Uses"
        qualificationsAPI -> prohibitionAPI "Uses"
        teachingIdentity -> prohibitionAPI "Provides OAUth grant and access tokens"
        cpd -> teachingIdentity "Uses"
        viewMyQualificationsApp -> teachingIdentity "Uses"
        checkTeachingQualificationsApp -> dfeSign "Uses"
        registerForITT -> qualificationsAPI "Fires events to" "REST/HTTPS"
        cpd -> qualificationsAPI "Fires events to" "REST/HTTPS"
        qualificationsAPI -> dfeSFTP "Reads from" "SFTP"
        qualificationsAPI -> trsBlob "Writes to" "REST/HTTPS"
        trsETLComponent -> dfeSFTP "Extracts files from"
        trsETLComponent -> trsBlob "Puts files"
        trsETLComponent -> professionalStatusSchema "Transforms & Loads data"
        qualificationsAPI -> trnGeneratorApp "Uses"
        trsStaffPages -> qualificationsAPI "Uses"
       
        # relationships to/from components
        dbsStaffPages -> prohibitionAPI "CRUD Operations" "Oauth2/HTTPS"
        dbscheckPages -> prohibitionAPI "CRUD Operations" "Oauth2/HTTPS"
        dbsQuickCheckApp -> prohibitionAPI "READ ONLY Operations" "Oauth2/HTTPS"
        prohibitionAPI -> fullDBSSchema "CRUD Operations" "Oauth2/HTTPS"
        prohibitionAPI -> dbsDatabase "CRUD Operations" "Oauth2/HTTPS"
        prohibitionAPI -> professionalStatusSchema "CRUD Operations" "Oauth2/HTTPS"
        qualificationsAPI -> professionalStatusSchema "CRUD Operations" "Oauth2/HTTPS"
        professionalStatusSchema -> dbsDatabase "FK Relationship, implements principle of least privilage"
        qualificationsAPI -> professionalStatusSchema "CRUD Operations" "Oauth2/HTTPS"
        trnGenAPI -> crmHandler
        crmHandler -> dqtD365
        giaHandler -> teachingIdentity
                         
          }              
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        systemcontext teachingRegulationSystem "SystemContext" {
            include *
            animation {
                teachingRegulationSystem
                teachingProfessional
                teacherMisconduct   
            }
            autoLayout
            description "The system context diagram for the Teaching Regulation System."
            properties {
                structurizr.groups false
            }
        }
        container teachingRegulationSystem "Containers" {
            include *
            animation {
                teachingProfessional
                prohibitionAPI
                qualificationsAPI
                trnGeneratorApp 
                trsDatabase
                trsStorage
                dbsDatabase
                dbsQuickCheckApp 
                applyForQTSApp
                findALostTRNApp
                viewMyQualificationsApp
                checkTeachingQualificationsApp
                trsStaffPages
            }
            autoLayout
            description "The container diagram for the Teaching Regulation System."
        }
        container teacherMisconduct "TMUContainers" {
            include *
            animation {
                tmuD365
            }
            autoLayout
            description "The container diagram for the Teacher Misconduct System."
        }
       
        component dbsQuickCheckApp "DBSQuickCheckComponents"{
            include *
            animation {
                dbscheckPages
                dbsStaffPages
                
            }
            autoLayout
            description "The component diagram for the DBS Quick Check App"

        }
        component trsDatabase "DBComponents" {
            include *
            animation {
                professionalStatusSchema
            }
            autoLayout
            description "The component diagram for the TRS Database"
        }
        component qualificationsAPI "TRSAPIComponents" {
            include *
            animation {
                trsETLComponent
            }
            autoLayout
            description "The component diagram for the TRS API"
        }
        /*
        deployment teachingRegulationSystem "Prohibition" "ProhibitiontDeployment" {
            include *
            animation {
                prohibitionDataInstance
                prohibitionWebApplicationInstance prohibitionAPIApplicationInstance
                checkTeachingQualsApplicationInstance
            }
            autoLayout
            description "An example prohibition deployment instance for the Teacher Regulation Instance"
        }
        */
       
        styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "traPolicylUser" {
                background #294226
            }
            element "externalDigitalUser" {
                background #08427b
            }
            element "employerOfTeacher" {
                background #520f3f
            }
            element "teachingCouncils" {
                background #877d08
            }
            element "TRA Support Staff" {
                background #999999
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "TS Digital Service" {
                background #5a5673
                color #ffffff
            }
            element "Deprocated" {
                background #fc0516
                color #ffffff
            }
            
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Authentication" {
                background #eb34e1
                color #ffffff
            }
            element "TRA Digital Service" {
                background #294226
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Web Browser" {
                shape WebBrowser
            }
            element "Mobile App" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Failover" {
                opacity 25
            }
        }
    }
}