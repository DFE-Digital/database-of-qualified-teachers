# 001 - Build a new Qualified Teacher API

**Date: 25-10-2021**

## Status
**Accepted**

## Context
### Teaching Regulation Agency
The Teaching Regulation Agency is currently undergoing a digital transformation, and a Discovery into the TRA has revealed inefficiencies in how the TRA and its systems interact with other services. These inefficiencies have arisen from multiple conversations with other services teams and stakeholders with Teacher Services.

Additionally, the current digital services landscape of Teacher Services and Teaching Regulation Agency is constantly changing. The department is re-imagining what education services look like from the teacher perspective. New and old services and their respective software systems are being created or being changed. 

A few examples are the new Register Trainee Teacher, Teacher Identity and Continuous Professional Development Services.

Functions provided by services are now duplicated in other TRA services and other newer digital services available to users across the department. Service definitions are unclear or have been subject to scope creep since launch. 

## The technical aspect
The lack of a well-defined service definition has leaked into technical choices adopted by the last delivery teams. An example is the current DQT API Façade which exposes teacher data to two external services (Claim and CPD).

The API is served via the Enterprise API Management (EAPIM) interface hosted within the Cloud Infrastructure Platform and managed by an external team outside TRA. The EAPIM platform forwards requests to the DQT CRM OData interface. 

The API was built to support business processes without understanding our services users and their needs and especially without considering such needs in the context of the end to end service. 

It does not meet the DfE Technical Guidance manual and the broader Gov UK technology code of practice:

1. It's not scalable to maintain service level objectives. It was built for a specific business process.
1. It's not reusable by other services for the same reason.
1. Data fields have not been defined with user needs in mind, especially around TRNs and QTSs.
1. It does not use Docker to isolate and package up the application from infrastructure and environmental concerns.


We want an API that meets Service level objectives, well-defined service definition, and aligns with DfE and Government technical standards.

## Decision
We will build a new API application to replace the current one. We will not be continuing the integration with EAPIM as it adds too much overhead for too little benefit and compromises user experience and flexibility.

We will implement authentication and authorisation for our users as well as point them to our documentation.

## Consequences
Our users and the engineering team won't have to manage two different tokens for authentication (one for EAPIM gateway and one for the backend).
Our Service Team will be directly responsible for granting access to the API as opposed to delegating that responsibility to an external team that doesn't understand who is a valid user or not.


Given DQT is classified by InfoSec as a gold service, we might have to explain the reason behind our choices in some governance processes.
