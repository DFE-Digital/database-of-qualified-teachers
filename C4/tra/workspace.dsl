workspace "TRA Workspace" "The system context diagram for my software system." {

    !impliedRelationships "false" 
    !identifiers "hierarchical" 

    model {
        enterprise "Enterprise" {
            DatabaseofQualifiedTeachers = softwareSystem "Database of Qualified Teachers" "The DQT is a Customer Relationship Management (CRM) system containing records of all TRN holders in England and Wales" {
                CRM = container "CRM" "The main component of the DQT application" "Dynamics 365" 
                ReportingDatabase = container "Reporting Database" "" "SQL Server" "Database" 
                Fileserver = container "File server" "Secure FTP Server allowing file exchange across applications" "SFTP Server" "Database" 
                TeacherstatusAPI = container "Teacher status API" "An API layer customised for CPD and Claim" "DfE EAPIM API" "RoundedBox" {
                    Heartbeat = component "Heartbeat" "returns 200 to check that EAPIM platform is up" 
                    Teacher = component "Teacher" "/teachers/{trn}?birthdate=1990-01-15" 
                    WhoAmI = component "WhoAmI" "returns info on the clients login" 
                }
                WebPortal = container "Web Portal" "" ".Net Portal and Power Apps portal" "Web" {
                    AppropriateBodyportal = component "Appropriate Body portal" "Used by the Local Authorities and some schools to claim teachers for Induction and to submit induction results." "" "Web" 
                    EmployerPortal = component "Employer Portal" "Used by Nurseries, Schools, Academies, Free schools, Independent schools and Colleges." "" "Web" 
                    TeacherSelfServePortal = component "Teacher Self Serve Portal" "Used by qualified and trainee teachers (who have been allocated a TRN reference)." "" "Web" 
                    ITTProviderPortal = component "ITT Provider Portal" "This portal is available for Higher Education Institutions (HEIs), who are responsible for Initial Teacher Training" "" "Web" 
                    OrganisationPortal = component "Organisation Portal" "Used by Teacher supply agencies, local authorities and training providers." "" "Web" 
                    MMRapplyforQTSPortal = component "MMR (apply for QTS) Portal" "Provides a set of online application forms for user to apply for recognition of their teacher qualifications in England" "" "Web" 
                }
                WebService = container "Web Service" "A service that receives organisational data from DSI" "" "RoundedBox" 
                ETL = container "ETL" "A series of automated jobs to process data" "SSIS Server" "Pipe" {
                    DQTHESAimportinterface = component "DQT - HESA import interface" "HEIs ITT collection" "" "Pipe" 
                    DQTHESAexportinterface = component "DQT - HESA export interface" "TRNs exports to HESA" "" "Pipe" 
                    DQTCAPITAinterface = component "DQT - CAPITA interface" "TRNs export" "" "Pipe" 
                    Trainingproviderinterface = component "Training provider interface" "Allow bulk uploads of trainee teachers" "" "Pipe" 
                    DQTDMSInterface = component "DQT - DMS Interface" "Data import from DTTP" "" "Pipe" 
                    DQTGTCWINTERFACE = component "DQT - GTCW INTERFACE" "General Teaching Council for Wales import of QTSs and Induction data" "" "Pipe" 
                    DQTNPQInterface = component "DQT- NPQ Interface" "National professional data import" "" "Pipe" 
                    DQTEDUBASEInterface = component "DQT - EDUBASE Interface" "GiAS data import" "" "Pipe" 
                }
                Reportbuilder = container "Report builder" "" "" "Folder" 
                Postgrescache = container "Postgres cache" "Data cache. Retries failed updates to the CRM" "Postgres, Gov PaaS" "Database,Accessory" 
                Rediscache = container "Redis cache" "Message cache. Handles async retries of failed updates to the CRM" "Redis, Gov PaaS" "Database,Accessory" 
                QualifiedTeacherAPI = container "Qualified Teacher API" "Restful API that returns qualifier teachers data" "Rest deployed on Gov PaaS" "RoundedBox" 
            }
            BATRegisterTraineeTeachers = softwareSystem "BAT - Register Trainee Teachers" "Support the exchange of data on Trainee Teachers in England between accredited Initial Teacher Training (ITT) providers and DFE." "OutsideDQT" 
        }
        DQTBAUinternalteam = person "DQT - BAU internal team" 
        TMSBAUTeam = person "TMS - BAU Team" "" "OutsideDQT" 
        EmployersSchoolsandcolleges = person "Employers (Schools and colleges)" "Nurseries, Schools, Academies, Free schools, Independent schools and Colleges" "ExternalUser" 
        AppropriateBody = person "Appropriate Body" "Local Authorities and schools" "ExternalUser" 
        HEIsTeacherTraineeProvider = person "HEIs - Teacher Trainee Provider" "An organisation offering programmes to train people to teach in schools" "ExternalUser" 
        Organisations = person "Organisations" "Teacher supply agencies, local authorities and training providers" "ExternalUser" 
        TraineeTeachers = person "Trainee Teachers" "Trainee Teachers with an allocated TRN" "ExternalUser" 
        Teachers = person "Teachers" "" "ExternalUser" 
        TeacherPanellist = person "Teacher Panellist" "" "ExternalUser" 
        ProfessionalTeachers = person "Professional Teachers" "" "ExternalUser" 
        SchoolHiringStaff = person "School Hiring Staff" "" "ExternalUser" 
        LeadProviders = person "Lead Providers" "" "ExternalUser" 
        Partecipants = person "Partecipants" "" "ExternalUser" 
        SchoolUsers = person "School Users" "" "ExternalUser" 
        DatabaseofTeacherTraineesProviders = softwareSystem "Database of Teacher Trainees & Providers" "A registry of Teacher Trainees & Providers" "OutsideDQT" 
        DisclosureandBarringService = softwareSystem "Disclosure and Barring Service" "Processes and issues DBS checks for England, Wales, the Channel Islands and the Isle of Man." "External" 
        EducationWorkforceCouncilWales = softwareSystem "Education Workforce Council Wales" "Regulator for the education workforce in Wales" "External" 
        Funding = softwareSystem "Funding" "Allocates funding to schools and Universities" "OutsideDQT" 
        CorporateAssurance = softwareSystem "Corporate Assurance" "An auditing body" "OutsideDQT" 
        TeachersAnalysisDivision = softwareSystem "Teachers Analysis Division" "ITT Analysis Unit" "OutsideDQT" 
        AzuresEnterpriseAPIManagement = softwareSystem "Azure's Enterprise API Management" "API management tool" "OutsideDQT" 
        EmailSystem = softwareSystem "Email System" "Secure email used to share data across organisations" "OutsideDQT" 
        NationAuditOffice = softwareSystem "Nation Audit Office" "Auditing Body" "OutsideDQT" 
        BATFindPostgraduateTeacherTrainingCourses = softwareSystem "BAT - Find Postgraduate Teacher Training Courses" "Find a course to become a Teacher" "OutsideDQT" 
        ContinuingProfessionalDevelopment = softwareSystem "Continuing Professional Development" "Supports Early Career Framework and National Professional Qualifications" "OutsideDQT" 
        ClaimAdditionalPaymentsforTeaching = softwareSystem "Claim Additional Payments for Teaching" "Allows eligible teachers to apply for retention payments" "OutsideDQT" 
        TeacherPensionService = softwareSystem "Teacher Pension Service" "" "External" 
        TeacherMisconductService = softwareSystem "Teacher Misconduct Service" "deals with misconduct cases and the engagement with teachers from referral to resolution." "OutsideDQT" {
            TMSDynamics365CRM = container "TMS - Dynamics 365 CRM" "" "" "OutsideDQT" 
            PanellistPortal = container "Panellist Portal" "" "CRM Add On Component" "OutsideDQT,Web" 
            MicrosoftSharepoint = container "Microsoft Sharepoint" "" "" "OutsideDQT" 
            MicrosoftB2B = container "Microsoft B2B" "IDAM solution used for Panellist users" "" "OutsideDQT" 
        }
        HigherEducationStatisticsAgency = softwareSystem "Higher Education Statistics Agency" "Higher Education Statistics Agency" "External" 
        BATApplyforpostgraduateteachertraining = softwareSystem "BAT - Apply for postgraduate teacher training" "" "OutsideDQT" 
        GetintoTeaching = softwareSystem "Get into Teaching" "A website for teachers for training and being a teacher." "OutsideDQT" 
        TeachingVacancies = softwareSystem "Teaching Vacancies" "A website to search for teaching jobs" "OutsideDQT" 
        Getinformationaboutschools = softwareSystem "Get information about schools" "Register of schools and colleges in England" "OutsideDQT" 
        DfESignIn = softwareSystem "DfE Sign In" "Authentication solution for school staff to access DfE online services" "OutsideDQT" 
        DfESignIn -> DatabaseofQualifiedTeachers "Push organisational data to" 
        EducationWorkforceCouncilWales -> DatabaseofQualifiedTeachers "Checks TRNs and QTSs through" 
        EducationWorkforceCouncilWales -> TeacherPensionService "Pulls data from" 
        DisclosureandBarringService -> DatabaseofQualifiedTeachers "Checks TRNs and QTSs from" 
        HEIsTeacherTraineeProvider -> HigherEducationStatisticsAgency "Submits trainee data" "" "Synchronous" 
        EmployersSchoolsandcolleges -> DfESignIn "Signs in" 
        AppropriateBody -> DfESignIn "signs in" 
        Organisations -> DfESignIn "signs in" 
        HEIsTeacherTraineeProvider -> DfESignIn "signs in" 
        DatabaseofTeacherTraineesProviders -> DatabaseofQualifiedTeachers.Fileserver "Uploads and downloads TRNs and QTSs files" 
        DatabaseofQualifiedTeachers -> HigherEducationStatisticsAgency "Pulls trainee data from" "" "Synchronous" 
        DQTBAUinternalteam -> DatabaseofQualifiedTeachers.CRM "Access" 
        DfESignIn -> DatabaseofQualifiedTeachers.WebPortal "redirects to" 
        DatabaseofQualifiedTeachers.WebService -> DatabaseofQualifiedTeachers.ReportingDatabase "updates" 
        DatabaseofQualifiedTeachers.ETL -> DatabaseofQualifiedTeachers.Fileserver "reads from" 
        Teachers -> DatabaseofQualifiedTeachers.WebPortal "log into" 
        DfESignIn -> DatabaseofQualifiedTeachers.WebService "Push organisational data to" "" "Orthogonal" 
        ContinuingProfessionalDevelopment -> AzuresEnterpriseAPIManagement "makes authenticated requests through" 
        ClaimAdditionalPaymentsforTeaching -> AzuresEnterpriseAPIManagement "makes authenticated api requests through" 
        AzuresEnterpriseAPIManagement -> DatabaseofQualifiedTeachers.TeacherstatusAPI "approve API users and sets policies" 
        DatabaseofQualifiedTeachers.ReportingDatabase -> DatabaseofQualifiedTeachers.Reportbuilder "exports to" 
        DQTBAUinternalteam -> EmailSystem "Reads data from" 
        DfESignIn -> DatabaseofQualifiedTeachers.WebPortal.AppropriateBodyportal "redirects to" 
        DfESignIn -> DatabaseofQualifiedTeachers.WebPortal.EmployerPortal "redirects to" 
        DfESignIn -> DatabaseofQualifiedTeachers.WebPortal.ITTProviderPortal "redirects to" 
        DfESignIn -> DatabaseofQualifiedTeachers.WebPortal.OrganisationPortal "redirects to" 
        Teachers -> DatabaseofQualifiedTeachers.WebPortal.MMRapplyforQTSPortal "apply for QTS" 
        Teachers -> DatabaseofQualifiedTeachers.WebPortal.TeacherSelfServePortal "check teacher status" 
        DatabaseofQualifiedTeachers.WebPortal.AppropriateBodyportal -> DatabaseofQualifiedTeachers.ReportingDatabase "reads and writes to" 
        DatabaseofQualifiedTeachers.WebPortal.EmployerPortal -> DatabaseofQualifiedTeachers.ReportingDatabase "reads and writes to" 
        DatabaseofQualifiedTeachers.WebPortal.ITTProviderPortal -> DatabaseofQualifiedTeachers.ReportingDatabase "reads and writes to" 
        DatabaseofQualifiedTeachers.WebPortal.MMRapplyforQTSPortal -> DatabaseofQualifiedTeachers.ReportingDatabase "reads and writes to" 
        DatabaseofQualifiedTeachers.WebPortal.OrganisationPortal -> DatabaseofQualifiedTeachers.ReportingDatabase "reads and writes to" 
        DatabaseofQualifiedTeachers.WebPortal.TeacherSelfServePortal -> DatabaseofQualifiedTeachers.ReportingDatabase "reads and writes to" 
        TMSBAUTeam -> TeacherMisconductService.TMSDynamics365CRM "logs into" 
        TMSBAUTeam -> TeacherMisconductService.MicrosoftSharepoint "uses" 
        TeacherMisconductService.MicrosoftB2B -> TeacherMisconductService.PanellistPortal "redirects to" 
        TeacherMisconductService.PanellistPortal -> TeacherMisconductService.TMSDynamics365CRM "reads from and writes to" 
        TeacherPanellist -> TeacherMisconductService.MicrosoftB2B "signs in using" 
        TeacherMisconductService.MicrosoftSharepoint -> Teachers "sends notification to" 
        TMSBAUTeam -> Teachers "sends misconduct cases information via post to" 
        DatabaseofQualifiedTeachers.WebPortal -> DatabaseofQualifiedTeachers.CRM "persists data to and reads from" ".NET SDK" 
        DatabaseofQualifiedTeachers.CRM -> DatabaseofQualifiedTeachers.ReportingDatabase "Syncs data into" 
        DatabaseofQualifiedTeachers.ETL -> DatabaseofQualifiedTeachers.CRM "writes to" 
        DatabaseofQualifiedTeachers.TeacherstatusAPI -> DatabaseofQualifiedTeachers.CRM "reads and writes" 
        DQTBAUinternalteam -> DatabaseofQualifiedTeachers.Reportbuilder "Creates reports" "PowerBI, Microsoft reporting services" 
        DatabaseofQualifiedTeachers.QualifiedTeacherAPI -> ClaimAdditionalPaymentsforTeaching 
        DatabaseofQualifiedTeachers.QualifiedTeacherAPI -> ContinuingProfessionalDevelopment 
        DatabaseofQualifiedTeachers.CRM -> DatabaseofQualifiedTeachers.QualifiedTeacherAPI 
        DatabaseofTeacherTraineesProviders -> HigherEducationStatisticsAgency "Pulls data" "" "Synchronous" 
        DatabaseofTeacherTraineesProviders -> DatabaseofQualifiedTeachers "Issues TRN requests and recommend for QTSs" "" "Synchronous,Asynchronous" 
        TeachersAnalysisDivision -> DatabaseofTeacherTraineesProviders "pulls data from" "" "Synchronous" 
        HEIsTeacherTraineeProvider -> BATRegisterTraineeTeachers "Submits trainee data" "" "Synchronous" 
        BATRegisterTraineeTeachers -> DatabaseofTeacherTraineesProviders "Issues trn requests" "" "Synchronous" 
        EmployersSchoolsandcolleges -> DatabaseofQualifiedTeachers "View teacher records and notify  teacher’s employment status" "Web Portal" 
        AppropriateBody -> DatabaseofQualifiedTeachers "claim teachers for Induction and to submit induction results" "Web Portal" 
        Organisations -> DatabaseofQualifiedTeachers "View teacher records" "Web Portal" 
        TraineeTeachers -> DatabaseofQualifiedTeachers "Update their personal records" "Web Portal" 
        HEIsTeacherTraineeProvider -> DatabaseofQualifiedTeachers "View and update trainee teacher records" "Web Portal" 
        Teachers -> DatabaseofQualifiedTeachers "apply for recognition of their teacher qualifications in England" "Web Portal" 
        ContinuingProfessionalDevelopment -> DatabaseofQualifiedTeachers "Pulls Teachers Data from" 
        DatabaseofQualifiedTeachers -> TeacherPensionService "Sends and pull TRNs data" 
        ClaimAdditionalPaymentsforTeaching -> TeacherPensionService "Validates teacher status" 
        ClaimAdditionalPaymentsforTeaching -> DatabaseofQualifiedTeachers "Validates teacher status" 
        TeacherPanellist -> TeacherMisconductService "Manages their attendance schedule through" "Web Portal" 
        TeacherMisconductService -> DatabaseofQualifiedTeachers "Validates teacher status" 
        TeachersAnalysisDivision -> DatabaseofQualifiedTeachers "pulls data from" 
        TeachersAnalysisDivision -> BATApplyforpostgraduateteachertraining "pulls data from" 
        ProfessionalTeachers -> TeachingVacancies "Looks for jobs" 
        SchoolHiringStaff -> TeachingVacancies "Publish Jobs" 
        Partecipants -> ContinuingProfessionalDevelopment 
        SchoolUsers -> ContinuingProfessionalDevelopment 
        LeadProviders -> ContinuingProfessionalDevelopment 
        DfESignIn -> Getinformationaboutschools "Pulls organisational data from" 
    }

    views {
        systemLandscape "TeacherServicesLandscape" {
            include DatabaseofTeacherTraineesProviders 
            include DatabaseofQualifiedTeachers 
            include DisclosureandBarringService 
            include EducationWorkforceCouncilWales 
            include Funding 
            include CorporateAssurance 
            include TeachersAnalysisDivision 
            include NationAuditOffice 
            include BATRegisterTraineeTeachers 
            include BATFindPostgraduateTeacherTrainingCourses 
            include EmployersSchoolsandcolleges 
            include AppropriateBody 
            include HEIsTeacherTraineeProvider 
            include Organisations 
            include TraineeTeachers 
            include Teachers 
            include ContinuingProfessionalDevelopment 
            include ClaimAdditionalPaymentsforTeaching 
            include TeacherPensionService 
            include TeacherMisconductService 
            include TeacherPanellist 
            include HigherEducationStatisticsAgency 
            include BATApplyforpostgraduateteachertraining 
            include GetintoTeaching 
            include TeachingVacancies 
            include ProfessionalTeachers 
            include SchoolHiringStaff 
            include LeadProviders 
            include Partecipants 
            include SchoolUsers 
            include Getinformationaboutschools 
            include DfESignIn 
        }

        systemContext DatabaseofQualifiedTeachers "DQTSystemContext" {
            include DatabaseofTeacherTraineesProviders 
            include DatabaseofQualifiedTeachers 
            include DisclosureandBarringService 
            include EducationWorkforceCouncilWales 
            include Funding 
            include TeachersAnalysisDivision 
            include EmployersSchoolsandcolleges 
            include AppropriateBody 
            include HEIsTeacherTraineeProvider 
            include Organisations 
            include TraineeTeachers 
            include Teachers 
            include ContinuingProfessionalDevelopment 
            include ClaimAdditionalPaymentsforTeaching 
            include TeacherPensionService 
            include TeacherMisconductService 
            include HigherEducationStatisticsAgency 
            include DfESignIn 
        }

        container DatabaseofQualifiedTeachers "NewDQTAPIContainer" {
            include DatabaseofTeacherTraineesProviders 
            include DisclosureandBarringService 
            include EducationWorkforceCouncilWales 
            include DatabaseofQualifiedTeachers.CRM 
            include DatabaseofQualifiedTeachers.ReportingDatabase 
            include DQTBAUinternalteam 
            include DatabaseofQualifiedTeachers.WebPortal 
            include DatabaseofQualifiedTeachers.Reportbuilder 
            include EmailSystem 
            include DatabaseofQualifiedTeachers.Postgrescache 
            include DatabaseofQualifiedTeachers.Rediscache 
            include DatabaseofQualifiedTeachers.QualifiedTeacherAPI 
            include EmployersSchoolsandcolleges 
            include AppropriateBody 
            include HEIsTeacherTraineeProvider 
            include Organisations 
            include Teachers 
            include ContinuingProfessionalDevelopment 
            include ClaimAdditionalPaymentsforTeaching 
            include HigherEducationStatisticsAgency 
            include DfESignIn 
        }

        container TeacherMisconductService "TMSContainer" {
            include TeacherMisconductService.TMSDynamics365CRM 
            include TeacherMisconductService.PanellistPortal 
            include TeacherMisconductService.MicrosoftSharepoint 
            include TeacherMisconductService.MicrosoftB2B 
            include TMSBAUTeam 
            include Teachers 
            include TeacherPanellist 
        }

        container DatabaseofQualifiedTeachers "TraDQTContainers" {
            include DatabaseofTeacherTraineesProviders 
            include DisclosureandBarringService 
            include EducationWorkforceCouncilWales 
            include DatabaseofQualifiedTeachers.CRM 
            include DatabaseofQualifiedTeachers.ReportingDatabase 
            include DatabaseofQualifiedTeachers.Fileserver 
            include DatabaseofQualifiedTeachers.TeacherstatusAPI 
            include DQTBAUinternalteam 
            include DatabaseofQualifiedTeachers.WebPortal 
            include DatabaseofQualifiedTeachers.ETL 
            include AzuresEnterpriseAPIManagement 
            include DatabaseofQualifiedTeachers.Reportbuilder 
            include EmailSystem 
            include EmployersSchoolsandcolleges 
            include AppropriateBody 
            include HEIsTeacherTraineeProvider 
            include Organisations 
            include Teachers 
            include ContinuingProfessionalDevelopment 
            include ClaimAdditionalPaymentsforTeaching 
            include HigherEducationStatisticsAgency 
            include DfESignIn 
        }

        component DatabaseofQualifiedTeachers.WebPortal "DQTPortalComponents" {
            include DatabaseofQualifiedTeachers.ReportingDatabase 
            include DatabaseofQualifiedTeachers.WebPortal.AppropriateBodyportal 
            include DatabaseofQualifiedTeachers.WebPortal.EmployerPortal 
            include DatabaseofQualifiedTeachers.WebPortal.TeacherSelfServePortal 
            include DatabaseofQualifiedTeachers.WebPortal.ITTProviderPortal 
            include DatabaseofQualifiedTeachers.WebPortal.OrganisationPortal 
            include DatabaseofQualifiedTeachers.WebPortal.MMRapplyforQTSPortal 
            include EmployersSchoolsandcolleges 
            include AppropriateBody 
            include HEIsTeacherTraineeProvider 
            include Organisations 
            include Teachers 
            include DfESignIn 
        }

        component DatabaseofQualifiedTeachers.ETL "DataInterfaceComponents" {
            include DatabaseofQualifiedTeachers.ReportingDatabase 
            include DatabaseofQualifiedTeachers.Fileserver 
            include DatabaseofQualifiedTeachers.ETL.DQTHESAimportinterface 
            include DatabaseofQualifiedTeachers.ETL.DQTHESAexportinterface 
            include DatabaseofQualifiedTeachers.ETL.DQTCAPITAinterface 
            include DatabaseofQualifiedTeachers.ETL.Trainingproviderinterface 
            include DatabaseofQualifiedTeachers.ETL.DQTDMSInterface 
            include DatabaseofQualifiedTeachers.ETL.DQTGTCWINTERFACE 
            include DatabaseofQualifiedTeachers.ETL.DQTNPQInterface 
            include DatabaseofQualifiedTeachers.ETL.DQTEDUBASEInterface 
        }

        styles {
            element "Accessory" {
                width "450" 
                height "300" 
            }
            element "Database" {
                shape "Cylinder" 
            }
            element "Element" {
                background "#648dd5" 
                color "#ffffff" 
            }
            element "External" {
                background "#28a197" 
            }
            element "ExternalUser" {
                background "#07437b" 
            }
            element "Folder" {
                shape "Folder" 
            }
            element "OutsideDQT" {
                background "#b4aaf0" 
            }
            element "Person" {
                shape "Person" 
            }
            element "Pipe" {
                shape "Robot" 
            }
            element "RoundedBox" {
                shape "RoundedBox" 
            }
            element "Web" {
                shape "WebBrowser" 
            }
            relationship "Orthogonal" {
                routing "Orthogonal" 
            }
            relationship "Relationship" {
                # empty style 
            }
        }

    }

}