# Dev Ops

The Teacher Regulation Agency is supported by DfE Teacher Services digital teams. These are multi-skilled teams that develop, support and iterate the services using agile practices.

# Code

### Design History
* [Design History](https://github.com/DFE-Digital/tra-digital-design-history)

### Source Code
* [Apply For Qualified Teacher Status](https://github.com/DFE-Digital/apply-for-qualified-teacher-status)
* [DQT legacy portals (private)](https://github.com/DFE-Digital/dqt-web-portal)
* [Find A Lost TRN](https://github.com/DFE-Digital/find-a-lost-trn)
* [Qualified Teachers API](https://github.com/DFE-Digital/qualified-teachers-api)

### Dev Ops
* [Dev Ops and Automation](https://github.com/DFE-Digital/tra-crm-automation)
* [Monitoring](https://github.com/DFE-Digital/tra-paas-monitoring)
* [Shared](https://github.com/DFE-Digital/tra-shared-services)

### Prototypes & Docs
* [General Tech docs repo / Technical Spikes etc.](https://github.com/DFE-Digital/database-of-qualified-teachers)
* [Find-a-lost-TRN-prototype](https://github.com/DFE-Digital/find-a-lost-trn-prototype)


# Dev Ops and Support

TRA Services are supported by the Teacher Services Dev Ops team and DfE Service Management Teams. Deployment pipelines are created where possible. For more information contact Teacher Services Dev Ops.

### General Workflow (for detail see each service repo)

* GitHub branches (Push) deployed to DEV environment
    * Tests (unit tests, component tests, regression tests, coverage and code security scan) are completed

    * CVE scan and OWASP are completed

* GitHub pull requests are deployed to a temporary TEST environment 

    * Browser automation full stack tests are completed

    * Product owner approval, if needed

* GitHub main branch (merge from branch) deployed to the PREPROD environment 

    * Cypress/Selenium browser tests run

    * Once approved following peer review, the code is deployed to PROD

* Infrastructure As Code (IAC) by default [see repo for details](https://github.com/DFE-Digital/tra-crm-automation). IAC code to live with each service.

* Containerisation by default [see repo for details](https://github.com/DFE-Digital/tra-crm-automation)

* Separate service principal per application per environment.


# Monitoring

Services are monitored using a number of services and channels.
DfE Slack channels are integrated into a growing number of TRA service code bases, allowing direct and quick alerting using targeted channels. See Dev Ops code bases for more info.

[Service uptime](https://teacher-services-status.education.gov.uk/)

* GOV.UK PaaS is monitored 24/7 via [StatusCake](https://www.statuscake.com/) and a number of reporting and alerting tools to ensure the team is aware of any issues or incidents.

* [Logit.io](http://logit.io/) Managed ELK as a Service, Open Distro, Hosted Grafana & APM, which is used across Teacher Services, and provides aggregated logging at the system and application level. 

* [Sentry.io](http://sentry.io/) - which is used widely across Teacher Services and provides error logging and threshold alerting

* [Grafana](https://grafana.com/) - which is used across Teacher Services to provide time series metrics at the system and application level

* [Prometheus.io](http://prometheus.io/) - which provides alerts to the team and any key stakeholders via the service team Slack channel and email alerts via GOV.UK Notify

# Availability & supported hours


* The TRA services and systems are available to users 24/7 365 days a week, with the exception of planned outages.

* The availability target for the services and systems is 99% during supported hours. 

* Dynamics 365 CE is part of the Microsoft Office 365 platform. The Office 365 is a hosted ‘software as a service’ platform with an uptime of 99.9%.  More information can be found [here](https://products.office.com/en-us/business/office-365-trust-center-operations).

* Dynamics CRM, although part of the Office 365 product family, has its own availability data here [International availability of Dynamics 365 | Microsoft Docs
](https://docs.microsoft.com/en-us/dynamics365/get-started/availability)

* TRA services hosted on GOV.UK PaaS aim for 99.95% uptime for applications and you [can view historical performance](https://status.cloud.service.gov.uk/). GOV.UK PaaS offers 24-hour platform-level support. The GOV.UK PaaS team provides 24/7 [support](https://admin.london.cloud.service.gov.uk/support) for any platform-related issues. 

* The peak period of user activity is **July-October** due to a number of activities around new teachers registering and the new academic year. 

# Support

Supported hours are from 09:00 to 17:00 Monday to Friday, excluding Bank Holidays.

Unsupported hours are from 17:00 to 09:00 Monday to Friday and all-day Saturday and Sunday.

# Infrastructure / Deployment

By default we use PAAS services where possible. All code is open by default except a very small part of sensitive information and secrets/keys etc. As a general rule, legacy components tend to be deployed on IAAS into shared Azure infrastructure subscriptions. New digital services and components are deployed on either Azure PAAS or GOVPAAS subscriptions.


[High Level Infrastructure / Deployment View of TRA-Digital Technical Architecture](images/structurizr-1-TRADeployment-01-06-22.png)

# Continuous Security Validation

We are adding continuous security validation into our CI/CD pipelines to reduce the chances of exploitable flaws and vulnerabilities. We adopt a combination of automated and manual pen-testing.

Increasingly automated pen-testing is becoming a part of our continuous integration validation using tools such as Owasp Zed Attack Proxy ([ZAP](https://www.zaproxy.org/)). This 

It constitutes a "man-in-the-middle proxy." Our team is currently using a feature of the ZAP ecosystem, specifically the API scan for the DQT API application, as it allows automated scanning of our API endpoints.

By default, the script we adopt:

1. Imports the API definition supplied

2. Actively scans the API using a custom scan profile tuned for APIs

3. Reports any issues found to the command line

This process is part of CI/CD, and it requires that no issues are reported to proceed to a release to production. 



 