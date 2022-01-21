# List of technical challenges (which could be tackled following the TRA discovery)

The following challenges have been identified as part of the ongoing TRA discovery and should be considered constraints and opportunities for future development. 
 
## DfE Sign In integration
DfE Sign-In should only be responsible for access management to the DQT portal. Currently it’s handling authentication and also syncing organisational data in the CRM database acting as an authoritative source of truth for that data set. The data sync is built using a legacy integration which adopts legacy_id as unique identifiers which tights together the two services creating an unnecessary dependency on DfE Sign-In. This issue became evident following the last security incident that caused the DQT service to be turned offline.

## Teacher EAPIM API 
It is not strategic choice for the service. The code and the management of the API is outside the boundaries of the service team making it hard to change and refine causing it to be inflexible. Whilst it might be currently be meeting the needs of Claim and CPD services, it is not fit for purpose to meet other emerging needs (such as TRN look up). 
We should develop a flexible, strategic API following established patterns which will meet the emerging needs of other teams and partners.  We want to move to a service that has full responsibility of developing and running our applications and tools. 

## Security posture
The DQT is considered by DfE InfoSec as a “Gold” which sets an unnecessary and disproportionate allocation of assurance burdens slowing delivery and generally making it hard to work with. The service is hosted on the legacy Azure tenants (Tier 1). 

## Tighten security around Teacher Self Serve authentication 
The teacher self serve portal allows access to teacher data simply using first name, last name, dob and TRNs which is clear contrast with the security posture of the application.

## Migrate out of Tier 1 DfE subscription Azure infrastructure
Azure Tier 1 is considered a legacy infrastructure and DfE  infrastructure team encourages to adopt Azure CIP or Gov PaaS when building new applications. 
We want to move an operative model where we can release to production multiple times a day and be responsible and owners of our own tools. 
Tier 1 is currently configured (network and environments) in a way that makes operating the service in such model complicated and inefficient, as the team would have to go through numerous and unnecessary  governance and assurance hoops to release change to productions.
This is even more relevant, given we might carve out of DQT some business functions and create new smaller and more manageable applications which would need integrations.

## CRM and Data schema
The CRM data scheme is highly denormalised and tight to the CRM implementation. This makes incredible inflexible and hard to change. DQT heavily uses core entities of Dynamics 365 CRM (Account, Contact) which have become bloated with numerous custom fields attached to them. 
Other than usual issues with vendor lock-in and not being aligned to what the department is doing it is also not clear what’s the technical reason for adopting a CRM as a solution for the current service delivery.

The service needs a review of its adherence to the technology code of practice:
[The technology code of practice 
](https://www.gov.uk/guidance/the-technology-code-of-practice)
and also the GDS service standard
[Service Standard - Service Manual - GOV.UK ](https://www.gov.uk/service-manual/service-standard)

## Reporting 
Teacher services is detached from what the department is doing: Big Query.

## Manual operations 
Manual insert of data is fiddly and introduces risk of errors and file exchange via sFTP requires significant manual effort

## File exchange integrations are brittle and hard to track. 

Having six different web portals in one component might be tricky to handle (deployment, monitoring)

## Configuration is strongly-tied to XML config files
The configuration APIs in the version of .NET used by the portals is coupled to XML config files; there’s no built-in way to get configuration from other sources e.g. environment variables. The application also has no abstraction around configuration so there’s no easy way to remove development-time secrets from the config files, meaning the repository cannot be made public.
