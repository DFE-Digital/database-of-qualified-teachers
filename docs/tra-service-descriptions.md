# TRA Service Descriptions

The Teaching Regulation Agency (TRA) is an arms-length body of the DfE that:

* Confirms [Qualified Teacher Status (QTS)](https://www.gov.uk/government/collections/qualified-teacher-status-qts) to appropriately qualified English and international teachers

* Provides an [employment checking service](https://www.gov.uk/guidance/teacher-status-checks-information-for-employers) to support employers of teachers to fulfil their statutory and safeguarding responsibilities

* Operates the [regulatory system for teacher misconduct](https://www.gov.uk/government/collections/teacher-misconduct) on behalf of the Secretary of State.

To deliver some of these responsibilities, the TRA manages a number of systems and services. These are maintained by the Teacher Qualification Unit within the TRA. The unit is primarily responsible for creating and maintaining the teacher records, awarding QTS and providing information from the database to authorised individuals and organisations. The unit will make around 36,000 QTS awards and record 30,000 induction passes annually.

The services and systems include:

* The Database of Qualified Teachers (DQT). The Database of Qualified Teachers is built on MS Dynamics 365. There are a number of data feeds and web-based portals that allow stakeholders to upload qualified teacher related data. Schools can access the DB and check the status of teachers, whilst teachers themselves can access their data and update it.

* The [TRA web portals](https://teacherservices.education.gov.uk/) are built using .Net and consist of six user interfaces that are accessed externally by teachers and schools/employers and training providers to view and/or provide details of teachers, their qualifications and eligibility.

* SFTP and SSIS systems. Together the SFTP and SSIS server allow data files to be received from different services (Capita, DMS, GIAS, GTC Wales, NPQ). Data is then extracted, transformed, and stored within staging tables before being loaded into the CRM at scheduled times.

* TRA Reporting service. The data export service provides TRA with reporting capabilities by replicating data from the Dynamics 365 CRM into a separate SQL Database. The system synchronises the entire data for selected entities and keeps them synched continuously as changes occur in the system.

* EAPIM API. This API was developed to meet the needs of the Claim and CPD digital teams. It was developed by the Solutions Delivery Team (SDT) and is managed by them. The EAPIM API is not extensible and so a more strategic and flexible API is being developed to meet a wider set of user needs.

* TRA API - this v3 API is currently being developed by the TRA Systems Development team to better meet the existing data needs of the CPD and Claim digital services, but without being developed within the EAPIM framework. It is being hosted in GOV.UK PaaS. A more strategic v4 API will quickly be developed to meet the data needs of the wider digital services.
