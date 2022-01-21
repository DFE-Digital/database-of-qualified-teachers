# DevOps & Release Management

This section outlines the deployment mechanisms for the TRA services.

**Note**: the EAPIM API is managed and maintained by the Solutions Delivery Team who have their own deployment process.

## TRA deployment process

Systems and services managed by the TRA System Development team will handle deployments as follows:

* GitHub branches (Push) deployed to DEV environment
    * Tests (unit tests, component tests, regression tests, coverage and code security scan) are completed

    * CVE scan and OWASP are completed

* GitHub pull requests are deployed to a temporary TEST environment 

    * Browser automation full stack tests are completed

    * Product owner approval, if needed

* GitHub main branch (merge from branch) deployed to the PREPROD environment 

    * Cypress/Selenium browser tests run

    * Once approved following peer review, the code is deployed to PROD

## Access management

TRA developers alone have access to application code via GitHub, with separation between the DEV and PROD environments.

Digital Tools Support are responsible for providing appropriate levels of access and revoking when the developers are off-boarded.
