# DevOps & Release Management

This section outlines the deployment mechanisms for the TRA services.


## TRA deployment process (Teacher Self Serve, Employer Portals, ITT Providers and Teachers outside England and Wales)

* GitHub branches (Push) deployed to DEV environment
    * Tests (unit tests, component tests, regression tests, coverage and code security scan) are completed

    * CVE scan and OWASP are completed

* GitHub pull requests are deployed to a temporary TEST environment 

    * Browser automation full stack tests are completed

    * Product owner approval, if needed

* GitHub main branch (merge from branch) deployed to the PREPROD environment 

    * Cypress/Selenium browser tests run

    * Once approved following peer review, the code is deployed to PROD

[Find a lost TRN](https://teacher-services-tech-docs.london.cloudapps.digital/#find-a-lost-trn)
[Qualified Teachers API](https://teacher-services-tech-docs.london.cloudapps.digital/#qualified-teachers-api)

## Access management

TRA developers alone have access to application code via GitHub, with separation between the DEV and PROD environments.


