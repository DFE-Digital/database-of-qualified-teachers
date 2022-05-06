# Technical Architecture Road Map
All technical architecture changes are fundamentally driven by user needs. We take a user centred design approach. Many of the current services require transformation to meet current service needs and GDS digital standards. While we can't let technology alone drive change we have identified a number of strategic milestones we are aiming to deliver in the next 2 years.

## Planned work in 2022
## Implement Continuous Integration
1. All code under source control and made public in [DfE Repos](https://github.com/orgs/DFE-Digital/teams/tra-digital/repositories) Done Jan 2022

## Implement Dev Ops
1. Create deployment pipelines for all of the DQT technical architecture. Ongoing
2. Implement better monitoring and hook into digital tools channels. E.g. [Paas Monitoring](https://github.com/DFE-Digital/tra-paas-monitoring). Ongoing

## Improving data integration by reducing file based DQT data integration and replacing with API based integration
1. Build new [Teacher Qualifications API](https://github.com/DFE-Digital/qualified-teachers-api). Done Live Feb 2022
2. [Register Trainee Teachers](https://www.register-trainee-teachers.education.gov.uk/), [Continuing Professional Development](https://manage-training-for-early-career-teachers.education.gov.uk/) and Claim Additional Teacher Payments integrated via qualified teacher data from new endpoints. Done Live March 2022
3. Build new "TRN less" integration with [Continuing Professional Development](https://manage-training-for-early-career-teachers.education.gov.uk/). This is the first delivery that starts to improve the way in which DfE digital services integrate teacher records, so that we can:
    Help Teachers by reducing the amount of times we ask them for thier information.
    Better inform policy by more accurately identifying Teachers, Trainees and Applicants across the DfE Teacher Service Line.

## Building new services to address user needs

1. Build new [Find a lost TRN Service](). To help users find their Teacher Reference Number quickly and digitally. Done Live May 2022
2. Build new Professional Recognition digital service. This will replace the existing .Net view "portal" with a fully accessible public [digital service](https://docs.google.com/drawings/d/1S-YDJgEdGv-53tEEfNN9_ivghyPxuDtfrojbK866ns8/edit?skip_itp2_check=true&pli=1) 

## Overall themes

1. Automate as much as possible through CI and CD pipelines.
2. Reduce manual intervention in data integrations by removing file / manual based with API's.
3. Monitor performance, security / access, errors and publish into actively managed channels.
4. Re-factor existing brittle code by strangulation.
5. Open source everything (except secrets etc.)
6. Simplify the technical architecure and reduce legacy technology footprint.
7. Stop collecting unessessary data.
8. Make our data more useable by removing duplications, streamlining data sets and better sharing with related DfE services.

